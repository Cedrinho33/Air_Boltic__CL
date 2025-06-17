WITH orders AS (

    SELECT
        *
    FROM {{ source('air_boltic', 'orders') }}

)

SELECT 
    -- PK
    order_id,

    -- FK
    customer_id,
    trip_id,

    -- Dimension
    seat_number,
    status, -- SCD, log would be helpful

    -- Measures
    price_eur,

    -- Date & Time

FROM orders