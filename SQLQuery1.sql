select * from dbo.pizza_sales;
-- The sum of the total price of all pizza orders
select sum(total_price) as Total_Revenue from pizza_sales;
-- The average amount spent per order. calculated by dividing the total revenue by the total number of orders
select sum(total_price)/ count(distinct order_id) as Average_order_value from pizza_sales;
-- The sum of the  quantities of all pizza sold
select sum(quantity) as Total_pizza_sold from pizza_sales;
-- Total Orders 
select count(distinct order_id) as Total_orders from pizza_sales;
-- The average number of pizzas sold per order
select sum(quantity)/count(distinct order_id) as Avg_pizza_per_order from pizza_sales;
-- Total orders per day
select datename(DW, order_date) as order_day, 
count(distinct order_id) as Total_orders 
from pizza_sales 
group by datename(DW, order_date);
-- Total orders per month
select datename(month, order_date) as Month_name, 
count(distinct order_id) as Total_orders 
from pizza_sales 
group by datename(month, order_date) 
order by Total_orders desc;
-- percentage of sales by pizza category
select pizza_category,
sum(total_price) as Total_price, 
sum(total_price) * 100 / (select sum(total_price) from pizza_sales 
where month(order_date) = 1) as PCT 
from pizza_sales
where month(order_date) = 1 
group by pizza_category;
-- percentage of sales by pizza size
select pizza_size,
cast(sum(total_price) as decimal(10,2)) as Total_sales, 
cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales
where datepart(quarter, order_date) = 1) as decimal(10,2)) as PCT
from pizza_sales
group by pizza_size
order by PCT desc;
-- Top 5 Best sellers by Revenue, Total Quantity and total orders
select Top 5 pizza_name, count(distinct order_id) as Total_orders from pizza_sales
group by pizza_name
order by Total_Orders;