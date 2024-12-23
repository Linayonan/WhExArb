WITH src_pricing AS (SELECT * FROm {{ ref('src_pricing') }})

SELECT 
    id,
    Apartment_Area,
    Land_Price,
    Building_price
    FROM src_pricing