Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB5668EA99
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjBHJJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjBHJJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:09:15 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C07945BEA;
        Wed,  8 Feb 2023 01:09:07 -0800 (PST)
X-UUID: 38bda29aa79011eda06fc9ecc4dadd91-20230208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KpS7zOQiS8xm+MgSXF0zo7YlE8zlcISMKY7OkefTdQ8=;
        b=f86rdaVL3q/lbHKfyVB/jqUIlonardrLQlpELWZYAQX00yJvEnMTtkvsMYbbXQBIU4DCRmkXuhQ2QBmXwqGiDCJJ7r0miO4Ydd5nJOCw93Nn5G1vYzRUmPHMBCyoZu73pMuoxvBi5zcTEnIea6bFrWAGTbFRtXZ3Tv7CozQfubs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:db8a735e-0622-4624-9ac0-69dee28a0f3e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:0233d4f7-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 38bda29aa79011eda06fc9ecc4dadd91-20230208
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 952723087; Wed, 08 Feb 2023 17:08:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Feb 2023 17:08:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 8 Feb 2023 17:08:58 +0800
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
Subject: [PATCH v6 10/12] media: platform: mtk-mdp3: Split general definitions used in MDP3
Date:   Wed, 8 Feb 2023 17:08:53 +0800
Message-ID: <20230208090855.18934-11-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230208090855.18934-1-moudy.ho@mediatek.com>
References: <20230208090855.18934-1-moudy.ho@mediatek.com>
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

Separate the generic definitions used in MDP3 to avoid recursive includes
when splitting chip-related definitions in further.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mtk-img-ipi.h      | 46 +---------------
 .../platform/mediatek/mdp3/mtk-mdp3-type.h    | 53 +++++++++++++++++++
 2 files changed, 54 insertions(+), 45 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
index c7f231f8ea3e..f5296994137a 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
@@ -8,7 +8,7 @@
 #ifndef __MTK_IMG_IPI_H__
 #define __MTK_IMG_IPI_H__
 
-#include <linux/types.h>
+#include "mtk-mdp3-type.h"
 
 /*
  * ISP-MDP generic input information
@@ -16,12 +16,6 @@
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
@@ -71,17 +65,6 @@ struct img_image_buffer {
 
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
@@ -146,20 +129,6 @@ struct img_comp_frame {
 	u32 out_total_width;
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
 	u32 tile_disable;
 	struct img_region in;
@@ -267,19 +236,6 @@ struct img_compparam {
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
index 000000000000..ae0396806152
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
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

