use hrdb;
select * from tbl_employees;

select first_name, char_length(first_name),character_length(first_name) from tbl_employees;

desc tbl_employees;
set sql_safe_updates = 0;
update tbl_employees 
set first_name= 'Steven'
where employee_id = 100;

/*Char_Length/Character_length - It give the number of characters in the string
If the value is null it will give null as an output*/


select first_name, last_name, concat(first_name,' ',last_name) name 
from tbl_employees;


select first_name, last_name, concat_ws(',',first_name,last_name,job_id) name 
from tbl_employees;

/*With Seperator*/

select * from tbl_employees;

select insert("Rahul Tiwari", 7,6,"Dravid");

/*www.theschnor.com*/

select instr("www.thescholar.com", 'h');
select * from tbl_employees;

select first_name, instr(first_name, 's') from tbl_employees;

select instr("Rahul Tiwari", "Tiwari");

select  lcase(first_name),lower(first_name) from tbl_employees;



select first_name, last_name, 
concat(left(first_name,1), left(last_name,1)) 
from tbl_employees;
Neena
Neena     
select rtrim(rpad(first_name,10,' ')) from tbl_employees;

select first_name, mid(first_name, 3,5) from tbl_employees;


select position("com" in "www.thescholar.com");


select repeat(first_name, 3) from tbl_employees;


select first_name, replace(first_name, "Steven","Stephen"),
reverse(first_name),upper(right(first_name,3)),
ucase(first_name) from 
tbl_employees;

select 
first_name,
last_name,
strcmp(first_name, last_name) from tbl_employees;

when ur strings are same - 0 
when s>k = +1 (s1>s2)
when a<h = -1 (s1<s2)


select instr("www.thescholar.com", "com");

select trim('    Rahul      ') ;

Rahul

select first_name, substr(first_name, 2,5), mid(first_name,2,5),
substring(first_name, 2,5) from tbl_employees;

select first_name, substr(first_name, 2), mid(first_name,2),
substring(first_name, 2) from tbl_employees;


select substring_index("www.thescholar.com", ".", 2);

select substring_index("a.b.c.d.e.f.g.h.i.j.k.l.m", ".", 6);

