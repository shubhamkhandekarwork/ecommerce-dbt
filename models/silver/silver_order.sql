{{ config(materialized='table') }}

WITH source AS (

    SELECT *
    FROM {{ ref('stg_order') }}

),

cleaned AS (

    SELECT
        ORDER_ID,
        CUSTOMER_ID,
        PRODUCT_ID,
        ORDER_DATE,
        QUANTITY,
        UPPER(TRIM(ORDER_STATUS)) AS ORDER_STATUS,

        ROW_NUMBER() OVER (
            PARTITION BY ORDER_ID
            ORDER BY ORDER_DATE DESC
        ) AS RN

    FROM source

    WHERE ORDER_ID IS NOT NULL

)

SELECT
    ORDER_ID,
    CUSTOMER_ID,
    PRODUCT_ID,
    ORDER_DATE,
    COALESCE(QUANTITY, 0) AS QUANTITY,
    COALESCE(ORDER_STATUS, 'UNKNOWN') AS ORDER_STATUS

FROM cleaned

WHERE RN = 1