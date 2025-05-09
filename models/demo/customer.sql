{{
    config
    (
        materialized = 'table'
    )
}}

WITH customer_src AS (
    SELECT
        CUSTOMER_ID,
        FIRST_NAME,
        LAST_NAME,
        EMAIL,
        PHONE,
        COUNTRY,
        CREATED_AT,
        CURRENT_TIMESTAMP AS INSERT_DTS
    FROM
        -- Pass the yml configuration name (employee) to pull the database
        -- and schema name, then pass the table (EMPLOYEE_RAW) against which
        -- you want to run the query
        {{source('customer', 'CUSTOMER_SRC')}}
)

SELECT *
FROM customer_src


