WITH fct_housingprices AS (SELECT * FROM {{ ref('fct_housingprices') }}),

region AS (SELECT region_key, region AS Region FROM {{ ref('dim_region') }}),

year AS (SELECT year_key, year AS Year FROM {{ ref('dim_year') }}),

pricing AS (SELECT id,
        Apartment_Area,
        Land_Price,
        Building_Price
    FROM {{ ref('dim_pricing') }})


SELECT
    r.Region,
    y.Year,
    p.Apartment_Area,
    p.Land_Price,
    p.Building_Price

FROM fct_housingprices AS f
LEFT JOIN region AS r
    ON r.region_key = f.region_key
LEFT JOIN year AS y
    ON y.year_key = f.year_key
LEFT JOIN pricing AS p
    ON p.id = f.id