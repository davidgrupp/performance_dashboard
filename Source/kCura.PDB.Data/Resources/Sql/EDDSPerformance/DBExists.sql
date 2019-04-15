SELECT CAST(
	CASE WHEN EXISTS(
		SELECT name FROM [master].[dbo].[sysdatabases] WHERE [name] = 'EDDSPerformance') 
		THEN 1 
		ELSE 0 
   END 
AS BIT)