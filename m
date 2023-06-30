Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327D674406B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjF3Q6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjF3Q6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:58:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C98D3C1B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-313e09a5b19so1884363f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144317; x=1690736317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvu4fKAQ0tzSA1HLZHWmdOfD3AhGAjrR/Ll1y4HIr3g=;
        b=qr5+4nIwjldrvsGryhMYGLJ0OZ3YPZKjPv+OTuAp/4rNWzvkYiUv3O5yz/WzJXzRa6
         KQv/gt2z+CkoeUbaGX1zpGiZIZDi3/KNJDfW5geRr9w8FUrgkurUI4dljqHYFb2HLzRA
         bRkVvPlAnKyKccVD3felM+Q3xqIN+bmqcbjQ65eGbJQk+PyewF+8CU4wu2ZorlFWBrCT
         Aqy0rV7RN/Qph8ZMgN5kVUry9zzQtd08pvcu4b1ITLE+bPCVs/OEiCRLqW4Iy88vxE39
         ZbguzboHfYRuknRWQC8Wkmoy1NyAqglrkA9Xoe8FsTg5CQKTR6k99+zzk6ERh/USH1gy
         Ti/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144318; x=1690736318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvu4fKAQ0tzSA1HLZHWmdOfD3AhGAjrR/Ll1y4HIr3g=;
        b=bLNm1v2ar25uLmyCFLJdbqIGbV6EyOCJ+wdApp9PJ/mcFeiNzdVAm1s1VfmpmOHoQQ
         TqymzzTV0MxS0ARDN/r5cKwZi5Uc8m1QSYYhiYJ46MS3OMTvJvf7TAkHaotspuahMqsU
         J6ZuF8oPc6uZ7V6V8lLwrYVkV39k7qEbHn10n2U/ER0dzkrHWPQtFVNJ0Xhl1ROup9jP
         D3CTo+5uzqRIqDtDLpyJUPdrTVmpl4NTFm3GHfwql8SUqu++4E2dmdp4Xh5RL1z1A8Hn
         dr16J/JOeAmP6RddCFZ0h2QOA/bjoEDfWqTLRyVaYSIk+zxaSP4JVBEzcVxmRRTvkEgi
         8iFQ==
X-Gm-Message-State: AC+VfDwBlLRrZZ/rFsQQ24RwAfhZeviNe3ktkgQtN8rT/SfgvHgZbi05
        KRPhiIeY0/8vZPJ5VwDhhWzs4g==
X-Google-Smtp-Source: ACHHUZ5fJLXkeHDlekS99srv8CaNw+1WybS+1I3eAvpIdoFsONKseLREnwiIE5G4NEju+Wz8e4zHNQ==
X-Received: by 2002:a5d:4bc3:0:b0:314:99e:af46 with SMTP id l3-20020a5d4bc3000000b00314099eaf46mr8051304wrt.20.1688144317723;
        Fri, 30 Jun 2023 09:58:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm18913772wri.73.2023.06.30.09.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:58:37 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 30 Jun 2023 18:58:26 +0200
Subject: [PATCH v2 01/15] clk: oxnas: remove obsolete clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-1-fb6ab3dea87c@linaro.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-oxnas@groups.io,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9036;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1hf999g5eEtxLqg8V04tUPdGH+Hq91QPzTw+uaq9mYk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwm0FtQDp9YXTDLZeHYHxn9vyusAxAx2Z1sd8aTE
 pfEkqtCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JtAAKCRB33NvayMhJ0SWoEA
 C1ki9NvMY6YAJTD7BcigSaZFUnNaU3bNIzzoTSAIyg+6TKBlDoXVdGwTbafVx6QhUhwNO3NhCK5A6a
 oyCqgHPD4lFTu9ROCWJ2CL278zqVx1VmcSa+uOlpzKK4YYEaWm3vsa7+U5iVGZ8UAOkHyXdnzO8s8w
 1Dfqra3pX8U+bPlqDir97EjKWcfUDdAdzCU6sHYH2n3tQOnojyMSPnw0UwLguaknlzQjDPs029ARay
 XbH6olhY+PTxvnpFJw0Q5HqUuAv4X4Sq4cyUhfV2s/I9v+m0TAwMF+VVAVg1hmYOwWEhzkbiXYY1xg
 ehVEfeUKR3rsFfUMKYZsyfcHGfn9t+/OKBDm7Zr7tQ6x5e4WWB7R0DuWIdeMDAxJw7hkkP+i86lkor
 BKAR2oZiZpywLv+E9+kDhrys05V3s2hMWkjZcB54j5x75xihTEOkua+Wl3qE6PQIuvXbWzGychMmgA
 tBoNJApM2Rh8CFnosbeCabkduja6txGtKlOtxEoTmLmQIDe26HFznjp8yeBoqw9W5yUjj8W8GsTZZM
 EZ8nbLkV9nJjLOI47CzUJgQbQsZCHsILHByMA8g9mlLN9qs74x5fbf9RtEE9gwQqUTQbHb9eIKjXx7
 3fMabs0tQEqq4OPYpGl4GAhLKjcbpCbtNATt6UR9Mu0l878Fs4XmAloBcWDw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove support
for OX810 and OX820 clock driver.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/Kconfig     |   7 --
 drivers/clk/Makefile    |   1 -
 drivers/clk/clk-oxnas.c | 251 ------------------------------------------------
 3 files changed, 259 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 93f38a8178ba..59a101e1cf65 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -360,13 +360,6 @@ config COMMON_CLK_PXA
 	help
 	  Support for the Marvell PXA SoC.
 
-config COMMON_CLK_OXNAS
-	bool "Clock driver for the OXNAS SoC Family"
-	depends on ARCH_OXNAS || COMPILE_TEST
-	select MFD_SYSCON
-	help
-	  Support for the OXNAS SoC Family clocks.
-
 config COMMON_CLK_RS9_PCIE
 	tristate "Clock driver for Renesas 9-series PCIe clock generators"
 	depends on I2C
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 7cb000549b61..94155999eba3 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
 obj-$(CONFIG_ARCH_NPCM7XX)	    	+= clk-npcm7xx.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
-obj-$(CONFIG_COMMON_CLK_OXNAS)		+= clk-oxnas.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
 obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+= clk-plldig.o
 obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
diff --git a/drivers/clk/clk-oxnas.c b/drivers/clk/clk-oxnas.c
deleted file mode 100644
index 584e293156ad..000000000000
--- a/drivers/clk/clk-oxnas.c
+++ /dev/null
@@ -1,251 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2010 Broadcom
- * Copyright (C) 2012 Stephen Warren
- * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#include <linux/clk-provider.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/platform_device.h>
-#include <linux/stringify.h>
-#include <linux/regmap.h>
-#include <linux/mfd/syscon.h>
-
-#include <dt-bindings/clock/oxsemi,ox810se.h>
-#include <dt-bindings/clock/oxsemi,ox820.h>
-
-/* Standard regmap gate clocks */
-struct clk_oxnas_gate {
-	struct clk_hw hw;
-	unsigned int bit;
-	struct regmap *regmap;
-};
-
-struct oxnas_stdclk_data {
-	struct clk_hw_onecell_data *onecell_data;
-	struct clk_oxnas_gate **gates;
-	unsigned int ngates;
-	struct clk_oxnas_pll **plls;
-	unsigned int nplls;
-};
-
-/* Regmap offsets */
-#define CLK_STAT_REGOFFSET	0x24
-#define CLK_SET_REGOFFSET	0x2c
-#define CLK_CLR_REGOFFSET	0x30
-
-static inline struct clk_oxnas_gate *to_clk_oxnas_gate(struct clk_hw *hw)
-{
-	return container_of(hw, struct clk_oxnas_gate, hw);
-}
-
-static int oxnas_clk_gate_is_enabled(struct clk_hw *hw)
-{
-	struct clk_oxnas_gate *std = to_clk_oxnas_gate(hw);
-	int ret;
-	unsigned int val;
-
-	ret = regmap_read(std->regmap, CLK_STAT_REGOFFSET, &val);
-	if (ret < 0)
-		return ret;
-
-	return val & BIT(std->bit);
-}
-
-static int oxnas_clk_gate_enable(struct clk_hw *hw)
-{
-	struct clk_oxnas_gate *std = to_clk_oxnas_gate(hw);
-
-	regmap_write(std->regmap, CLK_SET_REGOFFSET, BIT(std->bit));
-
-	return 0;
-}
-
-static void oxnas_clk_gate_disable(struct clk_hw *hw)
-{
-	struct clk_oxnas_gate *std = to_clk_oxnas_gate(hw);
-
-	regmap_write(std->regmap, CLK_CLR_REGOFFSET, BIT(std->bit));
-}
-
-static const struct clk_ops oxnas_clk_gate_ops = {
-	.enable = oxnas_clk_gate_enable,
-	.disable = oxnas_clk_gate_disable,
-	.is_enabled = oxnas_clk_gate_is_enabled,
-};
-
-static const char *const osc_parents[] = {
-	"oscillator",
-};
-
-static const char *const eth_parents[] = {
-	"gmacclk",
-};
-
-#define OXNAS_GATE(_name, _bit, _parents)				\
-struct clk_oxnas_gate _name = {						\
-	.bit = (_bit),							\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = #_name,						\
-		.ops = &oxnas_clk_gate_ops,				\
-		.parent_names = _parents,				\
-		.num_parents = ARRAY_SIZE(_parents),			\
-		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
-	},								\
-}
-
-static OXNAS_GATE(ox810se_leon, 0, osc_parents);
-static OXNAS_GATE(ox810se_dma_sgdma, 1, osc_parents);
-static OXNAS_GATE(ox810se_cipher, 2, osc_parents);
-static OXNAS_GATE(ox810se_sata, 4, osc_parents);
-static OXNAS_GATE(ox810se_audio, 5, osc_parents);
-static OXNAS_GATE(ox810se_usbmph, 6, osc_parents);
-static OXNAS_GATE(ox810se_etha, 7, eth_parents);
-static OXNAS_GATE(ox810se_pciea, 8, osc_parents);
-static OXNAS_GATE(ox810se_nand, 9, osc_parents);
-
-static struct clk_oxnas_gate *ox810se_gates[] = {
-	&ox810se_leon,
-	&ox810se_dma_sgdma,
-	&ox810se_cipher,
-	&ox810se_sata,
-	&ox810se_audio,
-	&ox810se_usbmph,
-	&ox810se_etha,
-	&ox810se_pciea,
-	&ox810se_nand,
-};
-
-static OXNAS_GATE(ox820_leon, 0, osc_parents);
-static OXNAS_GATE(ox820_dma_sgdma, 1, osc_parents);
-static OXNAS_GATE(ox820_cipher, 2, osc_parents);
-static OXNAS_GATE(ox820_sd, 3, osc_parents);
-static OXNAS_GATE(ox820_sata, 4, osc_parents);
-static OXNAS_GATE(ox820_audio, 5, osc_parents);
-static OXNAS_GATE(ox820_usbmph, 6, osc_parents);
-static OXNAS_GATE(ox820_etha, 7, eth_parents);
-static OXNAS_GATE(ox820_pciea, 8, osc_parents);
-static OXNAS_GATE(ox820_nand, 9, osc_parents);
-static OXNAS_GATE(ox820_ethb, 10, eth_parents);
-static OXNAS_GATE(ox820_pcieb, 11, osc_parents);
-static OXNAS_GATE(ox820_ref600, 12, osc_parents);
-static OXNAS_GATE(ox820_usbdev, 13, osc_parents);
-
-static struct clk_oxnas_gate *ox820_gates[] = {
-	&ox820_leon,
-	&ox820_dma_sgdma,
-	&ox820_cipher,
-	&ox820_sd,
-	&ox820_sata,
-	&ox820_audio,
-	&ox820_usbmph,
-	&ox820_etha,
-	&ox820_pciea,
-	&ox820_nand,
-	&ox820_etha,
-	&ox820_pciea,
-	&ox820_ref600,
-	&ox820_usbdev,
-};
-
-static struct clk_hw_onecell_data ox810se_hw_onecell_data = {
-	.hws = {
-		[CLK_810_LEON]	= &ox810se_leon.hw,
-		[CLK_810_DMA_SGDMA]	= &ox810se_dma_sgdma.hw,
-		[CLK_810_CIPHER]	= &ox810se_cipher.hw,
-		[CLK_810_SATA]	= &ox810se_sata.hw,
-		[CLK_810_AUDIO]	= &ox810se_audio.hw,
-		[CLK_810_USBMPH]	= &ox810se_usbmph.hw,
-		[CLK_810_ETHA]	= &ox810se_etha.hw,
-		[CLK_810_PCIEA]	= &ox810se_pciea.hw,
-		[CLK_810_NAND]	= &ox810se_nand.hw,
-	},
-	.num = ARRAY_SIZE(ox810se_gates),
-};
-
-static struct clk_hw_onecell_data ox820_hw_onecell_data = {
-	.hws = {
-		[CLK_820_LEON]	= &ox820_leon.hw,
-		[CLK_820_DMA_SGDMA]	= &ox820_dma_sgdma.hw,
-		[CLK_820_CIPHER]	= &ox820_cipher.hw,
-		[CLK_820_SD]	= &ox820_sd.hw,
-		[CLK_820_SATA]	= &ox820_sata.hw,
-		[CLK_820_AUDIO]	= &ox820_audio.hw,
-		[CLK_820_USBMPH]	= &ox820_usbmph.hw,
-		[CLK_820_ETHA]	= &ox820_etha.hw,
-		[CLK_820_PCIEA]	= &ox820_pciea.hw,
-		[CLK_820_NAND]	= &ox820_nand.hw,
-		[CLK_820_ETHB]	= &ox820_ethb.hw,
-		[CLK_820_PCIEB]	= &ox820_pcieb.hw,
-		[CLK_820_REF600]	= &ox820_ref600.hw,
-		[CLK_820_USBDEV]	= &ox820_usbdev.hw,
-	},
-	.num = ARRAY_SIZE(ox820_gates),
-};
-
-static struct oxnas_stdclk_data ox810se_stdclk_data = {
-	.onecell_data = &ox810se_hw_onecell_data,
-	.gates = ox810se_gates,
-	.ngates = ARRAY_SIZE(ox810se_gates),
-};
-
-static struct oxnas_stdclk_data ox820_stdclk_data = {
-	.onecell_data = &ox820_hw_onecell_data,
-	.gates = ox820_gates,
-	.ngates = ARRAY_SIZE(ox820_gates),
-};
-
-static const struct of_device_id oxnas_stdclk_dt_ids[] = {
-	{ .compatible = "oxsemi,ox810se-stdclk", &ox810se_stdclk_data },
-	{ .compatible = "oxsemi,ox820-stdclk", &ox820_stdclk_data },
-	{ }
-};
-
-static int oxnas_stdclk_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node, *parent_np;
-	const struct oxnas_stdclk_data *data;
-	struct regmap *regmap;
-	int ret;
-	int i;
-
-	data = of_device_get_match_data(&pdev->dev);
-
-	parent_np = of_get_parent(np);
-	regmap = syscon_node_to_regmap(parent_np);
-	of_node_put(parent_np);
-	if (IS_ERR(regmap)) {
-		dev_err(&pdev->dev, "failed to have parent regmap\n");
-		return PTR_ERR(regmap);
-	}
-
-	for (i = 0 ; i < data->ngates ; ++i)
-		data->gates[i]->regmap = regmap;
-
-	for (i = 0; i < data->onecell_data->num; i++) {
-		if (!data->onecell_data->hws[i])
-			continue;
-
-		ret = devm_clk_hw_register(&pdev->dev,
-					   data->onecell_data->hws[i]);
-		if (ret)
-			return ret;
-	}
-
-	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
-				      data->onecell_data);
-}
-
-static struct platform_driver oxnas_stdclk_driver = {
-	.probe = oxnas_stdclk_probe,
-	.driver	= {
-		.name = "oxnas-stdclk",
-		.suppress_bind_attrs = true,
-		.of_match_table = oxnas_stdclk_dt_ids,
-	},
-};
-builtin_platform_driver(oxnas_stdclk_driver);

-- 
2.34.1

