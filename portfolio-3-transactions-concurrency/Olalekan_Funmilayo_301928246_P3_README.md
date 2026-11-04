# Portfolio 3 Transactions and Concurrency

## Commit and rollback

The transaction exercise used Order 3 and Product 1 from the Fashion Accessories Ecommerce System. Order 3 was updated from **Pending** to **Shipped** and the change was committed successfully. A repeat update affected zero rows because the UPDATE statement only changed orders that were still in the Pending state.

In the next transaction, a valid stock update was attempted for Product 1 (Leather Handbag) before a second update deliberately violated the `stock_quantity >= 0` check constraint by setting the stock quantity to a negative value. PostgreSQL raised an error and the transaction was rolled back. The committed order status change remained, while the stock update was undone.

## Isolation and concurrency control

Two PostgreSQL sessions used the **READ COMMITTED** isolation level. Session A inserted a payment for Order 6 but did not commit immediately. Session B could not see the uncommitted payment and its query returned zero rows. Session B then attempted to insert another payment for the same order.

Session B waited while PostgreSQL checked the existing transaction. After Session A committed, Session B received a duplicate-key error because the `UNIQUE(order_id)` constraint on the `payment` table prevented a second payment from being created for the same order. Session B rolled back its transaction. The final verification query showed exactly one payment for Order 6, created by Session A.

## Conclusion

COMMIT makes transaction changes permanent, while ROLLBACK removes uncommitted changes. The READ COMMITTED isolation level prevents a session from seeing another session’s uncommitted records. The unique constraint on `payment.order_id` prevented conflicting payments from being recorded for the same order, even though Session B initially found no payment record. Transaction isolation works together with database constraints to protect data integrity, but isolation alone does not enforce all business rules.

## Files

| File | Purpose |
|------|---------|
| [Olalekan_Funmilayo_301928246_P3_Transactions.sql](Olalekan_Funmilayo_301928246_P3_Transactions.sql) | Commit and rollback transaction exercise. |
| [Olalekan_Funmilayo_301928246_P3_SessionA.sql](Olalekan_Funmilayo_301928246_P3_SessionA.sql) | Session A commands for the concurrency test. |
| [Olalekan_Funmilayo_301928246_P3_SessionB.sql](Olalekan_Funmilayo_301928246_P3_SessionB.sql) | Session B commands for the concurrency test. |
| [Screenshots/](Screenshots/) | Screenshots showing commit/rollback and concurrency test results. |

## References

- PostgreSQL Documentation: https://www.postgresql.org/docs/current/