USE grocery;

WITH monthly AS (
    SELECT p.date, SUM(p.price * b.quantity) AS basket_cost
    FROM prices p
    JOIN basket b ON p.product = b.product
    WHERE p.province = 'Canada'
    GROUP BY p.date
    HAVING COUNT(*) = (SELECT COUNT(*) FROM basket)
),
latest AS (SELECT MAX(date) AS d FROM monthly),
periods AS (
    SELECT AVG(CASE WHEN YEAR(m.date) = 2019 THEN m.basket_cost END) AS avg_2019,
           AVG(CASE WHEN m.date > DATE_SUB(l.d, INTERVAL 12 MONTH) THEN m.basket_cost END) AS avg_recent
    FROM monthly m CROSS JOIN latest l
)
SELECT ROUND(avg_2019, 2)                      AS avg_weekly_2019,
       ROUND(avg_recent, 2)                    AS avg_weekly_last_12m,
       ROUND(avg_recent - avg_2019, 2)         AS weekly_increase,
       ROUND((avg_recent - avg_2019) * 52, 2)  AS yearly_increase,
       ROUND(100 * (avg_recent / avg_2019 - 1), 1) AS pct_increase
FROM periods;