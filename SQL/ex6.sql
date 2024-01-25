SELECT * FROM lab3309.restockplan;
SET SQL_SAFE_UPDATES=0;
UPDATE lab3309.restockplan
SET planStatus = 'complete'
WHERE planSTatus = 'incomplete';
DELETE FROM lab3309.restockplan WHERE planStatus = 'complete';
INSERT INTO lab3309.restockplan VALUES (5, 'incomplete', (SELECT clientOrderNumber From lab3309.clientorder WHERE clientOrderNumber = 1));
INSERT INTO lab3309.restockplan VALUES (1, 'incomplete', (SELECT clientOrderNumber From lab3309.clientorder WHERE clientOrderNumber = 5));




