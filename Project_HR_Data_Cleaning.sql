CREATE DATABASE project_sql;
USE project_sql;

SELECT * FROM human_resources ;

ALTER TABLE human_resources
RENAME COLUMN `ï»¿id` TO emp_id;

ALTER TABLE human_resources
MODIFY COLUMN emp_id VARCHAR(20);


DESC human_resources;

SELECT birthdate FROM human_resources;
SELECT hire_date FROM human_resources;
SELECT termdate FROM human_resources;

UPDATE human_resources
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE human_resources
MODIFY COLUMN birthdate DATE;


UPDATE human_resources
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE human_resources
MODIFY COLUMN hire_date DATE;

DESC human_resources;

UPDATE human_resources
SET age = timestampdiff(YEAR, birthdate, CURDATE());

DESC human_resources;

SELECT age FROM human_resources;

ALTER TABLE human_resources
ADD COLUMN age INT;

UPDATE human_resources
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ' ';

SET sql_mode = 'ALLOW_INVALID_DATES';

SELECT termdate FROM human_resources;

ALTER TABLE human_resources
MODIFY COLUMN termdate DATE;


SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM human_resources;

SELECT count(*) FROM human_resources WHERE age < 18;



SELECT COUNT(*) FROM human_resources WHERE termdate > CURDATE();

SELECT COUNT(*)
FROM human_resources
WHERE termdate = '0000-00-00';

SELECT location FROM human_resources;