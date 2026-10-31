select
    cast(product_id as integer)         as product_id,
    trim(product_name)                  as product_name,
    category,
    cast(cost_price as decimal(12, 2))  as cost_price,
    cast(list_price as decimal(12, 2))  as list_price
from {{ source('raw', 'raw_products') }}