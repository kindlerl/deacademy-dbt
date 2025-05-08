
-- Let's create a TABLE instead of a VIEW.  Without the configuration block
-- below, it will only create a VIEW.
{{
    config (
        materialized='table'
    )
}}

WITH employee_raw AS (
    -- Original, just to confirm the data load
    -- SELECT *
    -- FROM DBT_DB.PUBLIC.EMPLOYEE_RAW

    -- Transform the data
    SELECT
        EMPID AS emp_id,
        split_part(NAME, ' ', 1) AS emp_firstname,
        split_part(NAME, ' ', 2) AS emp_lastname,
        SALARY AS emp_salary,
        HIREDATE AS emp_hiredate,
        split_part(ADDRESS, ',', 1) as emp_street,
        split_part(ADDRESS, ',', 2) as emp_city,
        split_part(ADDRESS, ',', 3) as emp_country,
        split_part(ADDRESS, ',', 4) as emp_zipcode
    FROM
        -- Initially, we hard-coded the source as the raw table.  
        -- But what if the schema got changed?
        -- You can store the source in one place, then reference it multiple places.
        -- To do that, we need to update the YML file to hold this configuration.
        -- DBT_DB.PUBLIC.EMPLOYEE_RAW
        -- Pass the yml configuration name (employee) to pull the database
        -- and schema name, then pass the table (EMPLOYEE_RAW) against which
        -- you want to run the query
        {{source('employee', 'EMPLOYEE_RAW')}}
)
SELECT *
FROM employee_raw