SELECT
    s.seller_id,
    s.seller_zip_code_prefix,
    s.seller_city,
    s.seller_state,

    COALESCE(ss.total_orders, 0) AS total_orders,
    COALESCE(ss.product_revenue, 0) AS product_revenue,
    COALESCE(ss.freight_revenue, 0) AS freight_revenue,
    COALESCE(ss.total_sales, 0) AS total_sales

FROM {{ ref('stg_sellers') }} s

LEFT JOIN {{ ref('int_seller_sales') }} ss
    ON s.seller_id = ss.seller_id