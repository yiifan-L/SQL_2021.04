/* 	In-Class Exercise # 10: UNION, VIEW and PROCEDURE on the Pubs Database

	Complete the SQL Statements for this in-class exercise 
    
	Make sure that you have executed the SQL script for the 'pubs' (publications)
	database provided by the instructor with the complete data for all the tables, 
    and that you have made this database the active database by double clicking on
    its name in the SCHEMAS pane (it should show highlighted in green in the "Object
    info" tab.
    
								*/

-- Query #1
-- Using the ‘pubs’ database, create a query that
-- lists all attributes for rows in the “authors” table whose zip code starts with the character ‘9’. 
-- Order by author’s last name.

USE pubs;
SELECT *
FROM author
WHERE AU_ZIP LIKE '9%'
ORDER BY AU_LNAME;


-- Query #2
-- Write a query that lists all attributes for rows in the authors table whose state is not California.
-- Order by author’s last name.

SELECT *
FROM author
WHERE AU_STATE != 'CA'
ORDER BY AU_LNAME;


-- Query #3
-- Are Query #1 & #2 Union Compatible? If so, proceed to write a query that uses the UNION clause
-- to append the rows from the result set in Query #2 to the result set in Query #1. Order by author's last name
-- Note: Remember that you cannot have more than one ORDER BY clause in your query and that it should be the last
-- clause in your query. 

SELECT *
FROM author
WHERE AU_ZIP LIKE '9%'
UNION
SELECT *
FROM author
WHERE AU_STATE != 'CA'
ORDER BY AU_LNAME;

-- Query #4
-- For this query copy Query #3 and paste it here. 
-- Replace the UNION keyword by UNION ALL and execute both QUERY #3 & #4 to compare 
-- both result sets. Can you detect the difference?

SELECT *
FROM author
WHERE AU_ZIP LIKE '9%'
UNION ALL
SELECT *
FROM author
WHERE AU_STATE != 'CA'
ORDER BY AU_LNAME;

-- Query #5
-- Create a view called “ComputerBooks” that displays the title ID and the title names of 'popular_comp' books, 
-- and the last name and first name of their authors, formated as "last name, first name"
-- Remember to include ONLY books whose type is ‘popular_comp’

CREATE VIEW ComputerBooks
AS
SELECT T.TI_ID 'TitleID', T.TI_TITLE 'Title', CONCAT(A.AU_LNAME,', ',A.AU_FNAME) AS 'Author'
FROM title T JOIN titleauthor TA ON T.TI_ID = TA.TI_ID
JOIN author A ON TA.AU_ID = A.AU_ID
WHERE T.TI_TYPE = 'popular_comp';
                    
-- Query #6
-- Write a query that displays all rows in the view 'ComputerBooks' sorted by Author's name

SELECT *
FROM ComputerBooks
ORDER BY Author;

-- Query #7
-- Write a query that displays all rows in the view 'ComputerBooks' sorted by Title's name

SELECT *
FROM ComputerBooks
ORDER BY Title;

-- Query #8
-- Write a query for the 'ComputerBooks' view that returns only rows for which the title ID is 'PC8888'

SELECT *
FROM ComputerBooks
WHERE TitleID = 'PC8888';

-- Query #9
-- Write a query that deletes the view 'ComputerBooks' from the 'pubs' database

DROP VIEW ComputerBooks;

-- Query #10
-- Create a simple stored procedure (no parameters), 
-- called “ListTitles” that lists all the titles in the title table when executed

CREATE PROCEDURE ListTitles ()
SELECT *
FROM title;

-- Query #11
-- Write the SQL statement to execute/call the ListTitles procedure

CALL ListTitles;

-- Query #12
-- Create a more complex procedure (one input parameter), called “ListTitlesByType” 
-- that receives a parameter called “TitleType” with data type CHAR(12). 
-- Your procedure should list all the titles in the title table with a value in title type 
-- equal to the value of title type that the user chooses to provide when executing/calling 
-- this procedure (e.g., 'business', 'popular_comp', 'mod_cook', 'psychology', 'UNDECIDED' ... ). 
-- Order by title id.

CREATE PROCEDURE ListTitlesByType (TitleType CHAR(12))
SELECT *
FROM title
WHERE TI_TYPE = TitleType
ORDER BY TI_ID;

-- Query #13
-- Write the SQL statement to execute/call the ListTitlesByType procedure and try it out
-- with different values: e.g., 'business', 'popular_comp', 'mod_cook', 'psychology', 'UNDECIDED', ...

CALL ListTitlesByType ('psychology');
CALL ListTitlesByType ('UNDECIDED');
CALL ListTitlesByType ('trad_cook');

-- Query #14
-- Create an even more complex procedure (two parameters and joining of two tables), called “EmpInfo” that receives the 
-- last name (VARCHAR(30) and a first name VARCHAR(20) –In that order-  of an employee and lists 
-- the employee id, the employee's name formatted as 'last_name, first_name',  
-- the publisher's name for which this employee works for, and the employee's hire date formatted as 
-- Month name, day of the month with English suffix, and Year numeric four digits ('%M %D %Y')  
-- of that specific employee in that specific order.  NOte that to pull the information of the publisher's
-- name you need to join to the publisher table

CREATE PROCEDURE EmpInfo (LNAME VARCHAR(30), FNAME VARCHAR(20))
SELECT e.EMP_ID AS 'EMPLOYEE ID',
CONCAT(e.EMP_LNAME, ', ', e.EMP_FNAME) AS 'EMPLOYEE NAME',
p.PUB_NAME AS 'EMPLOYER NAME',
DATE_FORMAT(e.EMP_HIREDATE,'%M %D, %Y') AS'DATE HIRED'
FROM employee e JOIN publisher p ON e.PUB_ID = p.PUB_ID
WHERE e.EMP_LNAME = LNAME AND e.EMP_FNAME = FNAME;

-- Query #15
-- Write the SQL statement that calls/executes the EmpInfo procedure
-- for employee Francisco Chang

CALL EmpInfo ('Chang','Francisco');

-- Query #16
-- Create a more complex procedure called “AuthorTitleInfo” that receives an 
-- author’s last name VARCHAR(40) and their first name VARCHAR(20) and lists author id,
-- last name and first name of the author formatted as 'First_Name Last_Name'
-- and all the names of the titles written by such author. 
-- Allow this time for the use of string wildcards in the input parameters (‘%’ and ‘_’) 
-- when the user calls/execute the procedure to find string patterns in the first and last names.
-- HINT: use the LIKE operator

CREATE PROCEDURE AuthorTitleInfo (LNAME VARCHAR(40), FNAME VARCHAR(20))
SELECT a.AU_ID AS 'Author ID',
CONCAT(a.AU_FNAME,' ',a.AU_LNAME) AS 'Author',
t.TI_TITLE AS 'Title'
FROM author a JOIN titleauthor ta ON a.AU_ID = ta.AU_ID
JOIN title t ON t.TI_ID = ta.TI_ID
WHERE a.AU_LNAME LIKE LNAME AND a.AU_FNAME LIKE FNAME;

-- Query #17
-- Call/execute the procedure “AuthorTitleInfo” to list the titles of all authors 
-- whose first name starts with the three characters ‘Ann’
-- Try other variants for parameter values (e.g. all authors with last name: ‘Ringer’, 
-- all authors for which last name starts with ‘G’, pattern for first name: 'Johns_n’, 
-- all authors with any first name and any last name, etc.)

CALL AuthorTitleInfo ('%','Ann%');
CALL AuthorTitleInfo ('Ringer','%');
CALL AuthorTitleInfo ('G%','%');
CALL AuthorTitleInfo ('%','Johns_n');
CALL AuthorTitleInfo ('%','%');

-- Query #18
-- Create a complex procedure called “ListTitlesByDate” 
-- that receives one date parameter (DATETIME) and lists all the titles in the database that were
-- published BEFORE OR ON that date, along with the names of their author(s) properly formatted,
-- and their publication date also properly formatted. Order your result set by publication date.

CREATE PROCEDURE ListTitlesByDate (PUBDATE DATETIME)
SELECT t.TI_TITLE AS 'Title',
CONCAT(a.AU_FNAME,' ',a.AU_LNAME) AS 'Author',
DATE_FORMAT(t.TI_PUBDATE,'%M %D, %Y') AS 'Publication Date'
FROM title t JOIN titleauthor ta ON t.TI_ID = ta.TI_ID
JOIN author a ON a.AU_ID = ta.AU_ID
WHERE t.TI_PUBDATE <= PUBDATE
ORDER BY t.TI_PUBDATE;

-- Query #19
-- Write a SQL statement to test your procedure 'ListTitlesByDate' using the date July 1st, 1991

CALL ListTitlesByDate ('1991-07-01');

-- Query #20 [Optional]
-- Create a store procedure called “AuthorsByTitleID” that receives as an input parameter a 
-- title id VARCHAR(6) and lists the personal data of ALL of the authors of such title 
-- (i.e. last name, first name, address, city, state, zip code, and phone number) ordered by authors’ last name
-- Write also a call/execute statement to test this procedure for title id = ‘TC7777’ 

CREATE PROCEDURE AuthorsByTitleID (titleID VARCHAR(6))
SELECT a.AU_LNAME, a.AU_FNAME, a.AU_ADDRESS, a.AU_CITY, a.AU_STATE,
a.AU_ZIP, a.AU_PHONE
FROM author a JOIN titleauthor ta ON a.AU_ID = ta.AU_ID
WHERE ta.TI_ID = titleID
ORDER BY a.AU_LNAME;
CALL AuthorsByTitleID ('TC7777');

