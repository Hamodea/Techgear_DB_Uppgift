--
-- File generated with SQLiteStudio v3.4.15 on Mon Feb 17 16:40:47 2025
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: categories
CREATE TABLE IF NOT EXISTS categories (
    category_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);
INSERT INTO categories (category_id, name) VALUES (1, 'Smartphones');
INSERT INTO categories (category_id, name) VALUES (2, 'Laptops');
INSERT INTO categories (category_id, name) VALUES (3, 'Accessories');
INSERT INTO categories (category_id, name) VALUES (4, 'Smartphones');
INSERT INTO categories (category_id, name) VALUES (5, 'Laptops');
INSERT INTO categories (category_id, name) VALUES (6, 'Accessories');

-- Table: customers
CREATE TABLE IF NOT EXISTS customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    address TEXT
);
INSERT INTO customers (customer_id, name, email, phone, address) VALUES (1, 'Alice Johnson', 'alice@example.com', '123456789', '123 Apple St');
INSERT INTO customers (customer_id, name, email, phone, address) VALUES (2, 'Bob Smith', 'bob@example.com', '987654321', '456 Orange Ave');
INSERT INTO customers (customer_id, name, email, phone, address) VALUES (3, 'Charlie Brown', 'charlie@example.com', '555667788', '789 Banana Blvd');

-- Table: manufacturers
CREATE TABLE IF NOT EXISTS manufacturers (
    manufacturer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);
INSERT INTO manufacturers (manufacturer_id, name) VALUES (1, 'TechCorp');
INSERT INTO manufacturers (manufacturer_id, name) VALUES (2, 'GadgetWorld');
INSERT INTO manufacturers (manufacturer_id, name) VALUES (3, 'InnovateX');

-- Table: order_items
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER NOT NULL,
    unit_price REAL NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES (1, 1, 1, 1, 999.99);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES (2, 1, 3, 2, 199.99);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES (3, 2, 2, 1, 1499.99);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES (4, 3, 3, 1, 199.99);

-- Table: orders
CREATE TABLE IF NOT EXISTS orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    shipping_method_id INTEGER,
    order_date TEXT NOT NULL,
    status TEXT NOT NULL,
    delivery_address TEXT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_methods(shipping_method_id)
);
INSERT INTO orders (order_id, customer_id, shipping_method_id, order_date, status, delivery_address) VALUES (1, 1, 1, '2024-02-17', 'Shipped', '123 Apple St');
INSERT INTO orders (order_id, customer_id, shipping_method_id, order_date, status, delivery_address) VALUES (2, 2, 2, '2024-02-16', 'Processing', '456 Orange Ave');
INSERT INTO orders (order_id, customer_id, shipping_method_id, order_date, status, delivery_address) VALUES (3, 3, 3, '2024-02-15', 'Delivered', '789 Banana Blvd');

-- Table: product_categories
CREATE TABLE IF NOT EXISTS product_categories (
    product_id INTEGER,
    category_id INTEGER,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO product_categories (product_id, category_id) VALUES (1, 1);
INSERT INTO product_categories (product_id, category_id) VALUES (2, 2);
INSERT INTO product_categories (product_id, category_id) VALUES (3, 3);

-- Table: products
CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    manufacturer_id INTEGER,
    name TEXT NOT NULL,
    description TEXT,
    price REAL NOT NULL,
    stock_quantity INTEGER NOT NULL,
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO products (product_id, manufacturer_id, name, description, price, stock_quantity) VALUES (1, 1, 'TechPhone X', 'Flaggskeppssmartphone med AI-kamera.', 999.99, 50);
INSERT INTO products (product_id, manufacturer_id, name, description, price, stock_quantity) VALUES (2, 2, 'UltraLaptop 15', 'Kraftfull laptop f�r programmering och spel.', 1499.99, 30);
INSERT INTO products (product_id, manufacturer_id, name, description, price, stock_quantity) VALUES (3, 3, 'Wireless Earbuds', 'Bluetooth-h�rlurar med brusreducering.', 199.99, 100);

-- Table: reviews
CREATE TABLE IF NOT EXISTS reviews (
    review_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INTEGER,
    customer_id INTEGER,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO reviews (review_id, product_id, customer_id, rating, comment) VALUES (1, 1, 1, 5, 'Fantastisk telefon, snabb och smidig!');
INSERT INTO reviews (review_id, product_id, customer_id, rating, comment) VALUES (2, 2, 2, 4, 'Bra laptop, men batteritiden kunde vara b�ttre.');
INSERT INTO reviews (review_id, product_id, customer_id, rating, comment) VALUES (3, 3, 3, 5, 'Ljudet �r kristallklart och batteriet h�ller l�nge.');

-- Table: shipping_methods
CREATE TABLE IF NOT EXISTS shipping_methods (
    shipping_method_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);
INSERT INTO shipping_methods (shipping_method_id, name) VALUES (1, 'Standard Shipping');
INSERT INTO shipping_methods (shipping_method_id, name) VALUES (2, 'Express Delivery');
INSERT INTO shipping_methods (shipping_method_id, name) VALUES (3, 'Overnight Shipping');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
