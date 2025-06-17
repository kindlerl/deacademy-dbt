{{ 
    config(
        database='WALMART_DB',
        schema='SILVER',
        materialized='table',
        tags=['silver', 'scd1']
    )
}}

WITH distinct_dates AS (
    SELECT DISTINCT 
      date AS date_day,
      is_holiday
    FROM
        {{ source('walmart', 'raw_fact') }}
)
SELECT
  ROWNUMBER() OVER(ORDER BY date) AS date_id,
  date_day as date,
  EXTRACT(DAY FROM date_day) AS day,
  EXTRACT(WEEK FROM date_day) AS week,
  EXTRACT(MONTH FROM date_day) AS month,
  TRIM(TO_CHAR(date_day, 'Month')) AS month_name,
  EXTRACT(QUARTER FROM date_day) AS quarter,
  EXTRACT(YEAR FROM date_day) AS year,
  EXTRACT(DAYOFWEEK FROM date_day) AS dayofweek,
  TRIM(TO_CHAR(date_day, 'Day')) AS day_name,
  CASE 
    WHEN EXTRACT(DAYOFWEEK FROM date_day) IN (1,7) THEN TRUE
    ELSE FALSE
  END AS is_weekend,
  is_holiday,
  CURRENT_TIMESTAMP() AS Insert_date,
  CURRENT_TIMESTAMP() AS Update_date
FROM
    distinct_dates




