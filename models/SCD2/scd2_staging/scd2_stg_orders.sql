SELECT
    ORDER_ID,
    ORDER_DATE,
    CUSTOMER_ID,
    PRODUCT_ID,
    QUANTITY
FROM {{ source('ecommerce_bronze', 'BRONZE_ORDERS') }}