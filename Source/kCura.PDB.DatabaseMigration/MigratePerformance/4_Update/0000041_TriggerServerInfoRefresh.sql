--Force server info refresh on install
UPDATE [EDDSPerformance].[eddsdbo].[ProcessControl]
SET LastProcessExecDateTime = DATEADD(dd, -1, getutcdate())
WHERE ProcessControlID = 3