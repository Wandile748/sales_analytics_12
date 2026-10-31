select
    category,
    count(*)                                                         as total_orders,
    sum(quantity)                                                    as units_sold,
    sum(net_amount)                                                  as net_revenue,
    sum(total_cost)                                                  as total_cost,
    {{ calculate_margin_pct('sum(net_amount)', 'sum(total_cost)') }} as margin_pct
from {{ ref('fct_orders') }}
group by 1
order by net_revenue desc