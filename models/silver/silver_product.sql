{{ config(materialized='table') }}

WITH source AS (

    SELECT *
    FROM {{ ref('stg_product') }}

),

cleaned AS (

    SELECT
        PRODUCT_ID,
        TRIM(PRODUCT_NAME) AS PRODUCT_NAME,
        TRIM(CATEGORY) AS CATEGORY,
        PRICE,

        ROW_NUMBER() OVER (
            PARTITION BY PRODUCT_ID
            ORDER BY PRODUCT_ID
        ) AS RN

    FROM source

    WHERE PRODUCT_ID IS NOT NULL

)

SELECT
    PRODUCT_ID,
    COALESCE(PRODUCT_NAME, 'UNKNOWN') AS PRODUCT_NAME,
    COALESCE(CATEGORY, 'UNKNOWN') AS CATEGORY,
    COALESCE(PRICE, 0) AS PRICE

FROM cleaned

WHERE RN = 1