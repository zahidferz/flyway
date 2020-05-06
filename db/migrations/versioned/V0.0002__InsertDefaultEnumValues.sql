IF NOT EXISTS (SELECT 1
FROM [dbo].[IncomeCategoryStatusEnum]
WHERE [Name]='active')
	INSERT INTO [dbo].[IncomeCategoryStatusEnum]
	([IncomeCategoryStatusId], [Name])
VALUES(1, 'active')
IF NOT EXISTS (SELECT 1
FROM [dbo].[IncomeCategoryStatusEnum]
WHERE [Name]='archived')
	INSERT INTO [dbo].[IncomeCategoryStatusEnum]
	([IncomeCategoryStatusId], [Name])
VALUES(2, 'archived')
IF NOT EXISTS (SELECT 1
FROM [dbo].[IncomeCategoryStatusEnum]
WHERE [Name]='deleted')
	INSERT INTO [dbo].[IncomeCategoryStatusEnum]
	([IncomeCategoryStatusId], [Name])
VALUES(3, 'deleted')
