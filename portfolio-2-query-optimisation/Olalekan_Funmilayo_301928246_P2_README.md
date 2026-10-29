# Portfolio 2 Query Processing and Optimisation

## Queries and results

### Query 1: Orders with customer and product details

This query joins the `customer`, `order`, `order_item`, and `product` tables and displays products included in paid or shipped orders.

| order_id | customer | order_date | order_status | product_name | quantity |
|----------|----------|------------|-------------|-------------|----------|
| 1 | Ada Johnson | 2026-01-10 | Paid | Classic Wristwatch | 1 |
| 1 | Ada Johnson | 2026-01-10 | Paid | Leather Handbag | 1 |
| 2 | Bisi Ahmed | 2026-01-12 | Shipped | Designer Sunglasses | 2 |

### Query 2: Orders without a payment

This query uses `NOT EXISTS` to identify orders that do not have a related payment record.

| order_id | customer | order_date | order_status |
|----------|----------|------------|-------------|
| 3 | Ada Johnson | 2026-01-15 | Pending |

### Query 3: Product count by category

This query uses a `LEFT JOIN` to count products in each category while ensuring categories with no products would still appear.

| category_name | product_count |
|---------------|--------------|
| Accessories | 1 |
| Bags | 1 |
| Watches | 1 |

---

## Index comparison

Test table: `p2_benchmark.order_history`

Row count: **100,000**

Unchanged query:

```sql
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
```

Added index:

```sql
CREATE INDEX idx_order_history_order_date
ON p2_benchmark.order_history (order_date);
```

| Measurement | Before index | After index |
| --- | --- | --- |
| Scan type | Sequential Scan (Seq Scan) | Bitmap Index Scan + Bitmap Heap Scan |
| Three execution times (ms) | 7.635, 8.314, 8.414 | 2.255, 2.507, 2.416 |
| Median time (ms) | 8.314 | 2.416 |
| Shared buffer hits, third run | 935 | 181 |

---

## Performance analysis

Before the index was added, PostgreSQL used a Sequential Scan and examined almost the entire `order_history` table before filtering the required rows. After creating the B-tree index on `order_date`, PostgreSQL changed to a Bitmap Index Scan and Bitmap Heap Scan, allowing matching rows to be located more efficiently. The median execution time decreased from **8.314 ms** to **2.416 ms**, while shared buffer hits decreased from **935** to **181**. This benchmark demonstrates an improvement for this specific query and dataset, but results may differ with other data distributions and workloads. A limitation is that the test uses synthetic benchmark data rather than a production workload. An index also requires additional storage and increases the cost of INSERT, UPDATE, and DELETE operations because PostgreSQL must maintain the index structure.

---

## Files

| File | Purpose |
|--------|---------|
| [Olalekan_Funmilayo_301928246_P2_Queries.sql](Olalekan_Funmilayo_301928246_P2_Queries.sql) | Query definitions and query result testing. |
| [Olalekan_Funmilayo_301928246_P2_Optimisation.sql](Olalekan_Funmilayo_301928246_P2_Optimisation.sql) | Benchmark table creation, data generation, indexing, and optimisation testing. |
| [Screenshots/](Screenshots/) | Screenshots showing query outputs and before/after index execution plans. |

### Screenshots saved

- `Olalekan_Funmilayo_301928246_P2_QueryResults.png`
- `Olalekan_Funmilayo_301928246_P2_BeforeIndex.png`
- `Olalekan_Funmilayo_301928246_P2_AfterIndex.png`

---

## Reference

- PostgreSQL Documentation: https://www.postgresql.org/docs/current/