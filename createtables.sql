CREATE SCHEMA IF NOT EXISTS MHS;

DROP TABLE IF EXISTS FACILITIES;
CREATE TABLE FACILITIES (
facid int primary key auto_increment,
size int,
ftype varchar(255) not null,
street varchar(255),
city varchar(100),
state varchar(100),
zip varchar(20));


DROP TABLE IF EXISTS OFFICES;
CREATE TABLE OFFICES(
facid int primary key,
office_count int,
foreign key (facid) REFERENCES FACILITIES(facid));



DROP TABLE IF EXISTS OUTPATIENT_SURGERY_ROOMS;
CREATE TABLE OUTPATIENT_SURGERY_ROOMS(
facid int primary key,
room_count int,
procedures varchar(255),
foreign key (facid) REFERENCES FACILITIES(facid));

DROP TABLE IF EXISTS EMPLOYEES;
CREATE TABLE EMPLOYEES(
empid int primary key auto_increment,
ssn varchar(9),
first_name varchar(80),
middle_name varchar(80),
last_name varchar(80),
salary int,
hire_date date,
job_class varchar(80),
facid int not null,
street varchar(255),
city varchar(100),
state varchar(100),
zip varchar(20),
foreign key (facid) REFERENCES FACILITIES(facid));

DROP TABLE IF EXISTS PHYSICIANS;
CREATE TABLE PHYSICIANS(
empid int primary key,
speciality varchar(255),
initial_board_certification_date date,
foreign key (empid) REFERENCES EMPLOYEES(empid));

DROP TABLE IF EXISTS NURSES;
CREATE TABLE NURSES(
empid int primary key,
certification varchar(255),
foreign key (empid) REFERENCES EMPLOYEES(empid));

DROP TABLE IF EXISTS HCP;
CREATE TABLE HCP(
empid int primary key,
practice_area varchar(255),
foreign key (empid) REFERENCES EMPLOYEES(empid));

DROP TABLE IF EXISTS ADMIN_STAFF;
CREATE TABLE ADMIN_STAFF(
empid int primary key,
job_type varchar(255),
foreign key (empid) REFERENCES EMPLOYEES(empid));

DROP TABLE IF EXISTS EMPLOYEE_FACILITIES;
CREATE TABLE EMPLOYEE_FACILITIES(
empid int, 
facid int,
primary key(empid,facid),
foreign key (empid) REFERENCES EMPLOYEES(empid),
foreign key (facid) REFERENCES FACILITIES(facid));

DROP TABLE IF EXISTS INSURANCE_COMPANIES;
CREATE TABLE INSURANCE_COMPANIES(
ins_id int primary key auto_increment,
company varchar(255),
street varchar(255),
city varchar(100),
state varchar(100),
zip varchar(20));


DROP TABLE IF EXISTS PATIENTS;
CREATE TABLE PATIENTS(
pid int primary key auto_increment,
first_name varchar(80),
middle_name varchar(80),
last_name varchar(80),
street varchar(255),
city varchar(100),
state varchar(100),
zip varchar(20),
primary_physician_id int not null,
ins_id int not null,
foreign key (primary_physician_id) REFERENCES PHYSICIANS (empid),
foreign key (ins_id) REFERENCES INSURANCE_COMPANIES (ins_id));


DROP TABLE IF EXISTS APPOINTMENTS;
CREATE TABLE APPOINTMENTS(
appt_id int primary key auto_increment,
appt_date_time datetime not null,
appt_description varchar(255),
patient_id int not null,
physician_id int not null,
facid int not null,
foreign key (patient_id) REFERENCES PATIENTS(pid),
foreign key (physician_id) REFERENCES PHYSICIANS (empid),
foreign key (facid) references EMPLOYEE_FACILITIES(facid));


DROP TABLE IF EXISTS INVOICES;
CREATE TABLE INVOICES(
inv_id int primary key auto_increment,
inv_date date,
amount decimal(10, 2),
appt_id int,
foreign key (appt_id) references APPOINTMENTS(appt_id));

