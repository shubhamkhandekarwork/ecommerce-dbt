{{ config(
    materialized='table'
) }}

WITH source AS (

    SELECT *
    FROM {{ ref('stg_order') }}

),

cleaned AS (

    SELECT
        ORDER_ID,
        CUSTOMER_ID,
        PRODUCT_ID,
        CAST(ORDER_DATE AS DATE) AS ORDER_DATE,
        CAST(QUANTITY AS NUMBER) AS QUANTITY,
        UPPER(TRIM(ORDER_STATUS)) AS ORDER_STATUS

    FROM source

)

SELECT *
FROM cleaned