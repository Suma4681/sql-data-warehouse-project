/*
===============================================================================
🎯 Quality Checks - Silver Layer
===============================================================================
This PostgreSQL script checks for:
  - Null or duplicate primary keys
  - Unwanted spaces in string fields
  - Data standardization and formatting
  - Invalid date ranges
  - Data integrity across sales fields
===============================================================================
*/

-- ====================================================================
-- ✅ silver.crm_cust_info
-- ====================================================================

-- Null or Duplicate cst_id
SELECT cst_id, COUNT(*) 
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Unwanted spaces in cst_key
SELECT cst_key 
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Marital status standardization
SELECT DISTINCT cst_material_status 
FROM silver.crm_cust_info;

-- ====================================================================
-- ✅ silver.crm_prd_info
-- ====================================================================

-- Null or Duplicate prd_id
SELECT prd_id, COUNT(*) 
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Trim check on product name
SELECT prd_nm 
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Negative or Null product cost
SELECT prd_cost 
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0;

-- Distinct product lines
SELECT DISTINCT prd_line 
FROM silver.crm_prd_info;

-- Start date should not be after end date
SELECT * 
FROM silver.crm_prd_info
WHERE prd_end_dt IS NOT NULL AND prd_start_dt > prd_end_dt;

-- ====================================================================
-- ✅ silver.crm_sales_details_info
-- ====================================================================

-- Check date order (Order vs Ship vs Due)
SELECT * 
FROM silver.crm_sales_details_info
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

-- Sales consistency (sales = quantity * price)
SELECT DISTINCT sls_sales, sls_quantity, sls_price 
FROM silver.crm_sales_details_info
WHERE sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL 
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0 
   OR sls_sales != sls_quantity * sls_price
ORDER BY sls_sales, sls_quantity, sls_price;

-- ====================================================================
-- ✅ silver.erp_CUST_AZ12
-- ====================================================================

-- Out-of-range birth dates
SELECT bdate 
FROM silver."erp_CUST_AZ12"
WHERE bdate < DATE '1924-01-01' OR bdate > CURRENT_DATE;

-- Gender standardization
SELECT DISTINCT gen 
FROM silver."erp_CUST_AZ12";

-- ====================================================================
-- ✅ silver.erp_LOC_A101
-- ====================================================================

-- Country values
SELECT DISTINCT cntry 
FROM silver."erp_LOC_A101"
ORDER BY cntry;

-- ====================================================================
-- ✅ silver.erp_PX_CAT_G1V2
-- ====================================================================

-- Trim check on category fields
SELECT * 
FROM silver."erp_PX_CAT_G1V2"
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat) 
   OR maintenance != TRIM(maintenance);

-- Maintenance values
SELECT DISTINCT maintenance 
FROM silver."erp_PX_CAT_G1V2";

-- ✅ END
