use hrdb;
select avg(salary) from tbl_employees;

select abs(-10);

select job_id, avg(salary),count(job_id) from tbl_employees
group by job_id;


select * from tbl_departments;



select department_name, avg(salary) avg_sal,count(*) cnt 
from tbl_employees emp inner join tbl_departments dept
on emp.department_id = dept.department_id
group by department_name
order by avg_sal asc;



select * from tbl_employees;

(salary + (Salary * commission))*12 = Yearly salary 
when the commission is null make it 0 

select salary, 
ifnull(commission_pct,0)*salary,
(salary+(salary * ifnull(commission_pct,0)))*12 yearly_salary from tbl_employees
order by yearly_salary;


25000 -350000

salary >=25000 <=100000 - "Low salary"
salary>100000 <=200000 - "Avg Salary" 
salary>200000 - "Good Salary"

select * from (
select salary, 
ifnull(commission_pct,0)*salary,
(salary+(salary * ifnull(commission_pct,0)))*12 yearly_salary,
case 
	when (salary+(salary * ifnull(commission_pct,0)))*12 >25000 and 
    (salary+(salary * ifnull(commission_pct,0)))*12<=100000 then "Low Salary"
    when (salary+(salary * ifnull(commission_pct,0)))*12 >100000 and
    (salary+(salary * ifnull(commission_pct,0)))*12 <=200000 then "Avg Salary"
    when (salary+(salary * ifnull(commission_pct,0)))*12 >200000 and
    (salary+(salary * ifnull(commission_pct,0)))*12 <=340000 then "Good Salary"
    else "High Salary"
end SalaryCategory
    from tbl_employees) tbl;
    
    
    
    
select * from (
select 
name,
job_id,
department_name, 
salary, 
commission,
case 
when yearly_salary>25000 and yearly_salary<=100000 then "Low Salary"
when yearly_salary>100000 and yearly_salary<=200000 then "Avg Salary"
when yearly_salary>200000 and yearly_salary<=300000 then "Good Salary"
else "High Salary"
end salary_category
 from (
select concat(first_name,' ', last_name) name, job_id, department_name, salary, ifnull(commission_pct,0) commission,
(salary + (salary * ifnull(commission_pct,0)))*12 yearly_salary
from tbl_employees emp inner join 
tbl_departments dept
on emp.department_id = dept.department_id) tbl)tbl1
where salary_category='High Salary';
    



