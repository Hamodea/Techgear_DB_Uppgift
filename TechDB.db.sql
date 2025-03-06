--
-- File generated with SQLiteStudio v3.4.15 on Thu Mar 6 01:11:16 2025
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: categories
CREATE TABLE IF NOT EXISTS categories (
    category_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL
                        UNIQUE
);

INSERT INTO categories (
                           category_id,
                           name
                       )
                       VALUES (
                           1,
                           'Smartphones'
                       );

INSERT INTO categories (
                           category_id,
                           name
                       )
                       VALUES (
                           2,
                           'Laptops'
                       );

INSERT INTO categories (
                           category_id,
                           name
                       )
                       VALUES (
                           3,
                           'Accessories'
                       );

INSERT INTO categories (
                           category_id,
                           name
                       )
                       VALUES (
                           4,
                           'Tablets'
                       );

INSERT INTO categories (
                           category_id,
                           name
                       )
                       VALUES (
                           5,
                           'Wearables'
                       );

INSERT INTO categories (
                           category_id,
                           name
                       )
                       VALUES (
                           20,
                           'Testkategori'
                       );


-- Table: customers
CREATE TABLE IF NOT EXISTS customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL,
    email       TEXT    UNIQUE
                        NOT NULL,
    phone       TEXT,
    address     TEXT
);

INSERT INTO customers (
                          customer_id,
                          name,
                          email,
                          phone,
                          address
                      )
                      VALUES (
                          1,
                          'Alice Johnson',
                          'alice@example.com',
                          '123456789',
                          '123 Apple St'
                      );

INSERT INTO customers (
                          customer_id,
                          name,
                          email,
                          phone,
                          address
                      )
                      VALUES (
                          2,
                          'Bob Smith',
                          'BoB Smith@gmail.com',
                          '0712345678',
                          'Lund 27434'
                      );

INSERT INTO customers (
                          customer_id,
                          name,
                          email,
                          phone,
                          address
                      )
                      VALUES (
                          3,
                          'Charlie Brown',
                          'charlie@example.com',
                          '555667788',
                          '789 Banana Blvd'
                      );

INSERT INTO customers (
                          customer_id,
                          name,
                          email,
                          phone,
                          address
                      )
                      VALUES (
                          4,
                          'Erik Svensson',
                          'erik@svenskmail.se',
                          '0701234567',
                          'Drottninggatan 10, Stockholm'
                      );

INSERT INTO customers (
                          customer_id,
                          name,
                          email,
                          phone,
                          address
                      )
                      VALUES (
                          5,
                          'Anna Karlsson',
                          'anna@karlssonmail.se',
                          '0739876543',
                          'Avenyn 5, Göteborg'
                      );


-- Table: manufacturers
CREATE TABLE IF NOT EXISTS manufacturers (
    manufacturer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name            TEXT    NOT NULL
);

INSERT INTO manufacturers (
                              manufacturer_id,
                              name
                          )
                          VALUES (
                              1,
                              'TechCorp'
                          );

INSERT INTO manufacturers (
                              manufacturer_id,
                              name
                          )
                          VALUES (
                              2,
                              'GadgetWorld'
                          );

INSERT INTO manufacturers (
                              manufacturer_id,
                              name
                          )
                          VALUES (
                              3,
                              'InnovateX'
                          );

INSERT INTO manufacturers (
                              manufacturer_id,
                              name
                          )
                          VALUES (
                              4,
                              'SvenskTech'
                          );


-- Table: order_items
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id      INTEGER NOT NULL,
    product_id    INTEGER NOT NULL,
    quantity      INTEGER NOT NULL,
    price         REAL    NOT NULL,
    FOREIGN KEY (
        order_id
    )
    REFERENCES orders (order_id) ON DELETE CASCADE,
    FOREIGN KEY (
        product_id
    )
    REFERENCES products (product_id) ON DELETE CASCADE
);

INSERT INTO order_items (
                            order_item_id,
                            order_id,
                            product_id,
                            quantity,
                            price
                        )
                        VALUES (
                            2,
                            2,
                            2,
                            1,
                            1499.99
                        );

INSERT INTO order_items (
                            order_item_id,
                            order_id,
                            product_id,
                            quantity,
                            price
                        )
                        VALUES (
                            3,
                            3,
                            3,
                            2,
                            199.99
                        );

INSERT INTO order_items (
                            order_item_id,
                            order_id,
                            product_id,
                            quantity,
                            price
                        )
                        VALUES (
                            4,
                            4,
                            6,
                            1,
                            899.99
                        );

INSERT INTO order_items (
                            order_item_id,
                            order_id,
                            product_id,
                            quantity,
                            price
                        )
                        VALUES (
                            5,
                            5,
                            4,
                            1,
                            799.99
                        );

INSERT INTO order_items (
                            order_item_id,
                            order_id,
                            product_id,
                            quantity,
                            price
                        )
                        VALUES (
                            6,
                            6,
                            5,
                            1,
                            1699.99
                        );


-- Table: orders
CREATE TABLE IF NOT EXISTS orders (
    order_id         INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id      INTEGER,
    product_id       INTEGER,
    order_date       TEXT    NOT NULL,
    status           TEXT    NOT NULL,
    delivery_address TEXT    NOT NULL,
    FOREIGN KEY (
        customer_id
    )
    REFERENCES customers (customer_id),
    FOREIGN KEY (
        product_id
    )
    REFERENCES products (product_id) ON DELETE SET NULL
);

INSERT INTO orders (
                       order_id,
                       customer_id,
                       product_id,
                       order_date,
                       status,
                       delivery_address
                   )
                   VALUES (
                       1,
                       1,
                       NULL,
                       '2024-02-17',
                       'Shipped',
                       '123 Apple St'
                   );

INSERT INTO orders (
                       order_id,
                       customer_id,
                       product_id,
                       order_date,
                       status,
                       delivery_address
                   )
                   VALUES (
                       2,
                       2,
                       2,
                       '2024-02-16',
                       'Processing',
                       '456 Orange Ave'
                   );

INSERT INTO orders (
                       order_id,
                       customer_id,
                       product_id,
                       order_date,
                       status,
                       delivery_address
                   )
                   VALUES (
                       3,
                       3,
                       3,
                       '2024-02-15',
                       'Delivered',
                       '789 Banana Blvd'
                   );

INSERT INTO orders (
                       order_id,
                       customer_id,
                       product_id,
                       order_date,
                       status,
                       delivery_address
                   )
                   VALUES (
                       4,
                       4,
                       6,
                       '2024-02-18',
                       'Pending',
                       'Drottninggatan 10, Stockholm'
                   );

INSERT INTO orders (
                       order_id,
                       customer_id,
                       product_id,
                       order_date,
                       status,
                       delivery_address
                   )
                   VALUES (
                       5,
                       5,
                       4,
                       '2024-02-19',
                       'Shipped',
                       'Avenyn 5, Göteborg'
                   );

INSERT INTO orders (
                       order_id,
                       customer_id,
                       product_id,
                       order_date,
                       status,
                       delivery_address
                   )
                   VALUES (
                       6,
                       2,
                       5,
                       '2024-02-20',
                       'Processing',
                       '456 Orange Ave'
                   );


-- Table: product_categories
CREATE TABLE IF NOT EXISTS product_categories (
    product_id  INTEGER,
    category_id INTEGER,
    PRIMARY KEY (
        product_id,
        category_id
    ),
    FOREIGN KEY (
        product_id
    )
    REFERENCES products (product_id) ON DELETE CASCADE
                                     ON UPDATE CASCADE,
    FOREIGN KEY (
        category_id
    )
    REFERENCES categories (category_id) ON DELETE CASCADE
                                        ON UPDATE CASCADE
);

INSERT INTO product_categories (
                                   product_id,
                                   category_id
                               )
                               VALUES (
                                   2,
                                   2
                               );

INSERT INTO product_categories (
                                   product_id,
                                   category_id
                               )
                               VALUES (
                                   3,
                                   3
                               );

INSERT INTO product_categories (
                                   product_id,
                                   category_id
                               )
                               VALUES (
                                   4,
                                   1
                               );

INSERT INTO product_categories (
                                   product_id,
                                   category_id
                               )
                               VALUES (
                                   5,
                                   2
                               );

INSERT INTO product_categories (
                                   product_id,
                                   category_id
                               )
                               VALUES (
                                   6,
                                   4
                               );


-- Table: products
CREATE TABLE IF NOT EXISTS products (
    product_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    manufacturer_id INTEGER,
    name            TEXT    NOT NULL,
    description     TEXT,
    price           REAL    NOT NULL,
    stock_quantity  INTEGER NOT NULL,
    FOREIGN KEY (
        manufacturer_id
    )
    REFERENCES manufacturers (manufacturer_id) ON DELETE CASCADE
                                               ON UPDATE CASCADE
);

INSERT INTO products (
                         product_id,
                         manufacturer_id,
                         name,
                         description,
                         price,
                         stock_quantity
                     )
                     VALUES (
                         2,
                         2,
                         'UltraLaptop 15',
                         'Kraftfull laptop för programmering och spel.',
                         1499.99,
                         30
                     );

INSERT INTO products (
                         product_id,
                         manufacturer_id,
                         name,
                         description,
                         price,
                         stock_quantity
                     )
                     VALUES (
                         3,
                         3,
                         'Wireless Earbuds',
                         'Bluetooth-hörlurar med brusreducering.',
                         199.99,
                         100
                     );

INSERT INTO products (
                         product_id,
                         manufacturer_id,
                         name,
                         description,
                         price,
                         stock_quantity
                     )
                     VALUES (
                         4,
                         4,
                         'SvenskMobil Pro',
                         'Svensktillverkad smartphone med 5G och lång batteritid.',
                         799.99,
                         40
                     );

INSERT INTO products (
                         product_id,
                         manufacturer_id,
                         name,
                         description,
                         price,
                         stock_quantity
                     )
                     VALUES (
                         5,
                         2,
                         'New Tech spel',
                         'A cool new ',
                         199.99,
                         70
                     );

INSERT INTO products (
                         product_id,
                         manufacturer_id,
                         name,
                         description,
                         price,
                         stock_quantity
                     )
                     VALUES (
                         6,
                         3,
                         'Tablet Pro 12',
                         'Högupplöst surfplatta med stor skärm.',
                         899.99,
                         25
                     );

INSERT INTO products (
                         product_id,
                         manufacturer_id,
                         name,
                         description,
                         price,
                         stock_quantity
                     )
                     VALUES (
                         8,
                         1,
                         'Testprodukt',
                         'Testbeskrivning',
                         100.0,
                         10
                     );

INSERT INTO products (
                         product_id,
                         manufacturer_id,
                         name,
                         description,
                         price,
                         stock_quantity
                     )
                     VALUES (
                         9,
                         1,
                         'Testprodukt',
                         'Testbeskrivning',
                         100.0,
                         10
                     );


-- Table: reviews
CREATE TABLE IF NOT EXISTS reviews (
    review_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    product_id  INTEGER NOT NULL,
    rating      INTEGER NOT NULL
                        CHECK (rating >= 1 AND
                               rating <= 5),
    review_text TEXT,
    review_date TEXT    NOT NULL
                        DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (
        customer_id
    )
    REFERENCES customers (customer_id) ON DELETE CASCADE,
    FOREIGN KEY (
        product_id
    )
    REFERENCES products (product_id) ON DELETE CASCADE
);

INSERT INTO reviews (
                        review_id,
                        customer_id,
                        product_id,
                        rating,
                        review_text,
                        review_date
                    )
                    VALUES (
                        2,
                        2,
                        2,
                        4,
                        'Bra laptop, men batteritiden kunde varit bättre.',
                        '2025-02-24 21:00:08'
                    );

INSERT INTO reviews (
                        review_id,
                        customer_id,
                        product_id,
                        rating,
                        review_text,
                        review_date
                    )
                    VALUES (
                        3,
                        3,
                        3,
                        3,
                        'Hörlurarna är okej, men brusreduceringen är inte den bästa.',
                        '2025-02-24 21:00:08'
                    );

INSERT INTO reviews (
                        review_id,
                        customer_id,
                        product_id,
                        rating,
                        review_text,
                        review_date
                    )
                    VALUES (
                        4,
                        4,
                        6,
                        5,
                        'Perfekt surfplatta för arbete och underhållning.',
                        '2025-02-24 21:00:08'
                    );

INSERT INTO reviews (
                        review_id,
                        customer_id,
                        product_id,
                        rating,
                        review_text,
                        review_date
                    )
                    VALUES (
                        5,
                        5,
                        4,
                        4,
                        'Bra mobil, men lite dyr.',
                        '2025-02-24 21:00:08'
                    );

INSERT INTO reviews (
                        review_id,
                        customer_id,
                        product_id,
                        rating,
                        review_text,
                        review_date
                    )
                    VALUES (
                        6,
                        1,
                        2,
                        5,
                        'Fantastisk produkt!',
                        '2025-03-05 23:46:47'
                    );

INSERT INTO reviews (
                        review_id,
                        customer_id,
                        product_id,
                        rating,
                        review_text,
                        review_date
                    )
                    VALUES (
                        7,
                        2,
                        3,
                        4,
                        'Bra produkt, men kunde vara bättre.',
                        '2025-03-05 23:46:52'
                    );


-- Table: shipping_methods
CREATE TABLE IF NOT EXISTS shipping_methods (
    shipping_method_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name               TEXT    NOT NULL
);

INSERT INTO shipping_methods (
                                 shipping_method_id,
                                 name
                             )
                             VALUES (
                                 1,
                                 'Standard Shipping'
                             );

INSERT INTO shipping_methods (
                                 shipping_method_id,
                                 name
                             )
                             VALUES (
                                 2,
                                 'Express Delivery'
                             );

INSERT INTO shipping_methods (
                                 shipping_method_id,
                                 name
                             )
                             VALUES (
                                 3,
                                 'Overnight Shipping'
                             );

INSERT INTO shipping_methods (
                                 shipping_method_id,
                                 name
                             )
                             VALUES (
                                 4,
                                 'PostNord Sverige'
                             );


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
