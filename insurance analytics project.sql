use project;
show tables;

select *from brokerage;
select *from fees;
select *from invoice;
select *from meeting;
select *from opportunity;
select *from individual_budgets;

desc brokerage;
desc fees;
desc invoice;
desc meeting;
desc opportunity;
desc individual_budgets;

SELECT branch_name,
SUM(amount) AS total_revenue
FROM invoice
GROUP BY branch_name;

SELECT branch_name,
COUNT(*) AS meeting_count
FROM meeting
GROUP BY branch_name;

SELECT branch,
COUNT(*) AS total_opportunities,
SUM(premium_amount) AS pipeline_value
FROM opportunity
GROUP BY branch;

CREATE VIEW branch_kpi AS
SELECT
i.branch_name,
SUM(i.amount) AS revenue,
COUNT(m.meeting_date) AS meetings
FROM invoice i
LEFT JOIN meeting m
ON i.branch_name = m.branch_name
GROUP BY i.branch_name;

SELECT * FROM branch_kpi;

SELECT
branch,
SUM(CASE WHEN stage='Won' THEN 1 ELSE 0 END) /
COUNT(*) * 100 AS conversion_rate
FROM opportunity
GROUP BY branch;

SELECT 
    Account_Executive,
    COUNT(invoice_number) AS total_invoices
FROM invoice
GROUP BY Account_Executive
ORDER BY total_invoices DESC;

SELECT 
    Account_Executive,
    COUNT(*) AS total_meetings
FROM meeting
GROUP BY Account_Executive
ORDER BY total_meetings DESC;

SELECT 
    Account_Executive,
    SUM(Amount) AS total_revenue
FROM invoice
GROUP BY Account_Executive
ORDER BY total_revenue DESC
LIMIT 4;

SELECT 
    stage,
    SUM(revenue_amount) AS stage_revenue
FROM opportunity
GROUP BY stage
ORDER BY stage_revenue DESC;

SELECT 
    SUM(revenue_amount) AS total_opportunity_revenue
FROM opportunity;

SELECT 
    Account_Executive,
    SUM(revenue_amount) AS opportunity_revenue
FROM opportunity
GROUP BY Account_Executive
ORDER BY opportunity_revenue DESC;

SELECT 
SUM(amount) AS Brokerage_Revenue
FROM brokerage; 

(select income_class ,round(sum(amount),2) as invoiced
from brokerage 
where income_class like "new%" group by income_class)
union
(select income_class ,sum(amount)
from brokerage 
where income_class like "%sell%"
group by income_class)
union
(select income_class ,round(sum(amount),2) from brokerage 
where income_class like "renewal%" 
group by income_class);

(select income_class ,sum(amount) as invoice_new
from invoice 
where income_class like "new%" group by income_class)
union
(select income_class ,sum(amount) as invoice_renewal from invoice 
where income_class like "renewal%" 
group by income_class)
union
(select income_class ,sum(amount) as invoice_cross
from invoice 
where income_class like "%sell%"
group by income_class);

