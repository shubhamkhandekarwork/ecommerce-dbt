{% macro merge_customer_scd2() %}

{% set update_sql %}

UPDATE {{ target.schema }}.DIM_CUSTOMER_SCD2 AS target
SET
    VALID_TO = CURRENT_TIMESTAMP(),
    IS_CURRENT = FALSE
FROM {{ ref('silver_customer') }} AS source
WHERE target.CUSTOMER_ID = source.CUSTOMER_ID
  AND target.IS_CURRENT = TRUE
  AND (
       NVL(target.CUSTOMER_NAME, '') <> NVL(source.CUSTOMER_NAME, '')
    OR NVL(target.CITY, '') <> NVL(source.CITY, '')
    OR NVL(target.STATE, '') <> NVL(source.STATE, '')
    OR NVL(target.EMAIL, '') <> NVL(source.EMAIL, '')
    OR NVL(target.CUSTOMER_TIER, '') <> NVL(source.CUSTOMER_TIER, '')
  );

{% endset %}

{% do run_query(update_sql) %}


{% set insert_sql %}

INSERT INTO {{ target.schema }}.DIM_CUSTOMER_SCD2
(
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CITY,
    STATE,
    EMAIL,
    CUSTOMER_TIER,
    VALID_FROM,
    VALID_TO,
    IS_CURRENT
)

SELECT
    source.CUSTOMER_ID,
    source.CUSTOMER_NAME,
    source.CITY,
    source.STATE,
    source.EMAIL,
    source.CUSTOMER_TIER,
    CURRENT_TIMESTAMP(),
    NULL,
    TRUE

FROM {{ ref('silver_customer') }} AS source

LEFT JOIN {{ target.schema }}.DIM_CUSTOMER_SCD2 AS target
    ON target.CUSTOMER_ID = source.CUSTOMER_ID
    AND target.IS_CURRENT = TRUE

WHERE target.CUSTOMER_ID IS NULL;

{% endset %}

{% do run_query(insert_sql) %}

{% endmacro %}