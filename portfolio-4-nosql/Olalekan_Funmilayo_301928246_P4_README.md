# Portfolio 4 NoSQL and Advanced Data Models

## Document model

This portfolio uses MongoDB to store activity events for the Fashion Accessories Ecommerce System. Instead of storing related data across multiple tables, MongoDB stores information in a single collection using embedded documents.

Collection: `activity_events`

| Field | Purpose |
|---------|---------|
| _id | Unique document identifier |
| eventId | Business event identifier |
| eventType | Event category |
| eventTime | Date and time of the event |
| customer | Embedded customer information |
| details | Event-specific information |

Example document:

```json
{
  "_id": "EVT001",
  "eventId": "EVT001",
  "eventType": "ORDER_CREATED",
  "customer": {
    "customerId": 1,
    "customerName": "Ada Johnson"
  },
  "details": {
    "orderId": 1,
    "orderStatus": "Paid",
    "itemCount": 2
  }
}
```

## Implementation and results

MongoDB was run locally using `mongosh`. The database used was `fashion_accessories_portfolio` and the collection used was `activity_events`.

Four fictional event documents were inserted successfully using a single `insertMany()` command. The collection contains two event types: `ORDER_CREATED` and `PAYMENT_RECORDED`.

Query results:

- `countDocuments()` returned **4**, confirming four documents were inserted.
- The customer history query for customer ID 1 returned **EVT001** and **EVT002** in date order.
- The nested field query for `"details.orderStatus": "Shipped"` returned **EVT003**.

## Why MongoDB fits

MongoDB is suitable for activity and event data because different event types can store different details while remaining in the same collection. Embedded documents allow customer and event information to be stored together without requiring joins. This flexibility makes MongoDB useful for event logging and activity tracking.

A limitation is that MongoDB does not automatically enforce the same relational constraints available in PostgreSQL, such as foreign keys between customers, orders, and payments.

## Files

| File | Purpose |
|--------|---------|
| Olalekan_Funmilayo_301928246_P4_MongoDB.js | MongoDB commands, documents and queries. |
| Screenshots/ | Screenshots showing document insertion and query results. |

## References

- MongoDB Documentation: https://www.mongodb.com/docs/
- MongoDB Shell Documentation: https://www.mongodb.com/docs/mongodb-shell/