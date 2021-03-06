-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Converting type to descriptor on [edfi].[EducationOrganizationInternationalAddress]'
GO

EXEC [migration_tempdata].[sp_ConvertTypeToDescriptor]
'edfi', 'EducationOrganizationInternationalAddress',
'edfi', 'AddressTypeDescriptor',
'edfi', 'AddressType'
GO

ALTER TABLE [edfi].[EducationOrganizationInternationalAddress]
ALTER COLUMN [AddressTypeDescriptorId] [int] NOT NULL
GO

ALTER TABLE [edfi].[EducationOrganizationInternationalAddress]
DROP COLUMN [AddressTypeId]
GO

