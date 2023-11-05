drop database index_learning;

create database index_learning;

use index_learning;


CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10, 2)
);


/*Index on a single column for "Where" clause*/
create index idx_dept on employees (department_id);
select * from employees where department_id = 6;

/*Index on a multiple columns - Composite Index*/

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(50)
);

create index idx_cust on orders(customer_id,order_date);

select * from orders where customer_id = 1 and order_date ='2013-02-02';

/*Index to speed up "Join" operations*/

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10, 2)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products (id)
);

SELECT p.name, p.price, oi.quantity
FROM products p
JOIN order_items oi ON p.id = oi.product_id
WHERE oi.order_id = 1001;

CREATE INDEX idx_product_id ON order_items (product_id);

drop index idx_product_id on order_items;

/*Using the index for sorting with "Order by"*/
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);


SELECT * FROM customers ORDER BY last_name ASC, first_name ASC;

create index idx_last_first on customers (last_name,first_name);
