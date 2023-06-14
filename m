Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779ED72F730
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243479AbjFNH7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243368AbjFNH7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:59:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF431FD7;
        Wed, 14 Jun 2023 00:59:25 -0700 (PDT)
X-UUID: 84b29b6c0a8511ee9cb5633481061a41-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hpLRJmYKhPB0QTpDN7lvpJRPpLMjx1ofzANUNwQ3SyY=;
        b=I9g5i/M/4UHoc9dnIEnMG7D5RzmmmYxz/PvDu0Sb3plf1qlNPs3omhDFGrTsbU7S0dZpafDKaXx0bgTgaASo1FilC8cUGUHqHTCMXc2r3K4u3ZsyL/UBK4JF7HuaqokYwTBoX/s2J488Lk9q89ZuV70nY6+cHbSpcT6vXEuhwZA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:c0ff2f91-27f6-4467-ad1e-b043853f856c,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.26,REQID:c0ff2f91-27f6-4467-ad1e-b043853f856c,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:cb9a4e1,CLOUDID:6109076f-2f20-4998-991c-3b78627e4938,B
        ulkID:230614153148HF8943RA,BulkQuantity:0,Recheck:0,SF:19|48|38|29|28|17,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC
X-UUID: 84b29b6c0a8511ee9cb5633481061a41-20230614
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1491743866; Wed, 14 Jun 2023 15:31:46 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 15:31:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 15:31:45 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>
Subject: [PATCH v2 11/15] soc: mediatek: Add MT8188 VDO0 reset bit map
Date:   Wed, 14 Jun 2023 15:31:21 +0800
Message-ID: <20230614073125.17958-12-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230614073125.17958-1-shawn.sung@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8188 VDO0 reset bit map.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/soc/mediatek/mt8188-mmsys.h | 26 ++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c    |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/soc/mediatek/mt8188-mmsys.h b/drivers/soc/mediatek/mt8188-mmsys.h
index 447afb72d95f..c3e3c5cfe931 100644
--- a/drivers/soc/mediatek/mt8188-mmsys.h
+++ b/drivers/soc/mediatek/mt8188-mmsys.h
@@ -3,6 +3,10 @@
 #ifndef __SOC_MEDIATEK_MT8188_MMSYS_H
 #define __SOC_MEDIATEK_MT8188_MMSYS_H

+#include <dt-bindings/reset/mt8188-resets.h>
+
+#define MT8188_VDO0_SW0_RST_B				0x190
+
 #define MT8188_VDO0_OVL_MOUT_EN				0xf14
 #define MT8188_MOUT_DISP_OVL0_TO_DISP_RDMA0		BIT(0)
 #define MT8188_MOUT_DISP_OVL0_TO_DISP_WDMA0		BIT(1)
@@ -118,6 +122,28 @@
 #define MT8188_MIXER_SOUT_SEL_IN_FROM_DISP_MIXER		0
 #define MT8188_VDO1_MIXER_VSYNC_LEN				0xd5c

+static const u8 mmsys_mt8188_vdo0_rst_tb[] = {
+	[MT8188_VDO0_RST_DISP_OVL0]	= 0,
+	[MT8188_VDO0_RST_FAKE_ENG0]	= 2,
+	[MT8188_VDO0_RST_DISP_CCORR0]	= 4,
+	[MT8188_VDO0_RST_DISP_MUTEX0]	= 6,
+	[MT8188_VDO0_RST_DISP_GAMMA0]	= 8,
+	[MT8188_VDO0_RST_DISP_DITHER0]	= 10,
+	[MT8188_VDO0_RST_DISP_WDMA0]	= 17,
+	[MT8188_VDO0_RST_DISP_RDMA0]	= 19,
+	[MT8188_VDO0_RST_DSI0]		= 21,
+	[MT8188_VDO0_RST_DSI1]		= 22,
+	[MT8188_VDO0_RST_DSC_WRAP0]	= 23,
+	[MT8188_VDO0_RST_VPP_MERGE0]	= 24,
+	[MT8188_VDO0_RST_DP_INTF0]	= 25,
+	[MT8188_VDO0_RST_DISP_AAL0]	= 26,
+	[MT8188_VDO0_RST_INLINEROT0]	= 27,
+	[MT8188_VDO0_RST_APB_BUS]	= 28,
+	[MT8188_VDO0_RST_DISP_COLOR0]	= 29,
+	[MT8188_VDO0_RST_MDP_WROT0]	= 30,
+	[MT8188_VDO0_RST_DISP_RSZ0]	= 31,
+};
+
 static const struct mtk_mmsys_routes mmsys_mt8188_routing_table[] = {
 	{
 		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 13249658721f..88029500ed4d 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -87,6 +87,9 @@ static const struct mtk_mmsys_driver_data mt8188_vdosys0_driver_data = {
 	.clk_driver = "clk-mt8188-vdo0",
 	.routes = mmsys_mt8188_routing_table,
 	.num_routes = ARRAY_SIZE(mmsys_mt8188_routing_table),
+	.sw0_rst_offset = MT8188_VDO0_SW0_RST_B,
+	.rst_tb = mmsys_mt8188_vdo0_rst_tb,
+	.num_resets = ARRAY_SIZE(mmsys_mt8188_vdo0_rst_tb),
 };

 static const struct mtk_mmsys_driver_data mt8188_vdosys1_driver_data = {
--
2.18.0

