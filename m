Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D12A5ED9A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiI1KAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiI1KA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:00:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3E892F52;
        Wed, 28 Sep 2022 03:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQW1I55OIzr2LXVRxHCj0G6n+W4VKiwOoaIbJ3bW+3YlyKZMrRMFlo/0cP+c3vYomnJQKxq1xavZlfN6r3vR+mFUFiapCrH5v5Amsc3iVEXC3oOA6cZUbxsVRmmn+7zUuxof4WdRfvc3Q0zoMDZH7I3CzrzysY1N29qqzy39pcSAjLmXPTMUpIocqiJPHyEzjJQKqbPeEThd3UMxfXMjtjPTdpROkraTlR7xGv090DWGOZDGWGNJqLxaT/u9hW1mt1nEwXp/mlK2hFQQph3xJMcNycbNPLTPF0k4sEW3f5XyWbD4LKEhhlvQsarCGw5FlEtxX6qA8/PUMbNjyGaX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+lH8Lg6WynmhnC1acEzNXTk9qF8gUJ/SdqFamvQI1E=;
 b=bQDidBwM0n3cXdF2uzRTNCv9yrTV0o5C4p7ZN8/4PDzLk+aZfqMhAC1WM0CUuJYZMLzJ4ec2jjsO2w9L2Gydos+YKfa4hjP/faUcdT/rfdxd8izWDS63X9OLmtlAqwbQxPdz7AW+CBe+sJLpDJI+tEMHqh5M5yHBS7XsYd6x2yWB/+8anZi+ZlR8LGqlrt+eV25WZ2hgUXFL8elYJSLOv7Kqr+LOVIKTqR+cc1Xse7cAjLxmC0rX8uLaoVHH+SXk2PmtSTFWRLFQswP6oQ1Zx50qZSX2Odd0wq8JXXI8AlVo0DFLLODFDO7KbTpidnCTaYWQ46dtgwvZbyY55hUg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+lH8Lg6WynmhnC1acEzNXTk9qF8gUJ/SdqFamvQI1E=;
 b=j1xB0i1VuZEuNKf7HUk6Dk+F5LEf8ZHBeDCpPvMEhyTtp4eo5HUllsRyDnWBhqH9fLdEjKJbiQ6KHWgKHkIQj+/JaPkBC4DoOwziliIEhd+oh6thNht2y9dA70adTnkFKgNCG0zPaKE4LJ+to2YjVw7p23IdB0QssiTIzVkrVCo=
Received: from MW4PR04CA0388.namprd04.prod.outlook.com (2603:10b6:303:81::33)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 10:00:21 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::2e) by MW4PR04CA0388.outlook.office365.com
 (2603:10b6:303:81::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 10:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 10:00:21 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 05:00:12 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v3 08/15] perf tool: Sync include/uapi/linux/perf_event.h header
Date:   Wed, 28 Sep 2022 15:27:58 +0530
Message-ID: <20220928095805.596-9-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928095805.596-1-ravi.bangoria@amd.com>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: d585c98e-ddd5-45af-e798-08daa138417e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djEUrY4MyXqOCmlwfjXm8gEL/wGV5fhzA6kOAOt2nzUC4LpSpot13DZWvulY59niZs6C+ewhsJ23ZHozi34V6bu774WHfREDDSAd6mWOAp714jMENLK1s/5/UxUZxaHglvGUmVgMVvNd63czIfVThiNmGsE3sG+uo+h1tPVzjjPY7TnLiXH1jLkJcY+0jJf5FInQSh8Hk3kFj3/zeyNn2N6QB0dYWapHX1Cafa0q6twN0UfQvoEDqTUQzJl2Z/Show4lPDR5IxdJhGNIGSK3NO426JI/5yQKiWUiNOq7EkMzZzpp0ca/OdW61tAnBItqlfCQQ+M7HZkvU/LG87TD/P18Huhg7tWNCP8ZMa/4k6L7iPwymyv0RR5PhqB3HFdHQYsZ1e0OIQe0l0t2H3iNLyssGLlM+m6TvS0Hs2u4bv2S9vFoKo696PZPDOOHlwSf58asyku+/lWYaQ3RSgO2y4HPWC6l6InA/NmkNl9WWttTxV1vTdf/puRP6qlj6j7psFsQKIxk+6P3d8icisjzlQQ9Vf/d60RGsFQWkavMH+6gIzEccbCQyIzkmYDp1hl5IzJQETG5O16BiC1aTZDuPPfQ0W1T+cTW48NzE8JChxU6AeMCm3fcUD0d31wHC6YKVu1oNJpdl4kGfJzm7M2h1wuk4B3SVXAyqOVC1l0x5g/ghdwMyLwbioiHE/XhkbdMRlzhbwhkTNosurxj9EU3MEKlSkHbdjMV63vLJ/X8Qemeg0OKFVktDGFytDGZIPIyFfhC6VVqlxIf8OMmMk7mEby7LuujNJpyy5YZb/51h6u2dQ46ZVVGEHqoSXWAHarO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(2616005)(426003)(336012)(16526019)(1076003)(186003)(47076005)(356005)(81166007)(82740400003)(36860700001)(7416002)(5660300002)(8936002)(41300700001)(82310400005)(44832011)(2906002)(478600001)(40460700003)(26005)(7696005)(6666004)(8676002)(40480700001)(4326008)(70206006)(70586007)(54906003)(110136005)(316002)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 10:00:21.3548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d585c98e-ddd5-45af-e798-08daa138417e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two new fields for mem_lvl_num has been introduced: PERF_MEM_LVLNUM_IO
and PERF_MEM_LVLNUM_EXTN_MEM which are required to support perf mem/c2c
on AMD platform.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 581ed4bdc062..9b65fc7d2377 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1295,7 +1295,9 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0xa available */
+/* 5-0x8 available */
+#define PERF_MEM_LVLNUM_EXTN_MEM 0x09 /* Extension memory */
+#define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
 #define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
 #define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
-- 
2.31.1

