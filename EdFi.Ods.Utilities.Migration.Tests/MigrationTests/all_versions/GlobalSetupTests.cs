﻿// SPDX-License-Identifier: Apache-2.0
// Licensed to the Ed-Fi Alliance under one or more agreements.
// The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
// See the LICENSE and NOTICES files in the project root for more information.

using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using Dapper;
using DbUp;
using DbUp.Helpers;
using EdFi.Ods.Utilities.Migration.Enumerations;
using EdFi.Ods.Utilities.Migration.Logging;
using EdFi.Ods.Utilities.Migration.MigrationManager;
using EdFi.Ods.Utilities.Migration.Queries;
using log4net;
using NUnit.Framework;
using Shouldly;

namespace EdFi.Ods.Utilities.Migration.Tests.MigrationTests.all_versions
{
    [TestFixture]
    public class GlobalSetupTests : DatabaseIntegrationTestBase
    {
        private readonly ILog _logger = LogManager.GetLogger(typeof(GlobalSetupTests));

        private static readonly List<GlobalVersionUpgradeTestCase> AllVersionUpgradesUnderTest =
            OdsMigrationManagerResolver.Instance
                .GetAllUpgradableVersions()
                .Where(FromVersionIsUnderTest)
                .SelectMany(GetAllUpgradesUnderTest)
                .ToList();

        [TestCaseSource(nameof(AllVersionUpgradesUnderTest))]
        public void ShouldSetupCorrectVersionAndCleanUp(GlobalVersionUpgradeTestCase testCase)
        {
            DropTestDatabase();
            CreateEmptyTestDatabase();

            var upgradeStatusQuery = new GetStatusOfUpgradeInProgress();
            Setup(testCase.FromVersion, testCase.ToVersion);

            var upgradeStatus = upgradeStatusQuery.Execute(ConnectionString);
            upgradeStatus.VersionBeforeUpgrade.ShouldBe(testCase.FromVersion);
            upgradeStatus.RequestedFinalUpgradeVersion.ShouldBe(testCase.ToVersion);
            upgradeStatus.InProgress.ShouldBe(true);

            CleanUp();

            upgradeStatus = upgradeStatusQuery.Execute(ConnectionString);
            upgradeStatus.InProgress.ShouldBe(false);
            upgradeStatus.VersionBeforeUpgrade.ShouldBe(null);
            upgradeStatus.RequestedFinalUpgradeVersion.ShouldBe(null);

            TestDatabaseShouldNoLongerContainUpgradeArtifacts();

        }

        private void Setup(EdFiOdsVersion fromVersion, EdFiOdsVersion toVersion)
        {
            var upgradeEngine = DeployChanges.To
                .SqlDatabase(ConnectionString)
                .WithScriptsFromFileSystem(Path.Combine(MigrationTestSettingsProvider.GetConfigVariable("BaseMigrationScriptFolderPath"), MigrationStep.Setup.FolderName), Encoding.UTF8)
                .WithTransactionPerScript()
                .WithVariable("VersionBeforeUpgrade", fromVersion.ApiVersion.ToString())
                .WithVariable("RequestedFinalUpgradeVersion", toVersion.ApiVersion.ToString())
                .LogScriptOutput()
                .JournalTo(new NullJournal())
                .LogTo(new DbUpLogger(_logger))
                .Build();

            upgradeEngine.PerformUpgrade();
        }

        private void CleanUp()
        {
            var upgradeEngine = DeployChanges.To
                .SqlDatabase(ConnectionString)
                .WithScriptsFromFileSystem(Path.Combine(MigrationTestSettingsProvider.GetConfigVariable("BaseMigrationScriptFolderPath"), MigrationStep.Cleanup.FolderName), Encoding.UTF8)
                .WithTransactionPerScript()
                .LogScriptOutput()
                .JournalTo(new NullJournal())
                .LogTo(new DbUpLogger(_logger))
                .Build();

            upgradeEngine.PerformUpgrade();
        }

        public static List<GlobalVersionUpgradeTestCase> GetAllUpgradesUnderTest(EdFiOdsVersion fromVersion)
        {
            return OdsMigrationManagerResolver.Instance
                .GetSupportedUpgradeVersions(fromVersion)
                .Select(toVersion => new GlobalVersionUpgradeTestCase
                {
                    FromVersion = fromVersion,
                    ToVersion = toVersion
                })
                .Where(upgrade => ToVersionIsUnderTest(upgrade.ToVersion))
                .ToList();
        }

        private void TestDatabaseShouldNoLongerContainUpgradeArtifacts()
        {
            using (var connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                var upgradeArtifacts = connection.Query<string>(
                        @"
                        SELECT OBJECT_NAME ([object_id])
                        FROM [sys].[objects]
                        WHERE [is_ms_shipped] = 0
                    ").ToList();
                upgradeArtifacts.ShouldBeEmpty("Found unexpected objects after cleanup operation.  Ensure that all setup data created during migration is removed by the cleanup process");
            }
        }
        public class GlobalVersionUpgradeTestCase
        {
            public EdFiOdsVersion FromVersion { get; set; }
            public EdFiOdsVersion ToVersion { get; set; }
            public override string ToString()
            {
                return $"v{FromVersion} => v{ToVersion}";
            }
        }
    }
}