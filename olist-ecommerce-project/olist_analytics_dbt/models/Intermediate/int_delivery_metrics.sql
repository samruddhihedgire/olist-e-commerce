SELECT
    order_id,
    order_purchase_timestamp,
    order_delivered_customer_date,
    order_estimated_delivery_date,

    DATEDIFF(
        order_delivered_customer_date,
        order_purchase_timestamp
    ) AS delivery_days,

    DATEDIFF(
        order_delivered_customer_date,
        order_estimated_delivery_date
    ) AS delay_days,

    CASE
        WHEN order_delivered_customer_date >
             order_estimated_delivery_date
        THEN 1
        ELSE 0
    END AS is_late

FROM {{ ref('stg_orders') }}

WHERE order_delivered_customer_date IS NOT NULL