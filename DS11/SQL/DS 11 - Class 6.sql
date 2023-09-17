use hrdb;

select * from tbl_employees;
select * from tbl_departments;

select ceiling(25.05);
select floor(25.95);

select greatest(10,100,1000,1);

select least(10,100,1000,1);


select round(25.777,2);

select mod(20,5);

select power(10,3);

select sqrt(100);



select sqrt(salary) from tbl_employees;


select first_name, hire_date, adddate(hire_date, interval 3 year) probation_period,
date_add(hire_date, interval 3 year) 
from tbl_employees;


select curdate();


select first_name,
hire_date, 
adddate(hire_date, interval 3 year) probation_period,
curdate(),
(curdate() - hire_date) duration,
datediff(curdate(), hire_date)/365 duration1
from tbl_employees;


select hire_date,extract(year from hire_date),
last_day(hire_date),month(hire_date),year(hire_date),day(hire_date),
quarter(hire_date),monthname(hire_date),dayname(hire_date),
now()
  from tbl_employees;
  
  
  select period_add(hire_date,3) from tbl_employees;
select period_add(202308,-3);
select period_add(2308,-3);

select period_diff(202306,202304);


select hire_date,extract(year from hire_date),
last_day(hire_date),month(hire_date),year(hire_date),day(hire_date),
quarter(hire_date),monthname(hire_date),dayname(hire_date),
now(), weekofyear(hire_date),weekday(hire_date)
  from tbl_employees;

select sysdate();

select commission_pct, ifnull(commission_pct,0) from tbl_employees;
select * from (
select first_name, last_name, length(first_name), length(last_name),
nullif(length(first_name), length(last_name)) output
from tbl_employees) tbl
where output is not null;



select coalesce(null,null,150,null,"No attempt");
select coalesce(150,null,130,null,"No attempt");
select coalesce(null,null,130,150,"No attempt");
select coalesce(50,120,130,150,"No attempt");
select coalesce(null,null,null,null,"No attempt");

select coalesce(null,100,null,null,1);

select coalesce(null,null,null,null,1,200);



select current_user();

select user();


select version();