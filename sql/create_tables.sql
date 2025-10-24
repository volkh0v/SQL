CREATE TABLE stores (
  store_id      SERIAL PRIMARY KEY,
  store_name    TEXT NOT NULL,
  city          TEXT,
  region        TEXT
);

CREATE TABLE products (
  product_id    SERIAL PRIMARY KEY,
  drug_name     TEXT NOT NULL,
  category      TEXT,
  manufacturer  TEXT,
  unit_price    NUMERIC(10,2) NOT NULL
);

CREATE TABLE inventory (
  inventory_id  SERIAL PRIMARY KEY,
  store_id      INT REFERENCES stores(store_id),
  product_id    INT REFERENCES products(product_id),
  stock_level   INT NOT NULL,
  reorder_level INT NOT NULL,
  last_restock  DATE
);

CREATE TABLE customers (
  customer_id   SERIAL PRIMARY KEY,
  name          TEXT,
  birth_date    DATE,
  city          TEXT
);

CREATE TABLE sales (
  sale_id       SERIAL PRIMARY KEY,
  store_id      INT REFERENCES stores(store_id),
  product_id    INT REFERENCES products(product_id),
  customer_id   INT REFERENCES customers(customer_id),
  sale_date     TIMESTAMP NOT NULL,
  quantity      INT NOT NULL CHECK (quantity > 0),
  unit_price    NUMERIC(10,2) NOT NULL,
  total_amount  NUMERIC(12,2) GENERATED ALWAYS AS (quantity * unit_price) STORED
);
