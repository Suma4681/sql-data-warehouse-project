/*
===============================================
Create Database and Schemas
===============================================

Script Purpose:
This script initializes the `datawarehouse` database and sets up 
a 3-layer architecture following the Medallion architecture pattern:
- Bronze: Raw data
- Silver: Cleaned/validated data
- Gold: Aggregated/business-ready data

WARNING:
- Running this will drop `datawarehouse` if it already exists.
- Make sure you have backups before executing it.

Author: Sumanth Koppula
*/

-- Step 1: Connect to the default `postgres` database
\c postgres;

-- Step 2: Drop `datawarehouse` if it exists (caution: this deletes everything inside)
DROP DATABASE IF EXISTS datawarehouse;

-- Step 3: Create a fresh `datawarehouse` database
CREATE DATABASE datawarehouse;

-- Step 4: Connect to the newly created `datawarehouse`
\c datawarehouse;

--Step 5: Create schemas for bronze, silver, and gold layers
CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;
