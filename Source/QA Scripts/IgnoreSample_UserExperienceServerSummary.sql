USE [EDDSPerformance]
GO
/****** Object:  StoredProcedure [eddsdbo].[QoS_UserExperienceServerReport]    Script Date: 02/12/2015 12:08:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [eddsdbo].[QoS_UserExperienceServerReport]
	@SortColumn VARCHAR(50) = 'Score',
	@SortDirection CHAR(4) = 'ASC',
	@TimezoneOffset INT = 0, --Offset to use (in minutes) for UTC dates
	@StartRow INT = 1,
	@EndRow INT = 25,
	@Server NVARCHAR(150) = NULL,
	@Workspace NVARCHAR(150) = NULL,
	@TotalUsers INT = NULL,
	@TotalSearchAudits INT = NULL,
	@TotalNonSearchAudits INT = NULL,
	@Score INT = NULL,
	@TotalLongRunning INT = NULL,
	@TotalExecutionTime BIGINT = NULL,
	@TotalAudits INT = NULL,
	@SummaryDayHour DATETIME = NULL,
	@IsActiveWeeklySample BIT = NULL
AS
BEGIN
	--Support ArtifactID filtering
	DECLARE @ServerId INT = NULL,
		@WorkspaceId INT = NULL;
	IF (ISNUMERIC(@Server) = 1)
		SET @ServerId = CAST(@Server as int);
	IF (ISNUMERIC(@Workspace) = 1)
		SET @WorkspaceId = CAST(@Workspace as int);	

	--Prepare string filter inputs
	SET @Server = '%' + @Server + '%';
	SET @Workspace = '%' + @Workspace + '%';
	
	DECLARE @Data TABLE
	(
		[RowNumber] INT,
		[TotalRows] INT,
		[ServerArtifactId] INT,
		[Server] NVARCHAR(150),
		[CaseArtifactId] INT,
		[Workspace] NVARCHAR(150),
		[TotalUsers] INT,
		[TotalSearchAudits] INT,
		[TotalNonSearchAudits] INT,
		[Score] INT,
		[TotalLongRunning] INT,
		[TotalExecutionTime] BIGINT,
		[TotalAudits] INT,
		[SummaryDayHour] DATETIME,
		[IsActiveWeeklySample] BIT
	);
	
	WITH Paging AS
	(
	SELECT
		ROW_NUMBER() OVER (
			ORDER BY
			/* STRING COLUMN ORDER BY */
			CASE @SortDirection WHEN 'ASC' THEN
				CASE @SortColumn
					WHEN 'Server' THEN [Server]
					WHEN 'Workspace' THEN [Workspace]
				END
			END ASC,
			CASE @SortDirection WHEN 'DESC' THEN
				CASE @SortColumn
					WHEN 'Server' THEN [Server]
					WHEN 'Workspace' THEN [Workspace]
				END
			END DESC,
			/* BIGINT ORDER BY */
			CASE @SortDirection WHEN 'ASC' THEN
				CASE @SortColumn
					WHEN 'TotalExecutionTime' THEN TotalExecutionTime
				END
			END ASC,
			CASE @SortDirection WHEN 'DESC' THEN
				CASE @SortColumn
					WHEN 'TotalExecutionTime' THEN TotalExecutionTime
				END
			END DESC,
			/* NON-STRING ORDER BY */
			CASE @SortDirection WHEN 'ASC' THEN
				CASE @SortColumn
					WHEN 'Score' THEN Score
					WHEN 'TotalUsers' THEN TotalUsers
					WHEN 'TotalSearchAudits' THEN TotalSearchAudits
					WHEN 'TotalNonSearchAudits' THEN TotalNonSearchAudits
					WHEN 'TotalLongRunning' THEN TotalLongRunning
					WHEN 'TotalAudits' THEN TotalAudits
					WHEN 'SummaryDayHour' THEN SS.SummaryDayHour
				END
			END ASC,
			CASE @SortDirection WHEN 'DESC' THEN
				CASE @SortColumn
					WHEN 'Score' THEN Score
					WHEN 'TotalUsers' THEN TotalUsers
					WHEN 'TotalSearchAudits' THEN TotalSearchAudits
					WHEN 'TotalNonSearchAudits' THEN TotalNonSearchAudits
					WHEN 'TotalLongRunning' THEN TotalLongRunning
					WHEN 'TotalAudits' THEN TotalAudits
					WHEN 'SummaryDayHour' THEN SS.SummaryDayHour
				END
			END DESC
		) AS RowNumber,
		COUNT(*) OVER () TotalRows,
		SS.ServerArtifactID,
		[Server],
		[CaseArtifactID],
		[Workspace],
		[TotalUsers],
		[TotalSearchAudits],
		[TotalNonSearchAudits],
		[Score],
		TotalLongRunning,
		TotalExecutionTime,
		TotalAudits,
		DATEADD(MINUTE, @TimezoneOffset, SS.[SummaryDayHour]) [SummaryDayHour],
		CAST(1 as bit) [IsActiveWeeklySample]
	FROM eddsdbo.QoS_UserExperienceServerSummary SS WITH(NOLOCK)
	--Filter options
	WHERE (@Server IS NULL OR [Server] LIKE @Server OR SS.ServerArtifactID = @ServerId)
	AND (@Workspace IS NULL OR Workspace LIKE @Workspace OR CaseArtifactID = @WorkspaceId)
	AND (@Score IS NULL OR Score = @Score)
	AND (@TotalUsers IS NULL OR TotalUsers = @TotalUsers)
	AND (@TotalSearchAudits IS NULL OR TotalSearchAudits = @TotalSearchAudits)
	AND (@TotalNonSearchAudits IS NULL OR TotalNonSearchAudits = @TotalNonSearchAudits)
	AND (@TotalLongRunning IS NULL OR TotalLongRunning = @TotalLongRunning)
	AND (@TotalExecutionTime IS NULL OR TotalExecutionTime = @TotalExecutionTime)
	AND (@TotalAudits IS NULL OR TotalAudits = @TotalAudits)
	AND (@SummaryDayHour IS NULL OR DATEADD(MINUTE, @TimezoneOffset, SS.[SummaryDayHour]) = @SummaryDayHour)
	)
	INSERT INTO @Data
	SELECT *
	FROM Paging
	WHERE RowNumber BETWEEN @StartRow AND @EndRow
	
	SELECT
		[RowNumber],
		[ServerArtifactId],
		[Server],
		[CaseArtifactId],
		[Workspace],
		[TotalUsers],
		[TotalSearchAudits],
		[TotalNonSearchAudits],
		[Score],
		[TotalLongRunning],
		[TotalExecutionTime],
		[TotalAudits],
		[SummaryDayHour],
		[IsActiveWeeklySample]
	FROM @Data
	
	SELECT TOP 1
		@StartRow AS StartIndex,
		@StartRow + @@ROWCOUNT - 1 AS EndIndex,
		TotalRows AS FilteredCount
	FROM @Data
END