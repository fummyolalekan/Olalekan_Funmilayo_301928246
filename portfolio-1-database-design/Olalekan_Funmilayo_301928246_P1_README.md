# Portfolio 1 Database Design and Modelling

## Case study
A Fashion Accessories Ecommerce System manages customers, products, orders and payments for an online retailer of fashion accessories. Customers browse products, place orders and track purchases, while administrators manage product listings and order fulfilment.

## Users
Customers browse products, create orders, make payments and view their order history. Administrators manage product information, update stock levels, process orders and review sales records.

## Main operations
Register a customer account; add or update a product; manage product stock levels; place a customer order; record a payment; update order status; view customer order history and product availability.

## Business rules
1. Each customer must have a unique customer ID and a unique email address.
2. Each product must have a unique product ID and belong to one product category.
3. A category can contain many products, but a product belongs to only one category.
4. Each order must be linked to one existing customer and contain at least one existing product.
5. An order may contain multiple products, and a product may appear in multiple orders.
6. Product stock quantity cannot be negative. An order can only be placed when sufficient stock is available.
7. Each payment must relate to one existing order. Payment amount must be greater than zero and equal to the order total.
8. Order status must be one of: Pending, Paid, Shipped, Delivered or Cancelled. A cancelled order cannot be marked as Delivered.

## Scope
The database covers customer accounts, product catalogue management, inventory tracking, orders and payments using fictional data. It excludes product reviews, discount codes, supplier management, delivery tracking integration, user authentication mechanisms and financial accounting functions.