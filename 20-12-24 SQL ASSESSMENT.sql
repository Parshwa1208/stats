create database try;
use try;

Create table employees(
Employee_id int auto_increment primary key,
name varchar(100),position varchar(150), salary decimal(10,2), hire_date date);

create table employee_audit(
audit_id int auto_increment primary key, employee_id int, name varchar(100), position varchar(100), salary decimal(10,2), hire_date 
date, action_date timestamp default current_timestamp
 );
 
 insert into employees(name, position, salary, hire_date)
 values('John doe', 'software engineering',80000, '2022-01-15'),
 ('Jane smith','project manager',90000,'2021-05-22'),
 ('Alice johnson','UX designer', 75000,'2023-03-01');
 
 select * from employees;
 
 
 DELIMITER //
CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (employee_id, name, position, salary, hire_date)
    VALUES (NEW.Employee_id, NEW.name, NEW.position, NEW.salary, NEW.hire_date);
END;
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE AddNewEmployees (
    IN emp_name VARCHAR(100),
    IN emp_position VARCHAR(100),
    IN emp_salary DECIMAL(10, 2),
    IN emp_hire_date DATE
)
BEGIN
    DECLARE new_emp_id INT;
    
    -- Insert the new employee into the employees table
    INSERT INTO employees (name, position, salary, hire_date)
    VALUES (emp_name, emp_position, emp_salary, emp_hire_date);
    
    -- Get the auto-generated Employee_id of the newly inserted employee
    SET new_emp_id = LAST_INSERT_ID();
    
    -- Insert a corresponding record into the employee_audit table
    INSERT INTO employee_audit (employee_id, name, position, salary, hire_date)
    VALUES (new_emp_id, emp_name, emp_position, emp_salary, emp_hire_date);
END$$

DELIMITER ;

CALL AddNewEmployee('Prahwa Shah', 'CBI', 68000.00, '2024-12-19');

-- verifying the result.
select * from employees;
select * from employee_audit;




