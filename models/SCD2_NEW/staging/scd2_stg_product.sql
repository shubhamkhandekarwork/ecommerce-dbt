{{ config(
    database='ECOMMERCE',
    schema='STAGING',
    materialized='view'
) }}

SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    PRICE,
    STOCK_QUANTITY,
    CREATED_AT
FROM ECOMMERCE.BRONZE.RAW_PRODUCT