WITH customers as (

    SELECT
        id as customer_id,
        first_name,
        last_name

    from dbt-tutorial-raw-data.jaffle_shop.raw_customers

),

SELECT * from customers