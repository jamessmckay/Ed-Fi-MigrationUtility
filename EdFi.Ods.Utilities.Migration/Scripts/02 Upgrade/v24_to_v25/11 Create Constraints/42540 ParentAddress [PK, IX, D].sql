-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Creating primary key [ParentAddress_PK] on [edfi].[ParentAddress]'
GO
ALTER TABLE [edfi].[ParentAddress] ADD CONSTRAINT [ParentAddress_PK] PRIMARY KEY CLUSTERED  ([ParentUSI], [AddressTypeId])
GO
PRINT N'Creating index [FK_ParentAddress_AddressType] on [edfi].[ParentAddress]'
GO
CREATE NONCLUSTERED INDEX [FK_ParentAddress_AddressType] ON [edfi].[ParentAddress] ([AddressTypeId])
GO
PRINT N'Creating index [FK_ParentAddress_Parent] on [edfi].[ParentAddress]'
GO
CREATE NONCLUSTERED INDEX [FK_ParentAddress_Parent] ON [edfi].[ParentAddress] ([ParentUSI])
GO
PRINT N'Creating index [FK_ParentAddress_StateAbbreviationType] on [edfi].[ParentAddress]'
GO
CREATE NONCLUSTERED INDEX [FK_ParentAddress_StateAbbreviationType] ON [edfi].[ParentAddress] ([StateAbbreviationTypeId])
GO

PRINT N'Adding constraints to [edfi].[ParentAddress]'
GO
ALTER TABLE [edfi].[ParentAddress] ADD CONSTRAINT [ParentAddress_DF_CreateDate] DEFAULT (getdate()) FOR [CreateDate]
GO

