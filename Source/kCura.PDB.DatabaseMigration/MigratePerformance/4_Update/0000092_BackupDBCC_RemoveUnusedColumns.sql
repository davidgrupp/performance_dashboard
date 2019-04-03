USE EDDSResource
GO

IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'kIE_BackResults' AND TABLE_SCHEMA = 'dbo')
BEGIN
	IF COL_LENGTH('dbo.kIE_BackResults', 'DaysSinceToday') IS NOT NULL
	BEGIN
		ALTER TABLE dbo.kIE_BackResults
		DROP COLUMN DaysSinceToday
	END
END

GO

IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'kIE_DBCCResults' AND TABLE_SCHEMA = 'dbo')
BEGIN
	IF COL_LENGTH('dbo.kIE_DBCCResults', 'DaysSinceToday') IS NOT NULL
	BEGIN
		ALTER TABLE dbo.kIE_DBCCResults
		DROP COLUMN DaysSinceToday
	END
END