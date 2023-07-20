WITH customers AS (

    SELECT
        id AS customer_id,
        first_name,
        last_name

    FROM dbt-tutorial-raw-data.jaffle_shop.raw_customers

)

SELECT * FROM customers