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

// 🟢 Viktigt! Lägg `/products/search` FÖRE `/products/:id`
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
app.get('/products/:id', (req, res) => {
    const productId = req.params.id;
    const product = db.getProductById(productId);
    
    if (!product) {
        return res.status(404).json({ error: 'Product not found' });
    }

    res.json(product);
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



app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
