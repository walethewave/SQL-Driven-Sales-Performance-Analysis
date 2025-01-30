
# **SQL-Driven Sales Performance Analysis**

## **Overview**
This project leverages **SQL** and **data analytics** to uncover **consumer behavior** and **retail trends** using supermarket sales data. By analyzing key metrics such as revenue, customer satisfaction, and product performance, this project provides actionable insights to optimize sales strategies, improve customer satisfaction, and drive revenue growth.

---

## **Key Objectives**
1. **Identify Top-Selling Products**: Determine the best-performing products by revenue.
2. **Analyze Revenue Trends**: Track monthly revenue trends to understand seasonal variations.
3. **Evaluate Customer Satisfaction**: Assess customer satisfaction by gender and customer type.
4. **Optimize Sales Strategies**: Use data-driven insights to enhance sales performance.

---

## **Dataset Overview**
The dataset includes the following attributes:
- **Invoice ID**: Unique identifier for each transaction.
- **Branch**: Location of the transaction.
- **City**: City where the branch is located.
- **Customer Type**: Regular or new customer.
- **Gender**: Gender of the customer.
- **Product Line**: Category of the product purchased.
- **Unit Price**: Price per unit of the product.
- **Quantity**: Number of units purchased.
- **Tax 5%**: Tax applied to the transaction.
- **Total**: Total cost of the transaction (including tax).
- **Date**: Date of the transaction.
- **Time**: Time of the transaction.
- **Payment**: Payment method used (e.g., credit card, cash).
- **COGS (Cost of Goods Sold)**: Direct costs of the products sold.
- **Gross Margin Percentage**: Profit margin percentage.
- **Gross Income**: Total profit from the transaction.
- **Rating**: Customer satisfaction rating.

---

## **Analyst Tasks**
### **1. Top-Selling Products by Revenue**
- **Objective**: Identify the top-selling products based on revenue.
- **SQL Approach**:
  ```sql
  SELECT Product_Line, SUM(Total) AS Revenue
  FROM SalesData
  GROUP BY Product_Line
  ORDER BY Revenue DESC;
  ```

### **2. Monthly Revenue Trend Analysis**
- **Objective**: Analyze revenue trends over time.
- **SQL Approach**:
  ```sql
  SELECT DATE_FORMAT(Date, '%Y-%m') AS Month, SUM(Total) AS Revenue
  FROM SalesData
  GROUP BY Month
  ORDER BY Month;
  ```

### **3. Customer Satisfaction Analysis by Gender and Customer Type**
- **Objective**: Evaluate customer satisfaction by demographic.
- **SQL Approach**:
  ```sql
  SELECT Gender, Customer_Type, AVG(Rating) AS Avg_Rating
  FROM SalesData
  GROUP BY Gender, Customer_Type;
  ```

---

## **Key Insights**
1. **Top-Selling Products**:
   - Identified the **top 3 product lines** by revenue, enabling targeted marketing and inventory management.
2. **Revenue Trends**:
   - Uncovered **seasonal patterns** in sales, helping to anticipate demand fluctuations.
3. **Customer Satisfaction**:
   - Found that **female customers** and **regular customers** tend to give higher ratings, suggesting opportunities for personalized marketing.

---

## **Business Applications**
1. **Inventory Management**:
   - Focus on high-revenue products to maximize profitability.
2. **Marketing Strategies**:
   - Tailor campaigns based on customer demographics and satisfaction levels.
3. **Sales Forecasting**:
   - Use revenue trends to predict future sales and adjust strategies accordingly.

---

## **How to Use This Repository**
### **1. Clone the Repository**
```bash
git clone https://github.com/walethewave/SQL-Driven-Sales-Performance-Analysis.git
```

### **2. Explore the SQL Scripts**
- **Sales Data 101.sql**: Contains SQL queries for analyzing sales data.
- **Sales Power BI Dashboard.pbix**: Power BI dashboard for visualizing insights.

### **3. Run the Queries**
- Use a SQL client (e.g., MySQL, PostgreSQL) to execute the queries and analyze the results.

---



---

## **Contributing**
Feel free to contribute to this project by:
- Reporting issues
- Suggesting improvements
- Submitting pull requests

---

## **Contact**
For questions or collaborations, reach out to me at Lekanolawale477@gmail.com or connect with me on [LinkedIn](https://www.linkedin.com/in/olawale-goodluck-691114255/).

