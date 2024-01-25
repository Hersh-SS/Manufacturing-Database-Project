CREATE TABLE Client(clientName VARCHAR(30) NOT NULL UNIQUE PRIMARY KEY, phoneNumber INT UNIQUE, shippingAddress VARCHAR(40), email VARCHAR(30) UNIQUE);

CREATE TABLE Material(materialID CHAR(5) NOT NULL UNIQUE PRIMARY KEY, materialName VARCHAR(15), cost INT NOT NULL, 
currentStock INT NOT NULL, setStock INT NOT NULL);

CREATE TABLE ProductionPlan(planNumber CHAR(5) NOT NULL UNIQUE PRIMARY KEY, productionTime INT, productionCost INT NOT NULL, 
materialID CHAR(5) NOT NULL, quantity INT NOT NULL, FOREIGN KEY (materialID) REFERENCES Material(materialID));

CREATE TABLE Product(productID CHAR(5) NOT NULL UNIQUE PRIMARY KEY, productName VARCHAR(20), price INT NOT NULL, currentStock INT NOT NULL, 
setStock INT NOT NULL, planNumber CHAR(5) NOT NULL, FOREIGN KEY (planNumber) REFERENCES ProductionPlan(planNumber));

CREATE TABLE ClientOrder(clientOrderNumber CHAR(5) NOT NULL UNIQUE PRIMARY KEY, 
deliveryDate DATE, price INT NOT NULL, clientName VARCHAR(30) NOT NULL, productID CHAR(5) NOT NULL, quantity INT NOT NULL, 
FOREIGN KEY (clientName) REFERENCES Client(clientName), FOREIGN KEY (productID) REFERENCES Product(productID));

CREATE TABLE RestockPlan(restockPlanNumber CHAR(5) NOT NULL UNIQUE PRIMARY KEY, 
planStatus VARCHAR(17) CHECK(planStatus = 'Complete' OR planStatus = 'Incomplete' OR planStatus = 'Missing Materials') NOT NULL DEFAULT 'Incomplete', 
clientOrderNumber CHAR(5) NOT NULL, FOREIGN KEY (clientOrderNumber) REFERENCES ClientOrder(clientOrderNumber));

CREATE TABLE ManufacturingOrder(manufacturingOrderNumber CHAR(7) NOT NULL UNIQUE PRIMARY KEY, 
planCost INT NOT NULL, restockPlanNumber CHAR(5) NOT NULL, productID CHAR(5) NOT NULL, quantity INT NOT NULL, 
FOREIGN KEY (productID) REFERENCES Product(productID), FOREIGN KEY (restockPlanNumber) REFERENCES RestockPlan(restockPlanNumber));

CREATE TABLE MaterialOrder(materialOrderNumber CHAR(7) NOT NULL UNIQUE PRIMARY KEY, arrivalDate DATE, 
cost INT NOT NULL, restockPlanNumber CHAR(5) NOT NULL, materialID CHAR(5) NOT NULL, quantity INT NOT NULL, 
FOREIGN KEY (materialID) REFERENCES Material(materialID), FOREIGN KEY (restockPlanNumber) REFERENCES RestockPlan(restockPlanNumber));

