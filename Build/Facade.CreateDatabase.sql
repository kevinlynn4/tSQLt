:SETVAR NewDbName tSQLtFacade

GO
IF(DB_ID('$(NewDbName)') IS NOT NULL)
BEGIN
  EXEC('
    ALTER DATABASE $(NewDbName) SET RESTRICTED_USER WITH ROLLBACK IMMEDIATE;
    USE $(NewDbName);
    ALTER DATABASE $(NewDbName) SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    USE tempdb;
    DROP DATABASE $(NewDbName);
  ');
END
GO
CREATE DATABASE $(NewDbName) COLLATE SQL_Latin1_General_CP1_CS_AS WITH TRUSTWORTHY OFF;
-- COLLATE SQL_Latin1_General_CP1_CS_AS
GO
ALTER AUTHORIZATION ON DATABASE::$(NewDbName) TO [tSQLt.Build]; 
GO
