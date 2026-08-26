{{ config(materialized='view') }}

SELECT
    -- Order details
    fo.ORDER_ID,
    fo.ORDER_DATE,
    fo.QUANTITY,
    fo.TOTAL_AMOUNT,

    -- Customer details
    dc.CUSTOMER_ID,
    dc.CUSTOMER_NAME,
    dc.CITY,
    dc.CUSTOMER_TIER,

    -- Product details
    dp.PRODUCT_ID,
    dp.PRODUCT_NAME,
    dp.CATEGORY,
    dp.PRICE

FROM {{ ref('fact_order') }} AS fo

LEFT JOIN {{ ref('dim_customer') }} AS dc
    ON fo.CUSTOMER_ID = dc.CUSTOMER_ID

LEFT JOIN {{ ref('dim_product') }} AS dp
    ON fo.PRODUCT_ID = dp.PRODUCT_ID