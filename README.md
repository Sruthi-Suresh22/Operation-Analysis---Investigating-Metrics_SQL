# OPERATION ANALYSIS AND INVESTIGATING METRICS SPIKE

### Table of Contents

- [Project Description](#project-description)
- [Dataset Details](#dataset-details)
- [Tasks](#tasks)
- [Insights](#insights)
- [Conclusion](#conclusion)

### Project Description

Operational Analytics is a crucial process that involves analyzing company’s end-to-end operations. The key aspect of Operational Analytics is investigating metric spikes which involves understanding and explaining sudden changes in key metrics, such as a dip in daily user engagement or drop in sales. As a Lead data Analyst at a company like Microsoft, this project helps in utilizing advanced SQL skills to analyze the data and provide valuable insights that can help in improving the company’s operations and understand sudden changes in key metrics.

### Dataset Details

For Case Study 1: Job Data Analysis, a table named **job_data** with the following columns are available:
- `job_id`: Unique identifier of jobs
- `actor_id`: Unique identifier of actor
- `event`: The type of event (decision/skip/transfer).
- `language`: The Language of the content
- `time_spent`: Time spent to review the job in seconds.
- `org`: The Organization of the actor
- `ds`: The date in the format yyyy/mm/dd (stored as text).
  
For Case Study 2: Investigating Metric Spike, there are 3 tables which are as follows:
- **users**: Contains one row per user, with descriptive information about that user’s account.
- **events**: Contains one row per event, where an event is an action that a user has taken (e.g., login, messaging, search).
- **email_events**: Contains events specific to the sending of emails.

### Tasks 

#### Case Study 1 : Job Data Analysis

A. **Jobs Reviewed Over Time**
   - Objective: Calculate the number of jobs reviewed per hour for each day in November 2020.
   - Your Task: Write an SQL query to calculate the number of jobs reviewed per hour for each day in November 2020.
     
B. **Throughput Analysis**
   - Objective: Calculate the 7-day rolling average of throughput (number of events per second).
   - Your Task: Write an SQL query to calculate the 7-day rolling average of throughput. Additionally, explain whether you prefer using the daily metric or the 7-day rolling average for throughput, and why.
     
C. **Language Share Analysis**
   - Objective: Calculate the percentage share of each language in the last 30 days.
   - Your Task: Write an SQL query to calculate the percentage share of each language over the last 30 days.
     
D. **Duplicate Rows Detection**
   - Objective: Identify duplicate rows in the data.
   - Your Task: Write an SQL query to display duplicate rows from the job_data table.

### Case Study 2: Investigating Metric Spike
A. **Weekly User Engagement**
   - Objective: Measure the activeness of users on a weekly basis.
   - Your Task: Write an SQL query to calculate the weekly user engagement.
     
B. **User Growth Analysis**
   - Objective: Analyze the growth of users over time for a product.
   - Your Task: Write an SQL query to calculate the user growth for the product.
     
C. **Weekly Retention Analysis**
   - Objective: Analyze the retention of users on a weekly basis after signing up for a product.
   - Your Task: Write an SQL query to calculate the weekly retention of users based on their sign-up cohort.
     
D. **Weekly Engagement Per Device**
   - Objective: Measure the activeness of users on a weekly basis per device.
   - Your Task: Write an SQL query to calculate the weekly engagement per device.
     
E. **Email Engagement Analysis**
   - Objective: Analyze how users are engaging with the email service.
   - Your Task: Write an SQL query to calculate the email engagement metrics.

### Insights

#### Case Study 1 : Job Data Analysis

A. Jobs Reviewed Over Time

Query:
```sql
SELECT ds AS "Dates", ROUND((COUNT(DISTINCT(job_id))/SUM(time_spent))*60*60) AS "No. of jobs reviewed per hour per day"
FROM job_data
WHERE ds BETWEEN "2020-11-01" AND "2020-11-30"
GROUP BY ds;
```
Result:
| Dates       |  No. of jobs reviewed per hour per day |
|-------------|----------------------------------------|
| 2020-11-25  | 80                                     |
| 2020-11-26  | 64                                     |
| 2020-11-27  | 35                                     |
| 2020-11-28  | 218                                    |
| 2020-11-29  | 180                                    |
| 2020-11-30  | 180                                    |

B. Throughput Analysis

Query:
```sql
SELECT ds AS "Dates", ROUND((COUNT(DISTINCT(event))/SUM(time_spent)),2) AS "Daily Throughput"
FROM job_data
GROUP BY ds;
```
Result:
| Dates       |  Daily Throughput |
|-------------|-------------------|
| 2020-11-25  | 0.02              |
| 2020-11-26  | 0.02              |
| 2020-11-27  | 0.01              |
| 2020-11-28  | 0.06              |
| 2020-11-29  | 0.05              |
| 2020-11-30  | 0.05              |

Query:
```sql
SELECT ROUND(COUNT(event)/SUM(time_spent),2) AS "Weekly Throughput"
FROM job_data;
```
Result:
| Weekly Throughput |
|-------------------|
| 0.03              |

C. Language Share Analysis

Query:
```sql
SELECT language AS "Languages", ROUND((COUNT(language)/(SELECT COUNT(*) FROM job_data))*100,2) AS "Percentage(%)" 
FROM job_data
GROUP BY language;
```
Result:
| Languages |  Percentage(%) |
|-----------|----------------|
| English   | 12.50          |
| Arabic    | 12.50          |
| Persian   | 37.50          |
| Hindi     | 12.50          |
| French    | 12.50          |
| Italian   | 12.50          |

D. Duplicate Rows Detection

Query:
```sql
SELECT actor_id AS "Actor ID", COUNT(*) AS "No. of Duplicate rows"
FROM job_data
GROUP BY actor_id
HAVING COUNT(*)>1;
```
Result:

| Actor ID |  No. of Duplicate rows |
|----------|------------------------|
| 1003     | 2                      |

Query:
```sql
SELECT job_id AS "Job ID", COUNT(*) AS "No. of Duplicate rows"
FROM job_data
GROUP BY job_id
HAVING COUNT(*)>1;
```
Result:
| Job ID |  No. of Duplicate rows |
|--------|------------------------|
| 23     | 3                      |

### Case Study 2: Investigating Metric Spike

A. Weekly User Engagement

Query:
```sql
SELECT EXTRACT(WEEK FROM(occurred_at)) AS "Week Number",COUNT(DISTINCT(user_id)) AS "Number of Active Users"
FROM events WHERE event_type ="engagement" GROUP BY 1;
```
B. User Growth Analysis

Query: Month-wise user growth analysis
```sql
SELECT Months, Number_of_Users, 
ROUND(((Number_of_Users/LAG(Number_of_Users,1) OVER (ORDER BY Months)-1)*100),2) AS "Growth in %" 
FROM 
(SELECT EXTRACT(MONTH FROM created_at) AS "Months", COUNT(*) AS "Number_of_Users"
FROM users WHERE activated_at IS NOT NULL
GROUP BY 1 ORDER BY 1) AS sub;
```
Year-wise user growth analysis
```sql
SELECT Year, Number_of_Users, 
ROUND(((Number_of_Users/LAG(Number_of_Users,1) OVER (ORDER BY Year)-1)*100),2) AS "Growth in %" 
FROM 
(SELECT EXTRACT(YEAR FROM created_at) AS "Year", COUNT(*) AS "Number_of_Users"
FROM users WHERE activated_at IS NOT NULL
GROUP BY 1 ORDER BY 1) AS sub;
```
C. Weekly Retention Analysis

Query:
```sql
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
```

D. Weekly Engagement Per Device

Query:
```sql
SELECT EXTRACT(WEEK FROM (occurred_at)) AS "Weeks",
device AS "Device",COUNT(DISTINCT(user_id)) AS "User Engagement"
FROM events
GROUP BY 2,1
ORDER BY 1;
```
E. Email Engagement Analysis

Query:
```sql
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
```
