# Data Warehouse ETL for Banking Industry

## Overview

This project involves creating a Data Warehouse for a client in the banking industry. The Data Warehouse integrates data from various sources, facilitating efficient data management and timely reporting. Below are the details of the data tables involved in this project.

## Data Tables

### Table: account
This table contains information about bank accounts or customer accounts.

- `account_id`: ID of the account
- `customer_id`: ID of the customer
- `account_type`: Type of the account (e.g., saving for long-term savings like deposits, checking for everyday accounts)
- `balance`: Balance of the account
- `date_opened`: Date the account was created
- `status`: Status of the account

### Table: branch
This table contains information about the bank branches.

- `branch_id`: ID of the branch
- `branch_name`: Name of the branch
- `branch_location`: Address of the branch location

### Table: customer
This table contains information about customers.

- `customer_id`: ID of the customer
- `customer_name`: Name of the customer
- `address`: Address of the customer
- `city_id`: ID of the city (sub-district)
- `age`: Age of the customer
- `gender`: Gender of the customer
- `email`: Email of the customer

### Table: city
This table contains information about cities (sub-districts).

- `city_id`: ID of the city (sub-district)
- `city_name`: Name of the city (sub-district)
- `state_id`: ID of the state (city)

### Table: state
This table contains information about states (cities).

- `state_id`: ID of the state (city)
- `state_name`: Name of the state (city)

---

This repository contains the necessary data files and configurations to set up the Data Warehouse, ensuring efficient data integration from various sources for better reporting and analysis in the banking industry.
