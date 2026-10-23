# Fashion Accessories Ecommerce System Database Design

## Entities

I chose six entities for the Fashion Accessories Ecommerce System.

| Entity | Information Stored |
|----------|------------------|
| customer | Registered customers who place orders |
| category | Product categories used to organise fashion accessories |
| product | Fashion accessories available for sale |
| order | Customer purchases and order details |
| order_item | Products included within an order |
| payment | Payment records for customer orders |

I keep **order** and **order_item** separate because one order can contain multiple products, and one product can appear in many different orders.

## Attributes and Keys

I use an automatically generated ID for each record. In the table below, **unique** means no repeated values. **Required** means the value cannot be NULL (missing).

| Entity | Attributes and Proposed PostgreSQL Types | Keys and Required Values |
|----------|-----------------------------------------|-------------------------|
| customer | customer_id BIGINT; full_name VARCHAR(120); email VARCHAR(254); phone_number VARCHAR(20) | PK: customer_id. Unique: email. All required except phone_number. |
| category | category_id BIGINT; category_name VARCHAR(100) | PK: category_id. Unique: category_name. All required. |
| product | product_id BIGINT; category_id BIGINT; product_name VARCHAR(150); price NUMERIC(10,2); stock_quantity INTEGER | PK: product_id. FK: category_id → category.category_id. All required. |
| order | order_id BIGINT; customer_id BIGINT; order_date DATE; order_status VARCHAR(20) | PK: order_id. FK: customer_id → customer.customer_id. All required. |
| order_item | order_item_id BIGINT; order_id BIGINT; product_id BIGINT; quantity INTEGER | PK: order_item_id. FKs: order_id → order.order_id; product_id → product.product_id. All required. |
| payment | payment_id BIGINT; order_id BIGINT; payment_date DATE; amount NUMERIC(10,2) | PK: payment_id. FK: order_id → order.order_id. All required. |

**BIGINT** stores whole numbers such as IDs. **VARCHAR** stores text values. **NUMERIC(10,2)** stores monetary values with two decimal places. **DATE** stores calendar dates.

I store the payment amount because it records the value paid at the time of the transaction and provides a historical payment record.

## Relationships

| Relationship | Description |
|-------------|-------------|
| customer → order | One customer can place zero, one, or many orders. |
| order → customer | Each order belongs to exactly one customer. |
| category → product | One category can contain zero, one, or many products. |
| product → category | Each product belongs to exactly one category. |
| order → order_item | One order contains one or many order items. |
| order_item → order | Each order item belongs to one order. |
| product → order_item | One product can appear in zero, one, or many order items. |
| order_item → product | Each order item refers to one product. |
| order → payment | One order can have zero or one payment. |
| payment → order | Each payment relates to exactly one order. |

**Example:** Order 1001 may contain a handbag and a wristwatch. Two order_item records connect the order to those products.

## Business Rules and Constraints

### Rule 1
Each customer has a unique customer ID and a unique email address. This is enforced using a primary key and a unique constraint.

### Rule 2
Each product has a unique product ID and belongs to one category. The category relationship is enforced through a foreign key.

### Rule 3
A category can contain many products, but each product belongs to only one category. This is enforced through the product-to-category foreign key relationship.

### Rule 4
Each order must be linked to one existing customer and contain at least one existing product. The customer relationship is enforced by a foreign key, while products are linked through order_item records.

### Rule 5
An order may contain multiple products, and a product may appear in multiple orders. The order_item table resolves this many-to-many relationship.

### Rule 6
Product stock quantity cannot be negative. An order can only be placed when sufficient stock is available to fulfil the requested quantity.

### Rule 7
Each payment must relate to an existing order. The payment amount must be greater than zero and must match the calculated order total.

### Rule 8
Order status must be one of the following values:

- Pending
- Paid
- Shipped
- Delivered
- Cancelled

A cancelled order cannot later be marked as delivered.
