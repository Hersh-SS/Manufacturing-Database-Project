select * from MaterialOrder where cost = 50;

select materialName, COUNT(materialID) as numOfMaterials from Material where currentStock > 1000 group by materialName;

select planNumber, 
(select productName from Product where productName = 'Table') as productName, 
productionCost as productionCost 
from ProductionPlan where productionCost < 1000;

SELECT *
FROM myDatabase.MaterialOrder
WHERE cost > (SELECT AVG(cost) FROM myDatabase.MaterialOrder)
ORDER BY materialOrderNumber ASC;

SELECT clientName FROM ClientOrder WHERE clientOrderNumber = '3';

SELECT *
FROM myDatabase.ManufacturingOrder
WHERE planCost < (SELECT AVG(planCost) FROM myDatabase.ManufacturingOrder)
ORDER BY manufacturingOrderNumber DESC;

