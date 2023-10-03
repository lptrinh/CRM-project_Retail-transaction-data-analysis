
#Phan khuc KH theo Member_Account_Code
select [Member Account Code] ,
       case when sum([Sales amt])/23300 >= 50000 then 'Platinum'
            when sum([Sales amt])/23300 < 50000 and sum([Sales amt])/23300 >= 25000 then 'Gold'
            when sum([Sales amt])/23300 < 25000 and sum([Sales amt])/23300 >= 10000 then 'Silver'
            when sum([Sales amt])/23300 < 10000 and sum([Sales amt])/23300 >= 3000 then 'CT'
            else 'Others' end as segmentation
from salesLT.Test_Assesment_Raw
group by [Member Account Code]

#Chon nhung Member_Account_Code theo tung phan khuc
select [Member Account Code] from (
select [Member Account Code] ,
       case when sum([Sales amt])/23300 >= 50000 then 'Platinum'
            when sum([Sales amt])/23300 < 50000 and sum([Sales amt])/23300 >= 25000 then 'Gold'
            when sum([Sales amt])/23300 < 25000 and sum([Sales amt])/23300 >= 10000 then 'Silver'
            when sum([Sales amt])/23300 < 10000 and sum([Sales amt])/23300 >= 3000 then 'CT'
            else 'Others' end as segmentation
from salesLT.Test_Assesment_Raw
group by [Member Account Code] ) pk
where pk.segmentation = 'PLATINUM'// 'GOLD'//'SILVER'//'CT'//'OTHERS'

#Tinh toan SoKH, DT, SGD, SP, ATV, UPT cua 1 phan khuc
select 'Platinum' as segmentation,
       COUNT( (DISTINCT ([Member Account Code])) as Total_Clients,
       ROUND ((SUM  ([Sales Amt])/23500),2) as Total_Sales,
       count(distinct([Invoice])) as total_transaction ,
       SUM( ([sales qty]) as Total_Items_sold ,
       ROUND (((SUM([Sales Amt]/23500))/COUNT(distinct([Invoice]))),2) as ATV,
       ROUND( ((sum([sales qty])/count(distinct([Invoice]))),2) as UPT
from salesLT.Test_Assesment_Raw tar
where tar.[Member Account Code] in (
select [Member Account Code] from (
select [Member Account Code] ,
       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
            else 'Others' end as segmentation
from salesLT.Test_Assesment_Raw
group by [Member Account Code] ) pk
where segmentation = 'PLATINUM') 

#Giao dich >2sp tung phan khuc
select [Invoice] , sum([Sales Qty]) as items from salesLT.Test_Assesment_Raw
where [Member Account Code] in (
	select [Member Account Code] from (
		select [Member Account Code] ,
		       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
		            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
		            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
		            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
		            else 'Others' end as segmentation
		from salesLT.Test_Assesment_Raw
		group by [Member Account Code] ) pk
	where segmentation = 'PLATINUM' )
group by [Invoice]
having sum([Sales Qty]) >= 2

#Tinh so giao dich >2sp tung phan khuc
select 'Platinum' as Segmentation ,
       count([Invoice]) as transaction_morethan_2
from (
	select [Invoice] , sum([Sales Qty]) as items from salesLT.Test_Assesment_Raw
	where [Member Account Code] in (
		select [Member Account Code] from (
			select [Member Account Code] ,
			       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
			            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
			            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
			            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
			            else 'Others' end as segmentation
			from salesLT.Test_Assesment_Raw
			group by [Member Account Code] ) pk
		where segmentation = 'PLATINUM' )
	group by [Invoice]
	having sum([Sales Qty]) >= 2
 ) A
 #Join 2 bang lai voi nhau de tinh cho 1 phan khuc
select * from
 (select 'Platinum' as segmentation,
       COUNT(DISTINCT ([Member Account Code])) as Total_Clients,
       ROUND ((SUM  ([Sales Amt])/23500),2) as Total_Sales,
       count(distinct([Invoice])) as total_transaction ,
       SUM([sales qty]) as Total_Items_sold ,
       ROUND (((SUM([Sales Amt]/23500))/COUNT(distinct([Invoice]))),2) as ATV,
       ROUND((sum([sales qty])/count(distinct([Invoice]))),2) as UPT
from salesLT.Test_Assesment_Raw tar
where tar.[Member Account Code] in (
select [Member Account Code] from (
select [Member Account Code] ,
       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
            else 'Others' end as segmentation
from salesLT.Test_Assesment_Raw
group by [Member Account Code] ) pk
where segmentation = 'PLATINUM'))TableA
join(
select 'Platinum' as Segmentation ,
       count([Invoice]) as transaction_morethan_2
from (
	select [Invoice] , sum([Sales Qty]) as items from salesLT.Test_Assesment_Raw
	where [Member Account Code] in (
		select [Member Account Code] from (
			select [Member Account Code] ,
			       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
			            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
			            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
			            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
			            else 'Others' end as segmentation
			from salesLT.Test_Assesment_Raw
			group by [Member Account Code] ) pk
		where segmentation = 'PLATINUM' )
	group by [Invoice]
	having sum([Sales Qty]) >= 2
 ) A)TableB
 on TableA.segmentation=TableB.segmentation
 
#Tinh tong cac chi so tren
select A.* , B.transaction_morethan_2 from (
select 'Total' as segmentation,
       count(distinct([Member Account Code])) as Total_Clients,
       round(sum([sales Amt])/23500,2) as total_sales ,
       count(distinct([Invoice])) as total_transaction ,
       sum([sales qty]) as Total_Items_sold ,
       round((sum([sales Amt])/count(distinct([Invoice])))/23500,2) as ATV,
       round((sum([sales qty])/count(distinct([Invoice]))),2) as UPT
from salesLT.Test_Assesment_Raw C ) A
join
(select 'Total' as segmentation ,count(invoice) as transaction_morethan_2 from (
select [invoice] , sum([sales qty]) as items from salesLT.Test_Assesment_Raw
group by [invoice]
having sum([sales qty]) >= 2  ) A ) B on A.segmentation = B.segmentation

#Union tat ca phan khuc lai voi nhau
select * from
 (select 'Platinum' as segmentation,
       COUNT(DISTINCT ([Member Account Code])) as Total_Clients,
       ROUND ((SUM  ([Sales Amt])/23500),2) as Total_Sales,
       count(distinct([Invoice])) as total_transaction ,
       SUM([sales qty]) as Total_Items_sold ,
       ROUND (((SUM([Sales Amt]/23500))/COUNT(distinct([Invoice]))),2) as ATV,
       ROUND((sum([sales qty])/count(distinct([Invoice]))),2) as UPT
from salesLT.Test_Assesment_Raw tar
where tar.[Member Account Code] in (
select [Member Account Code] from (
select [Member Account Code] ,
       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
            else 'Others' end as segmentation
from salesLT.Test_Assesment_Raw
group by [Member Account Code] ) pk
where segmentation = 'PLATINUM'))TableA
join(
select 'Platinum' as Segmentation ,
       count([Invoice]) as transaction_morethan_2
from (
	select [Invoice] , sum([Sales Qty]) as items from salesLT.Test_Assesment_Raw
	where [Member Account Code] in (
		select [Member Account Code] from (
			select [Member Account Code] ,
			       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
			            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
			            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
			            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
			            else 'Others' end as segmentation
			from salesLT.Test_Assesment_Raw
			group by [Member Account Code] ) pk
		where segmentation = 'PLATINUM' )
	group by [Invoice]
	having sum([Sales Qty]) >= 2
 ) A)TableB
 on TableA.segmentation=TableB.segmentation
 UNION 
 select * from
 (select 'Gold' as segmentation,
       COUNT(DISTINCT ([Member Account Code])) as Total_Clients,
       ROUND ((SUM  ([Sales Amt])/23500),2) as Total_Sales,
       count(distinct([Invoice])) as total_transaction ,
       SUM([sales qty]) as Total_Items_sold ,
       ROUND (((SUM([Sales Amt]/23500))/COUNT(distinct([Invoice]))),2) as ATV,
       ROUND((sum([sales qty])/count(distinct([Invoice]))),2) as UPT
from salesLT.Test_Assesment_Raw tar
where tar.[Member Account Code] in (
select [Member Account Code] from (
select [Member Account Code] ,
       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
            else 'Others' end as segmentation
from salesLT.Test_Assesment_Raw
group by [Member Account Code] ) pk
where segmentation = 'GOLD'))TableA
join(
select 'Gold' as Segmentation ,
       count([Invoice]) as transaction_morethan_2
from (
	select [Invoice] , sum([Sales Qty]) as items from salesLT.Test_Assesment_Raw
	where [Member Account Code] in (
		select [Member Account Code] from (
			select [Member Account Code] ,
			       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
			            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
			            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
			            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
			            else 'Others' end as segmentation
			from salesLT.Test_Assesment_Raw
			group by [Member Account Code] ) pk
		where segmentation = 'GOLD' )
	group by [Invoice]
	having sum([Sales Qty]) >= 2
 ) A)TableB
 on TableA.segmentation=TableB.segmentation
 UNION 
 select * from
 (select 'Silver' as segmentation,
       COUNT(DISTINCT ([Member Account Code])) as Total_Clients,
       ROUND ((SUM  ([Sales Amt])/23500),2) as Total_Sales,
       count(distinct([Invoice])) as total_transaction ,
       SUM([sales qty]) as Total_Items_sold ,
       ROUND (((SUM([Sales Amt]/23500))/COUNT(distinct([Invoice]))),2) as ATV,
       ROUND((sum([sales qty])/count(distinct([Invoice]))),2) as UPT
from salesLT.Test_Assesment_Raw tar
where tar.[Member Account Code] in (
select [Member Account Code] from (
select [Member Account Code] ,
       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
            else 'Others' end as segmentation
from salesLT.Test_Assesment_Raw
group by [Member Account Code] ) pk
where segmentation = 'SILVER'))TableA
join(
select 'Silver' as Segmentation ,
       count([Invoice]) as transaction_morethan_2
from (
	select [Invoice] , sum([Sales Qty]) as items from salesLT.Test_Assesment_Raw
	where [Member Account Code] in (
		select [Member Account Code] from (
			select [Member Account Code] ,
			       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
			            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
			            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
			            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
			            else 'Others' end as segmentation
			from salesLT.Test_Assesment_Raw
			group by [Member Account Code] ) pk
		where segmentation = 'SILVER' )
	group by [Invoice]
	having sum([Sales Qty]) >= 2
 ) A)TableB
 on TableA.segmentation=TableB.segmentation
 UNION 
 select * from
 (select 'CT' as segmentation,
       COUNT(DISTINCT ([Member Account Code])) as Total_Clients,
       ROUND ((SUM  ([Sales Amt])/23500),2) as Total_Sales,
       count(distinct([Invoice])) as total_transaction ,
       SUM([sales qty]) as Total_Items_sold ,
       ROUND (((SUM([Sales Amt]/23500))/COUNT(distinct([Invoice]))),2) as ATV,
       ROUND((sum([sales qty])/count(distinct([Invoice]))),2) as UPT
from salesLT.Test_Assesment_Raw tar
where tar.[Member Account Code] in (
select [Member Account Code] from (
select [Member Account Code] ,
       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
            else 'Others' end as segmentation
from salesLT.Test_Assesment_Raw
group by [Member Account Code] ) pk
where segmentation = 'CT'))TableA
join(
select 'CT' as Segmentation ,
       count([Invoice]) as transaction_morethan_2
from (
	select [Invoice] , sum([Sales Qty]) as items from salesLT.Test_Assesment_Raw
	where [Member Account Code] in (
		select [Member Account Code] from (
			select [Member Account Code] ,
			       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
			            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
			            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
			            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
			            else 'Others' end as segmentation
			from salesLT.Test_Assesment_Raw
			group by [Member Account Code] ) pk
		where segmentation = 'CT' )
	group by [Invoice]
	having sum([Sales Qty]) >= 2
 ) A)TableB
 on TableA.segmentation=TableB.segmentation
 UNION 
 select * from
 (select 'Others' as segmentation,
       COUNT(DISTINCT ([Member Account Code])) as Total_Clients,
       ROUND ((SUM  ([Sales Amt])/23500),2) as Total_Sales,
       count(distinct([Invoice])) as total_transaction ,
       SUM([sales qty]) as Total_Items_sold ,
       ROUND (((SUM([Sales Amt]/23500))/COUNT(distinct([Invoice]))),2) as ATV,
       ROUND((sum([sales qty])/count(distinct([Invoice]))),2) as UPT
from salesLT.Test_Assesment_Raw tar
where tar.[Member Account Code] in (
select [Member Account Code] from (
select [Member Account Code] ,
       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
            else 'Others' end as segmentation
from salesLT.Test_Assesment_Raw
group by [Member Account Code] ) pk
where segmentation = 'OTHERS'))TableA
join(
select 'Others' as Segmentation ,
       count([Invoice]) as transaction_morethan_2
from (
	select [Invoice] , sum([Sales Qty]) as items from salesLT.Test_Assesment_Raw
	where [Member Account Code] in (
		select [Member Account Code] from (
			select [Member Account Code] ,
			       case when sum([Sales amt])/23500 >= 50000 then 'Platinum'
			            when sum([Sales amt])/23500 < 50000 and sum([Sales amt])/23500 >= 25000 then 'Gold'
			            when sum([Sales amt])/23500 < 25000 and sum([Sales amt])/23500 >= 10000 then 'Silver'
			            when sum([Sales amt])/23500 < 10000 and sum([Sales amt])/23500 >= 3000 then 'CT'
			            else 'Others' end as segmentation
			from salesLT.Test_Assesment_Raw
			group by [Member Account Code] ) pk
		where segmentation = 'OTHERS' )
	group by [Invoice]
	having sum([Sales Qty]) >= 2
 ) A)TableB
 on TableA.segmentation=TableB.segmentation
 
# Top_10_Member_Account_Code:	
	#1.By_Sales_Quantity
select [Member Account Code] , sum([Sales Qty]) as Sales_Quantity
from SalesLT.Test_Assesment_Raw tar 
group by [Member Account Code] 
order by sum([Sales Qty]) desc
	2. By Sales Amount
select [Member Account Code] , sum([Sales amt]) as Sales_Amount
from SalesLT.Test_Assesment_Raw tar 
group by [Member Account Code] 
order by sum([Sales amt]) desc

#Analyze_by_Scheme Name	
	#1.By_Sales_Quantity
select [Scheme Name] , sum([Sales Qty]) as Sales_Quantity
from SalesLT.Test_Assesment_Raw tar 
group by [Scheme Name]
order by sum([Sales Qty]) desc
	#2._By_Sales_Amount
select [Scheme Name] , sum([Sales amt]) as Sales_Amount
from SalesLT.Test_Assesment_Raw tar 
group by [Scheme Name]
order by sum([Sales amt]) desc

#Top 10 Items sold	
	#1.By_Sales_Quantity
select  [Item Name]  , sum([Sales Qty]) as Sales_Quantity
from SalesLT.Test_Assesment_Raw tar 
group by [Item Name]
order by sum([Sales Qty]) desc
	#2._By_Sales_Amount
select [Item Name] , sum([Sales amt]) as Sales_Amount
from SalesLT.Test_Assesment_Raw tar 
group by [Item Name]
order by sum([Sales amt]) desc