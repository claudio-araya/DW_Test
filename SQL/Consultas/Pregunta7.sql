-- 7. ¿Cuál es el usuario del cliente cuya cuenta tiene entre 10 y 20 transacciones de tipo “buy”, y que presenta el promedio de inversión más alto por operación de este tipo?

SELECT ca.username, 
       ROUND(AVG(ft.amount), 2) AS promedio_inversion
FROM transactions ft
JOIN customer_account ca ON ft.account_id = ca.account_id
WHERE ft.transaction_code = 'buy'
GROUP BY ca.username, ft.account_id
HAVING COUNT(*) BETWEEN 10 AND 20
ORDER BY promedio_inversion DESC
LIMIT 1;