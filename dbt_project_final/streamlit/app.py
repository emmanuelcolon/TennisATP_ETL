import streamlit as st
import duckdb
import pandas as pd
import matplotlib.pyplot as plt

# Conexión a la base de datos
con = duckdb.connect(database='/dbt_project_final/TennisATP/dev.duckdb', read_only=True)

# Título
st.title("Demo Streamlit")

# Filtro de fechas
min_date, max_date = con.execute("SELECT MIN(tourney_date), MAX(tourney_date) FROM dbt_green.fact_matches_atp").fetchone()
start_date, end_date = st.sidebar.date_input("Selecciona una fecha", [min_date, max_date])

# Consulta para filtrar los datos
query = """
SELECT 
    tourney_date, 
    COUNT(*) AS total_matches,
FROM dbt_green.fact_matches_atp
WHERE tourney_date BETWEEN ? AND ?
GROUP BY ALL
"""
df = con.execute(query, (start_date, end_date)).df()

# Juegos totales
total_games = df['total_matches'].sum()



st.metric("Num total de juegos", "{:,.2f}".format(total_games) )

# Gráfico de líneas con el número de viajes por dia 
st.subheader("Número de juegos según el día")
df_daily = df.groupby('tourney_date')['total_games'].sum().reset_index()
st.line_chart(df_daily, x='tourney_date')

