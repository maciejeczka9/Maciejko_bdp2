SELECT  a.OrderDate, count(a.OrderDate) Orders_cnt FROM [AdventureWorksDW2019].[dbo].[FactInternetSales] a 
group by a.OrderDate
ORder by Orders_cnt DESC;


SELECT  a.OrderDate, count(a.OrderDate) Orders_cnt FROM [AdventureWorksDW2019].[dbo].[FactInternetSales] a 
group by a.OrderDate
having count(a.OrderDate) <100
order by Orders_cnt DESC;


SELECT e.OrderDate, e.UnitPrice FROM 
(
SELECT  a.OrderDate, 
 ROW_NUMBER() OVER(PARTITION BY OrderDate
 ORDER BY UnitPrice DESC) AS "Row Number",
 UnitPrice
 FROM [AdventureWorksDW2019].[dbo].[FactInternetSales] a 

 ) e where [Row Number] <4
 order by OrderDate;