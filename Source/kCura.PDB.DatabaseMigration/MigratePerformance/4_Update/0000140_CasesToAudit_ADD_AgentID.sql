USE EDDSPerformance
GO

IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'eddsdbo' AND TABLE_NAME = 'QoS_CasesToAudit') 
AND NOT EXISTS (SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'QoS_CasesToAudit' AND COLUMN_NAME = 'AgentID')
BEGIN
	ALTER TABLE eddsdbo.QoS_CasesToAudit
	ADD [AgentID] VARCHAR(10)
END