/*LinkedIn Learning: Solve RealWorld Data Problems with SQL by Jess Ramos

CTE practice:

Payment funnel analysis with multiple CTEs

Business problem:
The product manager has requested a payment funnel analysis from the analytics team; she wants to understand what the furthest point in the payment process users are getting to and
where users are falling out of the process. She wants to have full visibility into each possible stage of the payment process from the user's point of view.
Here's the payment process a user goes through when signing up for a subscription:

1 . The user opens the widget to initiate payment process.
2. The user types in credit card information.
3. The user clicks the submit button to complete their part of the
payment process.
4. The product sends the data to the third-party payment
processing company.
5. The payment company completes the transaction and reports
back with "complete."
Task:
Count the number of subscriptions in each paymentfunnelstage as
outlined in the code that I've given you by incorporating the the
maxstatus reached and currentstatus per subscription. Use the
paymentstatuslog and subscriptions tables.*/

with max_status as (
select 
	subscriptionid, 
	max(statusid) as maxstatus
from 
	paymentstatuslog
group by subscriptionid
),

payment_stages as (
select 
	s.subscriptionid,
	m.maxstatus,
	s.currentstatus
from
	subscriptions s
left join  
	max_status m
on 
	s.subscriptionid = m.subscriptionid
)

select   
  case 
  	
    when maxstatus = 1 then 'paymentwidgetopened'
    when maxstatus = 2 then 'paymententered'
    when maxstatus = 3 and currentstatus = 0 then 'user error with payment submission'
    when maxstatus = 3 and currentstatus != 0 then 'payment submitted'
    when maxstatus = 4 and currentstatus = 0 then 'payment processing error with vendor'
    when maxstatus = 4 and currentstatus != 0 then 'payment success'
    when maxstatus = 5 then 'complete'
	when maxstatus is null then 'user did not start the payment process'
    
  end as paymentfunnelstage,
  count(subscriptionid) as subscriptions
from 
  payment_stages
group by
	paymentfunnelstage;




