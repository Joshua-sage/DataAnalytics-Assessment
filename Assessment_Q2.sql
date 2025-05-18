WITH Monthly_txn_count AS (
    SELECT
        owner_id,
        COUNT(*) AS total_transactions,
        TIMESTAMPDIFF(MONTH, MIN(transaction_date), MAX(transaction_date)) + 1 AS months, -- I added 1 to make sure both the starting and ending months are included
        COUNT(*) / (TIMESTAMPDIFF(MONTH, MIN(transaction_date), MAX(transaction_date)) + 1) AS avg_transactions_per_month
    FROM savings_savingsaccount
    GROUP BY owner_id
),
user_frequency AS (
    SELECT
        CASE
            WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency' END AS frequency_category,
        avg_transactions_per_month
    FROM Monthly_txn_count
)
SELECT
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 2) AS avg_transactions_per_month
FROM user_frequency
GROUP BY frequency_category
ORDER BY avg_transactions_per_month desc; 

