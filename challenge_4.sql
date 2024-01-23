/*LinkedIn Learning: Solve RealWorld Data Problems with SQL by Jess Ramos

Creating Binary Columns with CASE

Business problem: Flagging upsell opportunities for the sales team

The product team is launching a new product offering that can be added on top of a current subscription for an increase in the
customer's annual fee. The sales team has decided that they first want to reach out to a select group of customers to offer the new
product and get feedback before offering it to the entire customer base.
They've decided it would be best to reach out to customers who meet one of the following two conditions:
1 . Have at least 5,000 registered users
• Companies with large amounts of users are a significant upsell opportunity, because they can lead to more potential revenue. (More users = More S)
OR
2. Only have one product subscription
• Based on conversations the sales team has had with customers, the companies that already have subscriptions for
two products are not going to be willing to spend more and add onto their current subscriptions.
You decide to help out the sales team by providing them a report with all current customers and the number of product subscriptions
and registered users they currently have. To make it extra easy for the sales team to identify customers that are upsell_opportunity ,
you also include a binary column that flags the customers that meet one of these conditions.

Task:
Create a report using the subscriptions table that contains:
• customerid
• The total number of products for that customer, num _ products
• The total number of users for that customer, total users
• Binary column that flags 1 for those who meet one of the
upsell_opportunity conditions using CASE
In real life, you'd likely have to export this report to Excel to deliver
to the sales team. But you can skip that step for the sake of this
problem!*/

select
    customerid,
    count(productid) as num_products, 
    sum(numberofusers) as total_users,
    case
        when sum(numberofusers) >= 5000 
        or count(productid) = 1 then 1 else 0
    end as upsell_opportunity
    
from
    subscriptions
group by
    customerid;

    -- First of all, I'm checking wich costumers have more than one product by counting the subscriptions per customer. 
--Then the sum of the users is done because both products subscriptions must been considered.
-- In the CASE statement, only costumers with an amount equal/greater than 5000 subscriptions OR only one product are set as upsell_opportunity
-- I ended up using CTE wich I later found out was not exactly necessary.




