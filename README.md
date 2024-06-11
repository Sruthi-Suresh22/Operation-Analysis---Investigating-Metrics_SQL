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
   - *Objective*: Calculate the number of jobs reviewed per hour for each day in November 2020.
   - *Your Task*: Write an SQL query to calculate the number of jobs reviewed per hour for each day in November 2020.
     
B. **Throughput Analysis**
   - *Objective*: Calculate the 7-day rolling average of throughput (number of events per second).
   - *Your Task*: Write an SQL query to calculate the 7-day rolling average of throughput. Additionally, explain whether you prefer using the daily metric or the 7-day rolling average for throughput, and why.
     
C. **Language Share Analysis**
   - *Objective*: Calculate the percentage share of each language in the last 30 days.
   - *Your Task*: Write an SQL query to calculate the percentage share of each language over the last 30 days.
     
D. **Duplicate Rows Detection**
   - *Objective*: Identify duplicate rows in the data.
   - *Your Task*: Write an SQL query to display duplicate rows from the job_data table.

### Case Study 2: Investigating Metric Spike
A. **Weekly User Engagement**
   - *Objective*: Measure the activeness of users on a weekly basis.
   - *Your Task*: Write an SQL query to calculate the weekly user engagement.
     
B. **User Growth Analysis**
   - *Objective*: Analyze the growth of users over time for a product.
   - *Your Task*: Write an SQL query to calculate the user growth for the product.
     
C. **Weekly Retention Analysis**
   - *Objective*: Analyze the retention of users on a weekly basis after signing up for a product.
   - *Your Task*: Write an SQL query to calculate the weekly retention of users based on their sign-up cohort.
     
D. **Weekly Engagement Per Device**
   - *Objective*: Measure the activeness of users on a weekly basis per device.
   - *Your Task*: Write an SQL query to calculate the weekly engagement per device.
     
E. **Email Engagement Analysis**
   - *Objective*: Analyze how users are engaging with the email service.
   - *Your Task*: Write an SQL query to calculate the email engagement metrics.

### Insights

#### Case Study 1 : Job Data Analysis

**A. Jobs Reviewed Over Time**

*- Query:*
```sql
SELECT ds AS "Dates", ROUND((COUNT(DISTINCT(job_id))/SUM(time_spent))*60*60) AS "No. of jobs reviewed per hour per day"
FROM job_data
WHERE ds BETWEEN "2020-11-01" AND "2020-11-30"
GROUP BY ds;
```
<details>
 <summary>Output:</summary>
  
| Dates       |  No. of jobs reviewed per hour per day |
|-------------|----------------------------------------|
| 2020-11-25  | 80                                     |
| 2020-11-26  | 64                                     |
| 2020-11-27  | 35                                     |
| 2020-11-28  | 218                                    |
| 2020-11-29  | 180                                    |
| 2020-11-30  | 180                                    |
</details>

*- Insights:*

The number of jobs reviewed per hour per day is maximum on 28th November 2020 which is 218 followed by 29th and 30th of November 2020 which is 180.The number of jobs reviewed per hour per day is minimum on 27th November 2020  which is 35.


**B. Throughput Analysis**

*- Query:*
```sql
SELECT ds AS "Dates", ROUND((COUNT(DISTINCT(event))/SUM(time_spent)),2) AS "Daily Throughput"
FROM job_data
GROUP BY ds;
```
<details>
  <summary>Output:</summary>
  
| Dates       |  Daily Throughput |
|-------------|-------------------|
| 2020-11-25  | 0.02              |
| 2020-11-26  | 0.02              |
| 2020-11-27  | 0.01              |
| 2020-11-28  | 0.06              |
| 2020-11-29  | 0.05              |
| 2020-11-30  | 0.05              |
</details>

*- Query:*
```sql
SELECT ROUND(COUNT(event)/SUM(time_spent),2) AS "Weekly Throughput"
FROM job_data;
```
<details>
  <summary>Output:</summary>
  
| Weekly Throughput |
|-------------------|
| 0.03              |
</details>

*- Insights:*

The throughput analysis were analyzed daily and the highest throughput was found to be 0.06 on 28th November 2020 and lowest throughput was found to be 0.01 on 27th November 2020.The weekly throughput analysis were also done and is found to be 0.03.Generally, Rolling average for throughput = sum of data over time / time period. To discover the trends in data, using smaller parts of the data is preferred. Considering the above data, daily metric gives a better understanding of trends going up or down. However, there are chances of incorrect insights drawn because of daily fluctuations.

**C. Language Share Analysis**

*- Query:*
```sql
SELECT language AS "Languages", ROUND((COUNT(language)/(SELECT COUNT(*) FROM job_data))*100,2) AS "Percentage(%)" 
FROM job_data
GROUP BY language;
```
<details>
  <summary>Output:</summary>
  
| Languages |  Percentage(%) |
|-----------|----------------|
| English   | 12.50          |
| Arabic    | 12.50          |
| Persian   | 37.50          |
| Hindi     | 12.50          |
| French    | 12.50          |
| Italian   | 12.50          |
</details>

*- Insights:*

Over the last 30 days, the highest percentage share was for the Persian Language which accounts to 37.50% and the remaining languages English, Arabic, Hindi, French and Italian have a share of 12.50% each.

**D. Duplicate Rows Detection**

*- Query:*
```sql
SELECT actor_id AS "Actor ID", COUNT(*) AS "No. of Duplicate rows"
FROM job_data
GROUP BY actor_id
HAVING COUNT(*)>1;
```
<details>
  <summary>Output:</summary>
  
| Actor ID |  No. of Duplicate rows |
|----------|------------------------|
| 1003     | 2                      |
</details>

*- Query:*
```sql
SELECT job_id AS "Job ID", COUNT(*) AS "No. of Duplicate rows"
FROM job_data
GROUP BY job_id
HAVING COUNT(*)>1;
```
<details>
  <summary>Output:</summary>
  
| Job ID |  No. of Duplicate rows |
|--------|------------------------|
| 23     | 3                      |
</details>

*- Insights:*

While considering the actor_id column, there are 2 records corresponding to actor_id 1003 and while considering the job_id column, there are 3 records having the same job_id as 23.

### Case Study 2: Investigating Metric Spike

**A. Weekly User Engagement**

*- Query:*
```sql
SELECT EXTRACT(WEEK FROM(occurred_at)) AS "Week Number",COUNT(DISTINCT(user_id)) AS "Number of Active Users"
FROM events WHERE event_type ="engagement" GROUP BY 1;
```
<details>
  <summary>Output:</summary>
  
| Week Number |  Number of Active Users |
|-------------|-------------------------|
| 17          | 663                     |
| 18          | 1068                    |
| 19          | 1113                    |
| 20          | 1154                    |
| 21          | 1121                    |
| 22          | 1186                    |
| 23          | 1232                    |
| 24          | 1275                    |
| 25          | 1264                    |
| 26          | 1302                    |
| 27          | 1372                    |
| 28          | 1365                    |
| 29          | 1376                    |
| 30          | 1467                    |
| 31          | 1299                    |
| 32          | 1225                    |
| 33          | 1225                    |
| 34          | 1204                    |
| 35          | 104                     |
</details>

*- Insights:*

Weekly User Engagement metrics measures the number of unique users who engage with a product/app/service within a 7-day period.The highest number of active users were in the 30th week of November and least user engagement was in the 35th week of November.

**B. User Growth Analysis**

*- Query: Month-wise user growth analysis*
```sql
SELECT Months, Number_of_Users, 
ROUND(((Number_of_Users/LAG(Number_of_Users,1) OVER (ORDER BY Months)-1)*100),2) AS "Growth in %" 
FROM 
(SELECT EXTRACT(MONTH FROM created_at) AS "Months", COUNT(*) AS "Number_of_Users"
FROM users WHERE activated_at IS NOT NULL
GROUP BY 1 ORDER BY 1) AS sub;
```
<details>
  <summary>Output:</summary>
  
| Months |  Number_of_Users |  Growth in % |
|--------|------------------|--------------|
| 1      | 712              | -            |
| 2      | 685              | -3.79        |
| 3      | 765              | 11.68        |
| 4      | 907              | 18.56        |
| 5      | 993              | 9.48         |
| 6      | 1086             | 9.37         |
| 7      | 1281             | 17.96        |
| 8      | 1347             | 5.15         |
| 9      | 330              | -75.50       |
| 10     | 390              | 18.18        |
| 11     | 399              | 2.31         |
| 12     | 486              | 21.80        |
</details>

*- Query: Year-wise user growth analysis*
```sql
SELECT Year, Number_of_Users, 
ROUND(((Number_of_Users/LAG(Number_of_Users,1) OVER (ORDER BY Year)-1)*100),2) AS "Growth in %" 
FROM 
(SELECT EXTRACT(YEAR FROM created_at) AS "Year", COUNT(*) AS "Number_of_Users"
FROM users WHERE activated_at IS NOT NULL
GROUP BY 1 ORDER BY 1) AS sub;
```
<details>
<summary>Output:</summary>
  
| Year |  Number_of_Users |  Growth in % |
|------|------------------|--------------|
| 2013 | 3283             | -            |
| 2014 | 6098             | 85.74        |
</details>

*- Insights:*

There is a significant 85.74 % growth in the number of users in the year 2014 than 2013.The number of users have declined in the month of September signifying a dip of 75.50%.

**C. Weekly Retention Analysis**

*- Query:*
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
<details>
  <summary>Output:</summary>

| Week Numbers |  Week 0 |  Week 1 |  Week 2 |  Week 3 |  Week 4 |  Week 5 |  Week 6 |  Week 7 |  Week 8 |  Week 9 |  Week 10 |  Week 11 |  Week 12 |  Week 13 |  Week 14 |  Week 15 |  Week 16 |  Week 17 |  Week 18 |
|--------------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|----------|----------|----------|----------|----------|----------|----------|----------|----------|
| 17           | 663     | 472     | 324     | 251     | 205     | 187     | 167     | 146     | 145     | 145     | 136      | 131      | 132      | 143      | 116      | 91       | 82       | 77       | 5        |
| 18           | 596     | 362     | 261     | 203     | 168     | 147     | 144     | 127     | 113     | 122     | 106      | 118      | 127      | 110      | 97       | 85       | 67       | 4        | 0        |
| 19           | 427     | 284     | 173     | 153     | 114     | 95      | 91      | 81      | 95      | 82      | 68       | 65       | 63       | 42       | 51       | 49       | 2        | 0        | 0        |
| 20           | 358     | 223     | 165     | 121     | 91      | 72      | 63      | 67      | 63      | 65      | 67       | 41       | 40       | 33       | 40       | 0        | 0        | 0        | 0        |
| 21           | 317     | 187     | 131     | 91      | 74      | 63      | 75      | 72      | 58      | 48      | 45       | 39       | 35       | 28       | 2        | 0        | 0        | 0        | 0        |
| 22           | 326     | 224     | 150     | 107     | 87      | 73      | 63      | 60      | 55      | 48      | 41       | 39       | 31       | 1        | 0        | 0        | 0        | 0        | 0        |
| 23           | 328     | 219     | 138     | 101     | 90      | 79      | 69      | 61      | 54      | 47      | 35       | 30       | 0        | 0        | 0        | 0        | 0        | 0        | 0        |
| 24           | 339     | 205     | 143     | 102     | 81      | 63      | 65      | 61      | 38      | 39      | 29       | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        |
| 25           | 305     | 218     | 139     | 101     | 75      | 63      | 50      | 46      | 38      | 35      | 2        | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        |
| 26           | 288     | 181     | 114     | 83      | 73      | 55      | 47      | 43      | 29      | 0       | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        |
| 27           | 292     | 199     | 121     | 106     | 68      | 53      | 40      | 36      | 1       | 0       | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        |
| 28           | 274     | 194     | 114     | 69      | 46      | 30      | 28      | 3       | 0       | 0       | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        |
| 29           | 270     | 186     | 102     | 65      | 47      | 40      | 1       | 0       | 0       | 0       | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        |
| 30           | 294     | 202     | 121     | 78      | 53      | 3       | 0       | 0       | 0       | 0       | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        |
| 31           | 215     | 145     | 76      | 57      | 1       | 0       | 0       | 0       | 0       | 0       | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        |
| 32           | 267     | 188     | 94      | 8       | 0       | 0       | 0       | 0       | 0       | 0       | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        |
| 33           | 286     | 202     | 9       | 0       | 0       | 0       | 0       | 0       | 0       | 0       | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        |
| 34           | 279     | 44      | 0       | 0       | 0       | 0       | 0       | 0       | 0       | 0       | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        |
| 35           | 18      | 0       | 0       | 0       | 0       | 0       | 0       | 0       | 0       | 0       | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        | 0        |
 </details>

*- Insights:*

There is a decline in the Weekly user retention over the time. More focus needed to improve strategies and enhance user experience.

**D. Weekly Engagement Per Device**

*- Query:*
```sql
SELECT EXTRACT(WEEK FROM (occurred_at)) AS "Weeks",
device AS "Device",COUNT(DISTINCT(user_id)) AS "User Engagement"
FROM events
GROUP BY 2,1
ORDER BY 1;
```
<details>
  <summary>Output:</summary>
  
| Weeks |  Device                |  User Engagement | 
|-------|------------------------|------------------|
| 17    | acer aspire desktop    | 9                |
| 17    | acer aspire notebook   | 20               |
| 17    | amazon fire phone      | 4                |
| 17    | asus chromebook        | 21               |
| 17    | dell inspiron desktop  | 18               |
| 17    | dell inspiron notebook | 46               |
| 17    | hp pavilion desktop    | 14               |
| 17    | htc one                | 16               |
| 17    | ipad air               | 27               |
| 17    | ipad mini              | 19               |
| 17    | iphone 4s              | 21               |
| 17    | iphone 5               | 65               |
| 17    | iphone 5s              | 42               |
| 17    | kindle fire            | 6                |
| 17    | lenovo thinkpad        | 86               |
| 17    | mac mini               | 6                |
| 17    | macbook air            | 54               |
| 17    | macbook pro            | 143              |
| 17    | nexus 10               | 16               |
| 17    | nexus 5                | 40               |
| 17    | nexus 7                | 18               |
| 17    | nokia lumia 635        | 17               |
| 17    | samsumg galaxy tablet  | 8                |
| 17    | samsung galaxy note    | 7                |
| 17    | samsung galaxy s4      | 52               |
| 17    | windows surface        | 10               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 18    | acer aspire desktop    | 26               |
| 18    | acer aspire notebook   | 33               |
| 18    | amazon fire phone      | 9                |
| 18    | asus chromebook        | 42               |
| 18    | dell inspiron desktop  | 58               |
| 18    | dell inspiron notebook | 77               |
| 18    | hp pavilion desktop    | 37               |
| 18    | htc one                | 19               |
| 18    | ipad air               | 52               |
| 18    | ipad mini              | 30               |
| 18    | iphone 4s              | 46               |
| 18    | iphone 5               | 113              |
| 18    | iphone 5s              | 73               |
| 18    | kindle fire            | 27               |
| 18    | lenovo thinkpad        | 153              |
| 18    | mac mini               | 13               |
| 18    | macbook air            | 121              |
| 18    | macbook pro            | 252              |
| 18    | nexus 10               | 30               |
| 18    | nexus 5                | 73               |
| 18    | nexus 7                | 30               |
| 18    | nokia lumia 635        | 33               |
| 18    | samsumg galaxy tablet  | 11               |
| 18    | samsung galaxy note    | 15               |
| 18    | samsung galaxy s4      | 82               |
| 18    | windows surface        | 10               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 19    | acer aspire desktop    | 23               |
| 19    | acer aspire notebook   | 41               |
| 19    | amazon fire phone      | 12               |
| 19    | asus chromebook        | 27               |
| 19    | dell inspiron desktop  | 36               |
| 19    | dell inspiron notebook | 83               |
| 19    | hp pavilion desktop    | 40               |
| 19    | htc one                | 30               |
| 19    | ipad air               | 55               |
| 19    | ipad mini              | 36               |
| 19    | iphone 4s              | 44               |
| 19    | iphone 5               | 115              |
| 19    | iphone 5s              | 79               |
| 19    | kindle fire            | 21               |
| 19    | lenovo thinkpad        | 178              |
| 19    | mac mini               | 18               |
| 19    | macbook air            | 112              |
| 19    | macbook pro            | 266              |
| 19    | nexus 10               | 25               |
| 19    | nexus 5                | 87               |
| 19    | nexus 7                | 41               |
| 19    | nokia lumia 635        | 23               |
| 19    | samsumg galaxy tablet  | 6                |
| 19    | samsung galaxy note    | 11               |
| 19    | samsung galaxy s4      | 91               |
| 19    | windows surface        | 16               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 20    | acer aspire desktop    | 23               |
| 20    | acer aspire notebook   | 40               |
| 20    | amazon fire phone      | 11               |
| 20    | asus chromebook        | 41               |
| 20    | dell inspiron desktop  | 52               |
| 20    | dell inspiron notebook | 84               |
| 20    | hp pavilion desktop    | 30               |
| 20    | htc one                | 29               |
| 20    | ipad air               | 59               |
| 20    | ipad mini              | 32               |
| 20    | iphone 4s              | 55               |
| 20    | iphone 5               | 125              |
| 20    | iphone 5s              | 79               |
| 20    | kindle fire            | 23               |
| 20    | lenovo thinkpad        | 173              |
| 20    | mac mini               | 26               |
| 20    | macbook air            | 119              |
| 20    | macbook pro            | 256              |
| 20    | nexus 10               | 22               |
| 20    | nexus 5                | 103              |
| 20    | nexus 7                | 32               |
| 20    | nokia lumia 635        | 22               |
| 20    | samsumg galaxy tablet  | 9                |
| 20    | samsung galaxy note    | 18               |
| 20    | samsung galaxy s4      | 93               |
| 20    | windows surface        | 21               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 21    | acer aspire desktop    | 29               |
| 21    | acer aspire notebook   | 47               |
| 21    | amazon fire phone      | 5                |
| 21    | asus chromebook        | 38               |
| 21    | dell inspiron desktop  | 41               |
| 21    | dell inspiron notebook | 80               |
| 21    | hp pavilion desktop    | 44               |
| 21    | htc one                | 21               |
| 21    | ipad air               | 51               |
| 21    | ipad mini              | 23               |
| 21    | iphone 4s              | 45               |
| 21    | iphone 5               | 137              |
| 21    | iphone 5s              | 74               |
| 21    | kindle fire            | 30               |
| 21    | lenovo thinkpad        | 167              |
| 21    | mac mini               | 18               |
| 21    | macbook air            | 110              |
| 21    | macbook pro            | 247              |
| 21    | nexus 10               | 25               |
| 21    | nexus 5                | 91               |
| 21    | nexus 7                | 29               |
| 21    | nokia lumia 635        | 25               |
| 21    | samsumg galaxy tablet  | 6                |
| 21    | samsung galaxy note    | 20               |
| 21    | samsung galaxy s4      | 84               |
| 21    | windows surface        | 17               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 22    | acer aspire desktop    | 25               |
| 22    | acer aspire notebook   | 41               |
| 22    | amazon fire phone      | 5                |
| 22    | asus chromebook        | 52               |
| 22    | dell inspiron desktop  | 52               |
| 22    | dell inspiron notebook | 92               |
| 22    | hp pavilion desktop    | 38               |
| 22    | htc one                | 24               |
| 22    | ipad air               | 58               |
| 22    | ipad mini              | 34               |
| 22    | iphone 4s              | 45               |
| 22    | iphone 5               | 125              |
| 22    | iphone 5s              | 71               |
| 22    | kindle fire            | 21               |
| 22    | lenovo thinkpad        | 176              |
| 22    | mac mini               | 25               |
| 22    | macbook air            | 145              |
| 22    | macbook pro            | 251              |
| 22    | nexus 10               | 27               |
| 22    | nexus 5                | 96               |
| 22    | nexus 7                | 45               |
| 22    | nokia lumia 635        | 25               |
| 22    | samsumg galaxy tablet  | 10               |
| 22    | samsung galaxy note    | 19               |
| 22    | samsung galaxy s4      | 105              |
| 22    | windows surface        | 15               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 23    | acer aspire desktop    | 22               |
| 23    | acer aspire notebook   | 43               |
| 23    | amazon fire phone      | 16               |
| 23    | asus chromebook        | 49               |
| 23    | dell inspiron desktop  | 53               |
| 23    | dell inspiron notebook | 103              |
| 23    | hp pavilion desktop    | 54               |
| 23    | htc one                | 20               |
| 23    | ipad air               | 41               |
| 23    | ipad mini              | 33               |
| 23    | iphone 4s              | 53               |
| 23    | iphone 5               | 152              |
| 23    | iphone 5s              | 79               |
| 23    | kindle fire            | 25               |
| 23    | lenovo thinkpad        | 176              |
| 23    | mac mini               | 18               |
| 23    | macbook air            | 124              |
| 23    | macbook pro            | 266              |
| 23    | nexus 10               | 45               |
| 23    | nexus 5                | 88               |
| 23    | nexus 7                | 36               |
| 23    | nokia lumia 635        | 31               |
| 23    | samsumg galaxy tablet  | 14               |
| 23    | samsung galaxy note    | 14               |
| 23    | samsung galaxy s4      | 99               |
| 23    | windows surface        | 14               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 24    | acer aspire desktop    | 24               |
| 24    | acer aspire notebook   | 40               |
| 24    | amazon fire phone      | 11               |
| 24    | asus chromebook        | 43               |
| 24    | dell inspiron desktop  | 59               |
| 24    | dell inspiron notebook | 99               |
| 24    | hp pavilion desktop    | 56               |
| 24    | htc one                | 20               |
| 24    | ipad air               | 57               |
| 24    | ipad mini              | 39               |
| 24    | iphone 4s              | 53               |
| 24    | iphone 5               | 142              |
| 24    | iphone 5s              | 79               |
| 24    | kindle fire            | 25               |
| 24    | lenovo thinkpad        | 165              |
| 24    | mac mini               | 29               |
| 24    | macbook air            | 152              |
| 24    | macbook pro            | 255              |
| 24    | nexus 10               | 38               |
| 24    | nexus 5                | 87               |
| 24    | nexus 7                | 49               |
| 24    | nokia lumia 635        | 35               |
| 24    | samsumg galaxy tablet  | 11               |
| 24    | samsung galaxy note    | 20               |
| 24    | samsung galaxy s4      | 101              |
| 24    | windows surface        | 22               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 25    | acer aspire desktop    | 28               |
| 25    | acer aspire notebook   | 47               |
| 25    | amazon fire phone      | 13               |
| 25    | asus chromebook        | 38               |
| 25    | dell inspiron desktop  | 52               |
| 25    | dell inspiron notebook | 105              |
| 25    | hp pavilion desktop    | 52               |
| 25    | htc one                | 21               |
| 25    | ipad air               | 57               |
| 25    | ipad mini              | 30               |
| 25    | iphone 4s              | 40               |
| 25    | iphone 5               | 137              |
| 25    | iphone 5s              | 78               |
| 25    | kindle fire            | 24               |
| 25    | lenovo thinkpad        | 197              |
| 25    | mac mini               | 21               |
| 25    | macbook air            | 121              |
| 25    | macbook pro            | 275              |
| 25    | nexus 10               | 29               |
| 25    | nexus 5                | 89               |
| 25    | nexus 7                | 51               |
| 25    | nokia lumia 635        | 37               |
| 25    | samsumg galaxy tablet  | 12               |
| 25    | samsung galaxy note    | 14               |
| 25    | samsung galaxy s4      | 99               |
| 25    | windows surface        | 22               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 26    | acer aspire desktop    | 29               |
| 26    | acer aspire notebook   | 35               |
| 26    | amazon fire phone      | 13               |
| 26    | asus chromebook        | 49               |
| 26    | dell inspiron desktop  | 60               |
| 26    | dell inspiron notebook | 89               |
| 26    | hp pavilion desktop    | 46               |
| 26    | htc one                | 23               |
| 26    | ipad air               | 56               |
| 26    | ipad mini              | 43               |
| 26    | iphone 4s              | 50               |
| 26    | iphone 5               | 152              |
| 26    | iphone 5s              | 94               |
| 26    | kindle fire            | 26               |
| 26    | lenovo thinkpad        | 192              |
| 26    | mac mini               | 11               |
| 26    | macbook air            | 134              |
| 26    | macbook pro            | 269              |
| 26    | nexus 10               | 29               |
| 26    | nexus 5                | 87               |
| 26    | nexus 7                | 46               |
| 26    | nokia lumia 635        | 42               |
| 26    | samsumg galaxy tablet  | 12               |
| 26    | samsung galaxy note    | 9                |
| 26    | samsung galaxy s4      | 112              |
| 26    | windows surface        | 21               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 27    | acer aspire desktop    | 29               |
| 27    | acer aspire notebook   | 49               |
| 27    | amazon fire phone      | 10               |
| 27    | asus chromebook        | 52               |
| 27    | dell inspiron desktop  | 53               |
| 27    | dell inspiron notebook | 89               |
| 27    | hp pavilion desktop    | 56               |
| 27    | htc one                | 27               |
| 27    | ipad air               | 55               |
| 27    | ipad mini              | 35               |
| 27    | iphone 4s              | 67               |
| 27    | iphone 5               | 163              |
| 27    | iphone 5s              | 83               |
| 27    | kindle fire            | 25               |
| 27    | lenovo thinkpad        | 202              |
| 27    | mac mini               | 15               |
| 27    | macbook air            | 142              |
| 27    | macbook pro            | 302              |
| 27    | nexus 10               | 37               |
| 27    | nexus 5                | 84               |
| 27    | nexus 7                | 40               |
| 27    | nokia lumia 635        | 31               |
| 27    | samsumg galaxy tablet  | 15               |
| 27    | samsung galaxy note    | 15               |
| 27    | samsung galaxy s4      | 116              |
| 27    | windows surface        | 33               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 28    | acer aspire desktop    | 30               |
| 28    | acer aspire notebook   | 49               |
| 28    | amazon fire phone      | 6                |
| 28    | asus chromebook        | 50               |
| 28    | dell inspiron desktop  | 56               |
| 28    | dell inspiron notebook | 103              |
| 28    | hp pavilion desktop    | 56               |
| 28    | htc one                | 26               |
| 28    | ipad air               | 54               |
| 28    | ipad mini              | 35               |
| 28    | iphone 4s              | 61               |
| 28    | iphone 5               | 151              |
| 28    | iphone 5s              | 93               |
| 28    | kindle fire            | 31               |
| 28    | lenovo thinkpad        | 220              |
| 28    | mac mini               | 28               |
| 28    | macbook air            | 148              |
| 28    | macbook pro            | 295              |
| 28    | nexus 10               | 26               |
| 28    | nexus 5                | 85               |
| 28    | nexus 7                | 39               |
| 28    | nokia lumia 635        | 35               |
| 28    | samsumg galaxy tablet  | 9                |
| 28    | samsung galaxy note    | 10               |
| 28    | samsung galaxy s4      | 122              |
| 28    | windows surface        | 33               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 29    | acer aspire desktop    | 28               |
| 29    | acer aspire notebook   | 53               |
| 29    | amazon fire phone      | 12               |
| 29    | asus chromebook        | 49               |
| 29    | dell inspiron desktop  | 54               |
| 29    | dell inspiron notebook | 113              |
| 29    | hp pavilion desktop    | 58               |
| 29    | htc one                | 31               |
| 29    | ipad air               | 52               |
| 29    | ipad mini              | 34               |
| 29    | iphone 4s              | 60               |
| 29    | iphone 5               | 144              |
| 29    | iphone 5s              | 90               |
| 29    | kindle fire            | 37               |
| 29    | lenovo thinkpad        | 209              |
| 29    | mac mini               | 31               |
| 29    | macbook air            | 148              |
| 29    | macbook pro            | 295              |
| 29    | nexus 10               | 25               |
| 29    | nexus 5                | 77               |
| 29    | nexus 7                | 45               |
| 29    | nokia lumia 635        | 43               |
| 29    | samsumg galaxy tablet  | 13               |
| 29    | samsung galaxy note    | 16               |
| 29    | samsung galaxy s4      | 123              |
| 29    | windows surface        | 28               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 30    | acer aspire desktop    | 33               |
| 30    | acer aspire notebook   | 60               |
| 30    | amazon fire phone      | 12               |
| 30    | asus chromebook        | 56               |
| 30    | dell inspiron desktop  | 54               |
| 30    | dell inspiron notebook | 127              |
| 30    | hp pavilion desktop    | 42               |
| 30    | htc one                | 31               |
| 30    | ipad air               | 70               |
| 30    | ipad mini              | 35               |
| 30    | iphone 4s              | 65               |
| 30    | iphone 5               | 152              |
| 30    | iphone 5s              | 103              |
| 30    | kindle fire            | 25               |
| 30    | lenovo thinkpad        | 206              |
| 30    | mac mini               | 23               |
| 30    | macbook air            | 159              |
| 30    | macbook pro            | 322              |
| 30    | nexus 10               | 36               |
| 30    | nexus 5                | 84               |
| 30    | nexus 7                | 62               |
| 30    | nokia lumia 635        | 34               |
| 30    | samsumg galaxy tablet  | 9                |
| 30    | samsung galaxy note    | 15               |
| 30    | samsung galaxy s4      | 103              |
| 30    | windows surface        | 19               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 31    | acer aspire desktop    | 31               |
| 31    | acer aspire notebook   | 55               |
| 31    | amazon fire phone      | 14               |
| 31    | asus chromebook        | 56               |
| 31    | dell inspiron desktop  | 44               |
| 31    | dell inspiron notebook | 113              |
| 31    | hp pavilion desktop    | 51               |
| 31    | htc one                | 13               |
| 31    | ipad air               | 55               |
| 31    | ipad mini              | 27               |
| 31    | iphone 4s              | 56               |
| 31    | iphone 5               | 135              |
| 31    | iphone 5s              | 71               |
| 31    | kindle fire            | 14               |
| 31    | lenovo thinkpad        | 207              |
| 31    | mac mini               | 24               |
| 31    | macbook air            | 147              |
| 31    | macbook pro            | 321              |
| 31    | nexus 10               | 24               |
| 31    | nexus 5                | 69               |
| 31    | nexus 7                | 38               |
| 31    | nokia lumia 635        | 28               |
| 31    | samsumg galaxy tablet  | 8                |
| 31    | samsung galaxy note    | 14               |
| 31    | samsung galaxy s4      | 100              |
| 31    | windows surface        | 19               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 32    | acer aspire desktop    | 35               |
| 32    | acer aspire notebook   | 55               |
| 32    | amazon fire phone      | 12               |
| 32    | asus chromebook        | 62               |
| 32    | dell inspiron desktop  | 57               |
| 32    | dell inspiron notebook | 104              |
| 32    | hp pavilion desktop    | 51               |
| 32    | htc one                | 18               |
| 32    | ipad air               | 48               |
| 32    | ipad mini              | 30               |
| 32    | iphone 4s              | 34               |
| 32    | iphone 5               | 119              |
| 32    | iphone 5s              | 67               |
| 32    | kindle fire            | 12               |
| 32    | lenovo thinkpad        | 179              |
| 32    | mac mini               | 20               |
| 32    | macbook air            | 125              |
| 32    | macbook pro            | 307              |
| 32    | nexus 10               | 30               |
| 32    | nexus 5                | 67               |
| 32    | nexus 7                | 25               |
| 32    | nokia lumia 635        | 28               |
| 32    | samsumg galaxy tablet  | 6                |
| 32    | samsung galaxy note    | 12               |
| 32    | samsung galaxy s4      | 82               |
| 32    | windows surface        | 10               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 33    | acer aspire desktop    | 39               |
| 33    | acer aspire notebook   | 46               |
| 33    | amazon fire phone      | 14               |
| 33    | asus chromebook        | 49               |
| 33    | dell inspiron desktop  | 37               |
| 33    | dell inspiron notebook | 110              |
| 33    | hp pavilion desktop    | 38               |
| 33    | htc one                | 19               |
| 33    | ipad air               | 40               |
| 33    | ipad mini              | 28               |
| 33    | iphone 4s              | 35               |
| 33    | iphone 5               | 110              |
| 33    | iphone 5s              | 65               |
| 33    | kindle fire            | 14               |
| 33    | lenovo thinkpad        | 191              |
| 33    | mac mini               | 32               |
| 33    | macbook air            | 133              |
| 33    | macbook pro            | 312              |
| 33    | nexus 10               | 23               |
| 33    | nexus 5                | 70               |
| 33    | nexus 7                | 30               |
| 33    | nokia lumia 635        | 27               |
| 33    | samsumg galaxy tablet  | 12               |
| 33    | samsung galaxy note    | 13               |
| 33    | samsung galaxy s4      | 80               |
| 33    | windows surface        | 15               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 34    | acer aspire desktop    | 30               |
| 34    | acer aspire notebook   | 63               |
| 34    | amazon fire phone      | 11               |
| 34    | asus chromebook        | 47               |
| 34    | dell inspiron desktop  | 49               |
| 34    | dell inspiron notebook | 105              |
| 34    | hp pavilion desktop    | 36               |
| 34    | htc one                | 25               |
| 34    | ipad air               | 39               |
| 34    | ipad mini              | 25               |
| 34    | iphone 4s              | 50               |
| 34    | iphone 5               | 101              |
| 34    | iphone 5s              | 70               |
| 34    | kindle fire            | 13               |
| 34    | lenovo thinkpad        | 193              |
| 34    | mac mini               | 30               |
| 34    | macbook air            | 136              |
| 34    | macbook pro            | 292              |
| 34    | nexus 10               | 25               |
| 34    | nexus 5                | 70               |
| 34    | nexus 7                | 33               |
| 34    | nokia lumia 635        | 17               |
| 34    | samsumg galaxy tablet  | 14               |
| 34    | samsung galaxy note    | 13               |
| 34    | samsung galaxy s4      | 90               |
| 34    | windows surface        | 18               |

| Weeks |  Device                |  User Engagement |
|-------|------------------------|------------------|
| 35    | acer aspire desktop    | 1                |
| 35    | acer aspire notebook   | 3                |
| 35    | asus chromebook        | 6                |
| 35    | dell inspiron desktop  | 1                |
| 35    | dell inspiron notebook | 9                |
| 35    | hp pavilion desktop    | 1                |
| 35    | htc one                | 2                |
| 35    | ipad mini              | 2                |
| 35    | iphone 4s              | 6                |
| 35    | iphone 5               | 2                |
| 35    | iphone 5s              | 3                |
| 35    | kindle fire            | 3                |
| 35    | lenovo thinkpad        | 16               |
| 35    | mac mini               | 2                |
| 35    | macbook air            | 10               |
| 35    | macbook pro            | 17               |
| 35    | nexus 10               | 2                |
| 35    | nexus 5                | 4                |
| 35    | nexus 7                | 2                |
| 35    | nokia lumia 635        | 2                |
| 35    | samsung galaxy note    | 1                |
| 35    | samsung galaxy s4      | 6                |
| 35    | windows surface        | 3                |
</details>

*- Insights:*

Weekly Engagement varies across devices and weeks. Adaptive strategies is needed to monitor device trends and optimize user engagement for lower engagement devices.

**E. Email Engagement Analysis**

*- Query:*
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
<details>
  <summary>Output:</summary>
| Week Number |  Weekly Digest Rate |  Re-engagement Mail Rate |  Opened Email Rate |  Email Clickthrough Rate |
|-------------|---------------------|--------------------------|--------------------|--------------------------|
| 17          | 62.32               | 5.01                     | 21.28              | 11.39                    |
| 18          | 63.45               | 3.83                     | 21.95              | 10.36                    |
| 19          | 62.16               | 4.04                     | 22.42              | 11.10                    |
| 20          | 61.62               | 4.31                     | 22.30              | 11.30                    |
| 21          | 63.52               | 3.69                     | 22.42              | 9.81                     |
| 22          | 63.59               | 4.19                     | 21.08              | 10.44                    |
| 23          | 62.39               | 4.09                     | 21.96              | 10.99                    |
| 24          | 61.61               | 4.48                     | 22.54              | 10.89                    |
| 25          | 63.77               | 3.90                     | 21.55              | 10.42                    |
| 26          | 62.99               | 4.18                     | 21.92              | 10.49                    |
| 27          | 62.24               | 3.90                     | 22.10              | 11.23                    |
| 28          | 62.92               | 3.83                     | 22.08              | 10.68                    |
| 29          | 63.98               | 3.79                     | 21.39              | 10.38                    |
| 30          | 62.29               | 3.88                     | 22.91              | 10.50                    |
| 31          | 65.27               | 3.82                     | 23.03              | 7.64                     |
| 32          | 66.59               | 3.42                     | 22.52              | 7.11                     |
| 33          | 64.73               | 4.26                     | 22.86              | 7.91                     |
| 34          | 64.33               | 4.08                     | 23.51              | 7.53                     |
| 35          | 0.00                | 37.80                    | 32.28              | 29.92                    |
</details>

*- Insights:*

The company has to compare the results with the industry set benchmarks and  focus on optimizing the emails to improve the user engagement.

### Conclusion

This project helps in understanding how Data Analytics play a great role in analyzing a company’s end-to-end operations while working with various teams, such as operations, support, and marketing, helping them derive valuable insights from the data they collect. This analysis also pave way for investigating metrics and to know how to deal with these metric spikes.
Doing this project, helped in learning Advanced SQL concepts to get the desired output and to load huge amount of data present in csv files using MySQL workbench. 

