show roles;
use role dbt_role;
use schema wh_db.staging;
show tables;
desc table housingprices;
 use warehouse compute_wh;
 select * from housingprices;
 select region, year, apartment_area_persqm 
 from HOUSINGPRICEs;
 select distinct year 
 from housingprices;
SELECT *
FROM staging.Housingprices
LIMIT 10;
