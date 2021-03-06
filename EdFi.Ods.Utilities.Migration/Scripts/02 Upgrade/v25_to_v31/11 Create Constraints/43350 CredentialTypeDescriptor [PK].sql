-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Creating primary key [CredentialTypeDescriptor_PK] on [edfi].[CredentialTypeDescriptor]'
GO
ALTER TABLE [edfi].[CredentialTypeDescriptor] ADD CONSTRAINT [CredentialTypeDescriptor_PK] PRIMARY KEY CLUSTERED  ([CredentialTypeDescriptorId])
GO
