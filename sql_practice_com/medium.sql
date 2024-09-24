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
