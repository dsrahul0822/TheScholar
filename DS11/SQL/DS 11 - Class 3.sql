use thescholar;

create table employees 
(eid int,
ename varchar(10),
esalary int, 
did int 
);

create table departments
(did int,
department_name varchar(10),
dept_phno int
);



insert into employees values (1,'John',10000,10),
(2,'Gomez',5000,10),
(3,'Lexi',2000,20),
(4,'Andrew',45000,20),
(5,'James',50000,30);

insert into employees values (6,'Rahul',4000, NULL);





select * from employees;


insert into departments values (10,'IT',111),
(20,'HR',222),
(30,'Sales',333),
(40,'Fin',444);


/*Joins - Helping us to join the tables to the get the relevant information

inner join 
left outer join 
right outer join 
full outer join





*/


select * from departments;


select * from employees emp inner join departments dept
on emp.did = dept.did;


select * from employees emp left outer join departments dept
on emp.did = dept.did;


select * from departments dept left outer join employees emp
on emp.did = dept.did;


select * from employees emp left outer join departments dept
on emp.did = dept.did;

select * from departments dept right outer join employees emp
on emp.did = dept.did;


select * from departments dept left outer join employees emp
on emp.did = dept.did;

select * from employees emp left outer join departments dept
on emp.did = dept.did;





select * from employees emp left outer join departments dept
on emp.did = dept.did
union  /*remove the duplicates*/
select * from employees emp right outer join departments dept
on emp.did = dept.did;
