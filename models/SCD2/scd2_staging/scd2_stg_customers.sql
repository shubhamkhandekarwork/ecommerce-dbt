SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    EMAIL,
    CITY,
    STATE,
    UPDATED_AT
FROM {{ source('ecommerce_bronze', 'BRONZE_CUSTOMERS') }}
