WITH trip AS (
    SELECT
        *
    FROM {{ ref("dim_trip") }}
),

orders AS(
    SELECT
        trip_id,
        SUM(price_eur) AS revenue,
        COUNT(DISTINCT seat_number) AS seats_booked
    FROM {{ ref("src_order") }}
    WHERE status != "Cancelled"
    GROUP BY 1
)


SELECT 
    -- PK
    t.trip_id,

    -- FK
    t.aeroplane_id,
    t.origin_city,
    t.destination_city,
    
    -- Dimension
    t.model,
    t.manufacturer,
    
    -- Measures
    t.origin_city_latitude,
    t.origin_city_longitude,
    t.origin_city_country,
    t.origin_city_population,

    t.destination_city_latitude,
    t.destination_city_longitude,
    t.destination_city_country,
    t.destination_city_population,

    t.distance_km,

    t.max_distance,
    t.max_seats,

    -- Date & Time 
    t.start_timestamp,
    t.end_timestamp

FROM trip AS t
LEFT JOIN orders AS o ON t.trip_id = o.trip_id