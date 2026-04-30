{% macro signed_quantity(operation_col, quantity_col) %}
    case
        when upper({{ operation_col }}) = 'BUY'  then  {{ quantity_col }}
        when upper({{ operation_col }}) = 'SELL' then -{{ quantity_col }}
        else 0
    end
{% endmacro %}
