/*
-- This T-SQL script creates a database backup encryption certificate.
-- This certificate can be used for creating encrypted database backup files.
--
-- This script is part of a technical article on SQLNetHub. 
-- For more info please visit: https://www.sqlnethub.com/2017/08/encrypting-a-sql-server-backup-set/
*/
--Create Database Master Key and Encrypt it with a Strong Password
USE master;
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'PASSWORD_GOES_HERE';
GO

--Create Backup Certificate
USE master;
GO
CREATE CERTIFICATE DBBackupEncryptCert1
WITH SUBJECT = 'DB Backup Encryption Certificate';
GO

--IMPORTANT NOTE: It is critical that you backup the master DB key and the database backup certificate to a secure location
--Backup Master DB Key
BACKUP MASTER KEY
TO FILE = 'c:\tmp\MasterKey.key'
ENCRYPTION BY PASSWORD = 'PASSWORD_GOES_HERE';
GO

--Export the Backup Certificate to a File
BACKUP CERTIFICATE DBBackupEncryptCert1 TO FILE = 'c:\tmp\DBBackupEncryptCert1.cert'
WITH PRIVATE KEY (
FILE = 'c:\tmp\DBBackupCertKey',
ENCRYPTION BY PASSWORD = 'PASSWORD_GOES_HERE');
GO

--Next Step: Follow the blog post on SQLNetHub to see how you can backup a database using the certificate created above: 
--https://www.sqlnethub.com/2017/08/encrypting-a-sql-server-backup-set/ 
