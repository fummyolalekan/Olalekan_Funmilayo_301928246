-- Show customer orders with product details
SELECT
    o.order_id,
    c.full_name,
    o.order_date,
    o.order_status,
    p.product_name,
    oi.quantity
FROM public."order" o
JOIN public.customer c
    ON o.customer_id = c.customer_id
JOIN public.order_item oi
    ON o.order_id = oi.order_id
JOIN public.product p
    ON oi.product_id = p.product_id
WHERE o.order_status IN ('Paid', 'Shipped')
ORDER BY o.order_date, o.order_id, p.product_name;

-- Find orders that do not yet have a payment
SELECT
    o.order_id,
    c.full_name,
    o.order_date,
    o.order_status
FROM public."order" o
JOIN public.customer c
    ON o.customer_id = c.customer_id
WHERE NOT EXISTS (
    SELECT 1
    FROM public.payment p
    WHERE p.order_id = o.order_id
)
ORDER BY o.order_id;

-- Count products in each category
SELECT
    c.category_name,
    COUNT(p.product_id) AS product_count
FROM public.category c
LEFT JOIN public.product p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_name;