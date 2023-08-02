WITH payments AS (

    SELECT
        id AS payment_id,
        order_id,
        payment_method,
        "accepted" AS status,

        -- amount is stored in cents, convert it to dollars
        {{cents_to_dollars('amount',4)}} AS amount,

    FROM {{ source('stripe', 'raw_payments') }}

)

SELECT * FROM payments