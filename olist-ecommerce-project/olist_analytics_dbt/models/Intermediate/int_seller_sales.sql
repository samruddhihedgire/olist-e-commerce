SELECT
    seller_id,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(price) AS product_revenue,

    SUM(freight_value) AS freight_revenue,

    SUM(price + freight_value) AS total_sales

FROM {{ ref('stg_order_items') }}

GROUP BY seller_id