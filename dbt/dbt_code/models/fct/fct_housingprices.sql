WITH f AS (SELECT * 
    FROM {{ ref('src_housingprices') }}),
r AS (SELECT id, {{ dbt_utils.generate_surrogate_key(['id', 'region']) }} AS region_key, Region 
    FROM {{ ref('src_region') }}),
y AS (SELECT id, {{ dbt_utils.generate_surrogate_key(['id', 'year']) }} AS year_key, Year
    FROM {{ ref('src_year') }}),
p AS (SELECT id, Apartment_Area, Land_Price, Building_Price
    FROM {{ ref('src_pricing') }})

SELECT 
    f.id,
    r.region_key,
    y.year_key,
    p.Apartment_Area,
    p.Land_Price,
    p.Building_Price
FROM f
LEFT JOIN r 
    ON r.id = f.id
LEFT JOIN y 
    ON y.id = f.id
LEFT JOIN p 
    ON p.id = f.id