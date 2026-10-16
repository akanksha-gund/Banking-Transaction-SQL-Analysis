#Common Table Expression
WITH customer_spending AS (
    SELECT
        a.customer_id,
        SUM(t.amount) AS total_spending
    FROM accounts a
    JOIN transactions t
        ON a.account_id = t.account_id
    WHERE t.transaction_type = 'DEBIT'
      AND t.status = 'SUCCESS'
    GROUP BY a.customer_id
)
SELECT
    c.customer_name,
    COALESCE(cs.total_spending, 0) AS total_spending
FROM customers c
LEFT JOIN customer_spending cs
    ON c.customer_id = cs.customer_id
ORDER BY total_spending DESC;


#Customer Ranking
SELECT
    c.customer_name,
    SUM(t.amount) AS total_spending,
    ROW_NUMBER() OVER (
        ORDER BY SUM(t.amount) DESC
    ) AS row_num
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.transaction_type = 'DEBIT'
  AND t.status = 'SUCCESS'
GROUP BY c.customer_id, c.customer_name;

#Customer Ranking with Ties
SELECT
    c.customer_name,
    SUM(t.amount) AS total_spending,
    RANK() OVER (
        ORDER BY SUM(t.amount) DESC
    ) AS spending_rank
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.transaction_type = 'DEBIT'
  AND t.status = 'SUCCESS'
GROUP BY c.customer_id, c.customer_name;

#Failed Transaction Analysis
SELECT
    payment_channel,
    COUNT(*) AS failed_transactions,
    SUM(amount) AS failed_transaction_amount
FROM transactions
WHERE status = 'FAILED'
GROUP BY payment_channel
ORDER BY failed_transactions DESC;

#Transaction Classification
SELECT
    transaction_id,
    amount,
    status,
    CASE
        WHEN status = 'FAILED' THEN 'Failed'
        WHEN status = 'PENDING' THEN 'Pending'
        WHEN amount >= 10000 THEN 'High Value'
        ELSE 'Regular'
    END AS transaction_category
FROM transactions
ORDER BY amount DESC;

#High-Spending Categories
SELECT
    category,
    SUM(amount) AS total_spending
FROM transactions
WHERE transaction_type = 'DEBIT'
  AND status = 'SUCCESS'
GROUP BY category
HAVING SUM(amount) > 3000
ORDER BY total_spending DESC;

USE banking_transaction_analysis;
