select
    cast(order_id as integer)       as order_id,
    cast(order_date as date)        as order_date,
    cast(customer_id as integer)    as customer_id,
    cast(product_id as integer)     as product_id,
    cast(quantity as integer)       as quantity,
    cast(discount as decimal(4, 2)) as discount,
    channel
from {{ source('raw', 'raw_orders') }}