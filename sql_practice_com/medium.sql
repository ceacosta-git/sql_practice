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

/* 16 - Show all of the days of the month (1-31) and how many admission_dates occurred on that day. 
Sort by the day with most admissions to least admissions.*/
SELECT day(admission_date) as day_number, COUNT(*) as number_of_admissions 
FROM admissions
group by day_number
order by number_of_admissions desc; 

/* 17 - Show all columns for patient_id 542's most recent admission_date.*/
SELECT *
FROM admissions
WHERE patient_id = 542
group by patient_id
having admission_date = max(admission_date);

SELECT *
FROM admissions
WHERE patient_id = 542 AND 
admission_date = (
  SELECT MAX(admission_date) 
  from admissions
  WHERE patient_id = 542
); 

/* This was my initial solution but was listed as 3rd solution out of 4*/
SELECT *
FROM admissions
WHERE patient_id = 542
order by admission_date DESC
limit 1;

SELECT *
FROM admissions
group by patient_id
having patient_id = 542 AND max(admission_date);

/* 18 - Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.*/
SELECT patient_id, attending_doctor_id, diagnosis
FROM admissions
WHERE (patient_id % 2 = 1 AND attending_doctor_id in (1, 5, 19)) or 
(attending_doctor_id like '%2%' AND len(patient_id) = 3); 

/* 19 - Show first_name, last_name, and the total number of admissions attended for each doctor.
Every admission has been attended by a doctor.*/
SELECT first_name, last_name, count(*) as total_admissions
FROM admissions
INNER JOIN doctors
ON doctors.doctor_id = admissions.attending_doctor_id
group by attending_doctor_id;

SELECT first_name, last_name, count(*) as total_admissions
FROM admissions, doctors
WHERE doctors.doctor_id = admissions.attending_doctor_id
group by attending_doctor_id;

/* 20 - For each doctor, display their id, full name, and the first and last admission date they attended.*/
SELECT doctor_id, 
concat(first_name, ' ', last_name) as full_name,
min(admission_date) AS first_admission_date, 
MAX(admission_date) AS last_admission_date
FROM doctors
INNER JOIN admissions
ON doctors.doctor_id = admissions.attending_doctor_id
group by doctors.doctor_id;

/* 21 - Display the total amount of patients for each province. Order by descending.*/
SELECT province_name, count(*) total_patients
FROM patients
INNER JOIN province_names
ON patients.province_id = province_names.province_id
GROUP BY patients.province_id
order by total_patients desc;

/* 22 - For every admission, display the patient's full name, their admission diagnosis, 
and their doctor's full name who diagnosed their problem.*/
SELECT 
CONCAT(patients.first_name, ' ', patients.last_name) as patient_full_name, 
diagnosis,
CONCAT(doctors.first_name, ' ', doctors.last_name) as doctor_full_name
FROM admissions
INNER JOIN patients
ON admissions.patient_id = patients.patient_id
INNER JOIN doctors
ON admissions.attending_doctor_id = doctors.doctor_id;

/* 23 - display the first name, last name and number of duplicate patients based on their first name and last name.
Ex: A patient with an identical name can be considered a duplicate.*/
SELECT first_name, last_name, count(*) as num_of_duplicates
FROM patients
group by first_name, last_name
having num_of_duplicates > 1;

SELECT first_name, last_name, count(*) as num_of_duplicates
FROM patients
group by (CONCAT(first_name,' ',last_name))
having num_of_duplicates > 1;

/* 24 - Display patient's full name,
height in the units feet rounded to 1 decimal,
weight in the unit pounds rounded to 0 decimals,
birth_date,
gender non abbreviated.

Convert CM to feet by dividing by 30.48.
Convert KG to pounds by multiplying by 2.205.*/
SELECT 
  CONCAT(first_name, ' ', last_name) as patient_name,
  round(height/30.48, 1) as height_feet,
  ROUND(weight*2.205, 0) AS weight_pounds,
  birth_date,
  (CASE 
     wheN gender = 'M' THEN 'Male'
     WHEN gender = 'F' THEN 'Female'
   END) AS gender
FROM patients;

/* 25 - Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table.
(Their patient_id does not exist in any admissions.patient_id rows.)*/
SELECT patients.patient_id, first_name, last_name
from patients
where patients.patient_id not in (
    select admissions.patient_id
    from admissions
  );

/* This was my initial solution but was listed as 2nd solution out of 2*/
SELECT patients.patient_id, patients.first_name, patients.last_name 
FROM patients
LEFT OUTER JOIN admissions
ON patients.patient_id = admissions.patient_id
WHERE admissions.patient_id is null;
