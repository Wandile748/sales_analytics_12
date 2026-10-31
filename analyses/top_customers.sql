select
    customer_name,
    region,
    tier,
    sum(net_amount) as net_revenue
from {{ ref('fct_orders') }}
group by 1, 2, 3
order by net_revenue desc
limit 5