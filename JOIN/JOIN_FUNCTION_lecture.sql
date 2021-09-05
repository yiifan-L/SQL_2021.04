-- Session 9 - ARTS/LIBR 554 Lecture by Richard Arias-Hernandez
-- IMPORTANT: make sure that you have executed the SQL Script for the 'sales'
-- database provided by the instructor for the last lecture and that once the 
-- 'sales' database has been (re)created with the SQL script, you double click on it
-- to make it the active database (it shows as the green highlighted Schema in the 'object info' pane)

-- INNER (NATURAL) JOIN of two tables (showing all attributes from both tables). Remember that this type of
-- join operation selects only rows from both tables with matching values on the shared attribute 
-- For example, in the next query V_CODE is the matching attribute (FK in product & PK in vendor).
-- More on the MySQL manual: https://dev.mysql.com/doc/refman/8.0/en/join.html

SELECT 	* 
FROM 	PRODUCT JOIN VENDOR ON PRODUCT.V_CODE = VENDOR.V_CODE;

SELECT 	*
FROM 	CUSTOMER JOIN INVOICE ON CUSTOMER.CUS_CODE = INVOICE.CUS_CODE;




-- INNER (NATURAL) JOIN of two tables (showing partial attributes from both tables). 
-- note that table names can OPTIONALLY be used as prefixes in the SELECT statement (follow by a period)
-- for the attributes names to specify the origin of non-duplicate attribute names. However, if an attribute name
-- is duplicated in both table, then the prefix is MANDATORY, otherwise the SQL compiler 
-- will give you an error because there is an ambiguity.

SELECT 		PRODUCT.P_CODE, PRODUCT.P_DESCRIPT, PRODUCT.P_QOH - PRODUCT.P_MIN AS P_DIFF, VENDOR.V_NAME, VENDOR.V_CONTACT, VENDOR.V_PHONE
FROM 		PRODUCT JOIN VENDOR ON PRODUCT.V_CODE = VENDOR.V_CODE
ORDER BY 	P_DIFF;

-- The following query does not compile correctly
-- Use your knowledge on how to properly use table name as prefixes to eliminate ambiguities in the SELECT
-- expression in the following query and make it work.

SELECT 		P_CODE, P_DESCRIPT, P_QOH - P_MIN AS P_DIFF, VENDOR.V_CODE, V_NAME, V_CONTACT, V_PHONE
FROM 		PRODUCT JOIN VENDOR ON PRODUCT.V_CODE = VENDOR.V_CODE
ORDER BY 	P_DIFF;

-- Aliases are not  only used for table attributes.  They can also be used to replace table names.
-- If we use aliases for table names in the SELECT statement, for example the alias "P" for "product"
-- and the alias "V" for vendor, then our previous query would look like this:

SELECT 		P_CODE, P_DESCRIPT, P_QOH - P_MIN AS P_DIFF, V.V_CODE, V_NAME, V_CONTACT, V_PHONE
FROM 		PRODUCT AS P JOIN VENDOR AS V ON P.V_CODE = V.V_CODE
ORDER BY 	P_DIFF;

-- the reserved keyword AS is optional for aliases, if we eliminate, and we just leave an
-- space between the attribute name, table name, or expression and its alias the query still works

SELECT 		P_CODE, P_DESCRIPT, P_QOH - P_MIN P_DIFF, V.V_CODE, V_NAME, V_CONTACT, V_PHONE
FROM 		PRODUCT P JOIN VENDOR V ON P.V_CODE = V.V_CODE
ORDER BY 	P_DIFF;

-- Follow the instructor to join three tables: invoice, line, and product. 
-- Only the following attributes should be shown:
-- INV_NUMBER, LINE_NUMBER, P_CODE, P_DESCRIPT, LINE_UNITS, and LINE_PRICE

SELECT I.INV_NUMBER, LINE_NUMBER, L.P_CODE, P_DESCRIPT, LINE_UNITS, LINE_PRICE
FROM INVOICE I JOIN LINE L ON I.INV_NUMBER = L.INV_NUMBER
			   JOIN PRODUCT P ON L.P_CODE = P.P_CODE
ORDER BY LINE_PRICE;



-- LEFT JOIN 
-- More on the MySQL manual: https://dev.mysql.com/doc/refman/8.0/en/join.html

SELECT 	P_CODE, P_DESCRIPT, PRODUCT.V_CODE, VENDOR.V_CODE, V_NAME, V_AREACODE 
FROM 	PRODUCT LEFT JOIN VENDOR ON PRODUCT.V_CODE = VENDOR.V_CODE;


SELECT 	P_CODE, P_DESCRIPT, PRODUCT.V_CODE, VENDOR.V_CODE, V_NAME, V_AREACODE
FROM 	PRODUCT LEFT JOIN VENDOR ON PRODUCT.V_CODE = VENDOR.V_CODE
WHERE 	VENDOR.V_CODE IS NULL;

-- RIGHT JOIN
-- More on the MySQL manual: https://dev.mysql.com/doc/refman/8.0/en/join.html

SELECT 	P_CODE, P_DESCRIPT, PRODUCT.V_CODE, VENDOR.V_CODE, V_NAME, V_AREACODE
FROM 	PRODUCT RIGHT JOIN VENDOR ON PRODUCT.V_CODE = VENDOR.V_CODE;

SELECT 	P_CODE, P_DESCRIPT, PRODUCT.V_CODE, VENDOR.V_CODE, V_NAME, V_AREACODE 
FROM 	PRODUCT RIGHT JOIN VENDOR ON PRODUCT.V_CODE = VENDOR.V_CODE
WHERE	PRODUCT.V_CODE IS NULL;

-- SQL Functions
-- Sometimes the data in your database is not exactly in the way you need it and you will be required to 
-- manipulate it and change it. For example: splitting a datetime attribute into month, day or year components, 
-- rounding decimal numbers, concatenating two string attributes, etc. For these cases, you will use SQL functions
-- There are many types of SQL functions, such as arithmetic, trigonometric, string, date, and time functions.
-- Below, some commonly used ones. More on the MySQL manual: https://dev.mysql.com/doc/refman/8.0/en/functions.html

-- String Functions: Concatenate CONCAT(string1,string2,...)

SELECT 	*
FROM	CUSTOMER;

SELECT 	CUS_CODE, 
		CONCAT(CUS_LNAME,', ',CUS_FNAME,' ',CUS_INITIAL) AS CUS_NAME,
		CONCAT('(',CUS_AREACODE,') ',CUS_PHONE) AS CUS_PHONE_NUMBER, 
        CUS_BALANCE
FROM	CUSTOMER; 

-- String Functions: SUBSTRING(str,pos), SUBSTRING(str,pos,len)
-- Using the function without a len argument returns a substring from 
-- string 'str' starting at position 'pos' until the end of the string. 
-- Using the function with a len argument return a substring 'len' characters 
-- long from string 'str', starting at position 'pos'.

SELECT SUBSTRING('UBC School of Information',5);
SELECT SUBSTRING('UBC School of Information',15);
SELECT SUBSTRING('UBC School of Information',5,6);
SELECT SUBSTRING('UBC School of Information',15,4);

-- Correct the following query to make it list only the first 10 characters of the product description
-- for all products in the product table. 

SELECT 		P_DESCRIPT, SUBSTRING(P_DESCRIPT, 1, 10) AS 'SHORT DESCRIPTION'
FROM		PRODUCT
ORDER BY	P_DESCRIPT;

-- String Functions: UPPER(str) & LOWER(str) - all uppercase or all lowercase letters

SELECT 	V_CODE, V_NAME, V_CONTACT
FROM 	VENDOR;

SELECT 	V_CODE, LOWER(V_NAME), UPPER(V_CONTACT)
FROM 	VENDOR;

-- Datetime functions: CURDATE(), CURRENT_DATE(), CURRENT_DATE

SELECT CURRENT_DATE();

-- Datetime functions: CURTIME(), CURRENT_TIME(), CURRENT_TIME

SELECT CURRENT_TIME();

-- Datetime functions: CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP, NOW()

SELECT NOW();

-- Datetime function: YEAR(datetime), MONTH(datetime), WEEK(datetime), DAY (datetime)

SELECT YEAR(NOW());

SELECT MONTH(NOW());

SELECT MONTHNAME(NOW());

SELECT WEEK(NOW());

SELECT DAY(NOW());

-- Datetime function: DATE_FORMAT(date, format) Formats the date value according to the format string
-- The format string can contain any of the following specifiers (more on the MySQL manual)
-- %M: Month name (January..December)
-- %m: Month, numeric (00..12)
-- %b: Abbreviated month name (Jan..Dec)
-- %d: Day of the month, numeric (00..31)
-- %D: Day of the month with English suffix (0th, 1st, 2nd, 3rd, …)
-- %W: Weekday name (Sunday..Saturday)
-- %a: Abbreviated weekday name (Sun..Sat)
-- %Y: Year, numeric, four digits
-- %y: Year, numeric (two digits)
-- Source: MySQL Manual https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format

SELECT 	P_CODE, DATE_FORMAT(P_INDATE, '%m/%d/%y') -- 2-digit month number+'/'+number of day of month+'/'+2-digit year
FROM 	PRODUCT;

SELECT 	P_CODE, DATE_FORMAT(P_INDATE, '%M %D, %Y') -- name of month+space+day of month with English suffix+', '+four-digit year 
FROM 	PRODUCT;

SELECT 	DATE_FORMAT(NOW(), '%M %D, %Y');

-- Datetime Function: TIMESTAMPADD(unit,interval,datetime_expr)
-- This function performs date arithmetic by adding datetime units to a datetime attribute
-- TIMESTAMPADD adds the integer expression 'interval' to the date or datetime expression 'datetime_expr'. 
-- The unit for 'interval' is given by the 'unit' argument. 'unit' should be one of the following 
-- values: MICROSECOND (microseconds), SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER, or YEAR.
-- Source: MySQL Manual https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_timestampadd

SELECT TIMESTAMPADD(MINUTE,1,'2003-01-02'); -- adds 1 minute to the datetime '2003-01-02'

SELECT  P_CODE, P_INDATE, TIMESTAMPADD(MONTH, 1, P_INDATE) 
FROM 	PRODUCT;

-- Datetime Function: TIMESTAMPDIFF(unit,datetime_expr1,datetime_expr2)
-- This function performs date arithmetic by substracting one datetime from another
-- TIMESTAMPDIFF returns datetime_expr2 − datetime_expr1, where datetime_expr1 and datetime_expr2 
-- are date or datetime expressions. One expression may be a date and the other a datetime; 
-- a date value is treated as a datetime having the time part '00:00:00' where necessary. 
-- The unit for the result (an integer) is given by the 'unit' argument. 
-- The legal values for 'unit' are the same as those listed in the description of the TIMESTAMPADD() function.
-- Source: MySQL Manual https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_timestampdiff

SELECT TIMESTAMPDIFF(MONTH,'2003-02-01','2003-05-01');
SELECT TIMESTAMPDIFF(MONTH,'2003-05-01','2003-02-01');

-- change the date on the next query to your birthdate: what is the meaning of the result?

SELECT TIMESTAMPDIFF(DAY,'1998-05-09',NOW());

-- Test TIMESTAMPDIFF in a query on the PRODUCT table

SELECT 		P_CODE, P_INDATE, TIMESTAMPDIFF(DAY,P_INDATE,NOW()) AS 'DAYS IN THE INVENTORY'
FROM 		PRODUCT
ORDER BY 	TIMESTAMPDIFF(DAY,P_INDATE,NOW()) DESC;


-- Numeric functions: e.g., ROUND(X) rounds a decimal to the next integer value, 
-- ROUND(X,D) Rounds the argument X to D decimal places. 

SELECT 	P_CODE, P_DESCRIPT, P_PRICE, ROUND(P_PRICE, 1)
FROM 	PRODUCT;

-- From one data type to another: CONVERT(expression, desired data type)
-- The CONVERT() function takes an 'expression' of any type and produces a result value of the 'desired data type'
-- 'desired data type' permitted are: BINARY, CHAR[(N)], DATE, DATETIME
-- DECIMAL[(M[,D])], FLOAT[(p)], DOUBLE - Other data types are not allowed for 'desired data type'
-- Source: https://dev.mysql.com/doc/refman/8.0/en/cast-functions.html#function_convert

SELECT 	CONVERT(1944.35, CHAR(7));
SELECT 	SUBSTRING(CONVERT(1944.35, CHAR(7)),2,2);

SELECT CONVERT('21225',DECIMAL(5));
SELECT CONVERT('21225',DECIMAL(5)) / 5;



