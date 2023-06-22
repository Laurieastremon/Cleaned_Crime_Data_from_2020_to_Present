--Data Preparation and cleaing. Prepping data to later store for visualizations. Main source of data were found on Data.gov

SELECT *
FROM Crime_Data_from_2020_to_Present$

--Checking the age values later for data visualization 
SELECT [Vict Age]
FROM Crime_Data_from_2020_to_Present$
ORDER BY [Vict Age] asc 

-- it appears that there are victims younger than 0 values so we are going to set that as null because there aren't anyone younger than 0.

SELECT [Vict Age]
FROM Crime_Data_from_2020_to_Present$
where [Vict Age] < 0

SELECT [Vict Age],
CASE
    WHEN [Vict Age] <= -1 THEN 'null'
    WHEN [Vict Age] >= 0 THEN CAST([Vict Age] AS VARCHAR(10))
END AS VictimAge

--ORDER BY VictimAge ASC
FROM Crime_Data_from_2020_to_Present$;

ALTER TABLE [dbo].[Crime_Data_from_2020_to_Present$]
ADD VictimAge VARCHAR(10)

UPDATE [dbo].[Crime_Data_from_2020_to_Present$]
SET VictimAge = case 
    WHEN [Vict Age] <= -1 THEN 'null'
    WHEN [Vict Age] >= 0 THEN CAST([Vict Age] AS VARCHAR(10))
END 

SELECT [VictimAge]
FROM Crime_Data_from_2020_to_Present$

SELECT [VictimAge]
FROM Crime_Data_from_2020_to_Present$
where [VictimAge] < '1' 


--CHECKING THE OUTPUTS for the gender
SELECT DISTINCT[Vict Sex]
FROM Crime_Data_from_2020_to_Present$

--CHANGING THE VICTIM'S SEX
SELECT [Vict Sex],
case
	WHEN [vict sex] = 'F' THEN 'FEMALE'
	WHEN [Vict Sex] = 'M' THEN 'MALE'
	ELSE 'NULL'
	END as VictimGender
FROM Crime_Data_from_2020_to_Present$

--Creating a new column for the formatted Victim's Sex

Alter Table [dbo].[Crime_Data_from_2020_to_Present$]
ADD VictimGender varchar(10); 

UPDATE [dbo].[Crime_Data_from_2020_to_Present$]
SET VictimGender =
case
	WHEN [vict sex] = 'F' THEN 'FEMALE'
	WHEN [Vict Sex] = 'M' THEN 'MALE'
	ELSE 'NULL'
	END;

--Checking Victim's Descent(RACE)
-- Turns out values are at an unspecificied range, but we can still fix it.
-- create column for the updated race 
SELECT DISTINCT [Vict Descent]
FROM Crime_Data_from_2020_to_Present$

SELECT [Vict Descent],
case
	WHEN [Vict Descent] = 'B' THEN 'Black'
	WHEN [Vict Descent] = 'w' THEN 'White'
	WHEN [Vict Descent] = 'H' THEN 'Hispanic'
	WHEN [Vict Descent] = 'P' THEN 'Pacific Islander'
	END as VictimRace
FROM Crime_Data_from_2020_to_Present$

ALTER TABLE [dbo].[Crime_Data_from_2020_to_Present$]
ADD VictimRace varchar(20); 

UPDATE [dbo].[Crime_Data_from_2020_to_Present$]
SET VictimRace = case
	WHEN [Vict Descent] = 'B' THEN 'Black'
	WHEN [Vict Descent] = 'w' THEN 'White'
	WHEN [Vict Descent] = 'H' THEN 'Hispanic'
	WHEN [Vict Descent] = 'P' THEN 'Pacific Islander'
	END ;

-- Changing date reported format 

SELECT [Date Rptd], CONVERT(date, [Date Rptd])
FROM Crime_Data_from_2020_to_Present$

UPDATE [dbo].[Crime_Data_from_2020_to_Present$]
SET [Date Rptd] = CONVERT(date, [Date Rptd])

SELECT [Date Rptd]
FROM Crime_Data_from_2020_to_Present$

-- Did not work so creating a new column for the formatted 'reported dates'

ALTER TABLE [dbo].[Crime_Data_from_2020_to_Present$]
Add DateWhenReported date; 

UPDATE [dbo].[Crime_Data_from_2020_to_Present$]
SET DateWhenReported = CONVERT(date, [Date Rptd]);  

SELECT *
FROM Crime_Data_from_2020_to_Present$

-- Formatting the 'date occurence' column 

ALTER TABLE [dbo].[Crime_Data_from_2020_to_Present$]
Add OccurenceDate date;

UPDATE [dbo].[Crime_Data_from_2020_to_Present$]
SET OccurenceDate = CONVERT(date, [DATE OCC])

--Deleting both 'date Rptd', and 'Date occ' columns since they are now formatted properly
SELECT *
FROM Crime_Data_from_2020_to_Present$

ALTER TABLE [dbo].[Crime_Data_from_2020_to_Present$]
DROP COLUMN [Date Rptd];

ALTER TABLE [dbo].[Crime_Data_from_2020_to_Present$]
DROP COLUMN [Date OCC];

-- Deleting entire unsused 'null' columns 

ALTER TABLE [dbo].[Crime_Data_from_2020_to_Present$]
DROP COLUMN [Crm Cd 3];

ALTER TABLE [dbo].[Crime_Data_from_2020_to_Present$]
DROP COLUMN [Crm Cd 4];

-- formating location column to correct format 
SELECT LOCATION
FROM Crime_Data_from_2020_to_Present$

SELECT 
    REPLACE(REPLACE(Location, '  ', ' '), '  ', ' ') AS LocationModified
FROM Crime_Data_from_2020_to_Present$


ALTER TABLE [dbo].[Crime_Data_from_2020_to_Present$]
ADD LocationModified varchar(50);

UPDATE [dbo].[Crime_Data_from_2020_to_Present$]
SET LocationModified =    REPLACE(REPLACE(Location, '  ', ' '), '  ', ' ') 
FROM Crime_Data_from_2020_to_Present$

SELECT *
FROM Crime_Data_from_2020_to_Present$

--Deleting original location format 

ALTER TABLE [dbo].[Crime_Data_from_2020_to_Present$]
DROP COLUMN [location]; 

--Formatting the time occurence 

SELECT [TIME OCC]
FROM Crime_Data_from_2020_to_Present$

SELECT CONCAT(LEFT([TIME OCC], 2), ':', RIGHT([TIME OCC], 2)) AS TimeOccurence 
FROM Crime_Data_from_2020_to_Present$