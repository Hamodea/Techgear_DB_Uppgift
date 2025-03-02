const express = require('express');
const app = express();
const port =  3000;

// Hämta Data
const db = require('./database');

// Skap Middleware
function logger(req, res, next) {
    console.log(`${req.method} ${req.url}`);
    next();
}

app.use(express.json());
app.use(logger);    

app.get('/', (req, res) => {
    res.send('Hello World!');
});


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

    // Om id INTE är ett nummer, gå vidare till næsta route
    if (isNaN(productId)) {
        next();
        return;
    }

    if (productId <= 0) {
        return res.status(400).json({ error: 'Invalid product ID' });
    }

    const product = db.getProductById(productId);

    if (!product) {
        return res.status(404).json({ error: 'Product not found' });
    }

    res.json(product);
});


app.get('/products/search', (req, res) => {
    const searchTerm = req.query.name;

    if (!searchTerm) {
        return res.status(400).json({ error: 'Search term is required' });
    }

    try {
        const products = db.getProductsByName(searchTerm);
        res.json(products);
    } catch (error) {
        res.status(500).json({ error: 'Server error' });
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


app.post('/products', (req, res) => {
    const { name, description, price, stock_quantity, manufacturer_id } = req.body;

    // Validera att alla nödvändiga fält finns
    if (!name || !price || !stock_quantity || !manufacturer_id) {
        return res.status(400).json({ error: 'Missing required fields' });
    }

    try {
        const newProduct = db.createProduct(name, description, price, stock_quantity, manufacturer_id);
        res.status(201).json({ message: 'Product created', product: newProduct });
    } catch (error) {
        res.status(500).json({ error: 'Server error' });
    }
});

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

app.delete('/products/:id', (req, res) => {
    const productId = req.params.id;
    
    try {
        db.deleteProduct(productId);
        res.json({ message: 'Product deleted' });
    } catch (error) {
        res.status(500).json({ error: 'Server error' });
    }
});


// Hund Handtering
app.get('/customers', (req, res) => {
    try {
        const customers = db.getAllCustomers();
        res.json(customers);
    } catch (error) {
        res.status(500).json({ error: 'Server error' });
    }
    
})


app.put('/customers/:id', (req, res) => {
    const customerId = req.params.id;
    const {  email, phone, address } = req.body;
    
    try {
        db.updateCustomers(customerId, email, phone, address);
        res.json({ message: 'Customer updated' });
    } catch (error) {
        res.status(500).json({ error: 'Server error' });
    }
});



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


app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
