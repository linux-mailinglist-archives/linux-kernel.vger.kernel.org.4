Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F0C655DBC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiLYQgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiLYQgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:36:02 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A016392;
        Sun, 25 Dec 2022 08:35:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak4N05bC0f1suIYn3S0SoTKaBgLpNKlfxKqRcVo+GRzBvr3QLDinpGMoqnhA1SNz0QQpxwBkm2LKcrFmWjsFnseVD8mvzmlqXh7aLWSWeCZpNuwopTfDDZk75dgjf0AQ3+faOLUOM5Gzp+MdBGoHn89Slr+Tx6Kppb+pe2jXHM21y+srHBG2ZSnT36xpIALtATdn9xC+bL6WSjcwHiRe1nrlUAeS57LxDOXZcdR3Mu0nELhjVFkCSPBPWTXVIShj27TT5vOXgLIjanJLjvQHWkTBuDgpGLyH9D7A0xsSvj+YWXYZ3RgcQnMAUrbkX6xGVYdeCD7Uw2ORgLnhoL51Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj0Sw6ImPImF5dKyf7qz6SM78Z547bVC8FKFub9x/Xc=;
 b=LnjLGeIQmxBEPVB8w1QhfaaVabWE6xgCxKmlIg9/SyPzJpfsfQwKyc21OwuEyrqPi6Q+2hms1OdT8JHlSWc0QemkHmdQON9pE7k3N04hMTWLV8QjlwGdbtHhV02HYEXpgxz1ECNPcnwU97z0HTDt6s078w1EcZe073sDElIvLXquvLIUHZtuTRrzQKXyVOn8RpWiVc36RzY0QxUFAuMDEikaCuIe3hZSt9Z6bw3EwJrSZnJUqqY9t28Pi1Ap2WaXGwWhPivcv0Y4L3Jjjaw2QzvBCbiUFuj/Sij7ehFk1xGQ+Z8+vWd/hoSiNYur9HTpl0kZBf3SlqU6DvqhMtIVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj0Sw6ImPImF5dKyf7qz6SM78Z547bVC8FKFub9x/Xc=;
 b=WxX8uXD/ln+tj2+OahdZ4mSptWvD06TDlkqcKObwjNUQoaPo/Nl3WOQXSit7HxJoNJVr4VQmwV9zM3cQsyN0Czr57vE5PIROJGQnx0FR2RT/hCS/xaOwgeGl2zrBzlwF3ZyEjdhXhsMvS2Cl0W8VyamOdNpiJ/9RRFwh3e2zYlA=
Received: from MW4PR04CA0267.namprd04.prod.outlook.com (2603:10b6:303:88::32)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Sun, 25 Dec
 2022 16:35:38 +0000
Received: from CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::17) by MW4PR04CA0267.outlook.office365.com
 (2603:10b6:303:88::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16 via Frontend
 Transport; Sun, 25 Dec 2022 16:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT102.mail.protection.outlook.com (10.13.175.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.16 via Frontend Transport; Sun, 25 Dec 2022 16:35:37 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 25 Dec 2022 10:35:33 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 11/13] Documentation: introduce amd pstate active mode kernel command line options
Date:   Mon, 26 Dec 2022 00:34:40 +0800
Message-ID: <20221225163442.2205660-12-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225163442.2205660-1-perry.yuan@amd.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT102:EE_|BL1PR12MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 40bf84c1-71c5-41e6-29cf-08dae6960dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzjC+dQ8QWKgzARwKjUpqytpT+Pu5z5zTr3eEFgsuA4IFZc74QMPQK1J/GVrz2eSsCkbbkJiw/LLLh/8pgGOYXAiTPO1yOG6kkyuMb/39HW/V0831HXhCq8ds3vBXGlIOBmmGzS2wKrwSeFTtZ1jdzsk8RgBnfVqhT+4c7tz8WDesp4cNXdz+oNIuOnUDIzD3WTQa+8Oy+lQpb+VUv6A7dDwTSv1alTEO5qiqx0Yn3PrmV56In+mbT6hq6AIBTD0KwOSD+GqjUidSx91kdZEnElSCgWe3pnNfY3URPGtFKUN5PKfUsQp8w7oDc0cW+q7n0REOjvWWi+qQCxL2TA3t3lP7NRLrq9CmV/ryJC0BxOCg6BbC3A5UBYYKZOg6RgAYZlOOd4CCOI4VNOAuE3NuwOUW4FOqtSndaTBmD7JfoWhucvenrZIls57upPxTZgUKAyIzv2nY6nU1s7DDkj4Un+q3tHNeCaPsxeToJFL27pf3PKYFOXgKA3DX07AILZlkURBLGG6ZoB+7yInXzrHP11SL2EDnOx/76kwKGXUPqrKa1yrFQt+W33GpTGemqABRFydXc/eL2q3sujiLIok4H+ESq+YY14BxokHub3BOflT/O4tKzkJvqxaCsqLjn/ty0aRkNoDGhmvgSYPjIt/4OlihWWYUJ2d/y1/Xl44h5lpBiYIggeF9fngSlZS4ze8f7NtkaTenePOZGyGdlhe8Ien8Dja5XqXhY/opoBnjf8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(426003)(47076005)(336012)(83380400001)(86362001)(82740400003)(356005)(81166007)(2906002)(44832011)(8936002)(41300700001)(5660300002)(40460700003)(40480700001)(70206006)(82310400005)(478600001)(6666004)(7696005)(1076003)(2616005)(26005)(16526019)(186003)(4326008)(70586007)(8676002)(316002)(54906003)(110136005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 16:35:37.8936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bf84c1-71c5-41e6-29cf-08dae6960dff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Pstate driver support another firmware based autonomous mode
with "amd_pstate=active" added to the kernel command line.
In autonomous mode SMU firmware decides frequencies at runtime
based on workload utilization, usage in other IPs, infrastructure
limits such as power, thermals and so on.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42af9ca0127e..73a02816f6f8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6970,3 +6970,10 @@
 			  management firmware translates the requests into actual
 			  hardware states (core frequency, data fabric and memory
 			  clocks etc.)
+			active
+			  Use amd_pstate_epp driver instance as the scaling driver,
+			  driver provides a hint to the hardware if software wants
+			  to bias toward performance (0x0) or energy efficiency (0xff)
+			  to the CPPC firmware. then CPPC power algorithm will
+			  calculate the runtime workload and adjust the realtime cores
+			  frequency.
-- 
2.34.1

