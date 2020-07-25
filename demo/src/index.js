const express = require('express');
const app = express();

//setting 
app.set('port', process.env.PORT || 3000);

//middlewares
app.use(express.json());

//routes
app.use(require('./routes/user'));

//starting server
app.listen(app.get('port'), () => {
    console.log('server on port', app.get('port'));
})