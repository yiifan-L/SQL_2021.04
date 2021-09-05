-- Session 10 - ARTS/LIBR 554 Lecture: UNION, VIEWs and STORED PROCEDUREs
-- By Richard Arias-Hernandez

-- IMPORTANT: make sure that you have executed the SQL Script for the 'pubs'
-- database provided by the instructor for this session and that once the 
-- 'pubs' database has been created or recreated with the new script, you double click on it
-- to make it the active database (it shows as the green highlighted Schema in the 'object info' pane)

-- Review of JOINs
-- What is wrong with the following query? How would you fix it?

SELECT 		T.TI_ID 'Title ID', 
			T.TI_TITLE 'Title', 
            CONCAT(A.AU_LNAME,', ',A.AU_FNAME) AS 'Author''s Name'
FROM		TITLE T JOIN TITLEAUTHOR TA JOIN AUTHOR A
ORDER BY	T.TI_ID;

-- UNION clause to append the content of two or more tables
/* 
	UNION clause combines rows resulting from two or more SELECT statements without including duplicate rows
	Each SELECT statement can have its own WHERE clause
	It can only have one ORDER BY clause, and it must be in the last SELECT statement
	Syntax:
				query_1 
				UNION 
				query_2
	UNION clause only works properly if tables are union-compatible
	Number of table attributes must be the same and their data types must be alike/compatible.
	UNION ALL works similarly to UNION with the only exception that UNION ALL includes duplicate rows in the result set.
    More: https://dev.mysql.com/doc/refman/8.0/en/union.html 
*/


USE SALES;

SELECT 	P_CODE, P_DESCRIPT, P.V_CODE, V.V_CODE, V_NAME, V_AREACODE 
FROM 	PRODUCT P LEFT JOIN VENDOR V ON P.V_CODE = V.V_CODE;

SELECT 	P_CODE, P_DESCRIPT, P.V_CODE, V.V_CODE, V_NAME, V_AREACODE 
FROM 	PRODUCT P RIGHT JOIN VENDOR V ON P.V_CODE = V.V_CODE;


-- VIEWS in MySQL
/* 
	Views are virtual tables based on a SELECT statement that provides the definition for the view.
	They are a great way to provide partial views of the data for purposes of privacy/security
	or for having at hand commonly used queries as quick to generate data reports.

	A view can contain attributes, aliases, computed attributes, and aggregate functions from one or several tables
    
    Syntax:
    
			CREATE VIEW view_name
			AS select_statement
    
    More: https://dev.mysql.com/doc/refman/8.0/en/create-view.html
*/

-- The author table in pubs has private information about the authors in the database such as their phone numbers
-- and addresses. The author_public view below provides only partial access to some attributes of this table that can be openly
-- provided to anyone to identify an author's ID in the database.

CREATE VIEW AUTHOR_PUBLIC
AS
SELECT 	AU_ID AS 'Author ID', AU_LNAME AS 'Last Name', AU_FNAME AS 'First Name'
FROM 	AUTHOR;

-- The tables 'title' and 'author' contain good information for customers interested in knowing about 
-- the available catalogue. However, there is lots of private information that a regular customer 
-- should not be accessing (e.g. Year to date sales, author's phone number, etc.).
-- Create a view called 'Catalogue' for customers to consult that only provides the title id, the title name, and 
-- names of the corresponding authors.
-- Format the name of each author as "last name, first name." Ordered by Title ID.

CREATE VIEW CATALOGUE
AS
SELECT 		T.TI_ID 'TitleID', 
			T.TI_TITLE 'Title', 
            CONCAT(a.AU_LNAME,', ',a.AU_FNAME) AS 'Author'
FROM 		TITLE T JOIN TITLEAUTHOR TA ON T.TI_ID = TA.TI_ID
					JOIN AUTHOR	A  		ON A.AU_ID = TA.AU_ID
ORDER BY 	T.TI_ID;

-- Querying a view as a table

SELECT 	*
FROM	CATALOGUE;

SELECT 	*
FROM	CATALOGUE
WHERE	TITLEID = 'BU1111';

SELECT 	*
FROM 	CATALOGUE
WHERE 	AUTHOR LIKE 'G%';

-- Dropping the View

DROP VIEW CATALOGUE;

-- store PROCEDURE
/*
	Store procedures are saved collections of SQL statements that can take 
    user-supplied parameters and return result sets according to the value of those parameters.
	They can also be used to encapsulate business transactions 
    (e.g. a procedure that inserts data of a new sale transaction in multiple tables at once in the pubs database).
    and secure queries done to the database. For example, applications and users could have no access to the database 
    tables directly, but only be allowed to execute specific stored procedures.
    
    Syntax:
    
			CREATE PROCEDURE sp_name ([[ IN | OUT | INOUT ] param_name type[,...]]) 
			routine_body: Valid SQL routine statement

	Note that the opening and closing parentheses are mandatory in this syntax whether you include any parameters or not.
	By default an entered parameter is IN (input) parameter unless specified differently.
    
    Read more on stored procedures: https://dev.mysql.com/doc/refman/8.0/en/create-procedure.html
*/

-- Simplest case a stored procedure with NO parameters.
-- The following procedure lists all titles in the database and some of their publishers info
-- it does not require any parameters

USE PUBS;
CREATE PROCEDURE TITLE_PUBLISHER ()
	SELECT 		T.TI_ID, 
				T.TI_TITLE,
				P.PUB_NAME,
                P.PUB_CITY
    FROM 		TITLE T JOIN PUBLISHER P ON T.PUB_ID = P.PUB_ID
    ORDER BY 	T.TI_ID;

-- execute the created procedure by using the CALL statement
-- Syntax:
-- 					CALL sp_name([parameter[,...]])
-- 					CALL sp_name[()]
-- If IN parameters were defined in the stored procedure, then they have to be provided
-- when executing/calling the procedure in the exact order as specified in the definition
-- of the procedure and providing values that correspond exactly 1-to-1 to the defined datatypes
-- of the expected input parameters.
-- More: https://dev.mysql.com/doc/refman/8.0/en/call.html

	CALL TITLE_PUBLISHER;
    
    CALL TITLE_PUBLISHER();
    
-- Second case: a stored procedure with ONE INPUT parameter.
-- The following example shows a simple stored procedure that, given a type of author contract (1 or 0), 
-- lists the authors' IDs and names for that type of contract that appear in the author table of the pubs database. 
-- The value of a specific type of contract (1 or 0) is provided by the user and it is passed using an IN parameter, 
-- no parameter is output/returned.

USE PUBS;
CREATE PROCEDURE AUTHOR_BY_CONTRACT_TYPE (CONT_TYPE BIT(1))
         SELECT 	*
         FROM 		AUTHOR
         WHERE 		AU_CONTRACT = CONT_TYPE;
         
-- execute the created procedure by using the CALL statement

CALL AUTHOR_BY_CONTRACT_TYPE (1);

CALL AUTHOR_BY_CONTRACT_TYPE (0);

CALL AUTHOR_BY_CONTRACT_TYPE (5);

CALL AUTHOR_BY_CONTRACT_TYPE ('Ringer');

CALL AUTHOR_BY_CONTRACT_TYPE (0, 1);

-- Third case: a stored procedure with more than 1 input parameter

-- We complete Query #14 and #15 of the In-Class Exercise together:

-- Query #14
-- Create an even more complex procedure (two parameters and joining of two tables), called “EMPINFO” that receives the 
-- last name (VARCHAR(30) and a first name VARCHAR(20) –In that order-  of an employee and lists 
-- the employee id, the employee's name formatted as 'last_name, first_name',  
-- the publisher's name for which this employee works for, and the employee's hire date formatted as 
-- Month name, day of the month with English suffix, and Year numeric four digits ('%M %D %Y')  
-- of that specific employee in that specific order.  NOte that to pull the information of the publisher's
-- name you need to join to the publisher table

/* delete this line and write your SQL query here */

-- Query #15
-- Write the SQL statement that calls/executes the EmpInfo procedure
-- for employee Francisco Chang

/* delete this line and write your SQL query here */

-- Dropping a stored procedure

DROP PROCEDURE EMPINFO;
