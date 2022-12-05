BEGIN 
drop table if exists AdventureWorksDW2019.dbo.stg_dimemp ;

SELECT de.EmployeeKey EMPLOYEEKEY, de.FIRSTNAME, de.LASTNAME, de.TITLE 
INTO AdventureWorksDW2019.dbo.stg_dimemp
FROM AdventureWorksDW2019.dbo.DimEmployee de
where EmployeeKey between 270 and 275
; 

ALTER TABLE AdventureWorksDW2019.dbo.stg_dimemp
ADD CONSTRAINT primary_key_empkey PRIMARY KEY (EmployeeKey);
END

SELECT * FROM AdventureWorksDW2019.dbo.stg_dimemp;

BEGIN 
drop table if exists AdventureWorksDW2019.dbo.scd_dimemp ;

CREATE TABLE AdventureWorksDW2019.dbo.scd_dimemp 
( EmployeeKey int , 
FirstName nvarchar(50) not null, 
LastName nvarchar(50) not null, 
Title nvarchar(50), 
StartDate datetime, 
EndDate datetime, 
PRIMARY KEY(EmployeeKey) );


SELECT * FROM AdventureWorksDW2019.dbo.scd_dimemp;
END;