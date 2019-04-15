USE EDDSPerformance
GO
  
IF NOT EXISTS (SELECT TOP 1 ProcessControlID FROM eddsdbo.ProcessControl WHERE ProcessControlID = 8)
BEGIN
	INSERT INTO eddsdbo.ProcessControl (ProcessControlID, ProcessTypeDesc, LastProcessExecDateTime, Frequency)
	VALUES (8, 'Data Table Cleanup', DATEADD(dd, -1, getutcdate()), 1440)
END