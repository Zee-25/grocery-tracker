WITH monthly AS (
    SELECT p.date,
           SUM(p.price * b.quantity) AS basket_cost
    FROM prices p
    JOIN basket b ON p.product = b.product
    WHERE p.province = 'Canada'
    GROUP BY p.date
    HAVING COUNT(*) = (SELECT COUNT(*) FROM basket)
)
SELECT date,
       ROUND(basket_cost, 2) AS basket_cost,
       ROUND(LAG(basket_cost, 12) OVER (ORDER BY date), 2) AS cost_year_ago,
       ROUND(100 * (basket_cost / LAG(basket_cost, 12) OVER (ORDER BY date) - 1), 1) AS yoy_pct
FROM monthly
ORDER BY date;