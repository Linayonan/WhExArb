USE ROLE useradmin;
CREATE ROLE IF NOT EXISTS reporter_role;

USE ROLE securityadmin;

GRANT USAGE ON WAREHOUSE compute_wh TO ROLE reporter_role;

GRANT USAGE ON DATABASE wh_db TO ROLE reporter_role;
GRANT USAGE ON SCHEMA wh_db.marts TO ROLE reporter_role; ----
GRANT SELECT ON ALL TABLES IN SCHEMA wh_db.marts TO ROLE reporter_role;
GRANT SELECT ON ALL VIEWS IN SCHEMA wh_db.marts TO ROLE reporter_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA wh_db.marts TO ROLE reporter_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA wh_db.marts TO ROLE reporter_role;


GRANT ROLE reporter_role TO USER reporter;
GRANT ROLE reporter_role TO USER LinaYonan;

USE ROLE reporter_role;

SHOW GRANTS TO ROLE reporter_role;

-- test querying a mart
USE WAREHOUSE compute_wh;
SELECT * FROM wh_db.marts.mart_housing_prices;