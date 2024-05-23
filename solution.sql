-- THE FOLLOWING CODE BELONGS TO ABHIJITH DAMERUPPALA

-- THIS FILE IS A SOLUTION TO THE CRYPTO MARKET TRANSACTIONS MONITORING PROBLEM FROM HACKERRANK.
WITH transactions_with_lag AS (
    SELECT
        *,
        LAG(dt) OVER (PARTITION BY sender ORDER BY dt) AS prev_dt
    FROM transactions
),
transaction_groups AS (
    SELECT
        sender,
        dt,
        amount,
        CASE
            WHEN TIMESTAMPDIFF(SECOND, prev_dt, dt) > 3600 OR prev_dt IS NULL THEN 1
            ELSE 0
        END AS new_group
    FROM transactions_with_lag
),
grouped_transactions AS (
    SELECT
        sender,
        dt,
        amount,
        SUM(new_group) OVER (PARTITION BY sender ORDER BY dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
    FROM transaction_groups
),
suspicious_sequences AS (
    SELECT
        sender,
        MIN(dt) AS sequence_start,
        MAX(dt) AS sequence_end,
        COUNT(*) AS transactions_count,
        SUM(amount) AS transactions_sum
    FROM grouped_transactions
    GROUP BY sender, group_id
    HAVING transactions_sum >= 150 AND transactions_count >= 2
)
SELECT
    sender,
    sequence_start,
    sequence_end,
    transactions_count,
    ROUND(transactions_sum, 6) AS transactions_sum
FROM suspicious_sequences
ORDER BY
    sender,
    sequence_start,
    sequence_end;
