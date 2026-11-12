USE grocery;

WITH monthly AS (
    SELECT p.date, SUM(p.price * b.quantity) AS basket_cost
    FROM prices p
    JOIN basket b ON p.product = b.product
    WHERE p.province = 'Canada'
    GROUP BY p.date
    HAVING COUNT(*) = (SELECT COUNT(*) FROM basket)
)
SELECT
    ROUND(b.basket_cost, 2)                          AS weekly_jan_2019,
    ROUND(l.basket_cost, 2)                          AS weekly_latest,
    l.date                                           AS latest_month,
    ROUND(l.basket_cost - b.basket_cost, 2)          AS weekly_increase,
    ROUND((l.basket_cost - b.basket_cost) * 52, 2)   AS yearly_increase,
    ROUND(100 * (l.basket_cost / b.basket_cost - 1), 1) AS pct_increase
FROM monthly b
JOIN monthly l ON l.date = (SELECT MAX(date) FROM monthly)
WHERE b.date = '2019-01-01';