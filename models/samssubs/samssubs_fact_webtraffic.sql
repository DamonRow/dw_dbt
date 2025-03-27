{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
) }}

SELECT
ts.trafficsource_key,
wp.webpage_key,
et.eventtype_key,
d.date_key,
COUNT(ts.trafficsource_key) as interactioncount
FROM {{ source('samssubs_landing', 'web_traffic_events') }} wt
INNER JOIN {{ ref('samssubs_dim_trafficsource') }} ts ON wt.traffic_source = ts.trafficsource
INNER JOIN {{ref('samssubs_dim_webpage') }} wp ON wt.page_url = wp.url
INNER JOIN {{ref('samssubs_dim_eventtype') }} et ON wt.event_name = et.eventname
INNER JOIN {{ ref('samssubs_dim_date') }} d ON CAST(wt.event_timestamp AS DATE) = d.date
GROUP BY ts.trafficsource_key, wp.webpage_key, et.eventtype_key, d.date_key