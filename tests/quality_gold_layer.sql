/*
===============================================================================
🎯 Quality Checks - Gold Layer
===============================================================================
Script Purpose:
    This script validates the integrity, uniqueness, and connectivity 
    of data across the Gold Layer tables. It focuses on:
      - Surrogate key uniqueness in dimension tables
      - Referential integrity between fact and dimensions
      - Ensuring clean analytical joins across the star schema

Usage Notes:
    - Run after gold layer ETL process
    - Any output rows indicate potential issues to be investigated
===============================================================================
*/

-- ====================================================================
-- ✅ gold.dim_customers
-- ====================================================================

-- 🔍 Check for duplicate customer keys
-- Expectation: No rows should be returned
SELECT customer_key, COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- ✅ gold.dim_products
-- ====================================================================

-- 🔍 Check for duplicate product keys
-- Expectation: No rows should be returned
SELECT product_key, COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- ✅ gold.fact_sales
-- ====================================================================

-- 🔍 Validate foreign keys in fact table reference dimension tables
-- Expectation: No NULLs in dimension keys (broken foreign key relationships)
SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON f.customer_key = c.customer_key
LEFT JOIN gold.dim_products p ON f.product_key = p.product_key
WHERE c.customer_key IS NULL OR p.product_key IS NULL;

-- 🔍 Check for any NULLs in key business metrics
-- Expectation: No NULLs or negative values in sales-related fields
SELECT *
FROM gold.fact_sales
WHERE sales_amount IS NULL OR price IS NULL OR sales_quantity IS NULL
   OR sales_amount <= 0 OR price <= 0 OR sales_quantity <= 0;

-- ✅ END
