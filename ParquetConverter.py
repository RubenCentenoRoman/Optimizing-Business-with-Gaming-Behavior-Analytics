import os
import pandas as pd

def choose_data_file():
    FileTypes = (".xlsx", ".csv") #The file types that this script supports.
    data_files = [f for f in os.listdir(".") if f.endswith(FileTypes)] #Shows in the console the list of files that are [.xlsx] and [.csv].

    if not data_files: #Stops the program if there are no [.xlsx] and [.csv] files.
        print("No data files (.xlsx or .csv) found.")
        return None
    
    print("Available data files:", *[f"{Number+1}. {File}" for Number, File in enumerate(data_files)], sep="\n") #Shows the list of files [.xlsx] and [.csv], giving them a number to choose from.
    choice = input("Enter choice (number or filename): ") #Lets you input the number in the console, that represents the files shown in the console.
    return data_files[int(choice)-1] if choice.isdigit() and 0 < int(choice) <= len(data_files) else (choice if choice in data_files else None)

def convert_to_parquet(file_path):
    FileName, FileType = os.path.splitext(file_path) #Splits the file name and the file type.
    
    print(f"Reading file {FileName}{FileType}, please wait...")
    df = pd.read_excel(file_path) if FileType == '.xlsx' else pd.read_csv(file_path, low_memory=False) #Reads the [.xlsx] or [.csv] file.
    print(f"File {FileName}{FileType}, has been read.")
    
    df.drop(columns='id', inplace=True, errors='ignore') #Drops the id column to avoid errors.
    
    print(f'Converting file {FileName}{FileType} to parquet, please wait...')
    df.astype(str).to_parquet(f"{FileName}.parquet", index=False) #Converts the file to [.parquet].
    print(f"File has been converted to {FileName}.parquet") 

selected_file = choose_data_file()
if selected_file:
    convert_to_parquet(selected_file)