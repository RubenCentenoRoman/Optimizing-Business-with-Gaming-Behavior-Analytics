import pandas as pd
import numpy as np

# Define the file path and columns of interest
file_path = 'online_gaming_behavior_dataset.parquet'
columns_of_interest = ['PlayerID', 'Age', 'Gender', 'Location', 'PlayTimeHours', 'SessionsPerWeek', 'AvgSessionDurationMinutes', 'EngagementLevel', 
                       'GameGenre', 'GameDifficulty', 'PlayerLevel', 'AchievementsUnlocked', 'InGamePurchases']
columns_to_round = ['Age', 'PlayTimeHours', 'SessionsPerWeek', 'AvgSessionDurationMinutes', 'PlayerLevel', 'AchievementsUnlocked']

# Read the Parquet file, selecting only the columns of interest
df = pd.read_parquet(file_path, columns=columns_of_interest)

# Round up the specified columns and convert them to integers
df[columns_to_round] = np.ceil(df[columns_to_round].astype(float)).astype(int)

# Function to calculate ranges for specified columns
def get_ranges(df, columns):
    ranges = {}
    for col in columns:
        min_value = int(df[col].min())  # Get the minimum value of the column
        max_value = int(df[col].max())  # Get the maximum value of the column
        # Calculate quartile ranges
        quarter1 = round(min_value + (max_value - min_value) / 4)
        quarter2 = round(min_value + 2 * (max_value - min_value) / 4)
        quarter3 = round(min_value + 3 * (max_value - min_value) / 4)
        # Store the ranges in a dictionary with a tab character to avoid date conversion
        ranges[col] = [
            (min_value, quarter1-1, f"{min_value}-{quarter1-1}\t"),
            (quarter1, quarter2-1, f"{quarter1}-{quarter2-1}\t"),
            (quarter2, quarter3-1, f"{quarter2}-{quarter3-1}\t"),
            (quarter3, max_value, f"{quarter3}-{max_value}\t")
        ]
    return ranges

# Function to map a value to its corresponding range
def map_to_range(value, ranges):
    for lower, upper, range_str in ranges:
        if lower <= value <= upper:
            return range_str
    return value

# Calculate ranges for the specified columns
ranges = get_ranges(df, columns_to_round)

# Debugging: Print ranges to ensure they are calculated correctly
print("Calculated ranges:", ranges)

# Apply the range mapping to the DataFrame and create new columns for the ranges
for col in columns_to_round:
    df[f"{col}_range"] = df[col].apply(map_to_range, args=(ranges[col],))

# Save the cleaned DataFrame to CSV, Parquet, and Excel files
df.to_csv('clean_online_gaming_behavior_dataset.csv', index=False)
df.to_parquet('clean_online_gaming_behavior_dataset.parquet', index=False)
df.to_excel('clean_online_gaming_behavior_dataset.xlsx', index=False)

# Confirmation message
print('Successfully cleaned the data.')
