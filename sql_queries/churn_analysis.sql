-- Overall churn rate
SELECT 
COUNT(*) FILTER (WHERE is_active = FALSE)*100.0/COUNT(*) AS churn_rate
FROM customers;

-- Churn by company size
SELECT company_size,
COUNT(*) FILTER (WHERE is_active = FALSE)*100.0/COUNT(*) AS churn_rate
FROM customers
GROUP BY company_size;

-- Churn by signup source
SELECT signup_source,
COUNT(*) FILTER (WHERE is_active = FALSE)*100.0/COUNT(*) AS churn_rate
FROM customers
GROUP BY signup_source;

-- NPS vs churn
SELECT 
CASE 
    WHEN nps_score <= 3 THEN 'Low'
    WHEN nps_score <= 7 THEN 'Medium'
    ELSE 'High'
END AS nps_category,
COUNT(*) FILTER (WHERE is_active = FALSE) AS churned_users
FROM customers
GROUP BY nps_category;