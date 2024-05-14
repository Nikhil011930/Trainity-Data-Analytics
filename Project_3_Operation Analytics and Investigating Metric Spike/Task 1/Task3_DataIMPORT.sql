CREATE DATABASE Project3;
USE Project3;

DROP TABLE Job_data;
CREATE TABLE job_data (
    ds VARCHAR(10),
    job_id INT NOT NULL,
    actor_id INT NOT NULL,
    event CHAR(50),
    language CHAR(50),
    time_spent INT,
    org CHAR
);

SHOW variables like 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/job_data.csv"
INTO TABLE job_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT 
    *
FROM
    job_data;

UPDATE job_data 
SET 
    ds = STR_TO_DATE(ds, '%m/%d/%Y'); 

ALTER TABLE job_data
MODIFY COLUMN ds DATE;


