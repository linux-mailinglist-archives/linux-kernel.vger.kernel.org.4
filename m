Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27187623C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiKJGtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiKJGtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:49:33 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E08F2F03C;
        Wed,  9 Nov 2022 22:49:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezPI0iW5+Ozb1CkBjqpvwHxGs2fl2uX+ly9I+DfpMl7M2dyTzmBoi9zN8OGEflXHCFgE7AkMSQoicdk0OOCJwGGtjZl1ksnb5EG0jWu0D5nNhq+PLQSt6FMYurjlFHizP9EayKkq2u8hmq79qC+axGEgGvMBoVmZSx2wMSV9P6yFhvtGmqkp4IHsEt/wwkO/nYfFI1Vy/egWAv0BKPYTe4H95DWBNIUYQplTwJicCEQielQ8itkNzPXYBSKh/rOZDbPTDKFT8X0jcycvAhCEOzhS84qsZQqwV2O/IIK7hDVWujiNbVVM/F01//XXQvk5/8ET7tkF+1lJnTSqp2PUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yUpJzh6QRUAzZSYvx6zTIHg+TdlbMVNpquqUA0Mhvg=;
 b=R+HEPNsP5HBXebZullUwKlv0bHfoXUY0ESQDJfEeN9A7MEEtiJvpiVZxEFRwV+E/OGfOowr93n7QSA6npNqdmPYdPnqycXkGj/bd0wOY4uQQsTpO5oWpCzsDqwcpiZJntIWnTGO4SZWeID5LrgjojRFb4kB2R8GhzyUcqBbaRy0AkrmkWxefedWJinRIYcffj++Dc5btjdrzS1LO7ZnfW5WW82QK+0f7O4Wfj4lB0491aCN3Ncync1bH4nnmFuvG5u8sseS1el6J70riVHIROcuIDeV7niLvzqjk/V5yWPAk9rAIdXGngquMYvMkUxQCQhABYsP6TIMol8oOHh6Yyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yUpJzh6QRUAzZSYvx6zTIHg+TdlbMVNpquqUA0Mhvg=;
 b=vCHGEhajLSZkJYDKwymPk+cP2kS6C/hvdftHenN38NpBfnfBuIx80eakIXaZ0hYnwL3dodA4VtzOE5rK7mUc+AZkBlSJ7PQidY6ez9A7j9H+jV0kxbWd6L/6qCDSsYccE2YG8aQYOHyvXN5o2PZoAIZ81zjF5I+EEAO/H9oBwks=
Received: from MW4PR04CA0377.namprd04.prod.outlook.com (2603:10b6:303:81::22)
 by DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 06:49:29 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::b0) by MW4PR04CA0377.outlook.office365.com
 (2603:10b6:303:81::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13 via Frontend
 Transport; Thu, 10 Nov 2022 06:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 06:49:28 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 00:49:06 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>
CC:     S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <rrangel@chromium.org>, "Rajat Jain" <rajatja@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Subject: [RFC v2 3/3] platform/x86/intel/pmc: core: Report duration of time in HW sleep state
Date:   Thu, 10 Nov 2022 00:47:23 -0600
Message-ID: <20221110064723.8882-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221110064723.8882-1-mario.limonciello@amd.com>
References: <20221110064723.8882-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 592d4884-0d0a-4580-b8ea-08dac2e7b6de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBWJkffu80cD+caBcBUXI1WkSTHYg/oYSMj2x0pQ/DZ/i3TOaZ6zpXzktjMjijY3Y4dYeOVHbooAAg1pHyv7P5Q7CEuvj3gRCCFfAwwVuUoH2QHBhmRJ99urFnDEnPA+JENIb+TM0IaNd0znV1JfpDNemweiv1XDjrQV8WIoc+l19FIlRM+YrmI39PtRIQwaSC/3ukHTcMTDI/BTw9l4axch7jwfRL/6jobFrFY/TUi/nfyDR3Df2cCZMTCgAjRvargF0O/9Yft2gtkRXMwjexQ9tXSYL90wPYnEVqKeTc2JBwBULdJ70rug2dYAvzd6CPLqleFXQcUkXfCb2MEOQIjd49igCinAVwy3aHgESE2g027eYEvabV+uQcYJLCYS1AKlFk0vfX3TAAPItsczhYsVpWbyHcFUe7CJ9xaWfRGsVaNOocnz5MxE7aadY+ZRoyDtWOIE1/b6bGTzJfqnqBgiR+QN3K0JxZxZywSE+r9LWfbeAswr06x1r0tzL5JBh71EDvl9Z2KP4/oSjp9sKkvC7IqFK52PegfpoZ32YdI0x5jkJYIx/9YKDBe7VJhP4jboCC9r6A9eCLeGrmbSlDAf3CfslW2UjHXCo4bi+LmTqoK+3od7D0IzQTg6r82rm3UuRnQpFI7s7WYH/F16SEdO7b+3udfXu2zuN0TmsGtM0PSljX4/fRc2IQPw0AgoLHlUnTSsgA+4ChmAROe2d8YANnnpQZuKScP4ZkvgihUcHClC8vuJQullgfgKjIQFyLLUlqu8aqjoNMUTnjmpatD10ibm15xQmns9qaUrTx0gXdVwG84W/Y89zIuRuyYk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(46966006)(36840700001)(40470700004)(1076003)(47076005)(16526019)(7416002)(2616005)(83380400001)(336012)(81166007)(82310400005)(356005)(44832011)(426003)(186003)(82740400003)(2906002)(36860700001)(4744005)(8936002)(40460700003)(5660300002)(6666004)(40480700001)(41300700001)(478600001)(26005)(4326008)(316002)(70206006)(8676002)(54906003)(110136005)(70586007)(7696005)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 06:49:28.5911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 592d4884-0d0a-4580-b8ea-08dac2e7b6de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_pmc_core displays a warning when a suspend didn't get to a HW
sleep state.

This information is generally useful to userspace as well which may use
it to collect further debugging data. Report this to the standard kernel
reporting infrastructure that can be accessed from sysfs.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/intel/pmc/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 17ec5825d13d..ef2055209213 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -2116,6 +2116,8 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
 	if (!pmcdev->check_counters)
 		return 0;
 
+	pm_set_hw_state_residency(pmcdev->s0ix_counter);
+
 	if (!pmc_core_is_s0ix_failed(pmcdev))
 		return 0;
 
-- 
2.34.1

