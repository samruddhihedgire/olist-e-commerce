SELECT
    o.customer_id,

    COUNT(DISTINCT o.order_id) AS total_orders,

    MIN(o.order_purchase_timestamp) AS first_order_date,

    MAX(o.order_purchase_timestamp) AS last_order_date

FROM {{ ref('stg_orders') }} o

GROUP BY o.customer_id