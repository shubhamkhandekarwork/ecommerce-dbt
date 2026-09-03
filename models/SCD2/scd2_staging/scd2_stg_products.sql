{{ config(
    schema='STAGING',
    materialized='view'
) }}

SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    UNIT_PRICE,
    CURRENCY
FROM ECOMMERCE.BRONZE.BRONZE_PRODUCTS