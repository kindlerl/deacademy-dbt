-- Must define this as a snapshot using the "snapshot" directive

{% snapshot patient_snapshot %}

    {{
        config (
            strategy = 'check',
            unique_key = 'PATIENT_ID',
            check_cols = ['PATIENT_NAME', 'PATIENT_CONTACT_NUMBER', 'PATIENT_EMAIL_ID' , 'PATIENT_ADDRESS']
        )
    }}
    SELECT 
        * 
    FROM 
        -- DBT_DB.PUBLIC.PATIENT_SRC
        {{ source('patient', 'PATIENT_SRC')}}

{% endsnapshot %}