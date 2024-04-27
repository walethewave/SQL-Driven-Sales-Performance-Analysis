CREATE DATABASE IF NOT EXISTS `Super_Market sales`;
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);
 -- ----------------------------------------------------------------------------------------------------------------------
 -- ------------------------------Feature Engineering---------------------------------------------------------------------
 
 -- ---time_of_day
SELECT 
     time,
     (CASE 
			WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
            WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
            ELSE "Evening"
            END
            ) AS time_of_date
FROM sales; 

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
        CASE 
			WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
            WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
            ELSE "Evening"
		END
        );


-- ---day_name
SELECT
	date,
    DAYNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);


-- --month_name
SELECT 
	date,
    MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- ---------------Generic Questions----------------------------------------------------------

-- --What is the total revenue generated from each product line in a specific city for a given date range? 
SELECT
    city,
    product_line,
    SUM(total) AS total_Revenue
FROM
    sales
WHERE
    date >= '2019-01-01' AND date <= '2019-03-30'
GROUP BY 
    city, product_line
ORDER BY total_revenue DESC;


-- --How does customer satisfaction (rating) vary by gender for different branches?    
SELECT
    branch,
    gender,
    AVG(rating) AS avg_rating
FROM 
    sales
GROUP BY
    branch,
    gender
ORDER BY avg_rating DESC;

-- --What is the average gross margin percentage for transactions made by normal customers compared to member customers?
SELECT 
    customer_type,
    AVG(gross_margin_pct) AS avg_gross_margin_pct
FROM 
    sales
WHERE 
    customer_type IN ('normal', 'member')
GROUP BY 
    customer_type;



-- --------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------Product Questions--------------------------------------------------------------------------------

-- --What are the top three best-selling product lines by revenue?
SELECT
    rating,
    city,
    product_line,
    SUM(total) AS total_Revenue
FROM 
    sales
GROUP BY 
    rating, city, product_line
ORDER BY
    product_line, total_Revenue DESC
LIMIT 3;


-- -- How does the quantity sold for each product line compare to the previous month?
SELECT
    current_month.product_line,
    'March' AS current_month,
    'February' AS previous_month,
    current_month.total_quantity AS current_month_quantity,
    previous_month.total_quantity AS previous_month_quantity,
    current_month.total_quantity - previous_month.total_quantity AS quantity_difference
FROM
    (SELECT
        product_line,
        SUM(quantity) AS total_quantity
    FROM
        sales
    WHERE
        month_name = 'March'
        AND YEAR(date) = 2019
    GROUP BY
        product_line) AS current_month
LEFT JOIN
    (SELECT
        product_line,
        SUM(quantity) AS total_quantity
    FROM
        sales
    WHERE
        month_name = 'February'
        AND YEAR(date) = 2019
    GROUP BY
        product_line) AS previous_month
ON
    current_month.product_line = previous_month.product_line;
    
    
-- --What is the average unit price for each product line?
SELECT 
	product_line,
    rating,
    AVG(unit_price) AS avg_unit_price
FROM 
	sales
GROUP BY 
	rating , product_line
ORDER BY avg_unit_price DESC;


-- --Which product line has the highest gross income
SELECT 
    product_line,
    SUM(quantity * unit_price) AS gross_income
FROM 
    sales
GROUP BY 
    product_line
ORDER BY 
    gross_income DESC
LIMIT 1;


-- --How does the tax amount collected for each product line vary across different branches?
SELECT
    product_line,
    branch,
    SUM(tax_pct) AS total_tax_pct
FROM
    sales
GROUP BY
    product_line,
    branch;
    
    
-- -- What is the total cost of goods sold (COGS) for each product line?
SELECT 
	product_line,
    SUM(cogs) AS total_cogs
FROM 
	sales
GROUP BY product_line;


-- --Which product lines have the highest and lowest average gross margin percentages?
SELECT
    product_line,
    AVG(gross_margin_pct) AS avg_gross_margin_pct
FROM
    sales
GROUP BY
    product_line
ORDER BY
    avg_gross_margin_pct DESC
LIMIT 1; -- Highest average gross margin percentage
-- the second order
SELECT
    product_line,
    AVG(gross_margin_pct) AS avg_gross_margin_pct
FROM
    sales
GROUP BY
    product_line
ORDER BY
    avg_gross_margin_pct ASC
LIMIT 1; -- Lowest average gross margin percentage


-- -- How does the quantity sold for each product line vary throughout the week?
SELECT 
    product_line,
    day_name,
    SUM(quantity) AS total_quantity_sold
FROM 
    sales
WHERE  day_name IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')
GROUP BY 
    product_line,
    day_name
ORDER BY 
    product_line,total_quantity_sold,
    day_name IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') DESC;
-- -- this also another way
SELECT 
    product_line,
    day_name,
    SUM(quantity) AS total_quantity_sold
FROM 
    sales
WHERE  
    day_name IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')
GROUP BY 
    product_line,
    day_name
ORDER BY 
    product_line,
    FIELD(day_name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
    
    
-- --. What is the revenue trend for each product line over the past three months?
SELECT 
    product_line,
    date,
    SUM(total) AS total_revenue
FROM 
    sales
WHERE  
    date >= '2019-01-01' AND date <='2019-03-27' -- Filter for the months January, February, and March of 2019
GROUP BY 
    product_line,
    date
ORDER BY 
    product_line,
    date;
    
    
    -- --How does customer satisfaction (rating) correlate with the purchase of specific product lines?
SELECT 
    product_line,
    AVG(rating) AS avg_rating
FROM 
    sales
GROUP BY 
    product_line
ORDER BY 
    avg_rating DESC;
    
    
-- --Which payment methods are most commonly used for purchasing each product line?
SELECT
	payment,
    product_line,
     COUNT(*) AS frequency
FROM 
	sales
WHERE payment IN ('Cash','Credit card','Ewallet')
GROUP BY 
    product_line, payment
ORDER BY 
    product_line, frequency DESC;
    
    
-- --How does the average unit price of each product line change over time?
SELECT
    product_line,
    date,
    AVG(unit_price) AS avg_unit_price
FROM
    sales
GROUP BY
    product_line,
    date
ORDER BY
    product_line,
    date;




-- ---------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------Sales Question----------------------------------------------------------------------------------



-- --What is the total revenue generated by each branch?
SELECT 
	branch,
    SUM(total) AS total_revenue
FROM 
	sales
GROUP BY 
	branch
ORDER BY total_revenue DESC;


-- --How does the quantity sold vary between normal and member customer?
SELECT
    customer_type,
    SUM(quantity) AS total_quantity_sold
FROM
    sales
WHERE
    customer_type IN ('normal', 'member')
GROUP BY
    customer_type;
    
    
-- --What is the distribution of sales by gender across different product lines?
SELECT
    gender,
    product_line,
    SUM(quantity) AS total_quantity_sold
FROM
    sales
GROUP BY
    gender,
    product_line;
    
    
-- --Which product line has the highest average unit price?
SELECT 
	product_line,
	AVG(unit_price) AS avg_unit_price
FROM 
	sales
GROUP BY product_line
ORDER BY avg_unit_price DESC
LIMIT 1;


-- --How does the gross income vary between different branches?
SELECT 
	branch,
    SUM(gross_income) AS sum_gross_income
FROM 
	sales
GROUP BY branch
ORDER BY sum_gross_income DESC;


-- --What is the average gross margin percentage for each city?
SELECT 
	city,
    AVG(gross_margin_pct) AS avg_gross_margin_pct
FROM 
	sales
GROUP BY city
ORDER BY avg_gross_margin_pct;


-- --Which branch has the highest total tax collected?
SELECT
    branch,
    SUM(tax_pct) AS total_tax_pct_collected
FROM
    sales
GROUP BY
    branch
ORDER BY
    total_tax_pct_collected DESC
LIMIT 1;


-- --How does the distribution of payment methods vary between product lines?
SELECT
    product_line,
    payment,
    COUNT(*) AS method_count
FROM
    sales
GROUP BY
    product_line,
    payment;
    
    
-- --What is the total revenue generated on a specific date?
SELECT 
	date,
    SUM(total) AS total_revenue
FROM 
	sales
Group by 
	date;
    
    
-- --How does the gross margin percentage differ between regular and new customers?
SELECT 
	customer_type,
    SUM(gross_margin_pct) AS sum_gross_margin_pct
FROM sales
GROUP BY customer_type;


-- --What is the average rating given by customers for each product line?
SELECT
	product_line,
    AVG(rating) AS avg_rating
FROM 
	sales
GROUP BY product_line
ORDER BY avg_rating DESC;


-- --How does the quantity sold vary throughout the day?
SELECT 
	time_of_day,
    SUM(quantity) AS sum_quantity
FROM 
	sales
GROUP BY 
	time_of_day
ORDER BY sum_quantity DESC;



-- ----------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------Customer Question-------------------------------------------------------------------------------------


-- --What is the total amount I spent on purchases within a specific time frame?
SELECT 
	product_line,
    date,
    SUM(total) AS sum_total
FROM 
	sales
GROUP BY product_line,date
ORDER BY sum_total;


-- --Can you provide a breakdown of my purchases by product line?
SELECT 
    branch,
    city,
    customer_type,
    product_line,
    SUM(unit_price) AS total_unit_price,
    SUM(quantity) AS total_quantity,
    SUM(total) AS total_amount,
    MAX(date) AS latest_date,
    payment,
    rating
FROM 
    sales
GROUP BY 
    branch,
    city,
    customer_type,
    product_line,
    payment,
    rating;
    
    
-- --What are the total purchases, grouped by product line and tax percentage, and sorted by the total purchases? 
SELECT 
	product_line
    tax_pct,
    SUM(unit_price * quantity) AS total_purchases
FROM
    sales
GROUP BY 
    tax_pct,product_line
ORDER BY 
    total_purchases;
    
    
-- --How much tax did I pay on my purchases?
SELECT 
    SUM(tax_pct) AS total_tax_paid
FROM 
    sales;
    
    
-- --What is the average price per unit for the products I bought?
SELECT 
	product_line,
	AVG(unit_price) AS avg_unit_price
FROM
	sales 
GROUP BY product_line;


-- --Which payment method did I use most frequently for my purchases?
SELECT 
    payment,
    COUNT(*) AS frequency
FROM
    sales
GROUP BY 
    payment
ORDER BY 
    frequency DESC
LIMIT 1;


-- --What is the total cost of goods sold (COGS) for each product line?
SELECT
	product_line,
    SUM(cogs) AS sum_cogs
FROM 
	sales
GROUP BY product_line
ORDER BY sum_cogs;


-- --What was the total cost of goods sold (COGS) for the products I purchased?
SELECT 
    SUM(unit_price * quantity) AS total_cogs
FROM
    sales;
    
    
-- --What is the average gross margin percentage for the products I bought?
SELECT
	AVG(gross_margin_pct) AS avg_gross_margin_pct
FROM
	sales;
    
    
-- --Can you show me my purchase history sorted by date?
SELECT 
    *
FROM 
    sales
ORDER BY 
    date;
    
    
-- --How does my spending vary between different branches or cities?
SELECT 
    branch,
    city,
    SUM(total) AS total_spending
FROM 
    sales
GROUP BY 
    branch, city
ORDER BY 
    total_spending DESC;
    
    
-- --What was the highest and lowest rated purchase I made?
SELECT
	product_line,
    COUNT(*) AS purchase
FROM
	sales
GROUP BY 
	product_line
ORDER BY purchase DESC;
-- ----------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------OR BY RATING--------------------------------------------------------------------------------------------------
SELECT 
    MAX(rating) AS highest_rating,
    MIN(rating) AS lowest_rating
FROM 
    sales;
    
    
-- --How many units of each product did I purchase in total?
SELECT 
    product_line,
    SUM(quantity) AS total_units_purchased
FROM 
    sales
GROUP BY 
    product_line;
    
    
-- --Can you provide a summary of my purchases by customer type and gender?
SELECT
	product_line,
    customer_type,
    gender,
    SUM(unit_price * quantity) AS purchase
FROM 
	sales
WHERE 
    date >= '2019-01-01' AND date <= '2019-03-30'
GROUP BY product_line,customer_type,gender 
ORDER BY purchase;

		
    
    







	



    


    








    

	


    





















































	














    

















