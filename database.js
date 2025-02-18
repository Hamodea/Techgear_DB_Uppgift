const dataBase  = require('better-sqlite3');

const db = dataBase('Techgear.db', {verbose: console.log});


function getAllCustomer() {
    return db.prepare("SELECT * FROM customers").all();
}



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


// function getProductById(id){
//     return db.prepare("SELECT * FROM products WHERE product_id = ?").all(id);
// }


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


module.exports = {getAllCustomer, getAllProducts, getProductsByName};
