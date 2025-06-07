-- 8. ¿Cuál es el promedio de transacciones de compra y de venta por acción (campo “symbol”)?

SELECT 
    symbol,
    ROUND(AVG(CASE WHEN transaction_code = 'buy' THEN 1 ELSE 0 END), 2) AS avg_buy,
    ROUND(AVG(CASE WHEN transaction_code = 'sell' THEN 1 ELSE 0 END), 2) AS avg_sell
FROM transactions
GROUP BY symbol;