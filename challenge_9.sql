/*Using Self Joins to Compare Rows Within the Same Table

Business problem: Comparing MoM Revenue

It's time for end-of-year reporting, and your manager wants you to put
together a slide deck summarizing the top revenue highlights of the year and
present it to the whole company on the all-hands call. Among other metrics
and insights, your manager suggests that you highlight months where
revenue was up month-over-month (MoM). In other words, she wants you to
highlight the months where revenue was up from the previous month. You
know this can be done with window functions using lead or lag (see the
window functions chapter of this course), but you decide to exercise your self
join skills to accomplish the task.
This problem is definitely a hard one to solve, so don't get discouraged if it's challenging!

Task:
Using the monthly _ revenue CTE joined to itself, pull a report that includes the following fields:
current month : the current month
previous_month : the previous month from the current month
cur rent_revenue : the monthly revenue of the current month
previous _ revenue : the monthly revenue of the previous month
Only pull rows where the monthly revenue for the current month is
greater than the revenue for the previous month.*/

with monthly_revenue as(
select 
    date_trunc('month', orderdate) as order_month, 
    sum(revenue) as monthly_revenue
from 
    subscriptions
group by 
    date_trunc('month', orderdate)
    order by date_trunc('month', orderdate)
)

select 
    current.order_month as current_month,
    previous.order_month as previous_month,
    current.monthly_revenue as current_revenue,    
    previous.monthly_revenue as previous_revenue
from 
    monthly_revenue current
left join
    monthly_revenue previous
where
    datediff('month', previous.order_month, current.order_month) = 1
    and current.monthly_revenue > previous.monthly_revenue
;





