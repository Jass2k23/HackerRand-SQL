--? Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.

select distinct city 
from station
where substr(city,1,1) not in ('a','e','i','o','u','A','E','I','O','U') and substr(city,-1,1) not in ('a','e','i','o','u','A','E','I','O','U');


--? Query the Name of any student in STUDENTS who scored higher 75 than  Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.

select name 
from students
where marks > 75
order by substr(name,-3), id;


--? Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.

select name 
from employee
order by name;


--? Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than 2,000 per month who have been employees for less than 10 months. Sort your result by ascending employee_id.

select name 
from employee
where salary > 2000 and months < 10
order by employee_id;


with recursive cte as (
    select 2 as n
    union all 
    select n+1 from cte
    where n 
)

--? Query a count of the number of cities in CITY having a Population larger than 100000.

select count(name) 
from city
where population > 100000;


--? Query the total population of all cities in CITY where District is California.

select sum(population )
from city
where district = 'California'
group by district;


--? Query the average population of all cities in CITY where District is California.

select avg(population)
from city
where district = 'California'
group by district;

--? Query the average population for all cities in CITY, rounded down to the nearest integer.

select round(avg(population))
from city;


--? Sum of all Japanese city's population

select sum(population)
from city
where countrycode = "JPN";


--! Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's 0 key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.

-- Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.

Select Ceil( avg( Salary) - avg( replace(Salary,"0","") )) from EMPLOYEES ;

SELECT CEIL(ABS(actual_average_salary - miscalculated_average_salary)) AS error_amount 
FROM ( 
    SELECT AVG(Salary) AS actual_average_salary, AVG(CAST(REPLACE(CAST(Salary AS CHAR), '0', '') AS UNSIGNED)) AS miscalculated_average_salary 
    FROM EMPLOYEES 
) AS averages;


--? We define an employee's total earnings to be their monthly  worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as 2 space-separated integers.

select (salary * months) as Salary, count(salary)
from employee
where (salary * months) = (
    select max(salary * months)
    from employee
)
group by (salary * months);


--? 
select round(sum(lat_n),4)
from station
group by lat_n
having lat_n > 38.7880 and lat_n < 137.2345


--? Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to 4 decimal places.

select round(max(lat_n),4)
from station
where lat_n in (
    select lat_n
    from station
    where lat_n < 137.2345
)


--! Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345 Round your answer to 4 decimal places.

select round(long_w,4)
from station
where lat_n = (
    select max(lat_n)
    from station
    where lat_n < 137.2345
)


--? Smallest lat_n greater 38.7780

select round(min(lat_n),4)
from station
where lat_n > 38.7780


--?
select round(long_w,4)
from station
where lat_n = (
    select min(lat_n)
    from station
    where lat_n > 38.7780
)


--? Consider P1(a,b) and P2(c,d) to be two points on a 2D plane.
-- a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
-- b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
-- a happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
-- b happens to equal the maximum value in Western Longitude (LONG_W in STATION).
--? Query the Manhattan Distance between points P1 and P2 and round it to a scale of 4 decimal places.
--* |x1 - x2| + |y1 - y2|

select round(abs(max(lat_n) - min(lat_n)) + abs(max(long_w) - min(long_w)),4)
from station

--* ((p1-p2)^2 + (p1-p2)^2)^1/2

select round( power(power(max(lat_n) - min(lat_n),2) + power(max(long_w) - min(long_w),2),1/2),4)
from station


--! Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.

select sum(city.population)
from city
inner join country
on countrycode = code
group by continent
having continent = "Asia";

SELECT SUM(city.population)
FROM city
INNER JOIN country ON city.countrycode = country.code
WHERE country.continent = 'Asia'
GROUP BY country.continent;


--?

select continent, floor((avg(city.population)))
from country
inner join city
on countrycode = code
group by continent