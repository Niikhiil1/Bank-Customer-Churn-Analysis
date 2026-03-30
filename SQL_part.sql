--creating a new database
create database churnanalysis

use churnanalysis
go

--selecting the database
select top(5) * from dbo.ChurnModel

--calculating the total number of rows.
select count(*) as row_count 
from dbo.ChurnModel

--checking the null values in dataset.
select 
count(*) as total_rows,
count(HasCrCard) as card_notnull,
count(isactivemember) as is_notnull,
count(estimatedsalary) as salary_notnull,
count(exited) as exited_notnull,
count(balance) as balance_notnull,
count(CustomerId) as id_notnull,
count(age) as age_notnull,
count(tenure) as tenure_notnull
from dbo.ChurnModel

/*from here we got to know that there is no null values in the dataset. So no need to worry about that.*/


--number of customers that exited
select count(*) as yes_exited
from dbo.ChurnModel
where Exited = 1

--number of customers that not exited.
select count(*) as not_exited
from dbo.ChurnModel
where Exited = 0

--calculating the chhurn rate now

select 
count(*) as total_customers,
sum(cast(Exited as int)) as customer_churn,
Round(sum(cast(Exited as int)) * 100.0 / count(*),2) as churn_rate
from dbo.churnmodel

--Data cleaning comes into frame now.

select top(5) * from dbo.ChurnModel

--deleting the specific rows which are of no use.
--deleting here means making a new table which contains columns of use only.

select
CreditScore,
Geography,
Gender,
Age,
Tenure,
Balance,
NumOfProducts,
HasCrCard,
IsActiveMember,
EstimatedSalary,
Exited
into dbo.newTable
from dbo.ChurnModel

--checking null values now in the new table that we created.

select
sum(case when Geography is null then 1 else 0 end) as Geography_notnull,
sum(case when Gender is null then 1 else 0 end) as Gender_notnull,
sum(case when EstimatedSalary is null then 1 else 0 end)as Salary_notnull,
sum(case when Exited is null then 1 else 0 end) as Exited_notnull
from dbo.newTable


-- after running this query we came with the result that there are no null values in the dataset.

--now checking the datatypes

exec sp_help 'dbo.newTable'

--here we don't need to change any datatypes.

--Feature Engineering

-- here comes the part of dividing the age column into categories.
--adding a new column in the table

alter table dbo.NewTable
add AgeGroup varchar(20)

--adding the values in the column that we created.

update dbo.newTable
set AgeGroup = 
case
	when age <30 then 'Young'
	when age between 30 and 60 then 'Middle Aged'
	else 'senior'
end

select top(5) * from dbo.newTable


--performing the same task with balance now.

alter table dbo.NewTable
add BalanceGroup varchar(20)

update dbo.newTable
set BalanceGroup = 
case 
	when balance = 0 then 'No Balance'
	when balance < 50000 then 'Low'
	when Balance between 50000 and 150000 then 'Medium'
	else 'High'
end

select top(5) * from dbo.newTable

--EDA 

--We will perform eda on this dataset.

--churn by geography

select
Geography,
count(*) as total_customers,
sum(cast(Exited as int)) as total_cust_churn,
round(sum(cast(Exited as int)) *100.0 / count(*), 2) as churn_ratio
from dbo.newTable
group by Geography
order by churn_ratio desc


--churn by Gender

select
Gender,
count(*) as total_customer,
sum(cast(Exited as int)) as total_cust_churn,
round(sum(cast(Exited as int)) * 100.0 / count(*) ,2)as churn_ratio
from dbo.newTable
group by Gender
order by churn_ratio desc

--churn by age group

select top(5) * from dbo.newTable

select 
AgeGroup,
sum(cast(Exited as int)) as cust_churn,
round(sum(cast(Exited as int)) * 100.0 / count(*) , 2) as churn_ratio
from dbo.newTable
group by AgeGroup
order by churn_ratio desc

--churn by isactivemember
select 
IsActiveMember,
sum(cast(Exited as int)) as cust_churn,
round(sum(cast(Exited as int)) * 100.0 / count(*) , 2) as churn_ratio
from dbo.newTable
group by IsActiveMember
order by churn_ratio

--churn vs number of products
SELECT 
    NumOfProducts,
    COUNT(*) AS Total,
    SUM(cast(Exited as int)) AS Churned,
    ROUND(SUM(cast(Exited as int))*100.0/COUNT(*),2) AS Churn_Rate
FROM dbo.newTable
GROUP BY NumOfProducts
ORDER BY NumOfProducts


select * from dbo.newTable
