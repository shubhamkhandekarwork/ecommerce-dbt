with source as (

    select *
    from ECOMMERCE_DWH.BRONZE.RAW_CUSTOMER

),

renamed as (

    select
        CUSTOMER_ID,
        CUSTOMER_NAME,
        CITY,
        STATE,
        EMAIL,
        CUSTOMER_TIER,
        UPDATED_AT

    from source

)

select *
from renamed