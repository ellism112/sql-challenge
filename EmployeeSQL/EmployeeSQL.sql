CREATE TABLE departments (
	dept_no VARCHAR(4) PRIMARY KEY,
	dept_name VARCHAR(20)
);

CREATE TABLE titles (
	title_id VARCHAR(5) PRIMARY KEY,
	title VARCHAR(30)
);

CREATE TABLE employees (
	emp_no INTEGER PRIMARY KEY,
	emp_title_id VARCHAR(5),
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id),
	birth_date DATE,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	sex VARCHAR(1),
	hire_date DATE
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INTEGER,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_emp (
	emp_no INTEGER,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(4),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE salaries (
	emp_no INTEGER,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INTEGER
);

SELECT * FROM departments;
SELECT * FROM titles; 
SELECT * FROM employees; 
SELECT * FROM dep_manager; 
SELECT * FROM dep_emp; 
SELECT * FROM salaries; 

SELECT salaries.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries
ON salaries.emp_no = employees.emp_no
ORDER BY salaries.emp_no;

SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE EXTRACT(year FROM hire_date) = 1986;

SELECT distinct on (dept_manager.dept_no) dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager 
INNER JOIN departments 
ON dept_manager.dept_no= departments.dept_no
INNER JOIN employees 
ON dept_manager.emp_no = employees.emp_no
ORDER BY dept_manager.dept_no DESC; 

SELECT distinct on (employees.emp_no) employees.emp_no, employees.last_name, employees.first_name, departments.dept_no, departments.dept_name
FROM employees
LEFT JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON dept_emp.dept_no = departments.dept_no
ORDER BY employees.emp_no DESC;

SELECT employees.last_name, employees.first_name, employees.sex
FROM employees
WHERE (employees.first_name = 'Hercules') and (lower(employees.last_name)like 'b%' )
ORDER BY employees.last_name;

SELECT distinct on (emp_no) *
INTO dept_emp_comb
FROM dept_emp
ORDER BY emp_no DESC;

SELECT employees.emp_no, employees.last_name, employees.first_name
FROM employees
inner join dept_emp_comb
on employees.emp_no = dept_emp_comb.emp_no
inner join departments
on dept_emp_comb.dept_no = departments.dept_no 
where lower(departments.dept_name) = 'Sales';

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp_comb
ON dept_emp_comb.emp_no = employees.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp_comb.dept_no
WHERE (lower(departments.dept_name) = 'Sales') or (lower(departments.dept_name)= 'Development');

SELECT last_name,COUNT(last_name) AS Frequency 
FROM employees 
GROUP BY last_name
ORDER BY frequency DESC;