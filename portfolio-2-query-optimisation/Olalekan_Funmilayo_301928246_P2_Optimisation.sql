-- Create a separate schema for Portfolio 2 testing
CREATE SCHEMA p2_benchmark;

-- Create a benchmark table
CREATE TABLE p2_benchmark.order_history (
    history_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    amount NUMERIC(10,2) NOT NULL
);

-- Generate 100,000 synthetic records
INSERT INTO p2_benchmark.order_history (
    order_id,
    customer_id,
    order_status,
    order_date,
    amount
)
SELECT
    gs,
    CASE
        WHEN MOD(gs, 2) = 0 THEN
            (
                SELECT customer_id
                FROM public.customer
                WHERE email = 'ada@email.com'
            )
        ELSE
            (
                SELECT customer_id
                FROM public.customer
                WHERE email = 'bisi@email.com'
            )
    END,
    CASE MOD(gs, 4)
        WHEN 0 THEN 'Paid'
        WHEN 1 THEN 'Shipped'
        WHEN 2 THEN 'Delivered'
        ELSE 'Pending'
    END,
    DATE '2025-01-01' + MOD(gs, 730),
    1000 + MOD(gs, 50000)
FROM generate_series(1, 100000) AS gs;

-- Refresh statistics
ANALYZE p2_benchmark.order_history;

-- Verify row count
-- Expected result: 100000
SELECT COUNT(*) AS total_rows
FROM p2_benchmark.order_history;

-- Benchmark query before indexing
-- Expected result: approximately 4,248 rows
EXPLAIN (ANALYZE, BUFFERS)
SELECT
    history_id,
    order_id,
    customer_id,
    order_status,
    order_date,
    amount
FROM p2_benchmark.order_history
WHERE order_date BETWEEN DATE '2026-01-01'
                     AND DATE '2026-01-31'
ORDER BY order_date;

-- Create B-tree index
CREATE INDEX idx_order_history_order_date
ON p2_benchmark.order_history (order_date);

-- Refresh statistics after index creation
ANALYZE p2_benchmark.order_history;

-- Benchmark query after indexing
EXPLAIN (ANALYZE, BUFFERS)
SELECT
    history_id,
    order_id,
    customer_id,
    order_status,
    order_date,
    amount
FROM p2_benchmark.order_history
WHERE order_date BETWEEN DATE '2026-01-01'
                     AND DATE '2026-01-31'
ORDER BY order_date;