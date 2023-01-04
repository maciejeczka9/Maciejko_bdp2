with dane as 
(
SELECT * FROM 
(
SELECT row_number() OVER (order by getdate()) as ROWID, * FROM AdventureWorksDW2019.dbo.stg_customers
) T
)
UPDATE  
dane
SET email=null where ROWID = ?;

SELECT * FROM 
(
SELECT row_number() OVER (order by getdate()) as ROWID, * FROM AdventureWorksDW2019.dbo.stg_customers
) T