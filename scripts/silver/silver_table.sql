/*
===============================================================================
 Create Tables for Silver Layer
===============================================================================
Author: Sumanth Koppula

 Description:
This script creates all necessary tables under the `silver` schema.
These tables store cleansed and transformed data coming from the `bronze` layer.
Each table includes a `dwh_create_date` timestamp to track load time.

tables Created:
- silver.crm_cust_info
- silver.crm_prd_info
- silver.crm_sales_details_info
- silver.erp_CUST_AZ12
- silver.erp_LOC_A101
- silver.erp_PX_CAT_G1V2

Run this script in `psql` or `pgAdmin` after setting up the `silver` schema.

===============================================================================
*/

--  Table: silver.crm_cust_info
DROP TABLE IF EXISTS silver.crm_cust_info;

CREATE TABLE IF NOT EXISTS silver.crm_cust_info (
    cst_id               INTEGER,
    cst_key              VARCHAR(50),
    cst_firstname        VARCHAR(50),
    cst_lastname         VARCHAR(50),
    cst_material_status  VARCHAR(50),
    cst_gndr             VARCHAR(50),
    cst_gender_date      DATE,
    cst_create_date      DATE,  -- Optional field if source data has it
    dwh_create_date      TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- ETL Load Timestamp
);

ALTER TABLE silver.crm_cust_info OWNER TO postgres;

--  Table: silver.crm_prd_info
DROP TABLE IF EXISTS silver.crm_prd_info;

CREATE TABLE IF NOT EXISTS silver.crm_prd_info (
    prd_id          INTEGER,
    cat_id          VARCHAR(50),
    prd_key         VARCHAR(50),
    prd_nm          VARCHAR(50),
    prd_cost        INTEGER,
    prd_line        VARCHAR(50),
    prd_start_dt    DATE,
    prd_end_dt      DATE,
    dwh_create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE silver.crm_prd_info OWNER TO postgres;

--  Table: silver.crm_sales_details_info
DROP TABLE IF EXISTS silver.crm_sales_details_info;

CREATE TABLE IF NOT EXISTS silver.crm_sales_details_info (
    sls_ord_num     VARCHAR(50),
    sls_prd_key     VARCHAR(50),
    sls_cust_id     INTEGER,
    sls_order_dt    DATE,
    sls_ship_dt     DATE,
    sls_due_dt      DATE,
    sls_sales       INTEGER,
    sls_quantity    INTEGER,
    sls_price       INTEGER,
    dwh_create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE silver.crm_sales_details_info OWNER TO postgres;

--  Table: silver.erp_CUST_AZ12
DROP TABLE IF EXISTS silver."erp_CUST_AZ12";

CREATE TABLE IF NOT EXISTS silver."erp_CUST_AZ12" (
    cid             VARCHAR(50),
    bdate           DATE,
    gen             VARCHAR(50),
    dwh_create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE silver."erp_CUST_AZ12" OWNER TO postgres;

--  Table: silver.erp_LOC_A101
DROP TABLE IF EXISTS silver."erp_LOC_A101";

CREATE TABLE IF NOT EXISTS silver."erp_LOC_A101" (
    cid             VARCHAR(50),
    cntry           VARCHAR(50),
    dwh_create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE silver."erp_LOC_A101" OWNER TO postgres;

--  Table: silver.erp_PX_CAT_G1V2
DROP TABLE IF EXISTS silver."erp_PX_CAT_G1V2";

CREATE TABLE IF NOT EXISTS silver."erp_PX_CAT_G1V2" (
    id              VARCHAR(50),
    cat             VARCHAR(50),
    subcat          VARCHAR(50),
    maintenance     VARCHAR(50),
    dwh_create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE silver."erp_PX_CAT_G1V2" OWNER TO postgres;
