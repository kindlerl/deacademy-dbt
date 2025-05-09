{{
    config
    (
        materialized = 'table'
    )
}}

WITH session_src AS (
    SELECT
        SESSION_ID,
        USER_ID,
        BROWSER,
        DEVICE_TYPE,
        -- COUNTRY_CODE,
        B.COUNTRY_NAME AS COUNTRY_NAME,
        B.CONTINENT AS CONTINENT,
        B.CURRENCY AS CURRENCY,
        START_TIME,
        END_TIME,
        PAGES_VISITED,
        CURRENT_TIMESTAMP AS INSERT_DTS
    FROM
        -- DBT_DB.PUBLIC.SESSION_SRC A
        {{ source('country', 'SESSION_SRC')}} A
    LEFT JOIN
        -- DBT_DB.PUBLIC.COUNTRY_CODE B
        {{ ref('country_code') }} B
    ON
        A.COUNTRY_CODE = B.COUNTRY_CODE
)

SELECT * FROM session_src