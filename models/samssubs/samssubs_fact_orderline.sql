{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
) }}

SELECT
    c.customer_key,
    e.employee_key,
    p.product_key,
    d.date_key,
    s.store_key,
    m.method_key,
    od.orderlineqty as quantity,
    od.orderlineprice as price
FROM {{ source('samssubs_landing', 'orderdetails') }} od
INNER JOIN {{ source('samssubs_landing', 'orders') }} o ON od.ordernumber = o.ordernumber
INNER JOIN {{ ref('samssubs_dim_customer') }} c ON o.customerid = c.customerid
INNER JOIN {{ ref('samssubs_dim_employee') }} e ON e.employeeid = o.employeeid
INNER JOIN {{ source('samssubs_landing', 'employee') }} em ON em.employeeid = e.employeeid
INNER JOIN {{ ref('samssubs_dim_product') }} p ON od.productid = p.productid
INNER JOIN {{ ref('samssubs_dim_date') }} d ON d.date = o.orderdate
INNER JOIN {{ ref('samssubs_dim_store') }} s ON s.storeid = em.storeid
INNER JOIN {{ ref('samssubs_dim_ordermethod') }} m ON m.ordermethod = o.ordermethod
