Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C114744089
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjF3Q7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjF3Q6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:58:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4393AB2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc0981733so19150945e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144324; x=1690736324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLX6nBNdDJugrDB/bEpPIyh5Bk3WxOcHqPGVxflanv0=;
        b=ZJshyi0t1+m1fWRh4RSn3mPfNlTGCmx81L3tZMHnGArfYhg6HHrT7fkJsgxItykzsw
         tjQpqSqwOJ7fG4jhR3xEDtR4/04cGDKawNeKlBGM8PfKXCY8v46mMglqxTDP9a3pgS3/
         xXE2UFjOCN44q1fmfEp/5pr8VwMLXKFABzvY4bwZH/HXY8xqlaSfidyKSinUJiaKaAcM
         0+rz7NTjRUfFvLMI9Z1ecvRAMiClwEBO/jT1sjfWEQDbZl8nMGEWLjaCaRmiYJzK6zE5
         yxI6eBZk13vTDUTke52+3CnwwvE0TB/kX5pt44x9k4bL0erd+p8et1wcGaDpKnP+GEJq
         Qzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144324; x=1690736324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLX6nBNdDJugrDB/bEpPIyh5Bk3WxOcHqPGVxflanv0=;
        b=WdcJ27YNZ/IPMWy2avaCTZc6I3Fm18VBEd91JgdSrIXM7Y6KOT0AOAs02J0hHPyiZq
         OuNbJ8VtY6UY7x9sBJmd5UQju8PH/2cyMVxjs0UEfMCoR2wFSiqblIb5H14k3P+7jPan
         ZHzGiF31untQtxfwyaiTC9BDbVgLlivFnl15pdoHKhQmIHl3/c8NBgfO66WdcJFuhUNj
         K87Cni/SdIKm//sEvAszN0qw0btIWdX3Lk5Jdt/GfMp/NA8w7n4oFaLXLIT1ncgBuG6d
         8b95nSLY0WQ9hgoy2hNHhnhYzB01jr8G/KgGglliWLbIblVSQ+eg/BsTc5zm695Bi9vT
         exbw==
X-Gm-Message-State: AC+VfDzVBy7THaBxdWvnAt3ZYpehYUXqZUxHBZ3y1K9PTs1kFmGbPsus
        gribG7rh9AFJnXwkMhzkyO6IhA==
X-Google-Smtp-Source: ACHHUZ7sLazNkS5hMB5t8MZsO4t0md2cj2Mnsc0FoY8HRuFayoCgx/4smWdsoKAUnjWfPgjREkHWvg==
X-Received: by 2002:a05:600c:2219:b0:3fb:c217:7243 with SMTP id z25-20020a05600c221900b003fbc2177243mr2743100wml.18.1688144324582;
        Fri, 30 Jun 2023 09:58:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm18913772wri.73.2023.06.30.09.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:58:43 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 30 Jun 2023 18:58:30 +0200
Subject: [PATCH v2 05/15] nand: oxnas_nand: remove obsolete raw nand driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-5-fb6ab3dea87c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7464;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=7dsGUntkBvgK9uJ6n7pA2u8tn+a0H9twzokCuaVvts0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwm1Oj0vMGvH0O5R6AWEiekxCYAhBP79UYq8vavO
 6hSf6XGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JtQAKCRB33NvayMhJ0YtrEA
 DELLHsyVja0JZ9+9NAqqxKxiIFJ+WvtNaveSgdefeOSaEFmDD5DqUs/U/ZvYSBhKv6nbnlPKBR412z
 jsRR6sX7nzNSYPdX+ckwEWSX1Q2pGOFUqrHEQuOiuvLGBlC/AlfJIyCmRIujDiU7GeI8o8mALeSpdJ
 dEGJlcO9eg2h1D7FC+CcTxOZPgBSaWal5tjwV24BjAiBnl0neqRE/TrVz7dpr62TQf662kibEmDhzI
 pQM7M6JLpCn7skYtYXyVkOm0r1HhTZHQrlYBro0LmVEjjyFjZzPQ+4CuQpa3liMeSq+ehFsEr+ldxE
 oWhGqQLNsa3QRWznq/Lq0UFwqscynT5CYWtQS72EyEZsG9Z/y1lhBK2hJs7cPP+ubGz3hHCkGJpdHO
 VD5Y7ivWGN1fQRqV/YGohAQKJjbvo4XYWNqlfBXmBErGB6nkLkPDLoPllO8fEF8azo/lDIoWCJk1lk
 vUGqCC6Z7gTT1l8XFTIg3mCV2WzAHQS2DyLa2Mg4SkOzvvHsR/Sf0Q14D1+m4A6RlUDQ9AVOsBWI1r
 rfGfajgw3ca5+I0PAO9REG9MjoosN1yQlLQPEo+73hQ1dXFxQi66lExAkqV0OO1JYQcZpbkIjmyEQ6
 oX0CJ/WRIoGnA56cF1huCNfoc2uc2ilsIlFtxqBbzuhFUWMBI7ibq7A6YFkA==
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
for OX810 and OX820 nand.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/mtd/nand/raw/Kconfig      |   7 --
 drivers/mtd/nand/raw/Makefile     |   1 -
 drivers/mtd/nand/raw/oxnas_nand.c | 209 --------------------------------------
 3 files changed, 217 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index b523354dfb00..5b871e2f5c5e 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -204,13 +204,6 @@ config MTD_NAND_BCM47XXNFLASH
 	  registered by bcma as platform devices. This enables driver for
 	  NAND flash memories. For now only BCM4706 is supported.
 
-config MTD_NAND_OXNAS
-	tristate "Oxford Semiconductor NAND controller"
-	depends on ARCH_OXNAS || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  This enables the NAND flash controller on Oxford Semiconductor SoCs.
-
 config MTD_NAND_MPC5121_NFC
 	tristate "MPC5121 NAND controller"
 	depends on PPC_MPC512x
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index d93e861d8ba7..25120a4afada 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -26,7 +26,6 @@ obj-$(CONFIG_MTD_NAND_MARVELL)		+= marvell_nand.o
 obj-$(CONFIG_MTD_NAND_PLATFORM)		+= plat_nand.o
 obj-$(CONFIG_MTD_NAND_PASEMI)		+= pasemi_nand.o
 obj-$(CONFIG_MTD_NAND_ORION)		+= orion_nand.o
-obj-$(CONFIG_MTD_NAND_OXNAS)		+= oxnas_nand.o
 obj-$(CONFIG_MTD_NAND_FSL_ELBC)		+= fsl_elbc_nand.o
 obj-$(CONFIG_MTD_NAND_FSL_IFC)		+= fsl_ifc_nand.o
 obj-$(CONFIG_MTD_NAND_FSL_UPM)		+= fsl_upm.o
diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/oxnas_nand.c
deleted file mode 100644
index e3c9807df1cd..000000000000
--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ /dev/null
@@ -1,209 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Oxford Semiconductor OXNAS NAND driver
-
- * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
- * Heavily based on plat_nand.c :
- * Author: Vitaly Wool <vitalywool@gmail.com>
- * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
- * Copyright (C) 2012 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/clk.h>
-#include <linux/reset.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/partitions.h>
-#include <linux/of.h>
-
-/* Nand commands */
-#define OXNAS_NAND_CMD_ALE		BIT(18)
-#define OXNAS_NAND_CMD_CLE		BIT(19)
-
-#define OXNAS_NAND_MAX_CHIPS	1
-
-struct oxnas_nand_ctrl {
-	struct nand_controller base;
-	void __iomem *io_base;
-	struct clk *clk;
-	struct nand_chip *chips[OXNAS_NAND_MAX_CHIPS];
-	unsigned int nchips;
-};
-
-static uint8_t oxnas_nand_read_byte(struct nand_chip *chip)
-{
-	struct oxnas_nand_ctrl *oxnas = nand_get_controller_data(chip);
-
-	return readb(oxnas->io_base);
-}
-
-static void oxnas_nand_read_buf(struct nand_chip *chip, u8 *buf, int len)
-{
-	struct oxnas_nand_ctrl *oxnas = nand_get_controller_data(chip);
-
-	ioread8_rep(oxnas->io_base, buf, len);
-}
-
-static void oxnas_nand_write_buf(struct nand_chip *chip, const u8 *buf,
-				 int len)
-{
-	struct oxnas_nand_ctrl *oxnas = nand_get_controller_data(chip);
-
-	iowrite8_rep(oxnas->io_base, buf, len);
-}
-
-/* Single CS command control */
-static void oxnas_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
-				unsigned int ctrl)
-{
-	struct oxnas_nand_ctrl *oxnas = nand_get_controller_data(chip);
-
-	if (ctrl & NAND_CLE)
-		writeb(cmd, oxnas->io_base + OXNAS_NAND_CMD_CLE);
-	else if (ctrl & NAND_ALE)
-		writeb(cmd, oxnas->io_base + OXNAS_NAND_CMD_ALE);
-}
-
-/*
- * Probe for the NAND device.
- */
-static int oxnas_nand_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	struct device_node *nand_np;
-	struct oxnas_nand_ctrl *oxnas;
-	struct nand_chip *chip;
-	struct mtd_info *mtd;
-	int count = 0;
-	int err = 0;
-	int i;
-
-	/* Allocate memory for the device structure (and zero it) */
-	oxnas = devm_kzalloc(&pdev->dev, sizeof(*oxnas),
-			     GFP_KERNEL);
-	if (!oxnas)
-		return -ENOMEM;
-
-	nand_controller_init(&oxnas->base);
-
-	oxnas->io_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(oxnas->io_base))
-		return PTR_ERR(oxnas->io_base);
-
-	oxnas->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(oxnas->clk))
-		oxnas->clk = NULL;
-
-	/* Only a single chip node is supported */
-	count = of_get_child_count(np);
-	if (count > 1)
-		return -EINVAL;
-
-	err = clk_prepare_enable(oxnas->clk);
-	if (err)
-		return err;
-
-	device_reset_optional(&pdev->dev);
-
-	for_each_child_of_node(np, nand_np) {
-		chip = devm_kzalloc(&pdev->dev, sizeof(struct nand_chip),
-				    GFP_KERNEL);
-		if (!chip) {
-			err = -ENOMEM;
-			goto err_release_child;
-		}
-
-		chip->controller = &oxnas->base;
-
-		nand_set_flash_node(chip, nand_np);
-		nand_set_controller_data(chip, oxnas);
-
-		mtd = nand_to_mtd(chip);
-		mtd->dev.parent = &pdev->dev;
-		mtd->priv = chip;
-
-		chip->legacy.cmd_ctrl = oxnas_nand_cmd_ctrl;
-		chip->legacy.read_buf = oxnas_nand_read_buf;
-		chip->legacy.read_byte = oxnas_nand_read_byte;
-		chip->legacy.write_buf = oxnas_nand_write_buf;
-		chip->legacy.chip_delay = 30;
-
-		/* Scan to find existence of the device */
-		err = nand_scan(chip, 1);
-		if (err)
-			goto err_release_child;
-
-		err = mtd_device_register(mtd, NULL, 0);
-		if (err)
-			goto err_cleanup_nand;
-
-		oxnas->chips[oxnas->nchips++] = chip;
-	}
-
-	/* Exit if no chips found */
-	if (!oxnas->nchips) {
-		err = -ENODEV;
-		goto err_clk_unprepare;
-	}
-
-	platform_set_drvdata(pdev, oxnas);
-
-	return 0;
-
-err_cleanup_nand:
-	nand_cleanup(chip);
-err_release_child:
-	of_node_put(nand_np);
-
-	for (i = 0; i < oxnas->nchips; i++) {
-		chip = oxnas->chips[i];
-		WARN_ON(mtd_device_unregister(nand_to_mtd(chip)));
-		nand_cleanup(chip);
-	}
-
-err_clk_unprepare:
-	clk_disable_unprepare(oxnas->clk);
-	return err;
-}
-
-static void oxnas_nand_remove(struct platform_device *pdev)
-{
-	struct oxnas_nand_ctrl *oxnas = platform_get_drvdata(pdev);
-	struct nand_chip *chip;
-	int i;
-
-	for (i = 0; i < oxnas->nchips; i++) {
-		chip = oxnas->chips[i];
-		WARN_ON(mtd_device_unregister(nand_to_mtd(chip)));
-		nand_cleanup(chip);
-	}
-
-	clk_disable_unprepare(oxnas->clk);
-}
-
-static const struct of_device_id oxnas_nand_match[] = {
-	{ .compatible = "oxsemi,ox820-nand" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, oxnas_nand_match);
-
-static struct platform_driver oxnas_nand_driver = {
-	.probe	= oxnas_nand_probe,
-	.remove_new = oxnas_nand_remove,
-	.driver	= {
-		.name		= "oxnas_nand",
-		.of_match_table = oxnas_nand_match,
-	},
-};
-
-module_platform_driver(oxnas_nand_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
-MODULE_DESCRIPTION("Oxnas NAND driver");
-MODULE_ALIAS("platform:oxnas_nand");

-- 
2.34.1

