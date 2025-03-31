{{ config(materialized='view') }}

select * from read_parquet('data/ds_tennis_atp/*/*.parquet')

