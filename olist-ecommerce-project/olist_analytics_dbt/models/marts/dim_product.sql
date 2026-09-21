SELECT
    p.product_id,
    p.product_category_name,
    ct.product_category_name_english,

    p.product_name_lenght,
    p.product_description_lenght,
    p.product_photos_qty,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,

    COALESCE(ps.total_orders, 0) AS total_orders,
    COALESCE(ps.product_revenue, 0) AS product_revenue,
    COALESCE(ps.total_freight, 0) AS total_freight,
    COALESCE(ps.total_sales, 0) AS total_sales

FROM {{ ref('stg_products') }} p

LEFT JOIN {{ ref('stg_category_translation') }} ct
    ON p.product_category_name = ct.product_category_name

LEFT JOIN {{ ref('int_product_sales') }} ps
    ON p.product_id = ps.product_id