--	1.	Get all customers and their addresses.
--SELECT * FROM customers LIMIT 10;
--SELECT * FROM addresses LIMIT 10;
SELECT 
	c.first_name,
	c.last_name, 
	a.city, 
	a.state, 
	a.street, 
	a.zip 
FROM customers AS c
JOIN addresses as a 
	on c.id = a.customer_id
ORDER BY c.first_name, c.last_name ASC;

--	2.	Get all orders and their line items.
--SELECT * FROM orders LIMIT 10;
--SELECT * FROM line_items LIMIT 10;
SELECT 
	o.order_date,
	o.total,
	l.product_id,
	l.quantity,
	l.unit_price
FROM orders as o
JOIN line_items as l
	on o.id = l.order_id
ORDER BY o.order_date DESC;

--	3.	Which warehouses have cheetos?
--SELECT * FROM products LIMIT 10;
--SELECT * FROM warehouse_product LIMIT 10;
--SELECT * FROM warehouse LIMIT 10;
SELECT
	w.warehouse
FROM products as p
JOIN warehouse_product as wp on p.id = wp.product_id
JOIN warehouse as w on w.id = wp.warehouse_id
WHERE p.description = 'cheetos'
ORDER BY w.warehouse ASC


--	4.	Which warehouses have diet pepsi?
SELECT
	w.warehouse
FROM products as p
JOIN warehouse_product as wp on p.id = wp.product_id
JOIN warehouse as w on w.id = wp.warehouse_id
WHERE p.description = 'diet pepsi'
ORDER BY w.warehouse ASC

--	5.	Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
--SELECT * FROM customers LIMIT 10;
--select * from addresses limit 10;
--SELECT * FROM orders LIMIT 10;
--SELECT * FROM line_items LIMIT 10;

SELECT DISTINCT
	c.first_name,
	c.last_name,
	COUNT(*) 
FROM customers as c
JOIN addresses as a on c.id=a.customer_id
JOIN orders as o on o.address_id=a.id
GROUP BY
	c.first_name, 
	c.last_name;
	
--or--	

SELECT DISTINCT	
	c.id,
	COUNT(*) 
FROM customers as c
JOIN addresses as a on c.id=a.customer_id
JOIN orders as o on o.address_id=a.id
GROUP BY
	c.id;


--	6.	How many customers do we have?
SELECT DISTINCT
	COUNT(*)
FROM customers as c

--	7.	How many products do we carry?
SELECT DISTINCT
	COUNT(*)
FROM products as p


--	8.	What is the total available on-hand quantity of diet pepsi?
SELECT DISTINCT
	p.description,
	sum(wp.on_hand)
FROM products as p
JOIN warehouse_product as wp on wp.product_id=p.id
JOIN warehouse as w on w.id=wp.warehouse_id
WHERE p.description = 'diet pepsi'
AND wp.on_hand >= 0
GROUP BY
	p.description;



