/*
-- This T-SQL script restores an encrypted database backup on a 
-- different SQL Server instance than the original where the backup was taken.
-- 
-- This script is based on the script CreateDBBackupCertificate.sql
--
-- This script is part of a technical article on SQLNetHub. 
-- For more info please visit: https://www.sqlnethub.com/2017/08/encrypting-a-sql-server-backup-set/
*/

--Recreate master DB key on destination SQL Server instance
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'PASSWORD_GOES_HERE!';
GO

--Restore the Certificate Based on the Previously Exported Key/Cert files
CREATE CERTIFICATE DBBackupEncryptCert1
FROM FILE = 'c:\tmp\DBBackupEncryptCert1.cert'
WITH PRIVATE KEY (FILE = 'c:\tmp\DBBackupCertKey',
DECRYPTION BY PASSWORD = 'PASSWORD_GOES_HERE!');
GO

--Restore Encrypted Database 'TestDB1'
RESTORE DATABASE [TestDB1]
FROM DISK = 'c:\tmpBackups\TestDB1.bak'
WITH MOVE 'TestDB1' TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\TestDB1_Data.mdf', 
MOVE 'TestDB1_Log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\TestDB1_Log.ldf';
GO
