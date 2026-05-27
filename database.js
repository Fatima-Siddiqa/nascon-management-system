// Import mysql2 library
require('dotenv').config();
var mysql = require('mysql2');

var connection = mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    database: process.env.DB_NAME || 'project',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASS
});

// Connect to the database
connection.connect(function(err) {
    if (err) throw err;
    console.log('Connected to MySQL Database');
});

// Export connection to use in other files
module.exports = connection;