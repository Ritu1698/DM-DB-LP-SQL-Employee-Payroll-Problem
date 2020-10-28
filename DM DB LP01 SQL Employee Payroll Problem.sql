#UC1

create database payroll_service;
show databases;
use payroll_service;
select database();

#UC2

create table employee_payroll(
    -> id int unsigned not null auto_increment,
    -> name varchar(150) not null,
    -> salary double not null,
    -> start date not null,
    -> primary key (id)
    -> );
 desc employee_payroll;

#UC3

insert into employee_payroll(name, salary, start) values
    -> ('Bill', 1000000.00, '2018-01-03'),
    -> ('Terisa', 2000000.00, '2019-11-13'),
    -> ('Charlie', 3000000.00, '2020-05-21');

#UC4

select * from employee_payroll;

#UC5

select salary from employee_payroll where name = 'Bill';
select name from employee_payroll where start between cast('2018-01-01' as date) and date(now());
 alter table employee_payroll add gender char(1) after name;

#UC6

update employee_payroll set gender = 'M' where name ='Bill' or name = 'Charlie';
update employee_payroll set gender = 'F' where name ='Terisa' ;
 select * from employee_payroll;
 update employee_payroll set salary = 3000000.00 where name ='Terisa' ;
 select * from employee_payroll;

#UC7

select avg(salary) from employee_payroll where gender = 'M' group by gender;
select gender, avg(salary) from employee_payroll group by gender;
select gender, count(name) from employee_payroll group by gender;
select gender, sum(salary) from employee_payroll group by gender;

#UC8

alter table employee_payroll add phone_number varchar(250) after name;
alter table employee_payroll add address varchar(250) after phone_number;
alter table employee_payroll add department varchar(250) not null after address;
alter table employee_payroll alter address set default 'TBD';
alter table employee_payroll rename column salary to basic_pay;

#UC9

alter table employee_payroll add deductions double not null after basic_pay;
alter table employee_payroll add taxable_pay double not null after deductions;
alter table employee_payroll add tax double not null after taxable_pay;
alter table employee_payroll add net_pay double not null after tax;
update employee_payroll set department = 'Sales'where name = 'Terisa';

#UC10

insert into employee_payroll (name, departmant, gender, basic_pay, deduction, taxable_pay, tax, net_pay, start) values ('Terisa', 'Marketing', 'F', 3000000.00, 1000000.00, 2000000.00, 5000000.00, 15000000.00, '2018-01-03');

#UC11

create table employee
    -> (
    -> employee_id INT unsigned not null auto_increment,
    -> name varchar(150) not null,
    -> phone_number varchar(250),
    -> address varchar(250) default 'TBD',
    -> gender char(1) not null,
    -> start date not null,
    -> primary key(employee_id)
    -> );
create table payroll
    -> (
    -> payroll_id int unsigned not null auto_increment,
    -> employee_id int unsigned not null references employee(employee_id),
    -> basic_pay double not null,
    -> deductions double not null,
    -> taxable_pay double not null,
    -> tax double not null,
    -> net_pay double not null,
    -> primary key(payroll_id)
    -> );
create table department
    -> (
    -> department_id int unsigned not null,
    -> department_name varchar(250) not null,
    -> employee_id int not null references employee(employee_id),
    -> primary key(department_id,employee_id)
    -> );
create table company
    -> (
    -> company_id int unsigned not null,
    -> company_name varchar(150) not null,
    -> employee_id int not null references employee(employee_id),
    -> primary key(company_id, employee_id)
    -> );
desc company;
desc employee;
desc payroll;
desc department;
 insert into employee(name,phone_number,address,gender,start) values
    -> ('Bill','1234567890','California','M','2018-01-03'),
    -> ('Terisa','4567890123','Dubai','F','2019-11-13'),
    -> ('Charlie','7890123456','NY','M','2020-05-21');
select * from employee;
 insert into payroll(employee_id,basic_pay,deductions,taxable_pay,tax,net_pay) values
    -> (1,3000000.00,1000000.00,2000000.00,500000.00,1500000.00),
    -> (2,5000000.00,2000000.00,3000000.00,400000.00,2600000.00),
    -> (3,4000000.00,1500000.00,3500000.00,100000.00,2500000.00);
select * from payroll;
insert into department(employee_id,department_name, department_id) values
    -> (1,'HR', 1),
    -> (2,'Engineering', 2),
	-> (2,'HR', 1),
    -> (3,'Engineering', 2);
select * from department;
 insert into company(employee_id,company_name, company_id) values
    -> (1,'Capgemini', 1),
    -> (2,'Bridgelabz', 2),
    -> (3,'Capgemini', 1);
select * from company;

#UC12

select employee.name,payroll.basic_pay from employee join payroll on employee.employee_id=payroll.employee_id;
select employee.gender,sum(payroll.basic_pay) from employee join payroll on employee.employee_id=payroll.employee_id group by employee.gender;