{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}


select
{{ dbt_utils.generate_surrogate_key(['storeid', 'address']) }} as store_key,
storeid,
address,
city,
state,
zip
FROM {{ source('samssubs_landing', 'store') }}