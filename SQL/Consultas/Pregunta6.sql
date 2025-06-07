-- 6. ¿Cuál es el nombre del cliente que, en total entre todas sus cuentas, ha realizado la mayor cantidad de transacciones de tipo sell?

SELECT c.name
FROM customer c
JOIN customer_account ca ON c.username = ca.username
JOIN transactions ft ON ca.account_id = ft.account_id
WHERE ft.transaction_code = 'sell'
GROUP BY c.username
ORDER BY COUNT(*) DESC
LIMIT 1;