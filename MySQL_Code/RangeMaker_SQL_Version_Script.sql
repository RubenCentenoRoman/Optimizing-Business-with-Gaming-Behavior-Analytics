-- Step 1: Switch to the desired database
USE gaming_behavior;

-- Step 2: Round the numeric columns in the dataset
UPDATE online_gaming_behavior_dataset
SET Age = CEIL(Age),
    PlayTimeHours = CEIL(PlayTimeHours),
    SessionsPerWeek = CEIL(SessionsPerWeek),
    AvgSessionDurationMinutes = CEIL(AvgSessionDurationMinutes),
    PlayerLevel = CEIL(PlayerLevel),
    AchievementsUnlocked = CEIL(AchievementsUnlocked);

-- Step 3: Drop each range column if it exists
SET @drop_columns = (
    SELECT GROUP_CONCAT(CONCAT('DROP COLUMN ', column_name) SEPARATOR ', ')
    FROM information_schema.columns
    WHERE table_name = 'online_gaming_behavior_dataset'
      AND table_schema = DATABASE()
      AND column_name IN (
        'Age_range', 'PlayTimeHours_range', 'SessionsPerWeek_range', 
        'AvgSessionDurationMinutes_range', 'PlayerLevel_range', 'AchievementsUnlocked_range'
      )
);

SET @sql = IF(@drop_columns IS NOT NULL, CONCAT('ALTER TABLE online_gaming_behavior_dataset ', @drop_columns), 'SELECT "No columns to drop"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Step 4: Add the range columns back
ALTER TABLE online_gaming_behavior_dataset
ADD Age_range VARCHAR(20),
ADD PlayTimeHours_range VARCHAR(20),
ADD SessionsPerWeek_range VARCHAR(20),
ADD AvgSessionDurationMinutes_range VARCHAR(20),
ADD PlayerLevel_range VARCHAR(20),
ADD AchievementsUnlocked_range VARCHAR(20);

-- Step 5: Update the table with range mappings
UPDATE online_gaming_behavior_dataset
SET Age_range = CASE
    WHEN Age BETWEEN 0 AND 24 THEN '0-24'
    WHEN Age BETWEEN 25 AND 49 THEN '25-49'
    WHEN Age BETWEEN 50 AND 74 THEN '50-74'
    ELSE '75-100'
END,
PlayTimeHours_range = CASE
    WHEN PlayTimeHours BETWEEN 0 AND 5 THEN '0-5'
    WHEN PlayTimeHours BETWEEN 6 AND 10 THEN '6-10'
    WHEN PlayTimeHours BETWEEN 11 AND 20 THEN '11-20'
    ELSE '21-30'
END,
SessionsPerWeek_range = CASE
    WHEN SessionsPerWeek BETWEEN 0 AND 2 THEN '0-2'
    WHEN SessionsPerWeek BETWEEN 3 AND 5 THEN '3-5'
    WHEN SessionsPerWeek BETWEEN 6 AND 8 THEN '6-8'
    ELSE '9-12'
END,
AvgSessionDurationMinutes_range = CASE
    WHEN AvgSessionDurationMinutes BETWEEN 0 AND 30 THEN '0-30'
    WHEN AvgSessionDurationMinutes BETWEEN 31 AND 60 THEN '31-60'
    WHEN AvgSessionDurationMinutes BETWEEN 61 AND 120 THEN '61-120'
    ELSE '121-180'
END,
PlayerLevel_range = CASE
    WHEN PlayerLevel BETWEEN 0 AND 25 THEN '0-25'
    WHEN PlayerLevel BETWEEN 26 AND 50 THEN '26-50'
    WHEN PlayerLevel BETWEEN 51 AND 75 THEN '51-75'
    ELSE '76-100'
END,
AchievementsUnlocked_range = CASE
    WHEN AchievementsUnlocked BETWEEN 0 AND 10 THEN '0-10'
    WHEN AchievementsUnlocked BETWEEN 11 AND 20 THEN '11-20'
    WHEN AchievementsUnlocked BETWEEN 21 AND 30 THEN '21-30'
    ELSE '31-40'
END;

-- Step 6: Export the cleaned data into a CSV file
SELECT 'PlayerID', 'Age', 'Gender', 'Location', 'PlayTimeHours', 'SessionsPerWeek', 'AvgSessionDurationMinutes', 
        'EngagementLevel', 'GameGenre', 'GameDifficulty', 'PlayerLevel', 'AchievementsUnlocked', 'InGamePurchases', 
        'Age_range', 'PlayTimeHours_range', 'SessionsPerWeek_range', 'AvgSessionDurationMinutes_range', 
        'PlayerLevel_range', 'AchievementsUnlocked_range'
UNION ALL
SELECT PlayerID, Age, Gender, Location, PlayTimeHours, SessionsPerWeek, AvgSessionDurationMinutes, 
        EngagementLevel, GameGenre, GameDifficulty, PlayerLevel, AchievementsUnlocked, InGamePurchases, 
        Age_range, PlayTimeHours_range, SessionsPerWeek_range, AvgSessionDurationMinutes_range, 
        PlayerLevel_range, AchievementsUnlocked_range 
 FROM online_gaming_behavior_dataset
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_online_gaming_behavior_dataset.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';
