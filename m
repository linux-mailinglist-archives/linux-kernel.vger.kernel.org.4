Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C29F62755C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 05:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbiKNEku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 23:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbiKNEkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 23:40:47 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9D8140FC;
        Sun, 13 Nov 2022 20:40:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xgpkl6ZQlLbGZ+gvAkr1ox6eG0QXZH4RrLYGE7e0abBXxBsYGUmaFf0Tf9Xk7f4JGDgSxAPpeuF/Ll8pMxOe3Y0slafzDl0k3LjwozAsk0ApKf6GHDDSTBxZaZW7l1BVRiIeWudybapP6DJ2ACsP/XGCKfyhL6gkoeS/3lCw7cluqq57r5I4bjvzV3PNxbBYzmMXK0jivM9OVKXrQU/c8f/DddYVlFtElwHE2AR1q/Xf9XOgAzpa5CoVwHcu9n3p0ZEFz/c7Ui7Wk7FEPu11QaQdkATygTV0RSbpKFIl2vY5YIdJOjfpZvnIGx2MNG+jJt6olXV+VTyBrIuo2FAL5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDWjL6iYN8zx5bYdHYkPGJkEmt0wBdgmn+8cOVLLmwg=;
 b=OWMi+PHS7syov5xIA577eXeTb8TtPKVlBNEfi3OAT0d1Viyd8dMDu/naJ9iH3+shpOx5ti9S7m0H+6h8pH53qcyq+/AxTTsStXzAwUs0dKyCAzv1i0wi3/NdR3hjFgodmPBhY4zV3QpIPN/ujd+ubYGgDowNMY2sJYQ7Lnj30Up7hKWxRcou8/TAhIEo/2soNNKC2oQM0gBpW/nfv0wjyzNccmkI50zsZB9/mmEGlMW51yl3fFBzNCpu784Pf3KY77KoVCJfIcdmvpt/meXTmByaR8X4Uq+Pu/rVkCYUa1xEdLruZo8hQeMVK0Ka0teyO17x2EM9gO1s3jurwgBA2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDWjL6iYN8zx5bYdHYkPGJkEmt0wBdgmn+8cOVLLmwg=;
 b=Fj+jlusqEl0kQ01lifSgpzWG9aVw4A1rd1Lc3FKFoqfayc2TJNaQzG4ymPuQ4wDt9AFHIhAk7Mg3unDPxGrDXlfOd0DKIk3Dhv3OJ8YkXT4/UadmBwg7kFvZQLw5xqnLUg0kyovhRzAoZrXdU8MuVdv87At2yStoG3LJxXBJ7ac=
Received: from DM6PR02CA0098.namprd02.prod.outlook.com (2603:10b6:5:1f4::39)
 by PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 14 Nov
 2022 04:40:43 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::54) by DM6PR02CA0098.outlook.office365.com
 (2603:10b6:5:1f4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 04:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 04:40:42 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 13 Nov
 2022 22:40:35 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <eranian@google.com>
CC:     <ravi.bangoria@amd.com>, <acme@kernel.org>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <kan.liang@linux.intel.com>, <bp@alien8.de>,
        <mark.rutland@arm.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH] perf/x86/amd: Fix crash due to race between amd_pmu_enable_all, perf NMI and throttling
Date:   Mon, 14 Nov 2022 10:10:29 +0530
Message-ID: <20221114044029.373-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <823b8819-b808-d11c-acbc-9caff9e2f535@amd.com>
References: <823b8819-b808-d11c-acbc-9caff9e2f535@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 376f8948-5bc6-4d7c-f54b-08dac5fa6338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6vSjhHmpCaRSIHwn0h+UQdv2uMYnVzSZRW5U7pyEsuKZj28B3x0JvcdSFa2cXtwHZ+mPK8PB9zUhdV6xs7UXzmWJyCGKWafl18rIn/w4BkNP+Gafnop4HyRTiMo+SZ9+LMNoyeY+/nNP/z7XegqnLfh2P2eIfhSslsxd81OmiWzH56omWTXpVrbk+iNF+FLyXureuFngW+QhE+6Q2oNh0V7mQRdyLiEVLREwLBI8h32ru/PzMFBKdzZlylT/kA86qLEU0+GXvYIiEBihrIsR3+L0SNN0Lt7Uk9EdKx3W4j/M0N3hynKIw5BQdDne/NTfQxYIIDLH0BPAbFKGqRD/zK0dpeNRomqjJbnpDMGHJoFJHHdqmV1JL6ngm9sWDVcKYm4h+vYHDiY2wRARKzQmXvT/XyGL3pJwWZreH9iFM8EYbC2XQK/kgcisrN3DmoALEKQTn507tz/45JV97NjSuVDbSaum6s8b7GiRbl42y2kqmrFScgFSQEAKm2YAQ63lzFwHlfDkpD3pSqYIYukx3xttK/gP3mlpRIeKU1Q9GSdtE1ictxQhR6f5pxBRGLkmBvjFtuZYrLXuBOKSS9QKJh/ljYaQh2cViTmUtq69hjaQYhRrJFfEv4JC+Pjyd2VNukIbrkNz+OxqtDl9Vu/30vZxVDIYBRkQd3CB8Z5UClmu+6McQtYMLilBGG8HWElgnWIWuTIKxFQ+zVLRa037im6KsAvoTi8OSMOL/quM6OJqtk/ytaLLkEyY1k7U5f9GbG2dCxjb8kFx5GK1+n1/jzHME63yFtUTTZnekNhVGfWH1miapzrfVZv5rAafAOf
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(6666004)(7696005)(54906003)(110136005)(70586007)(70206006)(8676002)(4326008)(316002)(478600001)(26005)(8936002)(426003)(2616005)(2906002)(336012)(16526019)(186003)(1076003)(44832011)(5660300002)(47076005)(7416002)(83380400001)(36860700001)(36756003)(82740400003)(356005)(40460700003)(82310400005)(81166007)(86362001)(41300700001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 04:40:42.2738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 376f8948-5bc6-4d7c-f54b-08dac5fa6338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_pmu_enable_all() does:

      if (!test_bit(idx, cpuc->active_mask))
              continue;

      amd_pmu_enable_event(cpuc->events[idx]);

A perf NMI of another event can come between these two steps. Perf NMI
handler internally disables and enables _all_ events, including the one
which nmi-intercepted amd_pmu_enable_all() was in process of enabling.
If that unintentionally enabled event has very low sampling period and
causes immediate successive NMI, causing the event to be throttled,
cpuc->events[idx] and cpuc->active_mask gets cleared by x86_pmu_stop().
This will result in amd_pmu_enable_event() getting called with event=NULL
when amd_pmu_enable_all() resumes after handling the NMIs. This causes a
kernel crash:

  BUG: kernel NULL pointer dereference, address: 0000000000000198
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  [...]
  Call Trace:
   <TASK>
   amd_pmu_enable_all+0x68/0xb0
   ctx_resched+0xd9/0x150
   event_function+0xb8/0x130
   ? hrtimer_start_range_ns+0x141/0x4a0
   ? perf_duration_warn+0x30/0x30
   remote_function+0x4d/0x60
   __flush_smp_call_function_queue+0xc4/0x500
   flush_smp_call_function_queue+0x11d/0x1b0
   do_idle+0x18f/0x2d0
   cpu_startup_entry+0x19/0x20
   start_secondary+0x121/0x160
   secondary_startup_64_no_verify+0xe5/0xeb
   </TASK>

amd_pmu_disable_all()/amd_pmu_enable_all() calls inside perf NMI handler
were recently added as part of BRS enablement but I'm not sure whether
we really need them. We can just disable BRS in the beginning and enable
it back while returning from NMI. This will solve the issue by not
enabling those events whose active_masks are set but are not yet enabled
in hw pmu.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Fixes: ada543459cab ("perf/x86/amd: Add AMD Fam19h Branch Sampling support")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8b70237c33f7..d6f3703e4119 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -861,8 +861,7 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 	pmu_enabled = cpuc->enabled;
 	cpuc->enabled = 0;
 
-	/* stop everything (includes BRS) */
-	amd_pmu_disable_all();
+	amd_brs_disable_all();
 
 	/* Drain BRS is in use (could be inactive) */
 	if (cpuc->lbr_users)
@@ -873,7 +872,7 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 
 	cpuc->enabled = pmu_enabled;
 	if (pmu_enabled)
-		amd_pmu_enable_all(0);
+		amd_brs_enable_all();
 
 	return amd_pmu_adjust_nmi_window(handled);
 }
-- 
2.37.3

