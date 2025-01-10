{{ 
    config(
        materialized='table'
    ) 
}}

WITH raw_data AS (
    SELECT *
    FROM {{ source('raw', 'amazon_reviews') }}
),

cleaned_data AS (
    SELECT
        review_id,
        LOWER(reviewText) AS review_text,  -- Convert text to lowercase
        overall AS rating,
        TO_DATE(reviewTime, 'YYYY-MM-DD') AS review_date -- Standardize review time
    FROM raw_data
    WHERE reviewText IS NOT NULL  -- Filter out rows with null review text
)

SELECT *
FROM cleaned_data;

