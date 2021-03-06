-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

IF NOT EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'BellSchedule' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'EndTime')
BEGIN
    ALTER TABLE edfi.BellSchedule ADD EndTime TIME(7) NULL;
END
GO

IF NOT EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'BellSchedule' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'TotalInstructionalTime')
BEGIN
    ALTER TABLE edfi.BellSchedule ADD TotalInstructionalTime INT NULL;
END
GO

IF EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Assessment' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'MaxRawScore' AND DATA_TYPE = 'INT')
BEGIN
    ALTER TABLE edfi.Assessment ALTER COLUMN MaxRawScore DECIMAL(15, 5) NULL;
END
GO

IF EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'AssessmentItem' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'MaxRawScore' AND DATA_TYPE = 'INT')
BEGIN
    ALTER TABLE edfi.AssessmentItem ALTER COLUMN MaxRawScore DECIMAL(15, 5) NULL;
END
GO

IF NOT EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'AssessmentItem' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'ItemText')
BEGIN
    ALTER TABLE edfi.AssessmentItem ADD ItemText NVARCHAR(1024) NULL;
END
GO

IF NOT EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'BellSchedule' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'StartTime')
BEGIN
    ALTER TABLE edfi.BellSchedule ADD StartTime TIME(7) NULL;
END
GO

IF NOT EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'GradebookEntry' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'DueDate')
BEGIN
    ALTER TABLE edfi.GradebookEntry ADD DueDate DATE NULL;
END
GO

IF NOT EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'LearningStandard' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'LearningStandardScopeDescriptorId')
BEGIN
    ALTER TABLE edfi.LearningStandard ADD LearningStandardScopeDescriptorId INT NULL;
END
GO

IF NOT EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ObjectiveAssessment' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'MaxRawScore' AND DATA_TYPE = 'INT')
BEGIN
    ALTER TABLE edfi.ObjectiveAssessment ALTER COLUMN MaxRawScore DECIMAL(15, 5) NULL;
END
GO

IF NOT EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ObjectiveAssessment' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'AcademicSubjectDescriptorId')
BEGIN
    ALTER TABLE edfi.ObjectiveAssessment ADD AcademicSubjectDescriptorId INT NULL;
END
GO

IF NOT EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Section' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'OfficialAttendancePeriod')
BEGIN
    ALTER TABLE edfi.Section ADD OfficialAttendancePeriod BIT NULL;
END

IF NOT EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'StudentAssessment' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'PlatformTypeDescriptorId')
BEGIN
    ALTER TABLE edfi.StudentAssessment ADD PlatformTypeDescriptorId INT NULL;
END
GO

IF NOT EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'StudentAssessmentItem' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'RawScoreResult' AND DATA_TYPE = 'INT')
BEGIN
    ALTER TABLE edfi.StudentAssessmentItem ALTER COLUMN RawScoreResult DECIMAL(15,5) NULL;
END
GO

IF NOT EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'StudentEducationOrganizationAssociationStudentIndicatorPeriod' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'IndicatorName' AND CHARACTER_MAXIMUM_LENGTH <> 200)
BEGIN
    ALTER TABLE edfi.StudentEducationOrganizationAssociationStudentIndicatorPeriod ALTER COLUMN IndicatorName NVARCHAR(200) NOT NULL;
END
GO

IF NOT EXISTS(SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'StudentEducationOrganizationAssociationStudentIndicator' AND TABLE_SCHEMA='edfi' AND COLUMN_NAME = 'IndicatorName' AND CHARACTER_MAXIMUM_LENGTH <> 200)
BEGIN
    ALTER TABLE edfi.StudentEducationOrganizationAssociationStudentIndicator ALTER COLUMN IndicatorName NVARCHAR(200) NOT NULL;
    ALTER TABLE edfi.StudentEducationOrganizationAssociationStudentIndicator ALTER COLUMN IndicatorGroup NVARCHAR(200) NULL;
END
