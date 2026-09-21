WITH payment_summary AS (

    SELECT
        order_id,
        SUM(payment_value) AS total_payment_value,
        MAX(payment_type) AS payment_type
    FROM {{ ref('stg_order_payments') }}
    GROUP BY order_id

),

review_summary AS (

    SELECT
        order_id,
        AVG(review_score) AS review_score
    FROM {{ ref('stg_order_reviews') }}
    GROUP BY order_id

)

SELECT
    o.order_id,
    o.customer_id,
    o.order_status,

    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,

    d.delivery_days,
    d.delay_days,
    d.is_late,

    COALESCE(p.total_payment_value, 0) AS total_payment_value,
    p.payment_type,

    r.review_score

FROM {{ ref('stg_orders') }} o

LEFT JOIN {{ ref('int_delivery_metrics') }} d
    ON o.order_id = d.order_id

LEFT JOIN payment_summary p
    ON o.order_id = p.order_id

LEFT JOIN review_summary r
    ON o.order_id = r.order_id