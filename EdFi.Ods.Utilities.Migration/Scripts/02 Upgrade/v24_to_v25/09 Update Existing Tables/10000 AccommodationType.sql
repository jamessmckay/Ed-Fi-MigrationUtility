-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Updating [edfi].[AccommodationType]'
GO

UPDATE [edfi].[AccommodationType]
SET [CodeValue] = LEFT(COALESCE (NULLIF([ShortDescription], ''''), NULLIF([Description], ''''), [ShortDescription]), 50)
WHERE [CodeValue] IS NULL
GO

ALTER TABLE [edfi].[AccommodationType]
ALTER COLUMN [CodeValue] [nvarchar] (50) NOT NULL
GO

UPDATE [edfi].[AccommodationType]
SET [Description] = COALESCE (NULLIF([CodeValue], ''''), NULLIF([ShortDescription], ''''), [CodeValue])
WHERE [Description] IS NULL
GO

ALTER TABLE [edfi].[AccommodationType]
ALTER COLUMN [Description] [nvarchar] (1024) NOT NULL
GO
