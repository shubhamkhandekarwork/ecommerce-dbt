{{ config(materialized='view') }}

WITH current_customer AS (

    SELECT
        CUSTOMER_ID,
        CUSTOMER_NAME,
        CITY,
        STATE,
        EMAIL,
        CUSTOMER_TIER
    FROM {{ ref('silver_customer') }}

),

scd2_customer AS (

    SELECT
        CUSTOMER_ID,
        CUSTOMER_NAME,
        CITY,
        STATE,
        EMAIL,
        CUSTOMER_TIER,
        VALID_FROM,
        VALID_TO,
        IS_CURRENT
    FROM ECOMMERCE_DWH.DBT_SKHANDEKAR.DIM_CUSTOMER_SCD2

),

unchanged AS (

    SELECT
        s.CUSTOMER_ID,
        s.CUSTOMER_NAME,
        s.CITY,
        s.STATE,
        s.EMAIL,
        s.CUSTOMER_TIER,
        d.VALID_FROM,
        d.VALID_TO,
        d.IS_CURRENT,
        'UNCHANGED' AS SCD2_STATUS

    FROM current_customer s

    INNER JOIN scd2_customer d
        ON s.CUSTOMER_ID = d.CUSTOMER_ID
       AND d.IS_CURRENT = TRUE

    WHERE
           NVL(s.CUSTOMER_NAME, '') = NVL(d.CUSTOMER_NAME, '')
       AND NVL(s.CITY, '') = NVL(d.CITY, '')
       AND NVL(s.STATE, '') = NVL(d.STATE, '')
       AND NVL(s.EMAIL, '') = NVL(d.EMAIL, '')
       AND NVL(s.CUSTOMER_TIER, '') = NVL(d.CUSTOMER_TIER, '')

),

changed AS (

    SELECT
        s.CUSTOMER_ID,
        s.CUSTOMER_NAME,
        s.CITY,
        s.STATE,
        s.EMAIL,
        s.CUSTOMER_TIER,
        d.VALID_FROM,
        d.VALID_TO,
        d.IS_CURRENT,
        'CHANGED' AS SCD2_STATUS

    FROM current_customer s

    INNER JOIN scd2_customer d
        ON s.CUSTOMER_ID = d.CUSTOMER_ID
       AND d.IS_CURRENT = TRUE

    WHERE
           NVL(s.CUSTOMER_NAME, '') <> NVL(d.CUSTOMER_NAME, '')
        OR NVL(s.CITY, '') <> NVL(d.CITY, '')
        OR NVL(s.STATE, '') <> NVL(d.STATE, '')
        OR NVL(s.EMAIL, '') <> NVL(d.EMAIL, '')
        OR NVL(s.CUSTOMER_TIER, '') <> NVL(d.CUSTOMER_TIER, '')

),

new_records AS (

    SELECT
        s.CUSTOMER_ID,
        s.CUSTOMER_NAME,
        s.CITY,
        s.STATE,
        s.EMAIL,
        s.CUSTOMER_TIER,
        CURRENT_TIMESTAMP() AS VALID_FROM,
        NULL AS VALID_TO,
        TRUE AS IS_CURRENT,
        'NEW' AS SCD2_STATUS

    FROM current_customer s

    LEFT JOIN scd2_customer d
        ON s.CUSTOMER_ID = d.CUSTOMER_ID

    WHERE d.CUSTOMER_ID IS NULL

)

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CITY,
    STATE,
    EMAIL,
    CUSTOMER_TIER,
    VALID_FROM,
    VALID_TO,
    IS_CURRENT,
    SCD2_STATUS
FROM unchanged

UNION ALL

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CITY,
    STATE,
    EMAIL,
    CUSTOMER_TIER,
    VALID_FROM,
    VALID_TO,
    IS_CURRENT,
    SCD2_STATUS
FROM changed

UNION ALL

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CITY,
    STATE,
    EMAIL,
    CUSTOMER_TIER,
    VALID_FROM,
    VALID_TO,
    IS_CURRENT,
    SCD2_STATUS
FROM new_records