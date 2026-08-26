{{ config(materialized='view') }}

SELECT
    fo.ORDER_ID,
    fo.ORDER_DATE,
    fo.QUANTITY,

    dc.CUSTOMER_ID,
    dc.CUSTOMER_NAME,
    dc.CITY,
    dc.CUSTOMER_TIER,
    dc.VALID_FROM,
    dc.VALID_TO,
    dc.IS_CURRENT,

    dp.PRODUCT_ID,
    dp.PRODUCT_NAME,
    dp.CATEGORY,
    dp.PRICE

FROM {{ ref('fact_order') }} AS fo

LEFT JOIN {{ target.schema }}.DIM_CUSTOMER_SCD2 AS dc
    ON fo.CUSTOMER_ID = dc.CUSTOMER_ID

LEFT JOIN {{ ref('dim_product') }} AS dp
    ON fo.PRODUCT_ID = dp.PRODUCT_ID