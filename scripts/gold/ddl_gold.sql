/*
=====================================================
🎯 Gold Layer Creation Script - Star Schema Model
=====================================================
This script creates the dimension and fact tables 
under the 'gold' schema using data from the silver layer.
It is designed for analytical and reporting use cases.

Author: Sumanth Koppula
*/

-- ✅ Create Schema if not exists
CREATE SCHEMA IF NOT EXISTS gold;

-- ================================
-- 📘 DIMENSION: Customers
-- ================================
DROP VIEW IF EXISTS gold.dim_customers;

CREATE VIEW gold.dim_customers AS
SELECT 
  ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
  ci.cst_id AS customer_id,
  ci.cst_key AS customer_number,
  ci.cst_firstname AS first_name,
  ci.cst_lastname AS last_name,
  la.cntry AS country,
  ci.cst_material_status AS martial_status,
  CASE 
    WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
    ELSE COALESCE(ca.gen, 'n/a')
  END AS gender,
  ca.bdate AS birth_date,
  ci.cst_gender_date AS create_date
FROM silver.crm_cust_info AS ci
LEFT JOIN silver."erp_CUST_AZ12" AS ca 
  ON ci.cst_key = ca.cid
LEFT JOIN silver."erp_LOC_A101" AS la
  ON ci.cst_key = la.cid;

-- ================================
-- 📘 DIMENSION: Products
-- ================================
DROP VIEW IF EXISTS gold.dim_products;

CREATE VIEW gold.dim_products AS
SELECT 
  ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
  pn.prd_id AS product_id,
  pn.prd_key AS product_number,
  pn.prd_nm AS product_name,
  pn.cat_id AS category_id,
  pc.cat AS category,
  pc.subcat AS subcategory,
  pc.maintenance,
  pn.prd_cost AS cost,
  pn.prd_line AS product_line,
  pn.prd_start_dt AS start_date
FROM silver.crm_prd_info AS pn
LEFT JOIN silver."erp_PX_CAT_G1V2" AS pc
  ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL;  -- filter historical data

-- ================================
-- 📊 FACT TABLE: Sales
-- ================================
DROP VIEW IF EXISTS gold.fact_sales;

CREATE VIEW gold.fact_sales AS
SELECT 
  sd.sls_ord_num AS order_number,
  pr.product_key,
  cu.customer_key,
  sd.sls_order_dt AS order_date,
  sd.sls_ship_dt AS shipping_date,
  sd.sls_due_dt AS due_date,
  sd.sls_sales AS sales_amount,
  sd.sls_quantity AS sales_quantity,
  sd.sls_price AS price
FROM silver.crm_sales_details_info AS sd
LEFT JOIN gold.dim_products AS pr
  ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers AS cu
  ON sd.sls_cust_id = cu.customer_id;

-- ✅ End of Script
