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
  Mapping foreign key relationships between tables (e.g., linking plans to users) and distinguishing savings vs. investment plans based on columns like `is_regular_savings` and `is_a_fund`.

- **Date Calculations:**  
  Handling transaction date ranges to accurately compute tenure, inactivity, and transaction frequency, especially with possible missing or NULL values.

- **Amount Conversion:**  
  All monetary values were stored in kobo, so I ensured all final outputs converted to naira (by dividing by 100).

- **Division by Zero:**  
  Used `NULLIF` to avoid division by zero errors, especially for new users with tenure < 1 month.

---

## How Challenges Were Resolved

- Carefully explored all columns in each table before writing queries.
- Added conditional logic to handle potential NULL values and avoid calculation errors.
- Tested calculation logic (e.g., CLV formula) step-by-step before combining into final queries.

---



