// user-service/index.js
const express = require('express');
const app = express();
app.use(express.json());

let users = [
  { id: 1, name: "Alice" },
  { id: 2, name: "Bob" }
];

app.get('/health', (req, res) => res.json({ status: 'ok', service: 'user-service' }));

app.get('/users', (req, res) => res.json(users));

app.get('/users/:id', (req, res) => {
  const u = users.find(x => x.id === parseInt(req.params.id));
  if (!u) return res.status(404).json({ error: 'not found' });
  res.json(u);
});

app.post('/users', (req, res) => {
  const id = users.length ? users[users.length-1].id + 1 : 1;
  const user = { id, name: req.body.name || `user${id}` };
  users.push(user);
  res.status(201).json(user);
});

app.listen(3001, () => console.log('user-service listening on 3001'));
