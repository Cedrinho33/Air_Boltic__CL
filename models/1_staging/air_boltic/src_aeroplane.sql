WITH customer AS (

    SELECT
        *
    FROM {{ source('air_boltic', 'aeroplane') }}

)

SELECT 
    -- PK
    aeroplane_id,

    -- FK
    model,

    -- Dimension
    manufacturer,

    -- Measures

    -- Date & Time

FROM customer