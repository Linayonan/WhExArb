WITH fct_housingprices AS (SELECT * FROM {{ ref('fct_housingprices') }}),

region AS (SELECT * FROM {{ ref('dim_region') }}),

year AS (SELECT * FROM {{ ref('dim_year') }}),

pricing AS (SELECT * FROM {{ ref('dim_pricing') }})

SELECT
    r.region,
    y.year,
    p.Apartment_Area,
    p.Land_Price,
    p.Building_price

FROM fct_housingprices AS f
JOIN region AS r
   ON r.region = f.region.
JOIN year AS y
    ON y.year = f.year
JOIN pricing AS p
    ON p.id = f.id
