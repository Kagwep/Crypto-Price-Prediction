import json
import csv

# Define the JSON file name
json_file = 'cryptodata.json'

# Define the CSV file name
csv_file = 'crypto_data.csv'

# Define the fieldnames based on the keys in the JSON objects
fieldnames = ['PUBLISHER', 'DECIMALS', 'PRICE', 'TIMESTAMP', 'NEW_PAIR_ID', 'SOURCE', 'VOLUME']

# Open the JSON file and load its contents
with open(json_file, 'r') as file:
    json_data = json.load(file)
    #print(json_data)

# Open the CSV file in write mode
with open(csv_file, mode='w', newline='') as file:
    # Create a CSV writer object
    writer = csv.DictWriter(file, fieldnames=fieldnames)

    # Write the header
    writer.writeheader()

    # Write each JSON object as a row in the CSV file
    for data in json_data:
        writer.writerow(data)

    print("CSV file created successfully!")
