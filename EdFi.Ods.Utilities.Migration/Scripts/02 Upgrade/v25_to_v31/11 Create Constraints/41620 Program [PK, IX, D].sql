-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Creating primary key [Program_PK] on [edfi].[Program]'
GO
ALTER TABLE [edfi].[Program] ADD CONSTRAINT [Program_PK] PRIMARY KEY CLUSTERED  ([EducationOrganizationId], [ProgramName], [ProgramTypeDescriptorId])
GO

PRINT N'Creating index [UX_Program_Id] on [edfi].[Program]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Program_Id] ON [edfi].[Program] ([Id]) WITH (FILLFACTOR=75, PAD_INDEX=ON)
GO

PRINT N'Creating index [FK_Program_EducationOrganization] on [edfi].[Program]'
GO
CREATE NONCLUSTERED INDEX [FK_Program_EducationOrganization] ON [edfi].[Program] ([EducationOrganizationId])
GO

PRINT N'Creating index [FK_Program_ProgramTypeDescriptor] on [edfi].[Program]'
GO
CREATE NONCLUSTERED INDEX [FK_Program_ProgramTypeDescriptor] ON [edfi].[Program] ([ProgramTypeDescriptorId])
GO

PRINT N'Adding constraints to [edfi].[Program]'
GO
ALTER TABLE [edfi].[Program] ADD CONSTRAINT [Program_DF_CreateDate] DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [edfi].[Program] ADD CONSTRAINT [Program_DF_LastModifiedDate] DEFAULT (getdate()) FOR [LastModifiedDate]
GO
ALTER TABLE [edfi].[Program] ADD CONSTRAINT [Program_DF_Id] DEFAULT (newid()) FOR [Id]
GO
