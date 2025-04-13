# 📘 Data Dictionary – Gold Layer

The **Gold Layer** is the business-level data model designed for reporting and analytics. It follows the **Star Schema** model with one fact table and two dimension tables.

---

## 📂 `gold.dim_customers`

**Purpose:** Stores customer details enriched with demographic and geographic data.

| Column Name     | Data Type   | Description                                                                 |
|-----------------|-------------|-----------------------------------------------------------------------------|
| customer_key    | INT         | Surrogate key uniquely identifying each customer                            |
| customer_id     | VARCHAR(50) | Original customer ID from source                                            |
| customer_number | VARCHAR(50) | Alphanumeric customer number used in transactions                          |
| first_name      | VARCHAR(50) | Customer’s first name                                                       |
| last_name       | VARCHAR(50) | Customer’s last name                                                        |
| country         | VARCHAR(50) | Geographic location of customer (e.g., US, Dubai, etc.)                    |
| martial_status  | VARCHAR(50) | Cleaned marital status (`Married`, `Single`, or `n/a`)                     |
| gender          | VARCHAR(50) | Standardized gender (`Male`, `Female`, or `n/a`)                           |
| birth_date      | DATE        | Date of birth                                                              |
| create_date     | DATE        | Date customer record was created                                           |

---

## 📂 `gold.dim_products`

**Purpose:** Describes each product with enriched category, subcategory, and timeline information.

| Column Name     | Data Type   | Description                                                               |
|-----------------|-------------|---------------------------------------------------------------------------|
| product_key     | INT         | Surrogate key uniquely identifying each product                          |
| product_id      | VARCHAR(50) | Original product ID                                                       |
| product_number  | VARCHAR(50) | Alphanumeric product key                                                  |
| product_name    | VARCHAR(50) | Descriptive name of the product                                           |
| category_id     | VARCHAR(50) | Derived ID that links to product category                                 |
| category        | VARCHAR(50) | Product category (e.g., Bikes, Accessories)                               |
| subcategory     | VARCHAR(50) | More granular level of category                                           |
| maintenance     | VARCHAR(50) | Product maintenance classification                                        |
| cost            | INT         | Base product cost                                                         |
| product_line    | VARCHAR(50) | Grouping for product line (e.g., Road, Touring)                          |
| start_date      | DATE        | Date when the product was launched                                        |

---

## 📊 `gold.fact_sales`

**Purpose:** Stores transactional sales facts used for calculating revenue, quantities, and order metrics.

| Column Name     | Data Type   | Description                                                               |
|-----------------|-------------|---------------------------------------------------------------------------|
| order_number    | VARCHAR(50) | Unique order identifier                                                   |
| product_key     | INT         | Foreign key to `gold.dim_products.product_key`                            |
| customer_key    | INT         | Foreign key to `gold.dim_customers.customer_key`                          |
| order_date      | DATE        | Date when the order was placed                                            |
| shipping_date   | DATE        | Date when the order was shipped                                           |
| due_date        | DATE        | Expected delivery date                                                    |
| sales_amount    | INT         | Total sales amount = quantity * price                                     |
| sales_quantity  | INT         | Number of units ordered                                                   |
| price           | INT         | Unit price of the product                                                 |

---

✅ **Usage:**  
This gold layer allows analysts to perform customer behavior analysis, sales performance tracking, and time-based reporting. Easily join dimension tables to `fact_sales` using `customer_key` and `product_key`.
