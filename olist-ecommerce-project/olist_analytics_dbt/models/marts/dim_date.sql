WITH RECURSIVE date_series AS (

    SELECT
        MIN(DATE(order_purchase_timestamp)) AS date_day
    FROM {{ ref('stg_orders') }}

    UNION ALL

    SELECT
        DATE_ADD(
            date_day,
            INTERVAL 1 DAY
        )
    FROM date_series
    WHERE date_day < (
        SELECT MAX(DATE(order_purchase_timestamp))
        FROM {{ ref('stg_orders') }}
    )

)

SELECT
    date_day AS date,
    YEAR(date_day) AS year,
    MONTH(date_day) AS month,
    MONTHNAME(date_day) AS month_name,
    QUARTER(date_day) AS quarter,
    DAY(date_day) AS day

FROM date_series