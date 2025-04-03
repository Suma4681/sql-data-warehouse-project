-- create_datawarehouse.sql

-- Optional: If you want a fresh setup each time, drop the DB (BE CAREFUL!)
-- DROP DATABASE IF EXISTS datawarehouse;

-- 1. Connect to the default or "postgres" database first.
\connect postgres

-- 2. Create the datawarehouse database
CREATE DATABASE datawarehouse;

-- 3. Connect to the newly created datawarehouse database
\connect datawarehouse

-- 4. Create the schemas
CREATE SCHEMA IF NOT EXISTS BRONZE;
CREATE SCHEMA IF NOT EXISTS SILVER;
CREATE SCHEMA IF NOT EXISTS GOLD;

-- (Optional) Change schema ownership or grant privileges here, e.g.:
-- ALTER SCHEMA BRONZE OWNER TO my_user;
-- GRANT USAGE ON SCHEMA BRONZE TO some_role;
-- GRANT CREATE ON SCHEMA BRONZE TO some_role;
