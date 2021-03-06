-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Creating primary key [ServiceDescriptor_PK] on [edfi].[ServiceDescriptor]'
GO
ALTER TABLE [edfi].[ServiceDescriptor] ADD CONSTRAINT [ServiceDescriptor_PK] PRIMARY KEY CLUSTERED  ([ServiceDescriptorId])
GO
PRINT N'Creating index [FK_ServiceDescriptor_Descriptor] on [edfi].[ServiceDescriptor]'
GO
CREATE NONCLUSTERED INDEX [FK_ServiceDescriptor_Descriptor] ON [edfi].[ServiceDescriptor] ([ServiceDescriptorId])
GO

