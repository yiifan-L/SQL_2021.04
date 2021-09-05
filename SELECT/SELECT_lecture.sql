-- Session 8 - ARTS/LIBR 554 Lecture by Richard Arias-Hernandez
-- IMPORTANT: make sure that you have executed the SQL Script for the 'sales'
-- database provided by the instructor for this session and that once the 
-- 'sales' database has been recreated with the new script, you double click on it
-- to make it the active database (it shows as the green highlighted Schema in the 'object info' pane


-- SELECT statement

SELECT 	*
FROM 	PRODUCT;

SELECT 	P_DESCRIPT, P_CODE
FROM 	PRODUCT;

-- CONDITIONAL select

SELECT 	P_CODE, P_DESCRIPT
FROM 	PRODUCT
WHERE	P_CODE = '2232/QWE';

-- Minimum expression of SELECT and arithmetic operators

SELECT 4 + 5;
SELECT 17.9 - 5.3;
SELECT 5 * 4.3;
SELECT 10 / 3;

-- Using arithmetic operations on numeric attributes to create CALCULATED (DERIVED) ATTRIBUTES

SELECT 	*
FROM 	LINE;

SELECT 	*, LINE_UNITS * LINE_PRICE
FROM	LINE;

-- Using the AS operator to rename regular attributes or calculated attributes (aliases)

SELECT 	*, LINE_UNITS * LINE_PRICE AS 'LINE SUBTOTAL'
-- use a single quote when there is space in the name
FROM	LINE;

-- Conditional SELECT using comparison operators on numeric attribute data types

SELECT 	*
FROM 	PRODUCT
WHERE	P_PRICE != 39.95;

-- Conditional SELECT using comparison operators on datetime attribute data types

SELECT 	*
FROM 	PRODUCT
WHERE	P_INDATE > '2018-01-01';

-- Conditional SELECT using comparison operators on textual attribute data types 

SELECT 	*
FROM 	PRODUCT
WHERE	P_DESCRIPT >= 'Power painter, 15 psi., 3-nozzle';

-- Conditional SELECT using more than one logical condition (predicate) and boolean operator OR

SELECT 	*
FROM 	CUSTOMER;

SELECT 	*
FROM 	CUSTOMER
WHERE	CUS_BALANCE = 0 OR CUS_AREACODE = '713';

-- Conditional SELECT using more than one logical condition (predicate) and boolean operator AND

SELECT 	*
FROM 	CUSTOMER
WHERE	CUS_BALANCE > 500 AND CUS_AREACODE = '615';

-- Conditional SELECT using more than one logical condition (predicate) and boolean operator NOT

SELECT 	*
FROM 	CUSTOMER
WHERE	NOT CUS_AREACODE = '615';

-- Conditional SELECT using more than one boolean operator

SELECT 	*
FROM 	CUSTOMER
WHERE	CUS_AREACODE = '713' AND CUS_BALANCE < 300 OR CUS_LNAME = 'Smith';

SELECT 	*
FROM 	CUSTOMER
WHERE	CUS_AREACODE = '713' AND (CUS_BALANCE < 300 OR CUS_LNAME = 'Smith');
-- in () will be evaluated before AND

SELECT 	*
FROM 	CUSTOMER
WHERE	(CUS_AREACODE = '713' AND CUS_BALANCE < 300) OR CUS_LNAME = 'Smith';

-- Conditional SELECT using the BETWEEN operator

SELECT	*
FROM 	PRODUCT
WHERE 	P_PRICE BETWEEN 5.00 AND 15.00;

-- Note that the previous query is equivalent to this one

SELECT	*
FROM 	PRODUCT
WHERE 	P_PRICE >= 5.00 AND P_PRICE <= 15.00;

-- Conditional SELECT using the IS NULL or the IS NOT NULL operator
-- can you figure out what relevant analytical questions may be behind these two queries?

SELECT	*
FROM 	PRODUCT
WHERE 	V_CODE IS NULL;

SELECT	*
FROM 	PRODUCT
WHERE 	V_CODE IS NOT NULL;

-- Conditional SELECT using the LIKE operator on string (textual) attibutes to find textual patterns

SELECT	*
FROM 	PRODUCT
WHERE 	P_DESCRIPT LIKE '%blade%';

SELECT	*
FROM 	PRODUCT
WHERE 	P_DESCRIPT LIKE 'B&D%';

SELECT	*
FROM 	CUSTOMER
WHERE 	CUS_PHONE LIKE '8_4-2%';

-- Conditional SELECT using the IN operator - note that the data type of values in the list have to match the
-- attribute data type in the logical comparison

SELECT 	*
FROM	VENDOR
WHERE 	V_STATE IN ('FL', 'GA', 'WA');

-- Note that the last query is equivalent to this query

SELECT 	*
FROM	VENDOR
WHERE 	V_STATE = 'FL' OR V_STATE = 'GA' OR V_STATE = 'WA';

-- Using the SELECT statement without and with the DISTINCT option. Notice the difference between these two queries

SELECT 	V_CODE
FROM 	PRODUCT;

SELECT 	DISTINCT V_CODE
FROM 	PRODUCT;

-- Aggregate Functions, such as COUNT(), when used, always go in the select_expression
-- right after the SELECT keyword and before the FROM keyword

SELECT 	COUNT(DISTINCT V_CODE)
FROM 	PRODUCT;
-- the green shows using function

-- Note that COUNT(expression) does not count NULL values. COUNT(*) is somewhat different in that it returns 
-- a count of the number of all rows retrieved, whether or not they contain NULL values.

SELECT COUNT(*)
FROM PRODUCT;

-- MAX(expression) and MIN(expression) are aggregate functions that can be applied on ordered data types
-- (e.g., numeric, textual, or datetime) to return the maximum or minimun values of a specific attribute

SELECT 	MAX(P_PRICE)
FROM 	product; -- can you tell what question is this query answering?

SELECT 	MIN(P_PRICE)
FROM 	product; -- can you tell what question is this query answering?

SELECT 	MAX(P_INDATE)
FROM 	product; -- can you tell what question is this query answering?

SELECT 	MIN(P_INDATE)
FROM 	product;  -- can you tell what question is this query answering?

SELECT 	MAX(P_CODE)
FROM 	product;

SELECT 	MIN(P_CODE)
FROM 	product;

-- SUM(expression) and AVG are aggregate functions that only make sense for numeric datatypes
-- to return the sum or average of all the values of a specific numeric attribute

SELECT 	SUM(P_QOH)
FROM 	product; -- can you tell what question is this query answering?

SELECT 	AVG(P_PRICE)
FROM 	product; -- can you tell what question is this query answering?

-- GROUP BY is an optional clause in the SELECT statement that lets you group
-- rows in your tables by values of specific attributes. These grouping by values
-- can use aggregate functions to provide summaries within these groups

SELECT 	* 
FROM 	VENDOR;

-- lets group rows in VENDOR by V_AREACODE values

SELECT		V_AREACODE
FROM		VENDOR
GROUP BY	V_AREACODE;

-- let's include an aggregate COUNT(*) function to count the number of rows within each V_AREACODE group

SELECT		V_AREACODE, COUNT(*)
FROM		VENDOR
GROUP BY	V_AREACODE;

-- Let's add an alias to the new calculated attribute and sort the table by the count of the rows values

SELECT		V_AREACODE, COUNT(*) AS 'NUMBER OF VENDORS BY AREA CODE'
FROM		VENDOR
GROUP BY	V_AREACODE
ORDER BY    COUNT(*);

-- If you are grouping your rows but do not want to show ALL the groups but only those
-- groups that satisfy a condition then you need to include a HAVING clause with a conditional expression
-- to restrict the output of grups. The HAVING clause always goes right after the GROUP BY clause when used.
-- Note that HAVING is different than WHERE. WHERE creates vertical subsets of table ROWS, while HAVING
-- creates vertical subsets of GROUPS of rows in tables.

SELECT		V_AREACODE, COUNT(*) AS 'NUMBER OF VENDORS BY AREA CODE'
FROM		VENDOR
GROUP BY	V_AREACODE
HAVING		V_AREACODE LIKE '9%'
ORDER BY    COUNT(*);

-- What is wrong with the following query? I want to group the product table by values of V_CODE
-- once I do that I would like to count the number of rows by groups of V_CODE values.
-- can you fix this query to make it work as expected?

SELECT		V_CODE, COUNT(*)
FROM		PRODUCT
GROUP BY	V_CODE;

