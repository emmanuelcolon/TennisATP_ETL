{{ config(materialized='table') }}

WITH generate_date AS (
    SELECT CAST(RANGE AS DATE) AS date_key,
    FROM RANGE(DATE '2018-01-01', DATE '2025-12-31', INTERVAL 1 DAY)
)

SELECT date_key AS ID,
       DAYOFYEAR(date_key) AS day_of_year,
       YEARWEEK(date_key) AS week_key,
       WEEKOFYEAR(date_key) AS week_of_year,
       DAYNAME(date_key) AS day_name,
       DATE_TRUNC('week', date_key) AS first_day_of_week,
       MONTH(date_key) AS month_key,
       MONTHNAME(date_key) AS day_of_month,
       DATE_TRUNC('month', date_key) AS first_day_of_month,
       YEAR(date_key) AS year_key,
FROM generate_date