const dataBase  = require('better-sqlite3');

const db = new dataBase('Techgear.db', {verbose: console.log});




function getAllProducts() {
    const sql = `
        SELECT 
            p.product_id, 
            p.name AS product_name, 
            p.description, 
            p.price, 
            p.stock_quantity,
            m.name AS manufacturer_name,
            c.name AS category_name
        FROM products p
        JOIN manufacturers m ON p.manufacturer_id = m.manufacturer_id
        LEFT JOIN product_categories pc ON p.product_id = pc.product_id
        LEFT JOIN categories c ON pc.category_id = c.category_id;
    `;
    return db.prepare(sql).all();
}


function getProductById(productId) {
    const sql = `
        SELECT 
            p.product_id, 
            p.name AS product_name, 
            p.description, 
            p.price, 
            p.stock_quantity,
            m.name AS manufacturer_name,
            c.name AS category_name
        FROM products p
        JOIN manufacturers m ON p.manufacturer_id = m.manufacturer_id
        LEFT JOIN product_categories pc ON p.product_id = pc.product_id
        LEFT JOIN categories c ON pc.category_id = c.category_id
        WHERE p.product_id = ?;
    `;
    return db.prepare(sql).get(productId);
}

// get Product By name
function getProductsByName(name) {
    const sql = `
    SELECT 
        p.product_id, 
        p.name AS product_name, 
        p.description, 
        p.price, 
        p.stock_quantity,
        m.name AS manufacturer_name,
        c.name AS category_name
    FROM products p
    JOIN manufacturers m ON p.manufacturer_id = m.manufacturer_id
    LEFT JOIN product_categories pc ON p.product_id = pc.product_id
    LEFT JOIN categories c ON pc.category_id = c.category_id
    WHERE p.name LIKE ?;
    `;

    console.log("Executing SQL with name:", name);
    const result = db.prepare(sql).all(`%${name}%`);
    console.log("SQL result:", result);
    return result;
}

function getProductsByCategory(categoryId) {
    const stmt = db.prepare(`
        SELECT p.*, c.name AS category_name 
        FROM products p
        JOIN product_categories pc ON p.product_id = pc.product_id
        JOIN categories c ON pc.category_id = c.category_id
        WHERE c.category_id = ?
    `);
    return stmt.all(categoryId);
}


function createProduct(name, description, price, stock_quantity, manufacturer_id) {
    const stmt = db.prepare(`
        INSERT INTO products (name, description, price, stock_quantity, manufacturer_id) 
        VALUES (?, ?, ?, ?, ?)
    `);
    const result = stmt.run(name, description, price, stock_quantity, manufacturer_id);
    return { product_id: result.lastInsertRowid };
}


function updateProduct(productId, name, description, price, stock_quantity, manufacturer_id) {
    const stmt = db.prepare(`
        UPDATE products 
        SET name = ?, description = ?, price = ?, stock_quantity = ?, manufacturer_id = ? 
        WHERE product_id = ?
    `);
    return stmt.run(name, description, price, stock_quantity, manufacturer_id, productId);
}

function deleteProduct(productId) {
    const stmt = db.prepare(`
        DELETE FROM products 
        WHERE product_id = ?
    `);
    return stmt.run(productId);
}




// kund hantering


function getAllCustomers() {
    const sql = db.prepare(`SELECT * FROM customers
        JOIN orders ON customers.customer_id = orders.customer_id`).all();
    return sql;
}


// Updatera Kund Information

function updateCustomers(customer_id, email, phone, address) {
    const stmt =db.prepare(`
        UPDATE customers
        SET  email = ?, phone = ?, address = ?
        WHERE customer_id = ?
    `);
    return stmt.run( email, phone, address, customer_id);
}

// Lista alla ordrar för en specifik kund 
function getOrdersByCustomerId(customerId) {
    const stmt = db.prepare(`
        SELECT *
        FROM orders
        WHERE customer_id = ?
    `);
    return stmt.all(customerId);
}


// DataAnalysis

//Visa statistik grupperad per kategori 

function getProductStats() {
    const stmt = db.prepare(`
        SELECT 
            c.name AS category_name, 
            COUNT(p.product_id) AS product_count, 
            AVG(p.price) AS avg_price
        FROM products p
        LEFT JOIN product_categories pc ON p.product_id = pc.product_id
        LEFT JOIN categories c ON pc.category_id = c.category_id
        GROUP BY c.category_id;
    `);

    const results = stmt.all();
    console.log("DB Query Result:", results); // 🔍 Logga vad som returneras
    return results;
}


function getreviewStats() {
    const stmt = db.prepare(`
        SELECT 
            product_id, 
            AVG(rating) AS average_rating, 
            COUNT(*) AS review_count
        FROM reviews
        GROUP BY product_id;
    `);
    return stmt.all();
}
module.exports = {getAllCustomers, getAllProducts, getProductById, getProductsByName, getProductsByCategory, createProduct, updateProduct, deleteProduct, updateCustomers, getOrdersByCustomerId, getProductStats, getreviewStats};
