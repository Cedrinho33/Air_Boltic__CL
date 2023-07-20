WITH orders as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from dbt-tutorial-raw-data.jaffle_shop.raw_orders

),

SELECT * FROM orders