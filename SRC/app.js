const { application } = require('express');
const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const mysql = require('mysql');

var connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : '', //your password in mysql workbench
    database : 'lab3309assign4-1', //your database schema might have difference name
    multipleStatements: true
  });

connection.connect((err, res) =>{
    if(err){
        console.log("error in database");
    }
    console.log("sql is connected...");
});
module.exports = connection;
app.set('view engine', 'ejs');
app.set('views', 'views');

app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())

app.get("/", (req, res) =>{
    res.render('index', {
      title:"Manufacturing Management System"  
    })
});

app.post("/theCode", (req, res, next) => {
    let postUpdate = {productID: req.body.ProductID, productName: req.body.ProductName, price: req.body.price, currentStock: req.body.CurrentStock, setStock: req.body.SetStock, planNumber: req.body.PlanNumber};
    let postUpdate1 = {planNumber: req.body.PlanNumber, productionTime: req.body.ProductionTime, productionCost: req.body.ProductionCost};
    let sql1 = "INSERT INTO productionplan SET ?";
    connection.query(sql1,postUpdate1, (err, result) => {
        if(err) {
            console.log(err);
        }
        console.log("data plan added...");
    })
    let sql = "INSERT INTO product SET ?";
    connection.query(sql,postUpdate, (err, result) =>{
        if(err){
            console.log(err);
        }
        console.log("data added");
    })
   
    next()
});

app.get('/product-list', function(req, res, next) {
    var sql='SELECT * FROM product';
    connection.query(sql, function (err, data, fields) {
    if (err) throw err;
    res.render('product-list', { title: 'Product List', productData: data});
  });
});

app.get('/search-product', function(req, res){
    var sql='SELECT * FROM product';
    connection.query(sql, function (err, data, fields) {
    if (err) throw err;
    res.render('search-product', { title: 'Product List', productData: data});
  });
});

app.get('/client-report', function(req, res){
    res.render('client-report', { title: 'Client Report'});
  });

app.get('/generated-client-report', function(req, res){
    var sql = "SELECT * FROM Client WHERE clientName = '" + req.query.clientName + "'; " +
    "SELECT SUM(price) AS orderTotal FROM ClientOrder WHERE clientName = '" + req.query.clientName + "'; " +
    "SELECT Product.productName, SUM(ClientOrderList.quantity) AS quantity FROM " +
    "ClientOrder INNER JOIN ClientOrderList ON ClientOrder.clientOrderNumber=ClientOrderList.clientOrderNumber " +
    "INNER JOIN Product ON ClientOrderList.productID=Product.productID WHERE clientName = '" + req.query.clientName + "' " +
    "GROUP BY productName, quantity ORDER BY productName";
    connection.query(sql, function (err, data, fields) {
    if (err) 
    {
        alert("Client: " + req.query.clientName + " does not exist.");
        throw err;
    }
    data = JSON.parse(JSON.stringify(data)); 
    res.render('client-report-generated', { title: 'Client Report', clientData: data[0][0], total: data[1][0].orderTotal, products: data[2]});
    });
});

app.get('/search', function(req, res){
var ProductID = req.query.ProductID;
var ProductName = req.query.ProductName;
var price = req.query.price;
var CurrentStock = req.query.CurrentStock;
var PlanNumber = req.query.PlanNumber;

//connection.connect(function(err){
    //if(err) console.log(err);
    var sql = "SELECT * FROM product WHERE productID LIKE '%"+ProductID+"%' AND productName LIKE '%"+ProductName+"%' AND price LIKE '%"+price+"%' AND currentStock LIKE '%"+CurrentStock+"%' AND planNumber LIKE '%"+PlanNumber+"%'" ;
    connection.query(sql, function(err, data, fields) {
        if(err) throw (err);
        res.render('search-product', { title: 'Product List', productData: data});
    });

//});

});

app.listen(3000);
