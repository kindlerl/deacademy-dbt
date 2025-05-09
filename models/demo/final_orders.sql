{{
    config 
    (
        materialized = 'table'
    )
}}

WITH clean_orders AS (
    SELECT
        ORDER_ID, 
        ORDER_DATE, 
        CUSTOMER_ID,
        CUSTOMER_NAME,
        CREATED_AT,
        CURRENT_TIMESTAMP AS INSERT_DTS
    FROM
        -- Select the 3-dots icon next to clean_orders.sql and pick "Copy as ref"
        -- to copy the reference.  Paste it here.
        {{ ref('clean_orders') }}
)

SELECT * FROM clean_orders