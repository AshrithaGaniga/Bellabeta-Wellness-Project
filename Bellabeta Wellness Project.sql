CREATE DATABASE bellabeat;

USE bellabeat;

CREATE TABLE dailyactivity (
    Id BIGINT NOT NULL,
    ActivityDate DATE NOT NULL,
    TotalSteps INT,
    TotalDistance FLOAT,
    TrackerDistance FLOAT,
    LoggedActivitiesDistance FLOAT,
    VeryActiveDistance FLOAT,
    ModeratelyActiveDistance FLOAT,
    LightActiveDistance FLOAT,
    SedentaryActiveDistance FLOAT,
    VeryActiveMinutes INT,
    FairlyActiveMinutes INT,
    LightlyActiveMinutes INT,
    SedentaryMinutes INT,
    Calories INT,
    PRIMARY KEY (Id, ActivityDate)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dailyActivity_merged.csv'
INTO TABLE dailyactivity
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT ActivityDate FROM dailyActivity LIMIT 10;

CREATE TABLE daily_calories (
    Id BIGINT,
    ActivityDate DATE,
    Calories INT
);

CREATE TABLE daily_intensity (
    Id BIGINT,
    ActivityDate DATE,
    SedentaryMinutes INT,
    LightlyActiveMinutes INT,
    FairlyActiveMinutes INT,
    VeryActiveMinutes INT,
    SedentaryActiveDistance FLOAT,
    LightActiveDistance FLOAT,
    ModeratelyActiveDistance FLOAT,
    VeryActiveDistance FLOAT
);

CREATE TABLE daily_steps (
    Id BIGINT,
    ActivityDate DATE,
    StepTotal INT
);

CREATE TABLE sleep_day (
    Id BIGINT,
    SleepDay date,
    TotalSleepRecords INT,
    TotalMinutesAsleep INT,
    TotalTimeInBed INT
);

CREATE TABLE weight_log (
    Id BIGINT,
    Date date,
    WeightKg FLOAT,
    WeightPounds FLOAT,
    Fat FLOAT,
    BMI FLOAT,
    IsManualReport BOOLEAN,
    LogId BIGINT
);

CREATE TABLE minute_steps (
    Id BIGINT,
    ActivityMinute date,
    StepTotal INT
);

CREATE TABLE minute_intensity (
    Id BIGINT,
    ActivityMinute date,
    Intensity INT
);

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\dailyCalories_merged.csv"
INTO TABLE daily_calories
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\dailyCalories_merged.csv"
INTO TABLE daily_calories
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\dailyIntensities_merged.csv"
INTO TABLE daily_intensity
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\dailySteps_merged.csv"
INTO TABLE daily_steps
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\dailyActivity_merged.csv"
INTO TABLE dailyactivity
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\minuteIntensitiesNarrow_merged.csv"  
INTO TABLE minute_intensity  
FIELDS TERMINATED BY ','  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS;


LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\minuteStepsNarrow_merged.csv"
INTO TABLE minute_steps
FIELDS TERMINATED BY ','  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS;


LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\sleepDay_merged.csv"
INTO TABLE sleep_day
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\weightinfo.csv"
INTO TABLE weight_log  
FIELDS TERMINATED BY ','  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS;


 # DATA CLEANING 
 
DELETE FROM dailyactivity 
WHERE id IN (
    SELECT id FROM (
        SELECT id, COUNT(*) AS count FROM dailyactivity 
        GROUP BY id HAVING count > 1
    ) AS duplicate_rows
);

# These SQL queries are checking for missing (NULL) values in specific columns of the sleep_day and weight_log tables.

SELECT * FROM sleep_day WHERE total_minutes_asleep IS NULL;
SELECT * FROM weight_log WHERE WeightKg IS NULL;

SELECT COUNT(DISTINCT id) FROM dailyactivity;



LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\weightinfo.csv"
INTO TABLE weight_log
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@var1, @var2, @var3, @var4, @date, @var6) 
SET Date = STR_TO_DATE(@date, '%m/%d/%Y %H:%i');

DESCRIBE weight_log;

ALTER TABLE weight_log MODIFY COLUMN Date DATETIME;

SELECT * FROM weight_log LIMIT 10;
SHOW WARNINGS;

SELECT * FROM weight_log WHERE Fat NOT REGEXP '^[0-9.]+$';
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\weightinfo.csv"
INTO TABLE weight_log
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@Id, @Date, @WeightKg, @WeightPounds, @Fat, @BMI, @IsManualReport, @LogId)
SET 
    Date = STR_TO_DATE(@Date, '%m/%d/%Y %H:%i'),
    IsManualReport = CASE WHEN @IsManualReport = 'TRUE' THEN 1 ELSE 0 END,
    Id = @Id,
    WeightKg = @WeightKg,
    WeightPounds = @WeightPounds,
    Fat = NULLIF(@Fat, ''),
    BMI = NULLIF(@BMI, ''),
    LogId = @LogId;

SELECT * FROM weight_log LIMIT 10;

SELECT COUNT(*) FROM dailyactivity;


LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\minuteIntensitiesNarrow_merged.csv" 
INTO TABLE minute_intensity 
FIELDS TERMINATED BY ','  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS 
(@Id, @ActivityMinute, @Intensity) 
SET 
    ActivityMinute = STR_TO_DATE(@ActivityMinute, '%h:%i %p'), 
    Id = @Id, 
    Intensity = @Intensity;

ALTER TABLE minute_intensity 
MODIFY COLUMN ActivityMinute DATETIME;


SELECT * FROM minute_intensity LIMIT 10;

SELECT COUNT(*) FROM minute_steps;

ALTER TABLE minute_intensity MODIFY COLUMN ActivityMinute DATETIME;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\minuteStepsNarrow_merged.csv" 
INTO TABLE minute_steps 
FIELDS TERMINATED BY ','  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS 
(@Id, @ActivityMinute, @Intensity)
SET ActivityMinute = STR_TO_DATE(@ActivityMinute, '%h:%i %p'); 

ALTER TABLE minute_intensity MODIFY COLUMN ActivityMinute TIME;

SELECT COUNT(*) FROM daily_calories;
SELECT COUNT(*) FROM daily_intensity;
SELECT COUNT(*) FROM daily_steps;
SELECT COUNT(*) FROM dailyactivity;
SELECT COUNT(*) FROM minute_intensity;
SELECT COUNT(*) FROM minute_steps;
SELECT COUNT(*) FROM sleep_day;
SELECT COUNT(*) FROM weight_log;

#Find Duplicate IDs and delete record with duplicate id 

DELETE FROM dailyactivity 
WHERE id IN (
    SELECT id FROM (
        SELECT id, COUNT(*) AS count FROM dailyactivity 
        GROUP BY id HAVING count > 1
    ) AS duplicate_rows
);

# check missing data in sleep day and weigh log 

SELECT * FROM sleep_day WHERE total_minutes_asleep IS NULL;
SELECT * FROM weight_log WHERE WeightKg IS NULL;

# count distinct id 
#  the average number of steps taken per day by users and rounds it to two decimal places.
SELECT * FROM dailyactivity LIMIT 100;
SELECT COUNT(DISTINCT id) FROM dailyactivity;
SELECT ROUND(AVG(TotalSteps), 2) AS avg_daily_steps FROM dailyactivity;

# the average number of calories burned per day by users and rounds it to two decimal places
SELECT ROUND(AVG(calories), 2) AS avg_daily_calories FROM daily_calories;
SELECT ROUND(AVG(TotalMinutesAsleep / 60), 2) AS avg_sleep_hours FROM sleep_day;

#the average sedentary time (in minutes) per day across all users and rounds it to two decimal places.
SELECT ROUND(AVG(SedentaryMinutes), 2) AS avg_sedentary_time FROM daily_intensity;

#This query calculates the Pearson correlation coefficient between Total Steps (from dailyactivity) and Calories Burned (from daily_calories).

#  What the Correlation Value Tells
# If correlation ≈ 1 → Strong positive relationship (more steps → more calories burned).
# If correlation ≈ -1 → Strong negative relationship (more steps → fewer calories burned, which is unlikely).
# If correlation ≈ 0 → No significant relationship between steps and calories.


SELECT 
    (SUM(dailyactivity.TotalSteps * daily_calories.Calories) - COUNT(*) * AVG(dailyactivity.TotalSteps) * AVG(daily_calories.Calories)) / 
    (SQRT(SUM(POWER(dailyactivity.TotalSteps, 2)) - COUNT(*) * POWER(AVG(dailyactivity.TotalSteps), 2)) * 
     SQRT(SUM(POWER(daily_calories.Calories, 2)) - COUNT(*) * POWER(AVG(daily_calories.Calories), 2))) 
     AS correlation
FROM dailyactivity
JOIN daily_calories USING (ID);

#1. Finding the Most Active Users Based on Steps and Calories
SELECT ID, 
       SUM(TotalSteps) AS total_steps, 
       SUM(daily_calories.Calories) AS total_calories
FROM dailyactivity
JOIN daily_calories USING (ID)
GROUP BY ID
ORDER BY total_steps DESC
LIMIT 10;

#2. Weekly Trends: Average Steps & Calories per Weekday
SELECT DAYNAME(dailyactivity.ActivityDate) AS weekday, 
       ROUND(AVG(dailyactivity.TotalSteps), 0) AS avg_steps, 
       ROUND(AVG(daily_calories.Calories), 0) AS avg_calories
FROM dailyactivity
JOIN daily_calories USING (ID)
GROUP BY weekday
ORDER BY FIELD(weekday, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

 # Categorizing Users Based on Activity Levels

SELECT ID,
       SUM(TotalSteps) AS total_steps,
       SUM(daily_calories.Calories) AS total_calories,
       CASE 
           WHEN SUM(TotalSteps) >= 100000 THEN 'Highly Active'
           WHEN SUM(TotalSteps) BETWEEN 50000 AND 99999 THEN 'Moderately Active'
           ELSE 'Low Activity'
       END AS activity_level
FROM dailyactivity
JOIN daily_calories USING (ID)
GROUP BY ID;

# (If the correlation is positive (e.g., 0.5)
#→ People who sleep more tend to take more steps.
#→ Indicates that good sleep might boost energy levels for physical activity.

#If the correlation is negative (e.g., -0.6)
#→ People who sleep more take fewer steps.
#→ Suggests that those who sleep longer may have a more sedentary lifestyle.

#If the correlation is near zero (e.g., 0.02)
#→ No strong relationship between sleep and activity.)



SELECT 
    (SUM(sleep_day.TotalMinutesAsleep * dailyactivity.TotalSteps) - COUNT(*) * AVG(sleep_day.TotalMinutesAsleep) * AVG(dailyactivity.TotalSteps)) /
    (SQRT(SUM(POWER(sleep_day.TotalMinutesAsleep, 2)) - COUNT(*) * POWER(AVG(sleep_day.TotalMinutesAsleep), 2)) * 
     SQRT(SUM(POWER(dailyactivity.TotalSteps, 2)) - COUNT(*) * POWER(AVG(dailyactivity.TotalSteps), 2))) 
    AS sleep_activity_correlation
FROM sleep_day
JOIN dailyactivity USING (ID);











































 
 
 
