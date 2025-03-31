{% macro publish() %}
    {% set sql %}
        CREATE OR REPLACE TABLE dbt_green.fact_matches_atp AS SELECT * FROM dbt_blue.fact_matches_atp;

    {% endset %}

    {%- if target.name == 'green' -%}
        {% do log("Merging into green environmet...", info=True) %}
        {% do run_query(sql) %}
        {% do log("Merge into green environmet done", info=True) %}
    {%- else -%}
        {% do exceptions.warn("[WARNING]: Target schema is not green") %}
    {%- endif -%}
{% endmacro %}