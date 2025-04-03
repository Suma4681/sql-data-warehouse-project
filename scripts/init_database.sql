# Setting Up the `datawarehouse` Database and Schemas

This document explains how we created the **`datawarehouse`** PostgreSQL database and its main schemas (**`BRONZE`, `SILVER`, `GOLD`**). The instructions here assume you’re using **pgAdmin** for a graphical user interface.

---

## Screenshot Overview

Below is a screenshot of the final setup in pgAdmin. You’ll see the **`datawarehouse`** database, along with **`BRONZE`**, **`SILVER`**, and **`GOLD`** schemas:

![Screenshot of pgAdmin showing the datawarehouse database and BRONZE, SILVER, GOLD schemas.](./path/to/your_screenshot.png)

> **Note:** Replace the image path (`./path/to/your_screenshot.png`) with your actual screenshot’s relative path in this repo.

---

## 1. Prerequisites

1. **PostgreSQL** installed and running (version 13 or above recommended).
2. **pgAdmin** installed to manage your PostgreSQL instance via a graphical interface.
3. A user with **CREATE DATABASE** and **CREATE SCHEMA** privileges.

---

## 2. Creating the Database

1. Launch **pgAdmin** and **connect** to your PostgreSQL server.
2. In the Object Browser (left panel), **right-click** on **Databases**.
3. Select **Create** → **Database...**.
4. In the dialog:
   - **Name**: `datawarehouse`
   - (Optional) **Owner**: Choose a user different from default if you wish.
5. Click **Save**.

When complete, you’ll see **`datawarehouse`** under **Databases**.

---

## 3. Creating the Schemas

1. Select or expand the **`datawarehouse`** database.
2. Right-click on **Schemas** → **Create** → **Schema...**.
3. Enter the schema **Name** (e.g., `BRONZE`).
4. (Optional) Select **Owner** if different from the default.
5. Click **Save**.

Repeat the same steps for:
- **`SILVER`**
- **`GOLD`**

---

## 4. Verifying the Setup

In pgAdmin:

1. Expand the **`datawarehouse`** database.
2. Expand **Schemas**.
3. Ensure **BRONZE**, **SILVER**, and **GOLD** are listed (alongside **public**).

---

## 5. (Optional) Grant Permissions

If you have multiple PostgreSQL users or roles:

1. Open **Query Tool** under the **`datawarehouse`** database.
2. Grant privileges as needed, for example:

   ```sql
   GRANT USAGE ON SCHEMA BRONZE TO my_role;
   GRANT CREATE ON SCHEMA BRONZE TO my_role;

