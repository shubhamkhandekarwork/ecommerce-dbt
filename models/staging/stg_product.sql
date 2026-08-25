with source as (

    select *
    from ECOMMERCE_DWH.BRONZE.RAW_PRODUCT

),

renamed as (

    select
        PRODUCT_ID,
        PRODUCT_NAME,
        CATEGORY,
        PRICE,
        STOCK_QUANTITY,
        CREATED_AT,

    from source

)

select *
from renamed