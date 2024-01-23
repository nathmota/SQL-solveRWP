/*Using self joins to pull hierarchical relationships

Business problem: Pulling employee/manager data with a self join

The VP of sales is currently contacting all of the managers who have direct reports
in the Sales department to notify them of the new commission structure. Using the
table, which contains all employees and their associated manager, you
can pull a report of all sales employees and their manager's email address using a
self join. However, with your sharp thinking, you notice that several employees
have null values for their manager's email address due to the fact that some
employees don't have a manager logged in the database.

Considering that the goal of this business problem is to spread the word about an
important business change that will affect the sales team, you know that null
email addresses won't be useful in the output. I mean...how would you feel if you
weren't notified of this important change because you didn't have a manager
logged for you in the database? We can't always accept null values, and
sometimes we have to recode them or impute them with another value that is
more meaningful for the business. Without bothering the super busy VP with this,
you take the initiative and modify your query so that it replaces all null manager
emails with the employees email. This way, all sales employees without a manager
email will receive the information directly.

Task:
Create an email list from table that includes the following columns
for all employees under department Sales .
- employeeid
- employee name
- manager name
- contact email (use the manager email if available and the employee email if not)*/

select 
    employees.employeeid,
    employees.name as employee_name,
    managers.name as manager_name,
    case 
        when employees.managerid is null then employees.email
        else managers.email
    end as contact_email
from
    employees
left join employees managers
on employees.managerid = managers.employeeid
where employees.department = 'Sales';



