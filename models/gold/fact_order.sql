{{ config(materialized='view') }}

SELECT
    ORDER_ID,
    CUSTOMER_ID,
    PRODUCT_ID,
    ORDER_DATE,
    QUANTITY,
    ORDER_STATUS
FROM {{ ref('silver_order') }}
WHERE ORDER_ID IS NOT NULL