WITH src_year AS (SELECT * FROm {{ ref('src_year') }})

SELECT
    id,
    {{ dbt_utils.generate_surrogate_key(['id','year']) }} AS year_key,
    Year
    
FROM src_year