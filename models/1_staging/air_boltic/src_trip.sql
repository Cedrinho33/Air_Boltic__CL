WITH trip AS (

    SELECT
        *
    FROM {{ source('air_boltic', 'trip') }}

)

SELECT 
    -- PK
    trip_id,

    -- FK
    aeroplane_id,
    origin_city,
    destination_city,
    
    -- Dimension

    -- Measures

    -- Date & Time 
    start_timestamp,
    end_timestamp

FROM trip