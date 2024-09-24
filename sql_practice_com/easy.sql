/* Retrieve first, last name and gender for patients whose gender is 'M'*/
SELECT first_name, last_name, gender
FROM patients
WHERE gender = ‘M’;
/*—————————————*/
SELECT *
FROM patients
WHERE patient_id IN (1,45,534,879,1000);
/*—————————————*/
SELECT DISTINCT(city) FROM patients
WHERE province_id = ’NS’

SELECT city
FROM patients
GROUP BY city
HAVING province_id = ’NS’
/*—————————————*/
SELECT first_name, last_name
FROM patients
WHERE name LIKE ‘C%’;

SELECT first_name, last_name
FROM patients
WHERE substring(name, 1, 1) = ‘C’;
/*—————————————*/
SELECT first_name, last_name
FROM patients WHERE age BETWEEN 18 AND 25;

SELECT first_name, last_name
FROM patients WHERE age >= 18 AND age <= 25;
/*—————————————*/
SELECT CONCAT(first_name, ‘ ‘, last_name AS full_name
FROM patients;

SELECT first_name || ‘ ‘ || last_name AS full_name
FROM patients;
/*—————————————*/
SELECT count(*) AS total_patients_born_2010
FROM patients
WHERE YEAR(birth_date) = 2010

SELECT count(*) AS total_patients_born_2010
FROM patients
WHERE birth_date >= ’2010-01-01’ AND birth_date <= ‘2010-12-31’ 
/*—————————————*/
SELECT first_name, last_name, MAX(height) AS height
FROM patients
HAVING height = MAX(height)

SELECT first_name, last_name, height
FROM patients
WHERE height = (SELECT MAX(height) FROM patients)
/*—————————————*/
UPDATE patients
SET allergies = ’NKA’
WHERE allergies IS null;
/*—————————————*/

SELECT first_name, last_name, province_name
FROM patients
INNER JOIN province_names
ON patients.province_id = province_names.province_id

