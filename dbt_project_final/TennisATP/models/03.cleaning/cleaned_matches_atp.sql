{{ config(materialized='view') }}

-- limpiamos duplicados
WITH remove_duplicates AS (

    SELECT DISTINCT
           *
    FROM {{ ref('stg_matches_atp') }}

)
-- solo comtemplamos torneos mas importantes
, main_tourney_level AS (

    SELECT * 
    FROM remove_duplicates
    WHERE tourney_level IN ('G', 'M', 'A') -- 'G' = Grand Slams, 'M' = Masters 1000s, 'A' = other tour-level events
)

SELECT * FROM main_tourney_level