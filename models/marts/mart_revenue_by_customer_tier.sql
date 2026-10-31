select
    tier,
    count(distinct customer_id)                                      as customers,
    count(*)                                                         as total_orders,
    sum(net_amount)                                                  as net_revenue,
    {{ calculate_margin_pct('sum(net_amount)', 'sum(total_cost)') }} as margin_pct
from {{ ref('fct_orders') }}
group by 1
order by net_revenue desc