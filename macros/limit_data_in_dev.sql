{% macro limit_data_in_dev(column_name, dev_days_of_data=3) %}
{% if target.name == 'default' %}
where date_diff(current_date(), {{column_name}}, DAY) <= {{dev_days_of_data}}
{% endif %}
{% endmacro %}