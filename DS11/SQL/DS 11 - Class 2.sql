use thescholar;

drop table employees;
create table employees 
(eid int primary key,
ename varchar(10),
deptid int,
salary int,
foreign key (deptid) references departments(deptid)
);

drop table departments;
delete from departments;
create table departments
(deptid int primary key,
department_name varchar(10)
);


select * from employees;



select * from departments;


update employees 
set deptid=40
where deptid is null;

delete from departments where deptid = 10;

insert into employees values (1,'A',10,1000), 
(2,'B',20,1500), 
(3,'C',20,1250), 
(4,'D',20,1300), 
(5,'E',30,1400), 
(6,'F',NULL,1500), 
(7,'G',NULL,1300); 

delete from departments;
insert into departments values (10,'HR'),(20,'IT'),(30,'Sales'),(40,'Marketing');

insert into departments values (10,'Fin');


delete from employees where deptid=30;


/*
Primary Key
1) Should be unique
2) Should not contain null values 
3) Only single primary key in a table

Foreign key
1) Can be null 
2) It is referring to other table's PK i.e. if the value is not present in the PK we cannot insert that value 
in the FK 
3) Lets delete sales department 
*/

delete from departments where deptid=30;



drop table employees;
create table employees 
(eid int primary key,
ename varchar(10) not null,
email varchar(10) unique,
deptid int,
salary int,
check(salary>0),
city varchar(10) default 'Delhi',
foreign key (deptid) references departments(deptid)
);

select * from employees;

insert into employees values (1,'A','A@gmail',10,1000), 
(2,'B','B@gmail',20,1500), 
(3,'C','C@gmail',20,1250), 
(4,'D','D@gmail',20,1300), 
(5,'E','E@gmail',30,1400), 
(6,'F','F@gmail',NULL,1500), 
(7,'G','G@gmail',NULL,1); 

desc employees;

desc departments;

insert into employees (eid,ename,email,deptid,salary) values (1,'A','a@gmail',10,1000);
