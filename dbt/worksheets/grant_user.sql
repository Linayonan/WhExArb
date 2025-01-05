USE ROLE USERADMIN;

CREATE ROLE IF NOT EXISTS dbt_role;
GRANT ROLE dbt_role TO USER dbt_transformer;
GRANT ROLE dbt_role TO USER LinaYonan;