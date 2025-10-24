-- 02_sample_data.sql

-- Stores
INSERT INTO stores (store_name, city, region) VALUES
('Apteka Centrum', 'Warsaw', 'Mazowieckie'),
('Apteka Nova', 'Krakow', 'Malopolskie'),
('Apteka Zdrowie', 'Gdansk', 'Pomorskie');

-- Products
INSERT INTO products (drug_name, category, manufacturer, unit_price) VALUES
('Paracetamol 500mg', 'Analgesic', 'PharmaA', 4.50),
('Ibuprofen 200mg', 'Analgesic', 'PharmaB', 6.00),
('Vitamin C 500mg', 'Supplement', 'PharmaC', 12.00),
('Antibiotic X', 'Antibiotic', 'PharmaD', 45.00),
('Cough Syrup', 'Respiratory', 'PharmaE', 18.50);

-- Inventory
INSERT INTO inventory (store_id, product_id, stock_level, reorder_level, last_restock) VALUES
(1,1,120,30,'2025-10-01'),
(1,2,50,20,'2025-09-24'),
(1,3,10,20,'2025-09-05'),
(2,1,200,40,'2025-09-30'),
(2,4,5,10,'2025-10-10'),
(3,5,0,15,'2025-08-15');

-- Customers
INSERT INTO customers (name, birth_date, city) VALUES
('Anna Kowalska','1986-05-12','Warsaw'),
('Piotr Nowak','1978-11-02','Krakow'),
('Ewa Zielinska','1998-03-22','Gdansk');

-- Sales (dates spread across months)
INSERT INTO sales (store_id, product_id, customer_id, sale_date, quantity, unit_price) VALUES
(1,1,1,'2025-10-02 10:15',2,4.50),
(1,1,2,'2025-10-02 12:30',1,4.50),
(1,3,1,'2025-09-20 09:00',1,12.00),
(2,4,2,'2025-10-11 14:00',1,45.00),
(2,1,3,'2025-09-05 11:30',5,4.50),
(3,5,1,'2025-09-01 08:45',1,18.50),
(1,2,3,'2025-10-05 16:00',3,6.00),
(1,3,2,'2025-08-15 10:00',2,12.00),
(3,1,3,'2025-10-03 13:00',1,4.50),
(1,4,1,'2025-07-30 15:00',1,45.00);
