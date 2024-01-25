/* Business problem: Tracking User Payment Funnel Times with
LEAD()
A customer has complained that it took too long for them complete their payment
process due to there being an error with the system. The customer support team
brought this issue up and asked the analytics team to investigate the payment
funnel time data for subscriptionid = 38844.

Task:
Using the paymentstatuslog table, pull payment funnel data for subscriptionid =
38844. For each status timestamp, calculate the time difference between that
timestamp the next chronological timestamp in order to show how long the user
was in each status before moving to the next status. You can use the window
function lead() to pull the next chronological timestamp.
Include the following columns:

• SubscriptionMovementid
• Subscriptionid
• Statusid
• MovementDate
• NextStatusMovementDate
• TimeinStatus */


select 
    statusmovementid,
    subscriptionid,
    statusid,
    movementdate,
    lead(movementdate, 1) 
        over(partition by subscriptionid    
            order by movementdate)
                as NextStatusMovementDate,
    lead(movementdate, 1) 
        over(partition by subscriptionid    
            order by movementdate) - movementdate
                as TimeInStatus
from 
    paymentstatuslog
where
    subscriptionid = '38844'
order by
    movementdate;