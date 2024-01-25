INSERT INTO Material VALUES('M1001', 'Aluminium', 3, 50, 50);

INSERT INTO ProductionPlan VALUES('P#001', 2, 10, (SELECT materialID FROM Material WHERE materialName = 'Aluminium'), 5);

INSERT INTO Product VALUES('P1004', 'Water Bottle', (SELECT cost FROM Material WHERE materialName = 'Aluminium')*
(SELECT productionCost FROM ProductionPlan WHERE productionTime > 1 AND materialID = 'M1001'), 10, 15, 
(SELECT planNumber FROM ProductionPlan WHERE planNumber = 'P#001'));



