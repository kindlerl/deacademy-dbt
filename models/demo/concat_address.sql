{{
    config
    (
        materialized = 'table'
    )
}}

SELECT {{ concat_macro('123street', 'Chicago') }} AS address