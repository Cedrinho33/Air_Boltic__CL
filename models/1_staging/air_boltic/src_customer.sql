WITH customer AS (

    SELECT
        *
    FROM {{ source('air_boltic', 'customer') }}

)

SELECT 
    -- PK
    customer_id,

    -- FK
    customer_group_id

    -- Dimension

    -- Measures

    -- Date & Time

FROM customer