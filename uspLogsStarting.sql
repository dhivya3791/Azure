CREATE PROCEDURE [apr25e].[uspLogsStarting]
    @p_ADFName NVARCHAR(100),
    @p_parent_id INT = NULL,
    @p_PipelineName NVARCHAR(100),
    @p_RunID NVARCHAR(100),
    @p_StartTime DATETIME
AS
BEGIN
    INSERT INTO apr25e.PipelineLogs (ADFName, ParentID, PipelineName, RunID, StartTime, Status)
    VALUES (@p_ADFName, @p_parent_id, @p_PipelineName, @p_RunID, @p_StartTime, 'In Progress');

    SELECT SCOPE_IDENTITY() AS id;
END
