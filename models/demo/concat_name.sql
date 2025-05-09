{{
    config
    (
        materialized = 'table'
    )
}}

SELECT {{ concat_macro('John','Smith') }} AS name