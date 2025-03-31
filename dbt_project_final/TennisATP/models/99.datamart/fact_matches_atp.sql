{{ config(materialized='incremental', unique_key='ID') }}

WITH _tmp_data AS (

    SELECT 
            *,
            NOW() AS audit_row_insert,
            'dbt_proyecto_final' as audit_process_id


    FROM {{ ref('stg_fact_matches_atp') }}

)

SELECT * FROM _tmp_data
{% if is_incremental() %}
  -- En el modo incremental, solo se procesan los registros nuevos o modificados
  where tourney_date > (select max(tourney_date) from {{ this }})
{% endif %}