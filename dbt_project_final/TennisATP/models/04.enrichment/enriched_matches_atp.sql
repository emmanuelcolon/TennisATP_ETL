{{ config(materialized='view') }}

WITH relevant_matches AS (

    SELECT *,
           COALESCE(((NULLIF(CAST(w_1st_won AS FLOAT),0) / NULLIF(CAST(w_svpt AS FLOAT),0)) * 100),0) AS avg_first_serve_won_winner,
           COALESCE(((NULLIF(CAST(w_2nd_won AS FLOAT),0) / NULLIF(CAST(w_svpt AS FLOAT),0)) * 100),0) AS avg_second_serve_won_winner,

           COALESCE(((NULLIF(CAST(l_1st_won AS FLOAT),0) / NULLIF(CAST(l_svpt AS FLOAT),0)) * 100),0) AS avg_first_serve_won_loser,
           COALESCE(((NULLIF(CAST(l_2nd_won AS FLOAT),0) / NULLIF(CAST(l_svpt AS FLOAT),0)) * 100),0) AS avg_second_serve_won_loser,
    FROM {{ ref('cleaned_matches_atp') }}

)

SELECT * FROM relevant_matches