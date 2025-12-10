CREATE DATABASE WeatherAnalytics;
USE WeatherAnalytics;

CREATE TABLE weather_data (
    country VARCHAR(100),
    location_name VARCHAR(100),
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    timezone VARCHAR(100),
    last_updated_epoch BIGINT,
    last_updated DATETIME,
    temperature_celsius DECIMAL(5,2),
    temperature_fahrenheit DECIMAL(5,2),
    condition_text VARCHAR(100),
    wind_mph DECIMAL(5,2),
    wind_kph DECIMAL(5,2),
    wind_degree INT,
    wind_direction VARCHAR(10),
    pressure_mb DECIMAL(8,2),
    pressure_in DECIMAL(8,2),
    precip_mm DECIMAL(8,2),
    precip_in DECIMAL(8,2),
    humidity INT,
    cloud INT,
    feels_like_celsius DECIMAL(5,2),
    feels_like_fahrenheit DECIMAL(5,2),
    visibility_km DECIMAL(5,2),
    visibility_miles DECIMAL(5,2),
    uv_index DECIMAL(5,2),
    gust_mph DECIMAL(5,2),
    gust_kph DECIMAL(5,2),
    air_quality_Carbon_Monoxide DECIMAL(8,2),
    air_quality_Ozone DECIMAL(8,2),
    air_quality_Nitrogen_dioxide DECIMAL(8,2),
    air_quality_Sulphur_dioxide DECIMAL(8,2),
    air_quality_PM2_5 DECIMAL(8,2),
    air_quality_PM10 DECIMAL(8,2),
    air_quality_us_epa_index INT,
    air_quality_gb_defra_index INT,
    sunrise VARCHAR(10),
    sunset VARCHAR(10),
    moonrise VARCHAR(10),
    moonset VARCHAR(10),
    moon_phase VARCHAR(50),
    moon_illumination DECIMAL(5,2)
);

SELECT COUNT(*) FROM weather_data;

DESCRIBE weather_data;

SELECT COUNT(*) AS total_rows FROM weather_data;

SELECT * FROM weather_data LIMIT 10;

SELECT 
    SUM(CASE WHEN temperature_celsius IS NULL THEN 1 ELSE 0 END) AS missing_temp_c,
    SUM(CASE WHEN wind_kph IS NULL THEN 1 ELSE 0 END) AS missing_wind_kph,
    SUM(CASE WHEN humidity IS NULL THEN 1 ELSE 0 END) AS missing_humidity,
    SUM(CASE WHEN air_quality_PM2_5 IS NULL THEN 1 ELSE 0 END) AS missing_pm2_5,
    SUM(CASE WHEN condition_text IS NULL THEN 1 ELSE 0 END) AS missing_condition
FROM weather_data;

SELECT 
	MIN(temperature_celsius) AS min_temp_c,
    MAX(temperature_celsius) AS max_temp_c,
    AVG(temperature_celsius) AS avg_temp_c,
    MIN(wind_kph) AS min_wind_kph,
    MAX(wind_kph) AS max_wind_kp,
    AVG(wind_kph) AS avg_wind_kp,
    MIN(humidity) AS min_humidity,
    MAX(humidity) AS max_humidity,
    AVG(humidity) AS avg_humidity,
    MIN(air_quality_PM2_5) AS min_pm2_5,
    MAX(air_quality_PM2_5) AS max_pm2_5,
    AVG(air_quality_PM2_5) AS avg_pm2_5
FROM weather_data;

-- Most frequent condition -- 
SELECT condition_text, COUNT(*) as count
FROM weather_data 
GROUP BY condition_text
ORDER BY count DESC;

-- TEMPERATURE WISE ANALYSIS -- 
-- top 10 hottest location --
SELECT country, location_name, temperature_celsius
FROM weather_data
ORDER BY temperature_celsius DESC
LIMIT 10;

-- top 10 coolest location --
SELECT country, location_name, temperature_celsius
FROM weather_data
ORDER BY temperature_celsius ASC
LIMIT 10;

-- average temp by country --
SELECT country, ROUND(AVG(temperature_celsius), 2) as avg_temp
FROM weather_data
GROUP BY country
ORDER BY avg_temp DESC;

-- HUMIDITY WISE ANALYSIS --
-- top 10 highest humidity location --
SELECT country, location_name, humidity
FROM weather_data
ORDER BY humidity DESC
LIMIT 10;

-- top 10 lowest humidity location --
SELECT country, location_name, humidity
FROM weather_data
ORDER BY humidity ASC
LIMIT 10;

-- average humidity by country --
SELECT country, ROUND(AVG(humidity), 2) as avg_humidity
FROM weather_data
GROUP BY country
ORDER BY avg_humidity DESC;    

-- WIND DATA ANALYSIS --
-- top 10 highest wind speed location --
SELECT country, location_name, wind_kph
FROM weather_data
ORDER BY wind_kph DESC
LIMIT 10;
    
-- top 10 lowest wind speed location --
SELECT country, location_name, wind_kph
FROM weather_data
ORDER BY wind_kph ASC
LIMIT 10;

-- average wind speed by country --
SELECT country, ROUND(AVG(wind_kph), 2) as avg_wind_kph
FROM weather_data
GROUP BY country
ORDER BY avg_wind_kph DESC; 

-- UV INDEX AND AIR QUALITY ANALYSIS --
-- highest UV --
SELECT country, location_name, uv_index
FROM weather_data
ORDER BY uv_index DESC
LIMIT 10;

-- air quality --
SELECT country, location_name, air_quality_PM2_5
FROM weather_data
ORDER BY air_quality_PM2_5 DESC
LIMIT 10;

-- country wise avg air quality --
SELECT country, ROUND(AVG(air_quality_PM2_5),2) AS avg_pm25
FROM weather_data
GROUP BY country
ORDER BY avg_pm25 DESC;

-- UV vs AIR QUALITY--
SELECT country, location_name, uv_index, air_quality_PM2_5
FROM weather_data
ORDER BY uv_index DESC, air_quality_PM2_5 DESC LIMIT 10;

SELECT country, location_name,
       air_quality_PM2_5,
       CASE
            WHEN air_quality_PM2_5 > 100 THEN 'Hazardous'
            WHEN air_quality_PM2_5 > 50 THEN 'Unhealthy'
            WHEN air_quality_PM2_5 > 25 THEN 'Moderate'
            ELSE 'Good'
       END AS air_quality_category
FROM weather_data
ORDER BY air_quality_PM2_5 DESC;

-- COUNTRY IN EACH CATEGORY --
SELECT air_quality_category,
       COUNT(*) AS num_countries
FROM (
    SELECT country,
           CASE
                WHEN air_quality_PM2_5 > 100 THEN 'Hazardous'
                WHEN air_quality_PM2_5 > 50 THEN 'Unhealthy'
                WHEN air_quality_PM2_5 > 25 THEN 'Moderate'
                ELSE 'Good'
           END AS air_quality_category
      FROM weather_data
) AS t
GROUP BY air_quality_category
ORDER BY num_countries DESC;

-- EXTREME UV INDEX COUNTRIES --
SELECT country, location_name, uv_index
FROM weather_data
WHERE uv_index > 10
ORDER BY uv_index DESC;

-- COUNTRIES WITH HIGH UV AND POLLUTION --
SELECT country, location_name, uv_index, air_quality_PM2_5
FROM weather_data
WHERE uv_index >= 9 AND air_quality_PM2_5 >= 50
ORDER BY uv_index DESC, air_quality_PM2_5 DESC;

-- AVG AIR QUALITY GLOBALLY --
SELECT AVG(air_quality_PM2_5) AS global_avg_pm25
FROM weather_data;

-- Standard Deviation (Health Spread) --
SELECT STD(air_quality_PM2_5) AS pm25_stddev
FROM weather_data;

-- TOP 10 MOST POLLUTED CITIES --
SELECT 
    country,
    ROUND(AVG(air_quality_PM2_5),2) AS avg_pm25
FROM weather_data
WHERE air_quality_PM2_5 IS NOT NULL
GROUP BY country
ORDER BY avg_pm25 DESC
LIMIT 10;

-- TOP 10 MOST CLEANED CITIES --
SELECT 
    country,
    ROUND(AVG(air_quality_PM2_5), 2) AS avg_PM2_5
FROM weather_data
WHERE air_quality_PM2_5 IS NOT NULL
GROUP BY country
ORDER BY avg_PM2_5 ASC
LIMIT 10;









