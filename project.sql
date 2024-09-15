use ecomm;

-- DATA CLEANING
-- Handling Missing Values and Outliers
-- (1)
select round(avg(WarehouseToHome)) into @mean from customer_churn where WarehouseToHome is not null;
update customer_churn set WarehouseToHome = @mean where WarehouseToHome is null;

select round(avg(HourSpendOnApp)) into @mean from customer_churn where HourSpendOnApp is not null;
update customer_churn set HourSpendOnApp = @mean where HourSpendOnApp is null;

select round(avg(OrderAmountHikeFromlastYear)) into @mean from customer_churn where OrderAmountHikeFromlastYear is not null;
update customer_churn set OrderAmountHikeFromlastYear = @mean where OrderAmountHikeFromlastYear is null;

select round(avg(DaySinceLastOrder)) into @mean from customer_churn where DaySinceLastOrder is not null;
update customer_churn set DaySinceLastOrder = @mean where DaySinceLastOrder is null;

-- (2)
select Tenure into @mode_impute from customer_churn group by Tenure having Tenure is not null order by count(*) desc limit 1;
update customer_churn set Tenure = @mode_impute where Tenure is null;

select CouponUsed into @mode_impute from customer_churn group by CouponUsed having CouponUsed is not null order by count(*) desc limit 1;
update customer_churn set CouponUsed = @mode_impute where CouponUsed is null;

select OrderCount into @mode_impute from customer_churn group by OrderCount having OrderCount is not null order by count(*) desc limit 1;
update customer_churn set OrderCount = @mode_impute where OrderCount is null;

-- (3)
delete from customer_churn where WarehouseToHome > 100;

-- Dealing with Inconsistencies:
-- (1)
update customer_churn set PreferredLoginDevice = 'Mobile Phone' where PreferredLoginDevice = 'Phone';
update customer_churn set PreferedOrderCat = 'Mobile Phone' where PreferedOrderCat = 'Mobile';
-- (2)
update customer_churn set PreferredPaymentMode="Cash on Delivery" where PreferredPaymentMode="COD";
update customer_churn set PreferredPaymentMode="Credit Card" where PreferredPaymentMode="CC";

-- DATA TRANSFORMATION
-- Column Renaming
alter table customer_churn
rename column PreferedOrderCat to PreferredOrderCat,
rename column HourSpendOnApp to HoursSpentOnApp;

-- Creating New Columns:
-- (1)
alter table customer_churn
add column ComplaintReceived varchar(5);
update customer_churn set ComplaintReceived = "Yes" where Complain = 1;
update customer_churn set ComplaintReceived = "No" where ComplaintReceived is null;
-- (2)
alter table customer_churn
add column ChurnStatus varchar(15);
update customer_churn set ChurnStatus = "Churned" where Churn = 1;
update customer_churn set ChurnStatus = "Active" where ChurnStatus is null;

-- Column Dropping:
alter table customer_churn
drop column Churn; 
alter table customer_churn
drop column Complain; 

-- DATA EXPLORATION AND ANALYSIS
-- (1)
select ChurnStatus, count(*) Count_of_Customers from customer_churn group by ChurnStatus;
-- (2)
select avg(Tenure) Average_Tenure_of_Churned_Customers from customer_churn where ChurnStatus = "Churned";
-- (3)
select sum(CashbackAmount) Total_Cashback from customer_churn where ChurnStatus = "Churned";
-- (4)
select ((select count(*) from customer_churn where ComplaintReceived = "Yes" and ChurnStatus = "Churned")/
(select count(*) from customer_churn where ChurnStatus = "Churned"))*100 percentage_of_churned_customers_who_complained;
-- (5)
select count(*) into @total from customer_churn where ComplaintReceived = "Yes";
select gender,(count(*)/@total)*100 Distribution from customer_churn where ComplaintReceived = "Yes" group by gender;
-- (6)
select CityTier from customer_churn where ChurnStatus = "Churned" and PreferredOrderCat='Laptop & Accessory' 
group by CityTier order by count(*) desc limit 1; 
-- (7)
select PreferredPaymentMode from customer_churn where ChurnStatus="Active" group by PreferredPaymentMode order by count(*) desc limit 1;
-- (8)
select PreferredLoginDevice,count(*) Count from customer_churn where DaySinceLastOrder>10 group by PreferredLoginDevice;
-- (9)
select count(*) from customer_churn where HoursSpentOnApp>3 and ChurnStatus = "Active";
-- (10)
select avg(CashbackAmount) avg_cashback_of_customer_who_spent_atleast_2hrs from customer_churn where HoursSpentOnApp>=2;
-- (11)
select PreferredOrderCat,max(HoursSpentOnApp) max_hrs_spent_on_app from customer_churn group by PreferredOrderCat;
-- (12)
select MaritalStatus, avg(OrderAmountHikeFromlastYear) Avg_OrderAmountHikeFromlastYear from customer_churn group by MaritalStatus;
-- (13)
select sum(OrderAmountHikeFromlastYear) Total_OrderAmountHikeFromlastYear from customer_churn where MaritalStatus = "Single" and PreferredLoginDevice ="Mobile Phone";
-- (14)
select round(avg(NumberOfDeviceRegistered)) avg_NumberOfDeviceRegistered from customer_churn where PreferredPaymentMode = "UPI";
-- (15)
select CityTier from customer_churn group by CityTier order by count(*) desc limit 1;
-- (16)
select CustomerID, MaritalStatus from customer_churn where NumberOfAddress = (select max(NumberOfAddress) from customer_churn);
-- (17)
select gender from customer_churn group by gender order by max(CouponUsed) limit 1;
-- (18)
select PreferredOrderCat, avg(SatisfactionScore) from customer_churn group by PreferredOrderCat;
-- (19)
select sum(OrderCount) total_order_count from customer_churn where PreferredPaymentMode = "Credit Card" and SatisfactionScore = (select max(SatisfactionScore));
-- (20)
select count(*) count from customer_churn where HoursSpentOnApp = 1 and DaySinceLastOrder>5; 
-- (21)
select avg(SatisfactionScore) avg_SatisfactionScore from customer_churn where ComplaintReceived="Yes";
-- (22)
select PreferredOrderCat, count(*) count from customer_churn group by PreferredOrderCat;
-- (23)
select avg(CashbackAmount) avg_CashbackAmount from customer_churn where MaritalStatus = "Married";
-- (24)
select round(avg(NumberOfDeviceRegistered)) avg_NumberOfDeviceRegistered from customer_churn where PreferredLoginDevice <> "Mobile Phone";
-- (25)
select PreferredOrderCat from customer_churn where CouponUsed > 5 group by PreferredOrderCat;
-- (26)
select PreferredOrderCat from customer_churn group by PreferredOrderCat order by avg(CashbackAmount) desc limit 3;
-- (27)
select PreferredPaymentMode from customer_churn group by PreferredPaymentMode having sum(OrderCount)>500 and round(avg(Tenure)) = 10;

-- (28)
SELECT 
CASE
WHEN WarehouseToHome <= 5 THEN 'Very Close Distance'
WHEN WarehouseToHome <= 10 THEN 'Close Distance'
WHEN WarehouseToHome <= 15 THEN 'Moderate Distance'
ELSE 'Far Distance'
END AS DistanceCat,
ChurnStatus,
COUNT(*) AS customer_count
FROM customer_churn
GROUP BY DistanceCat, ChurnStatus
ORDER BY DistanceCat, ChurnStatus;

-- (29)
select * from customer_churn where MaritalStatus = "Married" and CityTier=1 and OrderCount > (select avg(OrderCount) from customer_churn);

-- (30)[a]
create table customer_returns(
		ReturnID int primary key,
		CustomerID int,
		ReturnDate date,
		RefundAmount int);
insert into customer_returns(ReturnID, CustomerID, ReturnDate, RefundAmount) values
(1001, 50022, "2023-01-01", 2130),
(1002, 50316, "2023-01-23", 2000),
(1003, 51099, "2023-02-14", 2290),
(1004, 52321, "2023-03-08", 2510),
(1005, 52928, "2023-03-20", 3000),
(1006, 53749, "2023-04-17", 1740),
(1007, 54206, "2023-04-21", 3250),
(1008, 54838, "2023-04-30", 1990);

-- (30)[b]
select cc.*, cr.ReturnID, cr.ReturnDate, cr.RefundAmount  from customer_returns as cr
inner join customer_churn as cc on cc.CustomerID = cr.CustomerID
where cc.ChurnStatus = "Churned" and cc.ComplaintReceived = "Yes";
-- -------end-----------end------------end------------end----------end---------

select * from customer_churn;
