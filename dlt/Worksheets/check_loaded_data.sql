USE ROLE wh_dlt_role;
USE DATABASE wh_db;
SHOW SCHEMAS;
SHOW TABLES IN SCHEMA staging; DESC TABLE staging.housingprices; 
USE WAREHOUSE compute_wh;
SELECT region, year, apartment_area_persqm
FROM staging.housingprices;
SELECT * FROM staging.housingprices; 