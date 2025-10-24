-- 04_indexes_and_explain_examples.sql

-- Useful indexes:
CREATE INDEX idx_sales_sale_date ON sales (sale_date);
CREATE INDEX idx_sales_store_product ON sales (store_id, product_id);
CREATE INDEX idx_inventory_store_product ON inventory (store_id, product_id);
CREATE INDEX idx_products_category ON products (category);

-- Example: examine query plan for top selling products
EXPLAIN ANALYZE
SELECT p.product_id, p.drug_name, SUM(s.total_amount) AS revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_id, p.drug_name
ORDER BY revenue DESC
LIMIT 10;
