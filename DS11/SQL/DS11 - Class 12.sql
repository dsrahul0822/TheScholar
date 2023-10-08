use hrdb;


select * from tbl_employees;

/*Lead*/


select first_name, salary, 
lag(salary,1) over(order by employee_id) as next_emp_salary
from tbl_employees;



create table tbl_rev
(rev_date date,
revenue int);




insert into tbl_rev value
('2012-02-01',2000),
('2012-03-01',3000),
('2012-04-01',4000),
('2012-05-01',5000),
('2012-06-01',1000),
('2012-07-01',2000),
('2012-08-01',3000),
('2012-09-01',4000),
('2012-10-01',5000),
('2012-11-01',1000),
('2012-12-01',2000),
('2013-01-01',3000),
('2013-02-01',4000),
('2013-03-01',5000),
('2013-04-01',1000),
('2013-05-01',2000),
('2013-06-01',3000),
('2013-07-01',4000),
('2013-08-01',5000),
('2013-09-01',1000),
('2013-10-01',2000),
('2013-11-01',3000),
('2013-12-01',4000);


delete from tbl_rev;

select rev_date, revenue, prev_month_rev, ((revenue-prev_month_rev)/prev_month_rev)*100 per_change
from (
select rev_date,revenue,lag(revenue,12,0) over(order by rev_date) prev_month_rev  from tbl_rev) tbl;


select first_name,salary,department_id,lag(salary) over(partition by department_id order by salary) prev_salary
 from tbl_employees
 order by department_id;

select first_name,
salary,
department_id,
first_value(first_name) over(partition by department_id order by salary),
last_value(first_name) over(partition by department_id order by salary)
from tbl_employees;



create table tbl_test1
(id int,
value_nm int);


insert into tbl_test1 values (1,10),(2,20),(3,20),(4,30),(5,40);



select * from tbl_test1;

select id, value_nm,
sum(value_nm) over(order by value_nm rows between unbounded preceding and 1 following) sum_new_row,
sum(value_nm) over(order by value_nm range between unbounded preceding and 1 following) sum_new_range
from tbl_test1;


select id, value_nm,
sum(value_nm) over(order by id rows between unbounded preceding and 1 following) sum_new_row,
sum(value_nm) over(order by id range between unbounded preceding and 1 following) sum_new_range
from tbl_test1;




select first_name,
salary, 
rank() over(order by salary desc) rnk_wt,
rank() over(order by salary desc rows between 1 preceding and 1 following) rnk 
from tbl_employees;

select first_name,
salary, 
ifnull(department_id,0),
sum(salary) over(partition by department_id order by salary desc rows between unbounded preceding and 1 following) rnk_wt,
sum(salary) over(partition by department_id order by salary desc rows between 1 preceding and 1 following) rnk 
from tbl_employees;


select * from tbl_rev;

select rev_date, revenue, avg(revenue) over(order by rev_date rows between 5 preceding and 0 following )
from tbl_rev;