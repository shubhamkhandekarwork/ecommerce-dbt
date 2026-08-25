{{ config(materialized='view') }}

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CITY,
    STATE,
    EMAIL,
    CUSTOMER_TIER
FROM {{ ref('silver_customer') }}
WHERE CUSTOMER_ID IS NOT NULL