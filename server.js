const express = require('express');
const app = express();
const port =  3000;


// Hämta Data
const db = require('./database');


// Skap Medelwear

app.use(express.json());
app.use(express.urlencoded({ extended: true }));    


app.get('/', (req, res) => {
    res.send('Hello World!');
});



app.get('/products', (req, res) => {
    try {
        const products = db.getAllProducts();
        res.json(products);
    } catch (error) {
        res.status(500).json({ error: 'Server error' });
    }
});

app.get('/products/:id', (req, res) => {
    try {
        const id = req.params.id;
        const product = db.getProductById(id);
        res.json(product);
    } catch (error) {
        res.status(500).json({ error: 'Server error' });
    }
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

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
