/*THIS IS THE HOP2 TRANSFORMATION AREA, WHERE WE ARE GOING TO ADD NEW COLUMNS IN THE TABLE 
BASED ON THE REQUIREMENTS DATA*/
USE HRDB;
DROP TABLE TBL_TRANS_EMPLOYEES_HOP2;
CREATE TABLE TBL_TRANS_EMPLOYEES_HOP2
(
EMPLOYEE_ID INT,
EMPLOYEE_NAME VARCHAR(50),
EMAIL VARCHAR(50),
PHONE_NUMBER VARCHAR(13),
HIRE_DATE DATE,
JOB_ID VARCHAR(10),
SALARY DECIMAL(10,2),
COMMISSION_PCT DECIMAL(3,2),
MONTHLY_SALARY DECIMAL(10,2),
SALARY_CATEGORY VARCHAR(20),
MANAGER_ID INT,
DEPARTMENT_ID INT
);
