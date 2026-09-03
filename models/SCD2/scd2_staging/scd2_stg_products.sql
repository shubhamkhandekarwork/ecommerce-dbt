SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    UNIT_PRICE,
    CURRENCY
FROM {{ source('ecommerce_bronze', 'BRONZE_PRODUCTS') }}