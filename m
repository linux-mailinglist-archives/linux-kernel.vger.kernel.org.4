Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E95372DA60
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbjFMHFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbjFMHFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:05:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CF91995;
        Tue, 13 Jun 2023 00:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686639939; x=1718175939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/CEVsHh3cXtXVIDLUkkyiXlWx5YACPw7oC/4tgbf35c=;
  b=tL0abFG6utt+46YnADkmRLMD5dLJCLP8ToAc31E9Mv0bStwY2SlllypM
   ZUw13KgGB9kpYUhByws1krr8I938gx20lc+LryXRlE9x6UIqxmo+MZPRZ
   UIQFhRRb81lVGMDQsblXdXyuSvPqOZEtl4F+pRAnRCmObH/L2Xfx4SoqN
   asBbasAB2M9BJeOyHuECbfMnER5YfaPgAXLubCf8Vxpy22/MN2DBkgVZl
   6nZhzKxn7Y4ZeFgTSmzT/BSOL6MI9CLmtNtasMTLLmmKFRAhOeCvnHvrE
   PRWWrVdow4CHSWiSscJPeJO6gITDGKQHHcIF8H+tJFrPveSaHtAgfWMHj
   w==;
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="217553976"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2023 00:05:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 13 Jun 2023 00:05:38 -0700
Received: from che-lt-i67131.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 13 Jun 2023 00:05:29 -0700
From:   Manikandan Muralidharan <manikandan.m@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <sam@ravnborg.org>,
        <bbrezillon@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Balakrishnan.S@microchip.com>,
        Manikandan <manikandan.m@microchip.com>,
        Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH 4/9] drm: atmel-hlcdc: Define SAM9X7 XLCDC specific registers
Date:   Tue, 13 Jun 2023 12:34:21 +0530
Message-ID: <20230613070426.467389-5-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613070426.467389-1-manikandan.m@microchip.com>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Durai Manickam KR <durai.manickamkr@microchip.com>

The register address of the XLCDC IP used in SAM9X7 are different from
the previous HLCDC.Defining those address space with valid macros.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
[manikandan.m@microchip.com: Remove unused macro definitions]
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h | 108 +++++++++++++++++++
 include/linux/mfd/atmel-hlcdc.h              |  10 ++
 2 files changed, 118 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 5b5c774e0edf..aed1742b3665 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -15,6 +15,7 @@
 
 #include <drm/drm_plane.h>
 
+/* LCD controller common registers */
 #define ATMEL_HLCDC_LAYER_CHER			0x0
 #define ATMEL_HLCDC_LAYER_CHDR			0x4
 #define ATMEL_HLCDC_LAYER_CHSR			0x8
@@ -128,6 +129,113 @@
 
 #define ATMEL_HLCDC_MAX_LAYERS			6
 
+/* XLCDC controller specific registers */
+#define ATMEL_XLCDC_LAYER_ENR			0x10
+#define ATMEL_XLCDC_LAYER_EN			BIT(0)
+
+#define ATMEL_XLCDC_LAYER_IER			0x0
+#define ATMEL_XLCDC_LAYER_IDR			0x4
+#define ATMEL_XLCDC_LAYER_IMR			0x8
+#define ATMEL_XLCDC_LAYER_ISR			0xc
+#define ATMEL_XLCDC_LAYER_DONE_IRQ(p)		BIT(0 + (8 * (p)))
+#define ATMEL_XLCDC_LAYER_ERROR_IRQ(p)		BIT(1 + (8 * (p)))
+#define ATMEL_XLCDC_LAYER_OVR_IRQ(p)		BIT(2 + (8 * (p)))
+
+#define ATMEL_XLCDC_LAYER_PLANE_ADDR(p)		(((p) * 0x4) + 0x18)
+
+#define ATMEL_XLCDC_LAYER_DMA_CFG		0
+#define ATMEL_XLCDC_LAYER_DMA_BLEN_MASK		GENMASK(6, 4)
+#define ATMEL_XLCDC_LAYER_DMA_BLEN_SINGLE	(0 << 4)
+#define ATMEL_XLCDC_LAYER_DMA_BLEN_INCR32	(4 << 4)
+#define ATMEL_XLCDC_LAYER_DMA_BLENCC_MASK	GENMASK(10, 8)
+#define ATMEL_XLCDC_LAYER_DMA_BLENCC_SINGLE	(0 << 8)
+#define ATMEL_XLCDC_LAYER_DMA_BLENCC_INCR4	(1 << 8)
+#define ATMEL_XLCDC_LAYER_DMA_BLENCC_INCR8	(2 << 8)
+#define ATMEL_XLCDC_LAYER_DMA_BLENCC_INCR16	(3 << 8)
+#define ATMEL_XLCDC_LAYER_DMA_BLENCC_INCR32	(4 << 8)
+
+#define ATMEL_XLCDC_GAM				BIT(2)
+
+#define ATMEL_XLCDC_LAYER_POS(x, y)		((x) | ((y) << 16))
+#define ATMEL_XLCDC_LAYER_SIZE(w, h)		(((w) - 1) | (((h) - 1) << 16))
+
+#define ATMEL_XLCDC_LAYER_DMA			BIT(0)
+#define ATMEL_XLCDC_LAYER_REP			BIT(1)
+#define ATMEL_XLCDC_LAYER_CRKEY			BIT(2)
+#define ATMEL_XLCDC_LAYER_DSTKEY		BIT(3)
+#define ATMEL_XLCDC_LAYER_DISCEN                BIT(4)
+#define ATMEL_XLCDC_LAYER_VIDPRI		BIT(5)
+#define ATMEL_XLCDC_LAYER_SFACTC_MASK		GENMASK(8, 6)
+#define ATMEL_XLCDC_LAYER_SFACTC_ONE		(0 << 6)
+#define ATMEL_XLCDC_LAYER_SFACTC_ZERO		(1 << 6)
+#define ATMEL_XLCDC_LAYER_SFACTC_A0		(2 << 6)
+#define ATMEL_XLCDC_LAYER_SFACTC_A0_MULT_AD	(3 << 6)
+#define ATMEL_XLCDC_LAYER_SFACTC_A0_MULT_AS	(4 << 6)
+#define ATMEL_XLCDC_LAYER_SFACTC_M_A0_MULT_AD	(5 << 6)
+#define ATMEL_XLCDC_LAYER_SFACTA_MASK		GENMASK(10, 9)
+#define ATMEL_XLCDC_LAYER_SFACTA_ZERO		(0 << 9)
+#define ATMEL_XLCDC_LAYER_SFACTA_ONE		(1 << 9)
+#define ATMEL_XLCDC_LAYER_SFACTA_A0		(2 << 9)
+#define ATMEL_XLCDC_LAYER_SFACTA_A1		(3 << 9)
+#define ATMEL_XLCDC_LAYER_DFACTC_MASK		GENMASK(13, 11)
+#define ATMEL_XLCDC_LAYER_DFACTC_ZERO		(0 << 11)
+#define ATMEL_XLCDC_LAYER_DFACTC_ONE		(1 << 11)
+#define ATMEL_XLCDC_LAYER_DFACTC_A0		(2 << 11)
+#define ATMEL_XLCDC_LAYER_DFACTC_A1		(3 << 11)
+#define ATMEL_XLCDC_LAYER_DFACTC_A0_MULT_AD	(4 << 11)
+#define ATMEL_XLCDC_LAYER_DFACTC_M_A0_MULT_AD	(5 << 11)
+#define ATMEL_XLCDC_LAYER_DFACTC_M_A0_MULT_AS	(6 << 11)
+#define ATMEL_XLCDC_LAYER_DFACTC_M_A0		(7 << 11)
+#define ATMEL_XLCDC_LAYER_DFACTA_MASK		GENMASK(15, 14)
+#define ATMEL_XLCDC_LAYER_DFACTA_ZERO		(0 << 14)
+#define ATMEL_XLCDC_LAYER_DFACTA_ONE		(1 << 14)
+#define ATMEL_XLCDC_LAYER_DFACTA_M_A0_MULT_AS	(2 << 14)
+#define ATMEL_XLCDC_LAYER_DFACTA_A1		(3 << 14)
+#define ATMEL_XLCDC_LAYER_A0_SHIFT		16
+#define ATMEL_XLCDC_LAYER_A0_MASK		\
+	GENMASK(23, ATMEL_XLCDC_LAYER_A0_SHIFT)
+#define ATMEL_XLCDC_LAYER_A0(x)			\
+	((x) << ATMEL_XLCDC_LAYER_A0_SHIFT)
+#define ATMEL_XLCDC_LAYER_A1_SHIFT		24
+#define ATMEL_XLCDC_LAYER_A1_MASK		\
+	GENMASK(31, ATMEL_XLCDC_LAYER_A1_SHIFT)
+#define ATMEL_XLCDC_LAYER_A1(x)			\
+	((x) << ATMEL_XLCDC_LAYER_A1_SHIFT)
+
+#define ATMEL_XLCDC_LAYER_DISC_POS(x, y)	((x) | ((y) << 16))
+#define ATMEL_XLCDC_LAYER_DISC_SIZE(w, h)	(((w) - 1) | (((h) - 1) << 16))
+
+#define ATMEL_XLCDC_LAYER_VSCALER_LUMA_ENABLE		BIT(0)
+#define ATMEL_XLCDC_LAYER_VSCALER_CHROMA_ENABLE		BIT(1)
+#define ATMEL_XLCDC_LAYER_HSCALER_LUMA_ENABLE		BIT(4)
+#define ATMEL_XLCDC_LAYER_HSCALER_CHROMA_ENABLE		BIT(5)
+
+#define ATMEL_XLCDC_LAYER_VXSYCFG_ZERO		(0 << 0)
+#define ATMEL_XLCDC_LAYER_VXSYCFG_ONE		(1 << 0)
+#define ATMEL_XLCDC_LAYER_VXSYCFG_TWO		(2 << 0)
+#define ATMEL_XLCDC_LAYER_VXSYCFG_THREE		(3 << 0)
+#define ATMEL_XLCDC_LAYER_VXSYTAP2_ENABLE	BIT(4)
+#define ATMEL_XLCDC_LAYER_VXSYBICU_ENABLE	BIT(5)
+#define ATMEL_XLCDC_LAYER_VXSCCFG_ZERO		(0 << 16)
+#define ATMEL_XLCDC_LAYER_VXSCCFG_ONE		(1 << 16)
+#define ATMEL_XLCDC_LAYER_VXSCCFG_TWO		(2 << 16)
+#define ATMEL_XLCDC_LAYER_VXSCCFG_THREE		(3 << 16)
+#define ATMEL_XLCDC_LAYER_VXSCTAP2_ENABLE	BIT(20)
+#define ATMEL_XLCDC_LAYER_VXSCBICU_ENABLE	BIT(21)
+
+#define ATMEL_XLCDC_LAYER_HXSYCFG_ZERO		(0 << 0)
+#define ATMEL_XLCDC_LAYER_HXSYCFG_ONE		(1 << 0)
+#define ATMEL_XLCDC_LAYER_HXSYCFG_TWO		(2 << 0)
+#define ATMEL_XLCDC_LAYER_HXSYCFG_THREE		(3 << 0)
+#define ATMEL_XLCDC_LAYER_HXSYTAP2_ENABLE	BIT(4)
+#define ATMEL_XLCDC_LAYER_HXSYBICU_ENABLE	BIT(5)
+#define ATMEL_XLCDC_LAYER_HXSCCFG_ZERO		(0 << 16)
+#define ATMEL_XLCDC_LAYER_HXSCCFG_ONE		(1 << 16)
+#define ATMEL_XLCDC_LAYER_HXSCCFG_TWO		(2 << 16)
+#define ATMEL_XLCDC_LAYER_HXSCCFG_THREE		(3 << 16)
+#define ATMEL_XLCDC_LAYER_HXSCTAP2_ENABLE	BIT(20)
+#define ATMEL_XLCDC_LAYER_HXSCBICU_ENABLE	BIT(21)
+
 /**
  * Atmel HLCDC Layer registers layout structure
  *
diff --git a/include/linux/mfd/atmel-hlcdc.h b/include/linux/mfd/atmel-hlcdc.h
index a186119a49b5..80d675a03b39 100644
--- a/include/linux/mfd/atmel-hlcdc.h
+++ b/include/linux/mfd/atmel-hlcdc.h
@@ -22,6 +22,8 @@
 #define ATMEL_HLCDC_DITHER		BIT(6)
 #define ATMEL_HLCDC_DISPDLY		BIT(7)
 #define ATMEL_HLCDC_MODE_MASK		GENMASK(9, 8)
+#define ATMEL_XLCDC_MODE_MASK		GENMASK(10, 8)
+#define ATMEL_XLCDC_DPI			BIT(11)
 #define ATMEL_HLCDC_PP			BIT(10)
 #define ATMEL_HLCDC_VSPSU		BIT(12)
 #define ATMEL_HLCDC_VSPHO		BIT(13)
@@ -34,6 +36,12 @@
 #define ATMEL_HLCDC_IDR			0x30
 #define ATMEL_HLCDC_IMR			0x34
 #define ATMEL_HLCDC_ISR			0x38
+#define ATMEL_XLCDC_ATTRE		0x3c
+
+#define ATMEL_XLCDC_BASE_UPDATE		BIT(0)
+#define ATMEL_XLCDC_OVR1_UPDATE		BIT(1)
+#define ATMEL_XLCDC_OVR3_UPDATE		BIT(2)
+#define ATMEL_XLCDC_HEO_UPDATE		BIT(3)
 
 #define ATMEL_HLCDC_CLKPOL		BIT(0)
 #define ATMEL_HLCDC_CLKSEL		BIT(2)
@@ -48,6 +56,8 @@
 #define ATMEL_HLCDC_DISP		BIT(2)
 #define ATMEL_HLCDC_PWM			BIT(3)
 #define ATMEL_HLCDC_SIP			BIT(4)
+#define ATMEL_XLCDC_SD			BIT(5)
+#define ATMEL_XLCDC_CM			BIT(6)
 
 #define ATMEL_HLCDC_SOF			BIT(0)
 #define ATMEL_HLCDC_SYNCDIS		BIT(1)
-- 
2.25.1

