-- PROJECT 3 Task 2
USE  project3;

# A. Weekly User Engagement:
-- Objective: Measure the activeness of users on a weekly basis.
-- Your Task: Write an SQL query to calculate the weekly user engagement.

SELECT
    WEEK(occured_at) AS week_number,
    COUNT(DISTINCT user_id) AS engagement_count
FROM
    events
GROUP BY
    week_number
ORDER BY
    week_number;

-- B.User Growth Analysis:
-- Objective: Analyze the growth of users over time for a product.
-- Your Task: Write an SQL query to calculate the user growth for the product.

SELECT
	registration_year, 
	registration_month, 
	registration_week,
	new_user_count,
	SUM(new_user_count) OVER(ORDER BY registration_year, registration_month, registration_week) AS cumulative_new_users_count
FROM
(SELECT
    YEAR(created_at) AS registration_year,
    MONTH(created_at) AS registration_month,
    WEEK(created_at) AS registration_week,
    COUNT(DISTINCT user_id) AS new_user_count
FROM
    users
	GROUP BY
    registration_year, registration_month, registration_week) AS subquery
ORDER BY
    registration_year, registration_month, registration_week;

-- C. Weekly Retention Analysis:
-- Objective: Analyze the retention of users on a weekly basis after signing up for a product.
-- Your Task: Write an SQL query to calculate the weekly retention of users based on their sign-up cohort.

WITH user_cohorts AS ( SELECT
        user_id,
        created_at AS signup_date
    FROM users),
user_activity AS ( SELECT
        user_id,
        MIN(occured_at) AS first_engagement_date
    FROM
        events
    GROUP BY user_id)
SELECT
    UC.user_id,
    UC.signup_date,
    WEEK(UA.first_engagement_date) AS engagement_week,
    COUNT(DISTINCT UA.user_id) AS retained_users,
    SUM(COUNT(DISTINCT UA.user_id)) OVER (ORDER BY WEEK(UA.first_engagement_date)) AS total_retained_users
FROM
    user_cohorts UC
JOIN
    user_activity UA ON UC.user_id = UA.user_id
WHERE
    WEEK(UA.first_engagement_date) = WEEK(UC.signup_date)
GROUP BY
    UC.user_id, UC.signup_date, engagement_week
ORDER BY
    UC.user_id, UC.signup_date, engagement_week;



-- D. Weekly Engagement Per Device:
-- Objective: Measure the activeness of users on a weekly basis per device.
-- Your Task: Write an SQL query to calculate the weekly engagement per device.

SELECT
    YEAR(occured_at) AS year_number,
    WEEK(occured_at) AS week_number,
    device,
    COUNT(*) AS engagement_count
FROM
    events
WHERE
    occured_at IS NOT NULL
GROUP BY
    year_number, week_number, device
ORDER BY
    year_number, week_number, device;

-- E. Email Engagement Analysis:
-- Objective: Analyze how users are engaging with the email service.
-- Your Task: Write an SQL query to calculate the email engagement metrics.

SELECT
    action,
    COUNT(*) AS total_events,
    COUNT(DISTINCT user_id) AS unique_users_engaged,
    ROUND(COUNT(*) / COUNT(DISTINCT user_id),2) AS average_engagement_per_user
FROM
    email_events
GROUP BY
    action
ORDER BY
    action;

