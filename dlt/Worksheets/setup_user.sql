USE ROLE USERADMIN;
CREATE ROLE IF NOT EXISTS wh_dlt_role;

CREATE USER IF NOT EXISTS extractloader
    PASSWORD = 'el_password123'
    DEFAULT_WAREHOUSE = compute_wh;

USE ROLE SECURITYADMIN;
GRANT ROLE wh_dlt_role TO USER extractloader;
GRANT USAGE ON WAREHOUSE compute_wh TO ROLE wh_dlt_role; 
GRANT USAGE ON DATABASE wh_db TO ROLE wh_dlt_role;
GRANT USAGE ON SCHEMA wh_db.staging TO ROLE wh_dlt_role;
GRANT CREATE TABLE ON SCHEMA wh_db.staging TO ROLE wh_dlt_role;

GRANT SELECT, INSERT, UPDATE,
DELETE ON ALL TABLES IN SCHEMA wh_db.staging TO ROLE wh_dlt_role;
GRANT SELECT, INSERT, UPDATE,
DELETE ON FUTURE TABLES IN SCHEMA wh_db.staging TO ROLE wh_dlt_role;

SHOW GRANTS ON SCHEMA wh_db.staging;
SHOW FUTURE GRANTS IN SCHEMA wh_db.staging;

SHOW GRANTS TO ROLE wh_dlt_role;
SHOW GRANTS TO USER extractloader;
GRANT ROLE wh_dlt_role TO USER LinaYonan; 