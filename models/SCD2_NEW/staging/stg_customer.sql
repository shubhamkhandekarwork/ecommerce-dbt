{{ config(
    database='ECOMMERCE',
    schema='STAGING',
    materialized='view'
) }}

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CITY,
    STATE,
    EMAIL,
    CUSTOMER_TIER,
    UPDATED_AT
FROM ECOMMERCE.BRONZE.RAW_CUSTOMER