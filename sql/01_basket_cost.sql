USE grocery;

SELECT p.date,
       ROUND(SUM(p.price * b.quantity), 2) AS basket_cost,
       COUNT(*) AS items_priced
FROM prices p
JOIN basket b ON p.product = b.product
WHERE p.province = 'Canada'
GROUP BY p.date
HAVING COUNT(*) = (SELECT COUNT(*) FROM basket)
ORDER BY p.date;