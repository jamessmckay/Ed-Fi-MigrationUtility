-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Dropping [edfi].[StudentParentAssociation_DF_CreateDate]...';


GO
ALTER TABLE [edfi].[StudentParentAssociation] DROP CONSTRAINT [StudentParentAssociation_DF_CreateDate];


GO
PRINT N'Dropping [edfi].[StudentParentAssociation_DF_LastModifiedDate]...';


GO
ALTER TABLE [edfi].[StudentParentAssociation] DROP CONSTRAINT [StudentParentAssociation_DF_LastModifiedDate];


GO
PRINT N'Dropping [auth].[LocalEducationAgencyIdToParentUSI].[UCIX_LocalEducationAgencyIdToParentUSI]...';


GO
DROP INDEX [UCIX_LocalEducationAgencyIdToParentUSI]
    ON [auth].[LocalEducationAgencyIdToParentUSI];


GO
PRINT N'Removing schema binding from [auth].[LocalEducationAgencyIdToParentUSI]...';


GO
ALTER VIEW [auth].[LocalEducationAgencyIdToParentUSI]
AS
SELECT   sch.LocalEducationAgencyId,
         spa.ParentUSI,
         ssa.EntryDate AS BeginDate,
         ssa.ExitWithdrawDate AS EndDate,
         COUNT_BIG(*) AS Count
FROM     edfi.School AS sch
         INNER JOIN
         edfi.StudentSchoolAssociation AS ssa
         ON sch.SchoolId = ssa.SchoolId
         INNER JOIN
         edfi.Student AS s
         ON ssa.StudentUSI = s.StudentUSI
         INNER JOIN
         edfi.StudentParentAssociation AS spa
         ON ssa.StudentUSI = spa.StudentUSI
GROUP BY spa.ParentUSI, LocalEducationAgencyId, ssa.EntryDate, ssa.ExitWithdrawDate;


GO
PRINT N'Dropping [auth].[ParentUSIToSchoolId].[UCIX_ParentUSIToSchoolId]...';


GO
DROP INDEX [UCIX_ParentUSIToSchoolId]
    ON [auth].[ParentUSIToSchoolId];


GO
PRINT N'Removing schema binding from [auth].[ParentUSIToSchoolId]...';


GO
ALTER VIEW [auth].[ParentUSIToSchoolId]
AS
SELECT   ssa.SchoolId,
         spa.ParentUSI,
         ssa.EntryDate AS BeginDate,
         ssa.ExitWithdrawDate AS EndDate,
         COUNT_BIG(*) AS Count
FROM     edfi.StudentSchoolAssociation AS ssa
         INNER JOIN
         edfi.Student AS s
         ON ssa.StudentUSI = s.StudentUSI
         INNER JOIN
         edfi.StudentParentAssociation AS spa
         ON ssa.StudentUSI = spa.StudentUSI
GROUP BY spa.ParentUSI, SchoolId, ssa.EntryDate, ssa.ExitWithdrawDate;


GO
PRINT N'Dropping [auth].[ParentUSIToStudentUSI].[IX_ParentUSIToStudentUSI]...';


GO
DROP INDEX [IX_ParentUSIToStudentUSI]
    ON [auth].[ParentUSIToStudentUSI];


GO
PRINT N'Dropping [auth].[ParentUSIToStudentUSI].[UCIX_ParentUSIToStudentUSI]...';


GO
DROP INDEX [UCIX_ParentUSIToStudentUSI]
    ON [auth].[ParentUSIToStudentUSI];


GO
PRINT N'Removing schema binding from [auth].[ParentUSIToStudentUSI]...';


GO
ALTER VIEW [auth].[ParentUSIToStudentUSI]
AS
SELECT spa.StudentUSI,
       spa.ParentUSI
FROM   edfi.StudentParentAssociation AS spa;


GO
PRINT N'Altering [edfi].[StudentParentAssociation]...';


GO
ALTER TABLE [edfi].[StudentParentAssociation] ALTER COLUMN [CreateDate] DATETIME2 (7) NOT NULL;

ALTER TABLE [edfi].[StudentParentAssociation] ALTER COLUMN [LastModifiedDate] DATETIME2 (7) NOT NULL;


GO
PRINT N'Creating [edfi].[StudentParentAssociation_DF_CreateDate]...';


GO
ALTER TABLE [edfi].[StudentParentAssociation]
    ADD CONSTRAINT [StudentParentAssociation_DF_CreateDate] DEFAULT (getdate()) FOR [CreateDate];


GO
PRINT N'Creating [edfi].[StudentParentAssociation_DF_LastModifiedDate]...';


GO
ALTER TABLE [edfi].[StudentParentAssociation]
    ADD CONSTRAINT [StudentParentAssociation_DF_LastModifiedDate] DEFAULT (getdate()) FOR [LastModifiedDate];


GO
PRINT N'Adding schema binding to [auth].[LocalEducationAgencyIdToParentUSI]...';


GO


ALTER VIEW auth.LocalEducationAgencyIdToParentUSI
WITH SCHEMABINDING
AS
-- LEA to Parent USI
select	sch.LocalEducationAgencyId, spa.ParentUSI, ssa.EntryDate as BeginDate, ssa.ExitWithdrawDate as EndDate, COUNT_BIG(*) as Count
from	edfi.School sch
		inner join edfi.StudentSchoolAssociation ssa
			on sch.SchoolId = ssa.SchoolId
		inner join edfi.Student s
			on ssa.StudentUSI = s.StudentUSI
		inner join edfi.StudentParentAssociation spa
			on ssa.StudentUSI = spa.StudentUSI
group by spa.ParentUSI, LocalEducationAgencyId, ssa.EntryDate, ssa.ExitWithdrawDate 
--
GO
PRINT N'Creating [auth].[LocalEducationAgencyIdToParentUSI].[UCIX_LocalEducationAgencyIdToParentUSI]...';


GO
CREATE UNIQUE CLUSTERED INDEX [UCIX_LocalEducationAgencyIdToParentUSI]
    ON [auth].[LocalEducationAgencyIdToParentUSI]([ParentUSI] ASC, [LocalEducationAgencyId] ASC, [BeginDate] ASC, [EndDate] ASC);


GO
PRINT N'Adding schema binding to [auth].[ParentUSIToSchoolId]...';


GO

ALTER VIEW [auth].[ParentUSIToSchoolId]
WITH SCHEMABINDING
AS
-- School to Parent USI
select	ssa.SchoolId, spa.ParentUSI, ssa.EntryDate as BeginDate, ssa.ExitWithdrawDate as EndDate, COUNT_BIG(*) as Count
from	edfi.StudentSchoolAssociation ssa
		inner join edfi.Student s
			on ssa.StudentUSI = s.StudentUSI
		inner join edfi.StudentParentAssociation spa
			on ssa.StudentUSI = spa.StudentUSI
group by spa.ParentUSI, SchoolId, ssa.EntryDate, ssa.ExitWithdrawDate 
--
GO
PRINT N'Creating [auth].[ParentUSIToSchoolId].[UCIX_ParentUSIToSchoolId]...';


GO
CREATE UNIQUE CLUSTERED INDEX [UCIX_ParentUSIToSchoolId]
    ON [auth].[ParentUSIToSchoolId]([ParentUSI] ASC, [SchoolId] ASC, [BeginDate] ASC, [EndDate] ASC);


GO
PRINT N'Adding schema binding to [auth].[ParentUSIToStudentUSI]...';


GO


ALTER VIEW auth.ParentUSIToStudentUSI
WITH SCHEMABINDING
AS
select	spa.StudentUSI, spa.ParentUSI
from	edfi.StudentParentAssociation spa

--
GO
PRINT N'Creating [auth].[ParentUSIToStudentUSI].[UCIX_ParentUSIToStudentUSI]...';


GO
CREATE UNIQUE CLUSTERED INDEX [UCIX_ParentUSIToStudentUSI]
    ON [auth].[ParentUSIToStudentUSI]([StudentUSI] ASC, [ParentUSI] ASC);


GO
PRINT N'Creating [auth].[ParentUSIToStudentUSI].[IX_ParentUSIToStudentUSI]...';


GO
CREATE NONCLUSTERED INDEX [IX_ParentUSIToStudentUSI]
    ON [auth].[ParentUSIToStudentUSI]([ParentUSI] ASC, [StudentUSI] ASC);


GO
