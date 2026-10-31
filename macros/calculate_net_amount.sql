{% macro calculate_net_amount(quantity, unit_price, discount) %}
    round({{ quantity }} * {{ unit_price }} * (1 - {{ discount }}), 2)
{% endmacro %}