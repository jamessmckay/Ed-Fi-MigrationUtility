-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

PRINT N'Creating primary key [AchievementCategoryDescriptor_PK] on [edfi].[AchievementCategoryDescriptor]'
GO
ALTER TABLE [edfi].[AchievementCategoryDescriptor] ADD CONSTRAINT [AchievementCategoryDescriptor_PK] PRIMARY KEY CLUSTERED  ([AchievementCategoryDescriptorId])
GO
PRINT N'Creating index [FK_AchievementCategoryDescriptor_Descriptor] on [edfi].[AchievementCategoryDescriptor]'
GO
CREATE NONCLUSTERED INDEX [FK_AchievementCategoryDescriptor_Descriptor] ON [edfi].[AchievementCategoryDescriptor] ([AchievementCategoryDescriptorId])
GO
PRINT N'Creating index [FK_AchievementCategoryDescriptor_AchievementCategoryType] on [edfi].[AchievementCategoryDescriptor]'
GO
CREATE NONCLUSTERED INDEX [FK_AchievementCategoryDescriptor_AchievementCategoryType] ON [edfi].[AchievementCategoryDescriptor] ([AchievementCategoryTypeId])
GO

