-- writing 2 dashes creates a line of comments that will be ignored by the compiler
/* writing forward slash (/) and star (*) creates a block of multiple lines of comments
that will be ignored by the compiler. 
The block of line comments is closed by typing the reverse: star (*) and forward slash (/) */

-- CREATING A DATABASE : to begin this exercise, write and execute the SQL statement that creates a database called "sales"

CREATE DATABASE sales;

-- Refresh the "SCHEMAS" pane on the left, and verify that the "sales" database has been created, review the directory
-- structure and files that gets created when you execute this statement


/* Below, the "USE sales;" SQL statement makes sure that the database "sales" is selected 
   before executing the any other SQL query, so that following queries get applied to this specific database.
   If "sales" is already the selected database then the statement is redundant, but if another database is 
   active, then this USE statement makes sure that the query is applied to the correct database.*/
   
USE sales;

-- PART1: Use the information in the ERD from the conceptual design and the data dictionary to write and
-- execute the SQL query that creates the table "vendor," its attributes, and its contraints
 
USE sales;
CREATE TABLE vendor (
	V_CODE INT  NOT NULL  UNIQUE,
    V_NAME VARCHAR(35) NOT NULL,
    V_CONTACT VARCHAR(25) NOT NULL,
    V_AREACODE CHAR(3) NOT NULL,
    V_PHONE CHAR(8) NOT NULL,
    V_STATE CHAR(2) NOT NULL,
    V_ORDER CHAR(1) NOT NULL,
    PRIMARY KEY (V_CODE)
);

-- Now, review and execute the following block of SQL statements that the instructor has prepared to create
-- the table "product." Notice that V_CODE is a Foreing Key in the table that is used to establish a relationship
-- with the previously created table "vendor"

USE sales;
CREATE TABLE product (
P_CODE 			VARCHAR(10) 	NOT NULL UNIQUE,
P_DESCRIPT 		VARCHAR(35) 	NOT NULL,
P_INDATE 		DATE 			NOT NULL,
P_QOH 			SMALLINT 		NOT NULL,
P_MIN 			SMALLINT 		NOT NULL,
P_PRICE 		DECIMAL(8,2) 	NOT NULL,
P_DISCOUNT 		DECIMAL(5,2) 	NOT NULL,
V_CODE 			INT,
PRIMARY KEY (P_CODE),
FOREIGN KEY (V_CODE) REFERENCES vendor (V_CODE) ON UPDATE CASCADE);

-- Now review the table structure of the "vendor" and "product" tables using the interface features in design view
-- Review the syntax of the queries, the placing of commas and semicolons; the location of contraints; and the 
-- following of best practices such as indentation to make your code more readable.

-- PART 2: review column constraints, table constraints, PKs, FKs, default values and check constraints in the 
-- following SQL queries. Then execute all this SQL block at once to create the tables: "customer," "invoice," and "line."

USE sales;
CREATE TABLE customer (
CUS_CODE 		INT 			PRIMARY KEY,
CUS_LNAME 		VARCHAR(15) 	NOT NULL,
CUS_FNAME 		VARCHAR(15) 	NOT NULL,
CUS_INITIAL 	CHAR(1),
CUS_AREACODE 	CHAR(3) 		DEFAULT '615' NOT NULL CHECK(CUS_AREACODE IN ('615','713','931')),
CUS_PHONE 		CHAR(8) 		NOT NULL,
CUS_BALANCE 	DECIMAL(9,2) 	DEFAULT 0.00,
CONSTRAINT CUS_UI1 UNIQUE (CUS_LNAME, CUS_FNAME));

CREATE TABLE invoice (
INV_NUMBER 		INT 			PRIMARY KEY AUTO_INCREMENT,
CUS_CODE 		INT 			NOT NULL,
INV_DATE 		DATE 			DEFAULT (CURRENT_DATE) NOT NULL,
FOREIGN KEY (CUS_CODE) REFERENCES customer (CUS_CODE),
CONSTRAINT INV_CK1 CHECK (INV_DATE > '2018-01-01'));

CREATE TABLE line (
INV_NUMBER 		INT 			NOT NULL,
LINE_NUMBER 	DECIMAL(2,0) 	NOT NULL,
P_CODE 			VARCHAR(10) 	NOT NULL,
LINE_UNITS 		DECIMAL(9,2) 	DEFAULT 0.00 NOT NULL,
LINE_PRICE 		DECIMAL(9,2) 	DEFAULT 0.00 NOT NULL,
PRIMARY KEY (INV_NUMBER, LINE_NUMBER),
FOREIGN KEY (INV_NUMBER) REFERENCES invoice(INV_NUMBER) ON DELETE CASCADE,
FOREIGN KEY (P_CODE) REFERENCES product(P_CODE),
CONSTRAINT LINE_UI1 UNIQUE(INV_NUMBER, P_CODE));

-- PART 3: INDEXES
-- Write and execute SQL DDL queries to create and delete indexes on tables. Execute them and review the results
-- on the design view of the respective table

-- Write and execute a SQL Query that creates an index called P_INDATEX on the attribute P_INDATE in the table "product"

USE sales;
CREATE INDEX P_INDATEX ON product (P_INDATE);

-- Write and execute a SQL Query that creates a composite index called VENPRODX on V_CODE and P_CODE in the table "product"

USE sales;
CREATE INDEX VENPRODX ON product (V_CODE, P_CODE);

-- Write and execute a SQL Query that creates an index called PROD_PRICEX on P_PRICE in the table "product"in descendent order

USE sales;
CREATE INDEX PROD_PRICEX ON product (P_PRICE DESC);

-- Write and execute a SQL Query that deletes the PROD_PRICEX index from the "product" table

USE sales;
DROP INDEX PROD_PRICEX ON product;

-- Reverse Engineer the ERD for this database in MySQL and compare the result to the ERD in the conceptual design

-- PART 4: You are going to write and execute a few SQL queries for Data Manipulation to insert, update, and 
-- delete data from your tables in the "sales" database

-- Write and execute a SQL Query that inserts one row in the table "vendor" with the following values V_CODE should be 21225,
-- V_NAME should be 'Bryson, Inc.', V_CONTACT should be 'Smithson', V_AREACODE should be '615', V_PHONE should be '223-3234'
-- V_STATE should be 'TN', and V_ORDER should be 'Y'. All attributes in this table are required (NOT NULL) so failing
-- to include one of these values will result in an error for your query.

USE sales;
INSERT INTO vendor VALUES ('21225', 'Bryson, Inc.', 'Smithson', '615', '223-3234', 'TN', 'Y');

-- Execute the following two SQL statements to list all the rows in the table "vendor," your newly inserted row should be there

USE sales;
SELECT * FROM vendor;

-- Now, write and execute a SQL Query that inserts a second row in the table "vendor" with the following values V_CODE should be 21226,
-- V_NAME should be 'Superloo, Inc.', V_CONTACT should be 'Flushing', V_AREACODE should be '904', V_PHONE should be '215-8995'
-- V_STATE should be 'FL', and V_ORDER should be 'N'. All attributes in this table are required (NOT NULL) so failing
-- to include one of these values will result in an error for your query.

USE sales;
INSERT INTO vendor VALUES (21226, 'Superloo, Inc.', 'Flushing', '904', '215-8995', 'FL', 'N');

-- Execute the following two SQL statements to list all the rows in the table "vendor," your newly inserted row should be there

USE sales;
SELECT * FROM vendor;

/* The following block of SQL queries inserts two rows in the table "product," and shows the result of the operation.
   Remember the structure of "product:
   
    P_CODE     VARCHAR(10)  NOT NULL UNIQUE, 
	P_DESCRIPT VARCHAR(35)  NOT NULL, 
 	P_INDATE   DATETIME     NOT NULL, 
 	P_QOH      SMALLINT     NOT NULL,  
 	P_MIN      SMALLINT     NOT NULL, 
 	P_PRICE    DECIMAL(8,2) NOT NULL, 
 	P_DISCOUNT DECIMAL(4,2) NOT NULL, 
 	V_CODE     INT, 
	PRIMARY KEY (P_CODE),
 	FOREIGN KEY (V_CODE) REFERENCES vendor (V_CODE)

   Review the statements and execute the whole block at once */

USE sales;
INSERT INTO product VALUES ('11QER/31','Power painter, 15 psi., 3-nozzle','07-11-03',8,5,109.99,0.00,21225);
INSERT INTO product VALUES ('13-Q2/P2','7.25-in. pwr. saw blade','07-12-13',32,15,14.99, 0.05,21225);
SELECT * FROM product;

-- Review and execute the following query that inserts a row with a null FK value for V_CODE in the product table

USE sales;
INSERT INTO product VALUES ('BRT-345','Titanium drill bit', '07-10-18', 75, 10, 4.50, 0.06, NULL);
SELECT * FROM product;

/* The following query inserts a row with optional attributes in the "customer" table and shows the result of this
   process. Review the SQL block and and execute it.
   Remember the structure of this table:
   
	CUS_CODE       	INT PRIMARY KEY,
	CUS_LNAME      	VARCHAR(15) NOT NULL,
	CUS_FNAME      	VARCHAR(15) NOT NULL,
	CUS_INITIAL    	CHAR(1),
	CUS_AREACODE 	CHAR(3) DEFAULT '615' NOT NULL CHECK(CUS_AREACODE IN ('615','713','931')),
	CUS_PHONE       CHAR(8) NOT NULL,
	CUS_BALANCE     DECIMAL (9,2) DEFAULT 0.00,
	CONSTRAINT CUS_UI1 UNIQUE(CUS_LNAME,CUS_FNAME))
    
    Review the result
*/

USE sales;
INSERT INTO customer (CUS_CODE, CUS_LNAME, CUS_FNAME, CUS_PHONE) VALUES (1007,'Bond','James','555-1234');
SELECT * FROM customer;

-- Now, we are going to use the UPDATE command in SQL. You want to have a preview of tables in data view as the "before"
-- to compare it with the resilt of your UPDATE query, the "after"
-- Get started by writing and executing a SQL query that updates the value of P_INDATE to July 17, 2013 for the product
-- with P_CODE '13-Q2/P2' in the "product" table

USE sales;
UPDATE product
SET P_INDATE = '2013-07-17'
WHERE P_CODE = '13-02/P2';

-- write and execute a query that shows the content of all the rows in the "product" table and verify the sucess of the
-- update operation

USE sales;
SELECT * FROM product;

-- Review and execute the following query that modifies a row in the table "product" and verify the sucess of the operation

USE sales;
UPDATE product
SET    P_INDATE = '2014-07-14', 
       P_PRICE = 16.99, 
       P_MIN = 10
WHERE  P_CODE = '13-Q2/P2';
SELECT * FROM product;

-- Our final SQL query deletes two rows from the product table and shows the result of the deletion of such rows.
-- review and execute this query.

USE sales;
DELETE FROM product 
WHERE P_CODE = '11QER/31' OR P_CODE = 'BRT-345';
SELECT * FROM product;


