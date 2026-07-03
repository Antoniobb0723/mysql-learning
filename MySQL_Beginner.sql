SELECT * 
FROM Parks_and_Recreation.employee_demographics;

select first_name, # select statement
last_name,
birth_date,
age,
(age + 10) * 10
from Parks_and_Recreation.employee_demographics;

# pemdas

# select unique values (distinct)
select distinct first_name
from Parks_and_Recreation.employee_demographics;

select distinct gender
from Parks_and_Recreation.employee_demographics;

select distinct first_name, gender  # all the combinations are unique
from Parks_and_Recreation.employee_demographics;

-- WHERE Clause
select *
from employee_salary
where first_name = 'Leslie';

select *
from employee_salary
where salary <= 50000 ;

select *
from employee_demographics
where gender != 'Female';

select *
from employee_demographics
where birth_date > '1985-01-01';

-- Logical Operators -- AND OR NOT
select *
from employee_demographics
where birth_date > '1985-01-01'
and gender = 'male' # the rows fulfill both criteria
;

select *
from employee_demographics
where birth_date > '1985-01-01'
or gender = 'male' # the rows fulfill either criteria
;

select *
from employee_demographics
where birth_date > '1985-01-01'
or not gender = 'male' # the rows fulfill either criteria
# after 1985-01-01 or the gender is not male (is female)
# born before 1985 must be female
;

select *
from employee_demographics
where (first_name = 'Leslie' and age = 44) or age > 55
# 括号里面是同一个情况
;

-- Like statement: pattern
select *
from employee_demographics
where first_name = 'Jer' # equal sign means exact match
;

-- % and _
select *
from employee_demographics
where first_name like '%er%'  # anything before, er, anything after
;

select *
from employee_demographics
where first_name like 'a%'  # 'a' has to be the first letter, anything after
;

select *
from employee_demographics
where first_name like 'a__'  # starts with an 'a', two characters after it, no more no less.
;

select *
from employee_demographics
where first_name like 'a___%'  
# starts with an 'a', three characters after it, anything after.
;

select *
from employee_demographics
where birth_date like '1989%'  
# starts with 1989, anything after this
;

-- Group By
-- Take all rows with the same occupation and merge them into one group.
select *
from employee_demographics;

# grouping on the gender, 
# calculate average of age based on category gender
select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender
;

# group by和select的东西得相同
select occupation, salary 
# a unique combination of occupation and salary
from employee_salary
group by occupation, salary
;

-- order by
-- sort the result set in either ascending or descending
-- by default, it is in ascending order
-- asc desc
select *
from employee_demographics
# within female, ordered by age; then male, ordered by age
# all the age values are unique, so gender is not used at all if it comes after age
order by gender, age desc
;

-- Having vs Where
-- WHERE filters individual rows before grouping
-- Having filters entire groups after grouping
select gender, avg(age)
from employee_demographics
group by gender
having avg(age)>40
;


select occupation, avg(salary)
from employee_salary
where occupation like "%manager%" # row level
group by occupation
# having by only works after group by runs
having avg(salary) > 75000
;

-- Limit & Aliasing
select *
from employee_demographics
order by age desc
# take the top 3 oldest people in the table
limit 3
;

select *
from employee_demographics
order by age desc
# start at position 2 (of age) and go 1 row after it. 
limit 2,1
;

-- Aliasing
-- a way to change the names of the column for the most part
select gender, avg(age)
from employee_demographics
group by gender
having avg(age) > 40
;

select gender, avg(age) as avg_age # format the name better
from employee_demographics
group by gender
having avg(age) > 40
;





