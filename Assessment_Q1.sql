WITH savings AS ( -- count of savings 
    SELECT
        s.owner_id,
        COUNT(DISTINCT s.plan_id) AS savings_count,
        SUM(s.confirmed_amount) / 100 AS total_savings -- divide by 100 to convert kobo to naira
    FROM savings_savingsaccount s
    JOIN plans_plan p ON s.plan_id = p.id
    WHERE p.is_regular_savings = 1
      AND s.confirmed_amount > 0
    GROUP BY s.owner_id
),
investments AS ( -- count of investments 
    SELECT
        s.owner_id,
        COUNT(DISTINCT s.plan_id) AS investment_count,
        SUM(s.confirmed_amount) / 100 AS total_invested -- divide by 100 to convert kobo to naira
    FROM savings_savingsaccount s
    JOIN plans_plan p ON s.plan_id = p.id
    WHERE p.is_a_fund = 1
      AND s.confirmed_amount > 0
    GROUP BY s.owner_id
)
SELECT
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    s.savings_count,
    i.investment_count,
    ROUND((COALESCE(s.total_savings, 0) + COALESCE(i.total_invested, 0)), 2) AS total_deposits  
FROM users_customuser u
JOIN savings s ON s.owner_id = u.id
JOIN investments i ON i.owner_id = u.id
WHERE s.savings_count > 0 AND i.investment_count > 0
ORDER BY total_deposits DESC;
