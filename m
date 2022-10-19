Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CEF604B73
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiJSPbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiJSPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F242E1D63A8;
        Wed, 19 Oct 2022 08:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B63566192C;
        Wed, 19 Oct 2022 15:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88092C433C1;
        Wed, 19 Oct 2022 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666192017;
        bh=HS3PFH697lV4ACSOHmqEUYqKoZRf8xn5Q1It8jFYkb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=umD84749KZwLWWmN922ZOzZI0Xd8j7pVE+dQfuaKJS7DU+PQOHO8wfrNrui7g7cQE
         lg5vv++L2mqr6/V3DLVZ5KgCreozm4xoROPkEZhiAkuOwR34dw5Es+7imslKlQjs6l
         ml0LXs7MOMBwYvY0W07O2Yk31XvCQeDMev4IQlaTMk2Nptcl9F2OrV4wEZ1ZPV4noL
         NDpDYZrObSREXjHeH/EtyGljDsc0klsaiqgMsrKscG6b6jVNOk25Fgt5p3WaNeG5yR
         kvWURKBkfj0r6l/ISHGugheGLCo7l4nWBapay2XCZwzkCTVtPFKJRnCwaFd1cm1RFP
         a+HsYXSl/1s/g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Halasa <khalasa@piap.pl>, linux-mmc@vger.kernel.org
Subject: [PATCH 03/17] mmc: remove cns3xxx driver
Date:   Wed, 19 Oct 2022 17:03:25 +0200
Message-Id: <20221019150410.3851944-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019150410.3851944-1-arnd@kernel.org>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The cns3xxx platform is gone, so this driver is now orphaned.

Cc: Krzysztof Halasa <khalasa@piap.pl>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/Kconfig         |  11 ---
 drivers/mmc/host/Makefile        |   1 -
 drivers/mmc/host/sdhci-cns3xxx.c | 113 -------------------------------
 3 files changed, 125 deletions(-)
 delete mode 100644 drivers/mmc/host/sdhci-cns3xxx.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f324daadaf70..1c5b1c48a230 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -253,17 +253,6 @@ config MMC_SDHCI_CADENCE
 
 	  If unsure, say N.
 
-config MMC_SDHCI_CNS3XXX
-	tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
-	depends on ARCH_CNS3XXX || COMPILE_TEST
-	depends on MMC_SDHCI_PLTFM
-	help
-	  This selects the SDHCI support for CNS3xxx System-on-Chip devices.
-
-	  If you have a controller with this interface, say Y or M here.
-
-	  If unsure, say N.
-
 config MMC_SDHCI_ESDHC_MCF
 	tristate "SDHCI support for the Freescale eSDHC ColdFire controller"
 	depends on M5441x
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 4e4ceb32c4b4..7bea77c28b7e 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -77,7 +77,6 @@ obj-$(CONFIG_MMC_REALTEK_USB)	+= rtsx_usb_sdmmc.o
 
 obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
 obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
-obj-$(CONFIG_MMC_SDHCI_CNS3XXX)		+= sdhci-cns3xxx.o
 obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
 obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
 obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
deleted file mode 100644
index 2a29c7a4f308..000000000000
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ /dev/null
@@ -1,113 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * SDHCI support for CNS3xxx SoC
- *
- * Copyright 2008 Cavium Networks
- * Copyright 2010 MontaVista Software, LLC.
- *
- * Authors: Scott Shu
- *	    Anton Vorontsov <avorontsov@mvista.com>
- */
-
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/mmc/host.h>
-#include <linux/module.h>
-#include "sdhci-pltfm.h"
-
-static unsigned int sdhci_cns3xxx_get_max_clk(struct sdhci_host *host)
-{
-	return 150000000;
-}
-
-static void sdhci_cns3xxx_set_clock(struct sdhci_host *host, unsigned int clock)
-{
-	struct device *dev = mmc_dev(host->mmc);
-	int div = 1;
-	u16 clk;
-	unsigned long timeout;
-
-	host->mmc->actual_clock = 0;
-
-	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
-
-	if (clock == 0)
-		return;
-
-	while (host->max_clk / div > clock) {
-		/*
-		 * On CNS3xxx divider grows linearly up to 4, and then
-		 * exponentially up to 256.
-		 */
-		if (div < 4)
-			div += 1;
-		else if (div < 256)
-			div *= 2;
-		else
-			break;
-	}
-
-	dev_dbg(dev, "desired SD clock: %d, actual: %d\n",
-		clock, host->max_clk / div);
-
-	/* Divide by 3 is special. */
-	if (div != 3)
-		div >>= 1;
-
-	clk = div << SDHCI_DIVIDER_SHIFT;
-	clk |= SDHCI_CLOCK_INT_EN;
-	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
-	timeout = 20;
-	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
-			& SDHCI_CLOCK_INT_STABLE)) {
-		if (timeout == 0) {
-			dev_warn(dev, "clock is unstable");
-			break;
-		}
-		timeout--;
-		mdelay(1);
-	}
-
-	clk |= SDHCI_CLOCK_CARD_EN;
-	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-}
-
-static const struct sdhci_ops sdhci_cns3xxx_ops = {
-	.get_max_clock	= sdhci_cns3xxx_get_max_clk,
-	.set_clock	= sdhci_cns3xxx_set_clock,
-	.set_bus_width	= sdhci_set_bus_width,
-	.reset          = sdhci_reset,
-	.set_uhs_signaling = sdhci_set_uhs_signaling,
-};
-
-static const struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
-	.ops = &sdhci_cns3xxx_ops,
-	.quirks = SDHCI_QUIRK_BROKEN_DMA |
-		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
-		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
-		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
-		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
-};
-
-static int sdhci_cns3xxx_probe(struct platform_device *pdev)
-{
-	return sdhci_pltfm_register(pdev, &sdhci_cns3xxx_pdata, 0);
-}
-
-static struct platform_driver sdhci_cns3xxx_driver = {
-	.driver		= {
-		.name	= "sdhci-cns3xxx",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &sdhci_pltfm_pmops,
-	},
-	.probe		= sdhci_cns3xxx_probe,
-	.remove		= sdhci_pltfm_unregister,
-};
-
-module_platform_driver(sdhci_cns3xxx_driver);
-
-MODULE_DESCRIPTION("SDHCI driver for CNS3xxx");
-MODULE_AUTHOR("Scott Shu, "
-	      "Anton Vorontsov <avorontsov@mvista.com>");
-MODULE_LICENSE("GPL v2");
-- 
2.29.2

