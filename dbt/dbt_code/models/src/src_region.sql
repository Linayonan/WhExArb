WITH stg_wh_db AS 
(SELECT * 
FROM {{ source('wh_db', 'stg_tables_wh_db') }})  ---CTE Commun table expression

SELECT
    id,
    region AS Region
FROM stg_wh_db