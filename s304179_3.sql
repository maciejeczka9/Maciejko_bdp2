DECLARE @YearsAgo int;
SET @YearsAgo = 9;
BEGIN

SELECT b.*,a.CurrencyAlternateKey FROM [dbo].[DimCurrency] a, [dbo].[FactCurrencyRate] b
where a.CurrencyKey = b.CurrencyKey and a.CurrencyAlternateKey in ('GBP','EUR') 
and b.Date <= DATEADD(year, -@YearsAgo, GETDATE())  ;

END;
