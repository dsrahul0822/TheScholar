use misc;

/*Set Operators
Union 
Union all
Intersect
Except
*/

/*Inner Join, Left Outer Join, Right Outer Join and Full Outer Join*/

/*Union - Duplicates are not entertained 
Union all - Duplicates are entertained */

CREATE TABLE table1 (id INT, name VARCHAR(50));
CREATE TABLE table2 (id INT, name VARCHAR(50));

INSERT INTO table1 VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO table2 VALUES (3, 'Charlie'), (4, 'David');

INSERT INTO table1 values (3,'Charlie');

SELECT name FROM table1
UNION
SELECT name FROM table2;


select * from table2;

/*Intersect - Returns rows that are common between two select statements*/

select * from table1;

select * from table2;

select * from table1 where name in (select name from table2);

select a.name from table1 a inner join table2 b on a.id=b.id;


/*Except - Returns rows from the first select statement that are not in the 
select select statement*/

select name from table1 where name not in (select name from table2);

select name from table1 a where not exists (select 1 from table2 b where
a.name=b.name);




/*Exists Clause*/

use hrdb;

select * from tbl_employees;

select * from tbl_employees where employee_id  not in (select manager_id from 
tbl_employees);

select * from tbl_employees e 
where not exists (select 'rahul' from tbl_employees where manager_id = e.employee_id );


select * from tbl_employees;

/*Find the customers who have placed orders*/
-- DDL
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

-- DML
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 1, '2023-10-01'), (2, 1, '2023-10-05'), (3, 3, '2023-10-10');

select * from customers;
select * from orders;
-- Query
SELECT customer_name
FROM customers c
WHERE  EXISTS (
    SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id
);

/*Find the  products which are not sold*/
-- DDL
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT
);

-- DML
INSERT INTO products VALUES (1, 'Laptop'), (2, 'Tablet'), (3, 'Phone');
INSERT INTO sales VALUES (1, 1), (2, 3);

select * from products;
select * from sales;

select product_name from products p 
where not exists (select 1 from sales s where s.product_id = p.product_id);


/*Find the authors who have written more than one book*/

-- DDL
CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(50)
);

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    author_id INT,
    book_title VARCHAR(100)
);

-- DML
INSERT INTO authors VALUES (1, 'George'), (2, 'John'), (3, 'Paul');
INSERT INTO books VALUES (1, 1, 'Book A'), (2, 1, 'Book B'), (3, 2, 'Book C');

select * from authors;
select * from books;

select author_id, count(book_id)
from books
group by author_id;

select * from authors a 
where exists (select 1 from books b where b.author_id = a.author_id
group by b.author_id having count(*) >1);


/*Find the users who have not logged in recently*/

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50)
);

CREATE TABLE user_logs (
    log_id INT PRIMARY KEY,
    user_id INT,
    log_date DATE
);

INSERT INTO users VALUES (1, 'alice123'), (2, 'bob456'), (3, 'charlie789');
INSERT INTO user_logs VALUES (1, 1, '2023-10-01'), (2, 2, '2023-09-01');


select * from users;

select * from user_logs;

select * from users u 
where not exists (select 1 from user_logs u1 where u1.user_id = u.user_id 
and u1.log_date>'2023-09-30');


/*Full Outer Join*/

select * from tbl_employees;
select * from tbl_departments;

/*Full Outer Join*/
select * from tbl_employees emp 
left outer join tbl_departments dept
on emp.department_id = dept.department_id
union
select * from tbl_employees emp 
right outer join tbl_departments dept 
on emp.department_id = dept.department_id;


/*Employee and Departments*/

CREATE TABLE Department (
    DEPTID INT PRIMARY KEY,
    DNAME VARCHAR(255)
);

CREATE TABLE Employee (
    EID INT PRIMARY KEY,
    ENAME VARCHAR(255),
    DEPTID INT,
    SALARY FLOAT,
    FOREIGN KEY (DEPTID) REFERENCES Department(DEPTID)
);


select * from employee;
select * from Department;

use hrdb;
select * from employee emp
left outer join department dept 
on emp.deptid = dept.deptid
union 
select * from employee emp
right outer join department dept 
on emp.deptid = dept.deptid;


INSERT INTO Department (DEPTID, DNAME) VALUES (10, 'HR');
INSERT INTO Department (DEPTID, DNAME) VALUES (20, 'IT');
INSERT INTO Department (DEPTID, DNAME) VALUES (30, 'Marketing');
INSERT INTO Department (DEPTID, DNAME) VALUES (40, 'Sales');



INSERT INTO Employee (EID, ENAME, DEPTID, SALARY) VALUES (1, 'A', 10, 1000);
INSERT INTO Employee (EID, ENAME, DEPTID, SALARY) VALUES (2, 'B', 20, 1500);
INSERT INTO Employee (EID, ENAME, DEPTID, SALARY) VALUES (3, 'C', 20, 1250);
INSERT INTO Employee (EID, ENAME, DEPTID, SALARY) VALUES (4, 'D', 20, 1300);
INSERT INTO Employee (EID, ENAME, DEPTID, SALARY) VALUES (5, 'E', 30, 1400);
INSERT INTO Employee (EID, ENAME, DEPTID, SALARY) VALUES (6, 'F', NULL, 1500);
INSERT INTO Employee (EID, ENAME, DEPTID, SALARY) VALUES (7, 'G', NULL, 1300);

/*Temporary Tables*/

create temporary table temp_emp
(eid int, 
ename varchar(10),
deptid int, 
salary int);


select * from temp_emp;

insert into temp_emp select * from employee;


use hrdb;

select * from temp_emp;


select * from employee;

select * from department;

create temporary table temp_common
(eid int,
ename varchar(10),
salary int,
dname varchar(10)
);

create table final
(dname varchar(10),
salary int);
insert into temp_common
select emp.eid, emp.ename, emp.salary, dept.dname from employee emp
inner join department dept 
on emp.deptid = dept.deptid;

select * from temp_common;

use hrdb;
insert into final
select dname, sum(salary) 
from temp_common
group by dname;

select * from final;

drop table final;



call temp_test();



CREATE DEFINER=`root`@`localhost` PROCEDURE `temp_test`()
BEGIN
create temporary table temp_common
(eid int,
ename varchar(10),
salary int,
dname varchar(10)
);

insert into temp_common 
select emp.eid, emp.ename, emp.salary, dept.dname 
from employee emp
inner join department dept 
on emp.deptid = dept.deptid;


create table final
(dname varchar(10),
salary int);

insert into final
select dname, sum(salary) 
from temp_common
group by dname;
END