-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Adding foreign keys to [edfi].[InterventionPrescriptionAppropriateSex]'
GO
ALTER TABLE [edfi].[InterventionPrescriptionAppropriateSex] ADD CONSTRAINT [FK_InterventionPrescriptionAppropriateSex_InterventionPrescription] FOREIGN KEY ([InterventionPrescriptionIdentificationCode], [EducationOrganizationId]) REFERENCES [edfi].[InterventionPrescription] ([InterventionPrescriptionIdentificationCode], [EducationOrganizationId]) ON DELETE CASCADE
GO
ALTER TABLE [edfi].[InterventionPrescriptionAppropriateSex] ADD CONSTRAINT [FK_InterventionPrescriptionAppropriateSex_SexType] FOREIGN KEY ([SexTypeId]) REFERENCES [edfi].[SexType] ([SexTypeId])
GO
