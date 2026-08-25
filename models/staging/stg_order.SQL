with source as (

    select *
    from ECOMMERCE_DWH.BRONZE.RAW_ORDER

),

renamed as (

    select
        ORDER_ID,
        CUSTOMER_ID,
        PRODUCT_ID,
        ORDER_DATE,
        QUANTITY,
        ORDER_STATUS

    from source

)

select *
from renamed