USE EDDSPerformance
GO

IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'QoS_UserExperienceRatings' AND TABLE_SCHEMA = N'EDDSDBO') 
BEGIN
	CREATE TABLE EDDSDBO.QoS_UserExperienceRatings
	(
		Id INT IDENTITY ( 1 , 1 ),PRIMARY KEY (Id)
		,SummaryDayHour datetime NOT NULL
		,ArrivalRateUXScore DECIMAL (10, 3) NOT NULL
		,ConcurrencyUXScore DECIMAL (10, 3) NOT NULL
		,ServerArtifactId INT NOT NULL
	)
END
GO