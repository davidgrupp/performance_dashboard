USE EDDSPerformance
GO

IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'eddsdbo' AND TABLE_NAME = 'QoS_Ratings') 
AND NOT EXISTS (SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'QoS_Ratings' AND COLUMN_NAME = 'WeekBackupFrequencyScore')
BEGIN
	ALTER TABLE eddsdbo.QoS_Ratings
	ADD WeekBackupFrequencyScore DECIMAL(5, 2) NULL
	CONSTRAINT DF_Ratings_WeekBackupFrequencyScore DEFAULT 100
END

GO

IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'eddsdbo' AND TABLE_NAME = 'QoS_Ratings') 
AND NOT EXISTS (SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'QoS_Ratings' AND COLUMN_NAME = 'WeekBackupCoverageScore')
BEGIN
	ALTER TABLE eddsdbo.QoS_Ratings
	ADD WeekBackupCoverageScore DECIMAL(5, 2) NULL
	CONSTRAINT DF_Ratings_WeekBackupCoverageScore DEFAULT 100
END

GO

IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'eddsdbo' AND TABLE_NAME = 'QoS_Ratings') 
AND NOT EXISTS (SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'QoS_Ratings' AND COLUMN_NAME = 'WeekDBCCFrequencyScore')
BEGIN
	ALTER TABLE eddsdbo.QoS_Ratings
	ADD WeekDBCCFrequencyScore DECIMAL(5, 2) NULL
	CONSTRAINT DF_Ratings_WeekDBCCFrequencyScore DEFAULT 100
END

GO

IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'eddsdbo' AND TABLE_NAME = 'QoS_Ratings') 
AND NOT EXISTS (SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'QoS_Ratings' AND COLUMN_NAME = 'WeekDBCCCoverageScore')
BEGIN
	ALTER TABLE eddsdbo.QoS_Ratings
	ADD WeekDBCCCoverageScore DECIMAL(5, 2) NULL
	CONSTRAINT DF_Ratings_WeekDBCCCoverageScore DEFAULT 100
END