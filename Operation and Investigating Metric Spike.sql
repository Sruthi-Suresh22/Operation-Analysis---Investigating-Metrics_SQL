CREATE DATABASE PROJECT3;
USE PROJECT3;

#CASE STUDY 1: JOB DATA ANALYSIS

CREATE TABLE job_data(
ds varchar(100),
job_id int,
actor_id int,
event varchar(50),
language varchar(50),
time_spent int,
org varchar(5));

SELECT * FROM job_data;

ALTER TABLE job_data ADD COLUMN temp_ds DATETIME;

SET sql_safe_updates = 0;

UPDATE job_data SET temp_ds = STR_TO_DATE(ds, '%m/%d/%Y');

ALTER TABLE job_data DROP COLUMN ds;

ALTER TABLE job_data CHANGE COLUMN temp_ds ds DATETIME;

#TASK-A : JOBS REVIEWED OVER TIME
SELECT ds AS "Dates", ROUND((COUNT(DISTINCT(job_id))/SUM(time_spent))*60*60) AS "No. of jobs reviewed per hour per day"
FROM job_data
WHERE ds BETWEEN "2020-11-01" AND "2020-11-30"
GROUP BY ds;

#TASK-B : THROUGHPUT ANALYSIS
SELECT ds AS "Dates", ROUND((COUNT(DISTINCT(event))/SUM(time_spent)),2) AS "Daily Throughput"
FROM job_data
GROUP BY ds;
SELECT ROUND(COUNT(event)/SUM(time_spent),2) AS "Weekly Throughput"
FROM job_data;

#TASK-C : LANGUAGE SHARE ANALYSIS
SELECT language AS "Languages", ROUND((COUNT(language)/(SELECT COUNT(*) FROM job_data))*100,2) AS "Percentage(%)" 
FROM job_data
GROUP BY language;

#TASK-D : DUPLICATE ROWS DETECTION
SELECT actor_id AS "Actor ID", COUNT(*) AS "No. of Duplicate rows"
FROM job_data
GROUP BY actor_id
HAVING COUNT(*)>1;

SELECT job_id AS "Job ID", COUNT(*) AS "No. of Duplicate rows"
FROM job_data
GROUP BY job_id
HAVING COUNT(*)>1;

#CASE STUDY 2: INVESTIGATING METRIC SPIKE

CREATE TABLE users(
user_id int,
created_at varchar(100),
company_id int,
language varchar(50),
activated_at varchar(100),
state varchar(50));

SELECT * FROM users;

ALTER TABLE users ADD COLUMN temp_created_at DATETIME;

SET sql_safe_updates = 0;

UPDATE users SET temp_created_at = STR_TO_DATE(created_at, '%d-%m-%Y %H:%i');

ALTER TABLE users DROP COLUMN created_at;

ALTER TABLE users CHANGE COLUMN temp_created_at created_at DATETIME;

ALTER TABLE users ADD COLUMN temp_activated_at DATETIME;

SET sql_safe_updates = 0;

UPDATE users SET temp_activated_at = STR_TO_DATE(activated_at, '%d-%m-%Y %H:%i');

ALTER TABLE users DROP COLUMN activated_at;

ALTER TABLE users CHANGE COLUMN temp_activated_at activated_at DATETIME;

CREATE TABLE events(
user_id int,
occurred_at varchar(100),
event_type varchar(50),
event_name varchar(100),
location varchar(50),
device varchar(50),
user_type int);

SELECT * FROM events;

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"
INTO TABLE events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE events ADD COLUMN temp_occurred_at DATETIME;

SET sql_safe_updates = 0;

UPDATE events SET temp_occurred_at = STR_TO_DATE(occurred_at, '%d-%m-%Y %H:%i');

ALTER TABLE events DROP COLUMN occurred_at;

ALTER TABLE events CHANGE COLUMN temp_occurred_at occurred_at DATETIME;

CREATE TABLE email_events(
user_id int,
occurred_at varchar(100),
action varchar(50),
user_type int);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv"
INTO TABLE email_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM email_events;

ALTER TABLE email_events ADD COLUMN temp_occurred_at DATETIME;

SET sql_safe_updates = 0;

UPDATE email_events SET temp_occurred_at = STR_TO_DATE(occurred_at, '%d-%m-%Y %H:%i');

ALTER TABLE email_events DROP COLUMN occurred_at;

ALTER TABLE email_events CHANGE COLUMN temp_occurred_at occurred_at DATETIME;

#TASK-A : WEEKLY USER ENGAGEMENT
SELECT EXTRACT(WEEK FROM(occurred_at)) AS "Week Number",COUNT(DISTINCT(user_id)) AS "Number of Active Users"
FROM events WHERE event_type ="engagement" GROUP BY 1;

#TASK-B : USER GROWTH ANALYSIS
-- MONTH WISE USER GROWTH ANALYSIS
SELECT Months, Number_of_Users, 
ROUND(((Number_of_Users/LAG(Number_of_Users,1) OVER (ORDER BY Months)-1)*100),2) AS "Growth in %" 
FROM 
(SELECT EXTRACT(MONTH FROM created_at) AS "Months", COUNT(*) AS "Number_of_Users"
FROM users WHERE activated_at IS NOT NULL
GROUP BY 1 ORDER BY 1) AS sub;

-- YEAR WISE USER GROWTH ANALYSIS
SELECT Year, Number_of_Users, 
ROUND(((Number_of_Users/LAG(Number_of_Users,1) OVER (ORDER BY Year)-1)*100),2) AS "Growth in %" 
FROM 
(SELECT EXTRACT(YEAR FROM created_at) AS "Year", COUNT(*) AS "Number_of_Users"
FROM users WHERE activated_at IS NOT NULL
GROUP BY 1 ORDER BY 1) AS sub;

#TASK-C: WEEKLY RETENTION ANALYSIS
SELECT weekn AS "Week Numbers",
SUM(CASE WHEN week_number = 0 THEN 1 ELSE 0 END) AS "Week 0",
SUM(CASE WHEN week_number = 1 THEN 1 ELSE 0 END) AS "Week 1",
SUM(CASE WHEN week_number = 2 THEN 1 ELSE 0 END) AS "Week 2",
SUM(CASE WHEN week_number = 3 THEN 1 ELSE 0 END) AS "Week 3",
SUM(CASE WHEN week_number = 4 THEN 1 ELSE 0 END) AS "Week 4",
SUM(CASE WHEN week_number = 5 THEN 1 ELSE 0 END) AS "Week 5",
SUM(CASE WHEN week_number = 6 THEN 1 ELSE 0 END) AS "Week 6",
SUM(CASE WHEN week_number = 7 THEN 1 ELSE 0 END) AS "Week 7",
SUM(CASE WHEN week_number = 8 THEN 1 ELSE 0 END) AS "Week 8",
SUM(CASE WHEN week_number = 9 THEN 1 ELSE 0 END) AS "Week 9",
SUM(CASE WHEN week_number = 10 THEN 1 ELSE 0 END) AS "Week 10",
SUM(CASE WHEN week_number = 11 THEN 1 ELSE 0 END) AS "Week 11",
SUM(CASE WHEN week_number = 12 THEN 1 ELSE 0 END) AS "Week 12",
SUM(CASE WHEN week_number = 13 THEN 1 ELSE 0 END) AS "Week 13",
SUM(CASE WHEN week_number = 14 THEN 1 ELSE 0 END) AS "Week 14",
SUM(CASE WHEN week_number = 15 THEN 1 ELSE 0 END) AS "Week 15",
SUM(CASE WHEN week_number = 16 THEN 1 ELSE 0 END) AS "Week 16", 
SUM(CASE WHEN week_number = 17 THEN 1 ELSE 0 END) AS "Week 17",
SUM(CASE WHEN week_number = 18 THEN 1 ELSE 0 END) AS "Week 18"
FROM (SELECT A.user_id, A.login_week, B.weekn, A.login_week - weekn AS week_number
FROM (SELECT  user_id, EXTRACT(WEEK FROM(occurred_at)) AS login_week
FROM events GROUP BY 1, 2) AS A, 
(SELECT  user_id,  
MIN(EXTRACT(WEEK FROM(occurred_at))) AS weekn
FROM events GROUP BY 1) AS B 
WHERE A.user_id = B.user_id
) AS sub 
GROUP BY weekn 
ORDER BY weekn;

#TASK-D : WEEKLY ENGAGEMENT PER DEVICE
SELECT EXTRACT(WEEK FROM (occurred_at)) AS "Weeks",
device AS "Device",COUNT(DISTINCT(user_id)) AS "User Engagement"
FROM events
GROUP BY 2,1
ORDER BY 1;

#TASK-E : EMAIL ENGAGEMENT METRICS
SELECT Week_number AS "Week Number", ROUND((Weekly_Digest/total)*100,2) AS "Weekly Digest Rate",
ROUND((Reengagement_Mail/total)*100,2) AS "Re-engagement Mail Rate",
ROUND((Opened_Email/total)*100,2) AS "Opened Email Rate",
ROUND((Email_Clickthrough/total)*100,2) AS "Email Clickthrough Rate" FROM(
SELECT EXTRACT(WEEK FROM (occurred_at)) AS "Week_number",
COUNT(DISTINCT(CASE WHEN action = "sent_weekly_digest" THEN user_id END)) AS "Weekly_Digest",
COUNT(DISTINCT(CASE WHEN action = "sent_reengagement_email" THEN user_id END)) AS "Reengagement_Mail",
COUNT(DISTINCT(CASE WHEN action = "email_open" THEN user_id END)) AS "Opened_Email",
COUNT(DISTINCT(CASE WHEN action = "email_clickthrough" THEN user_id END)) AS "Email_Clickthrough",
COUNT(user_id) AS "total"
FROM email_events
GROUP BY 1) AS sub;

