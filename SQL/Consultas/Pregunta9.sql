-- 9. ¿Cuáles son los diferentes beneficios que tienen los clientes del tier “Gold”?

SELECT DISTINCT b.benefit_name
FROM tier t
JOIN tier_benefit tb ON t.tier_id = tb.tier_id
JOIN benefit b ON tb.benefit_name = b.benefit_name
WHERE t.tier_name = 'Gold' AND t.active = 1;