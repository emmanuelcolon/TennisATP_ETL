{{ config(materialized='incremental', unique_key='ID') }}

WITH _tmp_data AS (

    SELECT 
            *,
            NOW() AS audit_row_insert,
            'dbt_proyecto_final' as audit_process_id


    FROM {{ ref('stg_fact_matches_atp') }}

)

SELECT * FROM _tmp_data