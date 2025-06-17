WITH aeroplane_model AS (

    SELECT
        *
    FROM {{ source('seeds', 'aeroplane_models_v2') }}

)

SELECT 
    -- PK
    manufacturer, --composite key
    model, -- composite key

    -- FK
    
    -- Dimension
    engine_type,
    
    -- Measures
    max_seats,
    max_distance,

    -- Date & Time 
  
FROM aeroplane_model