/* 1 - Show unique birth years from patients and order them by ascending.*/
SELECT DISTINCT(YEAR(birth_date)) AS birth_year
FROM patients
order by birth_year ASC;

SELECT YEAR(birth_date) AS birth_year
FROM patients
group by birth_year
order by YEAR(birth_date) ASC;

/* 
2 - Show unique first names from the patients table which only occurs once in the list.
For example, 
if two or more people are named 'John' in the first_name column 
then don't include their name in the output list. 
If only 1 person is named 'Leo' then include them in the output.*/
SELECT distinct(first_name) AS first_name
FROM patients 
group by first_name 
having count(*) = 1;

SELECT first_name
FROM (
    SELECT
      first_name,
      count(first_name) AS occurrencies
    FROM patients
    GROUP BY first_name
  )
WHERE occurrencies = 1;


/* 3 - Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.*/
SELECT
  patient_id,
  first_name
FROM patients
WHERE first_name LIKE 's____%s';

SELECT
  patient_id,
  first_name
FROM patients
WHERE
  first_name LIKE 's%s'
  AND len(first_name) >= 6;
/* This was my initial solution but was listed as 3rd solution out of 3*/
SELECT patient_id, first_name
FROM patients 
WHERE first_name LIKE 's%' AND first_name LIKE '%s' AND len(first_name) >= 6;

/* 4 - Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
Primary diagnosis is stored in the admissions table.
*/
SELECT patients.patient_id, first_name, last_name
FROM patients
INNER JOIN admissions
ON patients.patient_id = admissions.patient_id
WHERE diagnosis = 'Dementia';

SELECT
  patient_id,
  first_name,
  last_name
FROM patients
WHERE patient_id IN (
    SELECT patient_id
    FROM admissions
    WHERE diagnosis = 'Dementia'
  );

/* 5 - Display every patient's first_name.
Order the list by the length of each name and then by alphabetically.*/
SELECT first_name
FROM patients
order by len(first_name), first_name;

/* 6 - Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row.*/
SELECT
(SELECT count(*) FROM patients WHERE gender = 'M') as male_count,
(SELECT count(*) FROM patients WHERE gender = 'F') AS female_count; 

SELECT
sum(gender = 'M') as male_count,
SUM(gender = 'F') AS female_count
FROM patients;

/* This was my initial solution but was listed as 3rd solution out of 3*/
SELECT 
COUNT(case WHEN gender = 'M' THEN 1 END) AS male_count, 
COUNT(CASE WHEN gender = 'F' THEN 1 END) as female_count
FROM patients;

/* 7 - Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
Show results ordered ascending by allergies then by first_name then by last_name.*/
SELECT first_name, last_name, allergies
FROM patients
WHERE allergies in ('Penicillin', 'Morphine')
order by allergies asc, first_name asc, last_name ASC; 

SELECT first_name, last_name, allergies
FROM patients
WHERE allergies = 'Penicillin' OR allergies = 'Morphine'
ORDER BY allergies ASC, first_name ASC, last_name ASC;

/* 8 - Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.*/
SELECT patient_id, diagnosis
FROM admissions
GROUP BY diagnosis, patient_id
HAVING COUNT(*) > 1; 

/* 9 - Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending.*/
SELECT city, count(*) AS total_patients
FROM patients
group by city
order by total_patients desc, city asc; 

/* 10 - Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor"*/
SELECT first_name, last_name, 'Doctor' as role FROM doctors
union all
SELECT first_name, last_name, 'Patient' as role FROM patients; 

/* 11 - Show all allergies ordered by popularity. Remove NULL values from query.*/
SELECT allergies, count(*) as total_diagnosis
from patients
WHERE allergies IS not null
group by allergies
order by total_diagnosis desc; 

SELECT allergies, count(*)
FROM patients
WHERE allergies NOT NULL
GROUP BY allergies
ORDER BY count(*) DESC; 

/* This was my initial solution but was listed as 3rd solution out of 3*/
SELECT allergies, count(*) as total_diagnosis
from patients
group by allergies
HAVING allergies IS not null
order by total_diagnosis desc; 

/* 12 - Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. 
Sort the list starting from the earliest birth_date.*/
SELECT first_name, last_name, birth_date
FROM patients
WHERE year(birth_date) between 1970 and 1979
order by birth_date asc; 

SELECT first_name, last_name, birth_date
FROM patients
WHERE birth_date >= '1970-01-01' AND birth_date < '1980-01-01'
ORDER BY birth_date ASC;

SELECT first_name, last_name, birth_date
FROM patients
WHERE year(birth_date) LIKE '197%'
ORDER BY birth_date ASC;

/* 13 - We want to display each patient's full name in a single column. 
Their last_name in all upper letters must appear first, 
then first_name in all lower case letters. 
Separate the last_name and first_name with a comma. 
Order the list by the first_name in decending order
EX: SMITH,jane*/
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS new_name_format
FROM patients
ORDER BY first_name DESC;

/* This was my initial solution but was listed as 2nd solution out of 2*/
SELECT upper(last_name) || ',' || lower(first_name) as full_name
FROM patients
order by first_name desc; 

/* 14 - Show the province_id(s), sum of height; 
where the total sum of its patient's height is greater than or equal to 7,000.*/
SELECT province_id, sum(height) AS total_sum_height
FROM patients
group by province_id
having total_sum_height >= 7000; 

select * from 
    (select province_id, SUM(height) as sum_height 
    FROM patients 
    group by province_id) 
where sum_height >= 7000;

/* 15 - Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'*/
SELECT max(weight) - min(weight) as difference_max_min_height
FROM patients
WHERE last_name = 'Maroni'; 
