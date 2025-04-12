/*
===============================================================================
📦 Stored Procedure: ETL to Silver Layer
===============================================================================
Author: Sumanth Koppula

📌 Description:
This stored procedure transforms raw data from the `bronze` layer 
and loads it into cleaned `silver` tables. Business rules, data cleansing, 
and basic validation are applied during transformation.

📂 Tables Processed:
- bronze.crm_cust_info      -> silver.crm_cust_info
- bronze.crm_prd_info       -> silver.crm_prd_info
- bronze.crm_sales_details_info -> silver.crm_sales_details_info
- bronze.erp_CUST_AZ12      -> silver.erp_CUST_AZ12
- bronze.erp_LOC_A101       -> silver.erp_LOC_A101
- bronze.erp_PX_CAT_G1V2    -> silver.erp_PX_CAT_G1V2

🧪 Usage:
CALL etl_to_silver();

===============================================================================
*/

CREATE OR REPLACE PROCEDURE etl_to_silver()
LANGUAGE plpgsql
AS $$
BEGIN

-- CRM Customer Info
TRUNCATE TABLE silver.crm_cust_info;
RAISE NOTICE '>> Inserting Data Into: silver.crm_cust_info';

INSERT INTO silver.crm_cust_info (
  cst_id,
  cst_key,
  cst_firstname,
  cst_lastname,
  cst_material_status,
  cst_gndr,
  cst_gender_date
)
WITH CTE AS (
  SELECT
    cst_id,
    cst_key,
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,
    CASE
      WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'Single'
      WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'Married'
      ELSE 'n/a'
    END AS cst_material_status,
    CASE
      WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
      WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
      ELSE 'n/a'
    END AS cst_gndr,
    cst_gender_date,
    ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_gender_date DESC) AS flag_last
  FROM bronze.crm_cust_info
)
SELECT
  cst_id,
  cst_key,
  cst_firstname,
  cst_lastname,
  cst_material_status,
  cst_gndr,
  cst_gender_date
FROM CTE
WHERE flag_last = 1 AND cst_id IS NOT NULL;

-- CRM Product Info
TRUNCATE TABLE silver.crm_prd_info;
RAISE NOTICE '>> Inserting Data Into: silver.crm_prd_info';

INSERT INTO silver.crm_prd_info (
  prd_id,
  prd_key,
  cat_id,
  prd_nm,
  prd_cost,
  prd_line,
  prd_start_dt,
  prd_end_dt
)
SELECT 
  prd_id,
  SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key,
  REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
  prd_nm,
  COALESCE(prd_cost, 0) AS prd_cost,
  CASE 
    WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
    WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
    WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
    WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
    ELSE 'n/a'
  END AS prd_line,
  CAST(prd_start_dt AS DATE),
  CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info;

-- CRM Sales Details Info
TRUNCATE TABLE silver.crm_sales_details_info;
RAISE NOTICE '>> Inserting Data Into: silver.crm_sales_details_info';

INSERT INTO silver.crm_sales_details_info (
  sls_ord_num, 
  sls_prd_key, 
  sls_cust_id,
  sls_order_dt,
  sls_ship_dt,
  sls_due_dt,
  sls_sales,
  sls_quantity,
  sls_price
)
SELECT 
  sls_ord_num, 
  sls_prd_key, 
  sls_cust_id,
  CASE 
    WHEN sls_order_dt = 0 OR LENGTH(sls_order_dt::TEXT) != 8 THEN NULL
    ELSE TO_DATE(sls_order_dt::TEXT, 'YYYYMMDD') 
  END,
  CASE 
    WHEN sls_ship_dt = 0 OR LENGTH(sls_ship_dt::TEXT) != 8 THEN NULL
    ELSE TO_DATE(sls_ship_dt::TEXT, 'YYYYMMDD') 
  END,
  CASE 
    WHEN sls_due_dt = 0 OR LENGTH(sls_due_dt::TEXT) != 8 THEN NULL
    ELSE TO_DATE(sls_due_dt::TEXT, 'YYYYMMDD') 
  END,
  CASE 
    WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
    THEN sls_quantity * ABS(sls_price)
    ELSE sls_sales
  END,
  sls_quantity,
  CASE 
    WHEN sls_price IS NULL OR sls_sales <= 0 
    THEN sls_sales / NULLIF(sls_quantity, 0)
    ELSE sls_price
  END
FROM bronze.crm_sales_details_info;

-- ERP Customer Info
TRUNCATE TABLE silver."erp_CUST_AZ12";
RAISE NOTICE '>> Inserting Data Into: silver.erp_CUST_AZ12';

INSERT INTO silver."erp_CUST_AZ12" (cid, bdate, gen)
SELECT  
  CASE 
    WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LENGTH(cid)) 
    ELSE cid 
  END,
  CASE 
    WHEN bdate > CURRENT_DATE THEN NULL
    ELSE bdate 
  END,
  CASE 
    WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
    WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
    ELSE 'n/a' 
  END
FROM bronze."erp_CUST_AZ12";

-- ERP Location Info
TRUNCATE TABLE silver."erp_LOC_A101";
RAISE NOTICE '>> Inserting Data Into: silver.erp_LOC_A101';

INSERT INTO silver."erp_LOC_A101" (cid, cntry)
SELECT 
  REPLACE(cid, '-', ''),
  CASE 
    WHEN TRIM(cntry) = 'DE' THEN 'Dubai'
    WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
    WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
    ELSE TRIM(cntry)
  END
FROM bronze."erp_LOC_A101";

-- ERP Product Category
TRUNCATE TABLE silver."erp_PX_CAT_G1V2";
RAISE NOTICE '>> Inserting Data Into: silver.erp_PX_CAT_G1V2';

INSERT INTO silver."erp_PX_CAT_G1V2" (id, cat, subcat, maintenance)
SELECT id, cat, subcat, maintenance
FROM bronze."erp_PX_CAT_G1V2";

END;
$$;
