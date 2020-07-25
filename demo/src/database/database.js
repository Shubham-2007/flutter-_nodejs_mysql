const mysql = require('mysql');

const mysqlconnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '12345',
    database: 'mydb',
});

mysqlconnection.connect(function(error) {
    if (error) {
        console.log(error);
        return;
    } else {
        console.log('database connected');
    }
});

module.exports = mysqlconnection;