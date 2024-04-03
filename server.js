// server.js
const express = require('express');
const cors = require('cors');
const mime = require('mime-types');
const app = express();
const port = 3000;

// Enable CORS
app.use(cors());

// Serve static files with proper MIME types
app.use(express.static('public', {
  setHeaders: (res, path) => {
    const mimeType = mime.lookup(path);
    res.setHeader('Content-Type', mimeType || 'application/octet-stream');
  }
}));

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
