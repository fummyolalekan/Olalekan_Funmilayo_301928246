# Fashion Accessories Ecommerce System Normalisation

Normalisation separates information into related tables to reduce repeated data and avoid inconsistent updates. The same two orders are used throughout the examples below. Only the fields needed to explain each normalisation step are shown.

Dates are shortened for readability. Product names, customer names, and email addresses are fictional.

## Starting order list

| order_id | customer_name | email | Products Ordered |
|-----------|--------------|--------|------------------|
| 1001 | Ada Johnson | ada@email.com | Handbag (Qty 1, Bags), Wristwatch (Qty 1, Watches) |
| 1002 | Bisi Ahmed | bisi@email.com | Sunglasses (Qty 2, Accessories), Handbag (Qty 1, Bags) |

The first row contains two products in one cell. Finding a specific product, updating category information, or calculating stock can be difficult.

---

## 1NF: One value per cell

Each ordered product has its own row. The repeated list is removed.

| order_id | customer_name | email | product_name | category_name | quantity |
|-----------|--------------|--------|-------------|--------------|----------|
| 1001 | Ada Johnson | ada@email.com | Handbag | Bags | 1 |
| 1001 | Ada Johnson | ada@email.com | Wristwatch | Watches | 1 |
| 1002 | Bisi Ahmed | bisi@email.com | Sunglasses | Accessories | 2 |
| 1002 | Bisi Ahmed | ada@email.com | Handbag | Bags | 1 |

For this example, the key is **(order_id, product_name)**. Both values together identify one product on an order.

The rows are now in 1NF, but customer details and category information are repeated.

---

## 2NF: Details depend on the whole key

2NF means a non-key field must depend on the whole key, not only part of a combined key.

Here, **product_name** determines **category_name**. The category does not depend on the whole key **(order_id, product_name)**.

### Product Details

**Key: product_name**

| product_name | category_name |
|-------------|--------------|
| Handbag | Bags |
| Wristwatch | Watches |
| Sunglasses | Accessories |

### Order Details

**Key: (order_id, product_name)**

| order_id | product_name | quantity | customer_name | email |
|-----------|-------------|----------|--------------|--------|
| 1001 | Handbag | 1 | Ada Johnson | ada@email.com |
| 1001 | Wristwatch | 1 | Ada Johnson | ada@email.com |
| 1002 | Sunglasses | 2 | Bisi Ahmed | bisi@email.com |
| 1002 | Handbag | 1 | Bisi Ahmed | bisi@email.com |

The category information no longer repeats in every order row. However, customer details still repeat across multiple orders.

---

## 3NF: Keep details with the thing they describe

3NF includes 2NF. Non-key fields must not depend on another non-key field.

Two remaining dependencies exist:

- customer_id determines customer_name and email.
- category_id determines category_name.

These details move into their own tables.

### Category

**Key: category_id**

| category_id | category_name |
|------------|--------------|
| 1 | Bags |
| 2 | Watches |
| 3 | Accessories |

### Product

**Key: product_id**

| product_id | product_name | category_id |
|-----------|-------------|------------|
| 1 | Handbag | 1 |
| 2 | Wristwatch | 2 |
| 3 | Sunglasses | 3 |

### Customer

**Key: customer_id**

| customer_id | customer_name | email |
|------------|--------------|--------|
| 1 | Ada Johnson | ada@email.com |
| 2 | Bisi Ahmed | bisi@email.com |

### Order

**Key: order_id**

| order_id | customer_id |
|----------|------------|
| 1001 | 1 |
| 1002 | 2 |

### Order Item

The final design uses **order_item_id** as the primary key instead of relying on a combined key.

| order_item_id | order_id | product_id | quantity |
|--------------|----------|-----------|----------|
| 1 | 1001 | 1 | 1 |
| 2 | 1001 | 2 | 1 |
| 3 | 1002 | 3 | 2 |
| 4 | 1002 | 1 | 1 |

### Payment

**Key: payment_id**

| payment_id | order_id | amount |
|-----------|----------|---------|
| 1 | 1001 | 25000.00 |
| 2 | 1002 | 35000.00 |

Customer details are now stored once in **Customer**, category details are stored once in **Category**, and IDs keep the tables linked together.

These are the final tables used in the database design. The complete schema also includes attributes such as `price`, `stock_quantity`, `order_date`, `payment_date`, `phone_number`, and `order_status`. Business rules such as stock availability, valid order statuses, and payment validation still require constraints or transaction logic; normalisation alone does not enforce them.