-- A. Total sales per month (time series)
SELECT
  date_trunc('month', sale_date) AS month,
  SUM(total_amount) AS revenue,
  SUM(quantity)   AS units_sold
FROM sales
GROUP BY 1
ORDER BY 1;

-- B. Top 10 selling products (by revenue)
SELECT p.product_id, p.drug_name, p.category,
       SUM(s.total_amount) AS revenue,
       SUM(s.quantity) AS units_sold
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_id, p.drug_name, p.category
ORDER BY revenue DESC
LIMIT 10;

-- C. Moving average (3-month) revenue — uses window functions
SELECT month,
       revenue,
       ROUND(AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS ma_3m
FROM (
  SELECT date_trunc('month', sale_date) AS month, SUM(total_amount) AS revenue
  FROM sales
  GROUP BY 1
) t
ORDER BY month;

-- D. Sales by region and category
SELECT st.region, p.category,
       SUM(s.total_amount) AS revenue
FROM sales s
JOIN stores st ON s.store_id = st.store_id
JOIN products p ON s.product_id = p.product_id
GROUP BY st.region, p.category
ORDER BY st.region, revenue DESC;

-- E. Inventory reorder alerts (stock <= reorder_level)
SELECT i.inventory_id, st.store_name, p.drug_name, i.stock_level, i.reorder_level
FROM inventory i
JOIN stores st ON i.store_id = st.store_id
JOIN products p ON i.product_id = p.product_id
WHERE i.stock_level <= i.reorder_level
ORDER BY i.stock_level;

-- F. Identify possible stockouts in last 30 days (sales but zero inventory)
-- Note: this is a heuristic: sales exist while current stock_level = 0
SELECT DISTINCT s.store_id, st.store_name, s.product_id, p.drug_name
FROM sales s
JOIN inventory i ON s.store_id = i.store_id AND s.product_id = i.product_id
JOIN stores st ON s.store_id = st.store_id
JOIN products p ON s.product_id = p.product_id
WHERE i.stock_level = 0
  AND s.sale_date >= current_date - interval '30 days';

-- G. Customers who frequently buy the same product (repeat purchase)
SELECT customer_id, product_id, COUNT(*) AS purchases
FROM sales
GROUP BY customer_id, product_id
HAVING COUNT(*) > 1
ORDER BY purchases DESC;

-- H. Average days between restock and next sale (supply responsiveness)
-- For each inventory item, compute time from last_restock to first sale after that date
SELECT i.inventory_id, st.store_name, p.drug_name,
       MIN(s.sale_date) AS first_sale_after_restock,
       (MIN(s.sale_date)::date - i.last_restock) AS days_to_first_sale
FROM inventory i
JOIN stores st ON i.store_id = st.store_id
JOIN products p ON i.product_id = p.product_id
LEFT JOIN sales s
  ON s.store_id = i.store_id AND s.product_id = i.product_id
  AND s.sale_date::date >= i.last_restock
GROUP BY i.inventory_id, st.store_name, p.drug_name, i.last_restock;
