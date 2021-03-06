-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Creating primary key [TeachingCredentialBasisType_PK] on [edfi].[TeachingCredentialBasisType]'
GO
ALTER TABLE [edfi].[TeachingCredentialBasisType] ADD CONSTRAINT [TeachingCredentialBasisType_PK] PRIMARY KEY CLUSTERED  ([TeachingCredentialBasisTypeId])
GO
PRINT N'Creating index [UX_TeachingCredentialBasisType_Id] on [edfi].[TeachingCredentialBasisType]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_TeachingCredentialBasisType_Id] ON [edfi].[TeachingCredentialBasisType] ([Id]) WITH (FILLFACTOR=100, PAD_INDEX=ON)
GO

PRINT N'Adding constraints to [edfi].[TeachingCredentialBasisType]'
GO
ALTER TABLE [edfi].[TeachingCredentialBasisType] ADD CONSTRAINT [TeachingCredentialBasisType_DF_CreateDate] DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [edfi].[TeachingCredentialBasisType] ADD CONSTRAINT [TeachingCredentialBasisType_DF_LastModifiedDate] DEFAULT (getdate()) FOR [LastModifiedDate]
GO
ALTER TABLE [edfi].[TeachingCredentialBasisType] ADD CONSTRAINT [TeachingCredentialBasisType_DF_Id] DEFAULT (newid()) FOR [Id]
GO

