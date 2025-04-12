/*
===============================================
Bronze Layer Tables: Data Warehouse Raw Stage
===============================================
This script creates all raw staging (bronze) tables
used for initial ingestion from source CSV files.

Schema: bronze

*/

-- =========================================================
--  Table: bronze.crm_cust_info
-- Raw customer info from CRM system
-- Source: cust_info.csv
-- =========================================================
DROP TABLE IF EXISTS bronze.crm_cust_info;

CREATE TABLE IF NOT EXISTS bronze.crm_cust_info (
    cst_id INTEGER,
    cst_key VARCHAR(50),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_material_status VARCHAR(50),
    cst_gndr VARCHAR(50),
    cst_gender_date DATE
);

-- =========================================================
-- Table: bronze.crm_prd_info
-- Raw product info
-- Source: prd_info.csv
-- =========================================================
DROP TABLE IF EXISTS bronze.crm_prd_info;

CREATE TABLE IF NOT EXISTS bronze.crm_prd_info (
    prd_id INTEGER,
    prd_key VARCHAR(50),
    prd_nm VARCHAR(50),
    prd_cost INTEGER,
    prd_line VARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE
);

-- =========================================================
-- Table: bronze.crm_sales_details_info
-- Raw sales order info
-- Source: sales_details.csv
-- =========================================================
DROP TABLE IF EXISTS bronze.crm_sales_details_info;

CREATE TABLE IF NOT EXISTS bronze.crm_sales_details_info (
    sls_ord_num VARCHAR(50),
    sls_prd_key VARCHAR(50),
    sls_cust_id INTEGER,
    sls_order_dt INTEGER,
    sls_ship_dt INTEGER,
    sls_due_dt INTEGER,
    sls_sales INTEGER,
    sls_quantity INTEGER,
    sls_price INTEGER
);

-- =========================================================
--Table: bronze."erp_CUST_AZ12"
-- ERP Customer Master Data
-- Source: cust_info.csv
-- =========================================================
DROP TABLE IF EXISTS bronze."erp_CUST_AZ12";

CREATE TABLE IF NOT EXISTS bronze."erp_CUST_AZ12" (
    cid VARCHAR(50),
    bdate DATE,
    gen VARCHAR(50)
);

-- =========================================================
-- Table: bronze."erp_LOC_A101"
-- ERP Location Info
-- Source: location.csv
-- =========================================================
DROP TABLE IF EXISTS bronze."erp_LOC_A101";

CREATE TABLE IF NOT EXISTS bronze."erp_LOC_A101" (
    cid VARCHAR(50),
    cntry VARCHAR(50)
);

-- =========================================================
-- Table: bronze."erp_PX_CAT_G1V2"
-- ERP Product Category Mapping
-- Source: category.csv
-- =========================================================
DROP TABLE IF EXISTS bronze."erp_PX_CAT_G1V2";

CREATE TABLE IF NOT EXISTS bronze."erp_PX_CAT_G1V2" (
    id VARCHAR(50),
    cat VARCHAR(50),
    subcat VARCHAR(50),
    maintenance VARCHAR(50)
);
