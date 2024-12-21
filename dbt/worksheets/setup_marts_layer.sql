USE ROLE SYSADMIN;

USE DATABASE wh_db;

CREATE SCHEMA IF NOT EXISTS marts;

SHOW SCHEMAS IN DATABASE wh_db;

USE ROLE securityadmin;

GRANT USAGE,
CREATE TABLE,
CREATE VIEW ON SCHEMA wh_db.marts TO ROLE dbt_role;

-- grant CRUD and select tables and views
GRANT SELECT,
INSERT,
UPDATE,
DELETE ON ALL TABLES IN SCHEMA wh_db.marts TO ROLE dbt_role;
GRANT SELECT ON ALL VIEWS IN SCHEMA wh_db.marts TO ROLE dbt_role;

-- grant CRUD and select on future tables and views
GRANT SELECT,
INSERT,
UPDATE,
DELETE ON FUTURE TABLES IN SCHEMA wh_db.marts TO ROLE dbt_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA wh_db.marts TO ROLE dbt_role;
USE ROLE dbt_role;

SHOW GRANTS ON SCHEMA wh_db.marts;

-- manual test
USE SCHEMA wh_db.marts;
CREATE TABLE test (id INTEGER);
SHOW TABLES;
DROP TABLE TEST;