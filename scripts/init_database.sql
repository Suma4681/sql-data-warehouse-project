-- create_datawarehouse.sql

-- 1. Connect to the default or "postgres" database (or another DB where you have sufficient privileges)
\connect postgres

-- 2. Drop the 'datawarehouse' database if it already exists
DROP DATABASE IF EXISTS datawarehouse;

-- 3. Create a new 'datawarehouse' database
CREATE DATABASE datawarehouse;

-- 4. Connect to the newly created 'datawarehouse' database
\connect datawarehouse

-- 5. Drop existing schemas (if present) inside the 'datawarehouse' DB
DROP SCHEMA IF EXISTS BRONZE CASCADE;
DROP SCHEMA IF EXISTS SILVER CASCADE;
DROP SCHEMA IF EXISTS GOLD CASCADE;

-- 6. Create fresh schemas
CREATE SCHEMA BRONZE;
CREATE SCHEMA SILVER;
CREATE SCHEMA GOLD;

-- (Optional) If you want to set owners or grant privileges, you can do so here
-- ALTER SCHEMA BRONZE OWNER TO my_user;
-- GRANT ALL ON SCHEMA BRONZE TO my_user;
