{{ config(
    schema='STAGING',
    materialized='view'
) }}

SELECT
    ORDER_ID,
    ORDER_DATE,
    CUSTOMER_ID,
    PRODUCT_ID,
    QUANTITY
FROM ECOMMERCE.BRONZE.BRONZE_ORDERS