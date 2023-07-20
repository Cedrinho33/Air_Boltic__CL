WITH orders AS (

    SELECT
        id AS order_id,
        user_id AS customer_id,
        order_date,
        status

    FROM dbt-tutorial-raw-data.jaffle_shop.raw_orders

)

SELECT * FROM orders