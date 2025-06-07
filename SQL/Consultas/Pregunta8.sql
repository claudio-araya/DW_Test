-- 8. ¿Cuál es el promedio de transacciones de compra y de venta por acción (campo “symbol”)?

SELECT
    ROUND(AVG(buy_count), 2) AS promedio_buy,
    ROUND(AVG(sell_count), 2) AS promedio_sell
FROM (
    SELECT
        symbol,
        COUNT(CASE WHEN transaction_code = 'buy' THEN 1 END) AS buy_count,
        COUNT(CASE WHEN transaction_code = 'sell' THEN 1 END) AS sell_count
    FROM transactions
    GROUP BY symbol
)