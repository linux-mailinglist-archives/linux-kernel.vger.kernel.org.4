Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1275B8D67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiINQpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiINQp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:45:27 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC187F129;
        Wed, 14 Sep 2022 09:45:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDE7h54DYeb3N4+BK169l+TPRz+5gwQ8TX/f2x9gBakL9q3cwWWc3jbK4F7CY5Lifnu4fWtaKUNxi4kPK5MndwLdRSuG/OM0KuqE0NOBqRq1MqRERM0XhNRgLzb5Q0iV4b0R4ry3HnYByEK6H/gxvzB1B/i8X4jwSvkayhB4LRsfIH4wWuagRLbohm8BtnlMq6AYRAEYtVu4sPDDaiZiXPQJu3JvavfmaaYgI9wKFElyIV2w4Bmd+H6I5l9KNdYv7XVA6aCobxLT6mt9MbcTL3AU/T0TQVXVRtlF6ZfDH9fgbFC0TWGeKpdvu2P1/dBpuDbgqIl5OU/X21eQ7wyvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNZHcCXbB0y3I6Ipa8Icz0vIG/QLZZEeWB5qf6doeWY=;
 b=Igvhi4e0TCTeRWN8j3HsLCbzun1Uwq0y2soVHOxxhaJ/q5ivuREYo4m9vqlu8UdSmCGKR0q62ebc6pMcnSpnHDRyScax6IctjAu2d/2V2WWFYo/PGNHDFsLZo/3h8qmg2hDtaPsMw0LQwMLFW3VmQoNFbDo5Nhzm+0FxS45NcSkZZFFI9lUzGTbKYoiX5cr9vfgqVrQNQ4HSM5MDNO98dbGMxFTkbB6o4PsaBX1ZNE+V5JFMImqf6Jgiqe4AaMcw+oSV1ljgiSyFVfafzUGECLmOiN0v/3pGYtCKwvNGWEcXtxHY2ikiZAPbYmyvzdXOPrAeZKivd1MB4IrhVkGMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNZHcCXbB0y3I6Ipa8Icz0vIG/QLZZEeWB5qf6doeWY=;
 b=BizFPFHll80W3rARLIjN3el1JsYUKF0h5CtTjmE2X/K+O/VHidNVnU40iYRlnoVu5h2auwvC0U3spT+SOZ7BvqwhXOX+O955hIvBZToCgCLCHCqK+UXjCrXmtRwY3x+hEr51g7yO9MPmN4Sm8rrUlCkCv25DWkJuz5wD+jre1DA=
Received: from BN9P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::14)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 16:45:16 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::c8) by BN9P221CA0022.outlook.office365.com
 (2603:10b6:408:10a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 16:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 16:45:16 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 11:45:12 -0500
From:   Arvind Yadav <Arvind.Yadav@amd.com>
To:     <Christian.Koenig@amd.com>, <andrey.grodzovsky@amd.com>,
        <shashank.sharma@amd.com>, <amaranath.somalapuram@amd.com>,
        <Arunpravin.PaneerSelvam@amd.com>, <sumit.semwal@linaro.org>,
        <gustavo@padovan.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
CC:     Arvind Yadav <Arvind.Yadav@amd.com>
Subject: [PATCH v4 5/6] drm/sched: Use parent fence instead of finished
Date:   Wed, 14 Sep 2022 22:13:20 +0530
Message-ID: <20220914164321.2156-6-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914164321.2156-1-Arvind.Yadav@amd.com>
References: <20220914164321.2156-1-Arvind.Yadav@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: 225b18ad-86b3-422d-9498-08da967080c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4Nur2dsnFH0PeghFNHP+i59dFgYfaZf3mL9q6RmvGrosdKDx7JXTeyJdxdK2WmkniVv3L1qE8F6U6TjiVnI1jJPZGNPEaREFCsnX/mUG+CzFGIcDIXh8Qd15+UyxRkJE2tiEDnY2VjaLQsoVRJqkOgLgc9yEEaZj1kQIrnUCs53i5wUceqiVjNzKgxBPvowfPQHxrytIzPApCdDrb/2dhhtDwYZP0FIGMSB7q5YDl7bqn7ggukyIvjzwIRMT/t4UdgWoOY6pEtmWzP35qlGRUcNkJ6eB61g6R8VbeZTma68ZnsOnkyc8E1MlWM4H9U9YhMgIQg40cYnBzi7DQuQGKC8WbZzWiWLgsuUKLpIXzKyZbTaC0YWmRVyEOqZUa+u5TdFcElX375lnjDi+XVbgL6Nrm6OnL5NA/HqMQJCA8OIgQvvMuDJXef0npotd0UiuKH+XgB9s6G3q2TGPsj8e/ETy8MhcH/wYAlHqnpj1GNWiv8Ve48b7BlErsn63WETKrI5ZdS4IlpO8EqA6g1zud/INYKwBUPjMD/o2SbHc7g7IE04dOT3GbAJ+/IFXAXzd7ys+Cm4SqsOxrkJuTigp0GP4KYy66mzZzCWeUnBMGNey+qcDXgWUCIQpYh3gpTRVYGBVs7ptVY9M8CBAdf3TBPUn4fFV0VNW5x68MzFNp0yFH81S3YJB3Oc7vZcD8gwyjcTBe6BQq05W52+kODY7ftCh/z0660XtowJadBdDaAiWo0wYuY41sSPmbLWk9pjtBBqKiGiFGZaFiwaMxjEQO4gUrujAHBsIhbEbchfFXNL8qaURscqyAm/iTkk6dBfOflR/5jPYNI9CKgrPLDyejJVr4+CgO6OgrLxOe9vkpFYEfs7+KVhap/KknIEDvkD
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(40460700003)(478600001)(4326008)(2906002)(110136005)(8936002)(426003)(70206006)(186003)(6666004)(2616005)(7696005)(336012)(40480700001)(36756003)(26005)(1076003)(82740400003)(47076005)(921005)(83380400001)(8676002)(81166007)(36860700001)(16526019)(356005)(5660300002)(86362001)(316002)(82310400005)(41300700001)(70586007)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 16:45:16.6501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 225b18ad-86b3-422d-9498-08da967080c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the parent fence instead of the finished fence
to get the job status. This change is to avoid GPU
scheduler timeout error which can cause GPU reset.

Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---

changes in v1,v2 - Enable signaling for finished fence in sche_main()
is removed

---
 drivers/gpu/drm/scheduler/sched_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index e0ab14e0fb6b..2ac28ad11432 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -829,7 +829,7 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 	job = list_first_entry_or_null(&sched->pending_list,
 				       struct drm_sched_job, list);
 
-	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
+	if (job && dma_fence_is_signaled(job->s_fence->parent)) {
 		/* remove job from pending_list */
 		list_del_init(&job->list);
 
@@ -841,7 +841,7 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 
 		if (next) {
 			next->s_fence->scheduled.timestamp =
-				job->s_fence->finished.timestamp;
+				job->s_fence->parent->timestamp;
 			/* start TO timer for next job */
 			drm_sched_start_timeout(sched);
 		}
-- 
2.25.1

