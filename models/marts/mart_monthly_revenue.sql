select
    date_trunc('month', order_date)  as order_month,
    count(*)                         as total_orders,
    sum(quantity)                    as units_sold,
    sum(net_amount)                  as net_revenue
from {{ ref('fct_orders') }}
group by 1
order by 1