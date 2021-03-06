-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Adding foreign keys to [edfi].[InterventionStudyPopulationServed]'
GO
ALTER TABLE [edfi].[InterventionStudyPopulationServed] ADD CONSTRAINT [FK_InterventionStudyPopulationServed_InterventionStudy] FOREIGN KEY ([EducationOrganizationId], [InterventionStudyIdentificationCode]) REFERENCES [edfi].[InterventionStudy] ([EducationOrganizationId], [InterventionStudyIdentificationCode]) ON DELETE CASCADE
GO
ALTER TABLE [edfi].[InterventionStudyPopulationServed] ADD CONSTRAINT [FK_InterventionStudyPopulationServed_PopulationServedDescriptor] FOREIGN KEY ([PopulationServedDescriptorId]) REFERENCES [edfi].[PopulationServedDescriptor] ([PopulationServedDescriptorId])
GO
