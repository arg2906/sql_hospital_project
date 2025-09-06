-- 🟢 Basic Level (Q1–Q15):

-- Display all columns from the hospital table.
SELECT 
	*
FROM hospital;

-- Show only the Name and Department_Referral of all patients.
SELECT 
	name,
	department_referral
from hospital;

-- List the names of patients who are female.
SELECT 
	name
FROM hospital 
WHERE gender = 'Female';

-- List all male patients aged above 40.
SELECT 
	name
FROM hospital
WHERE age >= 40 AND gender = 'Male';

-- Find patients admitted in the ‘Cardiology’ department.
SELECT 
	name
FROM hospital 
WHERE department_referral = 'Cardiology';

-- Get the patients with a Satisfactio_Score greater than 8.
SELECT 
	id,
	name,
	satisfactio_score
FROM hospital
WHERE satisfactio_score >= 8;
	
-- Sort the hospital data by Admission_Date ascending.
SELECT 
	name, 
	admission_date
FROM hospital
ORDER BY admission_date;

-- Sort the data by Waittime descending.
SELECT 
	name, 
	waittime
FROM hospital
ORDER BY waittime DESC;

-- Find the details of patients admitted after '2024-06-01'.
SELECT 
	* 
FROM hospital
WHERE admission_date > '2024-06-01';

-- Show unique values in the Race column.
SELECT 
	DISTINCT(race) AS unique_race
FROM hospital;

-- Count how many patients are male and how many are female.
SELECT 
	COUNT(*) AS male_count
	WHERE gender = 'Male',
	COUNT(*) AS female_count
	WHERE gender = 'Female';

-- Calculate the total number of patients.
SELECT 
	COUNT(*) AS total_patients
FROM hospital;

-- Show the name of the youngest patient.
SELECT 
	*
FROM hospital 
WHERE admission_date = (SELECT
	MIN(admission_date) FROM hospital);

-- Display the names of patients whose name starts with 'A'.
SELECT 
	name
FROM hospital
WHERE name LIKE 'A%';

SELECT * FROM hospital;

-- Find all patients whose department is either 'Cardiology' or 'Neurology'.
SELECT 	
	* 
FROM hospital
WHERE department_referral IN ('Cardiology', 'Neurology');

-- _________________________________________________________________________________________________________________________________________________________________
-- _________________________________________________________________________________________________________________________________________________________________

-- 🟡 Intermediate Level (Q16–Q35):

SELECT * FROM hospital;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Count how many patients visited each department.
SELECT 
	department_referral,
	COUNT(*) AS total_department
FROM hospital
GROUP BY department_referral;

-- Find the average wait time of all patients.
SELECT 
	ROUND(AVG(waittime),0) AS average_wait_time
FROM hospital;

-- Show the highest and lowest satisfaction scores.
SELECT 
	MAX(satisfactio_score) AS higest_score,
	MIN(satisfactio_score) AS lowest_score
FROM hospital;

-- Display the total number of patients admitted each day.
SELECT 
	count(*) AS total_patients,
	DATE(admission_date)
FROM hospital
GROUP BY DATE(admission_date)
ORDER BY admission_date;

-- Find the average age of patients in each race category.
SELECT 
	race,
	ROUND(AVG(age),2) AS average_age
FROM hospital
GROUP BY race;
	
-- Show patient details where Satisfactio_Score is null or 0.
SELECT 
	*
FROM hospital
WHERE satisfactio_score IN (NULL,0);

-- Change the column name output of Waittime to "Wait_Minutes".
ALTER TABLE hospital
RENAME COLUMN 'waittime' TO 'Wait_Time';

-- Group data by Gender and find average Age.
SELECT
	gender,
	ROUND(AVG(age),2) AS average_age
FROM hospital
GROUP BY gender;

-- Retrieve top 5 patients with the highest wait times.
WITH highest_wait_time As
	(SELECT 
		* 
	FROM hospital
	ORDER BY waittime Desc
	LIMIT 5) 
	SELECT * FROM highest_wait_time;

-- Find how many patients are aged between 30 and 50.
SELECT 
	COUNT(*) AS total_patients
FROM hospital
WHERE age BETWEEN 30 AND 50;

-- List all patients admitted between '2024-06-01' and '2024-06-15'.
SELECT 
	*
FROM hospital 
WHERE admission_date 
BETWEEN '2024-06-01' AND '2024-06-15';

-- Display patients whose satisfaction score is between 6 and 8.
SELECT 
	* 
FROM hospital
WHERE satisfactio_score BETWEEN 6 AND 8;

-- List names of patients who waited more than the average wait time.
SELECT
	*
FROM hospital
WHERE waittime > (SELECT AVG(waittime) FROM hospital);

-- Show department-wise maximum satisfaction score.
SELECT 
	department_referral,
	MAX(satisfactio_score) AS maximum_score
FROM hospital
GROUP BY department_referral;

-- Count number of admissions per department per gender.
SELECT 
	department_referral,
	gender,
	COUNT(*) AS total_admission
FROM hospital
GROUP BY department_referral, gender
ORDER BY department_referral;

-- Find duplicate records (if any) in the table.
SELECT 
	*
FROM hospital
GROUP BY id
HAVING COUNT(*) > 1;

-- Write a query to convert admission time to AM/PM format (if needed).
SELECT *
	CASE
		WHEN admission_date > '12:00:00' THEN 'PM'
		ELSE 'AM';
FROM hospital;

SELECT *,
    CASE
        WHEN CAST(admission_date AS TIME) > '12:00:00' THEN 'PM'
        ELSE 'AM'
    END AS time_period
FROM hospital;


-- Create a new column combining Name and Gender as "Patient_Info".
SELECT 
    name,
    gender,
    name || ', ' || gender AS Patient_Info
FROM hospital;

-- Show which department has the lowest average wait time.
SELECT 
	department_referral,
	AVG(waittime) AS average_time
FROM hospital 
GROUP BY department_referral
ORDER BY AVG(waittime)
LIMIT 1;

-- Display records where name contains the word 'son' (e.g., ‘Johnson’).
SELECT 
	name
FROM hospital
WHERE name LIKE '%son';

-- ___________________________________________________________________________________________________________________________________________________________
-- ___________________________________________________________________________________________________________________________________________________________

-- 🔴 Advanced Level (Q36–Q50):

SELECT * FROM hospital;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Write a subquery to find patients older than the average age.
SELECT 
	*
FROM hospital
WHERE age > (SELECT AVG(age) FROM hospital));

-- Use a subquery to find the department with the most patients.
SELECT 
	department_referral,
	COUNT(*) AS most_patients
FROM hospital
GROUP BY department_referral
ORDER BY most_patients DESC
LIMIT 1;

-- Retrieve names of patients admitted on the same day as '145-39-5480'.
SELECT
	 * 
FROM hospital
WHERE id = '145-39-5480';

-- Display the rank of patients based on wait time (use RANK()).
SELECT 
    *,
    RANK() OVER (ORDER BY waittime ASC) AS wait_rank
FROM hospital;


-- Use DENSE_RANK() to find top 3 departments based on satisfaction.
SELECT 
	*,
	DENSE_RANK() OVER (ORDER BY satisfactio_score ASC) AS satisfaction_rank
FROM hospital
LIMIT 3;

-- Partition data by department and show average age within each department.
SELECT
	department_referral, 
	ROUND(AVG(age),2) AS average_age
FROM hospital
GROUP BY department_referral;

-- List 2nd highest satisfaction score using subquery.
SELECT
	*
FROM hospital
WHERE satisfactio_score > (SELECT MAX(satisfactio_score) FROM hospital);

-- Use CASE to categorize wait time as: 'Short', 'Medium', 'Long'.
SELECT
	*,
	CASE 
		WHEN waittime BETWEEN 0 AND 20 THEN 'Short'
		WHEN waittime BETWEEN 21 AND 40 THEN 'Medium'
		ELSE 'Long'
	END AS waittime_category
FROM hospital;

-- Write a query to calculate the cumulative wait time for each department.

SELECT 
    id, 
    department_referral,
    waittime,
    SUM(waittime) OVER (
        PARTITION BY department_referral 
        ORDER BY id
    ) AS cumulative_waittime
FROM hospital;

-- Create a view to show only Neurology department patients.
WITH CTE AS 
	(SELECT
		* 
	FROM hospital 
	WHERE department_referral ='Neurology')

SELECT * FROM CTE;

-- Write a CTE (Common Table Expression) to filter patients above age 35.
WITH CTE AS 
	(SELECT * FROM hospital 
	WHERE age > 35)
SELECT * FROM CTE;

-- Write a query to extract just the year from the admission date.
SELECT
	id, 
	admission_date,
	EXTRACT (YEAR FROM admission_date) AS admission_year
FROM hospital;

-- Count how many patients were admitted during morning (before 12 PM).
SELECT 
	COUNT(*) AS total_admit_patient_morning
FROM hospital
WHERE admission_time < '12:00:00';

-- Update the table to set Satisfactio_Score = 10 where patient waited more than 40 mins.
UPDATE hospital
SET satisfactio_score = 10
WHERE waittime > 40;