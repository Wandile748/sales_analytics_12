{% macro calculate_margin_pct(revenue, cost) %}
    round((({{ revenue }}) - ({{ cost }})) / nullif(({{ revenue }}), 0) * 100, 1)
{% endmacro %}