/* Complete the SQL Statements for this in-class exercise 
   Make sure that you have executed the SQL script for the 'sales'
   database provided by the instructor with the complete data for 
   all the tables */

-- Query #1
-- Write a query that shows all the data (all attributes and all rows) in the vendor table

/* delete this line and write your query here */

-- Query #2
-- Write a query for the vendor table that shows ONLY the vendor name, the vendor state, the vendor arecode, 
-- and the vendor phone number (IN THAT ORDER) for all the rows in the vendor table

/* delete this line and write your query here */

-- Query #3
-- Write a query for the vendor table that shows ONLY the vendor name, the vendor state, the vendor arecode, 
-- and the vendor phone number (IN THAT ORDER) for all the rows in the vendor table that
-- satisfy the condition that their vendor areacode is '615'

/* delete this line and write your query here */

-- Query #4
-- Write a query for the product table that creates a calculated attribute that substracts the
-- number of minimum products to have on the inventory (P_MIN) from the products on hand (P_QOH) 
-- in order to know how far from the threshold to order new products we are. Show all rows but
-- show only the following attributes: product code, product name, quantity on hand, minimum number
-- in inventory and your newly created attribute. Use an alias to name your calculated attribute P_DIFFERENCE

/* delete this line and write your query here */

-- Query #5
-- Write a query for the customer table that shows all attributes for 
-- all customers with a positive balance in their accounts that are not in the areacode '713'

/* delete this line and write your query here */

-- Query #6
-- Correct the following query to make sure that precedence is given first to the ORs and then later to the AND
-- In other words first the logical comparisons using the OR operator have to be evaluated and then
-- their result has to be evaluated with the AND operator (Hint: your result dataset should have only 5 rows)

USE sales;
SELECT 	* 
FROM 	PRODUCT
WHERE 	P_INDATE > '2018-01-01' OR P_DISCOUNT = 0.00 AND V_CODE = '23119' OR V_CODE = '25595';

-- Query #7
-- Write a query for the product table that lists all of the products that include in their 
-- description the string ‘saw’ either as a word in itself, a prefix (stem) of a word, or 
-- a suffix of a word (last part of a word)

/* delete this line and write your query here */

-- Query #8
-- Write a query for the customer table that lists all of the customers 
-- with a telephone number whose next to last digit is 8

/* delete this line and write your query here */

-- Query #9
-- Optimize the following query using the IN operator

SELECT 	* 
FROM 	PRODUCT
WHERE 	P_MIN = 5 OR P_MIN = 6 OR P_MIN = 7 OR P_MIN = 8 OR P_MIN = 9 OR P_MIN = 10;

-- Query #10
-- Write a query for the vendor table that creates an ordered list of all vendors sorted 
-- first by area code and then by vendor code

/* delete this line and write your query here */

-- Query #11
-- Create a query in the product table that calculates the total value of the inventory. Note that you need to 
-- aggregate all the values per product (number of units on hand times their price per unit) in the product table
-- (Hint: answer should be: 15084.52)

/* delete this line and write your query here */

-- Query #12
-- Create a query for the vendor table that groups vendors by state and counts the number of vendors per state

/* delete this line and write your query here */

-- Save all your queries that you wrote on this script and upload the saved file to Canvas




