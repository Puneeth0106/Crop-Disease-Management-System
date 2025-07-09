
-- ==========================================
-- Sample Data Insertion
-- ==========================================

-- Insert sample crops
INSERT INTO Crop (Type, PlantingDate, DiseaseResistanceLevel, AverageYield) VALUES
('Wheat', '2024-03-15', 'High', 2500.00),
('Rice', '2024-04-01', 'Medium', 3200.00),
('Corn', '2024-05-10', 'Low', 4800.00),
('Barley', '2024-03-20', 'Medium', 2000.00),
('Soybeans', '2024-05-15', 'High', 1800.00);

-- Insert sample diseases
INSERT INTO Disease (Name, Symptoms, SeverityLevel, Treatment) VALUES
('Wheat Blight', 'Brown spots on leaves, yellowing, wilting', 'High', 'Apply fungicide, improve ventilation'),
('Rice Blast', 'Diamond-shaped lesions, leaf death', 'High', 'Resistant varieties, fungicide treatment'),
('Corn Smut', 'Grayish-white galls, distorted kernels', 'Medium', 'Remove infected plants, crop rotation'),
('Powdery Mildew', 'White powdery coating on leaves', 'Medium', 'Fungicide spray, reduce humidity'),
('Root Rot', 'Yellowing, stunted growth, root decay', 'High', 'Improve drainage, fungicide treatment');

-- Insert sample pesticides
INSERT INTO Pesticide (Name, Type, RecommendedDosage, ApprovedCrops) VALUES
('BlightShield', 'Fungicide', '2ml per liter', 'Wheat, Barley, Corn'),
('SpotRemedy', 'Fungicide', '1.5ml per liter', 'Rice, Wheat'),
('CornGuard', 'Fungicide', '3ml per liter', 'Corn, Soybeans'),
('MildewStop', 'Fungicide', '2.5ml per liter', 'All crops'),
('RootProtect', 'Fungicide', '4ml per liter', 'All crops');

-- Insert sample weather conditions
INSERT INTO WeatherConditions (Date, Temperature, Rainfall, Humidity) VALUES
('2024-06-01', 25.5, 10.2, 65.0),
('2024-06-02', 28.0, 0.0, 58.5),
('2024-06-03', 22.5, 25.8, 78.0),
('2024-06-04', 26.8, 5.5, 62.0),
('2024-06-05', 30.2, 0.0, 55.5);

-- Insert sample irrigation schedules
INSERT INTO IrrigationSchedule (CropID, LastWateredDate, WaterRequirement, WaterFrequency) VALUES
(1, '2024-06-01', 150.00, 'Weekly'),
(2, '2024-06-02', 200.00, 'Daily'),
(3, '2024-06-01', 180.00, 'Bi-weekly'),
(4, '2024-06-03', 120.00, 'Weekly'),
(5, '2024-06-02', 140.00, 'Weekly');

-- Insert sample yield records
INSERT INTO CropYield (YieldAmount, IrrigationScheduleID, Date) VALUES
(2400.00, 1, '2024-07-15'),
(3150.00, 2, '2024-08-20'),
(4750.00, 3, '2024-09-10'),
(1950.00, 4, '2024-07-25'),
(1780.00, 5, '2024-08-30');

-- Insert sample crop-disease relationships
INSERT INTO Crop_Disease (CropID, DiseaseID, DetectedDate, SeverityLevel, Status) VALUES
(1, 1, '2024-06-15', 'Medium', 'Active'),
(2, 2, '2024-06-20', 'High', 'Treated'),
(3, 3, '2024-06-25', 'Low', 'Recovered'),
(1, 4, '2024-07-01', 'Medium', 'Active'),
(5, 5, '2024-07-05', 'High', 'Treated');

-- Insert sample disease-pesticide relationships
INSERT INTO Disease_Pesticide (DiseaseID, PesticideID, Effectiveness, RecommendedDosage, ApplicationMethod) VALUES
(1, 1, 'High', '2ml per liter', 'Foliar spray'),
(2, 2, 'High', '1.5ml per liter', 'Foliar spray'),
(3, 3, 'Medium', '3ml per liter', 'Soil application'),
(4, 4, 'High', '2.5ml per liter', 'Foliar spray'),
(5, 5, 'High', '4ml per liter', 'Soil drench');

-- Insert sample pesticide applications
INSERT INTO Pesticide_Application (YieldID, PesticideID, ApplicationDate, DosageUsed, ApplicationMethod, Effectiveness) VALUES
(1, 1, '2024-06-16', '2ml per liter', 'Foliar spray', 'High'),
(2, 2, '2024-06-21', '1.5ml per liter', 'Foliar spray', 'High'),
(3, 3, '2024-06-26', '3ml per liter', 'Soil application', 'Medium'),
(1, 4, '2024-07-02', '2.5ml per liter', 'Foliar spray', 'High'),
(5, 5, '2024-07-06', '4ml per liter', 'Soil drench', 'High');