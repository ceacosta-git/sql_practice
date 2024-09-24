/* Retrieve first, last name and gender for patients whose gender is 'M'*/
SELECT first_name, last_name, gender
FROM patients
WHERE gender = ‘M’;
/*—————————————*/
SELECT *
FROM patients
WHERE patient_id IN (1,45,534,879,1000);
/*—————————————*/

/* Retrieve unique cities for patients with province 'NS'*/
SELECT DISTINCT(city) FROM patients
WHERE province_id = ’NS’;

SELECT city
FROM patients
GROUP BY city
HAVING province_id = ’NS’;
/*—————————————*/

/* Retrieve first name and last name for patients whose first name starts with 'C'*/
SELECT first_name, last_name
FROM patients
WHERE first_name LIKE ‘C%’;

SELECT first_name, last_name
FROM patients
WHERE substring(first_name, 1, 1) = ‘C’;
/*—————————————*/

/* Retrieve first name and last name for patients whose age is from 18 to 25 inclusive*/
SELECT first_name, last_name
FROM patients WHERE age BETWEEN 18 AND 25;

SELECT first_name, last_name
FROM patients WHERE age >= 18 AND age <= 25;
/*—————————————*/

/* List the full name of all patients by appemding their first name and last name*/
SELECT CONCAT(first_name, ‘ ‘, last_name AS full_name
FROM patients;

SELECT first_name || ‘ ‘ || last_name AS full_name
FROM patients;
/*—————————————*/

/* Lits the total of patients who were born in 2010*/
SELECT count(*) AS total_patients_born_2010
FROM patients
WHERE YEAR(birth_date) = 2010;

SELECT count(*) AS total_patients_born_2010
FROM patients
WHERE birth_date >= ’2010-01-01’ AND birth_date <= ‘2010-12-31’; 
/*—————————————*/

/* Retrieve first name,last name and height for the tallest patient*/
SELECT first_name, last_name, MAX(height) AS height
FROM patients
HAVING height = MAX(height);

SELECT first_name, last_name, height
FROM patients
WHERE height = (SELECT MAX(height) FROM patients);
/*—————————————*/

/* For patients with no allergies, set allergies to 'NKA'*/
UPDATE patients
SET allergies = ’NKA’
WHERE allergies IS null;
/*—————————————*/

/* Retrieve first name, last name and the full province name for all patients*/
SELECT first_name, last_name, province_name
FROM patients
INNER JOIN province_names
ON patients.province_id = province_names.province_id;

