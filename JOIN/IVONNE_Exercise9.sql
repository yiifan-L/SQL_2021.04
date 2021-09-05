
/* 	In-Class Exercise # 9: JOINS and Functions on the Pubs Database

	Complete the SQL Statements for this in-class exercise 
    
	Make sure that you have executed the SQL script for the 'pubs' (publications)
	database provided by the instructor with the complete data for all the tables, 
    and that you have made this database the active database by double clicking on
    its name in the SCHEMAS pane (it should show highlighted in green in the "Object
    info" tab.
    
								*/

-- Query #1
-- Using the ‘pubs’ database, create a query that joins tables “title” and “publisher” 
-- and displays only rows with matching values in both tables (i.e. INNER (NATURAL) JOIN). 
-- include all attributes from both tables.

SELECT *
FROM title JOIN publisher ON title.PUB_ID=publisher.PUB_ID;


-- Query #2
-- Modify your previous query (#1) to display only the following attributes:
-- from the title table: TITLE ID and TITLE
-- from the publishers table: NAME, CITY and STATE
-- sort this table by TITLE ID

SELECT title.TI_ID, title.TI_TITLE,
publisher.PUB_NAME, publisher.PUB_CITY, publisher.PUB_STATE
FROM title JOIN publisher ON title.PUB_ID=publisher.PUB_ID
ORDER BY title.TI_ID;

-- Query #3
-- Refine your previous query (#2) by assigning aliases to your tables

SELECT t.TI_ID, t.TI_TITLE, p.PUB_NAME, p.PUB_CITY, p.PUB_STATE
FROM title t JOIN publisher p ON t.PUB_ID=p.PUB_ID
ORDER BY t.TI_ID;

-- Query #4
-- Joining three tables:
-- Write a query that list TITLE ID and TITLE from all titles in the TITLES table, 
-- and the LAST NAME and FIRST NAME of the respective authors from the AUTHORS table.
-- order by TITLE ID.

SELECT title.TI_ID, title.TI_TITLE, author.AU_LNAME, author.AU_FNAME
FROM title JOIN titleauthor ON title.TI_ID=titleauthor.TI_ID
JOIN author ON titleauthor.AU_ID=author.AU_ID
ORDER BY title.TI_ID;

-- Query #5
-- WHERE conditions and JOINS:
-- Modify the previous query (#4) to show only the titles written by Anne Ringer

SELECT title.TI_ID, title.TI_TITLE,
author.AU_LNAME, author.AU_FNAME
FROM title JOIN titleauthor ON title.TI_ID=titleauthor.TI_ID
JOIN author ON titleauthor.AU_ID=author.AU_ID
WHERE AU_LNAME='Ringer' AND AU_FNAME='Anne'
ORDER BY title.TI_ID;

-- Query #6
-- Outer joins:
-- List the TITLE ID and the TITLE from the “TITLES” table; 
-- the sale number, sale date, and sale quantity from the “SALES” table. 
-- Your result set should include not only the rows from the “TITLE” table 
-- with matching values in the “SALES” table, but also ALL the rows in the “TITLE” 
-- table including those with unmatched values in the “SALES” table. 
-- order the result set by the title id. 

SELECT title.TI_ID, title.TI_TITLE,
sale.SALE_NUM, sale.SALE_DATE, sale.SALE_QTY
FROM title LEFT JOIN sale ON title.TI_ID=sale.TI_ID
ORDER BY title.TI_ID;


-- Query #7
-- Write a query for the "author" table that uses the CONCAT(str1, str2,...) function
-- to show ONLY the names of all of the authors in the database in one column called 'AUTHORS'
-- formatted in the following way: last name, first name (e.g., White, Johnson)
-- sort the list alphabetically by last name

SELECT CONCAT(AU_LNAME,',',AU_FNAME) AS AUTHOR
FROM author
ORDER BY AU_LNAME;


-- Query #8
-- Reformat Query # 4 to combine the attributes AU_LNAME and AU_FNAME
-- in one single calculated attribute called 'AUTHOR NAME'
-- using the format: lastname, firstname (e.g. Carson, Cheryl or O'Leary, Michael)
-- Also rename TI_ID as 'TITLE ID' and TI_TITLE as 'TITLE NAME'
-- Sort results by TI_ID

SELECT title.TI_ID 'TITLE ID',title.TI_TITLE'TITLE NAME',
CONCAT (author.AU_LNAME,',',author.AU_FNAME) AS 'AUTHOR NAME'
FROM title JOIN titleauthor ON title.TI_ID=titleauthor.TI_ID
JOIN author ON titleauthor.AU_ID=author.AU_ID
ORDER BY title.TI_ID; 

              
-- Query #9
-- Modify the previous query to show only the first 20 characters of the title name

SELECT title.TI_ID 'TITLE ID',
	SUBSTRING(title.TI_TITLE,1,20) 'TITLE NAME',
	CONCAT(author.AU_LNAME,',',author.AU_FNAME) AS 'AUHTOR NAME'
FROM title JOIN titleauthor ON title.TI_ID=titleauthor.TI_ID
JOIN author ON titleauthor.AU_ID = author.AU_ID
ORDER BY title.TI_ID;


-- Query #10
-- Take Query #9 and add the publication date from titles and a new derived attribute called ‘NEW DATE’ 
-- which adds 60 days to the original publication date. include only rows with a new date later than 
-- december 1st, 1991 in the result set. format all dates as "name of month+space+number of day of month+four-digit year"
-- order by the new date.

SELECT title.TI_ID'TITLE ID',
SUBSTRING(title.TI_TITLE,1,20)'TITLE NAME',
CONCAT(author.AU_LNAME,',',author.AU_FNAME)AS'AUTHOR NAME',
DATE_FORMAT(title.TI_PUBDATE,'%M %d, %Y') AS 'PUBLICATION DATE',
DATE_FORMAT (TIMESTAMPADD (DAY, 60, title.TI_PUBDATE), '%M %d, %Y') AS 'NEW DATE'
FROM title JOIN titleauthor ON title.TI_ID=titleauthor.TI_ID
JOIN author ON titleauthor.AU_ID=author.AU_ID
WHERE TIMESTAMPADD (DAY,60,title.TI_PUBDATE)>'1991-12-01'
ORDER BY TIMESTAMPADD (DAY,60,title.TI_PUBDATE);


-- Query #11
-- Take Query #10, and replace ‘NEW DATE’ with a derived attribute called ‘DAYS SINCE PUBLICATION’ 
-- that calculates the number of days since the title was published. select only rows that for 
-- which days since publication is less than 10,000. order by publication date.

SELECT title.TI_ID'TITLE_ID',
SUBSTRING(title.TI_TITLE,1,20)'TITLE NAME',
CONCAT(author.AU_LNAME,',',author.AU_FNAME) AS 'AUTHOR NAME',
DATE_FORMAT(title.TI_PUBDATE, NOW())AS 'DAYS SINCE PUBLICATION'
FROM title JOIN titleauthor ON title.TI_ID = titleauthor.TI_ID
JOIN author ON titleauthor.AU_ID = author.AU_ID
WHERE TIMESTAMPDIFF(DAY,title.TI_PUBDATE,NOW())<10000
ORDER BY title.TI_PUBDATE;


-- Query #11a [OPTIONAL]
-- Can you figure out how to modify Query #11 to replace the column 'DAYS SINCE PUBLICATION' by
-- a column called 'YEARS SINCE PUBLICATION' using datetime functions to show how many
-- year have passed since each title have been published? show all the rows in this table
-- and sort the table by publication date

SELECT title.TI_ID'TITLE ID',
SUBSTRING(title.TI_TITLE,1,20)'TITLE NAME',
CONCAT(author.AU_LNAME,',',author.AU_FNAME) AS 'AUTHOR NAME',
DATE_FORMAT(title.TI_PUBDATE, NOW()) AS'YEARS SINCE PUBLICATION'
FROM title JOIN titleauthor ON title.TI_ID=titleauthor.TI_ID
JOIN author ON titleauthor.AU_ID = author.AU_ID
ORDER BY title.TI_PUBDATE;


-- Query #12: Using GROUP BY on JOINed tables
-- Write a query that joins the table "title" and the table "sale" (natural -inner- join)
-- Group the table by store id and then by title id. Provide the following attributes:
-- store ID, title ID, title name, and a final attribute with the number of copies sold by
-- store for each title  called 'NUMBER OF COPIES SOLD BY STORE'

SELECT sale.ST_ID, title.TI_ID, title.TI_TITLE, COUNT(*) AS 'NUMBER OF TRANSACTIONS BY TITLE REPORTED BUY STORE'
FROM title JOIN sale ON title.TI_ID = sale.TI_ID
GROUP BY sale.ST_ID, title.TI_ID
ORDER BY sale.ST_ID;


-- Save all your queries that you wrote on this script and upload the saved file to Canvas




