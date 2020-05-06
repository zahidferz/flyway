/****** Object:  Table [dbo].[IncomeCategory]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IncomeCategory](
	[IncomeCategoryId] [uniqueidentifier] NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[Status] [int] NOT NULL,
	[CompanyNumber] [int] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[ParentCategoryId] [uniqueidentifier] NULL,
 CONSTRAINT [PkIncomeCategoryId] PRIMARY KEY NONCLUSTERED
(
	[IncomeCategoryId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IncomeCategoryStatusEnum]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IncomeCategoryStatusEnum](
	[IncomeCategoryStatusId] [int] NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [IncomeCategoryStatusId] PRIMARY KEY NONCLUSTERED
(
	[IncomeCategoryStatusId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IncomeCategory] ADD  CONSTRAINT [DfIncomeCategoryRegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[IncomeCategory]  WITH CHECK ADD  CONSTRAINT [FKIncomeCategoryParentIncomeCategory] FOREIGN KEY([ParentCategoryId])
REFERENCES [dbo].[IncomeCategory] ([IncomeCategoryId])
GO
ALTER TABLE [dbo].[IncomeCategory] CHECK CONSTRAINT [FKIncomeCategoryParentIncomeCategory]
GO

/****** Object:  StoredProcedure [dbo].[CountIncomeCategoryByCompanyNumber]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 30/05/2019
-- Description: Count Income Category By CompanyNumber and status
-- Example: EXEC [dbo].[CountIncomeCategoryByCompanyNumber] 1, 2
-- =============================================
CREATE PROCEDURE [dbo].[CountIncomeCategoryByCompanyNumber](
  @companyNumber AS INT
)
AS
BEGIN
  SET NOCOUNT ON
  SELECT
  COUNT(ic.IncomeCategoryId) AS total
  FROM [dbo].[IncomeCategory] ic
  INNER JOIN [dbo].[IncomeCategoryStatusEnum] ice WITH(NOLOCK)
    ON ic.Status = ice.IncomeCategoryStatusId
  WHERE CompanyNumber = @companyNumber AND ic.Status < 3
END
GO

/****** Object:  StoredProcedure [dbo].[CountIncomeCategoryByCompanyNumberByStatus]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 30/05/2019
-- Description: Count Income Category By CompanyNumber and status
-- Example: EXEC [dbo].[CountIncomeCategoryByCompanyNumberByStatus] 1, 2
-- =============================================
CREATE PROCEDURE [dbo].[CountIncomeCategoryByCompanyNumberByStatus](
  @companyNumber AS INT,
  @status AS INT
)
AS
BEGIN
  SET NOCOUNT ON
  SELECT
  COUNT(ic.IncomeCategoryId) AS total
  FROM [dbo].[IncomeCategory] ic
  INNER JOIN [dbo].[IncomeCategoryStatusEnum] ice WITH(NOLOCK)
    ON ic.Status = ice.IncomeCategoryStatusId
  WHERE CompanyNumber = @companyNumber AND ic.Status = @status
END
GO

/****** Object:  StoredProcedure [dbo].[CountIncomeCategoryByParentCategoryId]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 28/05/2019
-- Description: Get Income Category By ParentCategoryId
-- Example: EXEC [dbo].[CountIncomeCategoryByParentCategoryId]
-- =============================================
CREATE PROCEDURE [dbo].[CountIncomeCategoryByParentCategoryId](
  @parentCategoryId AS UNIQUEIDENTIFIER,
  @companyNumber AS INT
)
AS
BEGIN
  SET NOCOUNT ON
  SELECT
	COUNT(ic.IncomeCategoryId) AS total
  FROM [dbo].[IncomeCategory] ic
  INNER JOIN [dbo].[IncomeCategoryStatusEnum] ice WITH(NOLOCK)
    ON ic.Status = ice.IncomeCategoryStatusId
  WHERE ParentCategoryId = @parentCategoryId AND CompanyNumber = @companyNumber AND ic.Status < 3
END
GO

/****** Object:  StoredProcedure [dbo].[CountIncomeCategoryByParentCategoryIdByStatus]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 28/05/2019
-- Description: Count Income Category By ParentCategoryId and status
-- Example: EXEC [dbo].[CountIncomeCategoryByParentCategoryIdByStatus]
-- =============================================
CREATE PROCEDURE [dbo].[CountIncomeCategoryByParentCategoryIdByStatus](
  @parentCategoryId AS UNIQUEIDENTIFIER,
  @companyNumber AS INT,
  @status AS INT
)
AS
BEGIN
  SET NOCOUNT ON
  SELECT
  COUNT(ic.IncomeCategoryId) AS total
  FROM [dbo].[IncomeCategory] ic
  INNER JOIN [dbo].[IncomeCategoryStatusEnum] ice WITH(NOLOCK)
    ON ic.Status = ice.IncomeCategoryStatusId
  WHERE ParentCategoryId = @parentCategoryId AND CompanyNumber = @companyNumber AND ic.Status = @status
END
GO

/****** Object:  StoredProcedure [dbo].[GetIncomeCategoryByCompanyNumber]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 28/05/2019
-- Description: Get Income Category By CompanyNumber
-- Example: EXEC [dbo].[GetIncomeCategoryByCompanyNumber]
-- =============================================
CREATE PROCEDURE [dbo].[GetIncomeCategoryByCompanyNumber](
  @companyNumber AS INT,
  @pageSize AS INT,
  @pageNumber AS INT
)
AS
BEGIN
  SET NOCOUNT ON
  SELECT
	IncomeCategoryId
	, ic.Name
	, ice.Name as Status
	, registeredDate
	, ParentCategoryId
  FROM [dbo].[IncomeCategory] ic
  INNER JOIN [dbo].[IncomeCategoryStatusEnum] ice WITH(NOLOCK)
    ON ic.Status = ice.IncomeCategoryStatusId
  WHERE CompanyNumber = @companyNumber AND ic.Status < 3
  ORDER BY Name
	OFFSET @pageSize * (@pageNumber - 1) ROWS
	FETCH NEXT @pageSize ROWS ONLY
  OPTION
  (RECOMPILE)

END
GO

/****** Object:  StoredProcedure [dbo].[GetIncomeCategoryByCompanyNumberByStatus]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 30/05/2019
-- Description: Get Income Category By CompanyNumber and status
-- Example: EXEC [dbo].[GetIncomeCategoryByCompanyNumber]
-- =============================================
CREATE PROCEDURE [dbo].[GetIncomeCategoryByCompanyNumberByStatus](
  @companyNumber AS INT,
  @status AS INT,
  @pageSize AS INT,
  @pageNumber AS INT
)
AS
BEGIN
  SET NOCOUNT ON
  SELECT
	IncomeCategoryId
	, ic.Name
	, ice.Name as Status
	, registeredDate
	, ParentCategoryId
  FROM [dbo].[IncomeCategory] ic
  INNER JOIN [dbo].[IncomeCategoryStatusEnum] ice WITH(NOLOCK)
    ON ic.Status = ice.IncomeCategoryStatusId
  WHERE CompanyNumber = @companyNumber AND ic.Status = @status
  ORDER BY Name
	OFFSET @pageSize * (@pageNumber - 1) ROWS
	FETCH NEXT @pageSize ROWS ONLY
  OPTION
  (RECOMPILE)

END
GO

/****** Object:  StoredProcedure [dbo].[GetIncomeCategoryById]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 28/05/2019
-- Description: Get Income Category By Id
-- Example: EXEC [dbo].[GetIncomeCategoryById]
-- =============================================
CREATE PROCEDURE [dbo].[GetIncomeCategoryById](
  @categoryId AS UNIQUEIDENTIFIER
)
AS
BEGIN
  SET NOCOUNT ON
  SELECT
	IncomeCategoryId
	, ic.Name
	, CompanyNumber
	, ice.Name as Status
	, registeredDate
	, ParentCategoryId
  FROM [dbo].[IncomeCategory] ic
  INNER JOIN [dbo].[IncomeCategoryStatusEnum] ice WITH(NOLOCK)
    ON ic.Status = ice.IncomeCategoryStatusId
  WHERE IncomeCategoryId = @categoryId
  AND ic.Status < 3

END
GO

/****** Object:  StoredProcedure [dbo].[GetIncomeCategoryByIdByStatus]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 30/05/2019
-- Description: Get Income Category By Id and status
-- Example: EXEC [dbo].[GetIncomeCategoryByIdByStatus]
-- =============================================
CREATE PROCEDURE [dbo].[GetIncomeCategoryByIdByStatus](
  @categoryId AS UNIQUEIDENTIFIER,
  @status AS INT
)
AS
BEGIN
  SET NOCOUNT ON
  SELECT
	IncomeCategoryId
	, Name
	, CompanyNumber
	, Status
	, ParentCategoryId
  , registeredDate
  FROM [dbo].[IncomeCategory]
  WHERE IncomeCategoryId = @categoryId AND Status = @status

END
GO

/****** Object:  StoredProcedure [dbo].[GetIncomeCategoryByParentCategoryId]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 28/05/2019
-- Description: Get Income Category By ParentCategoryId
-- Example: EXEC [dbo].[GetIncomeCategoryByParentCategoryId]
-- =============================================
CREATE PROCEDURE [dbo].[GetIncomeCategoryByParentCategoryId](
  @parentCategoryId AS UNIQUEIDENTIFIER,
  @companyNumber AS INT,
  @pageSize AS INT,
  @pageNumber AS INT
)
AS
BEGIN
  SET NOCOUNT ON
  SELECT
	IncomeCategoryId
	, ic.Name
	, CompanyNumber
	, ice.Name as Status
    , registeredDate
	, parentCategoryId
  FROM [dbo].[IncomeCategory] ic
  INNER JOIN [dbo].[IncomeCategoryStatusEnum] ice WITH(NOLOCK)
    ON ic.Status = ice.IncomeCategoryStatusId
  WHERE ParentCategoryId = @parentCategoryId AND CompanyNumber = @companyNumber AND ic.Status < 3
  ORDER BY CompanyNumber, Name
  OFFSET @pageSize * (@pageNumber - 1) ROWS
  FETCH NEXT @pageSize ROWS ONLY
  OPTION
  (RECOMPILE)

END
GO

/****** Object:  StoredProcedure [dbo].[GetIncomeCategoryByParentCategoryIdByStatus]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 28/05/2019
-- Description: Get Income Category By ParentCategoryId and status
-- Example: EXEC [dbo].[GetIncomeCategoryByParentCategoryIdByStatus]
-- =============================================
CREATE PROCEDURE [dbo].[GetIncomeCategoryByParentCategoryIdByStatus](
  @parentCategoryId AS UNIQUEIDENTIFIER,
  @companyNumber AS INT,
  @status AS INT,
  @pageSize AS INT,
  @pageNumber AS INT
)
AS
BEGIN
  SET NOCOUNT ON
  SELECT
	IncomeCategoryId
	, ic.Name
	, CompanyNumber
	, ice.Name as Status
    , registeredDate
	, parentCategoryId
  FROM [dbo].[IncomeCategory] ic
  INNER JOIN [dbo].[IncomeCategoryStatusEnum] ice WITH(NOLOCK)
    ON ic.Status = ice.IncomeCategoryStatusId
  WHERE ParentCategoryId = @parentCategoryId AND CompanyNumber = @companyNumber AND ic.Status = @status
  ORDER BY CompanyNumber, Name
  OFFSET @pageSize * (@pageNumber - 1) ROWS
  FETCH NEXT @pageSize ROWS ONLY
  OPTION
  (RECOMPILE)

END
GO

/****** Object:  StoredProcedure [dbo].[InsertIncomeCategory]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 28/05/2019
-- Description: Insert Income Category
-- Example: EXEC [dbo].[InsertIncomeCategory]
-- =============================================
CREATE PROCEDURE [dbo].[InsertIncomeCategory](
  @name AS VARCHAR(200),
  @parentCategoryId AS UNIQUEIDENTIFIER = null,
  @companyNumber AS INT
)
AS
BEGIN
  DECLARE @incomeCategoryId as UNIQUEIDENTIFIER
  SET @incomeCategoryId =  NEWID();
  INSERT INTO [dbo].[IncomeCategory]
    (
	  IncomeCategoryId
	, Name
	, CompanyNumber
	, ParentCategoryId
	, Status
	, RegisteredDate
    )
  VALUES(
      @incomeCategoryId
	, @name
	, @companyNumber
	, @parentCategoryId
	, 1
	, GETDATE()
	)
  EXEC [dbo].[GetIncomeCategoryById] @incomeCategoryId
END
GO

/****** Object:  StoredProcedure [dbo].[UpdateIncomeCategory]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 28/05/2019
-- Description: Update Income Category info
-- =============================================
CREATE PROCEDURE [dbo].[UpdateIncomeCategory](
  @categoryId AS UNIQUEIDENTIFIER,
  @name AS VARCHAR(200) = NULL,
  @parentCategoryId AS UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
  SET NOCOUNT ON
  UPDATE [dbo].[IncomeCategory]
	SET Name = coalesce(@name, Name)
	, ParentCategoryId = @parentCategoryId
	WHERE IncomeCategoryId = @categoryId
  EXEC [dbo].[GetIncomeCategoryById] @categoryId
END
GO

/****** Object:  StoredProcedure [dbo].[UpdateIncomeCategoryStatus]    Script Date: 06/06/2019 10:38:09 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 28/05/2019
-- Description: Update Income Category info
-- EXEC [dbo].[UpdateIncomeCategoryStatus] "2EF0098B-A441-4F94-90D0-D80EF74643A6", 3
-- =============================================
CREATE PROCEDURE [dbo].[UpdateIncomeCategoryStatus](
  @categoryId AS UNIQUEIDENTIFIER,
  @status AS INT
)
AS
BEGIN
  SET NOCOUNT ON
  UPDATE [dbo].[IncomeCategory]
	SET Status = @status
	WHERE IncomeCategoryId = @categoryId
SELECT
	IncomeCategoryId
	, ic.Name
	, CompanyNumber
	, ice.Name as Status
	, ParentCategoryId
  , registeredDate
  FROM [dbo].[IncomeCategory] ic WITH(NOLOCK)
  INNER JOIN [dbo].[IncomeCategoryStatusEnum] ice WITH(NOLOCK)
   ON ic.Status = ice.IncomeCategoryStatusId
  WHERE IncomeCategoryId = @categoryId
END
GO

/****** Object:  StoredProcedure [dbo].[GetSubCategoriesByParentCategoryId]    Script Date: 09/06/2019 09:37:00 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 28/05/2019
-- Description: Getsub categories By ParentCategoryId
-- Example: EXEC [dbo].[GetSubCategoriesByParentCategoryId] '9FD4DB3F-C83C-4613-8A23-C0C629864820', 191
-- =============================================
CREATE PROCEDURE [dbo].[GetSubCategoriesByParentCategoryId](
  @parentCategoryId AS UNIQUEIDENTIFIER,
  @companyNumber AS INT
)
AS
BEGIN
  SET NOCOUNT ON
  SELECT
	IncomeCategoryId
  FROM [dbo].[IncomeCategory] ic
  WHERE ParentCategoryId = @parentCategoryId AND CompanyNumber = @companyNumber AND ic.Status < 3
END

GO

/****** Object:  StoredProcedure [dbo].[DeleteIncomeCategory]    Script Date: 10/06/2019 10:58:34 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Brenda SR
-- Create Date: 10/06/2019
-- Description: DELETE PERMANENTLY an income category
-- EXEC [dbo].[DeleteIncomeCategory] "2EF0098B-A441-4F94-90D0-D80EF74643A6"
-- =============================================
CREATE PROCEDURE [dbo].[DeleteIncomeCategory](
  @categoryId AS UNIQUEIDENTIFIER
)
AS
BEGIN
	EXEC [dbo].[GetIncomeCategoryById] @categoryId

	DELETE FROM [dbo].[IncomeCategory]
	WHERE IncomeCategoryId = @categoryId
END

GO

