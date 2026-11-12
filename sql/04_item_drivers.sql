WITH latest AS (
    SELECT MAX(date) AS d FROM prices WHERE province = 'Canada'
),
items AS (
    SELECT b.product, b.quantity,
           AVG(CASE WHEN YEAR(p.date) = 2019 THEN p.price END) AS avg_2019,
           AVG(CASE WHEN p.date > DATE_SUB(l.d, INTERVAL 12 MONTH) THEN p.price END) AS avg_recent
    FROM basket b
    JOIN prices p ON p.product = b.product
    CROSS JOIN latest l
    WHERE p.province = 'Canada'
    GROUP BY b.product, b.quantity
)
SELECT product,
       ROUND(avg_2019, 2)   AS avg_2019,
       ROUND(avg_recent, 2) AS avg_last_12m,
       ROUND(100 * (avg_recent / avg_2019 - 1), 1) AS pct_change,
       ROUND((avg_recent - avg_2019) * quantity, 2) AS weekly_cost_added,
       ROUND(100 * (avg_recent - avg_2019) * quantity
             / SUM((avg_recent - avg_2019) * quantity) OVER (), 1) AS share_of_increase
FROM items
ORDER BY weekly_cost_added DESC;