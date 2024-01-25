/* Tracking Running Totals with Window Functions
Business problem: Tracking Sales Quota Progress over Time
The sales team works diligently to sell the product, and they have quotas that they
must reach in order to earn all of their commission. Because these goals are so
intimately tied to revenue, the manager of the team wants to track each sales
member's performance throughout the year. You suggest a % of quota reached
metric that could be displayed on a dashboard, but the sales manager expresses
her concern that a single metric won't give her visibility into their progress
throughout the year. You suggest providing a running total of sales revenue and
a percent quota metric that will be recalculated every time a sales member makes
another sale. She agrees, and you get started!

Task:
Calculate the running total of sales revenue, running total and the % of quota
reached, percent _ quota , for each sales employee on each date they make a sale. */



select 
    s.salesemployeeid,
    s.saledate,
    s.saleamount,
    sum(s.saleamount) over(partition by s.salesemployeeid order by s.saledate asc) as running_total,
    cast(sum(s.saleamount) over(partition by s.salesemployeeid order by s.saledate asc) as float)/e.quota as percent_quota  
from 
    sales s
join
    employees e
on
    s.salesemployeeid = e.employeeid
order by s.salesemployeeid, s.saledate
;
