# Crop Disease Management System

A comprehensive database-driven system for managing crop diseases, pesticides, irrigation schedules, and yield predictions to help farmers optimize their agricultural practices.

## 📋 Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Database Schema](#database-schema)
- [Installation](#installation)
- [Usage](#usage)
- [Stored Procedures](#stored-procedures)
- [Contributors](#contributors)
- [License](#license)

## 🎯 Project Scope

**Important Note**: This project focuses on database design and management system architecture. The system provides:

- **Database Schema**: Comprehensive relational database design for agricultural data management
- **Data Storage**: Structured storage for crops, diseases, pesticides, irrigation, weather, and yield data
- **Query System**: Stored procedures for data retrieval and basic analysis
- **Framework**: Foundation for future implementation of predictive analytics and machine learning models

**What this project does NOT include**:
- Machine learning algorithms for disease prediction
- Real-time sensor data integration
- Advanced predictive analytics
- Trained models with actual agricultural data

The stored procedures provide basic conditional logic and data retrieval, not predictive modeling. This system serves as a foundation that can be extended with actual predictive capabilities in future development phases.

### Key Problems Solved
- **Disease Outbreaks**: Predict and manage disease outbreaks that cause significant yield losses globally
- **Real-time Insights**: Provide farmers with timely information about crop health and weather impacts
- **Pesticide Optimization**: Reduce inefficient pesticide use to minimize environmental and economic issues
- **Yield Optimization**: Support farmers in maximizing yield while reducing waste

## ✨ Features

### 1. Crop Management
- Store comprehensive crop information including type, planting date, disease resistance levels, and average yield
- View and update crop details with ease
- Track multiple crop varieties and their specific requirements

### 2. Disease Monitoring
- Comprehensive disease database with symptoms, severity levels, and treatments
- Disease prediction based on weather conditions and crop data
- Real-time disease alerts and recommendations

### 3. Irrigation Scheduling
- Automated irrigation schedules based on crop water requirements
- Weather-integrated irrigation planning
- Water usage optimization for higher yields

### 4. Pesticide Management
- Complete pesticide database with types, dosages, and approved crops
- Disease-specific pesticide recommendations
- Track pesticide applications and effectiveness

### 5. Weather Integration
- Real-time weather data integration
- Weather-based disease outbreak predictions
- Optimal farming condition insights

### 6. Yield Data Management
- Historical yield data storage and retrieval
- Database structure designed to support future predictive modeling
- Data collection framework for performance tracking

## 🗄️ Database Schema

### Entity Sets

#### Crop
- **CropID** (Primary Key): Unique identifier
- **Type**: Crop type (e.g., Wheat, Rice)
- **PlantingDate**: Date when crop was planted
- **DiseaseResistanceLevel**: Disease resistance (High, Medium, Low)
- **AverageYield**: Expected average yield per crop

#### Disease
- **DiseaseID** (Primary Key): Unique identifier
- **Name**: Disease name (e.g., Blight, Powdery Mildew)
- **Symptoms**: Disease symptoms description
- **SeverityLevel**: Disease severity (High, Medium, Low)
- **Treatment**: Recommended treatment

#### Pesticide
- **PesticideID** (Primary Key): Unique identifier
- **Name**: Pesticide name (e.g., BlightShield, SpotRemedy)
- **Type**: Pesticide type (Fungicide, Herbicide)
- **RecommendedDosage**: Recommended usage dosage
- **ApprovedCrops**: List of approved crops

#### IrrigationSchedule
- **ScheduleID** (Primary Key): Unique identifier
- **CropID** (Foreign Key): Associated crop
- **LastWateredDate**: Last watering date
- **WaterRequirement**: Required water amount
- **WaterFrequency**: Irrigation frequency

#### WeatherConditions
- **WeatherID** (Primary Key): Unique identifier
- **Date**: Weather data date
- **Temperature**: Temperature reading
- **Rainfall**: Rainfall amount
- **Humidity**: Humidity level

#### CropYield
- **YieldID** (Primary Key): Unique identifier
- **YieldAmount**: Yield quantity produced
- **IrrigationScheduleID** (Foreign Key): Associated irrigation schedule
- **Date**: Yield measurement date

### Relationships
- **Crop-Disease**: One-to-Many (A crop can have multiple diseases)
- **Disease-Pesticide**: Many-to-Many (Diseases can be treated by multiple pesticides)
- **Crop-IrrigationSchedule**: One-to-One (Each crop has one irrigation schedule)
- **Disease-Weather**: Many-to-Many (Weather conditions influence multiple diseases)
- **Pesticide-YieldInfo**: One-to-Many (Pesticides impact yield)
- **Irrigation-YieldInfo**: One-to-Many (Irrigation schedules affect yield)

## 🚀 Installation

### Prerequisites
- MySQL Server (version 8.0 or higher)
- MySQL Workbench (optional, for GUI management)

### Database Setup
1. Clone the repository:
```bash
git clone https://github.com/Puneeth0106/crop-disease-management-system.git
cd crop-disease-management-system
```

2. Import the database schema:
```bash
mysql -u root -p < database/schema.sql
```

3. Insert sample data (optional):
```bash
mysql -u root -p < database/sample_data.sql
```

## 📊 Usage

### Basic Operations

#### Adding a New Crop
```sql
INSERT INTO Crop (Type, PlantingDate, DiseaseResistanceLevel, AverageYield)
VALUES ('Wheat', '2024-03-15', 'High', 2500);
```

#### Checking Disease Alerts
```sql
CALL GetDiseaseAlert('Wheat', 25, 80, 150);
```

#### Getting Pesticide Recommendations
```sql
CALL RecommendPesticide('Blight');
```

## 🔧 Stored Procedures

### 1. Disease Alert System
**Procedure**: `GetDiseaseAlert`
- **Parameters**: Crop type, Temperature, Humidity, Rainfall
- **Returns**: Diseases that match current weather conditions (basic conditional logic)
- **Note**: Uses simple threshold-based matching, not predictive modeling

### 2. Yield Estimation
**Procedure**: `PredictYield`
- **Parameters**: Crop type, Temperature, Humidity, Rainfall
- **Returns**: Basic yield estimation using simple multiplication factors
- **Note**: Uses basic conditional logic, not machine learning prediction

### 3. Pesticide Recommendation
**Procedure**: `RecommendPesticide`
- **Parameters**: Disease type
- **Returns**: Recommended pesticides based on disease-pesticide relationships
- **Note**: Database lookup, not intelligent recommendation system

## 📁 Repository Structure

```
crop-disease-management-system/
├── README.md
├── LICENSE
├── database/
│   ├── schema.sql
│   ├── sample_data.sql
│   └── stored_procedures.sql
├── documentation/
│   ├── ER_Diagram.png
│   ├── presentation.pdf
│   └── design_document.md
└── images/
    └── er_diagram.png
```

## 🤝 Contributors

- **Dinesh Kumar Raju Kattunga** - Database Design & Implementation
- **Puneeth Kumar Amudala** - System Architecture & Documentation

## 📈 Database Normalization

The database follows normalization principles:
- **1NF**: Each table has unique rows with atomic values
- **2NF**: All non-key attributes are fully dependent on primary keys
- **3NF**: No transitive dependencies exist

## 🔮 Future Enhancements

- **Machine learning integration**: Implement actual predictive models for disease and yield prediction
- **Real data collection**: Integration with agricultural databases and research institutions
- **IoT sensor integration**: Real-time monitoring capabilities
- **Mobile application**: User-friendly interface for farmers
- **API development**: RESTful APIs for third-party integrations
- **Advanced analytics**: Statistical analysis and trend prediction
- **Multi-language support**: Localization for different regions


---
