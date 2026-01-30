-- Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
SELECT FIRST_NAME AS WORKER_NAME FROM Worker;

-- Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
SELECT ucase(FIRST_NAME) FROM Worker;

-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
SELECT DISTINCT DEPARTMENT FROM Worker;

-- Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
SELECT SUBSTR(FIRST_NAME, 1, 3) FROM Worker;

-- Q-5. Write an SQL query to find the position of the alphabet (‘b’) in the first name column ‘Amitabh’ from Worker table.
SELECT INSTR(FIRST_NAME, "B") FROM Worker WHERE FIRST_NAME = "Amitabh";

-- Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
SELECT RTRIM(FIRST_NAME) FROM Worker;

-- Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
select ltrim(FIRST_NAME) from Worker;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
SELECT DISTINCT DEPARTMENT, LENGTH(DEPARTMENT) FROM Worker;

-- Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
SELECT REPLACE(FIRST_NAME, 'a', 'A') FROM Worker;

-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME.
-- A space char should separate them.
SELECT CONCAT(first_name, ' ', last_name) as COMPLETE_NAME FROM Worker;

-- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
SELECT * FROM Worker ORDER BY FIRST_NAME;

-- Q-12. Write an SQL query to print all Worker details from the Worker table order by 
-- FIRST_NAME Ascending and DEPARTMENT Descending.
SELECT * FROM Worker ORDER BY FIRST_NAME ASC, DEPARTMENT DESC;

-- Q-13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
-- SELECT * FROM Worker WHERE FIRST_NAME = "Vipul" || FIRST_NAME = "Satish"; 			
-- OR
select * from worker where first_name IN ('Vipul', 'Satish');

-- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
select * from worker where first_name NOT IN ('Vipul', 'Satish');

-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin*”.
select * from worker where department LIKE 'Admin%';

-- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
SELECT * FROM Worker WHERE FIRST_NAME LIKE "%a%";

-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
select * from worker where first_name LIKE '%a';

-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
SELECT * FROM Worker WHERE FIRST_NAME LIKE '_____h';

-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
SELECT * FROM Worker WHERE SALARY >= 100000 AND SALARY <= 500000;
-- OR 
-- select * from worker where salary between 100000 AND 500000; 

-- Q-20. Write an SQL query to print details of the Workers who have joined in Feb’2014.
SELECT * FROM Worker WHERE JOINING_DATE >= "2014-02-01" AND JOINING_DATE < '2014-03-01';
-- OR
select * from worker where YEAR(joining_date) = 2014 AND MONTH(joining_date) = 02;


-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
SELECT DEPARTMENT, count(FIRST_NAME) FROM Worker WHERE DEPARTMENT = "Admin";
-- or
select department, count(*) from worker where department = 'Admin';

-- Q-22. Write an SQL query to fetch worker full names with salaries >= 50000 and <= 100000.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS FULL_NAME, SALARY FROM Worker WHERE SALARY >= 50000 AND SALARY <= 100000;
-- OR
select concat(first_name, ' ', last_name) from worker where salary between 50000 and 100000;
 
-- Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.
SELECT COUNT(FIRST_NAME), DEPARTMENT FROM Worker GROUP BY DEPARTMENT ORDER BY COUNT(FIRST_NAME) DESC;
-- or
select department, count(worker_id) AS no_of_worker from worker group by department ORDER BY no_of_worker desc;

-- Q-24. Write an SQL query to print details of the Workers who are also Managers.
SELECT Worker.* FROM Worker INNER JOIN Title ON Worker.WORKER_ID = Title.WORKER_REF_ID WHERE Title.WORKER_TITLE = "Manager";
--  OR
select w.* from worker as w inner join title as t on w.worker_id = t.worker_ref_id where t.worker_title = 'Manager';

-- Q-25. Write an SQL query to fetch number (more than 1) of same titles in the ORG of different types.
select worker_title, count(*) as count from title group by worker_title having count > 1;

-- Q-26. Write an SQL query to show only odd (worker_id) rows from a table.
select * from worker where MOD (WORKER_ID, 2) != 0;
-- select * from worker where MOD (WORKER_ID, 2) <> 0;

-- Q-27. Write an SQL query to show only even rows from a table.  
SELECT * FROM Worker WHERE MOD(WORKER_ID, 2) != 1;

-- Q-28. Write an SQL query to clone a new table from another table.
CREATE TABLE worker_clone LIKE worker;
INSERT INTO worker_clone select * from worker;
select * from worker_clone;

-- Q-29. Write an SQL query to fetch intersecting records of two tables. 
SELECT * 
FROM worker 
INNER JOIN Bonus 
ON worker.worker_id = Bonus.worker_ref_id;

-- Q-30. Write an SQL query to show records from one table that another table does not have.
-- MINUS
SELECT * 
FROM worker 
LEFT JOIN Bonus 
ON worker.worker_id = Bonus.worker_ref_id
where Bonus.worker_ref_id IS NULL;

-- Q-31. Write an SQL query to show the current date and time.
-- select curdate();
--  OR
select now();

-- Q-32. Write an SQL query to show the top n (say 5) records of a table order by descending salary.
SELECT FIRST_NAME, SALARY FROM Worker ORDER BY SALARY DESC LIMIT 5;
-- OR
select * from worker order by salary desc LIMIT 5;

-- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
SELECT FIRST_NAME, SALARY FROM Worker ORDER BY SALARY DESC LIMIT 1 OFFSET 4;
-- OR
select * from worker order by salary desc LIMIT 4,1;

-- Q-34. Write an SQL query to determine the 5th highest salary without using LIMIT keyword.
select first_name, salary from worker as w1
WHERE 5 = (
SELECT COUNT(DISTINCT w2.salary)
from worker w2
where w2.salary >= w1.salary
);

-- Q-35. Write an SQL query to fetch the list of employees with the same salary.
SELECT w1.FIRST_NAME, w1.SALARY 
FROM Worker as w1 
INNER JOIN Worker as w2 
ON w1.SALARY = w2.SALARY AND w1.WORKER_ID != w2.WORKER_ID;

-- Q-36. Write an SQL query to show the second highest salary from a table using sub-query.
SELECT FIRST_NAME, SALARY FROM Worker as w1
WHERE 2 = (
SELECT COUNT(DISTINCT w2.salary)
from worker as w2
where w2.salary >= w1.salary
);

-- Q-37. Write an SQL query to show one row twice in results from a table

select * from worker
UNION ALL
select * from worker 
ORDER BY worker_id;


-- Q-38. Write an SQL query to list worker_id who does not get bonus
SELECT WORKER_ID, FIRST_NAME 
FROM Worker as w 
LEFT JOIN Bonus as b 
ON w.WORKER_ID = b.WORKER_REF_ID 
WHERE b.WORKER_REF_ID IS NULL;
-- or 
select worker_id from worker where worker_id not in (select worker_ref_id from bonus);

-- Q-39. Write an SQL query to fetch the first 50% records from a table
select * from worker 
where worker_id <= ( select count(worker_id)/2 from worker);

-- Q-40. Write an SQL query to fetch the departments that have less than 4 people in it
SELECT DEPARTMENT, count(DEPARTMENT) 
FROM Worker 
GROUP BY DEPARTMENT 
HAVING COUNT(DEPARTMENT) < 4;
-- OR
select department, count(department) as depCount from worker group by department having depCount < 4;

-- Q-41. Write an SQL query to show all departments along with the number of people in there

SELECT DEPARTMENT, COUNT(DEPARTMENT)
FROM Worker
GROUP BY DEPARTMENT;
--  OR
select department, count(department) as depCount from worker group by department;

-- Q-42. Write an SQL query to show the last record from a table
SELECT * FROM WORKER WHERE WORKER_ID = (SELECT MAX(WORKER_ID) FROM Worker);

-- Q-43. Write an SQL query to fetch the first row of a table
SELECT * FROM WORKER WHERE WORKER_ID = (SELECT MIN(WORKER_ID) FROM Worker);

-- Q-44. Write an SQL query to fetch the last five records from a table
(select * from worker order by worker_id desc limit 5) order by worker_id;

-- Q-45. Write an SQL query to print the name of employees having the highest salary in each department
select first_name
from worker
where (salary, department) in (
SELECT max(salary) as Salary, department
FROM Worker 
GROUP BY DEPARTMENT
);
/*
DRY RUN: Fetch employees with the highest salary in each department.
Logic: (salary, department) Tuple Comparison

INNER QUERY RESULT (The "Winner's List"):
- (300000, 'HR')
- (500000, 'Admin')
- (200000, 'Account')

OUTER QUERY EVALUATION:
+-----+------------+--------+---------+-----------------------------------+---------+
| Row | Name       | Salary | Dept    | Match (Salary, Dept) in List?     | Result  |
+-----+------------+--------+---------+-----------------------------------+---------+
| 1   | Monika     | 100k   | HR      | (100k, HR) is NOT in list         | Discard |
| 2   | Vishal     | 300k   | HR      | (300k, HR) IS in list             | KEEP    |
| 3   | Niharika   | 80k    | Admin   | (80k, Admin) is NOT in list       | Discard |
| 4   | Amitabh    | 500k   | Admin   | (500k, Admin) IS in list          | KEEP    |
| 5   | Vivek      | 500k   | Admin   | (500k, Admin) IS in list          | KEEP    |
| 6   | Vipul      | 200k   | Account | (200k, Account) IS in list        | KEEP    |
| 7   | Satish     | 75k    | Account | (75k, Account) is NOT in list     | Discard |
| 8   | Geetika    | 90k    | Admin   | (90k, Admin) is NOT in list       | Discard |
+-----+------------+--------+---------+-----------------------------------+---------+
*/

-- Q-46. Write an SQL query to fetch three max salaries from a table using co-related subquery
--  THIS QUERY IS LOGICALLY CORRECT BUT CAN'T BE USED BECAUSE MYSQL WORKBENCH DOESNOT SUPPORT CORRELATED SUBQUERIES WITH LIMIT
-- SELECT * FROM WORKER WHERE SALARY IN (SELECT SALARY FROM WORKER ORDER BY SALARY DESC LIMIT 3);
--  correct query -->
SELECT * FROM Worker w1
WHERE 3 > (
    SELECT COUNT(DISTINCT w2.salary) 
    FROM Worker w2 
    WHERE w2.salary > w1.salary
);

-- Q-47. Write an SQL query to fetch three min salaries from a table using co-related subquery
select distinct salary from worker w1
where 3 >= (select count(distinct salary) from worker w2 where w1.salary >= w2.salary) 
order by w1.salary desc;

/*
DRY RUN: Fetch 3 Minimum Salaries (Inclusive Count Logic)
Question: Q-47 (Co-related subquery)

STEPS:
1. For every salary in the table (w1), count how many unique salaries (w2) 
   are smaller than OR equal to it.
2. If that count is 3 or less, it means the salary is among the 3 smallest.

+----------+------------------------------------+-------+----------------+---------+
| Salary   | Subquery: COUNT(DISTINCT w2 <= w1) | Count | Condition (3>=)| Result  |
+----------+------------------------------------+-------+----------------+---------+
| 75,000   | {75,000}                           | 1     | 3 >= 1 (True)  | KEEP    |
| 80,000   | {75,000, 80,000}                   | 2     | 3 >= 2 (True)  | KEEP    |
| 90,000   | {75,000, 80,000, 90,000}           | 3     | 3 >= 3 (True)  | KEEP    |
| 100,000  | {75k, 80k, 90k, 100k}              | 4     | 3 >= 4 (False) | DISCARD |
+----------+------------------------------------+-------+----------------+---------+

Note: The 'ORDER BY w1.salary DESC' in your query will show 90k first, then 80k, then 75k.
*/


-- Q-48. Write an SQL query to fetch nth max salaries from a table.
select distinct salary from worker w1
where n >= (select count(distinct salary) from worker w2 where w1.salary <= w2.salary) order by w1.salary desc;


-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
SELECT SUM(SALARY), DEPARTMENT
FROM WORKER
GROUP BY DEPARTMENT
ORDER BY SUM(SALARY);
-- OR
select department , sum(salary) as depSal from worker group by department order by depSal desc;


-- Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
select first_name, salary from worker where salary = (select max(Salary) from worker);


