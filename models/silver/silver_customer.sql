{{ config(
    materialized='table'
) }}

WITH source AS (

    SELECT *
    FROM {{ ref('stg_customer') }}

),

cleaned AS (

    SELECT
        CUSTOMER_ID,
        TRIM(CUSTOMER_NAME) AS CUSTOMER_NAME,
        TRIM(CITY) AS CITY,
        TRIM(STATE) AS STATE,
        LOWER(TRIM(EMAIL)) AS EMAIL,
        UPPER(TRIM(CUSTOMER_TIER)) AS CUSTOMER_TIER

    FROM source

)

SELECT *
FROM cleaned