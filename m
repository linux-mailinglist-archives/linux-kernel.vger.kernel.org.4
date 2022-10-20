Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DAD6058D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJTHjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiJTHjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:39:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4464D17359A;
        Thu, 20 Oct 2022 00:39:16 -0700 (PDT)
X-UUID: a8ae99c68b03475495a42f9ea4f5dfff-20221020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RVnHnjZIbc03C/0P+k/dMEPQcRFLgg8+dULkY97lXN8=;
        b=jKLi8IcB313/2qx6Ku8yTKikG0puaZUjcrIruOis23LMjmoFDMpqACAOVLC4y7eew9Aw32kiC4bjjgfkWbJwAHz1V1NIQ7M8hH3YKZzytgyuvjFRBSRWr/V2AVXD+QHCH5BAi399zt07WR/aRWrHSrDzVbeWCIjNATBeNMs6lz4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:9e468be0-e2e0-40aa-9e21-a460fb04ed3c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:9e468be0-e2e0-40aa-9e21-a460fb04ed3c,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:f87c66a4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:221020153911KCFZW3BJ,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a8ae99c68b03475495a42f9ea4f5dfff-20221020
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 181684689; Thu, 20 Oct 2022 15:39:09 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 20 Oct 2022 15:39:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 20 Oct 2022 15:39:08 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v2 1/9] media: platform: mtk-mdp3: add chip configuration header file
Date:   Thu, 20 Oct 2022 15:38:54 +0800
Message-ID: <20221020073902.21039-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221020073902.21039-1-moudy.ho@mediatek.com>
References: <20221020073902.21039-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be compatible with more MDP3 chip settings in the future,
move the chip-related configuration to a separate header file.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../mediatek/mdp3/mt8183/mdp3-plat-mt8183.h   | 35 +++++++++++++++++++
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 27 ++------------
 2 files changed, 37 insertions(+), 25 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h

diff --git a/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
new file mode 100644
index 000000000000..3084f62e7df5
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#ifndef __MDP3_PLAT_MT8183_H__
+#define __MDP3_PLAT_MT8183_H__
+
+static const struct mdp_platform_config mt8183_plat_cfg = {
+	.rdma_support_10bit		= true,
+	.rdma_rsz1_sram_sharing		= true,
+	.rdma_upsample_repeat_only	= true,
+	.rsz_disable_dcm_small_sample	= false,
+	.wrot_filter_constraint		= false,
+};
+
+static const struct of_device_id mt8183_mdp_probe_infra[MDP_INFRA_MAX] = {
+	[MDP_INFRA_MMSYS] = { .compatible = "mediatek,mt8183-mmsys" },
+	[MDP_INFRA_MUTEX] = { .compatible = "mediatek,mt8183-disp-mutex" },
+	[MDP_INFRA_SCP] = { .compatible = "mediatek,mt8183-scp" }
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
+#endif  /* __MDP3_PLAT_MT8183_H__ */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 2d1f6ae9f080..658037d06250 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -12,33 +12,10 @@
 #include <linux/remoteproc.h>
 #include <linux/remoteproc/mtk_scp.h>
 #include <media/videobuf2-dma-contig.h>
+
 #include "mtk-mdp3-core.h"
 #include "mtk-mdp3-m2m.h"
-
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
+#include "mt8183/mdp3-plat-mt8183.h"
 
 static const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.mdp_probe_infra = mt8183_mdp_probe_infra,
-- 
2.18.0

