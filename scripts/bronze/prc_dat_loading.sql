/*
===============================================================================
 Stored Procedure: load_bronze_data
===============================================================================
Purpose:
    - Load data into the 'bronze' schema from local CSV files
    - Clean tables (TRUNCATE) before loading
    - Logs duration of each step
    - Captures and prints errors if any

Author: Sumanth Koppula
===============================================================================
*/

DO $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    batch_start_time TIMESTAMP := clock_timestamp();
    batch_end_time TIMESTAMP;
BEGIN
    RAISE NOTICE '================================================';
    RAISE NOTICE 'Starting Bronze Layer Load';
    RAISE NOTICE '================================================';

    -- ===========================
    -- CRM TABLES
    -- ===========================

    -- CRM: Customer Info
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;

    RAISE NOTICE '>> Loading: bronze.crm_cust_info';
    COPY bronze.crm_cust_info
    FROM '/Users/skoppula/Downloads/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
    WITH (FORMAT csv, HEADER true);
    end_time := clock_timestamp();
    RAISE NOTICE '>> Duration: % seconds', EXTRACT(SECOND FROM end_time - start_time);

    -- CRM: Product Info
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating: bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;

    RAISE NOTICE '>> Loading: bronze.crm_prd_info';
    COPY bronze.crm_prd_info
    FROM '/Users/skoppula/Downloads/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
    WITH (FORMAT csv, HEADER true);
    end_time := clock_timestamp();
    RAISE NOTICE '>> Duration: % seconds', EXTRACT(SECOND FROM end_time - start_time);

    -- CRM: Sales Details
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating: bronze.crm_sales_details_info';
    TRUNCATE TABLE bronze.crm_sales_details_info;

    RAISE NOTICE '>> Loading: bronze.crm_sales_details_info';
    COPY bronze.crm_sales_details_info
    FROM '/Users/skoppula/Downloads/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
    WITH (FORMAT csv, HEADER true);
    end_time := clock_timestamp();
    RAISE NOTICE '>> Duration: % seconds', EXTRACT(SECOND FROM end_time - start_time);


    -- ===========================
    -- ERP TABLES
    -- ===========================

    -- ERP: CUST_AZ12
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating: bronze."erp_CUST_AZ12"';
    TRUNCATE TABLE bronze."erp_CUST_AZ12";

    RAISE NOTICE '>> Loading: bronze."erp_CUST_AZ12"';
    COPY bronze."erp_CUST_AZ12"
    FROM '/Users/skoppula/Downloads/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv'
    WITH (FORMAT csv, HEADER true);
    end_time := clock_timestamp();
    RAISE NOTICE '>> Duration: % seconds', EXTRACT(SECOND FROM end_time - start_time);

    -- ERP: LOC_A101
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating: bronze."erp_LOC_A101"';
    TRUNCATE TABLE bronze."erp_LOC_A101";

    RAISE NOTICE '>> Loading: bronze."erp_LOC_A101"';
    COPY bronze."erp_LOC_A101"
    FROM '/Users/skoppula/Downloads/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv'
    WITH (FORMAT csv, HEADER true);
    end_time := clock_timestamp();
    RAISE NOTICE '>> Duration: % seconds', EXTRACT(SECOND FROM end_time - start_time);

    -- ERP: PX_CAT_G1V2
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating: bronze."erp_PX_CAT_G1V2"';
    TRUNCATE TABLE bronze."erp_PX_CAT_G1V2";

    RAISE NOTICE '>> Loading: bronze."erp_PX_CAT_G1V2"';
    COPY bronze."erp_PX_CAT_G1V2"
    FROM '/Users/skoppula/Downloads/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv'
    WITH (FORMAT csv, HEADER true);
    end_time := clock_timestamp();
    RAISE NOTICE '>> Duration: % seconds', EXTRACT(SECOND FROM end_time - start_time);

    --  Completion Summary
    batch_end_time := clock_timestamp();
    RAISE NOTICE '==========================================';
    RAISE NOTICE 'Bronze Layer Load Completed Successfully';
    RAISE NOTICE 'Total Duration: % seconds', EXTRACT(SECOND FROM batch_end_time - batch_start_time);
    RAISE NOTICE '==========================================';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error Occurred: %', SQLERRM;
END $$;
