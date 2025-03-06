const express = require('express');
const app = express();
const port =  3000;

// Hämta Data
const db = require('./database');
const e = require('express');

// Skap Middleware
function logger(req, res, next) {
    console.log(`${req.method} ${req.url}`);
    next();
}

function errorHandler(err, req, res, next) {
    console.error(err.stack);  // Logga felet i konsolen

    res.status(err.status || 500).json({
        error: err.message || "Internal Server Error"
    });
}



app.use(express.json());
app.use(logger);    



// Lista alla produkter
app.get('/products', (req, res) => {
    try {
        const products = db.getAllProducts();
        res.json(products);
    } catch (error) {
        res.status(500).json({ error: 'Server error' });
    }
});

// Hämta en produkt via ID
app.get('/products/id/:id', (req, res, next) => {
    const productId = req.params.id;

    if (isNaN(productId)) {
        return next({ status: 400, message: "Invalid product ID" });
    }

    const product = db.getProductById(productId);
    
    if (!product) {
        return next({ status: 404, message: "Product not found" });
    }

    res.json(product);
});


//Sök och lista produkter vars namn innehåller söktermen + Extra funktionalitet
app.get('/products/search', (req, res, next) => {
    try {
        const products = db.filterProducts(req.query);
        
        if (!products.length) {
            return next({ status: 404, message: 'No products found' });
        }

        res.json(products);
    } catch (error) {
        console.error("Database error:", error);
        next(error);
    }
});

// Hämta en products by category
app.get('/products/category/:id', (req, res) => {
    const categoryId = req.params.id;
    const products = db.getProductsByCategory(categoryId);
    
    if (!products || products.length === 0) {
        return res.status(404).json({ error: 'No products found in this category' });
    }
    

    res.json(products);
});


// lägga till en produkt
app.post('/products', (req, res) => {
    const { name, description, price, stock_quantity, manufacturer_id } = req.body;

    // Validera att alla nödvändiga fält finns
    let missingFields = [];
    if (!name || name.trim() === ''){
        missingFields.push('name is required');
    }

    if (!description || description.trim() === ''){
        missingFields.push('description is required');
    }

    if (!price || isNaN(price) || price <= 0){
        missingFields.push('price is required and must be greater than 0');
    }

    if (!stock_quantity || isNaN(stock_quantity) || stock_quantity <= 0){
        missingFields.push('stock_quantity is required');
    }

    if (!manufacturer_id || isNaN(manufacturer_id) || manufacturer_id <= 0){
        missingFields.push('manufacturer_id is required');
    }

    if (missingFields.length > 0){
        return res.status(400).json({ error: missingFields.join(', ') });
    }

    try {
        const product = db.createProduct(name, description, price, stock_quantity, manufacturer_id);
        res.json(product);
    } catch (error) {
        res.status(500).json({ error: 'Server error' });
    }
});


// uppdatera en produkt
app.put('/products/:id', (req, res) => {
    const productId = req.params.id;
    const { name, description, price, stock_quantity, manufacturer_id } = req.body;
    
    try {
        db.updateProduct(productId, name, description, price, stock_quantity, manufacturer_id);
        res.json({ message: 'Product updated' });
    } catch (error) {
        res.status(500).json({ error: 'Server error' });
    }
});


// ta bort en produkt
app.delete('/products/:id', (req, res) => {
    const productId = req.params.id;
    
    try {
        db.deleteProduct(productId);
        res.json({ message: 'Product deleted' });
    } catch (error) {
        res.status(500).json({ error: 'Server error' });
    }
});


// Kund Handtering
app.get('/customers', (req, res) => {
    const customers = db.getAllCustomers();
    if (customers.length === 0) {
        return res.status(404).json({ error: 'No customers found' });
    }

    res.json(customers);
});


// update customer
app.put('/customers/:id', (req, res) => {
    const customerId = req.params.id;
    const { email, phone, address } = req.body;
    
    db.updateCustomers(customerId, email, phone, address);
    
    res.json({ message: 'Customer updated' });
});


// Lista alla ordrar för en specifik kund
app.get('/customers/:id/orders', (req, res) => {
    const customerId = req.params.id;
    console.log(customerId);
    try {
        const orders = db.getOrdersByCustomerId(customerId);
        console.log(orders);
        if (orders.length === 0) {
            return res.status(404).json({ error: 'No orders found for this customer' });
        }
        res.json(orders);
    } catch (error) {
        res.status(500).json({ error: 'Server error' });
    }
});

//Visa statistik grupperad per kategori 
app.get('/products/stats', (req, res) => {
    try {
        const stats = db.getProductStats();
        console.log("Stats from DB:", stats);  // 🔍 Logga resultatet

        if (!stats || stats.length === 0) {
            return res.status(404).json({ error: 'No product stats found' });
        }

        res.json(stats);
    } catch (error) {
        console.error("Error fetching product stats:", error); // 🔴 Logga eventuella fel
        res.status(500).json({ error: 'Server error' });
    }
});

//Visa genomsnittligt betyg per produkt 
app.get('/reviews/stats', (req, res) => {
    try {
        const stats = db.getreviewStats();
        console.log("Stats from DB:", stats);  // 🔍 Logga resultatet)

        if (!stats || stats.length === 0) {
            return res.status(404).json({ error: 'No review stats found' });
        }

        res.json(stats);
    } catch (error) {
        console.error("Error fetching review stats:", error); // 🔴 Logga eventuella fel
        res.status(500).json({ error: 'Server error' });
    }
});




app.use(errorHandler);

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
