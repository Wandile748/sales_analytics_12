-- Returns rows (= failures) when any order has a net amount of zero or less.
select
    order_id,
    net_amount
from {{ ref('fct_orders') }}
where net_amount <= 0