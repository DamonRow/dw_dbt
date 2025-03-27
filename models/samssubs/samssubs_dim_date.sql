{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

with cte_date as (
{{ dbt_date.get_date_dimension("1990-01-01", "2050-12-31") }}
)

SELECT
{{ dbt_utils.generate_surrogate_key(['date_day']) }} as date_key,
date_day AS date,
year_number AS year,
month_of_year AS month,
day_of_month AS day
from cte_date