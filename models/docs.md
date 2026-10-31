{% docs net_amount %}
Order value after discount, calculated as
`quantity * list_price * (1 - discount)` and rounded to 2 decimals.
{% enddocs %}

{% docs margin_pct %}
Gross margin as a percentage of net revenue:
`(net_revenue - total_cost) / net_revenue * 100`, rounded to 1 decimal.
{% enddocs %}

{% docs customer_tier %}
Loyalty tier of the customer: gold, silver or bronze.
{% enddocs %}