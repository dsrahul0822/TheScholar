create database thescholar;
use thescholar;
drop table students;
create table students
(sid int,
sname varchar(10),
sage int,
sloc varchar(250),
sfee int
);

select * from students;

/*create - DDL (data definition language)
Drop - DDL (data definition language)
Alter - DDL */ 

alter table students add column ssalary int;



select * from students;

/*insert  - DML (Data manipulation language)
Delete
Update*/

insert into students values (1,'A',23,'India',1000,2000);


select * from students;

update students 
set ssalary=3000
where sid=1;



set sql_safe_updates = 0;
delete from students where sid=1;


12:19:24	delete from students where sid=1	
Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.000 sec


