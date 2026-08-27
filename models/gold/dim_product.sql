{{ config(materialized='table') }}

SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    PRICE
FROM {{ ref('silver_product') }}
WHERE PRODUCT_ID IS NOT NULL