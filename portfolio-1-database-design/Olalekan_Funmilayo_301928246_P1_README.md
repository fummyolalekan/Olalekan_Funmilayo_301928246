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

## Design and implementation files

| File | Contents |
|------|----------|
| [Olalekan_Funmilayo_301928246_P1_Design.md](Olalekan_Funmilayo_301928246_P1_Design.md) | Database design, entities, attributes, keys, relationships, and business rules. |
| [Olalekan_Funmilayo_301928246_P1_ERDiagram.md](Olalekan_Funmilayo_301928246_P1_ERDiagram.md) | Mermaid ER diagram and relationship explanations. |
| [Olalekan_Funmilayo_301928246_P1_Normalisation.md](Olalekan_Funmilayo_301928246_P1_Normalisation.md) | 1NF, 2NF, and 3NF normalisation process with examples. |
| [Olalekan_Funmilayo_301928246_P1_Schema.sql](Olalekan_Funmilayo_301928246_P1_Schema.sql) | PostgreSQL schema containing tables, primary keys, foreign keys, unique constraints, and checks. |
| [Screenshots/](Screenshots/) | Screenshots showing schema creation, data insertion, constraint testing, and query results. |

## Implementation

The database was implemented in PostgreSQL using the database **fashion_accessories_portfolio**. The schema contains six tables: `customer`, `category`, `product`, `order`, `order_item`, and `payment`. Primary keys use generated identity values, while foreign keys enforce relationships between related records.

The schema script was executed first, followed by sample data inserts and constraint tests. The tests checked unique constraints, foreign key constraints, NOT NULL requirements, payment restrictions, and other validation rules defined in the schema. Screenshots of the execution and results were saved in the `Screenshots` folder.

## Test results

The tests showed that valid records were inserted successfully into all tables. Constraint tests correctly rejected invalid data, including duplicate customer emails, duplicate category names, missing required customer names, invalid category references, negative values, and duplicate payment records for the same order. These results confirm that the implemented primary keys, foreign keys, unique constraints, and check constraints are operating as expected.

The final row-count query returned the following results:

| Table | Rows |
|--------|------|
| category | 3 |
| customer | 2 |
| product | 3 |
| order | 3 |
| order_item | 3 |
| payment | 2 |

Screenshots saved in the `Screenshots` folder include schema creation, table listing, successful data inserts, constraint tests, foreign key tests, payment tests, and final record-count verification. Examples include:
- `Olalekan_Funmilayo_301928246_P1_SchemaCommit.png`
- `Olalekan_Funmilayo_301928246_P1_TableList.png`
- `Olalekan_Funmilayo_301928246_P1_TestForeignKey.png`
- `Olalekan_Funmilayo_301928246_P1_TestUniqueEmail.png`
- `Olalekan_Funmilayo_301928246_P1_TestRequiredName.png`
- `Olalekan_Funmilayo_301928246_P1_TestNegativePrice.png`
- `Olalekan_Funmilayo_301928246_P1_TestPaymentLimit.png`

**Reference**

PostgreSQL Documentation
