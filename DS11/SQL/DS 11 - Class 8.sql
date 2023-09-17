use hrdb;

/*60,80,90*/

select * from tbl_employees;

select * from tbl_departments;

/*First Query*/
select * from tbl_employees emp 
inner join tbl_departments dept 
on emp.department_id = dept.department_id 
where dept.department_name in ('IT','Executive');

/*Second Query*/
select * from tbl_employees emp 
inner join (
select department_id,department_name 
from tbl_departments where department_name in ('IT','Executive')) dept
on emp.department_id = dept.department_id;

select count(*) from tbl_employees;




select * from tbl_employees emp 
inner join tbl_departments dept 
on emp.department_id = dept.department_id 
where emp.department_id in (80,60,90);


select * from tbl_departments dept
inner join (
select * from tbl_employees
where department_id in (80,90,60)) emp 
on dept.department_id=emp.department_id;

use dvd_rental;

select count(*) from (
select concat(c.first_name, ' ',c.last_name) cust_name,  ca.name film_category,
f.title from customer c 
inner join store s 
on c.store_id = s.store_id
inner join inventory i 
on s.store_id = i.store_id
inner join film f 
on f.film_id = i.film_id
inner join film_category fc 
on fc.film_id = f.film_id
inner join category ca 
on ca.category_id = fc.category_id
where ca.name in ('Sci-Fi',
'Sports',
'Travel')) tbl;
/*1659976*/







select count(*) from (
select concat(c.first_name, ' ',c.last_name) cust_name,  ca.name film_category,
f.title from customer c 
inner join store s 
on c.store_id = s.store_id
inner join inventory i 
on s.store_id = i.store_id
inner join film f 
on f.film_id = i.film_id
inner join film_category fc 
on fc.film_id = f.film_id
inner join (select * from category where name in ('Sci-Fi',
'Sports',
'Travel')) ca 
on ca.category_id = fc.category_id
) tbl;


select count(*) from category;

select count(*) from customer;
select count(*) from store;
select count(*) from inventory;
select count(*) from film;
select count(*) from film_category;
select count(*) from category;


select * from inventory;


select count(*) from (
select concat(c.first_name, ' ',c.last_name) cust_name,  ca.name film_category,
f.title from customer c 
inner join store s 
on c.store_id = s.store_id
inner join inventory i 
on s.store_id = i.store_id
inner join film f 
on f.film_id = i.film_id
inner join film_category fc 
on fc.film_id = f.film_id
inner join category ca 
on ca.category_id = fc.category_id
where i.inventory_id in (1,2,3,4,5,6,7,8,9,10)) tbl;
/*11735*/


select count(*) from (
select concat(c.first_name, ' ',c.last_name) cust_name,  ca.name film_category,
f.title from customer c 
inner join store s 
on c.store_id = s.store_id
inner join (select * from inventory where inventory_id in (1,2,3,4,5,6,7,8,9,10)) i 
on s.store_id = i.store_id
inner join film f 
on f.film_id = i.film_id
inner join film_category fc 
on fc.film_id = f.film_id
inner join category ca 
on ca.category_id = fc.category_id
) tbl;

/*11735*/

desc category;

select * from i;