create table NASD_DEPARTMENTS(
    department_id   number(6, 0) primary key
  , department_name varchar2(30) not null
);

insert into NASD_DEPARTMENTS values ( 10, 'Administration');
insert into NASD_DEPARTMENTS values ( 20, 'Marketing');
insert into NASD_DEPARTMENTS values ( 30, 'Purchasing');
insert into NASD_DEPARTMENTS values ( 40, 'Human Resources');
insert into NASD_DEPARTMENTS values ( 50, 'Shipping');
insert into NASD_DEPARTMENTS values ( 60, 'IT');
insert into NASD_DEPARTMENTS values ( 70, 'Public Relations');
insert into NASD_DEPARTMENTS values ( 80, 'Sales');
insert into NASD_DEPARTMENTS values ( 90, 'Executive');
insert into NASD_DEPARTMENTS values (100, 'Finance');
insert into NASD_DEPARTMENTS values (110, 'Accounting');
commit;

create table NASD_EMPLOYEES(
    employee_id     number(6, 0) primary key
  , first_name      varchar2(10)
  , last_name       varchar2(10)
  , department_id   number(6, 0)
);

insert into NASD_EMPLOYEES values ( 10, 'Alexander', 'Khoo',     10);
insert into NASD_EMPLOYEES values ( 20, 'Neena',     'Khochar',  10);
insert into NASD_EMPLOYEES values ( 30, 'Adam',      'Fripp',    20);
insert into NASD_EMPLOYEES values ( 40, 'Den',       'Raphaely', 30);
insert into NASD_EMPLOYEES values ( 50, 'Steven',    'King',     30);
insert into NASD_EMPLOYEES values ( 60, 'Bruce',     'Ernst',    40);
insert into NASD_EMPLOYEES values ( 70, 'Matthew',   'Weiss',    50);
insert into NASD_EMPLOYEES values ( 80, 'Lex',       'De Haan',  50);
insert into NASD_EMPLOYEES values ( 90, 'Alexander', 'Hunold',   60);
insert into NASD_EMPLOYEES values (100, 'Kimberly',  'Grant',  null);
commit;

Run Code in LiveSQL (note: some quiz code may not execute in LiveSQL, which is restricted to a single schema)
/* Verification Script for Question 10242, played in Select from SQL */

/* START-SETUP Code to create all objects used in quiz */


create table NASD_departments(
    department_id   number(6, 0) primary key
  , department_name varchar2(30) not null
);

insert into NASD_departments values ( 10, 'Administration');
insert into NASD_departments values ( 20, 'Marketing');
insert into NASD_departments values ( 30, 'Purchasing');
insert into NASD_departments values ( 40, 'Human Resources');
insert into NASD_departments values ( 50, 'Shipping');
insert into NASD_departments values ( 60, 'IT');
insert into NASD_departments values ( 70, 'Public Relations');
insert into NASD_departments values ( 80, 'Sales');
insert into NASD_departments values ( 90, 'Executive');
insert into NASD_departments values (100, 'Finance');
insert into NASD_departments values (110, 'Accounting');
commit;

create table NASD_employees(
    employee_id     number(6, 0) primary key
  , first_name      varchar2(10)
  , last_name       varchar2(10)
  , department_id   number(6, 0)
);

insert into NASD_employees values ( 10, 'Alexander', 'Khoo',     10);
insert into NASD_employees values ( 20, 'Neena',     'Khochar',  10);
insert into NASD_employees values ( 30, 'Adam',      'Fripp',    20);
insert into NASD_employees values ( 40, 'Den',       'Raphaely', 30);
insert into NASD_employees values ( 50, 'Steven',    'King',     30);
insert into NASD_employees values ( 60, 'Bruce',     'Ernst',    40);
insert into NASD_employees values ( 70, 'Matthew',   'Weiss',    50);
insert into NASD_employees values ( 80, 'Lex',       'De Haan',  50);
insert into NASD_employees values ( 90, 'Alexander', 'Hunold',   60);
insert into NASD_employees values (100, 'Kimberly',  'Grant',  null);
commit;


/* END-SETUP*/

/* START-PRIVATESETUP Verification-only setup code */


set autotrace on explain


/* END-PRIVATESETUP*/

/* START-CHOICE 1 INCORRECT */
PROMPT Choice 1 INCORRECT

select dept.department_name
from NASD_departments dept
where dept.department_id not in
   (select emp.department_id from NASD_employees emp )
order by department_name;

/* END-CHOICE*/

/* START-CHOICE 2 CORRECT */
PROMPT Choice 2 CORRECT

select dept.department_name
from NASD_departments dept
where not exists
   (select null from NASD_employees emp
    where emp.department_id = dept.department_id)
order by department_name;

/* END-CHOICE*/

/* START-CHOICE 3 INCORRECT */
PROMPT Choice 3 INCORRECT

select dept.department_name
from NASD_departments dept
where dept.department_id !=ANY
   (select emp.department_id from NASD_employees emp)
order by department_name;

/* END-CHOICE*/

/* START-CHOICE 4 CORRECT */
PROMPT Choice 4 CORRECT

select dept.department_name
from NASD_departments dept
where dept.department_id not in
   (select nvl(emp.department_id, -1) from NASD_employees emp)
order by department_name;

/* END-CHOICE*/

/* START-CHOICE 5 CORRECT */
PROMPT Choice 5 CORRECT

select dept.department_name
from NASD_departments dept
where dept.department_id not in
   (select emp.department_id from NASD_employees emp
    where emp.department_id is not null)
order by department_name;

/* END-CHOICE*/

/* START-CHOICE 6 CORRECT */
PROMPT Choice 6 CORRECT

select dept.department_name
from NASD_departments dept
where dept.department_id in
   (select department_id from NASD_departments
    minus
    select department_id from NASD_employees)
order by department_name;

/* END-CHOICE*/

/* START-CHOICE 7 CORRECT */
PROMPT Choice 7 CORRECT

select dept.department_name
from NASD_departments dept left outer join NASD_employees emp
on dept.department_id = emp.department_id
where emp.department_id is null
order by department_name;

/* END-CHOICE*/

/* START-CHOICE 8 INCORRECT */
PROMPT Choice 8 INCORRECT

select dept.department_name
from NASD_departments dept left outer join NASD_employees emp
on dept.department_id = emp.department_id
where emp.department_id is not null
order by department_name;

/* END-CHOICE*/

/* START-CHOICE 9 CORRECT */
PROMPT Choice 9 CORRECT

select dept.department_name
from NASD_departments dept, NASD_employees emp
where dept.department_id = emp.department_id (+)
and emp.department_id is null
order by department_name;

/* END-CHOICE*/

/* START-CHOICE 10 INCORRECT */
PROMPT Choice 10 INCORRECT

select dept.department_name
from NASD_departments dept, NASD_employees emp
where emp.department_id = dept.department_id (+)
and dept.department_id is null
order by department_name;



/* END-CHOICE*/

/* START-CLEANUP Code to remove all objects created for quiz */


set autotrace off

drop table NASD_departments;

drop table NASD_employees;

/* END-CLEANUP*/