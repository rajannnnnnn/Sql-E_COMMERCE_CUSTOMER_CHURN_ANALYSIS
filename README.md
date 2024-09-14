# E-Commerce Customer Churn Analysis
## Problem Statement:
In the realm of e-commerce, businesses face the challenge of understanding customer
churn patterns to ensure customer satisfaction and sustained profitability. This project
aims to delve into the dynamics of customer churn within an e-commerce domain,
utilizing historical transactional data to uncover underlying patterns and drivers of
churn. By analyzing customer attributes such as tenure, preferred payment modes,
satisfaction scores, and purchase behavior, the project seeks to investigate and
understand the dynamics of customer attrition and their propensity to churn. The
ultimate objective is to equip e-commerce enterprises with actionable insights to
implement targeted retention strategies and mitigate churn, thereby fostering long-term
customer relationships and ensuring business viability in a competitive landscape.

**Dataset:** dataset.sql (or) [click to download it](https://drive.google.com/uc?export=download&id=1iKKCze_Fpk2n_g3BIZBiSjcDFdFcEn3D)

## Project Steps and Objectives:
### Data Cleaning:
#### Handling Missing Values and Outliers:
➢ Impute mean for the following columns, and round off to the nearest integer if
required: WarehouseToHome, HourSpendOnApp, OrderAmountHikeFromlastYear,
DaySinceLastOrder.<br>
➢ Impute mode for the following columns: Tenure, CouponUsed, OrderCount.<br>
➢ Handle outliers in the 'WarehouseToHome' column by deleting rows where the
values are greater than 100.

#### Dealing with Inconsistencies:
➢ Replace occurrences of “Phone” in the 'PreferredLoginDevice' column and
“Mobile” in the 'PreferedOrderCat' column with “Mobile Phone” to ensure
uniformity.<br>
➢ Standardize payment mode values: Replace "COD" with "Cash on Delivery" and
"CC" with "Credit Card" in the PreferredPaymentMode column.

### Data Transformation:
#### Column Renaming:
➢ Rename the column "PreferedOrderCat" to "PreferredOrderCat".<br>
➢ Rename the column "HourSpendOnApp" to "HoursSpentOnApp".
#### Creating New Columns:
➢ Create a new column named ‘ComplaintReceived’ with values "Yes" if the
corresponding value in the ‘Complain’ is 1, and "No" otherwise.<br>
➢ Create a new column named 'ChurnStatus'. Set its value to “Churned” if the
corresponding value in the 'Churn' column is 1, else assign “Active”.
#### Column Dropping:
➢ Drop the columns "Churn" and "Complain" from the table.

### Data Exploration and Analysis:
1. Retrieve the count of churned and active customers from the dataset.
2. Display the average tenure of customers who churned.
3. Calculate the total cashback amount earned by customers who churned.
4. Determine the percentage of churned customers who complained.
5. Find the gender distribution of customers who complained.

6. Identify the city tier with the highest number of churned customers whose
preferred order category is Laptop & Accessory.
7. Identify the most preferred payment mode among active customers.
8. List the preferred login device(s) among customers who took more than 10 days
since their last order.
9. List the number of active customers who spent more than 3 hours on the app.
10. Find the average cashback amount received by customers who spent at least 2
hours on the app.
11. Display the maximum hours spent on the app by customers in each preferred
order category.
12. Find the average order amount hike from last year for customers in each marital
status category.
13. Calculate the total order amount hike from last year for customers who are single
and prefer mobile phones for ordering.
14. Find the average number of devices registered among customers who used UPI as
their preferred payment mode.
15. Determine the city tier with the highest number of customers.
16. Find the marital status of customers with the highest number of addresses.
17. Identify the gender that utilized the highest number of coupons.
18. List the average satisfaction score in each of the preferred order categories.
19. Calculate the total order count for customers who prefer using credit cards and
have the maximum satisfaction score.
20. How many customers are there who spent only one hour on the app and days
since their last order was more than 5?
21. What is the average satisfaction score of customers who have complained?
22. How many customers are there in each preferred order category?

23. What is the average cashback amount received by married customers?
24. What is the average number of devices registered by customers who are not
using Mobile Phone as their preferred login device?
25. List the preferred order category among customers who used more than 5
coupons.
26. List the top 3 preferred order categories with the highest average cashback
amount.
27. Find the preferred payment modes of customers whose average tenure is 10
months and have placed more than 500 orders.
28. Categorize customers based on their distance from the warehouse to home such
as 'Very Close Distance' for distances <=5km, 'Close Distance' for <=10km,
'Moderate Distance' for <=15km, and 'Far Distance' for >15km. Then, display the
churn status breakdown for each distance category.
29. List the customer’s order details who are married, live in City Tier-1, and their
order counts are more than the average number of orders placed by all
customers.
30.
    1 ) Create a ‘customer_returns’ table in the ‘ecomm’ database and insert the
following data:
ReturnID CustomerID ReturnDate RefundAmount
1001 50022 2023-01-01 2130
1002 50316 2023-01-23 2000
1003 51099 2023-02-14 2290
1004 52321 2023-03-08 2510
1005 52928 2023-03-20 3000
1006 53749 2023-04-17 1740
1007 54206 2023-04-21 3250
1008 54838 2023-04-30 1990

    2 ) Display the return details along with the customer details of those who have
churned and have made complaints.
