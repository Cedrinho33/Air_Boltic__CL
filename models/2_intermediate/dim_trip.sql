WITH trip AS (
    SELECT
        *
    FROM {{ ref("src_trip") }}
),

aeroplane AS(
    SELECT
        *
    FROM {{ ref("src_aeroplane") }}

),

aeroplane_model AS(
    SELECT
        *
    FROM {{ ref("src_aeroplane_model") }}
),

city AS(
    SELECT
        *
    FROM {{ ref("src_city") }}
)

SELECT 
    -- PK
    t.trip_id,

    -- FK
    t.aeroplane_id,
    t.origin_city,
    t.destination_city,
    
    -- Dimension
    a.model,
    a.manufacturer,
    
    -- Measures
    oc.latitude AS origin_city_latitude,
    oc.longitude AS origin_city_longitude,
    oc.country AS origin_city_country,
    oc.population AS origin_city_population,

    dc.latitude AS destination_city_latitude,
    dc.longitude AS destination_city_longitude,
    dc.country AS destination_city_country,
    dc.population AS destination_city_population,

    ST_DISTANCE(
        ST_GEOGPOINT(oc.longitude, oc.latitude),
        ST_GEOGPOINT(dc.longitude, dc.latitude)
    ) / 1000 AS distance_km,

    am.max_distance,
    am.max_seats,

    -- Date & Time 
    t.start_timestamp,
    t.end_timestamp

FROM trip AS t
LEFT JOIN city AS oc ON t.origin_city = oc.city
LEFT JOIN city AS dc ON t.origin_city = dc.city
LEFT JOIN aeroplane AS a ON t.aeroplane_id = a.aeroplane_id
LEFT JOIN aeroplane_model AS am ON a.model = am.model AND a.manufacturer = am.manufacturer