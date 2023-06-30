Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7417674408C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjF3Q7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjF3Q6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:58:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82443C2F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3142860734aso183003f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144328; x=1690736328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hCA45HRWCawG6M+UrcKcJfcyL9bWow6mfzB7qY6kDQ=;
        b=Oxst0RVHWlB9WQr9vkW9qYJ2MXzI1wXizVa9zA6UbPIT2b22eRu4Bdrty9+ypVsjAT
         HufwRxeN+qSFgZb1HDxNa0Q4N44SsCnTD8tR1wcvjCL5/Ngt4URTFsH3uOxy4jDZgKh1
         AO1QlnQd79FbAcqedS3WXT5iayc+X38jM92/5eljOcip92th1/JXMiW1YRJyvU/C3Kn8
         S7NTziA8/RbNHM+mt5aIjoIIVVVuVBZKhgFuCWwh8x67qktMGaNioEzBvCUuhJZ1mJro
         3A0Wcg8/EI4QfgI4/Yzw9TKFOP3H6GSk2H/JPgnXqUndMLV+uXMROGASqllwR7R0dTpb
         F4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144328; x=1690736328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hCA45HRWCawG6M+UrcKcJfcyL9bWow6mfzB7qY6kDQ=;
        b=O/rtfy89xqQAnNTy2ghR61J4Y6L/Z3avNjkE34RpNdIlTOR+z+skUcscjOIGCpewL2
         edudmEMO8cjYL3kx8DJX5uL38rqUWSozAD7PHL2GmInHf+yvWElfuZQmgv8Bg12J2wDC
         e8yJOTOn0XD9GEIPyXFCwe3kZejJJyvtIJLpIPwT5wNbOUCjCQVHwY6/g+aMiLrb/wkX
         ENMFCiQsIB4HaWSDDZweIN0NnQfjTjmgZWVxfuIiTU/RxPI/TRCB92x3JTFLldoQZfDo
         PSdOhmbJ9pUmLZj4wB1uGg6MKFDDaSc3H5tKVVaNiyvBSzMtAYH1ZslwRMNwVTCGB3H5
         STeg==
X-Gm-Message-State: ABy/qLa2Z0oEDeu1gei9NJz6u9mBOrNX7cIXd3tPSehEV9FuEVU3+gN2
        XwYn2zSNIow5L0qxSkFFuGBvaA==
X-Google-Smtp-Source: APBJJlGvfNvFW0jCjGvznY6HK+i+JgrFVqcRb7025tQ2yfPikbi7tpgq/sWhuqGevYLVCCnwbLd10A==
X-Received: by 2002:adf:f84a:0:b0:314:140a:e629 with SMTP id d10-20020adff84a000000b00314140ae629mr5874134wrq.7.1688144327901;
        Fri, 30 Jun 2023 09:58:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm18913772wri.73.2023.06.30.09.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:58:47 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 30 Jun 2023 18:58:32 +0200
Subject: [PATCH v2 07/15] net: stmmac: dwmac-oxnas: remove obsolete dwmac
 glue driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-7-fb6ab3dea87c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9143;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ejAz1IAJoZ72AsGfMantZn1z4aUBu8ItOfmfHHeZV44=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwm2VumAiS88SMnmjtsiebP+hoRV9So6UYEBjYMz
 JLbm4f6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JtgAKCRB33NvayMhJ0fFoD/
 4923BNV/pVrdOwyik5/XtouR/Jlvt2gqmGEwEHrrLa9vkPleS9mo6rFBzrMKzub/3s8c0Nr8QGy9QX
 +ITgdAz3hadwdg6WD+pKQmzwLr5SKeq4Ompojznza9M1D2ah0zwnaqriC16RPkG1RVd+yHb+vvad44
 hEomE8lC0Fp8nJasBuzOIhGWqpmkdS4b2C+xrwoXbS1GGO2wMEX/1g1EoRXC+ntNgxjcL6pRnrYaZF
 s8s/YQvObMyhIAxq3i7JOy9pGZqwN1tvk8Vbf0R5EqttAQXu2KCd5SELFBQ8wGQl/Byf3ffNsUi6sO
 5+QyzsJ8RAQXIBJl+0rkLowTnsVe8drEo+VvVZYq4XasdenxbljLuxYlBD0sDgTteI8waV+7lWfORa
 wCLKAhLDXnOIGcCQSyhfia/noLqc3yJfrFgtgAG1DAdx89/WN2JJKXpxe0+hW3WDx8PzdfRmwW0HMe
 2ZnzPiJnTfeZUGsuw9gaKmmaPst2kgi1p9ap02/RB4dnRnRwSFVc8T/zWwPwFF5rT1ftWWLcRCo+TP
 ZpDESoAgNFIdfafkjaFeyNwqnzIypqe54Fm12UQO0BeDNGH+nMauN2ZDkw1V47DNwcS4hqcB3rykP2
 B8r4+4oRQfgq78z6eBgoDKvoxAxBrKjMsBceQDGiSyuaKHNNYRYR4VgR9deA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove support
for OX810 and OX820 ethernet.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig       |  11 -
 drivers/net/ethernet/stmicro/stmmac/Makefile      |   1 -
 drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c | 245 ----------------------
 3 files changed, 257 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 5583f0b055ec..06c6871f8788 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -121,17 +121,6 @@ config DWMAC_MESON
 	  the stmmac device driver. This driver is used for Meson6,
 	  Meson8, Meson8b and GXBB SoCs.
 
-config DWMAC_OXNAS
-	tristate "Oxford Semiconductor OXNAS dwmac support"
-	default ARCH_OXNAS
-	depends on OF && COMMON_CLK && (ARCH_OXNAS || COMPILE_TEST)
-	select MFD_SYSCON
-	help
-	  Support for Ethernet controller on Oxford Semiconductor OXNAS SoCs.
-
-	  This selects the Oxford Semiconductor OXNASSoC glue layer support for
-	  the stmmac device driver. This driver is used for OX820.
-
 config DWMAC_QCOM_ETHQOS
 	tristate "Qualcomm ETHQOS support"
 	default ARCH_QCOM
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 7dd3d388068b..5b57aee19267 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_DWMAC_IPQ806X)	+= dwmac-ipq806x.o
 obj-$(CONFIG_DWMAC_LPC18XX)	+= dwmac-lpc18xx.o
 obj-$(CONFIG_DWMAC_MEDIATEK)	+= dwmac-mediatek.o
 obj-$(CONFIG_DWMAC_MESON)	+= dwmac-meson.o dwmac-meson8b.o
-obj-$(CONFIG_DWMAC_OXNAS)	+= dwmac-oxnas.o
 obj-$(CONFIG_DWMAC_QCOM_ETHQOS)	+= dwmac-qcom-ethqos.o
 obj-$(CONFIG_DWMAC_ROCKCHIP)	+= dwmac-rk.o
 obj-$(CONFIG_DWMAC_SOCFPGA)	+= dwmac-altr-socfpga.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c
deleted file mode 100644
index 42954020de2c..000000000000
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c
+++ /dev/null
@@ -1,245 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Oxford Semiconductor OXNAS DWMAC glue layer
- *
- * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
- * Copyright (C) 2014 Daniel Golle <daniel@makrotopia.org>
- * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
- * Copyright (C) 2012 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
-#include <linux/mfd/syscon.h>
-#include <linux/stmmac.h>
-
-#include "stmmac_platform.h"
-
-/* System Control regmap offsets */
-#define OXNAS_DWMAC_CTRL_REGOFFSET	0x78
-#define OXNAS_DWMAC_DELAY_REGOFFSET	0x100
-
-/* Control Register */
-#define DWMAC_CKEN_RX_IN        14
-#define DWMAC_CKEN_RXN_OUT      13
-#define DWMAC_CKEN_RX_OUT       12
-#define DWMAC_CKEN_TX_IN        10
-#define DWMAC_CKEN_TXN_OUT      9
-#define DWMAC_CKEN_TX_OUT       8
-#define DWMAC_RX_SOURCE         7
-#define DWMAC_TX_SOURCE         6
-#define DWMAC_LOW_TX_SOURCE     4
-#define DWMAC_AUTO_TX_SOURCE    3
-#define DWMAC_RGMII             2
-#define DWMAC_SIMPLE_MUX        1
-#define DWMAC_CKEN_GTX          0
-
-/* Delay register */
-#define DWMAC_TX_VARDELAY_SHIFT		0
-#define DWMAC_TXN_VARDELAY_SHIFT	8
-#define DWMAC_RX_VARDELAY_SHIFT		16
-#define DWMAC_RXN_VARDELAY_SHIFT	24
-#define DWMAC_TX_VARDELAY(d)		((d) << DWMAC_TX_VARDELAY_SHIFT)
-#define DWMAC_TXN_VARDELAY(d)		((d) << DWMAC_TXN_VARDELAY_SHIFT)
-#define DWMAC_RX_VARDELAY(d)		((d) << DWMAC_RX_VARDELAY_SHIFT)
-#define DWMAC_RXN_VARDELAY(d)		((d) << DWMAC_RXN_VARDELAY_SHIFT)
-
-struct oxnas_dwmac;
-
-struct oxnas_dwmac_data {
-	int (*setup)(struct oxnas_dwmac *dwmac);
-};
-
-struct oxnas_dwmac {
-	struct device	*dev;
-	struct clk	*clk;
-	struct regmap	*regmap;
-	const struct oxnas_dwmac_data	*data;
-};
-
-static int oxnas_dwmac_setup_ox810se(struct oxnas_dwmac *dwmac)
-{
-	unsigned int value;
-	int ret;
-
-	ret = regmap_read(dwmac->regmap, OXNAS_DWMAC_CTRL_REGOFFSET, &value);
-	if (ret < 0)
-		return ret;
-
-	/* Enable GMII_GTXCLK to follow GMII_REFCLK, required for gigabit PHY */
-	value |= BIT(DWMAC_CKEN_GTX)		|
-		 /* Use simple mux for 25/125 Mhz clock switching */
-		 BIT(DWMAC_SIMPLE_MUX);
-
-	regmap_write(dwmac->regmap, OXNAS_DWMAC_CTRL_REGOFFSET, value);
-
-	return 0;
-}
-
-static int oxnas_dwmac_setup_ox820(struct oxnas_dwmac *dwmac)
-{
-	unsigned int value;
-	int ret;
-
-	ret = regmap_read(dwmac->regmap, OXNAS_DWMAC_CTRL_REGOFFSET, &value);
-	if (ret < 0)
-		return ret;
-
-	/* Enable GMII_GTXCLK to follow GMII_REFCLK, required for gigabit PHY */
-	value |= BIT(DWMAC_CKEN_GTX)		|
-		 /* Use simple mux for 25/125 Mhz clock switching */
-		BIT(DWMAC_SIMPLE_MUX)		|
-		/* set auto switch tx clock source */
-		BIT(DWMAC_AUTO_TX_SOURCE)	|
-		/* enable tx & rx vardelay */
-		BIT(DWMAC_CKEN_TX_OUT)		|
-		BIT(DWMAC_CKEN_TXN_OUT)	|
-		BIT(DWMAC_CKEN_TX_IN)		|
-		BIT(DWMAC_CKEN_RX_OUT)		|
-		BIT(DWMAC_CKEN_RXN_OUT)	|
-		BIT(DWMAC_CKEN_RX_IN);
-	regmap_write(dwmac->regmap, OXNAS_DWMAC_CTRL_REGOFFSET, value);
-
-	/* set tx & rx vardelay */
-	value = DWMAC_TX_VARDELAY(4)	|
-		DWMAC_TXN_VARDELAY(2)	|
-		DWMAC_RX_VARDELAY(10)	|
-		DWMAC_RXN_VARDELAY(8);
-	regmap_write(dwmac->regmap, OXNAS_DWMAC_DELAY_REGOFFSET, value);
-
-	return 0;
-}
-
-static int oxnas_dwmac_init(struct platform_device *pdev, void *priv)
-{
-	struct oxnas_dwmac *dwmac = priv;
-	int ret;
-
-	/* Reset HW here before changing the glue configuration */
-	ret = device_reset(dwmac->dev);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(dwmac->clk);
-	if (ret)
-		return ret;
-
-	ret = dwmac->data->setup(dwmac);
-	if (ret)
-		clk_disable_unprepare(dwmac->clk);
-
-	return ret;
-}
-
-static void oxnas_dwmac_exit(struct platform_device *pdev, void *priv)
-{
-	struct oxnas_dwmac *dwmac = priv;
-
-	clk_disable_unprepare(dwmac->clk);
-}
-
-static int oxnas_dwmac_probe(struct platform_device *pdev)
-{
-	struct plat_stmmacenet_data *plat_dat;
-	struct stmmac_resources stmmac_res;
-	struct oxnas_dwmac *dwmac;
-	int ret;
-
-	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
-	if (ret)
-		return ret;
-
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
-	if (IS_ERR(plat_dat))
-		return PTR_ERR(plat_dat);
-
-	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
-	if (!dwmac) {
-		ret = -ENOMEM;
-		goto err_remove_config_dt;
-	}
-
-	dwmac->data = (const struct oxnas_dwmac_data *)of_device_get_match_data(&pdev->dev);
-	if (!dwmac->data) {
-		ret = -EINVAL;
-		goto err_remove_config_dt;
-	}
-
-	dwmac->dev = &pdev->dev;
-	plat_dat->bsp_priv = dwmac;
-	plat_dat->init = oxnas_dwmac_init;
-	plat_dat->exit = oxnas_dwmac_exit;
-
-	dwmac->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-							"oxsemi,sys-ctrl");
-	if (IS_ERR(dwmac->regmap)) {
-		dev_err(&pdev->dev, "failed to have sysctrl regmap\n");
-		ret = PTR_ERR(dwmac->regmap);
-		goto err_remove_config_dt;
-	}
-
-	dwmac->clk = devm_clk_get(&pdev->dev, "gmac");
-	if (IS_ERR(dwmac->clk)) {
-		ret = PTR_ERR(dwmac->clk);
-		goto err_remove_config_dt;
-	}
-
-	ret = oxnas_dwmac_init(pdev, plat_dat->bsp_priv);
-	if (ret)
-		goto err_remove_config_dt;
-
-	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-	if (ret)
-		goto err_dwmac_exit;
-
-
-	return 0;
-
-err_dwmac_exit:
-	oxnas_dwmac_exit(pdev, plat_dat->bsp_priv);
-err_remove_config_dt:
-	stmmac_remove_config_dt(pdev, plat_dat);
-
-	return ret;
-}
-
-static const struct oxnas_dwmac_data ox810se_dwmac_data = {
-	.setup = oxnas_dwmac_setup_ox810se,
-};
-
-static const struct oxnas_dwmac_data ox820_dwmac_data = {
-	.setup = oxnas_dwmac_setup_ox820,
-};
-
-static const struct of_device_id oxnas_dwmac_match[] = {
-	{
-		.compatible = "oxsemi,ox810se-dwmac",
-		.data = &ox810se_dwmac_data,
-	},
-	{
-		.compatible = "oxsemi,ox820-dwmac",
-		.data = &ox820_dwmac_data,
-	},
-	{ }
-};
-MODULE_DEVICE_TABLE(of, oxnas_dwmac_match);
-
-static struct platform_driver oxnas_dwmac_driver = {
-	.probe  = oxnas_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
-	.driver = {
-		.name           = "oxnas-dwmac",
-		.pm		= &stmmac_pltfr_pm_ops,
-		.of_match_table = oxnas_dwmac_match,
-	},
-};
-module_platform_driver(oxnas_dwmac_driver);
-
-MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
-MODULE_DESCRIPTION("Oxford Semiconductor OXNAS DWMAC glue layer");
-MODULE_LICENSE("GPL v2");

-- 
2.34.1

