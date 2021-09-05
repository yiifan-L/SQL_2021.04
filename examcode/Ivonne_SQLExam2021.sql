/*
	ARST/LIBR 554: Database Design
	SQL Exam

	Instructions: Open book, individual quiz. 

	For this SQL quiz, you will use the “pubs” database in MySQL. 
    If you do not have this database, run the “MySQL_instpubs.sql” script 
    that creates a fresh copy of the pubs database. 
    
    Make sure that the “pubs” database is the active database before you run your queries. 

	Write the requested queries for each of the questions in the exam on 
    this SQL Script. Verify that each of your written queries produce the expected result sets.
    Expected result sets for each query are provided as screenshots in Canvas.

	Save constantly this SQL Script file with all your queries and once done with your exam, 
    upload your final version to Canvas.
    
    */
    
    
-- Query #1 (Out of 5)
-- From the "employee" table, list the employee id, last name, first name, 
-- the year of the hire date, and the number of years the employee has worked up 
-- to today’s current date (Hint: you need to use the appropriate SQL datetime Functions). 
-- Include in the result set only employees that were hired after January 1, 1993. 
-- Order the result set by hire date. The query should produce the same result set provided 
-- by the instructor on the exam questions on Canvas.

USE pubs;
SELECT EMP_ID, EMP_LNAME, EMP_FNAME, 
	   YEAR(EMP_HIREDATE) AS 'HIRE YEAR', 
       TIMESTAMPDIFF(YEAR,EMP_HIREDATE,NOW()) AS 'YEARS WORKED'
FROM employee
WHERE EMP_HIREDATE > '1993-01-01'
ORDER BY EMP_HIREDATE;



-- Query #2 (Out of 5)
-- List the title id, title name, title type, notes, and publication date from the "title" table, 
-- for all titles that are not of the type ‘popular_comp’ and for which the string of 
-- characters: ‘computer’ is found anywhere in their title or in their notes. The query 
-- should produce the result set provided by the instructor on the exam questions in Canvas. 
-- Note that the ‘PUBLICATION DATE’ column is a reformatted one that displays the 
-- publication date attribute in the format: Month name (January..December) 
-- Day of the month with English suffix (1st, 2nd, 3rd, …) [comma] Year, numeric, four digits
-- e.g., "November 24th, 2020" Note: the date for  TI_ID = 'MC3026' would be probably different 
-- to you depending on when you created the 'pubs' database.

SELECT TI_ID, TI_TITLE, TI_TYPE, TI_NOTES, DATE_FORMAT(TI_PUBDATE,'%M %D, %Y') AS 'PUBLICATION DATE'
FROM title
WHERE TI_TYPE != 'popular_comp' AND (TI_TITLE LIKE '%computer%' OR TI_NOTES LIKE '%computer%');



-- Query #3 (Out of 5)
-- Sales Report: List all sale numbers, their date using format YYYY-MM-DD, and quantity from the "sale" table; 
-- their store id, and store name from the "store" table; 
-- their title id and price from the "title" table; and a calculated attribute called ‘TOTAL PRICE PER ORDER’ 
-- that shows the result of multiplying sale quantity times the title price for each sale. 
-- Order the result set by store id and by order number. The query should produce the result set 
-- provided by the instructor on the exam questions in Canvas, with sale date formatted as YYYY-MM-DD
-- and the table being ordered first by store id, and then by sale number.

SELECT S.ST_ID, ST_NAME, SALE_NUM,
	   DATE_FORMAT(SALE_DATE,'%Y-%m-%d') AS 'SALE DATE',
       T.TI_ID, SALE_QTY, TI_PRICE, 
       SALE_QTY * TI_PRICE AS 'TOTAL PRICE PER ORDER'
FROM   title T JOIN  sale S 	ON 	T.TI_ID = S.TI_ID
			   JOIN  store ST	ON 	S.ST_ID = ST.ST_ID
ORDER BY S.ST_ID, SALE_NUM;



-- Query #4 (Out of 5)
-- Stores with total sales higher than $1,000: Modify Query #3 to show total sales by store. 
-- List only the store name and include an aggregate function that adds all total prices per 
-- order (obtained in Query #3), but this time by store. Provide this result in a column called 
-- ‘TOTAL SALES BY STORE’ (Hint: you need to create groups to produce totals by store). 
-- Show in your result set only stores with ‘TOTAL SALES BY STORE’ of more than $1,000. Order 
-- your table by store name. Your query should produce the following result set.

SELECT ST_NAME, 
	   SUM(SALE_QTY * T.TI_PRICE) AS 'TOTAL SALES BY STORE'
FROM   title T JOIN  sale S 	ON 	T.TI_ID = S.TI_ID
			   JOIN  store ST	ON 	S.ST_ID = ST.ST_ID
GROUP BY ST.ST_ID
HAVING SUM(SALE_QTY * T.TI_PRICE) > 1000
ORDER BY ST_NAME;



-- Query #5 (Out of 5)
-- Use Query #3 as a basis to create a stored procedure called “SalesByDateRange.” 
-- This procedure receives two parameters: a start date and an end date. 
-- When called/executed, this procedure will show only rows for which the sale date 
-- is within the date range specified by these two parameters, ordered by sale date first, and then by store id.  
-- For example, calling your procedure with the following date values: CALL SalesByDateRange '1994-01-01','1994-12-31'
-- Should produce the result set provided by the instructor on the exam questions in Canvas.

CREATE PROCEDURE SalesByDateRange (STARTDATE DATETIME, ENDDATE DATETIME)
SELECT S.ST_ID, ST_NAME, SALE_NUM,
	   DATE_FORMAT(SALE_DATE,'%Y-%m-%d') AS 'SALE DATE',
       T.TI_ID, SALE_QTY, TI_PRICE, 
       SALE_QTY * TI_PRICE AS 'TOTAL PRICE PER ORDER'
FROM   title T JOIN  sale S 	ON 	T.TI_ID = S.TI_ID
			   JOIN  store ST	ON 	S.ST_ID = ST.ST_ID
WHERE SALE_DATE > STARTDATE AND SALE_DATE < ENDDATE
ORDER BY SALE_DATE, ST.ST_ID;

-- CALL SalesByDateRange ('1994-01-01','1994-12-31');


