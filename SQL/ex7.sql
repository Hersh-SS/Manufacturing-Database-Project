CREATE VIEW `ProductsWithFullStockBelow5Dollars` AS
	SELECT productID, productName, price
    FROM Product
    WHERE (price < 5) AND (currentStock = setStock)
    GROUP BY productName;
    
CREATE VIEW `JohnsOrderedItemsDesc` AS
	SELECT clientOrdernumber, productID, quantity
    FROM ClientOrder
    WHERE clientName LIKE '%John%'
    ORDER BY quantity DESC;
    
SELECT COUNT(productID) AS NumberOfProducts FROM productswithfullstockbelow5dollars;
SELECT * FROM JohnsOrderedItemsDesc WHERE quantity >= 2;
    
