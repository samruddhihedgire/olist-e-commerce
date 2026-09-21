SELECT
    product_id,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(price) AS product_revenue,

    SUM(freight_value) AS total_freight,

    SUM(price + freight_value) AS total_sales

FROM {{ ref('stg_order_items') }}

GROUP BY product_id