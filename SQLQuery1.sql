-- --------------------------------------------------------------------------------
-- Name:  Josh Gauspohl
-- Class: IT-111 
-- Abstract: Assignment 9 Solution
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE db13;     -- Get out of the master database
SET NOCOUNT ON;

-- --------------------------------------------------------------------------------
--						Problem #9
-- --------------------------------------------------------------------------------

-- Drop Table Statements

IF OBJECT_ID ('TCustomerSongs')		IS NOT NULL DROP TABLE TCustomerSongs
IF OBJECT_ID ('TCustomers')			IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID ('TSongs')				IS NOT NULL DROP TABLE TSongs
IF OBJECT_ID ('TArtists')			IS NOT NULL DROP TABLE TArtists
IF OBJECT_ID ('TRace')				IS NOT NULL DROP TABLE TRace
IF OBJECT_ID ('TGender')			IS NOT NULL DROP TABLE TGender
IF OBJECT_ID ('TState')				IS NOT NULL DROP TABLE TState
IF OBJECT_ID ('TCity')				IS NOT NULL DROP TABLE TCity

-- --------------------------------------------------------------------------------
--	Step #1 : Create table 
-- --------------------------------------------------------------------------------

CREATE TABLE TSongs
(
	 intSongID			INTEGER			NOT NULL
	,intArtistID		INTEGER			NOT NULL
	,strSongName		VARCHAR(255)	NOT NULL
	,strGenre			VARCHAR(255)	NOT NULL
	,strRecordLabel		VARCHAR(255)	NOT NULL
	,dtmDateRecorded	DATETIME		NOT NULL
	,CONSTRAINT TSongs_PK PRIMARY KEY ( intSongID )
)

CREATE TABLE TArtists
(
	 intArtistID		INTEGER			NOT NULL
	,strFirstName		VARCHAR(255)	NOT NULL
	,strLastName		VARCHAR(255)	NOT NULL
	,CONSTRAINT TArtists_PK PRIMARY KEY ( intArtistID )
)


CREATE TABLE TCustomerSongs
(
	 intCustomerSongID	INTEGER			NOT NULL
	,intCustomerID		INTEGER			NOT NULL
	,intSongID			INTEGER			NOT NULL
	,CONSTRAINT TCustomerSongs_PK PRIMARY KEY (  intCustomerSongID )
)


CREATE TABLE TCity
(
	 intCityID			INTEGER			NOT NULL	
	,strCityName		VARCHAR(255)	NOT NULL
	,CONSTRAINT TCity_PK PRIMARY KEY ( intCityID )
)

CREATE TABLE TState
(
	 intStateID			INTEGER			NOT NULL	
	,strStateName		VARCHAR(255)	NOT NULL
	,CONSTRAINT TState_PK PRIMARY KEY ( intStateID )
)

CREATE TABLE TGender
(
	 intGenderID			INTEGER			NOT NULL	
	,strGender			VARCHAR(255)	NOT NULL
	,CONSTRAINT TGender_PK PRIMARY KEY ( intGenderID )
)

CREATE TABLE TRace
(
	 intRaceID			INTEGER			NOT NULL	
	,strRace			VARCHAR(255)	NOT NULL
	,CONSTRAINT TRace_PK PRIMARY KEY ( intRaceID )
)

CREATE TABLE TCustomers
(
	 intCustomerID		INTEGER			NOT NULL
	,strFirstName		VARCHAR(255)	NOT NULL
	,strLastName		VARCHAR(255)	NOT NULL
	,strAddress			VARCHAR(255)	NOT NULL
	,intCityID			INTEGER			NOT NULL
	,intStateID			INTEGER			NOT NULL
	,strZip				VARCHAR(255)	NOT NULL
	,dtmDateOfBirth		DATETIME		NOT NULL
	,intRaceID			INTEGER			NOT NULL
	,intGenderID		INTEGER			NOT NULL
	,CONSTRAINT TCustomers_PK PRIMARY KEY ( intCustomerID )
)

-- --------------------------------------------------------------------------------
--	Step #2 : Establishing Referential Integrity 
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column
-- -	-----							------						---------
-- 1	TSongs							TArtists					intArtistID						 
-- 2	TCustomerSongs					TCustomers					intCustomerID 
-- 3	TCustomerSongs					TSongs						intSongID
-- 4	TCustomers						TCity						intCityID
-- 5	TCustomers						TStates						intStateID
-- 6	TCustomers						TGender						intGenderID
-- 7	TCustomers						TRace						intRaceID

--1
ALTER TABLE TSongs ADD CONSTRAINT TSongs_TArtists_FK 
FOREIGN KEY ( intArtistID ) REFERENCES TArtists ( intArtistID ) 

--2
ALTER TABLE TCustomerSongs	 ADD CONSTRAINT TCustomerSongs_TCustomers_FK 
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID ) 

--3
ALTER TABLE TCustomerSongs	 ADD CONSTRAINT TCustomerSongs_TSongs_FK 
FOREIGN KEY ( intSongID ) REFERENCES TSongs ( intSongID ) 

--4
ALTER TABLE TCustomers	ADD CONSTRAINT TCustomers_TCity_FK
FOREIGN KEY ( intCityID ) REFERENCES TCity ( intCityID )

--5 
ALTER TABLE TCustomers	ADD CONSTRAINT TCustomers_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TState ( intStateID )

--6
ALTER TABLE TCustomers	ADD CONSTRAINT TCustomers_TGender_FK
FOREIGN KEY ( intGenderID ) REFERENCES TGender ( intGenderID )

--7
ALTER TABLE TCustomers	ADD CONSTRAINT TCustomers_TRace_FK
FOREIGN KEY ( intRaceID ) REFERENCES TRace ( intRaceID )


-- --------------------------------------------------------------------------------
--	Step #3 : Add Sample Data - INSERTS
-- --------------------------------------------------------------------------------


INSERT INTO TCity (intCityID, strCityName)
VALUES				(1, 'Cincinnati')
				   ,(2, 'Norwood')
				   ,(3, 'West Chester')
				   ,(4, 'Milford')


INSERT INTO TState (intStateID, strStateName)
VALUES					(1, 'Oh')
					   ,(2, 'Ky')
					   ,(3, 'Il')
					   ,(4, 'Fl')


INSERT INTO TGender (intGenderID, strGender)
VALUES				  (1, 'Male')
					 ,(2, 'Female')
					 ,(3, 'Other')


INSERT INTO TRace (intRaceID, strRace)
VALUES				(1, 'Hispanic')
				   ,(2, 'Afrian-American')
				   ,(3, 'Asian')
				   ,(4, 'White')


INSERT INTO TCustomers (intCustomerID, strFirstName, strLastName, strAddress, intCityID,  intStateID, strZip, dtmDateOfBirth, intRaceID, intGenderID)
VALUES				  (1, 'James', 'Jones', '321 Elm St.', 1, 2, '45201', '1/1/1997', 1, 1)
					 ,(2, 'Sally', 'Smith', '987 Main St.', 1, 2, '45218', '12/1/1999', 2, 2)
					 ,(3, 'Jose', 'Hernandez', '1569 Windisch Rd.', 2, 3, '45069', '9/23/1998', 4, 1)
					 ,(4, 'Lan', 'Kim', '44561 Oak Ave.', 3, 4, '45246', '6/11/1999', 4, 3)


INSERT INTO TArtists( intArtistID, strFirstName, strLastName)
VALUES				(1, 'Bob', 'Nields')
				   ,(2, 'Ray', 'Harmon')
				   ,(3, 'Pam', 'Ransdell')


INSERT INTO TSongs ( intSongID, intArtistID, strSongName, strGenre, strRecordLabel, dtmDateRecorded)
VALUES				 ( 1, 1,'Hey Jude', 'Rock', 'MyOwn', '8/28/2017')
					,( 2, 2,'School House Rock', 'Rock', 'HisOwn', '8/28/2007')
					,( 3, 3,'Rocking on the Porch', 'Country', 'CountingToes', '8/28/1997')
					,( 4, 1,'Blue Jude', 'Blues', 'DeepMusic', '8/28/2009')


INSERT INTO TCustomerSongs (intCustomerSongID, intCustomerID, intSongID)
VALUES				    	( 1, 1, 1)
						   ,( 2, 1, 2)
						   ,( 3, 1, 3)
						   ,( 4, 1, 4)
						   ,( 5, 2, 2)
						   ,( 6, 2, 3)
						   ,( 7, 3, 4)
						   ,( 8, 4, 1)
						   ,( 9, 4, 4)


-- Joining table date 
-- displaying data where customer is from cincinnati (city name = Cincinnati)
select
TCustomers.strFirstName,
TCustomers.strLastName, 
TCity.strCityName
FROM TCustomers
	,TCity
WHERE
TCustomers.intCityID = TCity.intCityID
and TCity.strCityName = 'Cincinnati'


-- Displaying customers who are male from TCustomers and parent TGender
SELECT
  TC.strFirstName
 ,TC.strLastName
 ,TG.strGender
FROM
 TCustomers as TC
,TGender as TG
WHERE
 TC.intGenderID = TG.intGenderID
and TG.strGender = 'Male'



