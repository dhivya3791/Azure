CREATE PROCEDURE [apr25e].[usp_UpdateLogsStarting]
    @LogID INT,
    @Status NVARCHAR(50),
    @ErrorMessage NVARCHAR(MAX) = NULL
AS
BEGIN
    UPDATE apr25e.PipelineLogs
    SET 
        EndTime = GETUTCDATE(),
        Status = @Status,
        ErrorMessage = @ErrorMessage
    WHERE ID = @LogID;
END
