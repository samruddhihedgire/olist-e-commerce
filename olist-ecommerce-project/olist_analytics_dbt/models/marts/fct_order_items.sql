SELECT
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,

    oi.shipping_limit_date,
    oi.price,
    oi.freight_value,

    oi.price + oi.freight_value AS total_item_value,

    p.product_category_name,
    p.product_category_name_english,

    s.seller_city,
    s.seller_state

FROM {{ ref('stg_order_items') }} oi

LEFT JOIN {{ ref('dim_product') }} p
    ON oi.product_id = p.product_id

LEFT JOIN {{ ref('dim_seller') }} s
    ON oi.seller_id = s.seller_id