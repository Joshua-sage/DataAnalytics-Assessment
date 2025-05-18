# DataAnalytics-Assessment

# Adashi Staging Database Analysis

---

## Per-Question Explanations

### 1. High-Value Customers with Multiple Products

**Approach:**  
- I identified customers with at least one funded savings plan (`is_regular_savings = 1`) and one funded investment plan (`is_a_fund = 1`).
- For each eligible customer, I counted their funded savings and investment plans, calculated the total deposits, and sorted the results by deposit value (in naira).

---

### 2. Transaction Frequency Analysis

**Approach:**  
- I calculated the average number of transactions per customer per month using the transaction date range and the count of inflow transactions.
- Based on the average monthly transaction volume, users were segmented into three categories: High Frequency, Medium Frequency, and Low Frequency.
- The output displays the number of users in each category along with their average monthly transaction frequency

---

### 3. Account Inactivity Alert

**Approach:**  
- I flagged all active savings or investment accounts (plans) that haven't had any inflow transactions (`confirmed_amount = 0`) in the past 365 days.
- For each flagged plan, I displayed the plan id, user id, plan type, the last transaction date, and how many days have passed since then.
- This helps the ops team track dormant accounts.

---

### 4. Customer Lifetime Value (CLV) Estimation

**Approach:**  
- I estimated Customer Lifetime Value (CLV) for each customer using the formula:  `CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction`
- `profit_per_transaction` is assumed to be 0.1% of the average transaction value (converted from kobo to naira).
- For each customer, I calculated their tenure(months since signup), total transactions, and estimated CLV, then sorted the results from highest to lowest CLV.

---

## Challenges

- **Data Structure Understanding:**  
  I mapped the relationships between tables by linking related data (like plans to users). I also made sure to differentiate between savings and investment plans by using specific columns like `is_regular_savings` and `is_a_fund`.

- **Date Calculations:**  
  I carefully managed transaction date ranges to calculate tenure, inactivity periods, and transaction frequency. paying extra attention to handle any missing or NULL values correctly.

- **Amount Conversion:**  
  Since all amount fields were in kobo, I made sure to convert them to naira in the final outputs by dividing by 100.

- **Division by Zero:**  
  I Used `NULLIF` to avoid division by zero errors, especially for new users with tenure < 1 month.

- **Computing Months (Question 2):**  
  To calculate how many months each customer was active, I had to be precise since transactions might happen within the same month or might not cover full months.
  
---

## How Challenges Were Resolved

- Carefully explored all columns in each table before writing queries.
- Added conditional logic to handle potential NULL values and avoid calculation errors.
- Tested calculation logic (e.g., CLV formula) step-by-step before combining into final queries.
-  I used `TIMESTAMPDIFF(MONTH, MIN(transaction_date), MAX(transaction_date)) + 1` to count the number of active months, I added 1 to make sure both the starting and ending months are included. This way, I accurately count users who make transactions within the same month or do otherwise.

---



