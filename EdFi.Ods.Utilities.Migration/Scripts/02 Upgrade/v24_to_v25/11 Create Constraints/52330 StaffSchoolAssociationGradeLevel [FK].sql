-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Adding foreign keys to [edfi].[StaffSchoolAssociationGradeLevel]'
GO
ALTER TABLE [edfi].[StaffSchoolAssociationGradeLevel] ADD CONSTRAINT [FK_StaffSchoolAssociationGradeLevel_GradeLevelDescriptor] FOREIGN KEY ([GradeLevelDescriptorId]) REFERENCES [edfi].[GradeLevelDescriptor] ([GradeLevelDescriptorId])
GO
ALTER TABLE [edfi].[StaffSchoolAssociationGradeLevel] ADD CONSTRAINT [FK_StaffSchoolAssociationGradeLevel_StaffSchoolAssociation] FOREIGN KEY ([StaffUSI], [ProgramAssignmentDescriptorId], [SchoolId]) REFERENCES [edfi].[StaffSchoolAssociation] ([StaffUSI], [ProgramAssignmentDescriptorId], [SchoolId]) ON DELETE CASCADE
GO
