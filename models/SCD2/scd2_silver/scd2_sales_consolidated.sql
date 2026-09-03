WITH customers AS (

    SELECT
        CUSTOMER_ID,
        CUSTOMER_NAME,
        EMAIL,
        CITY,
        STATE,
        UPDATED_AT
    FROM {{ ref('scd2_stg_customers') }}

),

products AS (

    SELECT
        PRODUCT_ID,
        PRODUCT_NAME,
        CATEGORY,
        UNIT_PRICE,
        CURRENCY
    FROM {{ ref('scd2_stg_products') }}

),

orders AS (

    SELECT
        ORDER_ID,
        ORDER_DATE,
        CUSTOMER_ID,
        PRODUCT_ID,
        QUANTITY
    FROM {{ ref('scd2_stg_orders') }}

)

SELECT
    o.ORDER_ID,
    o.ORDER_DATE,

    c.CUSTOMER_ID,
    c.CUSTOMER_NAME,
    c.EMAIL,
    c.CITY,
    c.STATE,
    c.UPDATED_AT AS CUSTOMER_UPDATED_AT,

    p.PRODUCT_ID,
    p.PRODUCT_NAME,
    p.CATEGORY,
    p.UNIT_PRICE,
    p.CURRENCY,

    o.QUANTITY,

    o.QUANTITY * p.UNIT_PRICE AS ORDER_AMOUNT

FROM orders o

LEFT JOIN customers c
    ON o.CUSTOMER_ID = c.CUSTOMER_ID

LEFT JOIN products p
    ON o.PRODUCT_ID = p.PRODUCT_ID