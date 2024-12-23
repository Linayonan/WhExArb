WITH f AS (SELECT * FROM {{ ref('src_housingprices') }}),

r AS (SELECT * FROM {{ ref('src_region') }}),

y AS (SELECT * FROM {{ ref('src_year') }}),

p AS (SELECT * FROM {{ ref('src_pricing') }})

SELECT 
    f.id,
    r.region,
    y.year,
    p.Apartment_Area,
    p.Land_Price,
    p.Building_price
FROM
    f
JOIN 
    r ON r.id = f.id
JOIN 
    y ON y.id = r.id
JOIN
    p ON p.id = y.id