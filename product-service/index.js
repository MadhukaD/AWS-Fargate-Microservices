// product-service/index.js
const express = require('express');
const app = express();
app.use(express.json());

let products = [
  { id: 1, name: "Widget" },
  { id: 2, name: "Gadget" },
  { id: 3, name: "Widget" },
  { id: 4, name: "Gadget" }
];

app.get('/health', (req, res) => res.json({ status: 'ok', service: 'product-service' }));
app.get('/products', (req, res) => res.json(products));
app.get('/products/:id', (req, res) => {
  const p = products.find(x => x.id === parseInt(req.params.id));
  if (!p) return res.status(404).json({ error: 'not found' });
  res.json(p);
});
app.post('/products', (req, res) => {
  const id = products.length ? products[products.length-1].id + 1 : 1;
  const product = { id, name: req.body.name || `product${id}` };
  products.push(product);
  res.status(201).json(product);
});
app.listen(3002, () => console.log('product-service listening on 3002'));
