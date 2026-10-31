{{
    config(
        materialized='incremental',
        unique_key='order_id',
        on_schema_change='append_new_columns'
    )
}}

select
    {{ dbt_utils.generate_surrogate_key(['o.order_id', 'o.product_id']) }} as order_line_key,
    o.order_id,
    o.order_date,
    o.customer_id,
    c.customer_name,
    c.region,
    c.tier,
    o.product_id,
    p.product_name,
    p.category,
    o.channel,
    o.quantity,
    p.list_price,
    o.discount,
    {{ calculate_net_amount('o.quantity', 'p.list_price', 'o.discount') }} as net_amount,
    round(o.quantity * p.cost_price, 2)                                    as total_cost
from {{ ref('stg_orders') }} as o
left join {{ ref('stg_customers') }} as c
    on o.customer_id = c.customer_id
left join {{ ref('stg_products') }} as p
    on o.product_id = p.product_id

{% if is_incremental() %}
where o.order_date > (select max(order_date) from {{ this }})
{% endif %}