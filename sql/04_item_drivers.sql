WITH latest AS (
    SELECT MAX(date) AS d FROM prices WHERE province = 'Canada'
),
items AS (
    SELECT b.product, b.quantity,
           MAX(CASE WHEN p.date = '2019-01-01' THEN p.price END) AS price_2019,
           MAX(CASE WHEN p.date = (SELECT d FROM latest) THEN p.price END) AS price_now
    FROM basket b
    JOIN prices p ON p.product = b.product
    WHERE p.province = 'Canada'
    GROUP BY b.product, b.quantity
)
SELECT product,
       price_2019,
       price_now,
       ROUND(100 * (price_now / price_2019 - 1), 1) AS pct_change,
       ROUND((price_now - price_2019) * quantity, 2) AS weekly_cost_added,
       ROUND(100 * (price_now - price_2019) * quantity
             / SUM((price_now - price_2019) * quantity) OVER (), 1) AS share_of_increase
FROM items
ORDER BY weekly_cost_added DESC;