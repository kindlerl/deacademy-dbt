-- By default, if we only pass materialized as "incremental", dbt will run it as a "merge"
{{
    config 
    (
        materialized = "incremental",
        incremental_strategy = "append"
    )
}}

WITH sales_src AS (
    SELECT
        SALE_ID, 
        SALE_DATE, 
        CUSTOMER_ID, 
        PRODUCT_ID, 
        QUANTITY, 
        TOTAL_AMOUNT, 
        CREATED_AT,
        CURRENT_TIMESTAMP AS INSERT_DTS
    FROM
        -- DBT_DB.PUBLIC.SALES_SRC
        {{ source("sales", "SALES_SRC") }}

    {% if is_incremental() %}
        WHERE CREATED_AT > (SELECT MAX(INSERT_DTS) FROM {{this}})
    {% endif %}
)

SELECT * FROM sales_src