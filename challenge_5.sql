
/*LinkedIn Learning: Solve RealWorld Data Problems with SQL by Jess Ramos

Pivoting rows into aggregated columns with CASE

Business problem: Tracking user activity with frontend events

The design team recently redesigned the customer support page on the website, and they want to run an AB test to see how the
newly designed page performs compared to the original. An AB test is a statistical test used frequently in data science to measure
the impact changes have on specified metrics. The users will be randomly assigned into two groups: control and treatment. The
users in control group will see the current customer support page, and the users in treatment will see the new page design. The
analytics team needs to track user activity via frontend events (button clicking, page viewing, etc.) to inform the product team for
future iterations. At the end of the experiment, the results of the control and treatment group will be compared to make a final product recommendation.*/

select 
    userid,
    sum(case when fed.eventid = 1 then 1 else 0 end) as viewedhelpcenterpage,
    sum(case when fed.eventid = 2 then 1 else 0 end) as clickedfaqs, 
    sum(case when fed.eventid = 3 then 1 else 0 end) as clickedcontactsupport,
    sum(case when fed.eventid = 4 then 1 else 0 end) as submittedticket                 
from 
    frontendeventdefinitions fed
join
    frontendeventlog fel
on
    fed.eventid = fel.eventid
where
    eventtype = 'customer support'
group by
    userid;




