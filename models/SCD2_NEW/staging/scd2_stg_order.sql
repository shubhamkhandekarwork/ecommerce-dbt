{{ config(
    database='ECOMMERCE',
    schema='STAGING',
    materialized='view'
) }}

SELECT
    ORDER_ID,
    CUSTOMER_ID,
    PRODUCT_ID,
    ORDER_DATE,
    QUANTITY,
    ORDER_STATUS
FROM ECOMMERCE.BRONZE.RAW_ORDER