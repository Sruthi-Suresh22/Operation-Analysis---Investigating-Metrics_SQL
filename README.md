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

