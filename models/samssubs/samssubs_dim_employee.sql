{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}


select
{{ dbt_utils.generate_surrogate_key(['employeeid', 'employeelname']) }} as employee_key,
employeeid,
employeefname,
employeelname,
employeebday
FROM {{ source('samssubs_landing', 'employee') }}