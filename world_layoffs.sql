/*
=========================================================
SQL Project: Data Cleaning (Tech Layoffs Dataset)
=========================================================

Dataset Source: https://www.kaggle.com/datasets/swaptr/layoffs-2022

Description:
This project focuses on cleaning a real-world layoffs dataset 
using MySQL. The goal is to transform raw data into a clean 
and analysis-ready format.

Steps Covered:
1. Create staging table
2. Remove duplicates
3. Standardize data
4. Handle null values
5. Remove unnecessary data

=========================================================
*/

-- =====================================================
-- STEP 1: CREATE STAGING TABLE
-- =====================================================

-- Create a copy of the original dataset to preserve raw data
CREATE TABLE world_layoffs.layoffs_staging 
LIKE world_layoffs.layoffs;

-- Insert raw data into staging table
INSERT INTO world_layoffs.layoffs_staging
SELECT * FROM world_layoffs.layoffs;



-- =====================================================
-- STEP 2: REMOVE DUPLICATES
-- =====================================================

-- Create a new staging table with row numbers to identify duplicates
CREATE TABLE world_layoffs.layoffs_staging2 AS
SELECT *,
ROW_NUMBER() OVER (
    PARTITION BY company, location, industry, total_laid_off, 
                 percentage_laid_off, `date`, stage, country, 
                 funds_raised_millions
) AS row_num
FROM world_layoffs.layoffs_staging;

-- Delete duplicate rows (keep only first occurrence)
DELETE FROM world_layoffs.layoffs_staging2
WHERE row_num >= 2;



-- =====================================================
-- STEP 3: STANDARDIZE DATA
-- =====================================================

-- 3.1 Convert empty industry values to NULL
UPDATE world_layoffs.layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- 3.2 Fill missing industry values using other rows of same company
UPDATE world_layoffs.layoffs_staging2 t1
JOIN world_layoffs.layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- 3.3 Standardize industry names
UPDATE world_layoffs.layoffs_staging2
SET industry = 'Crypto'
WHERE industry IN ('Crypto Currency', 'CryptoCurrency');

-- 3.4 Fix location encoding issues
UPDATE world_layoffs.layoffs_staging2
SET location = 'Dusseldorf'
WHERE location = 'DÃ¼sseldorf';

UPDATE world_layoffs.layoffs_staging2
SET location = 'Malmo'
WHERE location = 'MalmÃ¶';

UPDATE world_layoffs.layoffs_staging2
SET location = 'Florianopolis'
WHERE location = 'FlorianÃ³polis';

-- 3.5 Clean country names (remove trailing dots)
UPDATE world_layoffs.layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);



-- =====================================================
-- STEP 4: FORMAT DATE COLUMN
-- =====================================================

-- Convert date from text to proper DATE format
UPDATE world_layoffs.layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- Change column type to DATE
ALTER TABLE world_layoffs.layoffs_staging2
MODIFY COLUMN `date` DATE;



-- =====================================================
-- STEP 5: HANDLE NULL VALUES
-- =====================================================

-- Remove rows where both total_laid_off and percentage_laid_off are NULL
DELETE FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;



-- =====================================================
-- STEP 6: CLEAN UP TEMPORARY COLUMNS
-- =====================================================

-- Remove helper column used for duplicate detection
ALTER TABLE world_layoffs.layoffs_staging2
DROP COLUMN row_num;



-- =====================================================
-- FINAL CHECK
-- =====================================================

-- View cleaned dataset
SELECT * 
FROM world_layoffs.layoffs_staging2;
