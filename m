Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7CA6176EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiKCGtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiKCGtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:49:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC066401;
        Wed,  2 Nov 2022 23:48:51 -0700 (PDT)
X-UUID: 59017fee095b448f962da20e1a76af95-20221103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ml8P8ayllJ++wfxnbSOAXCJKmop75h7nDZiOwvUnQgM=;
        b=QPrcPtOxVYhmJzUosYMfXhWSlb32bIJum1N/gp/w1FWXZVghBx7Sox3dhyD4Z00FWJR0PPSrEAfigk/hq7YhSjiWMcKV6UgeOotZpl/eN2PlWHtSXYs0cMuPxlgxJUT4AOovBmZ8JDumAzvUXjiYsANeIJSYVaFWYhcs0CHpVz4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:457f1577-6152-4c0c-8527-0b4ee2664fb0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:457f1577-6152-4c0c-8527-0b4ee2664fb0,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:4ecf7d81-3116-4fbc-b86b-83475c3df513,B
        ulkID:221103144848PX7J4F8M,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 59017fee095b448f962da20e1a76af95-20221103
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 574321770; Thu, 03 Nov 2022 14:48:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 3 Nov 2022 14:48:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 3 Nov 2022 14:48:45 +0800
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
Subject: [PATCH v3 09/10] media: platform: mtk-mdp3: Split general definitions used in MDP3
Date:   Thu, 3 Nov 2022 14:48:41 +0800
Message-ID: <20221103064842.12042-10-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221103064842.12042-1-moudy.ho@mediatek.com>
References: <20221103064842.12042-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the generic definitions used in mdp3 to avoid recursive includes
when splitting chip-related definitions in further.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mtk-img-ipi.h      | 45 +---------------
 .../platform/mediatek/mdp3/mtk-mdp3-type.h    | 53 +++++++++++++++++++
 2 files changed, 54 insertions(+), 44 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
index eabfa538325d..7078f997e3cb 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
@@ -9,6 +9,7 @@
 #define __MTK_IMG_IPI_H__
 
 #include <linux/types.h>
+#include "mtk-mdp3-type.h"
 
 /*
  * ISP-MDP generic input information
@@ -16,12 +17,6 @@
  *     6da52bdcf4bf76a0983b313e1d4745d6
  */
 
-#define IMG_MAX_HW_INPUTS	3
-
-#define IMG_MAX_HW_OUTPUTS	4
-
-#define IMG_MAX_PLANES		3
-
 #define IMG_IPI_INIT    1
 #define IMG_IPI_DEINIT  2
 #define IMG_IPI_FRAME   3
@@ -71,17 +66,6 @@ struct img_image_buffer {
 
 #define IMG_SUBPIXEL_SHIFT	20
 
-struct img_crop {
-	s32 left;
-	s32 top;
-	u32 width;
-	u32 height;
-	u32 left_subpix;
-	u32 top_subpix;
-	u32 width_subpix;
-	u32 height_subpix;
-} __packed;
-
 #define IMG_CTRL_FLAG_HFLIP	BIT(0)
 #define IMG_CTRL_FLAG_DITHER	BIT(1)
 #define IMG_CTRL_FLAG_SHARPNESS	BIT(4)
@@ -146,20 +130,6 @@ struct img_comp_frame {
 	u16 out_total_width;
 } __packed;
 
-struct img_region {
-	s32 left;
-	s32 right;
-	s32 top;
-	s32 bottom;
-} __packed;
-
-struct img_offset {
-	s32 left;
-	s32 top;
-	u32 left_subpix;
-	u32 top_subpix;
-} __packed;
-
 struct img_comp_subfrm {
 	u32 tile_disable:1;
 	struct img_region in;
@@ -267,19 +237,6 @@ struct img_compparam {
 	};
 } __packed;
 
-#define IMG_MAX_COMPONENTS	20
-
-struct img_mux {
-	u32 reg;
-	u32 value;
-	u32 subsys_id;
-} __packed;
-
-struct img_mmsys_ctrl {
-	struct img_mux sets[IMG_MAX_COMPONENTS * 2];
-	u32 num_sets;
-} __packed;
-
 struct img_config {
 	struct img_compparam components[IMG_MAX_COMPONENTS];
 	u32 num_components;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
new file mode 100644
index 000000000000..37cd7b27548f
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#ifndef __MTK_MDP3_TYPE_H__
+#define __MTK_MDP3_TYPE_H__
+
+#include <linux/types.h>
+
+#define IMG_MAX_HW_INPUTS	3
+#define IMG_MAX_HW_OUTPUTS	4
+#define IMG_MAX_PLANES		3
+#define IMG_MAX_COMPONENTS	20
+
+struct img_crop {
+	s32 left;
+	s32 top;
+	u32 width;
+	u32 height;
+	u32 left_subpix;
+	u32 top_subpix;
+	u32 width_subpix;
+	u32 height_subpix;
+} __packed;
+
+struct img_region {
+	s32 left;
+	s32 right;
+	s32 top;
+	s32 bottom;
+} __packed;
+
+struct img_offset {
+	s32 left;
+	s32 top;
+	u32 left_subpix;
+	u32 top_subpix;
+} __packed;
+
+struct img_mux {
+	u32 reg;
+	u32 value;
+	u32 subsys_id;
+} __packed;
+
+struct img_mmsys_ctrl {
+	struct img_mux sets[IMG_MAX_COMPONENTS * 2];
+	u32 num_sets;
+} __packed;
+
+#endif  /* __MTK_MDP3_TYPE_H__ */
-- 
2.18.0

