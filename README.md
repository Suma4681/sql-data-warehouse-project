# SQL Data Warehouse Project

## Overview

This repository showcases a simple data warehouse built from scratch using SQL.  It demonstrates how to design a dimensional model, write ETL scripts to populate fact and dimension tables, and perform basic analytics queries.  The project is intended as a portfolio piece for data warehousing and SQL skills.

## Objectives

- Design a star schema from a transactional dataset.
- Write SQL scripts for extracting, transforming and loading (ETL) the data into warehouse tables.
- Create views and sample queries to answer typical business questions.
- Document the design choices and trade‑offs in the data model.

## Directory structure

```
sql‑data‑warehouse‑project/
├── ddl/               # DDL scripts to create schema, tables and indexes
│   ├── create_tables.sql
│   └── create_views.sql
├── dml/               # ETL scripts to load data into fact/dim tables
│   ├── load_dimensions.sql
│   └── load_fact.sql
├── queries/           # example analytics queries and reports
│   ├── sales_by_region.sql
│   └── top_products.sql
├── docs/              # documentation and ER diagrams
│   └── schema_design.md
├── readme.md          # project description (this file)
└── data/              # sample CSV files used for ETL (not committed)
```

## Getting started

1. **Choose your database:** This project is database agnostic – you can use PostgreSQL, MySQL, Redshift, Snowflake or another SQL engine that supports basic DDL and DML.  Create an empty database/schema for the warehouse.

2. **Run the DDL scripts:**

   ```bash
   psql -d your_database -f ddl/create_tables.sql
   psql -d your_database -f ddl/create_views.sql
   ```

3. **Load sample data:**

   Prepare sample CSV files in the `data/` directory.  Adjust paths in `dml/load_dimensions.sql` and `dml/load_fact.sql`, then run:

   ```bash
   psql -d your_database -f dml/load_dimensions.sql
   psql -d your_database -f dml/load_fact.sql
   ```

4. **Run analytics queries:**

   ```bash
   psql -d your_database -f queries/sales_by_region.sql
   ```

   Use `queries/` as a starting point to answer additional questions.

## Notes

- The `docs/schema_design.md` file describes the star schema, primary/foreign keys, grain of the fact table, and other design considerations.
- Feel free to modify the schema or ETL scripts to adapt to different source data.
- When deploying to production, schedule the ETL jobs to run incrementally (e.g. daily) and monitor for failures.

## License

This project is licensed under the MIT License.
