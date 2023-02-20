Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A70D69D043
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjBTPGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjBTPGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:06:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D184211F6;
        Mon, 20 Feb 2023 07:04:26 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 466F366021CF;
        Mon, 20 Feb 2023 15:02:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676905353;
        bh=x3v3ueWOU/hk/L+2Q5luAzeuPeuM010GE3F0ZFfFFVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mv9A/Ypm8oMn5cGlIzlxk2pQ3vQl8a5YX3ccuOzMB8J7GMT4vveUHDKNW6nU+ARhD
         ldBtEX/7H/VngcWNl7JslMrn0eW3RrOwmEXakaYo++Ry7fejlj6yYZ2aT/SBBnYA3b
         ehKOUTMpt8pmo8kLNO12heQ6Kov4LjWPL9cuV7ZPU749vlf20EEd+9MXlNCtgTDUbt
         e+29rQ58KauRWFcXtAiIkzyH24En+GXAp0sV+R2xBiuQS5/v4aBqWHgTOB8A7g6wZI
         aRqTQxumsclX8LpB/T9WHI6gr+MziEcjsFBI91t8xNcr52iQgACypZFOkyRWVOhUqi
         pHlSh5ITisuOA==
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
Subject: [PATCH v3 55/55] clk: mediatek: mt8135: Remove __initconst annotation from clock arrays
Date:   Mon, 20 Feb 2023 16:01:11 +0100
Message-Id: <20230220150111.77897-56-angelogioacchino.delregno@collabora.com>
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

Being this a platform driver, these arrays are not only used during
init anymore, but also during runtime: remove the __initconst annotation
from all of them.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8135.c | 66 +++++++++++++++----------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 39fd919900e5..084e48a554c2 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -19,7 +19,7 @@
 
 static DEFINE_SPINLOCK(mt8135_clk_lock);
 
-static const struct mtk_fixed_factor top_divs[] __initconst = {
+static const struct mtk_fixed_factor top_divs[] = {
 	FACTOR(CLK_DUMMY, "top_divs_dummy", "clk_null", 1, 1),
 	FACTOR(CLK_TOP_DSI0_LNTC_DSICLK, "dsi0_lntc_dsiclk", "clk_null", 1, 1),
 	FACTOR(CLK_TOP_HDMITX_CLKDIG_CTS, "hdmitx_clkdig_cts", "clk_null", 1, 1),
@@ -101,7 +101,7 @@ static const struct mtk_fixed_factor top_divs[] __initconst = {
 	FACTOR(CLK_TOP_MEMPLL_MCK_D4, "mempll_mck_d4", "clkph_mck", 1, 4),
 };
 
-static const char * const axi_parents[] __initconst = {
+static const char * const axi_parents[] = {
 	"clk26m",
 	"syspll_d3",
 	"syspll_d4",
@@ -111,7 +111,7 @@ static const char * const axi_parents[] __initconst = {
 	"syspll_d3p5"
 };
 
-static const char * const smi_parents[] __initconst = {
+static const char * const smi_parents[] = {
 	"clk26m",
 	"clkph_mck",
 	"syspll_d2p5",
@@ -129,7 +129,7 @@ static const char * const smi_parents[] __initconst = {
 	"lvdspll"
 };
 
-static const char * const mfg_parents[] __initconst = {
+static const char * const mfg_parents[] = {
 	"clk26m",
 	"univpll1_d4",
 	"syspll_d2",
@@ -145,13 +145,13 @@ static const char * const mfg_parents[] __initconst = {
 	"mmpll_d7"
 };
 
-static const char * const irda_parents[] __initconst = {
+static const char * const irda_parents[] = {
 	"clk26m",
 	"univpll2_d8",
 	"univpll1_d6"
 };
 
-static const char * const cam_parents[] __initconst = {
+static const char * const cam_parents[] = {
 	"clk26m",
 	"syspll_d3",
 	"syspll_d3p5",
@@ -162,13 +162,13 @@ static const char * const cam_parents[] __initconst = {
 	"univpll1_d4"
 };
 
-static const char * const aud_intbus_parents[] __initconst = {
+static const char * const aud_intbus_parents[] = {
 	"clk26m",
 	"syspll_d6",
 	"univpll_d10"
 };
 
-static const char * const jpg_parents[] __initconst = {
+static const char * const jpg_parents[] = {
 	"clk26m",
 	"syspll_d5",
 	"syspll_d4",
@@ -178,7 +178,7 @@ static const char * const jpg_parents[] __initconst = {
 	"univpll_d5"
 };
 
-static const char * const disp_parents[] __initconst = {
+static const char * const disp_parents[] = {
 	"clk26m",
 	"syspll_d3p5",
 	"syspll_d3",
@@ -189,7 +189,7 @@ static const char * const disp_parents[] __initconst = {
 	"vdecpll"
 };
 
-static const char * const msdc30_parents[] __initconst = {
+static const char * const msdc30_parents[] = {
 	"clk26m",
 	"syspll_d6",
 	"syspll_d5",
@@ -198,13 +198,13 @@ static const char * const msdc30_parents[] __initconst = {
 	"msdcpll"
 };
 
-static const char * const usb20_parents[] __initconst = {
+static const char * const usb20_parents[] = {
 	"clk26m",
 	"univpll2_d6",
 	"univpll1_d10"
 };
 
-static const char * const venc_parents[] __initconst = {
+static const char * const venc_parents[] = {
 	"clk26m",
 	"syspll_d3",
 	"syspll_d8",
@@ -215,7 +215,7 @@ static const char * const venc_parents[] __initconst = {
 	"mmpll_d6"
 };
 
-static const char * const spi_parents[] __initconst = {
+static const char * const spi_parents[] = {
 	"clk26m",
 	"syspll_d6",
 	"syspll_d8",
@@ -224,17 +224,17 @@ static const char * const spi_parents[] __initconst = {
 	"univpll1_d8"
 };
 
-static const char * const uart_parents[] __initconst = {
+static const char * const uart_parents[] = {
 	"clk26m",
 	"univpll2_d8"
 };
 
-static const char * const mem_parents[] __initconst = {
+static const char * const mem_parents[] = {
 	"clk26m",
 	"clkph_mck"
 };
 
-static const char * const camtg_parents[] __initconst = {
+static const char * const camtg_parents[] = {
 	"clk26m",
 	"univpll_d26",
 	"univpll1_d6",
@@ -242,12 +242,12 @@ static const char * const camtg_parents[] __initconst = {
 	"syspll_d8"
 };
 
-static const char * const audio_parents[] __initconst = {
+static const char * const audio_parents[] = {
 	"clk26m",
 	"syspll_d24"
 };
 
-static const char * const fix_parents[] __initconst = {
+static const char * const fix_parents[] = {
 	"rtc32k",
 	"clk26m",
 	"univpll_d5",
@@ -258,7 +258,7 @@ static const char * const fix_parents[] __initconst = {
 	"univpll1_d8"
 };
 
-static const char * const vdec_parents[] __initconst = {
+static const char * const vdec_parents[] = {
 	"clk26m",
 	"vdecpll",
 	"clkph_mck",
@@ -277,13 +277,13 @@ static const char * const vdec_parents[] __initconst = {
 	"lvdspll"
 };
 
-static const char * const ddrphycfg_parents[] __initconst = {
+static const char * const ddrphycfg_parents[] = {
 	"clk26m",
 	"axi_sel",
 	"syspll_d12"
 };
 
-static const char * const dpilvds_parents[] __initconst = {
+static const char * const dpilvds_parents[] = {
 	"clk26m",
 	"lvdspll",
 	"lvdspll_d2",
@@ -291,7 +291,7 @@ static const char * const dpilvds_parents[] __initconst = {
 	"lvdspll_d8"
 };
 
-static const char * const pmicspi_parents[] __initconst = {
+static const char * const pmicspi_parents[] = {
 	"clk26m",
 	"univpll2_d6",
 	"syspll_d8",
@@ -302,14 +302,14 @@ static const char * const pmicspi_parents[] __initconst = {
 	"syspll_d24"
 };
 
-static const char * const smi_mfg_as_parents[] __initconst = {
+static const char * const smi_mfg_as_parents[] = {
 	"clk26m",
 	"smi_sel",
 	"mfg_sel",
 	"mem_sel"
 };
 
-static const char * const gcpu_parents[] __initconst = {
+static const char * const gcpu_parents[] = {
 	"clk26m",
 	"syspll_d4",
 	"univpll_d7",
@@ -317,14 +317,14 @@ static const char * const gcpu_parents[] __initconst = {
 	"syspll_d6"
 };
 
-static const char * const dpi1_parents[] __initconst = {
+static const char * const dpi1_parents[] = {
 	"clk26m",
 	"tvhdmi_h_ck",
 	"tvhdmi_d2",
 	"tvhdmi_d4"
 };
 
-static const char * const cci_parents[] __initconst = {
+static const char * const cci_parents[] = {
 	"clk26m",
 	"mainpll_537p3m",
 	"univpll_d3",
@@ -333,7 +333,7 @@ static const char * const cci_parents[] __initconst = {
 	"syspll_d5"
 };
 
-static const char * const apll_parents[] __initconst = {
+static const char * const apll_parents[] = {
 	"clk26m",
 	"apll_ck",
 	"apll_d4",
@@ -342,14 +342,14 @@ static const char * const apll_parents[] __initconst = {
 	"apll_d24"
 };
 
-static const char * const hdmipll_parents[] __initconst = {
+static const char * const hdmipll_parents[] = {
 	"clk26m",
 	"hdmitx_clkdig_cts",
 	"hdmitx_clkdig_d2",
 	"hdmitx_clkdig_d3"
 };
 
-static const struct mtk_composite top_muxes[] __initconst = {
+static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
 	MUX_GATE(CLK_TOP_AXI_SEL, "axi_sel", axi_parents,
 		0x0140, 0, 3, INVALID_MUX_GATE_BIT),
@@ -409,7 +409,7 @@ static const struct mtk_gate_regs infra_cg_regs = {
 	GATE_MTK_FLAGS(_id, _name, _parent, &infra_cg_regs, _shift,	\
 		       &mtk_clk_gate_ops_setclr, CLK_IS_CRITICAL)
 
-static const struct mtk_gate infra_clks[] __initconst = {
+static const struct mtk_gate infra_clks[] = {
 	GATE_DUMMY(CLK_DUMMY, "infra_dummy"),
 	GATE_ICG(CLK_INFRA_PMIC_WRAP, "pmic_wrap_ck", "axi_sel", 23),
 	GATE_ICG(CLK_INFRA_PMICSPI, "pmicspi_ck", "pmicspi_sel", 22),
@@ -444,7 +444,7 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 #define GATE_PERI1(_id, _name, _parent, _shift)	\
 	GATE_MTK(_id, _name, _parent, &peri1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-static const struct mtk_gate peri_gates[] __initconst = {
+static const struct mtk_gate peri_gates[] = {
 	GATE_DUMMY(CLK_DUMMY, "peri_dummy"),
 	/* PERI0 */
 	GATE_PERI0(CLK_PERI_I2C5, "i2c5_ck", "axi_sel", 31),
@@ -491,12 +491,12 @@ static const struct mtk_gate peri_gates[] __initconst = {
 	GATE_PERI1(CLK_PERI_I2C6, "i2c6_ck", "axi_sel", 0),
 };
 
-static const char * const uart_ck_sel_parents[] __initconst = {
+static const char * const uart_ck_sel_parents[] = {
 	"clk26m",
 	"uart_sel",
 };
 
-static const struct mtk_composite peri_clks[] __initconst = {
+static const struct mtk_composite peri_clks[] = {
 	MUX(CLK_PERI_UART0_SEL, "uart0_ck_sel", uart_ck_sel_parents, 0x40c, 0, 1),
 	MUX(CLK_PERI_UART1_SEL, "uart1_ck_sel", uart_ck_sel_parents, 0x40c, 1, 1),
 	MUX(CLK_PERI_UART2_SEL, "uart2_ck_sel", uart_ck_sel_parents, 0x40c, 2, 1),
-- 
2.39.1

