WITH stg_wh_db AS (SELECT * FROM {{ source('wh_db', 'stg_tables_wh_db') }})  
SELECT
    id,
    year AS Year
FROM stg_wh_db