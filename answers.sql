WITH RECURSIVE product_cte AS (
    -- Start by taking the first product from the list
    SELECT 
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(Products, ',', 1)) AS Product,
        SUBSTRING(Products, LENGTH(SUBSTRING_INDEX(Products, ',', 1)) + 2) AS rest
    FROM ProductDetail

    UNION ALL

    -- Recursively extract the next product from the remaining list
    SELECT 
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(rest, ',', 1)) AS Product,
        SUBSTRING(rest, LENGTH(SUBSTRING_INDEX(rest, ',', 1)) + 2)
    FROM product_cte
    WHERE rest <> ''
)

-- Final output
SELECT OrderID, CustomerName, Product
FROM product_cte;
