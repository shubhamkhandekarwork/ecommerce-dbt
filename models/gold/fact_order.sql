{{ config(materialized='view') }}

SELECT
    o.ORDER_ID,
    o.CUSTOMER_ID,
    o.PRODUCT_ID,
    o.ORDER_DATE,
    o.QUANTITY,
    o.ORDER_STATUS,
    p.PRICE,
    o.QUANTITY * p.PRICE AS ORDER_AMOUNT
FROM {{ ref('silver_order') }} o
LEFT JOIN {{ ref('silver_product') }} p
    ON o.PRODUCT_ID = p.PRODUCT_ID
WHERE o.ORDER_ID IS NOT NULL