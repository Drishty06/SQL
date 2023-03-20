-- Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
select FIRST_NAME from Worker as WORKER_NAME;

-- Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
select upper(FIRST_NAME) from Worker;

-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
select distinct(DEPARTMENT) from Worker;

-- Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
select substring(FIRST_NAME, 1, 3) from Worker;
-- substring function

-- Q-5. Write an SQL query to find the position of the alphabet (‘b’) in the first name column ‘Amitabh’ from Worker table.
select instr(FIRST_NAME, 'b') from Worker where FIRST_NAME = "Amitabh";
-- instr function 
-- it is case insensitive

-- Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
select rtrim(FIRST_NAME) from Worker;
-- trimming whitespaces using ltrim and rtrim

-- Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
select ltrim(FIRST_NAME) from Worker;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
select DISTINCT DEPARTMENT, length(DEPARTMENT) from Worker;

-- Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
select REPLACE(FIRST_NAME, 'a', 'A') from Worker;
-- replace 

-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME.
-- A space char should separate them.
select concat(FIRST_NAME, " ", LAST_NAME) as COMPLETE_NAME from Worker;

-- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
select * from Worker ORDER BY FIRST_NAME;	

-- Q-12. Write an SQL query to print all Worker details from the Worker table order by 
-- FIRST_NAME Ascending and DEPARTMENT Descending.
select * from Worker ORDER BY FIRST_NAME DESC;	

-- Q-13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
select * from Worker where FIRST_NAME IN ("Vipul", "Satish");

-- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
select * from Worker where FIRST_NAME NOT IN ("Vipul", "Satish");

-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin*”.
select * from Worker where DEPARTMENT LIKE "Admin%";
-- wildcard character "5" is used to replace any number of any character

-- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
select * from Worker where FIRST_NAME LIKE "%a%";

-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
select * from Worker where FIRST_NAME LIKE "%a";

-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
select * from Worker where FIRST_NAME LIKE "_____h";
-- using wildcard character "_" which is used for a character with frequency 1

-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
select * from Worker 
where SALARY > 100000 AND SALARY < 500000;

-- Q-20. Write an SQL query to print details of the Workers who have joined in Feb’2014.
select * from Worker 
where year(JOINING_DATE) = 2014 AND month(JOINING_DATE) = 02;

-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
select department, count(WORKER_ID) from Worker group by department HAVING department = "Admin";
-- where cannot be used with group by
-- another way  
select department, count(*) from Worker 
where department = "Admin";

-- Q-22. Write an SQL query to fetch worker full names with salaries >= 50000 and <= 100000.
select concat(first_name, " ", last_name) as full_name from Worker 
where SALARY >= 50000 AND SALARY <= 100000;

-- Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.
select department, count(*) from Worker 
group by department 
ORDER BY count(*) DESC;

-- Q-24. Write an SQL query to print details of the Workers who are also Managers.
select w.* from Worker w
inner Join Title t
on w.WORKER_ID = t.WORKER_REF_ID
where WORKER_TITLE = "Manager";

-- Q-25. Write an SQL query to fetch number (more than 1) of same titles in the ORG of different types.
select WORKER_TITLE, count(*) 
from Title
group by WORKER_TITLE
having count(*) > 1;
-- where cannot be used with group by 

-- Q-26. Write an SQL query to show only odd rows from a table.
select * from Worker where MOD (WORKER_ID, 2) != 0; 
-- select * from Worker where MOD (WORKER_ID, 2) <> 0;  

-- Q-27. Write an SQL query to show only even rows from a table. 
select * from Worker where MOD (WORKER_ID, 2) = 0; 

-- Q-28. Write an SQL query to clone a new table from another table.
create table worker_clone like Worker;
insert into worker_clone select * from Worker;
select * from worker_clone;
-- cloning a table 

-- Q-29. Write an SQL query to fetch intersecting records of two tables.
select w1.* from Worker w1 inner join worker_clone w2 on w1.WORKER_ID = w2.WORKER_ID;

-- Q-30. Write an SQL query to show records from one table that another table does not have.
-- MINUS
select w1.* from Worker w1 inner join worker_clone w2 on w1.WORKER_ID = w2.WORKER_ID where w2.WORKER_ID = NULL;

-- Q-31. Write an SQL query to show the current date and time.
-- DUAL
select curdate();
select now();

-- Q-32. Write an SQL query to show the top n (say 5) records of a table order by descending salary.
select * from Worker order by salary DESC limit 5;

-- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
select * from Worker order by salary DESC limit 4,1; 

-- Q-34. Write an SQL query to determine the 5th highest salary without using LIMIT keyword.
select * from Worker w1 
where 4 = (select count(distinct w2.salary) 
		   from Worker w2 
           where w1.salary <= w2.salary);
           
-- https://www.youtube.com/watch?v=fh4yBn0oTaM 
-- must do 
-- correlated  sub query 
 
-- Q-35. Write an SQL query to fetch the list of employees with the same salary.
select * from Worker w1, Worker w2
where w1.salary = w2.salary and w1.worker_id != w2.worker_id;

-- Q-36. Write an SQL query to show the second highest salary from a table using sub-query.
select MAX(salary) from Worker
where salary not in (select max(salary) from Worker);

-- Q-37. Write an SQL query to show one row twice in results from a table.
select * from Worker
UNION ALL
select * from Worker;

-- Q-38. Write an SQL query to list worker_id who does not get bonus.
select worker_id from Worker
where worker_id not in (select WORKER_REF_ID from Bonus);

-- Q-39. Write an SQL query to fetch the first 50% records from a table.
select * from Worker 
where worker_id <= (select count(*)/2 from Worker);

-- Q-40. Write an SQL query to fetch the departments that have less than 4 people in it.
select department, count(worker_id) from Worker
group by department
having count(worker_id) < 4;

-- Q-41. Write an SQL query to show all departments along with the number of people in there.
select department, count(worker_id) from Worker
group by department;

-- Q-42. Write an SQL query to show the last record from a table.
select * from Worker
where worker_id = (select max(worker_id) from Worker);

-- Q-43. Write an SQL query to fetch the first row of a table.
select * from Worker
where worker_id = (select min(worker_id) from Worker);

-- Q-44. Write an SQL query to fetch the last five records from a table.
select * from Worker 
where worker_id > (select count(*)/2 from Worker);
-- alternative
(select * from Worker
order by Worker_id desc limit 5) order by Worker_id; 

-- Q-45. Write an SQL query to print the name of employees having the highest salary in each department.
-- select department, max(salary) from Worker
-- group by department;
-- the above mentioned lines won't give the answer if there is more than one person having max salary
select first_name, last_name, salary from
(select DEPARTMENT, max(salary) as maxSalary from Worker group by department) temp
inner join Worker w on temp.department = w.department and temp.maxSalary = w.salary;

-- Q-46. Write an SQL query to fetch three max salaries from a table using co-related subquery
-- DRY RUN AFTER REVISING THE CORELATED SUBQUERY CONCEPT FROM LEC-9.
select * from Worker w1
where 2 >= (select count(distinct salary) from Worker w2 
			where w1.salary <= w2.salary)
order by w1.salary desc;

-- OR 
select distinct salary from Worker 
order by salary desc
limit 3;

-- Q-47. Write an SQL query to fetch three min salaries from a table using co-related subquery
select * from Worker w1
where 2 >= (select count(distinct salary) from Worker w2 
			where w1.salary >= w2.salary);

-- Q-48. Write an SQL query to fetch nth max salaries from a table.
select * from Worker w1
where n - 1 >= (select count(distinct salary) from Worker w2 
			where w1.salary < w2.salary);

-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
select department, sum(salary) as deptSalary
from Worker
group by department;

-- Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
select concat(first_name, " ", last_name), salary as full_name
from Worker
where salary = (select max(salary) from Worker);
