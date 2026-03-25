
-- SQL Data Cleaning Script for NimbusAI

-- 1. Remove duplicate customers (keep latest record)
DELETE FROM nimbus.customers a
USING nimbus.customers b
WHERE a.ctid < b.ctid
AND a.customer_id = b.customer_id;

-- 2. Handle NULL values in company_size
UPDATE nimbus.customers
SET company_size = 'unknown'
WHERE company_size IS NULL OR company_size = '';

-- 3. Handle NULL values in signup_source
UPDATE nimbus.customers
SET signup_source = 'unknown'
WHERE signup_source IS NULL OR signup_source = '';

-- 4. Standardize boolean values (ensure consistency)
-- Convert NULL is_active to FALSE (assume churned if unknown)
UPDATE nimbus.customers
SET is_active = FALSE
WHERE is_active IS NULL;

-- 5. Clean NPS score (ensure valid range 0–10)
UPDATE nimbus.customers
SET nps_score = NULL
WHERE nps_score < 0 OR nps_score > 10;

-- 6. Remove records with missing customer_id
DELETE FROM nimbus.customers
WHERE customer_id IS NULL;

-- 7. Trim whitespace from text fields
UPDATE nimbus.customers
SET 
    company_size = TRIM(company_size),
    signup_source = TRIM(signup_source);

-- 8. Create cleaned view for analysis
CREATE OR REPLACE VIEW nimbus.cleaned_customers AS
SELECT *
FROM nimbus.customers;

-- Done
SELECT 'Data cleaning completed successfully' AS status;