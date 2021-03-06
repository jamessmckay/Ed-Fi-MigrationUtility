-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Adding foreign keys to [edfi].[CourseLearningObjective]'
GO
ALTER TABLE [edfi].[CourseLearningObjective] ADD CONSTRAINT [FK_CourseLearningObjective_Course] FOREIGN KEY ([EducationOrganizationId], [CourseCode]) REFERENCES [edfi].[Course] ([EducationOrganizationId], [CourseCode]) ON DELETE CASCADE
GO
ALTER TABLE [edfi].[CourseLearningObjective] ADD CONSTRAINT [FK_CourseLearningObjective_LearningObjective] FOREIGN KEY ([LearningObjectiveId], [Namespace]) REFERENCES [edfi].[LearningObjective] ([LearningObjectiveId], [Namespace])
GO
