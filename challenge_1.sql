/*LinkedIn Learning: Solve RealWorld Data Problems with SQL by Jess Ramos

CTE practice:

Calculating descriptive statistics for monthly revenue by product.

Business problem:
The leadership team at your company is making goals for 2023 and
wants to understand how much revenue each of the product
subscriptions, basic and expert , are generating each month. More
specifically, they want to understand the distribution of monthly
revenue across the past year, 2022.
They've asked you the following questions:
1 . How much revenue does each product usually generate each
month?
2. Which product had the most success throughout all of last year?


Task:
Using a CTE and the subscriptions and products tables, calculate
the:
• minimum monthly revenue: min _ rev
• maximum monthly revenue: max_rev
• average monthly revenue: avg_rev
• standard deviation of monthly revenue: std dev_rev for each product, ProductName.*/

with monthly_rev as (
select 
    t1.productname,
    date_trunc('month', t2.orderdate) as month,
    sum(t2.revenue) as total_revenue
from 
    subscriptions t2
join 
    products t1 
on 
    t1.productid = t2.productid
where 
    extract(year from t2.orderdate) = 2022
group by 
    t1.productname, 
    date_trunc('month',
    t2.orderdate)
)

select 
    productname,
    min(total_revenue) as min_rev,
    max(total_revenue) as max_rev,
    avg(total_revenue) as avg_rev,
    stddev(total_revenue) as std_dev_rev
from 
    monthly_rev
group by 
    productname;