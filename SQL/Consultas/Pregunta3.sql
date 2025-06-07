-- 3. ¿Cuál es el monto promedio y el número de transacciones del mes de junio?

SELECT 
    ROUND(AVG(amount), 2) AS monto_promedio,
    COUNT(*) AS num_transacciones
FROM transactions
WHERE substr(transaction_date, 6, 2) = '06';