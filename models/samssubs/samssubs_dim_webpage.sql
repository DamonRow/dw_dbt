{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}


select distinct
{{ dbt_utils.generate_surrogate_key(['page_url']) }} as webpage_key,
page_url as url
FROM {{ source('samssubs_landing', 'web_traffic_events') }}