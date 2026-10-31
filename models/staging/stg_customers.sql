select
    cast(customer_id as integer)    as customer_id,
    trim(customer_name)             as customer_name,
    lower(trim(email))              as email,
    region,
    tier,
    cast(updated_at as timestamp)   as updated_at
from {{ source('raw', 'raw_customers') }}