
update [AdventureWorksDW2019].[dbo].[stg_dimemp] 
set LastName = 'Nowak'
where EmployeeKey = 270;

update [AdventureWorksDW2019].[dbo].[stg_dimemp] 
set TITLE = 'Senior Design Engineer'
where EmployeeKey = 274;

update [AdventureWorksDW2019].[dbo].[stg_dimemp] 
set FIRSTNAME = 'Ryszard'
where EmployeeKey = 275

SELECT * FROM [AdventureWorksDW2019].[dbo].[scd_dimemp];
SELECT * FROM [AdventureWorksDW2019].[dbo].[stg_dimemp];


-------------------
Jaki typ SCD został zaimplementowany w każdej z kwerend w zadaniu numer 5b i c?
5A - typ 1 SCD -> overwrite
5B - typ 2 SCD -> add new row
5C - typ 3 SCD -> add new attribute

Jakie ustawienie i dlaczego miało wpływ na działanie procesu w przypadku kwerendy 5c?
5C -> Change type = Fixed attribute -> warunkuje że warotść w kolumnie nie może sie zmienić, dlatego narzędzie wpadło na bład.