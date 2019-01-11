-- Tables were created in jupyterlab notebooks 
-- in Cognitive Class labs using the file 
-- "Chicago_Public_Schools_-_Progress_Report_Cards__2011-2012-v3.csv"

%load_ext sql

-- Remember the connection string is of the format:
-- %sql ibm_db_sa://my-username:my-password@my-hostname:my-port/my-db-name
-- Enter the connection string for your Db2 on Cloud database instance below
%sql ibm_db_sa://kqt79482:0v9wn51z6c380h%40p@dashdb-txn-sbox-yp-dal09-04.services.dal.bluemix.net:50000/BLUDB

-- Rows in Crime table
%sql SELECT count(*) as crimes FROM CHICAGO_CRIME_DATA

-- Retrieve first 10 rows from the CRIME table
%sql SELECT * FROM CHICAGO_CRIME_DATA LIMIT 10

-- How many crimes involve an arrest?
%sql SELECT count(*) as amount FROM CHICAGO_CRIME_DATA \
WHERE arrest=TRUE

-- Which unique types of crimes have been recorded at GAS STATION locations?
%sql SELECT DISTINCT(primary_type) as crime_type FROM CHICAGO_CRIME_DATA \
WHERE LOWER(location_description)='gas station'

-- In the CENUS_DATA table list all Community Areas whose 
-- names start with the letter ‘B’.
%sql SELECT community_area_name FROM census_data 
WHERE community_area_name LIKE 'B%'

-- Which schools in Community Areas 10 to 15 are 
-- healthy school certified?
%sql SELECT name_of_school, community_area_number 
FROM chicago_public_schools \
WHERE community_area_number BETWEEN 10 AND 15 \
AND healthy_school_certified

-- What is the average school Safety Score?
%sql SELECT AVG(safety_score) as avg_safety_score 
FROM chicago_public_schools

-- List the top 5 Community Areas by average College 
-- Enrollment [number of students]
%sql SELECT community_area_name, AVG(college_enrollment) AS avg_college_enrollment \
FROM chicago_public_schools \
GROUP BY community_area_name \
ORDER BY AVG(college_enrollment) desc LIMIT 5

-- Use a sub-query to determine which Community Area has the 
-- least value for school Safety Score?
%sql SELECT community_area_name, safety_score 
FROM chicago_public_schools WHERE safety_score = \
(SELECT MIN(safety_score) FROM chicago_public_schools)

-- [Without using an explicit JOIN operator] Find the Per 
-- Capita Income of the Community Area which has a school 
-- Safety Score of 1
%sql SELECT CD.per_capita_income, CPS.community_area_name \
FROM census_data as CD, chicago_public_schools as CPS \
WHERE safety_score = 1 AND CD.community_area_number 
= CPS.community_area_number
