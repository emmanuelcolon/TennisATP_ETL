
# Instalar esta librerias :
# 1 : !pip install "dlt[filesystem]"
# 2 : !pip install pandas
# 3 : !pip install "dlt[parquet]"

import os
import requests
import dlt
from pathlib import Path
import pandas as pd
from io import StringIO

# Obtener la ruta absoluta del archivo app.py
app_path = Path(__file__).resolve()

parent_folder = app_path.parent.parent
bucket_path = parent_folder / "data"

# Definir la ruta donde se almacenarán los ficheros
os.environ["BUCKET_URL"] = str(bucket_path) #"./data/"

# Array de años a importar
years_to_import = [2018, 2019, 2020]

data_pipeline = dlt.pipeline(
    pipeline_name="data_tennis_atp",
    destination="filesystem",
    dataset_name="ds_tennis_atp"
)

# Iterar sobre cada año del array para construir la URL y ejecutar el pipeline
for year in years_to_import:

    API_URL = f"https://raw.githubusercontent.com/JeffSackmann/tennis_atp/master/atp_matches_{year}.csv"
    
    # Descargar el contenido del CSV
    response = requests.get(API_URL)
    response.raise_for_status()  # Verifica que la descarga sea exitosa
    csv_text = response.text

    # Leer el CSV en un DataFrame
    df = pd.read_csv(StringIO(csv_text))

    # Convertir el DataFrame a una lista de diccionarios (estructura JSON)
    data = df.to_dict(orient="records")

    print(f"Importando datos del año {year} desde {API_URL}")
    
    # Ejecutar el pipeline: se descarga el CSV y se guarda en una partición identificada por el año
    data_pipeline.run(
        data,
        table_name=str(year),
        loader_file_format="parquet",
        write_disposition="replace"
    )