-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
SELECT gender, COUNT(*) AS count
FROM human_resources
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1;

-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race, COUNT(*) AS count
FROM human_resources
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1
ORDER BY 2 DESC;

-- 3. What is the age distribution of employees in the company?
SELECT
	MIN(age) as youngest,
    MAX(age) as oldest
FROM human_resources
WHERE age >= 18 AND termdate = '0000-00-00';

SELECT
	CASE
		WHEN age BETWEEN 18 AND 24 THEN '18-24'
		WHEN age BETWEEN 25 AND 34 THEN '25-34'
		WHEN age BETWEEN 35 AND 44 THEN '35-44'
		WHEN age BETWEEN 45 AND 54 THEN '45-54'
		WHEN age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
	END as age_group,
    gender,
    COUNT(*) AS count
FROM human_resources
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1, 2
ORDER BY 1, 2;

-- 4. How many employees work at headquarters versus remote locations?
SELECT 
	location,
    COUNT(*) AS count
FROM human_resources
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT
	ROUND(AVG(DATEDIFF(termdate, hire_date))/365,0) as avg_length_employement
FROM human_resources
WHERE termdate <= CURDATE() AND termdate <> '0000-00-00' AND age >= 18;


-- 6. How does the gender distribution vary across departments and job titles?
SELECT
	department,
    gender,
    COUNT(*) AS count
FROM human_resources
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1, 2
ORDER BY 1;

-- 7. What is the distribution of job titles across the company?
SELECT
	jobtitle,
    COUNT(*) AS count
FROM human_resources
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1
ORDER BY 1 DESC;

-- 8. Which department has the highest turnover rate?
SELECT
	department,
    total_count,
    terminated_count,
    terminated_count/total_count as termination_rate
FROM (
	SELECT
		department,
        COUNT(*) total_count,
        SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count
	FROM human_resources
    WHERE age >= 18
    GROUP BY 1) AS derived_table
ORDER BY termination_rate DESC;

-- 9. What is the distribution of employees across locations by city and state?
SELECT
	location_state,
    COUNT(*) AS count
FROM human_resources
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1
ORDER BY 2 DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT
	years,
    hires,
    terminations,
    hires-terminations as net_change,
    ROUND((hires-terminations)/hires *100, 2) as net_change_percent
FROM (
	SELECT
		EXTRACT(YEAR FROM hire_date) as years,
        COUNT(*) AS hires,
        SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
	FROM human_resources
	WHERE age >= 18
    GROUP BY 1
    ) as derived_table
ORDER BY years ASC;

-- 11. What is the tenure distribution for each department?
SELECT
	department,
    ROUND(AVG(DATEDIFF(termdate, hire_date)/365)) AS avg_tenure
FROM human_resources
WHERE termdate <= CURDATE() AND termdate <> '0000-00-00' AND age >= 18
GROUP BY 1;

