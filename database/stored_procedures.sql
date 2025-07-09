

-- ==========================================
-- Stored Procedures
-- ==========================================

-- Stored Procedure: Get Disease Alert
DELIMITER //
CREATE PROCEDURE GetDiseaseAlert(
    IN p_crop_type VARCHAR(100),
    IN p_temperature DECIMAL(5,2),
    IN p_humidity DECIMAL(5,2),
    IN p_rainfall DECIMAL(8,2)
)
BEGIN
    SELECT DISTINCT 
        d.Name as DiseaseName,
        d.Symptoms,
        d.SeverityLevel,
        d.Treatment,
        dw.RiskLevel
    FROM Disease d
    JOIN Crop_Disease cd ON d.DiseaseID = cd.DiseaseID
    JOIN Crop c ON cd.CropID = c.CropID
    JOIN Disease_Weather dw ON d.DiseaseID = dw.DiseaseID
    WHERE c.Type = p_crop_type
    AND (dw.MinTemperature IS NULL OR p_temperature >= dw.MinTemperature)
    AND (dw.MaxTemperature IS NULL OR p_temperature <= dw.MaxTemperature)
    AND (dw.MinHumidity IS NULL OR p_humidity >= dw.MinHumidity)
    AND (dw.MaxHumidity IS NULL OR p_humidity <= dw.MaxHumidity)
    AND (dw.MinRainfall IS NULL OR p_rainfall >= dw.MinRainfall)
    AND (dw.MaxRainfall IS NULL OR p_rainfall <= dw.MaxRainfall)
    ORDER BY dw.RiskLevel DESC, d.SeverityLevel DESC;
END //
DELIMITER ;

-- Stored Procedure: Recommend Pesticide
DELIMITER //
CREATE PROCEDURE RecommendPesticide(
    IN p_disease_name VARCHAR(100)
)
BEGIN
    SELECT 
        p.Name as PesticideName,
        p.Type,
        dp.RecommendedDosage,
        dp.ApplicationMethod,
        dp.Effectiveness,
        p.ApprovedCrops
    FROM Pesticide p
    JOIN Disease_Pesticide dp ON p.PesticideID = dp.PesticideID
    JOIN Disease d ON dp.DiseaseID = d.DiseaseID
    WHERE d.Name = p_disease_name
    ORDER BY dp.Effectiveness DESC;
END //
DELIMITER ;

-- Stored Procedure: Basic Yield Estimation (NOT predictive modeling)
DELIMITER //
CREATE PROCEDURE EstimateYield(
    IN p_crop_type VARCHAR(100),
    IN p_temperature DECIMAL(5,2),
    IN p_humidity DECIMAL(5,2),
    IN p_rainfall DECIMAL(8,2)
)
BEGIN
    DECLARE avg_yield DECIMAL(10,2);
    DECLARE yield_factor DECIMAL(5,2) DEFAULT 1.0;
    
    -- Get average yield for crop type
    SELECT AverageYield INTO avg_yield
    FROM Crop 
    WHERE Type = p_crop_type
    LIMIT 1;
    
    -- Simple conditional adjustments (NOT machine learning prediction)
    IF p_temperature < 15 OR p_temperature > 35 THEN
        SET yield_factor = yield_factor * 0.8;
    END IF;
    
    IF p_humidity < 40 OR p_humidity > 90 THEN
        SET yield_factor = yield_factor * 0.85;
    END IF;
    
    IF p_rainfall < 50 OR p_rainfall > 300 THEN
        SET yield_factor = yield_factor * 0.9;
    END IF;
    
    -- Return basic estimation (not prediction)
    SELECT 
        p_crop_type as CropType,
        avg_yield as BaseYield,
        yield_factor as YieldFactor,
        ROUND(avg_yield * yield_factor, 2) as EstimatedYield,
        CASE 
            WHEN yield_factor >= 1.0 THEN 'Excellent'
            WHEN yield_factor >= 0.9 THEN 'Good'
            WHEN yield_factor >= 0.8 THEN 'Fair'
            ELSE 'Poor'
        END as YieldOutlook,
        'Basic estimation using simple conditional logic' as Note;
END //
DELIMITER ;

-- ==========================================
-- Views for Common Queries
-- ==========================================

-- View: Current Crop Health Status
CREATE VIEW CropHealthStatus AS
SELECT 
    c.CropID,
    c.Type as CropType,
    c.PlantingDate,
    c.DiseaseResistanceLevel,
    COUNT(cd.DiseaseID) as ActiveDiseases,
    GROUP_CONCAT(d.Name SEPARATOR ', ') as DiseaseNames
FROM Crop c
LEFT JOIN Crop_Disease cd ON c.CropID = cd.CropID AND cd.Status = 'Active'
LEFT JOIN Disease d ON cd.DiseaseID = d.DiseaseID
GROUP BY c.CropID, c.Type, c.PlantingDate, c.DiseaseResistanceLevel;

-- View: Irrigation Summary
CREATE VIEW IrrigationSummary AS
SELECT 
    c.Type as CropType,
    i.WaterRequirement,
    i.WaterFrequency,
    i.LastWateredDate,
    DATEDIFF(CURDATE(), i.LastWateredDate) as DaysSinceWatering,
    cy.YieldAmount as LastYield
FROM Crop c
JOIN IrrigationSchedule i ON c.CropID = i.CropID
LEFT JOIN CropYield cy ON i.ScheduleID = cy.IrrigationScheduleID
ORDER BY DaysSinceWatering DESC;

-- View: Pesticide Usage Report
CREATE VIEW PesticideUsageReport AS
SELECT 
    p.Name as PesticideName,
    p.Type as PesticideType,
    COUNT(pa.ApplicationID) as ApplicationCount,
    AVG(CASE pa.Effectiveness 
        WHEN 'High' THEN 3 
        WHEN 'Medium' THEN 2 
        WHEN 'Low' THEN 1 
    END) as AvgEffectiveness
FROM Pesticide p
LEFT JOIN Pesticide_Application pa ON p.PesticideID = pa.PesticideID
GROUP BY p.PesticideID, p.Name, p.Type
ORDER BY ApplicationCount DESC;