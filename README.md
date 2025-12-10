# Global Weather Analytics Using SQL

## Overview
This project performs **in-depth data exploration and analytics using SQL** on a large-scale global weather dataset.

The dataset contains detailed climate parameters for major countries including:
- Temperature
- Humidity
- UV index
- Air quality levels
- Wind speed
- Cloud cover
- Atmospheric pollution (PM2.5)

All analytics are conducted **only with SQL**, proving real-world data handling and analytical query skills.

---

## Dataset Used
Dataset: **Global Weather Repository**  
Source: Kaggle  
Link: https://www.kaggle.com/datasets/henryshan/globalweatherrepository

Dataset contains:
- 450+ global locations
- 40+ weather indicators per location
- Multi-environmental attributes

---

## Technologies Used
| Component | Usage |
|----------|-------|
SQL (MySQL) | Data storage + analytics
DDL | Schema creation
DML | Data access/manipulation
Aggregation & Grouping | Statistical summaries
CASE Expressions | Risk segmentation
Ranking | Top N polluted/cleanest location detection

---

## Database Architecture

### Database:
`WeatherAnalytics`

### Table:
`weather_data`

### Table Fields Include:
- Geolocation (`country`, `location_name`, `latitude`, `longitude`)
- Weather (`temperature_celsius`, `humidity`, `wind_kph`)
- Pollution (`air_quality_PM2_5`, `PM10`, `Ozone`, `CO`)
- UV exposure (`uv_index`)
- Environmental conditions (`visibility`, `cloud`)
- Sunrise, sunset, moon phase

Schema file: **Global air quality analysis.sql**

Link: https://github.com/SonalChinkate02/Global-air-quality-analysis/blob/main/Global%20air%20quality%20analysis.sql

---

## Key SQL Features Demonstrated

- Schema design  
- Data profiling  
- Aggregations (AVG, MIN, MAX)  
- CASE-based categorization  
- Ranking and ordering  
- Statistical insights  
- Segmentation & grouping  

---

## Insights Generated

### Temperature Analysis
- Top 10 hottest regions
- Top 10 coolest regions
- Average temperature per country

### Humidity Insights
- Highest & lowest humidity locations
- Average humidity per country

### Wind Speed Analytics
- Wind speed extremes
- Country-wise wind patterns

### UV Analysis
- Most UV-exposed locations
- Risk assessment potential

### Air Quality & Pollution
- Top 10 most polluted countries
- Top 10 cleanest countries
- Advanced segmentation:
  - Good
  - Moderate
  - Unhealthy
  - Hazardous



## Analytical Use Cases
- Health risk identification
- Environmental monitoring
- Pollution risk classification
- Climate impact benchmarking

---

## How to Use (Steps)
1. Install MySQL locally  
2. Run the SQL file  
3. Upload Kaggle dataset into table  
4. Execute insights queries directly

