{{ config(
    materialized='table'
) }}

WITH source AS (

    SELECT *
    FROM {{ ref('stg_product') }}

),

cleaned AS (

    SELECT
        PRODUCT_ID,
        TRIM(PRODUCT_NAME) AS PRODUCT_NAME,
        TRIM(CATEGORY) AS CATEGORY,
        CAST(PRICE AS NUMBER(12,2)) AS PRICE

    FROM source

)

SELECT *
FROM cleaned