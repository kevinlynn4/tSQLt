IF OBJECT_ID('tSQLt.Private_CleanUpCmdHandler') IS NOT NULL DROP PROCEDURE tSQLt.Private_CleanUpCmdHandler;
GO
---Build+
CREATE PROCEDURE tSQLt.Private_CleanUpCmdHandler
  @CleanUpCmd NVARCHAR(MAX),
  @TestResult NVARCHAR(MAX) OUTPUT,
  @TestMsg NVARCHAR(MAX) OUTPUT,
  @ResultInCaseOfError NVARCHAR(MAX) = 'Error'
AS
BEGIN
  BEGIN TRY
    EXEC(@CleanUpCmd);
  END TRY
  BEGIN CATCH
    SET @TestMsg = (CASE WHEN @TestMsg <> '' THEN @TestMsg + ' [Result: '+ ISNULL(@TestResult,'<NULL>') + '] || ' ELSE '' END) + 'Error during clean up: (' + ERROR_MESSAGE() + ' | Procedure: ' + ISNULL(ERROR_PROCEDURE(),'<NULL>') + ' | Line: ' + CAST(ERROR_LINE() AS NVARCHAR(MAX)) + ' | Severity, State: ' + CAST(ERROR_SEVERITY() AS NVARCHAR(MAX)) + ', ' + CAST(ERROR_STATE() AS NVARCHAR(MAX)) + ')';
    SET @TestResult = @ResultInCaseOfError;
  END CATCH;
END;
GO
