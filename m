Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB1E6C9A04
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 05:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjC0DO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 23:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjC0DN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 23:13:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41425582;
        Sun, 26 Mar 2023 20:13:45 -0700 (PDT)
X-UUID: 5d555080cc4d11edb6b9f13eb10bd0fe-20230327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7VmBJgriOASC62cUJULR69R/y/ATp3ZjkbCCpiCyZhM=;
        b=ILEnbmnByuJz3Hw9D4OXOmdEi3kr/FSJVLkuuz86KJPmEB+TFyBP+upywNuIxpZ10CpTBInFOfrS7swZW1NXV7Eb1d/ckIz4jRC0W0YY5oyBAt8txNGmkzt7YPMN7RePbj7DEfiHF1cY5G7NLhdxINnZgjJDcSaDSa8lCSuUMVI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:715fb1e8-d380-4bd2-b2f2-06c92d80c3b0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:b6d38f29-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 5d555080cc4d11edb6b9f13eb10bd0fe-20230327
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 830338321; Mon, 27 Mar 2023 11:13:36 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 27 Mar 2023 11:13:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 27 Mar 2023 11:13:36 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v7 02/12] media: platform: mtk-mdp3: add files for chip configuration
Date:   Mon, 27 Mar 2023 11:13:25 +0800
Message-ID: <20230327031335.9663-3-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230327031335.9663-1-moudy.ho@mediatek.com>
References: <20230327031335.9663-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be compatible with more MDP3 chip settings in further,
integrate and separate chip-related configurations into specific files.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 drivers/media/platform/mediatek/mdp3/Makefile |  2 +-
 .../platform/mediatek/mdp3/mdp_cfg_data.c     | 38 +++++++++++++++++++
 .../platform/mediatek/mdp3/mtk-mdp3-cfg.h     | 12 ++++++
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 33 +---------------
 4 files changed, 53 insertions(+), 32 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cfg.h

diff --git a/drivers/media/platform/mediatek/mdp3/Makefile b/drivers/media/platform/mediatek/mdp3/Makefile
index 63e6c87e480b..2ee24195a2dd 100644
--- a/drivers/media/platform/mediatek/mdp3/Makefile
+++ b/drivers/media/platform/mediatek/mdp3/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-mtk-mdp3-y += mtk-mdp3-core.o mtk-mdp3-vpu.o mtk-mdp3-regs.o
+mtk-mdp3-y += mdp_cfg_data.o mtk-mdp3-core.o mtk-mdp3-vpu.o mtk-mdp3-regs.o
 mtk-mdp3-y += mtk-mdp3-m2m.o
 mtk-mdp3-y += mtk-mdp3-comp.o mtk-mdp3-cmdq.o
 
diff --git a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
new file mode 100644
index 000000000000..837b8202dcc7
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#include "mtk-mdp3-core.h"
+
+static const struct of_device_id mt8183_mdp_probe_infra[MDP_INFRA_MAX] = {
+	[MDP_INFRA_MMSYS] = { .compatible = "mediatek,mt8183-mmsys" },
+	[MDP_INFRA_MUTEX] = { .compatible = "mediatek,mt8183-disp-mutex" },
+	[MDP_INFRA_SCP] = { .compatible = "mediatek,mt8183-scp" }
+};
+
+static const struct mdp_platform_config mt8183_plat_cfg = {
+	.rdma_support_10bit		= true,
+	.rdma_rsz1_sram_sharing		= true,
+	.rdma_upsample_repeat_only	= true,
+	.rsz_disable_dcm_small_sample	= false,
+	.wrot_filter_constraint		= false,
+};
+
+static const u32 mt8183_mutex_idx[MDP_MAX_COMP_COUNT] = {
+	[MDP_COMP_RDMA0] = MUTEX_MOD_IDX_MDP_RDMA0,
+	[MDP_COMP_RSZ0] = MUTEX_MOD_IDX_MDP_RSZ0,
+	[MDP_COMP_RSZ1] = MUTEX_MOD_IDX_MDP_RSZ1,
+	[MDP_COMP_TDSHP0] = MUTEX_MOD_IDX_MDP_TDSHP0,
+	[MDP_COMP_WROT0] = MUTEX_MOD_IDX_MDP_WROT0,
+	[MDP_COMP_WDMA] = MUTEX_MOD_IDX_MDP_WDMA,
+	[MDP_COMP_AAL0] = MUTEX_MOD_IDX_MDP_AAL0,
+	[MDP_COMP_CCORR0] = MUTEX_MOD_IDX_MDP_CCORR0,
+};
+
+const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
+	.mdp_probe_infra = mt8183_mdp_probe_infra,
+	.mdp_cfg = &mt8183_plat_cfg,
+	.mdp_mutex_table_idx = mt8183_mutex_idx,
+};
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cfg.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cfg.h
new file mode 100644
index 000000000000..e0a698cba6ff
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cfg.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#ifndef __MTK_MDP3_CFG_H__
+#define __MTK_MDP3_CFG_H__
+
+extern const struct mtk_mdp_driver_data mt8183_mdp_driver_data;
+
+#endif  /* __MTK_MDP3_CFG_H__ */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 97edcd9d1c81..745cb06cc8bc 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -12,40 +12,11 @@
 #include <linux/remoteproc.h>
 #include <linux/remoteproc/mtk_scp.h>
 #include <media/videobuf2-dma-contig.h>
+
 #include "mtk-mdp3-core.h"
+#include "mtk-mdp3-cfg.h"
 #include "mtk-mdp3-m2m.h"
 
-static const struct mdp_platform_config mt8183_plat_cfg = {
-	.rdma_support_10bit		= true,
-	.rdma_rsz1_sram_sharing		= true,
-	.rdma_upsample_repeat_only	= true,
-	.rsz_disable_dcm_small_sample	= false,
-	.wrot_filter_constraint		= false,
-};
-
-static const struct of_device_id mt8183_mdp_probe_infra[MDP_INFRA_MAX] = {
-	[MDP_INFRA_MMSYS] = { .compatible = "mediatek,mt8183-mmsys" },
-	[MDP_INFRA_MUTEX] = { .compatible = "mediatek,mt8183-disp-mutex" },
-	[MDP_INFRA_SCP] = { .compatible = "mediatek,mt8183-scp" }
-};
-
-static const u32 mt8183_mutex_idx[MDP_MAX_COMP_COUNT] = {
-	[MDP_COMP_RDMA0] = MUTEX_MOD_IDX_MDP_RDMA0,
-	[MDP_COMP_RSZ0] = MUTEX_MOD_IDX_MDP_RSZ0,
-	[MDP_COMP_RSZ1] = MUTEX_MOD_IDX_MDP_RSZ1,
-	[MDP_COMP_TDSHP0] = MUTEX_MOD_IDX_MDP_TDSHP0,
-	[MDP_COMP_WROT0] = MUTEX_MOD_IDX_MDP_WROT0,
-	[MDP_COMP_WDMA] = MUTEX_MOD_IDX_MDP_WDMA,
-	[MDP_COMP_AAL0] = MUTEX_MOD_IDX_MDP_AAL0,
-	[MDP_COMP_CCORR0] = MUTEX_MOD_IDX_MDP_CCORR0,
-};
-
-static const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
-	.mdp_probe_infra = mt8183_mdp_probe_infra,
-	.mdp_cfg = &mt8183_plat_cfg,
-	.mdp_mutex_table_idx = mt8183_mutex_idx,
-};
-
 static const struct of_device_id mdp_of_ids[] = {
 	{ .compatible = "mediatek,mt8183-mdp3-rdma",
 	  .data = &mt8183_mdp_driver_data,
-- 
2.18.0

