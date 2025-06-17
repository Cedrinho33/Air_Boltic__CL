WITH city AS (

    SELECT
        *
    FROM {{ source('seeds', 'cities') }}

)

SELECT 
    -- PK
    city_ascii AS city,

    -- FK
    
    -- Dimension
    country,

    -- Measures
    SAFE_CAST(lat AS FLOAT64) AS latitude,
    SAFE_CAST(lng AS FLOAT64) AS longitude,
    SAFE_CAST(
        CASE 
            WHEN population = '' OR LOWER(population) = 'popupulation' THEN '0'
            ELSE population
        END AS INT64
    ) AS population

    -- Date & Time 

FROM city