-- Start Transaction B

BEGIN;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Session B cannot see Session A's uncommitted payment

SELECT
    payment_id,
    order_id,
    amount
FROM public.payment
WHERE order_id = 6;

-- Attempt to create a second payment for the same order

INSERT INTO public.payment (
    order_id,
    payment_date,
    amount
)
VALUES (
    6,
    DATE '2026-02-02',
    15000.00
);

-- STOP HERE
-- PostgreSQL should wait because Session A
-- holds an uncommitted row for the same order
-- Switch to Session A and run COMMIT


-- Return to Session B after Session A commits

-- PostgreSQL should return a duplicate key error

ROLLBACK;

-- Verify the final result

SELECT
    payment_id,
    order_id,
    amount
FROM public.payment
WHERE order_id = 6;

-- Only one payment should exist for Order 6
-- The payment inserted by Session A remains
-- The conflicting payment from Session B is rejected