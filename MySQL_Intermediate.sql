-- Joins: combine columns (side by side)

Select * 
from employee_demographics;

Select *
from employee_salary;

-- Inner Join
Select dem.employee_id, age, occupation
from employee_demographics as dem # from statement is the left table
inner join employee_salary as sal # join statement is the right table
	on dem.employee_id = sal.employee_id
;

-- Outer Joins (Left / Right Join)
-- Left join: Bring everything from the left table
-- and only matches the right table
Select *
from employee_demographics as dem
left join employee_salary as sal 
	on dem.employee_id = sal.employee_id
;

-- Outer Joins (Left / Right Join)
-- Right join: Bring everything from the right table
-- and only matches the right table
Select *
from employee_demographics as dem
right join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

-- Self Join
select *
from employee_salary as emp1 
join employee_salary as emp2
# assign the next highest number as the person's secret santa
	on emp1.employee_id + 1 = emp2.employee_id
;

-- Joining multiple tables together
Select *
from employee_demographics as dem # from statement is the left table
inner join employee_salary as sal # join statement is the right table
	on dem.employee_id = sal.employee_id
inner join parks_departments as pd
	on sal.dept_id = pd.department_id
;

select *
from parks_departments;

-- Union: combine rows (top to bottom)
-- Stack one table underneath

select first_name, last_name
from employee_demographics
union 
select first_name, last_name
from employee_salary
;

-- union is by default union distinct
-- union all shows all values including duplicates

select first_name, last_name, 'Old Man' AS Label
from employee_demographics
where age > 40 and gender = 'Male'
union 
select first_name, last_name, 'Old Lady' AS Label
from employee_demographics
where age > 40 and gender = 'Female'
union
select first_name, last_name, 'Highly Paid Employee' AS Label
from employee_salary
where salary > 70000
order by first_name, last_name
;

-- String Functions
select length('skyfall');

select first_name, length(first_name)
from employee_demographics
order by 2 # sort by the second column in the select list
;

select first_name, upper(first_name) # helpful for standardization
from employee_demographics;

-- trim, ltrim, rtrim
select rtrim('          sky           ')
;

select first_name, 
left(first_name, 4),
right(first_name, 4),
substring(first_name, 3, 2), # we start at the thrid position and choose 2 characters
birth_date,
substring(birth_date, 6, 2) as birth_month,
substring(birth_date, 9, 2) as birth_date
# we are selecting 4 letters from the left hand side from first names
from employee_demographics;

-- replace


select first_name, replace(first_name, 'a', 'z') 
# replace 'a' with 'z'
from employee_demographics;

-- locate
select locate('x', 'Alexander')
# locate "x" in "alexander"
from employee_demographics;

select first_name, locate('an', first_name) 
# replace 'a' with 'z'
from employee_demographics;

-- concat
select first_name, last_name,
concat(first_name, ' ', last_name) as full_name
from employee_demographics;

-- case statement
select first_name, last_name,
case
	when age <= 30 then 'Young'
    when age between 31 and 50 then 'old'
    when age >= 50 then "On Death's Door"
end as Age_Bracket
from employee_demographics;

-- pay and bonuses

select first_name, last_name, salary,
case
	when salary < 50000 then salary * 1.05
    when salary > 50000 then salary * 1.07
end as new_salary,
case
	when dept_id = 6 then salary * .10
end as bonus
from employee_salary;

-- subqueries
# Show me the demographic information for employees id are 1, 3, and 5.
# employees 1 3 5 are dept 1.
# in returns multiple values
select *
from employee_demographics
where employee_id in
					(select employee_id
						from employee_salary
                        where dept_id = 1)
;

select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender;

select avg(max_age)
from
(select gender, 
 avg(age) as avg_age, 
 max(age) as max_age, 
 min(age) as min_age, 
 count(age) as count_age
from employee_demographics
group by gender) as agg_table
;

-- Window Functions
# group by rows everything into one row
select gender, avg(salary)
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
group by gender
;

-- does NOT merge rows
-- does NOT affect rows when adding new information
-- rolling total: start at a row and add on values
select dem.first_name, dem.last_name, gender, salary,
 sum(salary) over(partition by gender order by dem.employee_id) as rolling_total
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

-- Row number, rank, dense rank
select dem.first_name, dem.last_name, gender, salary,
# row number gives unique values
row_number() over(partition by gender order by salary desc) as row_num,
# rank number will appear the same numbers
# next number positionally
rank() over(partition by gender order by salary desc) as rank_num,
# next number numerically
dense_rank() over(partition by gender order by salary desc) as dense_rank_num
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
;


