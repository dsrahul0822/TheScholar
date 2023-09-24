use hrdb;

/*view never stores the data it just stores the query and you call the view it will hit that query
and fetch the output. */

with dept_salary as (
select department_name, sum(salary) dept_total from tbl_employees emp
inner join tbl_departments dept 
on emp.department_id = dept.department_id 
group by department_name), 
avg_salary as (select sum(dept_total)/count(*) as dept_avg
from dept_salary)
select * from dept_salary 
where dept_total>(select dept_avg from avg_salary);


select * from avg_salary_vw;


select * from information_schema.tables where table_name='tbl_employees';

select * from information_schema.columns;

select * from tbl_employees;


insert into tbl_employees values (999, 'Tiwari','Rahul', 'rtiwari', '123456789','2003-06-17','AD_VP',20000,0.2,100,90);





/*Metadata tables - Data about data*/



/*Simple View*/

create or replace view vw_emp as 
select * from tbl_employees;

select * from tbl_employees;

select * from vw_emp;


insert into vw_emp_log values 
(1000, 'Sharma', 'rsharma',null,'2003-06-17','IT_PROG',15000,0.2,100,60);

create or replace view vw_emp_log as 
select 
employee_id,
concat(first_name,' ',last_name) name,
email,
Hire_date,
job_id,
salary,
Commission_pct, 
Manager_id,
department_id
 from tbl_employees;


select * from vw_emp_log;

select * from tbl_employees;


create or replace view vw_emp_90
as 
select * from tbl_employees where department_id=90;



select * from vw_emp_90;
insert into vw_emp_90 values 
(1000, 'kohli', 'Virat', 'vkohli',8885552223,'2003-06-17','AD_VP',15000,0.2,100,90);

select * from tbl_employees;






create or replace view vw_join as 
select employee_id,
last_name,
first_name,
email,
hire_date,
job_id,
salary,
commission_pct,
emp.manager_id emid,
emp.department_id edept,
dept.department_id ddpept,
department_name,
dept.manager_id mdind,
location_id
 from tbl_employees emp
inner join tbl_departments dept 
on emp.department_id = dept.department_id;


select * from vw_join;

insert into vw_join values 
(1000, 'kohli', 'Virat', 'vkohli',null,'2003-06-17','AD_VP',15000,0.2,100,90,'Exective',100,1000);

