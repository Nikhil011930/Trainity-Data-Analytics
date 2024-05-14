USE project3;

-- TABLE 1: USERS

DROP TABLE users;
CREATE TABLE users (
    user_id INT,
    created_at VARCHAR(20),
    company_id INT,
    language VARCHAR(20),
    active_at VARCHAR(20),
    state VARCHAR(50)
);

SHOW variables like 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv"
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM users;


UPDATE users 
SET 
    created_at = STR_TO_DATE(created_at, '%d-%m-%Y %H:%i'),
    active_at = STR_TO_DATE(active_at, '%d-%m-%Y %H:%i'); 

ALTER TABLE users
MODIFY COLUMN created_at DATETIME, 
MODIFY COLUMN active_at DATETIME;

-- TABLE2: EVENTS
DROP TABLE events;
CREATE TABLE events (
    user_id INT NOT NULL,
    occured_at VARCHAR(50),
    event_type VARCHAR(50),
    event_name VARCHAR(50),
    location VARCHAR(50),
    device VARCHAR(100),
    user_type INT
);

SHOW variables like 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"
INTO TABLE events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM events;

UPDATE events
SET 
    occured_at = STR_TO_DATE(occured_at, '%d-%m-%Y %H:%i');
 
ALTER TABLE events
MODIFY COLUMN occured_at DATETIME;

SELECT * FROM events;

-- TABLE 3: EMAIL_EVENTS
DROP TABLE email_events;

CREATE TABLE email_events(
    user_id INT,
    occured VARCHAR(50),
    action VARCHAR(50),
    user_type INT
);

SHOW variables like 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv"
INTO TABLE email_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM email_events;

UPDATE email_events
SET 
    occured = STR_TO_DATE(occured, '%d-%m-%Y %H:%i');
 
ALTER TABLE email_events
MODIFY COLUMN occured DATETIME;

SELECT * FROM email_events;

-- MAKING PRIMARY KEY AND FOREIGN KEYS FOR ALL 3 TABLES.
-- Add primary key to the 'users' table
ALTER TABLE users
ADD PRIMARY KEY (user_id);

-- Add foreign key to the 'events' table referencing 'users' table
ALTER TABLE events
ADD CONSTRAINT fk_events_user
FOREIGN KEY (user_id) REFERENCES users(user_id);

-- Add primary key to the 'events' table
ALTER TABLE events
ADD PRIMARY KEY (user_id, occured_at);

-- Add foreign key to the 'email_events' table referencing 'users' table
ALTER TABLE email_events
ADD CONSTRAINT fk_email_events_user
FOREIGN KEY (user_id) REFERENCES users(user_id);

-- Add primary key to the 'email_events' table
ALTER TABLE email_events
ADD PRIMARY KEY (user_id, occured);

-- Optionally, you can add foreign key to the 'events' table referencing 'users' table
-- This assumes that the 'user_id' in the 'events' table is a foreign key referencing 'users' table
ALTER TABLE events
ADD CONSTRAINT fk_events_user
FOREIGN KEY (user_id) REFERENCES users(user_id);
