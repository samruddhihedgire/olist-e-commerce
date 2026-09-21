SELECT
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,

    COALESCE(co.total_orders, 0) AS total_orders,

    co.first_order_date,
    co.last_order_date

FROM {{ ref('stg_customers') }} c

LEFT JOIN {{ ref('int_customer_orders') }} co
    ON c.customer_id = co.customer_id