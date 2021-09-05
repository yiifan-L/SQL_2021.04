/*                                                                        */
/*            Pubs database - SQL Script Adapted from Microsoft's original version (1994-2000)               */ 
/*            by Richard Arias Hernandez for Educational Purposes                                       */

DROP DATABASE IF EXISTS pubs;

CREATE DATABASE pubs;

USE pubs;

CREATE TABLE author
(
   AU_ID 			CHAR(11) 		PRIMARY KEY UNIQUE,
   AU_LNAME			VARCHAR(40)     NOT NULL,
   AU_FNAME     	VARCHAR(20)     NOT NULL,
   AU_PHONE        	CHAR(12)        NOT NULL DEFAULT ('UNKNOWN'),
   AU_ADDRESS      	VARCHAR(40),
   AU_CITY         	VARCHAR(20),
   AU_STATE        	CHAR(2),
   AU_ZIP          	CHAR(5),
   AU_CONTRACT     	BIT             NOT NULL
);

INSERT author VALUES ('409-56-7008', 'Bennet', 'Abraham', '415 658-9932','6223 Bateman St.', 'Berkeley', 'CA', '94705', 1);
INSERT author VALUES ('213-46-8915', 'Green', 'Marjorie', '415 986-7020','309 63rd St. #411', 'Oakland', 'CA', '94618', 1);
INSERT author VALUES ('238-95-7766', 'Carson', 'Cheryl', '415 548-7723','589 Darwin Ln.', 'Berkeley', 'CA', '94705', 1);
INSERT author VALUES ('998-72-3567', 'Ringer', 'Albert', '801 826-0752','67 Seventh Av.', 'Salt Lake City', 'UT', '84152', 1);
INSERT author VALUES ('899-46-2035', 'Ringer', 'Anne', '801 826-0752','67 Seventh Av.', 'Salt Lake City', 'UT', '84152', 1);
INSERT author VALUES ('722-51-5454', 'DeFrance', 'Michel', '219 547-9982','3 Balding Pl.', 'Gary', 'IN', '46403', 1);
INSERT author VALUES ('807-91-6654', 'Panteley', 'Sylvia', '301 946-8853','1956 Arlington Pl.', 'Rockville', 'MD', '20853', 1);
INSERT author VALUES ('893-72-1158', 'McBadden', 'Heather','707 448-4982', '301 Putnam', 'Vacaville', 'CA', '95688', 0);
INSERT author VALUES ('724-08-9931', 'Stringer', 'Dirk', '415 843-2991','5420 Telegraph Av.', 'Oakland', 'CA', '94609', 0);
INSERT author VALUES ('274-80-9391', 'Straight', 'Dean', '415 834-2919','5420 College Av.', 'Oakland', 'CA', '94609', 1);
INSERT author VALUES ('756-30-7391', 'Karsen', 'Livia', '415 534-9219','5720 McAuley St.', 'Oakland', 'CA', '94609', 1);
INSERT author VALUES ('724-80-9391', 'MacFeather', 'Stearns', '415 354-7128','44 Upland Hts.', 'Oakland', 'CA', '94612', 1);
INSERT author VALUES ('427-17-2319', 'Dull', 'Ann', '415 836-7128','3410 Blonde St.', 'Palo Alto', 'CA', '94301', 1);
INSERT author VALUES ('672-71-3249', 'Yokomoto', 'Akiko', '415 935-4228','3 Silver Ct.', 'Walnut Creek', 'CA', '94595', 1);
INSERT author VALUES ('267-41-2394', 'O''Leary', 'Michael', '408 286-2428','22 Cleveland Av. #14', 'San Jose', 'CA', '95128', 1);
INSERT author VALUES ('472-27-2349', 'Gringlesby', 'Burt', '707 938-6445','PO Box 792', 'Covelo', 'CA', '95428', 1);
INSERT author VALUES ('527-72-3246', 'Greene', 'Morningstar', '615 297-2723','22 Graybar House Rd.', 'Nashville', 'TN', '37215', 0);
INSERT author VALUES ('172-32-1176', 'White', 'Johnson', '408 496-7223','10932 Bigge Rd.', 'Menlo Park', 'CA', '94025', 1);
INSERT author VALUES ('712-45-1867', 'del Castillo', 'Innes', '615 996-8275','2286 Cram Pl. #86', 'Ann Arbor', 'MI', '48105', 1);
INSERT author VALUES ('846-92-7186', 'Hunter', 'Sheryl', '415 836-7128','3410 Blonde St.', 'Palo Alto', 'CA', '94301', 1);
INSERT author VALUES ('486-29-1786', 'Locksley', 'Charlene', '415 585-4620','18 Broadway Av.', 'San Francisco', 'CA', '94130', 1);
INSERT author VALUES ('648-92-1872', 'Blotchet-Halls', 'Reginald', '503 745-6402','55 Hillsdale Bl.', 'Corvallis', 'OR', '97330', 1);
INSERT author VALUES ('341-22-1782', 'Smith', 'Meander', '913 843-0462','10 Mississippi Dr.', 'Lawrence', 'KS', '66044', 0);

CREATE TABLE publisher
(
   PUB_ID         	CHAR(4)       	PRIMARY KEY UNIQUE
									CHECK (PUB_ID IN ('1389', '0736', '0877', '1622', '1756') OR PUB_ID LIKE '99%'),
   PUB_NAME       	VARCHAR(40),
   PUB_CITY         VARCHAR(20),
   PUB_STATE        CHAR(2),
   PUB_COUNTRY      VARCHAR(30)   	DEFAULT('USA')
);

INSERT publisher (PUB_ID,PUB_NAME,PUB_CITY,PUB_STATE) VALUES ('0736','New Moon Books', 'Boston','MA');
INSERT publisher (PUB_ID,PUB_NAME,PUB_CITY,PUB_STATE) VALUES ('0877','Binnet & Hardley','Washington','DC');
INSERT publisher (PUB_ID,PUB_NAME,PUB_CITY,PUB_STATE) VALUES ('1389','Algodata Infosystems','Berkeley','CA');
INSERT publisher (PUB_ID,PUB_NAME,PUB_CITY,PUB_STATE) VALUES ('1622','Five Lakes Publishing', 'Chicago','IL');
INSERT publisher (PUB_ID,PUB_NAME,PUB_CITY,PUB_STATE) VALUES ('1756','Ramona Publishers','Dallas','TX');
INSERT publisher (PUB_ID,PUB_NAME,PUB_CITY,PUB_COUNTRY) VALUES ('9901', 'GGG&G', 'München', 'Germany');
INSERT publisher (PUB_ID,PUB_NAME,PUB_CITY,PUB_STATE) VALUES ('9952','Scootney Books','New York City','NY');
INSERT publisher (PUB_ID,PUB_NAME,PUB_CITY,PUB_COUNTRY) VALUES ('9999','Lucerne publishing','Paris', 'France');

CREATE TABLE title
(
	TI_ID       	CHAR(6)				PRIMARY KEY UNIQUE,
	TI_TITLE        VARCHAR(80)      	NOT NULL,
    TI_TYPE         CHAR(12)         	NOT NULL DEFAULT ('UNDECIDED'),
    PUB_ID         	CHAR(4),
	TI_PRICE        DECIMAL(7,2),
	TI_ADVANCE      DECIMAL(7,2),
	TI_ROYALTY      SMALLINT,
	TI_YTDSALES     INT UNSIGNED,
	TI_NOTES        TEXT,
	TI_PUBDATE      DATETIME 			DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (PUB_ID) REFERENCES publisher (PUB_ID) ON UPDATE CASCADE
);

INSERT title VALUES ('PC8888', 'Secrets of Silicon Valley', 'popular_comp', '1389',
20.00, 8000.00, 10, 4095,
'Muckraking reporting on the world''s largest computer hardware and software manufacturers.',
'94-06-12');

INSERT title VALUES ('BU1032', 'The Busy Executive''s Database Guide', 'business',
'1389', 19.99, 5000.00, 10, 4095,
'An overview of available database systems with emphasis on common business applications. Illustrated.',
'91-06-12');

INSERT title VALUES ('PS7777', 'Emotional Security: A New Algorithm', 'psychology',
'0736', 7.99, 4000.00, 10, 3336,
'Protecting yourself and your loved ones from undue emotional stress in the modern world. Use of computer and nutritional aids emphasized.',
'91-06-12');

INSERT title VALUES ('PS3333', 'Prolonged Data Deprivation: Four Case Studies',
'psychology', '0736', 19.99, 2000.00, 10, 4072,
'What happens when the data runs dry?  Searching evaluations of information-shortage effects.',
'91-06-12');

INSERT title VALUES ('BU1111', 'Cooking with Computers: Surreptitious Balance Sheets',
'business', '1389', 11.95, 5000.00, 10, 3876,
'Helpful hints on how to use your electronic resources to the best advantage.',
'91-06-09');

INSERT title VALUES ('MC2222', 'Silicon Valley Gastronomic Treats', 'mod_cook', '0877',
19.99, 0.00, 12, 2032,
'Favorite recipes for quick, easy, and elegant meals.',
'91-06-09');

INSERT title VALUES ('TC7777', 'Sushi, Anyone?', 'trad_cook', '0877', 14.99, 8000.00,
10, 4095,
'Detailed instructions on how to make authentic Japanese sushi in your spare time.',
'91-06-12');

INSERT title VALUES ('TC4203', 'Fifty Years in Buckingham Palace Kitchens', 'trad_cook',
'0877', 11.95, 4000.00, 14, 15096,
'More anecdotes from the Queen''s favorite cook describing life among English royalty. Recipes, techniques, tender vignettes.',
'91-06-12');

INSERT title VALUES ('PC1035', 'But Is It User Friendly?', 'popular_comp', '1389',
22.95, 7000.00, 16, 8780,
'A survey of software for the naive user, focusing on the ''friendliness'' of each.',
'91-06-30');

INSERT title VALUES ('BU2075', 'You Can Combat Computer Stress!', 'business', '0736',
2.99, 10125.00, 24, 18722,
'The latest medical and psychological techniques for living with the electronic office. Easy-to-understand explanations.',
'91-06-30');

INSERT title VALUES ('PS2091', 'Is Anger the Enemy?', 'psychology', '0736', 10.95,
2275.00, 12, 2045,
'Carefully researched study of the effects of strong emotions on the body. Metabolic charts included.',
'91-06-15');

INSERT title VALUES ('PS2106', 'Life Without Fear', 'psychology', '0736', 7.00, 6000.00,
10, 111,
'New exercise, meditation, and nutritional techniques that can reduce the shock of daily interactions. Popular audience. Sample menus included, exercise video available separately.',
'91-10-05');

INSERT title VALUES ('MC3021', 'The Gourmet Microwave', 'mod_cook', '0877', 2.99,
15000.00, 24, 22246,
'Traditional French gourmet recipes adapted for modern microwave cooking.',
'91-06-18');

INSERT title VALUES ('TC3218', 'Onions, Leeks, and Garlic: Cooking Secrets of the Mediterranean',
'trad_cook', '0877', 20.95, 7000.00, 10, 375,
'Profusely illustrated in color, this makes a wonderful gift book for a cuisine-oriented friend.',
'91-10-21');

INSERT title (TI_ID, TI_TITLE, PUB_ID) VALUES ('MC3026','The Psychology of Computer Cooking', '0877');

INSERT title VALUES ('BU7832', 'Straight Talk About Computers', 'business', '1389',
19.99, 5000.00, 10, 4095,
'Annotated analysis of what computers can do for you: a no-hype guide for the critical user.',
'91-06-22');

INSERT title VALUES ('PS1372', 'Computer Phobic AND Non-Phobic Individuals: Behavior Variations',
'psychology', '0877', 21.59, 7000.00, 10, 375,
'A must for the specialist, this book examines the difference between those who hate and fear computers and those who don''t.',
'91-10-21');

INSERT title (TI_ID, TI_TITLE, TI_TYPE, PUB_ID, TI_NOTES) VALUES ('PC9999', 'Net Etiquette',
'popular_comp', '1389', 'A must-read for computer conferencing.');

CREATE TABLE titleauthor
(
   AU_ID         	CHAR(11),
   TI_ID	      	CHAR(6),
   TA_ORD         	SMALLINT,
   TA_ROYALTYPERC	INT,
   PRIMARY KEY (AU_ID, TI_ID),
   FOREIGN KEY (AU_ID) REFERENCES author (AU_ID) ON UPDATE CASCADE,
   FOREIGN KEY (TI_ID) REFERENCES title (TI_ID) ON UPDATE CASCADE,
   UNIQUE (AU_ID, TI_ID)
);

INSERT titleauthor VALUES ('409-56-7008', 'BU1032', 1, 60);
INSERT titleauthor VALUES ('486-29-1786', 'PS7777', 1, 100);
INSERT titleauthor VALUES ('486-29-1786', 'PC9999', 1, 100);
INSERT titleauthor VALUES ('712-45-1867', 'MC2222', 1, 100);
INSERT titleauthor VALUES ('172-32-1176', 'PS3333', 1, 100);
INSERT titleauthor VALUES ('213-46-8915', 'BU1032', 2, 40);
INSERT titleauthor VALUES ('238-95-7766', 'PC1035', 1, 100);
INSERT titleauthor VALUES ('213-46-8915', 'BU2075', 1, 100);
INSERT titleauthor VALUES ('998-72-3567', 'PS2091', 1, 50);
INSERT titleauthor VALUES ('899-46-2035', 'PS2091', 2, 50);
INSERT titleauthor VALUES ('998-72-3567', 'PS2106', 1, 100);
INSERT titleauthor VALUES ('722-51-5454', 'MC3021', 1, 75);
INSERT titleauthor VALUES ('899-46-2035', 'MC3021', 2, 25);
INSERT titleauthor VALUES ('807-91-6654', 'TC3218', 1, 100);
INSERT titleauthor VALUES ('274-80-9391', 'BU7832', 1, 100);
INSERT titleauthor VALUES ('427-17-2319', 'PC8888', 1, 50);
INSERT titleauthor VALUES ('846-92-7186', 'PC8888', 2, 50);
INSERT titleauthor VALUES ('756-30-7391', 'PS1372', 1, 75);
INSERT titleauthor VALUES ('724-80-9391', 'PS1372', 2, 25);
INSERT titleauthor VALUES ('724-80-9391', 'BU1111', 1, 60);
INSERT titleauthor VALUES ('267-41-2394', 'BU1111', 2, 40);
INSERT titleauthor VALUES ('672-71-3249', 'TC7777', 1, 40);
INSERT titleauthor VALUES ('267-41-2394', 'TC7777', 2, 30);
INSERT titleauthor VALUES ('472-27-2349', 'TC7777', 3, 30);
INSERT titleauthor VALUES ('648-92-1872', 'TC4203', 1, 100);

CREATE TABLE store
(
   ST_ID        	CHAR(4)     	PRIMARY KEY UNIQUE,
   ST_NAME      	VARCHAR(40),
   ST_ADDRESS   	VARCHAR(40),
   ST_CITY      	VARCHAR(20),
   ST_PUB_STATE     CHAR(2),
   ST_ZIP       	CHAR(5)
);

INSERT store VALUES ('7066','Barnum''s','567 Pasadena Ave.','Tustin','CA','92789');
INSERT store VALUES ('7067','News & Brews','577 First St.','Los Gatos','CA','96745');
INSERT store VALUES ('7131','Doc-U-Mat: Quality Laundry and Books','24-A Avogadro Way','Remulade','WA','98014');
INSERT store VALUES ('8042','Bookbeat','679 Carson St.','Portland','OR','89076');
INSERT store VALUES ('6380','Eric the Read Books','788 Catamaugus Ave.','Seattle','WA','98056');
INSERT store VALUES ('7896','Fricative Bookshop','89 Madison St.','Fremont','CA','90019');

CREATE TABLE sale
(
	ST_ID        		CHAR(4)         NOT NULL,
	SALE_NUM        	VARCHAR(20)     NOT NULL,
	SALE_DATE       	DATETIME        NOT NULL,
	SALE_QTY         	SMALLINT        NOT NULL,
	SALE_PAYTERMS    	VARCHAR(12)     NOT NULL,
	TI_ID       		CHAR(6)			NOT NULL,
	PRIMARY KEY (ST_ID, SALE_NUM, TI_ID),
    FOREIGN KEY (ST_ID) REFERENCES store (ST_ID) ON UPDATE CASCADE,
    FOREIGN KEY (TI_ID) REFERENCES title (TI_ID) ON UPDATE CASCADE
);

INSERT sale VALUES ('7066', 'QA7442.3', '94-09-13', 75, 'ON invoice','PS2091');
INSERT sale VALUES ('7067', 'D4482', '94-09-14', 10, 'Net 60','PS2091');
INSERT sale VALUES ('7131', 'N914008', '94-09-14', 20, 'Net 30','PS2091');
INSERT sale VALUES ('7131', 'N914014', '94-09-14', 25, 'Net 30','MC3021');
INSERT sale VALUES ('8042', '423LL922', '94-09-14', 15, 'ON invoice','MC3021');
INSERT sale VALUES ('8042', '423LL930', '94-09-14', 10, 'ON invoice','BU1032');
INSERT sale VALUES ('6380', '722a', '94-09-13', 3, 'Net 60','PS2091');
INSERT sale VALUES ('6380', '6871', '94-09-14', 5, 'Net 60','BU1032');
INSERT sale VALUES ('8042','P723', '93-03-11', 25, 'Net 30', 'BU1111');
INSERT sale VALUES ('7896','X999', '93-02-21', 35, 'ON invoice', 'BU2075');
INSERT sale VALUES ('7896','QQ2299', '93-10-28', 15, 'Net 60', 'BU7832');
INSERT sale VALUES ('7896','TQ456', '93-12-12', 10, 'Net 60', 'MC2222');
INSERT sale VALUES ('8042','QA879.1', '93-05-22', 30, 'Net 30', 'PC1035');
INSERT sale VALUES ('7066','A2976', '93-05-24', 50, 'Net 30', 'PC8888');
INSERT sale VALUES ('7131','P3087a', '93-05-29', 20, 'Net 60', 'PS1372');
INSERT sale VALUES ('7131','P3087a', '93-05-29', 25, 'Net 60', 'PS2106');
INSERT sale VALUES ('7131','P3087a', '93-05-29', 15, 'Net 60', 'PS3333');
INSERT sale VALUES ('7131','P3087a', '93-05-29', 25, 'Net 60', 'PS7777');
INSERT sale VALUES ('7067','P2121', '92-06-15', 40, 'Net 30', 'TC3218');
INSERT sale VALUES ('7067','P2121', '92-06-15', 20, 'Net 30', 'TC4203');
INSERT sale VALUES ('7067','P2121', '92-06-15', 20, 'Net 30', 'TC7777');


CREATE TABLE roysched
(
   TI_ID       		CHAR(6),
   ROY_RANGEID		SMALLINT,
   ROY_LORANGE      INT,
   ROY_HIRANGE      INT,
   ROY_ROYALTY      INT,
   PRIMARY KEY (TI_ID, ROY_RANGEID),
   FOREIGN KEY (TI_ID) REFERENCES title (TI_ID) ON DELETE CASCADE
);

INSERT roysched VALUES ('BU1032', 1, 0, 5000, 10);
INSERT roysched VALUES ('BU1032', 2, 5001, 50000, 12);
INSERT roysched VALUES ('PC1035', 1, 0, 2000, 10);
INSERT roysched VALUES ('PC1035', 2, 2001, 3000, 12);
INSERT roysched VALUES ('PC1035', 3, 3001, 4000, 14);
INSERT roysched VALUES ('PC1035', 4, 4001, 10000, 16);
INSERT roysched VALUES ('PC1035', 5, 10001, 50000, 18);
INSERT roysched VALUES ('BU2075', 1, 0, 1000, 10);
INSERT roysched VALUES ('BU2075', 2, 1001, 3000, 12);
INSERT roysched VALUES ('BU2075', 3, 3001, 5000, 14);
INSERT roysched VALUES ('BU2075', 4, 5001, 7000, 16);
INSERT roysched VALUES ('BU2075', 5, 7001, 10000, 18);
INSERT roysched VALUES ('BU2075', 6, 10001, 12000, 20);
INSERT roysched VALUES ('BU2075', 7, 12001, 14000, 22);
INSERT roysched VALUES ('BU2075', 8, 14001, 50000, 24);
INSERT roysched VALUES ('PS2091', 1, 0, 1000, 10);
INSERT roysched VALUES ('PS2091', 2, 1001, 5000, 12);
INSERT roysched VALUES ('PS2091', 3, 5001, 10000, 14);
INSERT roysched VALUES ('PS2091', 4, 10001, 50000, 16);
INSERT roysched VALUES ('PS2106', 1, 0, 2000, 10);
INSERT roysched VALUES ('PS2106', 2, 2001, 5000, 12);
INSERT roysched VALUES ('PS2106', 3, 5001, 10000, 14);
INSERT roysched VALUES ('PS2106', 4, 10001, 50000, 16);
INSERT roysched VALUES ('MC3021', 1, 0, 1000, 10);
INSERT roysched VALUES ('MC3021', 2, 1001, 2000, 12);
INSERT roysched VALUES ('MC3021', 3, 2001, 4000, 14);
INSERT roysched VALUES ('MC3021', 4, 4001, 6000, 16);
INSERT roysched VALUES ('MC3021', 5, 6001, 8000, 18);
INSERT roysched VALUES ('MC3021', 6, 8001, 10000, 20);
INSERT roysched VALUES ('MC3021', 7, 10001, 12000, 22);
INSERT roysched VALUES ('MC3021', 8, 12001, 50000, 24);
INSERT roysched VALUES ('TC3218', 1, 0, 2000, 10);
INSERT roysched VALUES ('TC3218', 2, 2001, 4000, 12);
INSERT roysched VALUES ('TC3218', 3, 4001, 6000, 14);
INSERT roysched VALUES ('TC3218', 4, 6001, 8000, 16);
INSERT roysched VALUES ('TC3218', 5, 8001, 10000, 18);
INSERT roysched VALUES ('TC3218', 6, 10001, 12000, 20);
INSERT roysched VALUES ('TC3218', 7, 12001, 14000, 22);
INSERT roysched VALUES ('TC3218', 8, 14001, 50000, 24);
INSERT roysched VALUES ('PC8888', 1, 0, 5000, 10);
INSERT roysched VALUES ('PC8888', 2, 5001, 10000, 12);
INSERT roysched VALUES ('PC8888', 3, 10001, 15000, 14);
INSERT roysched VALUES ('PC8888', 4, 15001, 50000, 16);
INSERT roysched VALUES ('PS7777', 1, 0, 5000, 10);
INSERT roysched VALUES ('PS7777', 2, 5001, 50000, 12);
INSERT roysched VALUES ('PS3333', 1, 0, 5000, 10);
INSERT roysched VALUES ('PS3333', 2, 5001, 10000, 12);
INSERT roysched VALUES ('PS3333', 3, 10001, 15000, 14);
INSERT roysched VALUES ('PS3333', 4, 15001, 50000, 16);
INSERT roysched VALUES ('BU1111', 1, 0, 4000, 10);
INSERT roysched VALUES ('BU1111', 2, 4001, 8000, 12);
INSERT roysched VALUES ('BU1111', 3, 8001, 10000, 14);
INSERT roysched VALUES ('BU1111', 4, 10001, 12000, 15);
INSERT roysched VALUES ('BU1111', 5, 12001, 16000, 16);
INSERT roysched VALUES ('BU1111', 6, 16001, 20000, 18);
INSERT roysched VALUES ('BU1111', 7, 20001, 24000, 20);
INSERT roysched VALUES ('BU1111', 8, 24001, 28000, 22);
INSERT roysched VALUES ('BU1111', 9, 28001, 50000, 24);
INSERT roysched VALUES ('MC2222', 1, 0, 2000, 10);
INSERT roysched VALUES ('MC2222', 2, 2001, 4000, 12);
INSERT roysched VALUES ('MC2222', 3, 4001, 8000, 14);
INSERT roysched VALUES ('MC2222', 4, 8001, 12000, 16);
INSERT roysched VALUES ('MC2222', 5, 12001, 20000, 18);
INSERT roysched VALUES ('MC2222', 6, 20001, 50000, 20);
INSERT roysched VALUES ('TC7777', 1, 0, 5000, 10);
INSERT roysched VALUES ('TC7777', 2, 5001, 15000, 12);
INSERT roysched VALUES ('TC7777', 3, 15001, 50000, 14);
INSERT roysched VALUES ('TC4203', 1, 0, 2000, 10);
INSERT roysched VALUES ('TC4203', 2, 2001, 8000, 12);
INSERT roysched VALUES ('TC4203', 3, 8001, 16000, 14);
INSERT roysched VALUES ('TC4203', 4, 16001, 24000, 16);
INSERT roysched VALUES ('TC4203', 5, 24001, 32000, 18);
INSERT roysched VALUES ('TC4203', 6, 32001, 40000, 20);
INSERT roysched VALUES ('TC4203', 7, 40001, 50000, 22);
INSERT roysched VALUES ('BU7832', 1, 0, 5000, 10);
INSERT roysched VALUES ('BU7832', 2, 5001, 10000, 12);
INSERT roysched VALUES ('BU7832', 3, 10001, 15000, 14);
INSERT roysched VALUES ('BU7832', 4, 15001, 20000, 16);
INSERT roysched VALUES ('BU7832', 5, 20001, 25000, 18);
INSERT roysched VALUES ('BU7832', 6, 25001, 30000, 20);
INSERT roysched VALUES ('BU7832', 7, 30001, 35000, 22);
INSERT roysched VALUES ('BU7832', 8, 35001, 50000, 24);
INSERT roysched VALUES ('PS1372', 1, 0, 10000, 10);
INSERT roysched VALUES ('PS1372', 2, 10001, 20000, 12);
INSERT roysched VALUES ('PS1372', 3, 20001, 30000, 14);
INSERT roysched VALUES ('PS1372', 4, 30001, 40000, 16);
INSERT roysched VALUES ('PS1372', 5, 40001, 50000, 18);

CREATE TABLE discount
(
	DISC_TYPE   		VARCHAR(40)		NOT NULL,
	ST_ID        		CHAR(4),
	DISC_LOWQTY         SMALLINT,
	DISC_HIGHQTY		SMALLINT,
	DISC_AMOUNT       	DECIMAL(4,2)	NOT NULL,
    FOREIGN KEY (ST_ID) REFERENCES store (ST_ID) ON DELETE CASCADE
);

INSERT discount VALUES ('Initial Customer', NULL, NULL, NULL, 10.5);
INSERT discount VALUES ('Volume Discount', NULL, 100, 1000, 6.7);
INSERT discount VALUES ('Customer Discount', '8042', NULL, NULL, 5.0);

CREATE TABLE job
(
   JOB_ID         INT         		PRIMARY KEY AUTO_INCREMENT,
   JOB_DESC       VARCHAR(50)       NOT NULL DEFAULT 'New Position - title not formalized yet',
   JOB_MINLVL     SMALLINT          NOT NULL CHECK (JOB_MINLVL >= 10),
   JOB_MAXLVL     SMALLINT          NOT NULL CHECK (JOB_MAXLVL <= 250)
);

INSERT job (JOB_DESC, JOB_MINLVL, JOB_MAXLVL) VALUES ('New Hire - Job not specified', 10, 10);
INSERT job (JOB_DESC, JOB_MINLVL, JOB_MAXLVL) VALUES ('Chief Executive Officer', 200, 250);
INSERT job (JOB_DESC, JOB_MINLVL, JOB_MAXLVL) VALUES ('Business Operations Manager', 175, 225);
INSERT job (JOB_DESC, JOB_MINLVL, JOB_MAXLVL) VALUES ('Chief Financial Officier', 175, 250);
INSERT job (JOB_DESC, JOB_MINLVL, JOB_MAXLVL) VALUES ('Publisher', 150, 250);
INSERT job (JOB_DESC, JOB_MINLVL, JOB_MAXLVL) VALUES ('Managing Editor', 140, 225);
INSERT job (JOB_DESC, JOB_MINLVL, JOB_MAXLVL) VALUES ('Marketing Manager', 120, 200);
INSERT job (JOB_DESC, JOB_MINLVL, JOB_MAXLVL) VALUES ('Public Relations Manager', 100, 175);
INSERT job (JOB_DESC, JOB_MINLVL, JOB_MAXLVL) VALUES ('Acquisitions Manager', 75, 175);
INSERT job (JOB_DESC, JOB_MINLVL, JOB_MAXLVL) VALUES ('Productions Manager', 75, 165);
INSERT job (JOB_DESC, JOB_MINLVL, JOB_MAXLVL) VALUES ('Operations Manager', 75, 150);
INSERT job (JOB_DESC, JOB_MINLVL, JOB_MAXLVL) VALUES ('Editor', 25, 100);
INSERT job (JOB_DESC, JOB_MINLVL, JOB_MAXLVL) VALUES ('Sales Representative', 25, 100);
INSERT job (JOB_DESC, JOB_MINLVL, JOB_MAXLVL) VALUES ('Designer', 25, 100);

CREATE TABLE pub_info
(
   PUB_ID         	CHAR(4)		PRIMARY KEY UNIQUE,
   PUBINFO_LOGO     BLOB,
   PUBINFO_INFO     TEXT,
   FOREIGN KEY (PUB_ID) REFERENCES publisher (PUB_ID) ON DELETE CASCADE
);

CREATE TABLE employee
(
   EMP_ID			CHAR(9) 		PRIMARY KEY UNIQUE, 
   EMP_FNAME		VARCHAR(20)		NOT NULL,
   EMP_MINIT		CHAR(1),
   EMP_LNAME		VARCHAR(30)		NOT NULL,
   JOB_ID			INT				NOT NULL DEFAULT 1,
   EMP_JOBLVL      	SMALLINT		DEFAULT 10,
   PUB_ID       	CHAR(4)         NOT NULL DEFAULT ('9952'),
   EMP_HIREDATE     DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY (JOB_ID) REFERENCES job (JOB_ID) ON UPDATE CASCADE,
   FOREIGN KEY (PUB_ID) REFERENCES publisher (PUB_ID) ON UPDATE CASCADE
);

INSERT employee VALUES ('PTC11962M', 'Philip', 'T', 'Cramer', 2, 215, '9952', '89-11-11');
INSERT employee VALUES ('AMD15433F', 'Ann', 'M', 'Devon', 3, 200, '9952', '91-07-16');
INSERT employee VALUES ('F-C16315M', 'Francisco', NULL, 'Chang', 4, 227, '9952', '90-11-03');
INSERT employee VALUES ('LAL21447M', 'Laurence', 'A', 'Lebihan', 5, 175, '0736', '90-06-03');
INSERT employee VALUES ('PXH22250M', 'Paul', 'X', 'Henriot', 5, 159, '0877', '93-08-19');
INSERT employee VALUES ('SKO22412M', 'Sven', 'K', 'Ottlieb', 5, 150, '1389', '91-04-05');
INSERT employee VALUES ('RBM23061F', 'Rita', 'B', 'Muller', 5, 198, '1622', '93-10-09');
INSERT employee VALUES ('MJP25939M', 'Maria', 'J', 'Pontes', 5, 246, '1756', '89-03-01');
INSERT employee VALUES ('JYL26161F', 'Janine', 'Y', 'Labrune', 5, 172, '9901', '91-05-26');
INSERT employee VALUES ('CFH28514M', 'Carlos', 'F', 'Hernadez', 5, 211, '9999', '89-04-21');
INSERT employee VALUES ('VPA30890F', 'Victoria', 'P', 'Ashworth', 6, 140, '0877', '90-09-13');
INSERT employee VALUES ('L-B31947F', 'Lesley', NULL, 'Brown', 7, 120, '0877', '91-02-13');
INSERT employee VALUES ('ARD36773F', 'Anabela', 'R', 'Domingues', 8, 100, '0877', '93-01-27');
INSERT employee VALUES ('M-R38834F', 'Martine', NULL, 'Rance', 9, 75, '0877', '92-02-05');
INSERT employee VALUES ('PHF38899M', 'Peter', 'H', 'Franken', 10, 75, '0877', '92-05-17');
INSERT employee VALUES ('DBT39435M', 'Daniel', 'B', 'Tonini', 11, 75, '0877', '90-01-01');
INSERT employee VALUES ('H-B39728F', 'Helen', NULL, 'Bennett', 12, 35, '0877', '89-09-21');
INSERT employee VALUES ('PMA42628M', 'Paolo', 'M', 'Accorti', 13, 35, '0877', '92-08-27/');
INSERT employee VALUES ('ENL44273F', 'Elizabeth', 'N', 'Lincoln', 14, 35, '0877', '90-07-24');
INSERT employee VALUES ('MGK44605M', 'Matti', 'G', 'Karttunen', 6, 220, '0736', '94-05-01');
INSERT employee VALUES ('PDI47470M', 'Palle', 'D', 'Ibsen', 7, 195, '0736', '93-05-09');
INSERT employee VALUES ('MMS49649F', 'Mary', 'M', 'Saveley', 8, 175, '0736', '93-06-29');
INSERT employee VALUES ('GHT50241M', 'Gary', 'H', 'Thomas', 9, 170, '0736', '88-08-09');
INSERT employee VALUES ('MFS52347M', 'Martin', 'F', 'Sommer', 10, 165, '0736', '90-04-13');
INSERT employee VALUES ('R-M53550M', 'Roland', NULL, 'Mendel', 11, 150, '0736', '91-09-05');
INSERT employee VALUES ('HAS54740M', 'Howard', 'A', 'Snyder', 12, 100, '0736', '88-11-19');
INSERT employee VALUES ('TPO55093M', 'Timothy', 'P', 'O''Rourke', 13, 100, '0736', '88-06-19');
INSERT employee VALUES ('KFJ64308F', 'Karin', 'F', 'Josephs', 14, 100, '0736', '92-10-17');
INSERT employee VALUES ('DWR65030M', 'Diego', 'W', 'Roel', 6, 192, '1389', '91-12-16');
INSERT employee VALUES ('M-L67958F', 'Maria', NULL, 'Larsson', 7, 135, '1389', '92-03-27');
INSERT employee VALUES ('PSP68661F', 'Paula', 'S', 'Parente', 8, 125, '1389', '94-01-19');
INSERT employee VALUES ('MAS70474F', 'Margaret', 'A', 'Smith', 9, 78, '1389', '88-09-29');
INSERT employee VALUES ('A-C71970F', 'Aria', NULL, 'Cruz', 10, 87, '1389', '91-10-26');
INSERT employee VALUES ('MAP77183M', 'Miguel', 'A', 'Paolino', 11, 112, '1389', '92-12-07');
INSERT employee VALUES ('Y-L77953M', 'Yoshi', NULL, 'Latimer', 12, 32, '1389', '89-06-11');
INSERT employee VALUES ('CGS88322F', 'Carine', 'G', 'Schmitt', 13, 64, '1389', '92-07-07');
INSERT employee VALUES ('PSA89086M', 'Pedro', 'S', 'Afonso', 14, 89, '1389', '90-12-24');
INSERT employee VALUES ('A-R89858F', 'Annette', NULL, 'Roulet', 6, 152, '9999', '90-02-21');
INSERT employee VALUES ('HAN90777M', 'Helvetius', 'A', 'Nagy', 7, 120, '9999', '93-03-19');
INSERT employee VALUES ('M-P91209M', 'Manuel', NULL, 'Pereira', 8, 101, '9999', '89-01-09');
INSERT employee VALUES ('KJJ92907F', 'Karla', 'J', 'Jablonski', 9, 170, '9999', '94-03-11');
INSERT employee VALUES ('POK93028M', 'Pirkko', 'O', 'Koskitalo', 10, 80, '9999', '93-11-29');
INSERT employee VALUES ('PCM98509F', 'Patricia', 'C', 'McKenna', 11, 150, '9999', '89-08-01');


CREATE INDEX employee_ind ON employee(EMP_LNAME, EMP_FNAME, EMP_MINIT);
CREATE INDEX aunmind ON author (AU_LNAME, AU_FNAME);
CREATE INDEX titleidind ON sale (TI_ID);
CREATE INDEX titleind ON title (TI_TITLE);
CREATE INDEX auidind ON titleauthor (AU_ID);
CREATE INDEX titleidind ON titleauthor (TI_ID);
CREATE INDEX titleidind ON roysched (TI_ID);


