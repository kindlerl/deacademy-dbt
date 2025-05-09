
{{
    config 
    (
        materialized = "incremental",
        incremental_strategy = "delete+insert",
        unique_key = "PRODUCT_ID"
    )
}}

WITH product_src AS (
    SELECT
        PRODUCT_ID,
        PRODUCT_NAME,
        PRODUCT_PRICE,
        CREATED_AT,
        CURRENT_TIMESTAMP AS INSERT_DTS
    FROM
        -- DBT_DB.PUBLIC.PRODUCT_SRC
        {{ source("product", "PRODUCT_SRC") }}

    -- Since this is an incremental materialization, we need to create the logic here
    {% if is_incremental() %}
        WHERE CREATED_AT > (SELECT MAX(INSERT_DTS) FROM {{ this }})
    {% endif %}
)

SELECT * FROM product_src