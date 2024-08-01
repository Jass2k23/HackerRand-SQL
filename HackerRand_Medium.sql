--! Write a query to print all prime numbers less than or equal to 1000. Print your result on a single line, and use the ampersand (&) character as your separator (instead of a space).

--? Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

select 
case 
    when (a+b <= c) or (b+c <= a) or (a+c <=b) then 'Not A Triangle'
    when a = b and b = c then 'Equilateral'
    when (a = b) or (b = c) or (a = c) then 'Isosceles'
    else 'Scalene'
    end as 'Triangle Type'
from Triangles


--? P(R) represents a pattern drawn by Julia in R rows. Write query for p(20)
-- p(4):
-- * * * *
-- * * *
-- * *
-- *

with recursive cte as(
    select 20 as n
    union all 
    select n-1 
    from cte
    where n > 1
)

select repeat ('* ',n)
from cte;


