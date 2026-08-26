{% macro insert_customer_scd2() %}

INSERT INTO {{ target.schema }}.DIM_CUSTOMER_SCD2 (
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

{% endmacro %}