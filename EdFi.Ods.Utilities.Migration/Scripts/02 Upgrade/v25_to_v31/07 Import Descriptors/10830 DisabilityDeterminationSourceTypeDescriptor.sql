-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Creating [edfi].[DisabilityDeterminationSourceTypeDescriptor]'
GO

CREATE TABLE [edfi].[DisabilityDeterminationSourceTypeDescriptor]
(
[DisabilityDeterminationSourceTypeDescriptorId] [int] NOT NULL
)
GO

EXEC [migration_tempdata].[sp_ImportDescriptorsFromXML] 'DisabilityDeterminationSourceTypeDescriptor'
GO

