import dlt
import pandas as pd
from pathlib import Path
import os

def run_pipeline(csv_file_path, table_name):
    pipeline = dlt.pipeline(
        pipeline_name="Housingprices_pipeline",
        destination="snowflake",
        dataset_name="staging",
    )
    
    # Läser in CSV-filen
    data = pd.read_csv(csv_file_path, encoding="utf-8")
    # Ändra vissa kolumnnamnen till engelska
    column_name_mapping = {
        "Brutto-/Nettopris": "Gross_Price",
        "År": "Year",
        "Lägenhetsarea/lägenhet (kvm)": "ApartmentArea_persqm",
        "Markpris/lägenhetsarea (kr)": "LandPrice_persqm",
        "Byggnadspris/lägenhetsarea (kr)": "BuildingPrice_persqm",
    }
    data.rename(columns=column_name_mapping, inplace=True)

    # Säkerställer att kolumnerna är av rätt datatyper
    data["Gross_Price"] = data["Gross_Price"].astype(int)
    data["Year"] = data["Year"].astype(int)
    data["ApartmentArea_persqm"] = data["ApartmentArea_persqm"].astype(float)
    data["LandPrice_persqm"] = data["LandPrice_persqm"].astype(float)
    data["BuildingPrice_persqm"] = data["BuildingPrice_persqm"].astype(float)

    # Lägg till en auto-increment ID-kolumn som första kolumn
    data.insert(0, "id", range(1, len(data) + 1))

    # Visa den transformerade datan innan den skickas till pipelinen
    print("Transformerad data (förhandsgranskning):")
    print(data.head())  
    print("Kolumnnamn och datatyper:")
    print(data.dtypes)  

    # Konverterar DataFrame till en lista av dictionaries
    transformed_data = data.to_dict(orient="records")

    # Kör pipelinen
    load_info = pipeline.run(transformed_data, table_name=table_name)
    print(f"Pipeline körd: {load_info}")

if __name__ == "__main__":
    working_directory = Path(__file__).parent
    os.chdir(working_directory)
    csv_file_path = "stor_stockholm_data.csv"  
    table_name = "Housingprices"
    # Kontrollera första raden i CSV-filen
    with open("stor_stockholm_data.csv", encoding="utf-8") as file:
        print("Första raden i CSV-filen:")
        print(file.readline())

    run_pipeline(csv_file_path, table_name)
