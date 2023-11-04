select * from employees;

select * from departments;


/*Recursive CTEs*/

/*Build the hierarchy for the engineering department = 3*/
select * from employees;

with recursive department_hier as (
select 
employee_id, 
employee_name,
manager_id, 
department_id 
from employees 
where manager_id is null 
and department_id = 3


union all 

select e.employee_id, 
e.employee_name,
e.manager_id, 
e.department_id 
from employees e 
inner join department_hier dh on e.manager_id = dh.employee_id 
where e.department_id = 3
)
select dh.employee_name as employee ,
m.employee_name as manager
from department_hier dh 
left outer join employees m 
on dh.manager_id = m.employee_id 
order by dh.manager_id;


/*Find the full reporting chain for a specific employee - Diana*/



with recursive reporting_chain as (
select e.employee_id, e.employee_name, e.manager_id 
from employees e 
where e.employee_name = 'Diana'

union all 

select e.employee_id, e.employee_name, e.manager_id 
from employees e 
inner join reporting_chain rc on e.employee_id = rc.manager_id

)
select rc.employee_name as employee, 
m.employee_name as manager
from reporting_chain rc 
left outer join employees m 
on rc.manager_id = m.employee_id;



/*List all the employees without subordinates*/

with recursive subordinates as (
select employee_id , employee_name 
from employees 
where employee_id not in (select distinct manager_id from employees where manager_id is not null) 
)

select s.employee_name as employee
from subordinates s;

/*Find the count of employees in the department - Need to check this*/

with recursive department_hier as (
select employee_id, department_id 
from employees 
where manager_id is not null

union all

select e.employee_id, e.department_id 
from employees e 
inner join department_hier df on 
e.manager_id = dh.employee_id
);



create database regex;

use regex;


-- DDL for `departments` table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);

-- DDL for `employees` table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);


-- DML for `departments`
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Human Resources'),
(2, 'Marketing'),
(3, 'Finance'),
(4, 'Information Technology');

-- DML for `employees`
INSERT INTO employees (employee_id, name, email, department_id) VALUES
(101, 'Alice Johnson', 'alice.johnson@example.com', 1),
(102, 'Bob Smith', 'bob.smith@work-email.com', 2),
(103, 'Charlie Brown', 'charlie.brown@marketing-dept.com', 2),
(104, 'Diana Prince', 'diana.prince@finances.biz', 3),
(105, 'Ethan Hunt', 'ethan.hunt@it-dept.tech', 4);

INSERT INTO employees (employee_id, name, email, department_id) VALUES
(106, 'Sarah Johnson', 'sarah.johnson123@example.com', 1);


select * from employees;

select * from departments;

/*Regular Expressions - REGEXP*/

/*Name starting with A*/
select * from employees where name regexp '^A';

select * from employees where name like 'A%';

/*Name ending with n*/
select * from employees where name regexp 'n$';

select * from employees where name like '%n';

/*Contains ic*/
select * from employees where name regexp 'ic';


/*REGEXP_INSTR() */

select name, email,regexp_instr(email,'@') as at_position from employees; 

select name, email,regexp_instr(email, '[0-9]') as digit_position from employees;

select name, email,regexp_instr(email, '[a-c]') as char_position from employees;



/*REGEXP_LIKE()*/
SELECT * FROM EMPLOYEES WHERE REGEXP_LIKE(NAME, '^[bds]');


select * from employees where regexp_like(email, '@it-dept');

select * from employees;

/*REGEXP_REPLACE*/
select name, email,regexp_replace(email, 'dept', 'department')
from employees;

/*Except B*/
SELECT * FROM EMPLOYEES WHERE REGEXP_LIKE(NAME, '^[^b]+');

select name, regexp_replace(email, '^[^@]+', '******')
from employees;
/*masking email*/

/*REGEXP_SUBSTR*/

select name, regexp_substr(email, '^[^@]+') from employees;

select regexp_substr('abc def ghi', '[a-z]+', 5,2)