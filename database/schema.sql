-- ==========================================
-- Crop Disease Management System Database
-- ==========================================
-- Authors: Dinesh Kumar Raju Kattunga & Puneeth Kumar Amudala
-- Created: 2024
-- Description: Database schema for managing crop diseases, pesticides, 
--              irrigation schedules, and yield data collection.


-- Create database
CREATE DATABASE IF NOT EXISTS CropDiseaseManagementSystem;
USE CropDiseaseManagementSystem;

-- ==========================================
-- Table: Crop
-- ==========================================
CREATE TABLE Crop (
    CropID INT PRIMARY KEY AUTO_INCREMENT,
    Type VARCHAR(100) NOT NULL,
    PlantingDate DATE NOT NULL,
    DiseaseResistanceLevel ENUM('High', 'Medium', 'Low') NOT NULL,
    AverageYield DECIMAL(10, 2) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ==========================================
-- Table: Disease
-- ==========================================
CREATE TABLE Disease (
    DiseaseID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Symptoms TEXT NOT NULL,
    SeverityLevel ENUM('High', 'Medium', 'Low') NOT NULL,
    Treatment TEXT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ==========================================
-- Table: Pesticide
-- ==========================================
CREATE TABLE Pesticide (
    PesticideID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Type ENUM('Fungicide', 'Herbicide', 'Insecticide', 'Bactericide') NOT NULL,
    RecommendedDosage VARCHAR(100) NOT NULL,
    ApprovedCrops TEXT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ==========================================
-- Table: WeatherConditions
-- ==========================================
CREATE TABLE WeatherConditions (
    WeatherID INT PRIMARY KEY AUTO_INCREMENT,
    Date DATE NOT NULL,
    Temperature DECIMAL(5, 2) NOT NULL,
    Rainfall DECIMAL(8, 2) NOT NULL,
    Humidity DECIMAL(5, 2) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_date (Date)
);

-- ==========================================
-- Table: IrrigationSchedule
-- ==========================================
CREATE TABLE IrrigationSchedule (
    ScheduleID INT PRIMARY KEY AUTO_INCREMENT,
    CropID INT NOT NULL,
    LastWateredDate DATE NOT NULL,
    WaterRequirement DECIMAL(10, 2) NOT NULL,
    WaterFrequency ENUM('Daily', 'Weekly', 'Bi-weekly', 'Monthly') NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (CropID) REFERENCES Crop(CropID) ON DELETE CASCADE
);

-- ==========================================
-- Table: CropYield
-- ==========================================
CREATE TABLE CropYield (
    YieldID INT PRIMARY KEY AUTO_INCREMENT,
    YieldAmount DECIMAL(10, 2) NOT NULL,
    IrrigationScheduleID INT NOT NULL,
    Date DATE NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (IrrigationScheduleID) REFERENCES IrrigationSchedule(ScheduleID) ON DELETE CASCADE
);

-- ==========================================
-- Junction Table: Crop_Disease (Many-to-Many)
-- ==========================================
CREATE TABLE Crop_Disease (
    CropID INT NOT NULL,
    DiseaseID INT NOT NULL,
    DetectedDate DATE NOT NULL,
    SeverityLevel ENUM('High', 'Medium', 'Low') NOT NULL,
    Status ENUM('Active', 'Treated', 'Recovered') DEFAULT 'Active',
    PRIMARY KEY (CropID, DiseaseID),
    FOREIGN KEY (CropID) REFERENCES Crop(CropID) ON DELETE CASCADE,
    FOREIGN KEY (DiseaseID) REFERENCES Disease(DiseaseID) ON DELETE CASCADE
);

-- ==========================================
-- Junction Table: Disease_Pesticide (Many-to-Many)
-- ==========================================
CREATE TABLE Disease_Pesticide (
    DiseaseID INT NOT NULL,
    PesticideID INT NOT NULL,
    Effectiveness ENUM('High', 'Medium', 'Low') NOT NULL,
    RecommendedDosage VARCHAR(100) NOT NULL,
    ApplicationMethod VARCHAR(200),
    PRIMARY KEY (DiseaseID, PesticideID),
    FOREIGN KEY (DiseaseID) REFERENCES Disease(DiseaseID) ON DELETE CASCADE,
    FOREIGN KEY (PesticideID) REFERENCES Pesticide(PesticideID) ON DELETE CASCADE
);

-- ==========================================
-- Junction Table: Disease_Weather (Many-to-Many)
-- ==========================================
CREATE TABLE Disease_Weather (
    DiseaseID INT NOT NULL,
    WeatherID INT NOT NULL,
    MinTemperature DECIMAL(5, 2),
    MaxTemperature DECIMAL(5, 2),
    MinHumidity DECIMAL(5, 2),
    MaxHumidity DECIMAL(5, 2),
    MinRainfall DECIMAL(8, 2),
    MaxRainfall DECIMAL(8, 2),
    RiskLevel ENUM('High', 'Medium', 'Low') NOT NULL,
    PRIMARY KEY (DiseaseID, WeatherID),
    FOREIGN KEY (DiseaseID) REFERENCES Disease(DiseaseID) ON DELETE CASCADE,
    FOREIGN KEY (WeatherID) REFERENCES WeatherConditions(WeatherID) ON DELETE CASCADE
);

-- ==========================================
-- Junction Table: Pesticide_YieldInfo (One-to-Many relationship tracking)
-- ==========================================
CREATE TABLE Pesticide_Application (
    ApplicationID INT PRIMARY KEY AUTO_INCREMENT,
    YieldID INT NOT NULL,
    PesticideID INT NOT NULL,
    ApplicationDate DATE NOT NULL,
    DosageUsed VARCHAR(100) NOT NULL,
    ApplicationMethod VARCHAR(200),
    Effectiveness ENUM('High', 'Medium', 'Low'),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (YieldID) REFERENCES CropYield(YieldID) ON DELETE CASCADE,
    FOREIGN KEY (PesticideID) REFERENCES Pesticide(PesticideID) ON DELETE CASCADE
);

-- ==========================================
-- Indexes for Performance Optimization
-- ==========================================
CREATE INDEX idx_crop_type ON Crop(Type);
CREATE INDEX idx_disease_name ON Disease(Name);
CREATE INDEX idx_pesticide_type ON Pesticide(Type);
CREATE INDEX idx_weather_date ON WeatherConditions(Date);
CREATE INDEX idx_weather_temp ON WeatherConditions(Temperature);
CREATE INDEX idx_weather_humidity ON WeatherConditions(Humidity);
CREATE INDEX idx_weather_rainfall ON WeatherConditions(Rainfall);
CREATE INDEX idx_irrigation_crop ON IrrigationSchedule(CropID);
CREATE INDEX idx_yield_date ON CropYield(Date);
CREATE INDEX idx_crop_disease_date ON Crop_Disease(DetectedDate);
CREATE INDEX idx_pesticide_app_date ON Pesticide_Application(ApplicationDate);


-- Grant necessary permissions (adjust as needed)
-- GRANT SELECT, INSERT, UPDATE, DELETE ON CropDiseaseManagementSystem.* TO 'crop_user'@'localhost';
-- FLUSH PRIVILEGES;

-- ==========================================
-- End of Schema
-- ==========================================