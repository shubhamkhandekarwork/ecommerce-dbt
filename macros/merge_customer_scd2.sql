{% macro merge_customer_scd2() %}

MERGE INTO {{ target.schema }}.DIM_CUSTOMER_SCD2 AS target

USING (
    SELECT
        CUSTOMER_ID,
        CUSTOMER_NAME,
        CITY,
        STATE,
        EMAIL,
        CUSTOMER_TIER
    FROM {{ ref('silver_customer') }}
) AS source

ON target.CUSTOMER_ID = source.CUSTOMER_ID
AND target.IS_CURRENT = TRUE

WHEN MATCHED
AND (
       NVL(target.CUSTOMER_NAME, '') <> NVL(source.CUSTOMER_NAME, '')
    OR NVL(target.CITY, '') <> NVL(source.CITY, '')
    OR NVL(target.STATE, '') <> NVL(source.STATE, '')
    OR NVL(target.EMAIL, '') <> NVL(source.EMAIL, '')
    OR NVL(target.CUSTOMER_TIER, '') <> NVL(source.CUSTOMER_TIER, '')
)
THEN UPDATE SET
    target.VALID_TO = CURRENT_TIMESTAMP(),
    target.IS_CURRENT = FALSE;

{% endmacro %}