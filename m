Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48506DAC34
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbjDGL0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240709AbjDGL0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:26:34 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD78AD2C;
        Fri,  7 Apr 2023 04:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmEKyMwnFOcm2QXGJcPmwU6pYXSLv7UHO9sxqPWYyGB0lkZBujyXXewjdiTpXonTHR7uPi7Dpz6M2Bwe/MAETCIv4rb8Pi8WFmOTnvHKH3/VKkpMhLZ6GNodT7OuSOIoJLTzMZYTp1XELey5BoHOQCIGH0m4i/UaxRjJD/z7yL7Jq7Mzbtp7CiEYv04tWKvH8m/X0g8yYmMElEAIGWKsuKHW/rvfnvt7ZVkmbVMbcPrIeWoh8Bq0GtzrFdkJ+AKv/+IFGMBUVSUnvGfTTsm4Tx/6ZebG6FkVvWhFfoZpzdegJ5bafuVlqocK3b9qZPuLUvFXBOV8eYg0Z3JHEzodaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3z1/SwaOJ9rzXZTB2MnYp+1mU2e1/lP28Aea0TZmnA=;
 b=IiN9oBJKjhGgMzmYp6uQQWmpLfiAP9PGDGAuzQgOzZAGJSbyOCdmaAecM/bl/oiyzMrnKStOzAOsCYOITvrTM4vjN83sDqlYjhTIeag1VPM3HLUlE/Y6bb4P/Y5RfyIl/1aJDI7+T/9YX2rVbnYkmbcbfXpMaIhtXxQB6JcspiWr5FufrsQVK6PV8+mITea0KVQwqPGCZYwc3JLgi3JsYJfi7UpFs5OquVkXywLTGLziL3xpKfk5a3Q/20JGAQCANIq2LUW26VhiIEqnHO1e6oqTKDxLZUcUEh6Y+xJw9pHCjc94loCvRe7D8aTpfSOBvb18+XIZK9eD5Jzq/1xVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3z1/SwaOJ9rzXZTB2MnYp+1mU2e1/lP28Aea0TZmnA=;
 b=XxtDOFvas/+9m4S6ku6IGNU0YEqyU+zwMqas6ifBw/KswOJ8LrIy9PdCJSoFwMkU4RzK01nZo8Hr7LdKyKNr++PvkDQvW0wTCdtiIm2o11lMnwzFA1+XPOjm1gIxDCYMJL3s5xreE3cr7ZULa+C9Xcfk8clqbr6Snoa9MbZvPbU=
Received: from MW4PR03CA0220.namprd03.prod.outlook.com (2603:10b6:303:b9::15)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Fri, 7 Apr
 2023 11:26:07 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::3b) by MW4PR03CA0220.outlook.office365.com
 (2603:10b6:303:b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35 via Frontend
 Transport; Fri, 7 Apr 2023 11:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.28 via Frontend Transport; Fri, 7 Apr 2023 11:26:07 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 06:26:01 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <leo.yan@linaro.org>, <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 7/9] perf mem: Refactor perf_mem__lvl_scnprintf()
Date:   Fri, 7 Apr 2023 16:54:57 +0530
Message-ID: <20230407112459.548-8-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407112459.548-1-ravi.bangoria@amd.com>
References: <20230407112459.548-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b65dd14-d7b7-48c4-a7e4-08db375ae1c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25oM6JrdSkqE9e7Wva+OfiuSAv3CIjxesJ7j1c7U0nw6cpzRzpqaVPZLDrv+97GnsNy/RQJsepFcVfsQ3NuXT+QqlYepYxSBMmaZLLPBN6jKYwNR8wtQ2J7LJW49i8EfXFjki63HXyUXjI9/Ttiz0SOzuDSgZREGMUi1C/mlGN2Q5zYU8SZ6sle7PwWNKv3CJwQYe36mn4obXhJTXNbHlyqWV/BZJJ4TdV5y+M1nTCGrSE7nOPXWa/PbbatZzmi2DfEn9S6LhA48ZoIFWhgXno2g+ib+QdPjK0qTCb9OTvgb0aYNW/cDRb3ypzDIjZ3enlh6VY2FqNPUfoOU4uhuoQxMlgLy6ZTo5FfRxFAMimVEVXlIx/s3UYGBYmKPTeGv4OyarGm9P2F3dbscq/defAPBq5LwY0sj56WsH4tmfHf/WVtaQSODVeDGUp5/xLDkuq2maEUiGSho+2oOnzcY7fyKpm58HWpbfL7IOWJpfrV23Fse2cspjKvC/7xPr39wbrElFRLIvZPOXo+vilF71YxUN6gBySsjAaWtg3lSMLa5cDUJuf1nCGiuCT6B+x8SAKFVXYVf9hjWofjZxEwPJWDL1jW6tYAldVvNFRCyEV8W9QVR+slxnFkq4c83o0h5Qfe4zupd6UnTeWxBRGgR6cAg/qupFs4oK2f7LHYcnOgVQcXxiP8AjZVs6Tb1op6JS4cDWY2QiHQ8a5sqxZ0OSjPgZ93p5ilrdt4XpRse9A1HlKDAbueWfuwTPoEBRtACEZ4yItV9dsnLwyY93Y2Bfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(36756003)(40460700003)(81166007)(2906002)(44832011)(7416002)(5660300002)(336012)(82310400005)(40480700001)(8676002)(8936002)(70586007)(4326008)(356005)(41300700001)(82740400003)(70206006)(86362001)(426003)(2616005)(83380400001)(47076005)(1076003)(54906003)(110136005)(26005)(186003)(7696005)(316002)(16526019)(478600001)(6666004)(101420200003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 11:26:07.6062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b65dd14-d7b7-48c4-a7e4-08db375ae1c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interpretation of perf_mem_data_src by perf_mem__lvl_scnprintf() is
non-intuitive. For ex, it ignores mem_lvl when mem_hops is set but
considers it otherwise. It prints both mem_lvl_num and mem_lvl when
mem_hops is not set.

Refactor this function such that it behaves more intuitively: Use
new API mem_lvl_num|mem_remote|mem_hops if mem_lvl_num contains
value other than PERF_MEM_LVLNUM_NA. Otherwise, fallback to old API
mem_lvl. Since new API has no way to indicate MISS, use it from old
api, otherwise don't club old and new APIs while parsing as well as
printing.

Before:
  $ sudo ./perf mem report -F sample,mem --stdio
  #      Samples  Memory access
  # ............  ........................
  #
          250097  N/A
          188907  L1 hit
            4116  L2 hit
            3496  Remote Cache (1 hop) hit
            3271  Remote Cache (2 hops) hit
             873  L3 hit
             598  Local RAM hit
             438  Remote RAM (1 hop) hit
               1  Uncached hit

After:
  $ sudo ./perf mem report -F sample,mem --stdio
  #      Samples  Memory access
  # ............  .......................................
  #
          255517  N/A
          189989  L1 hit
            4541  L2 hit
            3363  Remote core, same node Any cache hit
            3336  Remote node, same socket Any cache hit
            1275  L3 hit
             743  RAM hit
             545  Remote node, same socket RAM hit
               4  Uncached hit

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/mem-events.c | 89 +++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 3a7c72be8326..ed1ee4b05356 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -344,66 +344,71 @@ static int perf_mem__op_scnprintf(char *out, size_t sz, struct mem_info *mem_inf
 
 int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 {
-	size_t i, l = 0;
-	u64 m =  PERF_MEM_LVL_NA;
-	u64 hit, miss;
+	union perf_mem_data_src data_src;
 	int printed = 0;
-
-	if (mem_info)
-		m  = mem_info->data_src.mem_lvl;
+	size_t l = 0;
+	size_t i;
+	int lvl;
+	char hit_miss[5] = {0};
 
 	sz -= 1; /* -1 for null termination */
 	out[0] = '\0';
 
-	hit = m & PERF_MEM_LVL_HIT;
-	miss = m & PERF_MEM_LVL_MISS;
+	if (!mem_info)
+		goto na;
 
-	/* already taken care of */
-	m &= ~(PERF_MEM_LVL_HIT|PERF_MEM_LVL_MISS);
+	data_src = mem_info->data_src;
 
-	if (mem_info && mem_info->data_src.mem_remote) {
-		strcat(out, "Remote ");
-		l += 7;
-	}
+	if (data_src.mem_lvl & PERF_MEM_LVL_HIT)
+		memcpy(hit_miss, "hit", 3);
+	else if (data_src.mem_lvl & PERF_MEM_LVL_MISS)
+		memcpy(hit_miss, "miss", 4);
 
-	/*
-	 * Incase mem_hops field is set, we can skip printing data source via
-	 * PERF_MEM_LVL namespace.
-	 */
-	if (mem_info && mem_info->data_src.mem_hops) {
-		l += scnprintf(out + l, sz - l, "%s ", mem_hops[mem_info->data_src.mem_hops]);
-	} else {
-		for (i = 0; m && i < ARRAY_SIZE(mem_lvl); i++, m >>= 1) {
-			if (!(m & 0x1))
-				continue;
-			if (printed++) {
-				strcat(out, " or ");
-				l += 4;
-			}
-			l += scnprintf(out + l, sz - l, mem_lvl[i]);
+	lvl = data_src.mem_lvl_num;
+	if (lvl && lvl != PERF_MEM_LVLNUM_NA) {
+		if (data_src.mem_remote) {
+			strcat(out, "Remote ");
+			l += 7;
 		}
+
+		if (data_src.mem_hops)
+			l += scnprintf(out + l, sz - l, "%s ", mem_hops[data_src.mem_hops]);
+
+		if (mem_lvlnum[lvl])
+			l += scnprintf(out + l, sz - l, mem_lvlnum[lvl]);
+		else
+			l += scnprintf(out + l, sz - l, "L%d", lvl);
+
+		l += scnprintf(out + l, sz - l, " %s", hit_miss);
+		return l;
 	}
 
-	if (mem_info && mem_info->data_src.mem_lvl_num) {
-		int lvl = mem_info->data_src.mem_lvl_num;
+	lvl = data_src.mem_lvl;
+	if (!lvl)
+		goto na;
+
+	lvl &= ~(PERF_MEM_LVL_NA | PERF_MEM_LVL_HIT | PERF_MEM_LVL_MISS);
+	if (!lvl)
+		goto na;
+
+	for (i = 0; lvl && i < ARRAY_SIZE(mem_lvl); i++, lvl >>= 1) {
+		if (!(lvl & 0x1))
+			continue;
 		if (printed++) {
 			strcat(out, " or ");
 			l += 4;
 		}
-		if (mem_lvlnum[lvl])
-			l += scnprintf(out + l, sz - l, mem_lvlnum[lvl]);
-		else
-			l += scnprintf(out + l, sz - l, "L%d", lvl);
+		l += scnprintf(out + l, sz - l, mem_lvl[i]);
 	}
 
-	if (l == 0)
-		l += scnprintf(out + l, sz - l, "N/A");
-	if (hit)
-		l += scnprintf(out + l, sz - l, " hit");
-	if (miss)
-		l += scnprintf(out + l, sz - l, " miss");
+	if (printed) {
+		l += scnprintf(out + l, sz - l, " %s", hit_miss);
+		return l;
+	}
 
-	return l;
+na:
+	strcat(out, "N/A");
+	return 3;
 }
 
 static const char * const snoop_access[] = {
-- 
2.34.1

