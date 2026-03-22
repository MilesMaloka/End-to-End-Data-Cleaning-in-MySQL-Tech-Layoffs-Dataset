# Tech Layoffs Data Cleaning (MySQL)

## Overview

This project focuses on **data cleaning and preprocessing using MySQL** with a real-world dataset of global tech layoffs from 2020 to 2025.

The dataset contains inconsistencies such as missing values, duplicates, inconsistent text formats, and unstructured fields. The goal of this project is to transform the raw dataset into a **clean, structured, and analysis-ready format** using SQL.

---

## Objectives

* Clean raw data using **MySQL queries**
* Handle **NULL values and missing data**
* Remove **duplicate records**
* Standardize inconsistent text fields (e.g., company names, locations, stages)
* Format and convert date columns correctly
* Prepare a dataset suitable for further analysis

---

## Tools Used

* **MySQL**
* SQL (Data Cleaning & Transformation)

---

## Dataset

The dataset tracks global tech layoffs reported between **March 2020 and April 2025**.
It includes information such as:

* Company name
* Number of employees laid off
* Industry
* Country/location
* Company stage
* Date of layoffs

> Note: Some fields in the dataset may contain missing or inconsistent values, which are addressed during the cleaning process.

---

## Data Cleaning Steps

### 1. Removing Duplicates

* Identified duplicate records using `ROW_NUMBER()`
* Removed duplicates to ensure data integrity

### 2. Handling Missing Values

* Replaced or removed NULL values where necessary
* Filled missing data when possible using logical assumptions

### 3. Standardizing Data

* Cleaned inconsistent text values (e.g., trimming spaces, fixing case sensitivity)
* Unified naming conventions for companies and countries

### 4. Date Formatting

* Converted date columns into proper **DATE format**
* Ensured consistency across all records

### 5. Data Transformation

* Created new cleaned tables for analysis
* Structured the dataset for easier querying

---

## Key Skills Demonstrated

* Data cleaning with SQL
* Writing efficient MySQL queries
* Handling real-world messy datasets
* Data transformation and preparation
* Attention to detail and data quality

---

## Project Purpose

This project was created to strengthen **practical data cleaning skills in MySQL** by working with real-world data challenges. It reflects the type of preprocessing required before performing data analysis or building dashboards.

---

## Future Improvements

* Perform exploratory data analysis (EDA)
* Build dashboards using tools like Power BI or Tableau
* Automate cleaning workflows using SQL scripts

---

## Author

**Miles Maloka**
