
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

-- The table name will be created with the same name as this file (my_first_dbt_model)
-- "dbt run" will simply run both SQL models
-- "dbt build" will run both SQL models AND run the test cases (in schema.yml)
-- To run a single model, execute "dbt build --select <model_name>"

{{ config(materialized='table') }}

WITH source_data AS (

    SELECT 1 AS id
    UNION all
    SELECT null AS id

)

SELECT *
FROM source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
