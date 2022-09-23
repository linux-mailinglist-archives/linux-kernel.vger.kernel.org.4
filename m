Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1EF5E7600
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiIWIlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiIWIk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:40:56 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB40118DEC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:40:51 -0700 (PDT)
X-UUID: 8811e24e72f342a5b266edc8ccb49ade-20220923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=r0OGVc8YlNITM6t+j/cuJTs1G3/JIN2S8nS8+Fy3ir8=;
        b=kVE1f5McOIXRSSIy/51iYGckYaA5yEDlsFLcK/rp1vCS4+Vz4xCdaLzl6p6Hnt8f5Badhdi3Ohe59Vzaqal2MTcrVj8JX1DgR2tdoDcSXJs1irNNdzMixdLeUVNpbJ9JrScQ42OgJhx0xOzRLahUbZ9UNPc+Ij0QjMtUUcYDdsA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:53686092-dcc1-4116-81a0-c03a542b6af3,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.11,REQID:53686092-dcc1-4116-81a0-c03a542b6af3,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:39a5ff1,CLOUDID:8473d8a2-dc04-435c-b19b-71e131a5fc35,B
        ulkID:220923164048ITM2R4PM,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0
X-UUID: 8811e24e72f342a5b266edc8ccb49ade-20220923
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1083366329; Fri, 23 Sep 2022 16:40:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Sep 2022 16:40:44 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 23 Sep 2022 16:40:44 +0800
From:   <xinlei.lee@mediatek.com>
To:     <matthias.bgg@gmail.com>, <jason-jh.lin@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <rex-bc.chen@mediatek.com>, <ck.hu@mediatek.com>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v9,1/3] soc: mediatek: Add all settings to mtk_mmsys_ddp_dpi_fmt_config func
Date:   Fri, 23 Sep 2022 16:40:38 +0800
Message-ID: <1663922440-20242-2-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1663922440-20242-1-git-send-email-xinlei.lee@mediatek.com>
References: <1663922440-20242-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

The difference between MT8186 and other ICs is that when modifying the
output format, we need to modify the mmsys_base+0x400 register to take
effect.
So when setting the dpi output format, we need to call mmsys_func to set
it to MT8186 synchronously.
Adding mmsys all the settings that need to be modified with dpi are for mt8186.

Fixes: a071e52f75d1 ("soc: mediatek: Add mmsys func to adapt to dpi output for MT8186")

Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
---
 drivers/soc/mediatek/mt8186-mmsys.h    |  8 +++++---
 drivers/soc/mediatek/mtk-mmsys.c       | 27 ++++++++++++++++++++------
 include/linux/soc/mediatek/mtk-mmsys.h |  7 +++++++
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/mediatek/mt8186-mmsys.h b/drivers/soc/mediatek/mt8186-mmsys.h
index 09b1ccbc0093..035aec1eb616 100644
--- a/drivers/soc/mediatek/mt8186-mmsys.h
+++ b/drivers/soc/mediatek/mt8186-mmsys.h
@@ -5,9 +5,11 @@
 
 /* Values for DPI configuration in MMSYS address space */
 #define MT8186_MMSYS_DPI_OUTPUT_FORMAT		0x400
-#define DPI_FORMAT_MASK					0x1
-#define DPI_RGB888_DDR_CON				BIT(0)
-#define DPI_RGB565_SDR_CON				BIT(1)
+#define DPI_FORMAT_MASK					GENMASK(1, 0)
+#define DPI_RGB888_SDR_CON				0
+#define DPI_RGB888_DDR_CON				1
+#define DPI_RGB565_SDR_CON				2
+#define DPI_RGB565_DDR_CON				3
 
 #define MT8186_MMSYS_OVL_CON			0xF04
 #define MT8186_MMSYS_OVL0_CON_MASK			0x3
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 2e20b24da363..95fbac5bd378 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -238,12 +238,27 @@ static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, u32 mask,
 
 void mtk_mmsys_ddp_dpi_fmt_config(struct device *dev, u32 val)
 {
-	if (val)
-		mtk_mmsys_update_bits(dev_get_drvdata(dev), MT8186_MMSYS_DPI_OUTPUT_FORMAT,
-				      DPI_RGB888_DDR_CON, DPI_FORMAT_MASK);
-	else
-		mtk_mmsys_update_bits(dev_get_drvdata(dev), MT8186_MMSYS_DPI_OUTPUT_FORMAT,
-				      DPI_RGB565_SDR_CON, DPI_FORMAT_MASK);
+	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
+
+	switch (val) {
+	case MTK_DPI_RGB888_SDR_CON:
+		mtk_mmsys_update_bits(mmsys, MT8186_MMSYS_DPI_OUTPUT_FORMAT,
+				      DPI_FORMAT_MASK, DPI_RGB888_SDR_CON);
+		break;
+	case MTK_DPI_RGB565_SDR_CON:
+		mtk_mmsys_update_bits(mmsys, MT8186_MMSYS_DPI_OUTPUT_FORMAT,
+				      DPI_FORMAT_MASK, DPI_RGB565_SDR_CON);
+		break;
+	case MTK_DPI_RGB565_DDR_CON:
+		mtk_mmsys_update_bits(mmsys, MT8186_MMSYS_DPI_OUTPUT_FORMAT,
+				      DPI_FORMAT_MASK, DPI_RGB565_DDR_CON);
+		break;
+	case MTK_DPI_RGB888_DDR_CON:
+	default:
+		mtk_mmsys_update_bits(mmsys, MT8186_MMSYS_DPI_OUTPUT_FORMAT,
+				      DPI_FORMAT_MASK, DPI_RGB888_DDR_CON);
+		break;
+	}
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_dpi_fmt_config);
 
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index d2b02bb43768..b85f66db33e1 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -9,6 +9,13 @@
 enum mtk_ddp_comp_id;
 struct device;
 
+enum mtk_dpi_out_format_con {
+	MTK_DPI_RGB888_SDR_CON,
+	MTK_DPI_RGB888_DDR_CON,
+	MTK_DPI_RGB565_SDR_CON,
+	MTK_DPI_RGB565_DDR_CON
+};
+
 enum mtk_ddp_comp_id {
 	DDP_COMPONENT_AAL0,
 	DDP_COMPONENT_AAL1,
-- 
2.18.0

