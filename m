Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BC45ED9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiI1KAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiI1KAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:00:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690484B4BC;
        Wed, 28 Sep 2022 03:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=corv2TiuuF1RFbt0SXMtEAIAC4GhUj2UftWK+SJdAT0/76TW/ZabfX29LMfoU1d4PV/qf9eDu8O8RMLuHUXPyN8r/tWo9T8J3r7uJW4LaRmFpP6fmpfM7JJxzf3mAqwyKm2G5a2O7VGXfAWZIpAXfj2FVnfNWDEEKC3Our1+YJ31pAc4uD8MvIgP/J6If03R5S4DQsNoko5RoYmDnOmqCe5ObZhVfgWvJhWi/VLOL6YsNilH+EeA3fNxylEDJcYhzaWuCZQn2YTq/Qy7C8c79RtwZxaJsA2UV1CjRraM9FspXgS9mqW/WUqmf9Zq0s75spN/sLYEVPpVBhJzsY0/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iyo6Ezh2IEVcMSrqoqYKAlpPy3/A/bMJzcSal71sOIk=;
 b=nluEWB6mNvymG4v3UvyXoIa6F7jBArcSDrkkxvxL4nYoRYDk8RkmJd7A8mofHoxUcwOYPd1IdZ5+hcg1m4W3vpbqIOKMB7oFUP4rDVaA1WH9jDfTzKbgcmp7lLgCOu03PIDGeIdBecKSuvtebSdvo+dkeKt5dAfsfhytGXkYiYiql2L4Lzw3XM6f0XA9qPldjfI73f0tOTluCI/FojcHpseFUemgxNOnz5SaCTNNDrRJ8fdVXXvpPVFnx+LJFqX8o8lk4fPh7ObaNoYsfFA9sHhzcCrVEvQ/ZRgDxJwXKSUUYQ51hLDF+NMBls/FpzQo6UF8b1SH3l1/wJd9a8g9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iyo6Ezh2IEVcMSrqoqYKAlpPy3/A/bMJzcSal71sOIk=;
 b=gjE6BagpjL3kYh3z9Ol4ClI5BVwHSqVEVSQFDvk62eJxd7crVaV0pnqUmY7h17gL0WQj4i9WTbGXluz/7+/5i2kcZVMzKL3Mu9L90Et963ksjCFLc6PcnqrUhO/CnD23nz6+C4VGS92r8LTKJIwNe4ovUAaRm28v6mxrDrF97sQ=
Received: from MW3PR06CA0009.namprd06.prod.outlook.com (2603:10b6:303:2a::14)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 09:59:55 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::c3) by MW3PR06CA0009.outlook.office365.com
 (2603:10b6:303:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22 via Frontend
 Transport; Wed, 28 Sep 2022 09:59:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 09:59:54 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 04:59:36 -0500
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
Subject: [PATCH v3 05/15] perf/x86/amd: Support PERF_SAMPLE_ADDR
Date:   Wed, 28 Sep 2022 15:27:55 +0530
Message-ID: <20220928095805.596-6-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 825835ca-62c1-485d-301d-08daa138314a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3pKq0YVyNzQKDe1E2pwy9rLgqWibIeE20+2fVvsfPP08GUf3HgmacM79jXl37kpAQerc9hMPdE7BAVKbZiMoUBppcabgR5ekZHocaC8TOSXmX1T5MmFluNSJV8VuYERzAt0MU7+aSvZQLRiZalu37eHTIoXTJAOVPsH1vPhvhB8u34duQix0yWn32TQ7EDdP0LiswHU9B63TFTBsRLoDk5io8QLu6kJDqwFIJpK6esd5yc8x1JUBhihDoxzIRgcqzY4Gk/+cr3cDEtMZlMBBWOjFT8/L+NEvvLU2Eui0504cx0IY3fYUVkueoCcMxSAEO4CueAS/OU584IUG0ldiqsQYT55mj9cj2/owq77krwr1gjlvSq/vCg3j6K/r+twHt2xpuFXjFQ7xIdkABBACTFsDX9ejcogQU7xqpx83VEx3913tXR3FyVAnb7OZPL7wTkp2vlhhUn/m9K36Hm4zW7OfBqi0cOgCjAM3dnxTL4C2cat5m9WqeFeMpA4ubISn56A/v7qHzFsihiyVJ9pDKPwxUscH8puS5Dhdr6LxBXgOcEzEMnX7HbNAT+eCyaAxIO2nCWtXeyikSK+HnbmtojHk4rFYAvdazK+IIj0Hob6Kvn5ekcWPnTqmQ2G+kgAkcOrpcBuLit6+zsmFrDYmPmZ2edzbmb05bINAkMe8fz0tf6xLKxsLZDGHrwftCWwtrjfocvRwFzIeDqH6eEE7i434ZpLEbmEZtp06P0rPngyevAxbwbiVHMpS909OKM+EvKwrY2G4XZx732ipOar1FU7URimsSGvhYxIzlG2y2Q7NgfibjmE8AMRPaNfBn5E
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(54906003)(110136005)(26005)(8936002)(6666004)(41300700001)(70586007)(478600001)(4326008)(2906002)(7696005)(8676002)(5660300002)(44832011)(2616005)(7416002)(81166007)(82310400005)(40460700003)(82740400003)(36756003)(83380400001)(47076005)(426003)(1076003)(336012)(16526019)(70206006)(356005)(316002)(86362001)(36860700001)(40480700001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 09:59:54.1657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825835ca-62c1-485d-301d-08daa138314a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS_DC_LINADDR provides the linear data address for the tagged load/
store operation. Populate perf sample address using it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index d883694e0fd4..0ad49105c154 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -984,6 +984,11 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
 		}
 		data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 	}
+
+	if (sample_type & PERF_SAMPLE_ADDR && op_data3.dc_lin_addr_valid) {
+		data->addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
+		data->sample_flags |= PERF_SAMPLE_ADDR;
+	}
 }
 
 static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
@@ -992,7 +997,8 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
 	if (sample_type & PERF_SAMPLE_RAW ||
 	    (perf_ibs == &perf_ibs_op &&
 	     (sample_type & PERF_SAMPLE_DATA_SRC ||
-	      sample_type & PERF_SAMPLE_WEIGHT_TYPE)))
+	      sample_type & PERF_SAMPLE_WEIGHT_TYPE ||
+	      sample_type & PERF_SAMPLE_ADDR)))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
-- 
2.31.1

