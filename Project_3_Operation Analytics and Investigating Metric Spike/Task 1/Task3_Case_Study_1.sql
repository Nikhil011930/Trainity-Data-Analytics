USE Project3;

SELECT * FROM job_data;

-- A. Jobs Reviewed Over Time:
-- Objective: Calculate the number of jobs reviewed per hour for each day in November 2020.
-- Your Task: Write an SQL query to calculate the number of jobs reviewed per hour for each day in November 2020.

SELECT 
    ds AS review_date,
    HOUR(time_spent) AS review_hour,
    COUNT(job_id) AS job_reviewed_per_hours
FROM
    job_data
WHERE
    ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY 
	ds , review_hour
ORDER BY 
	ds , review_hour;

-- B. Throughput Analysis:    
-- Objective: Calculate the 7-day rolling average of throughput (number of events per second).
-- Your Task: Write an SQL query to calculate the 7-day rolling average of throughput. Additionally, explain whether you prefer using the daily metric or the 7-day rolling average for throughput, and why.

SELECT
    ds,
    ROUND (COUNT(event) / COUNT(DISTINCT ds)) AS daily_throughput,
    ROUND (AVG(COUNT(event) / COUNT(DISTINCT ds)) OVER (ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 3) AS rolling_avg_throughput
FROM
    job_data
GROUP BY
    ds
ORDER BY
    ds;
    

-- Language Share Analysis:
-- Objective: Calculate the percentage share of each language in the last 30 days.
-- Your Task: Write an SQL query to calculate the percentage share of each language over the last 30 days.

SELECT 
    job_data.language,
    COUNT(DISTINCT language) AS Total_of_each_language,
    ROUND(((COUNT(language) / (SELECT 
            COUNT(*)
        FROM
            job_data)) * 100), 2) AS Percentage_share_of_each_language
FROM
    job_data
GROUP BY job_data.language;

-- Duplicate Rows Detection:
-- Objective: Identify duplicate rows in the data.
-- Your Task: Write an SQL query to display duplicate rows from the job_data table.

SELECT * FROM ( 
	SELECT *, 
    ROW_NUMBER() OVER (PARTITION BY job_id) AS Total_numb_row
FROM 
	job_data) _row
WHERE 
	Total_numb_row > 1;
    
    