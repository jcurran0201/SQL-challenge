-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);  
CREATE TABLE employees (   emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
); 
CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
); 
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);  
CREATE TABLE dept_emp(
emp_no INT NOT NULL, 
dept_no VARCHAR(4) NOT NULL,
from_date DATE NOT NULL, 
to_date DATE NOT NULL, 
FOREIGN KEY (emp_no) REFERENCES employees (emp_no), 
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
PRIMARY KEY (emp_no, dept_no)
);  
CREATE TABLE titles( 
emp_no INT NOT NULL,
title VARCHAR NOT NULL,   
from_date DATE NOT NULL, 
to_date DATE NOT NULL, 
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),  
PRIMARY KEY (emp_no, from_date)  
); 
-- Shows the tables here 
Select * From departments; 
Select * From employees;
Select * From dept_manager; 
Select * From salaries;  
Select * From dept_emp; 
Select * from titles;   
Select * from retirement_titles 
Select * from unique_titles
-- Retirement title table 
select titles.emp_no, first_name, last_name, title, from_date, to_date
INTO retirement_titles
FROM titles  
INNER Join employees 
ON employees.emp_no = titles.emp_no 
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31' 
ORDER BY emp_no 
;
-- Unique titles table count = 72458
select distinct emp_no, first_name,  
last_name, title   
INTO Unique_titles
FROM retirement_titles   
WHERE to_date = ('9999-01-01') 
ORDER BY emp_no 
;
-- retiring_titles 
SELECT COUNT(*),title 
INTO reitring_titles
from unique_titles 
GROUP BY title 
ORDER BY  count DESC;
-- Mentorship Eligibility table  
select distinct on (employees.emp_no) 
employees.emp_no,
first_name, last_name, birth_date, dept_emp.from_date, 
dept_emp.to_date, titles.title
INTO Mentorship_Eligibility
from employees
inner JOIN dept_emp 
ON employees.emp_no = dept_emp.emp_no  
inner join titles
on employees.emp_no = titles.emp_no 
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')  
AND (dept_emp.to_date Between '9999-01-01' and '9999-01-01')
ORDER BY emp_no;
