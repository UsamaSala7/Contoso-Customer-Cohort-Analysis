with base as(select s.customerkey , d.yearmonthnumber, d.yearmonthshort, count(distinct s.orderkey ) orders
from sales s join "date" d on s.orderdate = d."date" 
where d."year" >=2024
group by 1, 2, 3 )
select
a1.yearmonthnumber yearmonthnumber1 ,
	a1.yearmonthshort AS cohort_month,
    a2.yearmonthnumber AS activity_month_number,
    a2.yearmonthshort AS activity_month,
    (a2.yearmonthnumber - a1.yearmonthnumber) AS period_offset,
    COUNT(DISTINCT a1.customerkey) AS customers
from
	base a1
join base a2 on
	a1.customerkey = a2.customerkey
	and a2.yearmonthnumber >= a1.yearmonthnumber
group by
	1,
	2,
	3,
	4,
	5
	order by 1,3
