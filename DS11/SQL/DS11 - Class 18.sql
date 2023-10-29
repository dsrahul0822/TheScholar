/*Limit*/ 



/*Delete Cascade*/
drop table authors;
drop table books;
CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

INSERT INTO authors (name) VALUES ('George Orwell');
INSERT INTO authors (name) VALUES ('Jane Austen');

-- Assuming George Orwell has `author_id` 1 and Jane Austen has `author_id` 2
INSERT INTO books (title, author_id) VALUES ('1984', 1);
INSERT INTO books (title, author_id) VALUES ('Animal Farm', 1);
INSERT INTO books (title, author_id) VALUES ('Pride and Prejudice', 2);

select * from books;
 
select * from authors;

SET SQL_SAFE_UPDATES = 0;
delete from authors where name = 'George Orwell';

/*Update Join*/

/*Example 1: Updates prices based on a discount table*/
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE discounts (
    product_id INT PRIMARY KEY,
    discount_percent INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_name, price) VALUES ('Laptop', 1000.00), ('Tablet', 500.00);
INSERT INTO discounts (product_id, discount_percent) VALUES (1, 10); -- 10% discount for Laptop

select * from products;

select * from discounts;


update products prd
inner join discounts disc
on prd.product_id = disc.product_id
set prd.price = prd.price * (1-disc.discount_percent/100);  


/*Example 2: Update the employees salary based on the promotion table*/

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

CREATE TABLE promotions (
    emp_id INT PRIMARY KEY,
    salary_increment DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

INSERT INTO employees (emp_name, salary) VALUES ('John', 50000.00), ('Jane', 60000.00);
INSERT INTO promotions (emp_id, salary_increment) VALUES (1, 5000.00); -- John gets a salary increment of 5000

select * from employees;

select * from promotions;

update employees emp 
inner join promotions pr
on emp.emp_id = pr.emp_id 
set emp.salary = emp.salary + pr.salary_increment;

drop table categories;
drop table discounts;
drop table products;

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    category_id INT,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE discounts (
    discount_id INT PRIMARY KEY,
    category_id INT,
    discount_percent DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Inserting data into categories
INSERT INTO categories VALUES (1, 'Electronics');
INSERT INTO categories VALUES (2, 'Apparels');

-- Inserting data into products
INSERT INTO products (product_id, product_name, category_id, price) VALUES (10,'Smartphone', 1, 500.00);
INSERT INTO products (product_id, product_name, category_id, price) VALUES (20,'Smartwatch', 1, 200.00);
INSERT INTO products (product_id, product_name, category_id, price) VALUES (30, 'T-Shirt', 2, 20.00);

-- Inserting data into discounts
INSERT INTO discounts (discount_id,category_id, discount_percent) VALUES (100,1, 15); -- 15% discount for Electronics


update products prd 
inner join categories cat 
on prd.category_id = cat.category_id 
inner join discounts disc 
on disc.category_id = cat.category_id 
set prd.price = prd.price * (1-disc.discount_percent/100);


select * from products;

select * from categories;

select * from discounts;

/*Delete join*/

/*Example 1: Delete the orders for the discontinued products*/

drop table products;

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    is_discontinued BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_name, is_discontinued) VALUES ('Laptop', FALSE), ('Old Phone', TRUE);
INSERT INTO orders (product_id, quantity) VALUES (1, 3), (2, 5);



select * from products;

select * from orders;

delete ord from orders ord
inner join products prd 
on ord.product_id = prd.product_id 
where prd.is_discontinued=True; 


/*Example 2: Delete Employees with departments */
drop table employees;
drop table promotions;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(255) NOT NULL
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(255) NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);


INSERT INTO departments (dept_name) VALUES ('HR');
INSERT INTO employees (emp_name, dept_id) VALUES ('John', 1), ('Jane', NULL);


select * from departments;

select * from employees;

delete e from employees e 
left outer join departments d 
on e.dept_id = d.dept_id 
where d.dept_id is null;


/*Example 3: Delete the expired promotions*/
drop table products;
drop table discounts;
drop table categories;
drop table orders;


CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL
);

CREATE TABLE promotions (
    promo_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO products (product_name) VALUES ('Laptop'), ('Tablet');
INSERT INTO promotions (product_id, end_date) VALUES (1, '2023-01-01'), (2, '2023-12-31');


select * from promotions;

select * from products;


delete p from promotions p
inner join products prd 
on p.product_id = prd.product_id 
where p.end_date < curdate();

/*Cross join*/

/*Example 1: Color and Size combinations for clothing*/

CREATE TABLE colors (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    color_name VARCHAR(255) NOT NULL
);

CREATE TABLE sizes (
    size_id INT PRIMARY KEY AUTO_INCREMENT,
    size_name VARCHAR(50) NOT NULL
);


INSERT INTO colors (color_name) VALUES ('Red'), ('Blue'), ('Green');
INSERT INTO sizes (size_name) VALUES ('Small'), ('Medium'), ('Large');

select * from colors;
select * from sizes;

select color_name, size_name 
from colors
cross join sizes;

/*Example 2: Generate Date and Time slot combinations for appointments*/

CREATE TABLE dates (
    date_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_date DATE NOT NULL
);

CREATE TABLE time_slots (
    slot_id INT PRIMARY KEY AUTO_INCREMENT,
    time_slot TIME NOT NULL
);

INSERT INTO dates (appointment_date) VALUES ('2023-11-01'), ('2023-11-02'), ('2023-11-03');
INSERT INTO time_slots (time_slot) VALUES ('09:00:00'), ('10:00:00'), ('11:00:00');

select appointment_date,time_slot
from dates cross join time_slots limit 2;




