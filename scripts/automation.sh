#!/bin/bash

################################################################################
# 🚀 End-to-End ETL Shell Script for Data Warehouse Project
# ------------------------------------------------------------------------------
# Author: Sumanth Koppula
# Description:
#   Automates the entire ETL pipeline: DB setup → Bronze → Silver → Gold Layers
#   + Quality checks on Silver and Gold Layers.
#
# Requirements:
#   - PostgreSQL installed and accessible via CLI
#   - Assumes datasets and SQL scripts exist in appropriate folders
#   - Run permission: Use `chmod +x automation/run_etl_pipeline.sh`
################################################################################

echo "======================================"
echo "🚀 Starting End-to-End ETL Pipeline..."
echo "======================================"

# Define file paths
DB_INIT_SCRIPT="scripts/silver/init_database.sql"
BRONZE_DDL_SCRIPT="scripts/bronze/DDL_Bronze.sql"
BRONZE_LOAD_PROC="scripts/bronze/prc_dat_loading.sql"
SILVER_TABLE_SCRIPT="scripts/silver/silver_table.sql"
SILVER_ETL_SCRIPT="scripts/silver/etl_silver.sql"
GOLD_VIEW_SCRIPT="scripts/gold/ddl_gold.sql"
QUALITY_SILVER="tests/quality_silver_layer.sql"
QUALITY_GOLD="tests/quality_gold_layer.sql"

# Step 1: Create DB and Schemas
echo "✅ Step 1: Creating database and schemas..."
psql -U postgres -f $DB_INIT_SCRIPT

# Step 2: Create Bronze Tables
echo "✅ Step 2: Creating bronze layer tables..."
psql -U postgres -d datawarehouse -f $BRONZE_DDL_SCRIPT

# Step 3: Load Bronze Layer Data
echo "✅ Step 3: Loading data into bronze layer..."
psql -U postgres -d datawarehouse -f $BRONZE_LOAD_PROC

# Step 4: Create Silver Tables
echo "✅ Step 4: Creating silver tables..."
psql -U postgres -d datawarehouse -f $SILVER_TABLE_SCRIPT

# Step 4.1: Transform from Bronze → Silver
echo "✅ Step 4.1: Running ETL transformation to silver layer..."
psql -U postgres -d datawarehouse -f $SILVER_ETL_SCRIPT

# Step 5: Create Gold Layer Views
echo "✅ Step 5: Creating gold layer views..."
psql -U postgres -d datawarehouse -f $GOLD_VIEW_SCRIPT

# Step 6: Run Data Quality Checks
echo "✅ Step 6: Running data quality checks on silver layer..."
psql -U postgres -d datawarehouse -f $QUALITY_SILVER

echo "✅ Step 6.1: Running data quality checks on gold layer..."
psql -U postgres -d datawarehouse -f $QUALITY_GOLD

echo "======================================"
echo "🎉 ETL Pipeline Execution Completed Successfully!"
echo "======================================"
