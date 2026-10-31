-- Returns rows (= failures) when a category sells at a loss.
select
    category,
    margin_pct
from {{ ref('mart_category_performance') }}
where margin_pct < 0