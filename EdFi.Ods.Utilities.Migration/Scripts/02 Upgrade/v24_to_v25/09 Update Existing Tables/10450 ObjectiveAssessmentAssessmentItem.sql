-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Updating Assessment key references in [edfi].[ObjectiveAssessmentAssessmentItem]'
GO

ALTER TABLE [edfi].[ObjectiveAssessmentAssessmentItem]
ADD
	[AssessmentIdentifier] [nvarchar] (60) NULL,
	[Namespace] [nvarchar] (255) NULL
GO

UPDATE [edfi].[ObjectiveAssessmentAssessmentItem]
SET
	[AssessmentIdentifier] = m.[AssessmentIdentifier],
	[Namespace] = m.[Namespace]
FROM [edfi].[ObjectiveAssessmentAssessmentItem] a
INNER JOIN [migration_tempdata].[AssessmentIdentityMapping] m
ON a.[AssessmentTitle] = m.[AssessmentTitle]
	AND a.[AssessedGradeLevelDescriptorId] = m.[AssessedGradeLevelDescriptorId]
	AND a.[AcademicSubjectDescriptorId] = m.[AcademicSubjectDescriptorId]
	AND a.[Version] = m.[Version]
GO

ALTER TABLE [edfi].[ObjectiveAssessmentAssessmentItem]
ALTER COLUMN [AssessmentIdentifier] [nvarchar] (60) NOT NULL
GO

ALTER TABLE [edfi].[ObjectiveAssessmentAssessmentItem]
ALTER COLUMN [Namespace] [nvarchar] (255) NOT NULL
GO

ALTER TABLE [edfi].[ObjectiveAssessmentAssessmentItem] DROP
	COLUMN [AssessmentTitle],
	COLUMN [Version],
	COLUMN [AssessedGradeLevelDescriptorId],
	COLUMN [AcademicSubjectDescriptorId]
GO

