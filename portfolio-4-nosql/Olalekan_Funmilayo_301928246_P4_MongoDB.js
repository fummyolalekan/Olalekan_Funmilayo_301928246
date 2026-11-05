// Select the database
use("fashion_accessories_portfolio");


// Check that the collection is empty before inserting documents
db.activity_events.countDocuments();


// Insert four activity-event documents
db.activity_events.insertMany([

{
  _id: "EVT001",
  eventId: "EVT001",
  eventType: "ORDER_CREATED",
  eventTime: ISODate("2026-01-10T09:00:00Z"),
  customer: {
    customerId: 1,
    customerName: "Ada Johnson"
  },
  details: {
    orderId: 1,
    orderStatus: "Paid",
    itemCount: 2
  }
},

{
  _id: "EVT002",
  eventId: "EVT002",
  eventType: "PAYMENT_RECORDED",
  eventTime: ISODate("2026-01-10T09:15:00Z"),
  customer: {
    customerId: 1,
    customerName: "Ada Johnson"
  },
  details: {
    paymentId: "PAY001",
    orderId: 1,
    amount: 43000
  }
},

{
  _id: "EVT003",
  eventId: "EVT003",
  eventType: "ORDER_CREATED",
  eventTime: ISODate("2026-01-12T11:00:00Z"),
  customer: {
    customerId: 2,
    customerName: "Bisi Ahmed"
  },
  details: {
    orderId: 2,
    orderStatus: "Shipped",
    itemCount: 1
  }
},

{
  _id: "EVT004",
  eventId: "EVT004",
  eventType: "PAYMENT_RECORDED",
  eventTime: ISODate("2026-01-12T11:20:00Z"),
  customer: {
    customerId: 2,
    customerName: "Bisi Ahmed"
  },
  details: {
    paymentId: "PAY002",
    orderId: 2,
    amount: 24000
  }
}

]);


// Query 1: Count all documents in the collection
db.activity_events.countDocuments();


// Query 2: Show the event history for customer ID 1
// Results are sorted by event time

db.activity_events.find(
  {
    "customer.customerId": 1
  }
).sort(
  {
    eventTime: 1
  }
);


// Query 3: Find order events where the embedded order status is Shipped

db.activity_events.find(
  {
    "details.orderStatus": "Shipped"
  }
);