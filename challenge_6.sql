
/* Combining Multiple Tables using UNION

Business problem: Combining 2 Product Tables into 1
The chief growth officer is focused on reducing churn, or the number of customers
that don't renew their annual subscription. She is planning to launch multiple
product experiments and marketing campaigns throughout 2023 to drive users to
renew their subscriptions. She's first conducting research to understand the
potential impact that the churn initiative can have on the business. She reaches out
to your team and asks when all active subscriptions are going to expire.
Because of data modeling limitations, your company was prevented from putting
both products in the same table, so there are currently separate tables for each
product, subscriptionsproductl and subscriptionsproduct2 .

Task:
Count the number of active subscriptions, active
= 1 that will expire in each year.
I've already given you the code that aggregates the number of subscriptions by
year, but if you want, you can write it yourself. Either way, you'll need to write the
code for the all subscriptions CTE.*/

with all_subscriptions as (
    select 
        subscriptionid,
        expirationdate
    from 
        subscriptionsproduct2

    union all

    select 
        subscriptionid,
        expirationdate         
    from 
        subscriptionsproduct1
)

select 
    date_trunc('year', expirationdate) as exp_year,
    count(subscriptionid) as subscriptions
from 
    all_subscriptions
where active = 1
group by exp_year;