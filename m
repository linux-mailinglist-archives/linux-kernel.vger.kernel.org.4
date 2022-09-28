Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D551E5ED99F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiI1J7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiI1J7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:59:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1485ABA6;
        Wed, 28 Sep 2022 02:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=At+UWR0KiVbgJjptOQpx6PGUOAnxwUjvjoB8vMzHMWsePIB9Bwzgz77vEuPWry4lx9/Wqv362Gwsdq5xihxEoobSiFpUIpA0kJc//IS4KZSPPsWfwsRENdm4I8JabFufaTn+mlmlC62UnAVfvNfrHw9VR6+yLemjp+u+nPvFwS04wNky6vOetfYeZWOmkwx0mWV00376jC6CK9SCtpgm+N0REdeqgdkbB1YPe2mrJ2a01elUtTe5AA+HFu2yWGPQNVk2Ks5tkjO8HsRkVZeIiagmBWxdvQdA96SbxnGGjT56uLPoqhVXPLPgMsh/bevTpbZUFOwseHjQPo/9KCWZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai3xh6q/IN0Rf/7Isr1Cy2gwm2PR4siqjSISILZuHP8=;
 b=cUATqqORWQ7LitcSqCcQHTy+XT+qG7vnNpoSzsF7w2BSMbRctXuESsjnaAr7V1dW4scrx8vu+wE9mSKCkD2xq95y5GDknLFUgB9ZL6eViokGKtMA4btMq2MScENKm/wKGGn3WsI5E3xSpIGiVINvoLZZgbPZKOL/lBg5H2MCSSqUh6SXpoFaEg40Ax+sEyr/vBfLB2xIqr3G20NFSNaotqD4ze6k26mCq8Iak2AWG1adnHxsv0MuAkYvshxds3hDKFy2DvNY7b3krZ1T+0hX378SEwXLN0OiJrjhIhKzCL62RJa9b+t4LOHPF2uUTQ5xF8Ool8s7LN8ACF6PEXH8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai3xh6q/IN0Rf/7Isr1Cy2gwm2PR4siqjSISILZuHP8=;
 b=yA+dsQkyrnIgeSb6f3diKeBMywz+WhJBmhFY8Eb5H6aFu5M4vmrMvPMqAIVjhoXV2ErjRMvAtmatzW2aWO0Uccdc7FsSFjHSkJ340ATk9Oc6Rw4B2JSYIAseJ4h8hiyvj5jihcJReg2rtmPNqcFPPrBgqYgXm2JC24h9dEhXMgQ=
Received: from MW4PR04CA0357.namprd04.prod.outlook.com (2603:10b6:303:8a::32)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 09:59:28 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::a9) by MW4PR04CA0357.outlook.office365.com
 (2603:10b6:303:8a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 09:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 09:59:28 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 04:59:18 -0500
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
Subject: [PATCH v3 03/15] perf/x86/amd: Support PERF_SAMPLE_DATA_SRC
Date:   Wed, 28 Sep 2022 15:27:53 +0530
Message-ID: <20220928095805.596-4-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 8844cc63-7823-4e80-627e-08daa13821db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUTXWpfvVwdNJTSGUWRUlpS1ztSqTyDoAE7pbYwcSsHIyX9bEF2Ccyfw1x3xwMyqUn9vZuFg1Ghd7DwPhFWGoApOSYsydoD4fFGfA1gmNbJN9ovZ84hkI7YO1Hg3y2dteuMe3KcasMWVxi6xTA0kA9FLDGZ/UX7nUnKzApefhHKXzjw4UFe/DMt2R2BNoADwctotl67ta9pDeyp9LssPIGofWV4BEnT4gnZmEVu3P88LSh9G0jrgpQsPpCzVnpDJN7jNBiVM3P1Agulqzu8LCvbr5QnGYF/rQZ2v00xkKmSGLh8HKeDyEIVKCatiE0M4mURPCwThqgudoD86l2VOCTW8Qz1a2HyXliuUMwXUbbbPBm7a0tw4IK88UGfz62MA8OY9vULKxpmUFELGw7Srr0QsX3r4OWJurvxYABD7i1v5YcMseLgISxHJa8qoYg6OzR9EByyKPY3nUmT+DYmC1BSFHw2670XXwMxNrouTDtNOYYaGx7X+HXytqu55ROAg1ZQ+jXBKnCIfDA2SusN4U56UtNDn/7kO2Dh8ieeNW5OJDYJZJdvAyTKJobYsaaNo6nlF7cjf6rtiaqDmWmpw+NpCbp0bO5/H38vHzX91mpSU1+CakFLEivianhbGarIyAkPmjwpxacOgoCahRmk5lganxQII9uw+yKTfQYQ6NwjNZP3OXP+yiIgJf+x+fUqc9ixf7NYxx0C8JCQTWG5o54+4UlhhltIyi6yNK0wjWw0a4InHRuFqHy40tC4c0lcdJSwroElbPZjPVhL2qdDNBIVYdRlHpHeFbifriunDQ2CNvpeqEURyJjoZJ+G7msOl
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(110136005)(47076005)(5660300002)(82740400003)(426003)(81166007)(336012)(83380400001)(16526019)(356005)(1076003)(2616005)(36860700001)(186003)(7416002)(40460700003)(2906002)(30864003)(82310400005)(40480700001)(70586007)(478600001)(6666004)(44832011)(41300700001)(26005)(7696005)(8676002)(70206006)(316002)(8936002)(54906003)(36756003)(4326008)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 09:59:28.2894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8844cc63-7823-4e80-627e-08daa13821db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct perf_mem_data_src is used to pass arch specific memory access
details into generic form. These details gets consumed by tools like
perf mem and c2c. IBS tagged load/store sample provides most of the
information needed for these tools. Add a logic to convert IBS
specific raw data into perf_mem_data_src.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 318 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 312 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c29a006954c7..e20caa5cf02f 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -678,6 +678,312 @@ static struct perf_ibs perf_ibs_op = {
 	.get_count		= get_ibs_op_count,
 };
 
+static void perf_ibs_get_mem_op(union ibs_op_data3 *op_data3,
+				struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+
+	data_src->mem_op = PERF_MEM_OP_NA;
+
+	if (op_data3->ld_op)
+		data_src->mem_op = PERF_MEM_OP_LOAD;
+	else if (op_data3->st_op)
+		data_src->mem_op = PERF_MEM_OP_STORE;
+}
+
+/*
+ * Processors having CPUID_Fn8000001B_EAX[11] aka IBS_CAPS_ZEN4 has
+ * more fine granular DataSrc encodings. Others have coarse.
+ */
+static u8 perf_ibs_data_src(union ibs_op_data2 *op_data2)
+{
+	if (ibs_caps & IBS_CAPS_ZEN4)
+		return (op_data2->data_src_hi << 3) | op_data2->data_src_lo;
+
+	return op_data2->data_src_lo;
+}
+
+static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
+				 union ibs_op_data3 *op_data3,
+				 struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+	u8 ibs_data_src = perf_ibs_data_src(op_data2);
+
+	data_src->mem_lvl = 0;
+
+	/*
+	 * DcMiss, L2Miss, DataSrc, DcMissLat etc. are all invalid for Uncached
+	 * memory accesses. So, check DcUcMemAcc bit early.
+	 */
+	if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO) {
+		data_src->mem_lvl = PERF_MEM_LVL_UNC | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	/* L1 Hit */
+	if (op_data3->dc_miss == 0) {
+		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	/* L2 Hit */
+	if (op_data3->l2_miss == 0) {
+		/* Erratum #1293 */
+		if (boot_cpu_data.x86 != 0x19 || boot_cpu_data.x86_model > 0xF ||
+		    !(op_data3->sw_pf || op_data3->dc_miss_no_mab_alloc)) {
+			data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
+			return;
+		}
+	}
+
+	/*
+	 * OP_DATA2 is valid only for load ops. Skip all checks which
+	 * uses OP_DATA2[DataSrc].
+	 */
+	if (data_src->mem_op != PERF_MEM_OP_LOAD)
+		goto check_mab;
+
+	/* L3 Hit */
+	if (ibs_caps & IBS_CAPS_ZEN4) {
+		if (ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE) {
+			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
+			return;
+		}
+	} else {
+		if (ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
+			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_REM_CCE1 |
+					    PERF_MEM_LVL_HIT;
+			return;
+		}
+	}
+
+	/* A peer cache in a near CCX */
+	if (ibs_caps & IBS_CAPS_ZEN4 &&
+	    ibs_data_src == IBS_DATA_SRC_EXT_NEAR_CCX_CACHE) {
+		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	/* A peer cache in a far CCX */
+	if (ibs_caps & IBS_CAPS_ZEN4) {
+		if (ibs_data_src == IBS_DATA_SRC_EXT_FAR_CCX_CACHE) {
+			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
+			return;
+		}
+	} else {
+		if (ibs_data_src == IBS_DATA_SRC_REM_CACHE) {
+			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
+			return;
+		}
+	}
+
+	/* DRAM */
+	if (ibs_data_src == IBS_DATA_SRC_EXT_DRAM) {
+		if (op_data2->rmt_node == 0)
+			data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
+		else
+			data_src->mem_lvl = PERF_MEM_LVL_REM_RAM1 | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	/* PMEM */
+	if (ibs_caps & IBS_CAPS_ZEN4 && ibs_data_src == IBS_DATA_SRC_EXT_PMEM) {
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_PMEM;
+		if (op_data2->rmt_node) {
+			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+			/* IBS doesn't provide Remote socket detail */
+			data_src->mem_hops = PERF_MEM_HOPS_1;
+		}
+		return;
+	}
+
+	/* Extension Memory */
+	if (ibs_caps & IBS_CAPS_ZEN4 &&
+	    ibs_data_src == IBS_DATA_SRC_EXT_EXT_MEM) {
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_EXTN_MEM;
+		if (op_data2->rmt_node) {
+			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+			/* IBS doesn't provide Remote socket detail */
+			data_src->mem_hops = PERF_MEM_HOPS_1;
+		}
+		return;
+	}
+
+	/* IO */
+	if (ibs_data_src == IBS_DATA_SRC_EXT_IO) {
+		data_src->mem_lvl = PERF_MEM_LVL_IO;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_IO;
+		if (op_data2->rmt_node) {
+			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+			/* IBS doesn't provide Remote socket detail */
+			data_src->mem_hops = PERF_MEM_HOPS_1;
+		}
+		return;
+	}
+
+check_mab:
+	/*
+	 * MAB (Miss Address Buffer) Hit. MAB keeps track of outstanding
+	 * DC misses. However, such data may come from any level in mem
+	 * hierarchy. IBS provides detail about both MAB as well as actual
+	 * DataSrc simultaneously. Prioritize DataSrc over MAB, i.e. set
+	 * MAB only when IBS fails to provide DataSrc.
+	 */
+	if (op_data3->dc_miss_no_mab_alloc) {
+		data_src->mem_lvl = PERF_MEM_LVL_LFB | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	data_src->mem_lvl = PERF_MEM_LVL_NA;
+}
+
+static bool perf_ibs_cache_hit_st_valid(void)
+{
+	/* 0: Uninitialized, 1: Valid, -1: Invalid */
+	static int cache_hit_st_valid;
+
+	if (unlikely(!cache_hit_st_valid)) {
+		if (boot_cpu_data.x86 == 0x19 &&
+		    (boot_cpu_data.x86_model <= 0xF ||
+		    (boot_cpu_data.x86_model >= 0x20 &&
+		     boot_cpu_data.x86_model <= 0x5F))) {
+			cache_hit_st_valid = -1;
+		} else {
+			cache_hit_st_valid = 1;
+		}
+	}
+
+	return cache_hit_st_valid == 1;
+}
+
+static void perf_ibs_get_mem_snoop(union ibs_op_data2 *op_data2,
+				   struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+	u8 ibs_data_src;
+
+	data_src->mem_snoop = PERF_MEM_SNOOP_NA;
+
+	if (!perf_ibs_cache_hit_st_valid() ||
+	    data_src->mem_op != PERF_MEM_OP_LOAD ||
+	    data_src->mem_lvl & PERF_MEM_LVL_L1 ||
+	    data_src->mem_lvl & PERF_MEM_LVL_L2 ||
+	    op_data2->cache_hit_st)
+		return;
+
+	ibs_data_src = perf_ibs_data_src(op_data2);
+
+	if (ibs_caps & IBS_CAPS_ZEN4) {
+		if (ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE ||
+		    ibs_data_src == IBS_DATA_SRC_EXT_NEAR_CCX_CACHE ||
+		    ibs_data_src == IBS_DATA_SRC_EXT_FAR_CCX_CACHE)
+			data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+	} else if (ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
+		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+	}
+}
+
+static void perf_ibs_get_tlb_lvl(union ibs_op_data3 *op_data3,
+				 struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+
+	data_src->mem_dtlb = PERF_MEM_TLB_NA;
+
+	if (!op_data3->dc_lin_addr_valid)
+		return;
+
+	if (!op_data3->dc_l1tlb_miss) {
+		data_src->mem_dtlb = PERF_MEM_TLB_L1 | PERF_MEM_TLB_HIT;
+		return;
+	}
+
+	if (!op_data3->dc_l2tlb_miss) {
+		data_src->mem_dtlb = PERF_MEM_TLB_L2 | PERF_MEM_TLB_HIT;
+		return;
+	}
+
+	data_src->mem_dtlb = PERF_MEM_TLB_L2 | PERF_MEM_TLB_MISS;
+}
+
+static void perf_ibs_get_mem_lock(union ibs_op_data3 *op_data3,
+				  struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+
+	data_src->mem_lock = PERF_MEM_LOCK_NA;
+
+	if (op_data3->dc_locked_op)
+		data_src->mem_lock = PERF_MEM_LOCK_LOCKED;
+}
+
+#define ibs_op_msr_idx(msr)	(msr - MSR_AMD64_IBSOPCTL)
+
+static void perf_ibs_get_data_src(struct perf_ibs_data *ibs_data,
+				  struct perf_sample_data *data,
+				  union ibs_op_data2 *op_data2,
+				  union ibs_op_data3 *op_data3)
+{
+	perf_ibs_get_mem_lvl(op_data2, op_data3, data);
+	perf_ibs_get_mem_snoop(op_data2, data);
+	perf_ibs_get_tlb_lvl(op_data3, data);
+	perf_ibs_get_mem_lock(op_data3, data);
+}
+
+static __u64 perf_ibs_get_op_data2(struct perf_ibs_data *ibs_data,
+				   union ibs_op_data3 *op_data3)
+{
+	__u64 val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA2)];
+
+	/* Erratum #1293 */
+	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model <= 0xF &&
+	    (op_data3->sw_pf || op_data3->dc_miss_no_mab_alloc)) {
+		/*
+		 * OP_DATA2 has only two fields on Zen3: DataSrc and RmtNode.
+		 * DataSrc=0 is 'No valid status' and RmtNode is invalid when
+		 * DataSrc=0.
+		 */
+		val = 0;
+	}
+	return val;
+}
+
+static void perf_ibs_parse_ld_st_data(__u64 sample_type,
+				      struct perf_ibs_data *ibs_data,
+				      struct perf_sample_data *data)
+{
+	union ibs_op_data3 op_data3;
+	union ibs_op_data2 op_data2;
+
+	data->data_src.val = PERF_MEM_NA;
+	op_data3.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+
+	perf_ibs_get_mem_op(&op_data3, data);
+	if (data->data_src.mem_op != PERF_MEM_OP_LOAD &&
+	    data->data_src.mem_op != PERF_MEM_OP_STORE)
+		return;
+
+	op_data2.val = perf_ibs_get_op_data2(ibs_data, &op_data3);
+
+	if (sample_type & PERF_SAMPLE_DATA_SRC) {
+		perf_ibs_get_data_src(ibs_data, data, &op_data2, &op_data3);
+		data->sample_flags |= PERF_SAMPLE_DATA_SRC;
+	}
+}
+
+static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
+				   int check_rip)
+{
+	if (sample_type & PERF_SAMPLE_RAW ||
+	    (perf_ibs == &perf_ibs_op &&
+	     sample_type & PERF_SAMPLE_DATA_SRC))
+		return perf_ibs->offset_max;
+	else if (check_rip)
+		return 3;
+	return 1;
+}
+
 static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 {
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
@@ -725,12 +1031,9 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	size = 1;
 	offset = 1;
 	check_rip = (perf_ibs == &perf_ibs_op && (ibs_caps & IBS_CAPS_RIPINVALIDCHK));
-	if (event->attr.sample_type & PERF_SAMPLE_RAW)
-		offset_max = perf_ibs->offset_max;
-	else if (check_rip)
-		offset_max = 3;
-	else
-		offset_max = 1;
+
+	offset_max = perf_ibs_get_offset_max(perf_ibs, event->attr.sample_type, check_rip);
+
 	do {
 		rdmsrl(msr + offset, *buf++);
 		size++;
@@ -784,6 +1087,9 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		data.sample_flags |= PERF_SAMPLE_RAW;
 	}
 
+	if (perf_ibs == &perf_ibs_op)
+		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
+
 	/*
 	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
 	 * recorded as part of interrupt regs. Thus we need to use rip from
-- 
2.31.1

