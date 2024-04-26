# Super-Market-Sales-using-SQL
# Super Market Sales: Unveiling Consumer Behavior and Retail Trends through Supermarket Sales Data

## About Dataset
Here's a brief description of each of the attributes or labels in the dataset:
1. **Invoice ID:** A unique identifier for each invoice or transaction.
2. **Branch:** The branch or location where the transaction occurred.
3. **City:** The city where the branch is located.
4. **Customer Type:** Indicates whether the customer is a regular or new customer.
5. **Gender:** The gender of the customer.
6. **Product Line:** The category or type of product purchased.
7. **Unit Price:** The price of a single unit of the product.
8. **Quantity:** The number of units of the product purchased.
9. **Tax 5%:** The amount of tax (5% of the total cost) applied to the transaction.
10. **Total:** The total cost of the transaction, including tax.
11. **Date:** The date when the transaction took place.
12. **Time:** The time of day when the transaction occurred.
13. **Payment:** The payment method used (e.g., credit card, cash).
14. **COGS (Cost of Goods Sold):** The direct costs associated with producing or purchasing the products sold.
15. **Gross Margin Percentage:** The profit margin percentage for the transaction.
16. **Gross Income:** The total profit earned from the transaction.
17. **Rating:** Customer satisfaction rating or feedback on the transaction.

## Analyst List
Certainly! Here are three analyst tasks that can be accomplished using SQL:

1. **Top Selling Products by Revenue:** This task involves identifying the top-selling products based on revenue generated. This query calculates the total revenue for each product line by summing up the total transaction amounts and then orders the results in descending order of revenue.

2. **Monthly Revenue Trend Analysis:** This task aims to analyze the trend of revenue over different months. This query groups the data by the year and month of the transaction date, calculates the total revenue for each month, and orders the results chronologically.

3. **Customer Satisfaction Analysis by Gender and Customer Type:** This task involves analyzing customer satisfaction ratings based on gender and customer type. This query calculates the average rating for each combination of gender and customer type, providing insights into how satisfaction varies across different demographics.

### Approach Used
Certainly! Let's break down the approaches used for each of the analyst tasks using SQL:

1. **Top Selling Products by Revenue:**
   - **Approach:**
     - Use the `SELECT` statement to retrieve the product line and the total revenue.
     - Utilize the `SUM()` function to calculate the total revenue for each product line.
     - Group the results by the product line using the `GROUP BY` clause.
     - Order the results in descending order of revenue using the `ORDER BY` clause.

2. **Monthly Revenue Trend Analysis:**
   - **Approach:**
     - Utilize the `DATE_FORMAT()` function to extract the year and month from the transaction date.
     - Use the `SELECT` statement to retrieve the formatted date and the total revenue.
     - Apply the `SUM()` function to calculate the total revenue for each month.
     - Group the results by the formatted date using the `GROUP BY` clause.
     - Order the results chronologically using the `ORDER BY` clause.

3. **Customer Satisfaction Analysis by Gender and Customer Type:**
   - **Approach:**
     - Use the `SELECT` statement to retrieve the gender, customer type, and average rating.
     - Utilize the `AVG()` function to calculate the average rating for each combination of gender and customer type.
     - Group the results by gender and customer type using the `GROUP BY` clause.

Each approach leverages SQL functions and clauses to aggregate and analyze data according to the specific requirements of the analyst tasks.

## Business Questions to Answer

### Generic Questions
1. What is the total revenue generated from each product line in a specific city for a given date range? This question requires you to aggregate data by product line and city while filtering transactions within a specific date range. You'll need to calculate the total revenue for each product line.
2. How does customer satisfaction (rating) vary by gender for different branches? This question involves grouping data by branch and gender, then calculating the average customer satisfaction rating for each group. It allows you to analyze the relationship between gender and customer satisfaction across different branches.
3. What is the average gross margin percentage for transactions made by regular customers compared to new customers? This question requires you to group data by customer type and calculate the average gross margin percentage for each group. It allows you to understand if there's a difference in profitability between regular and new customers.

### Product Questions
Business questions based on "Product Line" attribute that can be answered using SQL with the provided dataset:
1. What are the top three best-selling product lines by revenue?
2. How does the quantity sold for each product line compare to the previous month?
3. What is the average unit price for each product line?
4. Which product line has the highest gross income?
5. How does the tax amount collected for each product line vary across different branches?
6. What is the total cost of goods sold (COGS) for each product line?
7. Which product lines have the highest and lowest average gross margin percentages?
8. How does the quantity sold for each product line vary throughout the week?
9. What is the revenue trend for each product line over the past six months?
10. How does customer satisfaction (rating) correlate with the purchase of specific product lines?
11. Which payment methods are most commonly used for purchasing each product line?
12. How does the average unit price of each product line change over time?

### Sales Questions
Business questions based on sales that can be answered using SQL with the provided attributes:
1. What is the total revenue generated by each branch?
2. How does the quantity sold vary between regular and new customers?
3. What is the distribution of sales by gender across different product lines?
4. Which product line has the highest average unit price?
5. How does the gross income vary between different branches?
6. What is the average gross margin percentage for each city?
7. Which branch has the highest total tax collected?
8. How does the distribution of payment methods vary between product lines?
9. What is the total revenue generated on a specific date?
10. How does the gross margin percentage differ between regular and new customers?
11. What is the average rating given by customers for each product line?
12. How does the quantity sold vary throughout the day?

### Customer Questions
Business questions that a customer can ask, which can be answered using SQL with the provided attributes:
1. What is the total amount I spent on purchases within a specific time frame?
2. Can you provide a breakdown of my purchases by product line?
3. How much tax did I pay on my purchases?
4. What is the average price per unit for the products I bought?
5. Which payment method did I use most frequently for my purchases?
6. What was the total cost of goods sold (COGS) for the products I purchased?
7. What is the average gross margin percentage for the products I bought?
8. Can you show me my purchase history sorted by date?
9. How does my spending vary between different branches or cities?
10. What was the highest and lowest rated purchase I made?
11. How many units of each product did I purchase in total?
12. Can you provide a summary of my purchases by customer type and gender?
These questions allow customers to gain insights into their purchasing behavior, expenditure patterns, product preferences, and overall satisfaction with their transactions. By leveraging SQL, these questions can be answered efficiently using the provided attributes.
