-- 1. Business Question:
-- Which bicycle categories (e.g., road bikes, mountain bikes, e-bikes) are generating the most revenue?
SELECT 
    c.category_name, 
    SUM(sf.quantity * p.list_price) AS total_revenue
FROM 
    sales_dw.Sales_Fact sf
JOIN 
    sales_dw.Products p ON sf.product_id = p.product_id
JOIN 
    sales_dw.Categories c ON p.category_id = c.category_id
GROUP BY 
    c.category_name
ORDER BY 
    total_revenue DESC;
	
	
-- 2. Business Question:
-- What are the top 5 best-selling bicycles by quantity?	
SELECT 
    p.product_name, 
    SUM(sf.quantity) AS total_quantity_sold
FROM 
    sales_dw.Sales_Fact sf
JOIN 
    sales_dw.Products p ON sf.product_id = p.product_id
GROUP BY 
    p.product_name
ORDER BY 
    total_quantity_sold DESC
LIMIT 5;

-- 3. Business Question:
-- How much revenue did each store generate?
SELECT 
    s.store_name, 
    SUM(sf.quantity * p.list_price) AS total_revenue
FROM 
    sales_dw.Sales_Fact sf
JOIN 
    sales_dw.Stores s ON sf.store_id = s.store_id
JOIN 
    sales_dw.Products p ON sf.product_id = p.product_id
GROUP BY 
    s.store_name
ORDER BY 
    total_revenue DESC;
