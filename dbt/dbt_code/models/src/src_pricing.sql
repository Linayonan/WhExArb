WITH stg_wh_db AS (SELECT * FROM {{ source('wh_db', 'stg_tables_wh_db') }})  
SELECT
    id,
    apartment_area_persqm AS Apartment_Area,
    land_price_persqm AS Land_Price,
    building_price_persqm AS Building_price
FROM stg_wh_db