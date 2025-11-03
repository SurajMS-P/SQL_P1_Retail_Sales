-- Retail-Sales-Analysis-SQL-Project--P1

Create database Project;

Use Project;

-- Create Table Retail_Sales

Create table Retail_Sales 
		(
		transactions_id int primary key,
		sale_date date,
		sale_time time,
		customer_id int,
		gender varchar(15),
		age int,
		category varchar(15),
		quantiy int,
		price_per_unit int,
		cogs float,
		total_sale float
		);

-- ========================================================================================================================================

Desc Retail_Sales;

-- Alter column name
alter table Retail_sales change column quantiy quantity int;
Alter table Retail_Sales rename column quantiy to quantity;

Select * from Retail_Sales;

-- ========================================================================================================================================

-- Data Cleaning

Select * from Retail_sales
where quantiy is null;

Select * from Retail_sales
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or 
gender is null
or 
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale;

-- ========================================================================================================================================

-- Data Exploration
Select * from Retail_Sales;

-- How many sales we have?
Select count(*) as Sales_Count from Retail_sales;

-- How many uniuque customers we have ?
Select count(distinct customer_id) as Unique_Customer from Retail_Sales;

-- How many uniuque category we have ?
Select distinct category from Retail_Sales;

-- ========================================================================================================================================

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

Select
* from Retail_Sales 
where sale_date = '2022-11-05';

-- ========================================================================================================================================

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

Select 
* from Retail_Sales
where category = "Clothing"
and
Quantity > 3
and 
Sale_date >= '2022-11-01' 
and 
Sale_date <= '2022-11-30';

-- ========================================================================================================================================

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

Select
Category,
sum(total_sale) as Total_sale
from Retail_sales
group by 1;

-- ========================================================================================================================================

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
/*
Select 
Customer_id,
avg(age) as Avg_age,
category
from Retail_sales
where category = "Beauty"
group by 1;
*/

Select 
Round(avg(age),2) as AVG_age
from Retail_sales
where category = "Beauty";

-- ========================================================================================================================================

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

Select 
* from Retail_sales
where total_sale > 1000;

-- ========================================================================================================================================

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

Select 
Category,
Gender,
count(*) as T_Transactions,
count(transactions_id) as T_T
from Retail_sales
group by 1,2
order by 1;

-- ========================================================================================================================================

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

Select 
Yr, 
B_S_Mnth, 
Avg_sale from 
(
Select
year(sale_date) as Yr,
month(sale_date) as B_S_Mnth,
round(avg(total_sale),0) as Avg_sale,
dense_rank() over(partition by year(sale_date)order by round(avg(total_sale),0) ) as Rnk
from Retail_sales
group by 1,2
) as Best_selling_month 
where rnk = 12;

-- ========================================================================================================================================

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

Select 
Customer_id,
sum(total_sale) as Total_sales
from Retail_sales
group by 1
order by 2 desc
limit 5;

-- ========================================================================================================================================

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

Select 
Category,
count(distinct customer_id) Unique_Customer
From retail_sales
group by 1;

-- ========================================================================================================================================

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

With hourly_sale as 
(
Select *,
Case
when hour(sale_time) <=12 then "Morning"
when hour(sale_time) between 12 and 17 then "Afternoon"
Else "Evening"
end as Shift
from Retail_sales 
) 
Select 
Shift,
count(*)
from hourly_sale 
group by Shift;

Select Shift, count(*) from (
Select *,
Case
when hour(sale_time) <=12 then "Morning"
when hour(sale_time) between 12 and 17 then "Afternoon"
Else "Evening"
end as Shift
from Retail_sales) as AB
group by 1;

-- ========================================================================================================================================













