# 🏗️ Data Warehouse & Analytics Project (PostgreSQL | Shell | GitHub)

Welcome to my end-to-end **Data Warehousing & Analytics** portfolio project! 🚀  
This project demonstrates how to build and automate a modern data pipeline using industry-standard practices — right from ingestion (CSV) to analytical modeling (Gold layer). It showcases **ETL, Data Modeling, Shell Scripting, and Analytics** — all in one!

---

## 🔁 Medallion Architecture Overview

This project follows the **Medallion Architecture** structure:

| Layer     | Description                                                                 |
|-----------|-----------------------------------------------------------------------------|
| **Bronze** | Raw ingestion of CSV files into PostgreSQL                                  |
| **Silver** | Data cleansing, business logic, and standardization                         |
| **Gold**   | Analytical star schema (dimensional modeling) for reporting and insights    |

---

## 📖 Project Goals

🎯 Design and implement a PostgreSQL data warehouse from scratch  
🔁 Build **ETL pipelines** using SQL & stored procedures  
🧹 Apply robust **data cleaning & transformation** logic  
📊 Develop a **Star Schema** for business-ready reporting  
✅ Implement **quality checks** for data accuracy  
🖥️ Automate with **shell scripting** for reproducibility  
📈 Connect to BI tools like Tableau for visualization  

---

## 🧩 Technologies Used

- PostgreSQL + SQL
- pgAdmin + psql
- Shell Scripting
- Git & GitHub
- Tableau (for Gold layer visualization)
- Markdown + Metadata Cataloging

---

## 📂 Project Structure


---

## 🔧 Key Scripts

| Script/File | Description |
|-------------|-------------|
| `init_db_and_schemas.sql` | Initializes PostgreSQL schemas |
| `create_bronze_tables.sql` | Creates bronze tables for raw ingestion |
| `load_bronze_data.sh` | Automates CSV loading via terminal |
| `etl_to_silver.sql` | Cleans and transforms data to silver layer |
| `create_gold_views.sql` | Builds star schema views |
| `quality_silver.sql` | Data quality checks on silver tables |
| `quality_gold.sql` | Validations between fact/dimension tables |

---

## 🗂️ Metadata Catalogs

Detailed documentation for all tables, columns, and transformations:

- 📌 `bronze_data_catalog.md` → Raw schema
- 📌 `silver_data_catalog.md` → Cleaned and transformed schema
- 📌 `gold_data_catalog.md` → Star schema (facts + dimensions)

---

## 🧪 Data Quality Checks

- Null or duplicate key validation
- Trim + formatting issues
- Date range validation
- Referential integrity between fact & dimension tables
- Sales = Quantity × Price validation

Scripts:
- ✅ `quality_checks_silver.sql`
- ✅ `quality_checks_gold.sql`

---

## 📈 Business Use Cases

📊 **Sales Insights**  
📊 **Customer Segmentation**  
📊 **Product Performance**  
📊 **Time Series Analysis**  
📊 **Geographic Distribution**  

---

## 🚀 How to Run This Project

```bash
# Step 1: Create DB + Schemas
psql -U postgres -f automation/init_db_and_schemas.sql

# Step 2: Create bronze tables
psql -U postgres -d datawarehouse -f scripts/bronze/create_bronze_tables.sql

# Step 3: Load data
bash automation/load_bronze_data.sh

# Step 4: Transform to silver
psql -U postgres -d datawarehouse -f scripts/silver/etl_to_silver.sql

# Step 5: Create gold views
psql -U postgres -d datawarehouse -f scripts/gold/create_gold_views.sql

# Step 6: Run quality checks
psql -U postgres -d datawarehouse -f quality_checks/quality_silver.sql
psql -U postgres -d datawarehouse -f quality_checks/quality_gold.sql

Let me know if you'd like this broken down into separate `.md` files (e.g., `bronze_readme.md`, `gold_readme.md`) or if you want me to upload a `.md` file directly.
