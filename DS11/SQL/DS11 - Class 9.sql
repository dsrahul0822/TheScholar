use hrdb;
/*CTE - Common Table Expressions*/

select * from tbl_employees;
select * from tbl_departments;

select e.employee_id, e.first_name, e.last_name, d.department_name
from tbl_employees e
inner join 
tbl_departments d 
on e.department_id = d.department_id
where d.department_name='IT';


with department_name as (select department_id, department_name
from tbl_departments where department_name='IT')
select employee_id, first_name, last_name, department_name 
from tbl_employees e 
inner join department_name d
on e.department_id = d.department_id;

select employee_id, first_name, last_name, department_name 
from tbl_employees e 
inner join 
(select department_id, department_name
from tbl_departments where department_name='IT') dept
on e.department_id = dept.department_id;


select * from tbl_employees;


select concat(emp.first_name,' ', emp.last_name) employee_name,
concat(mgr.first_name,' ', mgr.last_name) manager_name 
from tbl_employees emp 
left outer join tbl_employees mgr 
on emp.manager_id = mgr.employee_id;


with mgr as (select  employee_id, concat(first_name, ' ', last_name) manager_name,
manager_id
from tbl_employees),
emp as (select employee_id, manager_id, concat(first_name, ' ', last_name) employee_name 
from tbl_employees) 
select emp.employee_id,
emp.employee_name,mgr.employee_id manager_id,mgr.manager_name from emp
left outer join mgr
on emp.manager_id = mgr.employee_id;


with emp as 
(select employee_id, manager_id, 
concat(first_name, ' ', last_name) employee_name from tbl_employees),
mgr as (select employee_id, manager_id, 
concat(first_name,' ', last_name) manager_name from tbl_employees)
select emp.employee_id, 
emp.employee_name, 
emp.manager_id, 
mgr.manager_name 
from emp 
left outer join mgr 
on emp.manager_id = mgr.employee_id;

select * from tbl_employees;

select * from tbl_departments;



with assal as (
select department_id, avg(salary) avg_salary 
from tbl_employees
group by department_id)
select dept.department_id, department_name,assal.avg_salary
from tbl_departments dept 
inner join assal
on assal.department_id = dept.department_id;




with empc as (select department_id,count(*) emp_count from tbl_employees 
group by department_id),
dept as (select department_id, department_name from tbl_departments) 
select department_name, emp_count from empc
inner join dept
on empc.department_id=dept.department_id;



select dept.department_name, sum(emp.salary) 
from tbl_employees emp
inner join tbl_departments dept 
on emp.department_id = dept.department_id
group by dept.department_name
having sum(emp.salary)>(
select sum(dept_total)/count(*) from (
select sum(emp.salary) dept_total
from tbl_employees emp
inner join tbl_departments dept 
on emp.department_id = dept.department_id
group by dept.department_name) tbl) ;

with dept_salary as (
select department_name, sum(salary) dept_total from tbl_employees emp
inner join tbl_departments dept 
on emp.department_id = dept.department_id 
group by department_name), 
avg_salary as (select sum(dept_total)/count(*) as dept_avg
from dept_salary)
select * from dept_salary 
where dept_total>(select dept_avg from avg_salary);