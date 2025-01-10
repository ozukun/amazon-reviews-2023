{{ 
    config(
        materialized='table'
    ) 
}}

WITH cleaned_data AS (
    SELECT *
    FROM {{ ref('cleaned_reviews') }}
),

aggregated_data AS (
    SELECT
        rating,
        COUNT(*) AS review_count,
        AVG(LENGTH(review_text)) AS avg_review_length -- Example metric: average review text length
    FROM cleaned_data
    GROUP BY rating
)

SELECT *
FROM aggregated_data;
