Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF4C69CFF5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjBTPCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjBTPCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:02:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8292004E;
        Mon, 20 Feb 2023 07:01:41 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D9B2F660216A;
        Mon, 20 Feb 2023 15:01:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676905300;
        bh=XeiwdSMa5MSAJMakc/I4Gazz0YRe/PZo/27waOJdBVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W98NDvXY1WP8lI3VzOSUr06/wzu2UB3yTj3Mqlas+oaOoW2YK8/FhHfIgUrdtM2QF
         phR1AwPo1bylIFaW8wxO2oMSBH7Ld5fttede7Pn5fU7M22vcFAKj3yKHGHldpmmQqg
         qEkkpd22xQPTwtGfGijkaYoYF9cqzhJY2rr2Hm9KaEK2o3cfMwLlKLVXi41aF3VQD7
         1ED8asyBRkZO2NjCE4c3huLq1PnOEXvo8jZqgbL1DifbWX+uFUI1nI51N1GY0crehD
         yHyYPmhXSfOtW53eex2pxX6IoiXAGqPDJW9zAJTno7hbS+22nUNMS2XjYh6cswFIUZ
         7p2NCP8LjFBCg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 17/55] clk: mediatek: mt8167: Remove __initconst annotation from arrays
Date:   Mon, 20 Feb 2023 16:00:33 +0100
Message-Id: <20230220150111.77897-18-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for converting the MT8167 clock drivers to be proper
platform_driver(s), drop the __initconst annotation from all of the
clock arrays since they will be used not only during init but also
during runtime.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8167-aud.c    |   2 +-
 drivers/clk/mediatek/clk-mt8167-img.c    |   2 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c |   2 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c   |   2 +-
 drivers/clk/mediatek/clk-mt8167.c        | 100 +++++++++++------------
 5 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8167-aud.c b/drivers/clk/mediatek/clk-mt8167-aud.c
index f6bea6e9e6a4..2d890a440863 100644
--- a/drivers/clk/mediatek/clk-mt8167-aud.c
+++ b/drivers/clk/mediatek/clk-mt8167-aud.c
@@ -32,7 +32,7 @@ static const struct mtk_gate_regs aud_cg_regs = {
 		.ops = &mtk_clk_gate_ops_no_setclr,		\
 	}
 
-static const struct mtk_gate aud_clks[] __initconst = {
+static const struct mtk_gate aud_clks[] = {
 	GATE_AUD(CLK_AUD_AFE, "aud_afe", "clk26m_ck", 2),
 	GATE_AUD(CLK_AUD_I2S, "aud_i2s", "i2s_infra_bck", 6),
 	GATE_AUD(CLK_AUD_22M, "aud_22m", "rg_aud_engen1", 8),
diff --git a/drivers/clk/mediatek/clk-mt8167-img.c b/drivers/clk/mediatek/clk-mt8167-img.c
index 77db13b177fc..23950186ee02 100644
--- a/drivers/clk/mediatek/clk-mt8167-img.c
+++ b/drivers/clk/mediatek/clk-mt8167-img.c
@@ -32,7 +32,7 @@ static const struct mtk_gate_regs img_cg_regs = {
 		.ops = &mtk_clk_gate_ops_setclr,	\
 	}
 
-static const struct mtk_gate img_clks[] __initconst = {
+static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_LARB1_SMI, "img_larb1_smi", "smi_mm", 0),
 	GATE_IMG(CLK_IMG_CAM_SMI, "img_cam_smi", "smi_mm", 5),
 	GATE_IMG(CLK_IMG_CAM_CAM, "img_cam_cam", "smi_mm", 6),
diff --git a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
index 3c23591b02f7..40b2d45f3fe3 100644
--- a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
@@ -32,7 +32,7 @@ static const struct mtk_gate_regs mfg_cg_regs = {
 		.ops = &mtk_clk_gate_ops_setclr,	\
 	}
 
-static const struct mtk_gate mfg_clks[] __initconst = {
+static const struct mtk_gate mfg_clks[] = {
 	GATE_MFG(CLK_MFG_BAXI, "mfg_baxi", "ahb_infra_sel", 0),
 	GATE_MFG(CLK_MFG_BMEM, "mfg_bmem", "gfmux_emi1x_sel", 1),
 	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_mm", 2),
diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
index 759e5791599f..905529789a7c 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -47,7 +47,7 @@ static const struct mtk_gate_regs vdec1_cg_regs = {
 		.ops = &mtk_clk_gate_ops_setclr_inv,	\
 	}
 
-static const struct mtk_gate vdec_clks[] __initconst = {
+static const struct mtk_gate vdec_clks[] = {
 	/* VDEC0 */
 	GATE_VDEC0_I(CLK_VDEC_CKEN, "vdec_cken", "rg_vdec", 0),
 	/* VDEC1 */
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index a4ffdac6d94d..f604add9b546 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -19,7 +19,7 @@
 
 static DEFINE_SPINLOCK(mt8167_clk_lock);
 
-static const struct mtk_fixed_clk fixed_clks[] __initconst = {
+static const struct mtk_fixed_clk fixed_clks[] = {
 	FIXED_CLK(CLK_TOP_CLK_NULL, "clk_null", NULL, 0),
 	FIXED_CLK(CLK_TOP_I2S_INFRA_BCK, "i2s_infra_bck", "clk_null", 26000000),
 	FIXED_CLK(CLK_TOP_MEMPLL, "mempll", "clk26m", 800000000),
@@ -28,7 +28,7 @@ static const struct mtk_fixed_clk fixed_clks[] __initconst = {
 	FIXED_CLK(CLK_TOP_LVDSTX_CLKDIG_CTS, "lvdstx_dig_cts", "clk26m", 52500000),
 };
 
-static const struct mtk_fixed_factor top_divs[] __initconst = {
+static const struct mtk_fixed_factor top_divs[] = {
 	FACTOR(CLK_TOP_DMPLL, "dmpll_ck", "mempll", 1, 1),
 	FACTOR(CLK_TOP_MAINPLL_D2, "mainpll_d2", "mainpll", 1, 2),
 	FACTOR(CLK_TOP_MAINPLL_D4, "mainpll_d4", "mainpll", 1, 4),
@@ -84,22 +84,22 @@ static const struct mtk_fixed_factor top_divs[] __initconst = {
 	FACTOR(CLK_TOP_ETH_D2, "eth_d2_ck", "eth_sel", 1, 2),
 };
 
-static const char * const uart0_parents[] __initconst = {
+static const char * const uart0_parents[] = {
 	"clk26m_ck",
 	"univpll_d24"
 };
 
-static const char * const gfmux_emi1x_parents[] __initconst = {
+static const char * const gfmux_emi1x_parents[] = {
 	"clk26m_ck",
 	"dmpll_ck"
 };
 
-static const char * const emi_ddrphy_parents[] __initconst = {
+static const char * const emi_ddrphy_parents[] = {
 	"gfmux_emi1x_sel",
 	"gfmux_emi1x_sel"
 };
 
-static const char * const ahb_infra_parents[] __initconst = {
+static const char * const ahb_infra_parents[] = {
 	"clk_null",
 	"clk26m_ck",
 	"mainpll_d11",
@@ -115,7 +115,7 @@ static const char * const ahb_infra_parents[] __initconst = {
 	"mainpll_d10"
 };
 
-static const char * const csw_mux_mfg_parents[] __initconst = {
+static const char * const csw_mux_mfg_parents[] = {
 	"clk_null",
 	"clk_null",
 	"univpll_d3",
@@ -126,7 +126,7 @@ static const char * const csw_mux_mfg_parents[] __initconst = {
 	"mmpll380m"
 };
 
-static const char * const msdc0_parents[] __initconst = {
+static const char * const msdc0_parents[] = {
 	"clk26m_ck",
 	"univpll_d6",
 	"mainpll_d8",
@@ -137,7 +137,7 @@ static const char * const msdc0_parents[] __initconst = {
 	"mmpll_d2"
 };
 
-static const char * const camtg_mm_parents[] __initconst = {
+static const char * const camtg_mm_parents[] = {
 	"clk_null",
 	"clk26m_ck",
 	"usb_phy48m_ck",
@@ -145,17 +145,17 @@ static const char * const camtg_mm_parents[] __initconst = {
 	"univpll_d6"
 };
 
-static const char * const pwm_mm_parents[] __initconst = {
+static const char * const pwm_mm_parents[] = {
 	"clk26m_ck",
 	"univpll_d12"
 };
 
-static const char * const uart1_parents[] __initconst = {
+static const char * const uart1_parents[] = {
 	"clk26m_ck",
 	"univpll_d24"
 };
 
-static const char * const msdc1_parents[] __initconst = {
+static const char * const msdc1_parents[] = {
 	"clk26m_ck",
 	"univpll_d6",
 	"mainpll_d8",
@@ -166,24 +166,24 @@ static const char * const msdc1_parents[] __initconst = {
 	"mmpll_d2"
 };
 
-static const char * const spm_52m_parents[] __initconst = {
+static const char * const spm_52m_parents[] = {
 	"clk26m_ck",
 	"univpll_d24"
 };
 
-static const char * const pmicspi_parents[] __initconst = {
+static const char * const pmicspi_parents[] = {
 	"univpll_d20",
 	"usb_phy48m_ck",
 	"univpll_d16",
 	"clk26m_ck"
 };
 
-static const char * const qaxi_aud26m_parents[] __initconst = {
+static const char * const qaxi_aud26m_parents[] = {
 	"clk26m_ck",
 	"ahb_infra_sel"
 };
 
-static const char * const aud_intbus_parents[] __initconst = {
+static const char * const aud_intbus_parents[] = {
 	"clk_null",
 	"clk26m_ck",
 	"mainpll_d22",
@@ -191,7 +191,7 @@ static const char * const aud_intbus_parents[] __initconst = {
 	"mainpll_d11"
 };
 
-static const char * const nfi2x_pad_parents[] __initconst = {
+static const char * const nfi2x_pad_parents[] = {
 	"clk_null",
 	"clk_null",
 	"clk_null",
@@ -279,12 +279,12 @@ static const char * const nfi2x_pad_parents[] __initconst = {
 	"mainpll_d5"
 };
 
-static const char * const nfi1x_pad_parents[] __initconst = {
+static const char * const nfi1x_pad_parents[] = {
 	"ahb_infra_sel",
 	"nfi1x_ck"
 };
 
-static const char * const mfg_mm_parents[] __initconst = {
+static const char * const mfg_mm_parents[] = {
 	"clk_null",
 	"clk_null",
 	"clk_null",
@@ -324,12 +324,12 @@ static const char * const mfg_mm_parents[] __initconst = {
 	"mainpll_d14"
 };
 
-static const char * const ddrphycfg_parents[] __initconst = {
+static const char * const ddrphycfg_parents[] = {
 	"clk26m_ck",
 	"mainpll_d16"
 };
 
-static const char * const smi_mm_parents[] __initconst = {
+static const char * const smi_mm_parents[] = {
 	"clk26m_ck",
 	"clk_null",
 	"clk_null",
@@ -345,7 +345,7 @@ static const char * const smi_mm_parents[] __initconst = {
 	"mainpll_d14"
 };
 
-static const char * const usb_78m_parents[] __initconst = {
+static const char * const usb_78m_parents[] = {
 	"clk_null",
 	"clk26m_ck",
 	"univpll_d16",
@@ -353,7 +353,7 @@ static const char * const usb_78m_parents[] __initconst = {
 	"mainpll_d20"
 };
 
-static const char * const scam_mm_parents[] __initconst = {
+static const char * const scam_mm_parents[] = {
 	"clk_null",
 	"clk26m_ck",
 	"mainpll_d14",
@@ -361,7 +361,7 @@ static const char * const scam_mm_parents[] __initconst = {
 	"mainpll_d12"
 };
 
-static const char * const spinor_parents[] __initconst = {
+static const char * const spinor_parents[] = {
 	"clk26m_d2",
 	"clk26m_ck",
 	"mainpll_d40",
@@ -372,7 +372,7 @@ static const char * const spinor_parents[] __initconst = {
 	"univpll_d12"
 };
 
-static const char * const msdc2_parents[] __initconst = {
+static const char * const msdc2_parents[] = {
 	"clk26m_ck",
 	"univpll_d6",
 	"mainpll_d8",
@@ -383,7 +383,7 @@ static const char * const msdc2_parents[] __initconst = {
 	"mmpll_d2"
 };
 
-static const char * const eth_parents[] __initconst = {
+static const char * const eth_parents[] = {
 	"clk26m_ck",
 	"mainpll_d40",
 	"univpll_d24",
@@ -391,7 +391,7 @@ static const char * const eth_parents[] __initconst = {
 	"mainpll_d20"
 };
 
-static const char * const vdec_mm_parents[] __initconst = {
+static const char * const vdec_mm_parents[] = {
 	"clk26m_ck",
 	"univpll_d4",
 	"mainpll_d4",
@@ -400,7 +400,7 @@ static const char * const vdec_mm_parents[] __initconst = {
 	"mainpll_d6"
 };
 
-static const char * const dpi0_mm_parents[] __initconst = {
+static const char * const dpi0_mm_parents[] = {
 	"clk26m_ck",
 	"lvdspll_ck",
 	"lvdspll_d2",
@@ -408,7 +408,7 @@ static const char * const dpi0_mm_parents[] __initconst = {
 	"lvdspll_d8"
 };
 
-static const char * const dpi1_mm_parents[] __initconst = {
+static const char * const dpi1_mm_parents[] = {
 	"clk26m_ck",
 	"tvdpll_d2",
 	"tvdpll_d4",
@@ -416,85 +416,85 @@ static const char * const dpi1_mm_parents[] __initconst = {
 	"tvdpll_d16"
 };
 
-static const char * const axi_mfg_in_parents[] __initconst = {
+static const char * const axi_mfg_in_parents[] = {
 	"clk26m_ck",
 	"mainpll_d11",
 	"univpll_d24",
 	"mmpll380m"
 };
 
-static const char * const slow_mfg_parents[] __initconst = {
+static const char * const slow_mfg_parents[] = {
 	"clk26m_ck",
 	"univpll_d12",
 	"univpll_d24"
 };
 
-static const char * const aud1_parents[] __initconst = {
+static const char * const aud1_parents[] = {
 	"clk26m_ck",
 	"apll1_ck"
 };
 
-static const char * const aud2_parents[] __initconst = {
+static const char * const aud2_parents[] = {
 	"clk26m_ck",
 	"apll2_ck"
 };
 
-static const char * const aud_engen1_parents[] __initconst = {
+static const char * const aud_engen1_parents[] = {
 	"clk26m_ck",
 	"rg_apll1_d2_en",
 	"rg_apll1_d4_en",
 	"rg_apll1_d8_en"
 };
 
-static const char * const aud_engen2_parents[] __initconst = {
+static const char * const aud_engen2_parents[] = {
 	"clk26m_ck",
 	"rg_apll2_d2_en",
 	"rg_apll2_d4_en",
 	"rg_apll2_d8_en"
 };
 
-static const char * const i2c_parents[] __initconst = {
+static const char * const i2c_parents[] = {
 	"clk26m_ck",
 	"univpll_d20",
 	"univpll_d16",
 	"univpll_d12"
 };
 
-static const char * const aud_i2s0_m_parents[] __initconst = {
+static const char * const aud_i2s0_m_parents[] = {
 	"rg_aud1",
 	"rg_aud2"
 };
 
-static const char * const pwm_parents[] __initconst = {
+static const char * const pwm_parents[] = {
 	"clk26m_ck",
 	"univpll_d12"
 };
 
-static const char * const spi_parents[] __initconst = {
+static const char * const spi_parents[] = {
 	"clk26m_ck",
 	"univpll_d12",
 	"univpll_d8",
 	"univpll_d6"
 };
 
-static const char * const aud_spdifin_parents[] __initconst = {
+static const char * const aud_spdifin_parents[] = {
 	"clk26m_ck",
 	"univpll_d2"
 };
 
-static const char * const uart2_parents[] __initconst = {
+static const char * const uart2_parents[] = {
 	"clk26m_ck",
 	"univpll_d24"
 };
 
-static const char * const bsi_parents[] __initconst = {
+static const char * const bsi_parents[] = {
 	"clk26m_ck",
 	"mainpll_d10",
 	"mainpll_d12",
 	"mainpll_d20"
 };
 
-static const char * const dbg_atclk_parents[] __initconst = {
+static const char * const dbg_atclk_parents[] = {
 	"clk_null",
 	"clk26m_ck",
 	"mainpll_d5",
@@ -502,7 +502,7 @@ static const char * const dbg_atclk_parents[] __initconst = {
 	"univpll_d5"
 };
 
-static const char * const csw_nfiecc_parents[] __initconst = {
+static const char * const csw_nfiecc_parents[] = {
 	"clk_null",
 	"mainpll_d7",
 	"mainpll_d6",
@@ -510,7 +510,7 @@ static const char * const csw_nfiecc_parents[] __initconst = {
 	"mainpll_d5"
 };
 
-static const char * const nfiecc_parents[] __initconst = {
+static const char * const nfiecc_parents[] = {
 	"clk_null",
 	"nfi2x_pad_sel",
 	"mainpll_d4",
@@ -624,24 +624,24 @@ static struct mtk_composite top_muxes[] __initdata = {
 		0x07c, 13, 3),
 };
 
-static const char * const ifr_mux1_parents[] __initconst = {
+static const char * const ifr_mux1_parents[] = {
 	"clk26m_ck",
 	"armpll",
 	"univpll",
 	"mainpll_d2"
 };
 
-static const char * const ifr_eth_25m_parents[] __initconst = {
+static const char * const ifr_eth_25m_parents[] = {
 	"eth_d2_ck",
 	"rg_eth"
 };
 
-static const char * const ifr_i2c0_parents[] __initconst = {
+static const char * const ifr_i2c0_parents[] = {
 	"ahb_infra_d2",
 	"rg_i2c"
 };
 
-static const struct mtk_composite ifr_muxes[] __initconst = {
+static const struct mtk_composite ifr_muxes[] = {
 	MUX(CLK_IFR_MUX1_SEL, "ifr_mux1_sel", ifr_mux1_parents, 0x000,
 		2, 2),
 	MUX(CLK_IFR_ETH_25M_SEL, "ifr_eth_25m_sel", ifr_eth_25m_parents, 0x080,
@@ -744,7 +744,7 @@ static const struct mtk_gate_regs top5_cg_regs = {
 #define GATE_TOP5(_id, _name, _parent, _shift) \
 	GATE_MTK(_id, _name, _parent, &top5_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
-static const struct mtk_gate top_clks[] __initconst = {
+static const struct mtk_gate top_clks[] = {
 	/* TOP0 */
 	GATE_TOP0(CLK_TOP_PWM_MM, "pwm_mm", "pwm_mm_sel", 0),
 	GATE_TOP0(CLK_TOP_CAM_MM, "cam_mm", "camtg_mm_sel", 1),
-- 
2.39.1

