-- Check the order before the transaction
SELECT
    order_id,
    order_status
FROM public."order"
WHERE order_id = 3;


-- Start a transaction and update a pending order
BEGIN;

UPDATE public."order"
SET order_status = 'Shipped'
WHERE order_id = 3
  AND order_status = 'Pending';

-- Make the change permanent
COMMIT;


-- Verify that the order status was updated
SELECT
    order_id,
    order_status
FROM public."order"
WHERE order_id = 3;


-- Repeat check
-- This update should affect 0 rows because the order is no longer Pending
UPDATE public."order"
SET order_status = 'Shipped'
WHERE order_id = 3
  AND order_status = 'Pending';


-- Start a new transaction for the rollback example
BEGIN;

-- Valid update: reduce stock quantity
UPDATE public.product
SET stock_quantity = stock_quantity - 5
WHERE product_id = 1;

-- Deliberately violate the stock quantity CHECK constraint
-- This should produce an error because stock quantity cannot be negative
UPDATE public.product
SET stock_quantity = -1
WHERE product_id = 1;

-- Cancel the transaction and undo all changes
ROLLBACK;


-- Verify that the committed order change remains
SELECT
    order_id,
    order_status
FROM public."order"
WHERE order_id = 3;


-- Verify that the stock change was rolled back
SELECT
    product_id,
    product_name,
    stock_quantity
FROM public.product
WHERE product_id = 1;