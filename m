Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABD35BE14E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiITJDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiITJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:02:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D776BD44
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:01:52 -0700 (PDT)
X-UUID: e5030f545a5b439d8e1e2008fdb8e2dc-20220920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kSOs6zUQirLBN1JAYVn/+CkOGaCnw6v6r+kmkvDzR+Q=;
        b=tHd9H4kQ7iz3Pr/RkYo96LIXjqHoejmgwoMetCXbFTOhWYV6YSzuUnot4SN/5G1/F/KkNUrpEJ0iWiWkeTSdmkWhuMQPyReRhviyAs7KzAxqWOd56POtiW7vPmSlg66NcKnucDJXbOlRSLQvM7y7PZTMY5MXXiDIZuxD+DmdgJ0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:cfb8e756-c894-47d3-ac8d-f13446ce1a2e,IP:0,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:39a5ff1,CLOUDID:9cf103f7-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:5,IP:nil,UR
        L:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e5030f545a5b439d8e1e2008fdb8e2dc-20220920
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1792459238; Tue, 20 Sep 2022 17:01:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 20 Sep 2022 17:00:42 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Sep 2022 17:00:42 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH 03/18] phy: mediatek: xsphy: remove macros used to prepare bitfield value
Date:   Tue, 20 Sep 2022 17:00:23 +0800
Message-ID: <20220920090038.15133-4-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920090038.15133-1-chunfeng.yun@mediatek.com>
References: <20220920090038.15133-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Prefer to make use of FIELD_PREP() macro to prepare bitfield value,
then no need local ones anymore.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-xsphy.c | 46 ++++++++++------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-xsphy.c b/drivers/phy/mediatek/phy-mtk-xsphy.c
index c0cdb78f77fa..b222fbbd71d1 100644
--- a/drivers/phy/mediatek/phy-mtk-xsphy.c
+++ b/drivers/phy/mediatek/phy-mtk-xsphy.c
@@ -37,7 +37,6 @@
 #define XSP_U2FREQ_FMCR0	((SSUSB_SIFSLV_U2FREQ) + 0x00)
 #define P2F_RG_FREQDET_EN	BIT(24)
 #define P2F_RG_CYCLECNT		GENMASK(23, 0)
-#define P2F_RG_CYCLECNT_VAL(x)	((P2F_RG_CYCLECNT) & (x))
 
 #define XSP_U2FREQ_MMONR0  ((SSUSB_SIFSLV_U2FREQ) + 0x0c)
 
@@ -50,16 +49,12 @@
 
 #define XSP_USBPHYACR1		((SSUSB_SIFSLV_U2PHY_COM) + 0x04)
 #define P2A1_RG_INTR_CAL		GENMASK(23, 19)
-#define P2A1_RG_INTR_CAL_VAL(x)	((0x1f & (x)) << 19)
 #define P2A1_RG_VRT_SEL			GENMASK(14, 12)
-#define P2A1_RG_VRT_SEL_VAL(x)	((0x7 & (x)) << 12)
 #define P2A1_RG_TERM_SEL		GENMASK(10, 8)
-#define P2A1_RG_TERM_SEL_VAL(x)	((0x7 & (x)) << 8)
 
 #define XSP_USBPHYACR5		((SSUSB_SIFSLV_U2PHY_COM) + 0x014)
 #define P2A5_RG_HSTX_SRCAL_EN	BIT(15)
 #define P2A5_RG_HSTX_SRCTRL		GENMASK(14, 12)
-#define P2A5_RG_HSTX_SRCTRL_VAL(x)	((0x7 & (x)) << 12)
 
 #define XSP_USBPHYACR6		((SSUSB_SIFSLV_U2PHY_COM) + 0x018)
 #define P2A6_RG_BC11_SW_EN	BIT(23)
@@ -74,15 +69,12 @@
 
 #define SSPXTP_PHYA_GLB_00		((SSPXTP_SIFSLV_PHYA_GLB) + 0x00)
 #define RG_XTP_GLB_BIAS_INTR_CTRL		GENMASK(21, 16)
-#define RG_XTP_GLB_BIAS_INTR_CTRL_VAL(x)	((0x3f & (x)) << 16)
 
 #define SSPXTP_PHYA_LN_04	((SSPXTP_SIFSLV_PHYA_LN) + 0x04)
 #define RG_XTP_LN0_TX_IMPSEL		GENMASK(4, 0)
-#define RG_XTP_LN0_TX_IMPSEL_VAL(x)	(0x1f & (x))
 
 #define SSPXTP_PHYA_LN_14	((SSPXTP_SIFSLV_PHYA_LN) + 0x014)
 #define RG_XTP_LN0_RX_IMPSEL		GENMASK(4, 0)
-#define RG_XTP_LN0_RX_IMPSEL_VAL(x)	(0x1f & (x))
 
 #define XSP_REF_CLK		26	/* MHZ */
 #define XSP_SLEW_RATE_COEF	17
@@ -134,8 +126,8 @@ static void u2_phy_slew_rate_calibrate(struct mtk_xsphy *xsphy,
 	mtk_phy_set_bits(pbase + XSP_U2FREQ_FMMONR1, P2F_RG_FRCK_EN);
 
 	/* set cycle count as 1024 */
-	mtk_phy_update_bits(pbase + XSP_U2FREQ_FMCR0, P2F_RG_CYCLECNT,
-			    P2F_RG_CYCLECNT_VAL(XSP_FM_DET_CYCLE_CNT));
+	mtk_phy_update_field(pbase + XSP_U2FREQ_FMCR0, P2F_RG_CYCLECNT,
+			     XSP_FM_DET_CYCLE_CNT);
 
 	/* enable frequency meter */
 	mtk_phy_set_bits(pbase + XSP_U2FREQ_FMCR0, P2F_RG_FREQDET_EN);
@@ -166,8 +158,7 @@ static void u2_phy_slew_rate_calibrate(struct mtk_xsphy *xsphy,
 		xsphy->src_ref_clk, xsphy->src_coef);
 
 	/* set HS slew rate */
-	mtk_phy_update_bits(pbase + XSP_USBPHYACR5, P2A5_RG_HSTX_SRCTRL,
-			    P2A5_RG_HSTX_SRCTRL_VAL(calib_val));
+	mtk_phy_update_field(pbase + XSP_USBPHYACR5, P2A5_RG_HSTX_SRCTRL, calib_val);
 
 	/* disable USB ring oscillator */
 	mtk_phy_clear_bits(pbase + XSP_USBPHYACR5, P2A5_RG_HSTX_SRCAL_EN);
@@ -280,20 +271,20 @@ static void u2_phy_props_set(struct mtk_xsphy *xsphy,
 	void __iomem *pbase = inst->port_base;
 
 	if (inst->efuse_intr)
-		mtk_phy_update_bits(pbase + XSP_USBPHYACR1, P2A1_RG_INTR_CAL,
-				    P2A1_RG_INTR_CAL_VAL(inst->efuse_intr));
+		mtk_phy_update_field(pbase + XSP_USBPHYACR1, P2A1_RG_INTR_CAL,
+				     inst->efuse_intr);
 
 	if (inst->eye_src)
-		mtk_phy_update_bits(pbase + XSP_USBPHYACR5, P2A5_RG_HSTX_SRCTRL,
-				    P2A5_RG_HSTX_SRCTRL_VAL(inst->eye_src));
+		mtk_phy_update_field(pbase + XSP_USBPHYACR5, P2A5_RG_HSTX_SRCTRL,
+				     inst->eye_src);
 
 	if (inst->eye_vrt)
-		mtk_phy_update_bits(pbase + XSP_USBPHYACR1, P2A1_RG_VRT_SEL,
-				    P2A1_RG_VRT_SEL_VAL(inst->eye_vrt));
+		mtk_phy_update_field(pbase + XSP_USBPHYACR1, P2A1_RG_VRT_SEL,
+				     inst->eye_vrt);
 
 	if (inst->eye_term)
-		mtk_phy_update_bits(pbase + XSP_USBPHYACR1, P2A1_RG_TERM_SEL,
-				    P2A1_RG_TERM_SEL_VAL(inst->eye_term));
+		mtk_phy_update_field(pbase + XSP_USBPHYACR1, P2A1_RG_TERM_SEL,
+				     inst->eye_term);
 }
 
 static void u3_phy_props_set(struct mtk_xsphy *xsphy,
@@ -302,19 +293,16 @@ static void u3_phy_props_set(struct mtk_xsphy *xsphy,
 	void __iomem *pbase = inst->port_base;
 
 	if (inst->efuse_intr)
-		mtk_phy_update_bits(xsphy->glb_base + SSPXTP_PHYA_GLB_00,
-				    RG_XTP_GLB_BIAS_INTR_CTRL,
-				    RG_XTP_GLB_BIAS_INTR_CTRL_VAL(inst->efuse_intr));
+		mtk_phy_update_field(xsphy->glb_base + SSPXTP_PHYA_GLB_00,
+				     RG_XTP_GLB_BIAS_INTR_CTRL, inst->efuse_intr);
 
 	if (inst->efuse_tx_imp)
-		mtk_phy_update_bits(pbase + SSPXTP_PHYA_LN_04,
-				    RG_XTP_LN0_TX_IMPSEL,
-				    RG_XTP_LN0_TX_IMPSEL_VAL(inst->efuse_tx_imp));
+		mtk_phy_update_field(pbase + SSPXTP_PHYA_LN_04,
+				     RG_XTP_LN0_TX_IMPSEL, inst->efuse_tx_imp);
 
 	if (inst->efuse_rx_imp)
-		mtk_phy_update_bits(pbase + SSPXTP_PHYA_LN_14,
-				    RG_XTP_LN0_RX_IMPSEL,
-				    RG_XTP_LN0_RX_IMPSEL_VAL(inst->efuse_rx_imp));
+		mtk_phy_update_field(pbase + SSPXTP_PHYA_LN_14,
+				     RG_XTP_LN0_RX_IMPSEL, inst->efuse_rx_imp);
 }
 
 static int mtk_phy_init(struct phy *phy)
-- 
2.18.0

