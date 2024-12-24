-- NOTE: you should .gitignore this file as it contains credentials
USE ROLE useradmin;
CREATE USER IF NOT EXISTS reporter
    PASSWORD = 'reporter123'
    LOGIN_NAME = 'reporter'
    DEFAULT_WAREHOUSE = compute_wh
    DEFAULT_NAMESPACE = 'housingprices.marts'
    COMMENT = 'reporter user for making analysis and BI'
    DEFAULT_ROLE = 'reporter_role';