-- Check that Order 6 exists

SELECT
    order_id,
    customer_id,
    order_date,
    order_status
FROM public."order"
WHERE order_id = 6;


-- Check that no payment exists for Order 6

SELECT
    payment_id,
    order_id,
    amount
FROM public.payment
WHERE order_id = 6;


-- Start Transaction A

BEGIN;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Create a payment for Order 6

INSERT INTO public.payment (
    order_id,
    payment_date,
    amount
)
VALUES (
    6,
    DATE '2026-02-02',
    12000.00
);

-- STOP HERE
-- Switch to Session B and run Session B commands
-- Do NOT commit yet


-- After Session B is waiting, return here

COMMIT;

-- Payment is now committed and visible to other sessions