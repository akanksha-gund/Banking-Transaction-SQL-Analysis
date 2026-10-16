
CREATE DATABASE IF NOT EXISTS banking_transaction_analysis;

USE banking_transaction_analysis;

CREATE TABLE branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(60) NOT NULL
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE,
    city VARCHAR(60),
    join_date DATE
);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    account_type VARCHAR(30) NOT NULL,
    opening_balance DECIMAL(12,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    CHECK (opening_balance >= 0)
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_date DATETIME NOT NULL,
    transaction_type VARCHAR(10) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    category VARCHAR(50),
    payment_channel VARCHAR(30),
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id),
    CHECK (amount > 0),
    CHECK (transaction_type IN ('DEBIT', 'CREDIT')),
    CHECK (status IN ('SUCCESS', 'FAILED', 'PENDING'))
);

USE banking_transaction_analysis;

INSERT INTO branches (branch_id, branch_name, city) VALUES
(1, 'Pune Main Branch', 'Pune'),
(2, 'Mumbai Central Branch', 'Mumbai'),
(3, 'Nashik Branch', 'Nashik'),
(4, 'Nagpur Branch', 'Nagpur');

INSERT INTO customers(customer_id, customer_name, email, city, join_date)VALUES
(101, 'Aarav Sharma', 'aarav@example.com', 'Pune', '2025-01-10'),
(102, 'Priya Patil', 'priya@example.com', 'Mumbai', '2025-02-15'),
(103, 'Rohan Deshmukh', 'rohan@example.com', 'Nashik', '2025-03-20'),
(104, 'Sneha Joshi', 'sneha@example.com', 'Pune', '2025-04-05'),
(105, 'Aditya Kulkarni', 'aditya@example.com', 'Nagpur', '2025-05-12'),
(106, 'Neha Shah', 'neha@example.com', 'Mumbai', '2025-06-18'),
(107, 'Omkar Jadhav', 'omkar@example.com', 'Pune', '2025-07-22'),
(108, 'Isha More', 'isha@example.com', 'Nashik', '2025-08-09');

INSERT INTO accounts(account_id, customer_id, branch_id, account_number,
 account_type, opening_balance) VALUES
(201, 101, 1, 'ACC1001', 'Savings', 25000),
(202, 102, 2, 'ACC1002', 'Savings', 40000),
(203, 103, 3, 'ACC1003', 'Current', 60000),
(204, 104, 1, 'ACC1004', 'Savings', 18000),
(205, 105, 4, 'ACC1005', 'Current', 75000),
(206, 106, 2, 'ACC1006', 'Savings', 32000),
(207, 107, 1, 'ACC1007', 'Savings', 15000),
(208, 108, 3, 'ACC1008', 'Current', 50000);

INSERT INTO transactions(transaction_id, account_id, transaction_date,
 transaction_type, amount, category, payment_channel, status)VALUES
(1001, 201, '2025-09-01 10:15:00', 'DEBIT', 1500, 'Shopping', 'UPI', 'SUCCESS'),
(1002, 202, '2025-09-02 11:30:00', 'CREDIT', 10000, 'Salary', 'NEFT', 'SUCCESS'),
(1003, 203, '2025-09-03 14:20:00', 'DEBIT', 5000, 'Rent', 'NEFT', 'SUCCESS'),
(1004, 204, '2025-09-04 09:45:00', 'DEBIT', 800, 'Food', 'UPI', 'SUCCESS'),
(1005, 205, '2025-09-05 16:10:00', 'CREDIT', 20000, 'Business', 'NEFT', 'SUCCESS'),
(1006, 206, '2025-09-06 12:00:00', 'DEBIT', 2500, 'Shopping', 'CARD', 'FAILED'),
(1007, 207, '2025-09-07 18:25:00', 'DEBIT', 1200, 'Food', 'UPI', 'SUCCESS'),
(1008, 208, '2025-09-08 13:40:00', 'CREDIT', 15000, 'Business', 'NEFT', 'SUCCESS'),
(1009, 201, '2025-09-10 10:00:00', 'CREDIT', 5000, 'Salary', 'NEFT', 'SUCCESS'),
(1010, 202, '2025-09-11 15:15:00', 'DEBIT', 3000, 'Shopping', 'CARD', 'SUCCESS'),
(1011, 203, '2025-09-12 17:30:00', 'DEBIT', 2000, 'Food', 'UPI', 'PENDING'),
(1012, 204, '2025-09-14 12:10:00', 'CREDIT', 7000, 'Salary', 'NEFT', 'SUCCESS'),
(1013, 205, '2025-09-15 09:20:00', 'DEBIT', 4000, 'Travel', 'CARD', 'SUCCESS'),
(1014, 206, '2025-09-17 19:00:00', 'DEBIT', 1200, 'Food', 'UPI', 'SUCCESS'),
(1015, 207, '2025-09-19 11:45:00', 'CREDIT', 3000, 'Other', 'UPI', 'SUCCESS'),
(1016, 208, '2025-09-20 14:35:00', 'DEBIT', 6000, 'Shopping', 'CARD', 'FAILED'),
(1017, 201, '2025-10-01 10:10:00', 'DEBIT', 900, 'Food', 'UPI', 'SUCCESS'),
(1018, 202, '2025-10-03 16:50:00', 'CREDIT', 12000, 'Salary', 'NEFT', 'SUCCESS'),
(1019, 203, '2025-10-05 13:25:00', 'DEBIT', 3500, 'Travel', 'CARD', 'SUCCESS'),
(1020, 204, '2025-10-08 17:40:00', 'DEBIT', 1100, 'Shopping', 'UPI', 'PENDING'),
(1021, 205, '2025-10-10 12:30:00', 'CREDIT', 18000, 'Business', 'NEFT', 'SUCCESS'),
(1022, 206, '2025-10-12 09:15:00', 'DEBIT', 1800, 'Food', 'UPI', 'SUCCESS'),
(1023, 207, '2025-10-14 15:00:00', 'DEBIT', 2200, 'Shopping', 'CARD', 'SUCCESS'),
(1024, 208, '2025-10-15 11:20:00', 'CREDIT', 8000, 'Other', 'NEFT', 'SUCCESS');

SELECT * FROM branches;
SELECT * FROM customers;
SELECT * FROM accounts;
SELECT * FROM transactions;

SELECT COUNT(*) AS total_transactions
FROM transactions;

SELECT
    status,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY status
ORDER BY transaction_count DESC;

SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM transactions
WHERE status = 'SUCCESS'
GROUP BY transaction_type;

SELECT
    payment_channel,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'SUCCESS' THEN 1 ELSE 0 END)
        AS successful_transactions,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END)
        AS failed_transactions
FROM transactions
GROUP BY payment_channel
ORDER BY total_transactions DESC;

USE banking_transaction_analysis;

SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    a.account_number,
    a.account_type,
    a.opening_balance
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
ORDER BY a.opening_balance DESC;

SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

SELECT
    status,
    COUNT(*) AS total_transactions,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM transactions), 2
    ) AS percentage
FROM transactions
GROUP BY status
ORDER BY total_transactions DESC;

SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS transaction_month,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_transaction_amount
FROM transactions
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY transaction_month;

SELECT
    category,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_spending,
    ROUND(AVG(amount), 2) AS average_transaction
FROM transactions
WHERE transaction_type = 'DEBIT'
  AND status = 'SUCCESS'
GROUP BY category
ORDER BY total_spending DESC;


SELECT
    c.customer_name,
    SUM(t.amount) AS total_debit_amount
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.transaction_type = 'DEBIT'
  AND t.status = 'SUCCESS'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_debit_amount DESC
LIMIT 5;
