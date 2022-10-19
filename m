Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B7F604B05
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiJSPRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiJSPRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:17:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4BD14409D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:09:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0DF4B824A5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC48C433C1;
        Wed, 19 Oct 2022 15:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666192083;
        bh=95MlQNM30vmfwNJFsblpQxVcyVh7sYL+rn6OLXApeOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXrG90nVSwcvr2gq5pXRK6RjII348ylQTrCTVeamFy7AnpXi4cBDLcWkyEgBAJeJ9
         8sKiNf/ITiCUletwrgC8Hxcgx2nPlO8yzfa7eth3zGVHgi/xsK+6E/QrmbYtW+SQLy
         F5AKd4+CvWb1Uu/q8vZf0M8Dp2RtctUC9EjbCeKoO/Sm7ITsTVAuVtXTjJkK39VYVW
         4Jjz0twFemiEOEFSzNoNtPQct+M/llMGJ5orDlO9rBQmFn/gKWPcBgW73TsLkNNSR6
         zdU82WqWumqzrEAY81f1a7ecwoREtXBGBjha5HvJHi8b7fRhZqSMH5zFgFZYlRmi05
         NwK7h3sw5mhYw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Hubert Feurstein <hubert.feurstein@contec.at>
Subject: [PATCH 04/17] ARM: ep93xx: remove old board files
Date:   Wed, 19 Oct 2022 17:03:26 +0200
Message-Id: <20221019150410.3851944-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019150410.3851944-1-arnd@kernel.org>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

These five board files were marked as unused a while ago, and
nobody wanted to keep them around for longer, so remove them
now.

We still have the edb93xx, visision_ep9307 and ts72xx files,
which can hopefully be converted to device tree in the future.

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Hubert Feurstein <hubert.feurstein@contec.at>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                            |  10 --
 arch/arm/boot/compressed/misc-ep93xx.h |  13 +-
 arch/arm/mach-ep93xx/Kconfig           |  63 ----------
 arch/arm/mach-ep93xx/Makefile          |   5 -
 arch/arm/mach-ep93xx/adssphere.c       |  41 -------
 arch/arm/mach-ep93xx/gesbc9312.c       |  41 -------
 arch/arm/mach-ep93xx/micro9.c          | 125 -------------------
 arch/arm/mach-ep93xx/simone.c          | 128 -------------------
 arch/arm/mach-ep93xx/snappercl15.c     | 162 -------------------------
 9 files changed, 1 insertion(+), 587 deletions(-)
 delete mode 100644 arch/arm/mach-ep93xx/adssphere.c
 delete mode 100644 arch/arm/mach-ep93xx/gesbc9312.c
 delete mode 100644 arch/arm/mach-ep93xx/micro9.c
 delete mode 100644 arch/arm/mach-ep93xx/simone.c
 delete mode 100644 arch/arm/mach-ep93xx/snappercl15.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 57b74156df3a..89f72dba8e64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1793,11 +1793,6 @@ F:	include/dt-bindings/reset/actions,*
 F:	include/linux/soc/actions/
 N:	owl
 
-ARM/ADS SPHERE MACHINE SUPPORT
-M:	Lennert Buytenhek <kernel@wantstofly.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-
 ARM/Allwinner SoC Clock Support
 M:	Emilio López <emilio@elopez.com.ar>
 S:	Maintained
@@ -2029,11 +2024,6 @@ S:	Maintained
 F:	arch/arm/boot/dts/cx92755*
 N:	digicolor
 
-ARM/CONTEC MICRO9 MACHINE SUPPORT
-M:	Hubert Feurstein <hubert.feurstein@contec.at>
-S:	Maintained
-F:	arch/arm/mach-ep93xx/micro9.c
-
 ARM/CORESIGHT FRAMEWORK AND DRIVERS
 M:	Mathieu Poirier <mathieu.poirier@linaro.org>
 M:	Suzuki K Poulose <suzuki.poulose@arm.com>
diff --git a/arch/arm/boot/compressed/misc-ep93xx.h b/arch/arm/boot/compressed/misc-ep93xx.h
index 3dc942589cba..65b4121d1490 100644
--- a/arch/arm/boot/compressed/misc-ep93xx.h
+++ b/arch/arm/boot/compressed/misc-ep93xx.h
@@ -57,8 +57,7 @@ static inline void ep93xx_decomp_setup(void)
 	if (machine_is_ts72xx())
 		ts72xx_watchdog_disable();
 
-	if (machine_is_adssphere() ||
-	    machine_is_edb9301() ||
+	if (machine_is_edb9301() ||
 	    machine_is_edb9302() ||
 	    machine_is_edb9302a() ||
 	    machine_is_edb9302a() ||
@@ -69,16 +68,6 @@ static inline void ep93xx_decomp_setup(void)
 	    machine_is_edb9315() ||
 	    machine_is_edb9315a() ||
 	    machine_is_edb9315a() ||
-	    machine_is_gesbc9312() ||
-	    machine_is_micro9() ||
-	    machine_is_micro9l() ||
-	    machine_is_micro9m() ||
-	    machine_is_micro9s() ||
-	    machine_is_micro9m() ||
-	    machine_is_micro9l() ||
-	    machine_is_micro9s() ||
-	    machine_is_sim_one() ||
-	    machine_is_snapper_cl15() ||
 	    machine_is_ts72xx() ||
 	    machine_is_bk3() ||
 	    machine_is_vision_ep9307())
diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 2c40996a444b..703f3d232a60 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -25,13 +25,6 @@ config EP93XX_SOC_COMMON
 
 comment "EP93xx Platforms"
 
-config MACH_ADSSPHERE
-	bool "Support ADS Sphere"
-	depends on UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the ADS
-	  Sphere board.
-
 config MACH_BK3
 	bool "Support Liebherr BK3.1"
 	select MACH_TS72XX
@@ -98,62 +91,6 @@ config MACH_EDB9315A
 	  Say 'Y' here if you want your kernel to support the Cirrus
 	  Logic EDB9315A Evaluation Board.
 
-config MACH_GESBC9312
-	bool "Support Glomation GESBC-9312-sx"
-	depends on UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the Glomation
-	  GESBC-9312-sx board.
-
-config MACH_MICRO9
-	bool
-
-config MACH_MICRO9H
-	bool "Support Contec Micro9-High"
-	select MACH_MICRO9
-	depends on UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Contec Micro9-High board.
-
-config MACH_MICRO9M
-	bool "Support Contec Micro9-Mid"
-	select MACH_MICRO9
-	depends on UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Contec Micro9-Mid board.
-
-config MACH_MICRO9L
-	bool "Support Contec Micro9-Lite"
-	select MACH_MICRO9
-	depends on UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Contec Micro9-Lite board.
-
-config MACH_MICRO9S
-	bool "Support Contec Micro9-Slim"
-	select MACH_MICRO9
-	depends on UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Contec Micro9-Slim board.
-
-config MACH_SIM_ONE
-        bool "Support Simplemachines Sim.One board"
-	depends on UNUSED_BOARD_FILES
-        help
-          Say 'Y' here if you want your kernel to support the
-          Simplemachines Sim.One board.
-
-config MACH_SNAPPER_CL15
-	bool "Support Bluewater Systems Snapper CL15 Module"
-	depends on UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the Bluewater
-	  Systems Snapper CL15 Module.
-
 config MACH_TS72XX
 	bool "Support Technologic Systems TS-72xx SBC"
 	help
diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
index cfad517fac46..62e37403df14 100644
--- a/arch/arm/mach-ep93xx/Makefile
+++ b/arch/arm/mach-ep93xx/Makefile
@@ -6,11 +6,6 @@ obj-y			:= core.o clock.o timer-ep93xx.o
 
 obj-$(CONFIG_EP93XX_DMA)	+= dma.o
 
-obj-$(CONFIG_MACH_ADSSPHERE)	+= adssphere.o
 obj-$(CONFIG_MACH_EDB93XX)	+= edb93xx.o
-obj-$(CONFIG_MACH_GESBC9312)	+= gesbc9312.o
-obj-$(CONFIG_MACH_MICRO9)	+= micro9.o
-obj-$(CONFIG_MACH_SIM_ONE)	+= simone.o
-obj-$(CONFIG_MACH_SNAPPER_CL15)	+= snappercl15.o
 obj-$(CONFIG_MACH_TS72XX)	+= ts72xx.o
 obj-$(CONFIG_MACH_VISION_EP9307)+= vision_ep9307.o
diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
deleted file mode 100644
index 0c48d3c5b8e7..000000000000
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ /dev/null
@@ -1,41 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * arch/arm/mach-ep93xx/adssphere.c
- * ADS Sphere support.
- *
- * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/sizes.h>
-
-#include "hardware.h"
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include "soc.h"
-
-static struct ep93xx_eth_data __initdata adssphere_eth_data = {
-	.phy_id		= 1,
-};
-
-static void __init adssphere_init_machine(void)
-{
-	ep93xx_init_devices();
-	ep93xx_register_flash(4, EP93XX_CS6_PHYS_BASE, SZ_32M);
-	ep93xx_register_eth(&adssphere_eth_data, 1);
-}
-
-MACHINE_START(ADSSPHERE, "ADS Sphere board")
-	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= NR_EP93XX_IRQS,
-	.map_io		= ep93xx_map_io,
-	.init_irq	= ep93xx_init_irq,
-	.init_time	= ep93xx_timer_init,
-	.init_machine	= adssphere_init_machine,
-	.restart	= ep93xx_restart,
-MACHINE_END
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
deleted file mode 100644
index 0b7043e3e178..000000000000
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ /dev/null
@@ -1,41 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * arch/arm/mach-ep93xx/gesbc9312.c
- * Glomation GESBC-9312-sx support.
- *
- * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/sizes.h>
-
-#include "hardware.h"
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include "soc.h"
-
-static struct ep93xx_eth_data __initdata gesbc9312_eth_data = {
-	.phy_id		= 1,
-};
-
-static void __init gesbc9312_init_machine(void)
-{
-	ep93xx_init_devices();
-	ep93xx_register_flash(4, EP93XX_CS6_PHYS_BASE, SZ_8M);
-	ep93xx_register_eth(&gesbc9312_eth_data, 0);
-}
-
-MACHINE_START(GESBC9312, "Glomation GESBC-9312-sx")
-	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= NR_EP93XX_IRQS,
-	.map_io		= ep93xx_map_io,
-	.init_irq	= ep93xx_init_irq,
-	.init_time	= ep93xx_timer_init,
-	.init_machine	= gesbc9312_init_machine,
-	.restart	= ep93xx_restart,
-MACHINE_END
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
deleted file mode 100644
index c121c459aa17..000000000000
--- a/arch/arm/mach-ep93xx/micro9.c
+++ /dev/null
@@ -1,125 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  linux/arch/arm/mach-ep93xx/micro9.c
- *
- * Copyright (C) 2006 Contec Steuerungstechnik & Automation GmbH
- *                    Manfred Gruber <m.gruber@tirol.com>
- * Copyright (C) 2009 Contec Steuerungstechnik & Automation GmbH
- *                    Hubert Feurstein <hubert.feurstein@contec.at>
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-
-#include "hardware.h"
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include "soc.h"
-
-/*************************************************************************
- * Micro9 NOR Flash
- *
- * Micro9-High has up to 64MB of 32-bit flash on CS1
- * Micro9-Mid has up to 64MB of either 32-bit or 16-bit flash on CS1
- * Micro9-Lite uses a separate MTD map driver for flash support
- * Micro9-Slim has up to 64MB of either 32-bit or 16-bit flash on CS1
- *************************************************************************/
-static unsigned int __init micro9_detect_bootwidth(void)
-{
-	u32 v;
-
-	/* Detect the bus width of the external flash memory */
-	v = __raw_readl(EP93XX_SYSCON_SYSCFG);
-	if (v & EP93XX_SYSCON_SYSCFG_LCSN7)
-		return 4; /* 32-bit */
-	else
-		return 2; /* 16-bit */
-}
-
-static void __init micro9_register_flash(void)
-{
-	unsigned int width;
-
-	if (machine_is_micro9())
-		width = 4;
-	else if (machine_is_micro9m() || machine_is_micro9s())
-		width = micro9_detect_bootwidth();
-	else
-		width = 0;
-
-	if (width)
-		ep93xx_register_flash(width, EP93XX_CS1_PHYS_BASE, SZ_64M);
-}
-
-
-/*************************************************************************
- * Micro9 Ethernet
- *************************************************************************/
-static struct ep93xx_eth_data __initdata micro9_eth_data = {
-	.phy_id		= 0x1f,
-};
-
-
-static void __init micro9_init_machine(void)
-{
-	ep93xx_init_devices();
-	ep93xx_register_eth(&micro9_eth_data, 1);
-	micro9_register_flash();
-}
-
-
-#ifdef CONFIG_MACH_MICRO9H
-MACHINE_START(MICRO9, "Contec Micro9-High")
-	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= NR_EP93XX_IRQS,
-	.map_io		= ep93xx_map_io,
-	.init_irq	= ep93xx_init_irq,
-	.init_time	= ep93xx_timer_init,
-	.init_machine	= micro9_init_machine,
-	.restart	= ep93xx_restart,
-MACHINE_END
-#endif
-
-#ifdef CONFIG_MACH_MICRO9M
-MACHINE_START(MICRO9M, "Contec Micro9-Mid")
-	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= NR_EP93XX_IRQS,
-	.map_io		= ep93xx_map_io,
-	.init_irq	= ep93xx_init_irq,
-	.init_time	= ep93xx_timer_init,
-	.init_machine	= micro9_init_machine,
-	.restart	= ep93xx_restart,
-MACHINE_END
-#endif
-
-#ifdef CONFIG_MACH_MICRO9L
-MACHINE_START(MICRO9L, "Contec Micro9-Lite")
-	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= NR_EP93XX_IRQS,
-	.map_io		= ep93xx_map_io,
-	.init_irq	= ep93xx_init_irq,
-	.init_time	= ep93xx_timer_init,
-	.init_machine	= micro9_init_machine,
-	.restart	= ep93xx_restart,
-MACHINE_END
-#endif
-
-#ifdef CONFIG_MACH_MICRO9S
-MACHINE_START(MICRO9S, "Contec Micro9-Slim")
-	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= NR_EP93XX_IRQS,
-	.map_io		= ep93xx_map_io,
-	.init_irq	= ep93xx_init_irq,
-	.init_time	= ep93xx_timer_init,
-	.init_machine	= micro9_init_machine,
-	.restart	= ep93xx_restart,
-MACHINE_END
-#endif
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
deleted file mode 100644
index 569e72413561..000000000000
--- a/arch/arm/mach-ep93xx/simone.c
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * arch/arm/mach-ep93xx/simone.c
- * Simplemachines Sim.One support.
- *
- * Copyright (C) 2010 Ryan Mallon
- *
- * Based on the 2.6.24.7 support:
- *   Copyright (C) 2009 Simplemachines
- *   MMC support by Peter Ivanov <ivanovp@gmail.com>, 2007
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/i2c.h>
-#include <linux/mmc/host.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/mmc_spi.h>
-#include <linux/platform_data/video-ep93xx.h>
-#include <linux/platform_data/spi-ep93xx.h>
-#include <linux/gpio.h>
-#include <linux/gpio/machine.h>
-
-#include "hardware.h"
-#include "gpio-ep93xx.h"
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include "soc.h"
-
-static struct ep93xx_eth_data __initdata simone_eth_data = {
-	.phy_id		= 1,
-};
-
-static struct ep93xxfb_mach_info __initdata simone_fb_info = {
-	.flags		= EP93XXFB_USE_SDCSN0 | EP93XXFB_PCLK_FALLING,
-};
-
-static struct mmc_spi_platform_data simone_mmc_spi_data = {
-	.detect_delay	= 500,
-	.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
-};
-
-static struct gpiod_lookup_table simone_mmc_spi_gpio_table = {
-	.dev_id = "mmc_spi.0", /* "mmc_spi" @ CS0 */
-	.table = {
-		/* Card detect */
-		GPIO_LOOKUP_IDX("A", 0, NULL, 0, GPIO_ACTIVE_LOW),
-		{ },
-	},
-};
-
-static struct spi_board_info simone_spi_devices[] __initdata = {
-	{
-		.modalias		= "mmc_spi",
-		.platform_data		= &simone_mmc_spi_data,
-		/*
-		 * We use 10 MHz even though the maximum is 3.7 MHz. The driver
-		 * will limit it automatically to max. frequency.
-		 */
-		.max_speed_hz		= 10 * 1000 * 1000,
-		.bus_num		= 0,
-		.chip_select		= 0,
-		.mode			= SPI_MODE_3,
-	},
-};
-
-/*
- * Up to v1.3, the Sim.One used SFRMOUT as SD card chip select, but this goes
- * low between multi-message command blocks. From v1.4, it uses a GPIO instead.
- * v1.3 parts will still work, since the signal on SFRMOUT is automatic.
- */
-static struct gpiod_lookup_table simone_spi_cs_gpio_table = {
-	.dev_id = "spi0",
-	.table = {
-		GPIO_LOOKUP("A", 1, "cs", GPIO_ACTIVE_LOW),
-		{ },
-	},
-};
-
-static struct ep93xx_spi_info simone_spi_info __initdata = {
-	.use_dma = 1,
-};
-
-static struct i2c_board_info __initdata simone_i2c_board_info[] = {
-	{
-		I2C_BOARD_INFO("ds1337", 0x68),
-	},
-};
-
-static struct platform_device simone_audio_device = {
-	.name		= "simone-audio",
-	.id		= -1,
-};
-
-static void __init simone_register_audio(void)
-{
-	ep93xx_register_ac97();
-	platform_device_register(&simone_audio_device);
-}
-
-static void __init simone_init_machine(void)
-{
-	ep93xx_init_devices();
-	ep93xx_register_flash(2, EP93XX_CS6_PHYS_BASE, SZ_8M);
-	ep93xx_register_eth(&simone_eth_data, 1);
-	ep93xx_register_fb(&simone_fb_info);
-	ep93xx_register_i2c(simone_i2c_board_info,
-			    ARRAY_SIZE(simone_i2c_board_info));
-	gpiod_add_lookup_table(&simone_mmc_spi_gpio_table);
-	gpiod_add_lookup_table(&simone_spi_cs_gpio_table);
-	ep93xx_register_spi(&simone_spi_info, simone_spi_devices,
-			    ARRAY_SIZE(simone_spi_devices));
-	simone_register_audio();
-}
-
-MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
-	/* Maintainer: Ryan Mallon */
-	.atag_offset	= 0x100,
-	.nr_irqs	= NR_EP93XX_IRQS,
-	.map_io		= ep93xx_map_io,
-	.init_irq	= ep93xx_init_irq,
-	.init_time	= ep93xx_timer_init,
-	.init_machine	= simone_init_machine,
-	.restart	= ep93xx_restart,
-MACHINE_END
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
deleted file mode 100644
index 1dfb725671b1..000000000000
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ /dev/null
@@ -1,162 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * arch/arm/mach-ep93xx/snappercl15.c
- * Bluewater Systems Snapper CL15 system module
- *
- * Copyright (C) 2009 Bluewater Systems Ltd
- * Author: Ryan Mallon
- *
- * NAND code adapted from driver by:
- *   Andre Renaud <andre@bluewatersys.com>
- *   James R. McKaskill
- */
-
-#include <linux/platform_device.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/i2c.h>
-#include <linux/fb.h>
-
-#include <linux/mtd/platnand.h>
-
-#include "hardware.h"
-#include <linux/platform_data/video-ep93xx.h>
-#include "gpio-ep93xx.h"
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include "soc.h"
-
-#define SNAPPERCL15_NAND_BASE	(EP93XX_CS7_PHYS_BASE + SZ_16M)
-
-#define SNAPPERCL15_NAND_WPN	(1 << 8)  /* Write protect (active low) */
-#define SNAPPERCL15_NAND_ALE	(1 << 9)  /* Address latch */
-#define SNAPPERCL15_NAND_CLE	(1 << 10) /* Command latch */
-#define SNAPPERCL15_NAND_CEN	(1 << 11) /* Chip enable (active low) */
-#define SNAPPERCL15_NAND_RDY	(1 << 14) /* Device ready */
-
-#define NAND_CTRL_ADDR(chip) 	(chip->legacy.IO_ADDR_W + 0x40)
-
-static void snappercl15_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
-				      unsigned int ctrl)
-{
-	static u16 nand_state = SNAPPERCL15_NAND_WPN;
-	u16 set;
-
-	if (ctrl & NAND_CTRL_CHANGE) {
-		set = SNAPPERCL15_NAND_CEN | SNAPPERCL15_NAND_WPN;
-
-		if (ctrl & NAND_NCE)
-			set &= ~SNAPPERCL15_NAND_CEN;
-		if (ctrl & NAND_CLE)
-			set |= SNAPPERCL15_NAND_CLE;
-		if (ctrl & NAND_ALE)
-			set |= SNAPPERCL15_NAND_ALE;
-
-		nand_state &= ~(SNAPPERCL15_NAND_CEN |
-				SNAPPERCL15_NAND_CLE |
-				SNAPPERCL15_NAND_ALE);
-		nand_state |= set;
-		__raw_writew(nand_state, NAND_CTRL_ADDR(chip));
-	}
-
-	if (cmd != NAND_CMD_NONE)
-		__raw_writew((cmd & 0xff) | nand_state,
-			     chip->legacy.IO_ADDR_W);
-}
-
-static int snappercl15_nand_dev_ready(struct nand_chip *chip)
-{
-	return !!(__raw_readw(NAND_CTRL_ADDR(chip)) & SNAPPERCL15_NAND_RDY);
-}
-
-static struct mtd_partition snappercl15_nand_parts[] = {
-	{
-		.name		= "Kernel",
-		.offset		= 0,
-		.size		= SZ_2M,
-	},
-	{
-		.name		= "Filesystem",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= MTDPART_SIZ_FULL,
-	},
-};
-
-static struct platform_nand_data snappercl15_nand_data = {
-	.chip = {
-		.nr_chips		= 1,
-		.partitions		= snappercl15_nand_parts,
-		.nr_partitions		= ARRAY_SIZE(snappercl15_nand_parts),
-		.chip_delay		= 25,
-	},
-	.ctrl = {
-		.dev_ready		= snappercl15_nand_dev_ready,
-		.cmd_ctrl		= snappercl15_nand_cmd_ctrl,
-	},
-};
-
-static struct resource snappercl15_nand_resource[] = {
-	{
-		.start		= SNAPPERCL15_NAND_BASE,
-		.end		= SNAPPERCL15_NAND_BASE + SZ_4K - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device snappercl15_nand_device = {
-	.name			= "gen_nand",
-	.id			= -1,
-	.dev.platform_data	= &snappercl15_nand_data,
-	.resource		= snappercl15_nand_resource,
-	.num_resources		= ARRAY_SIZE(snappercl15_nand_resource),
-};
-
-static struct ep93xx_eth_data __initdata snappercl15_eth_data = {
-	.phy_id			= 1,
-};
-
-static struct i2c_board_info __initdata snappercl15_i2c_data[] = {
-	{
-		/* Audio codec */
-		I2C_BOARD_INFO("tlv320aic23", 0x1a),
-	},
-};
-
-static struct ep93xxfb_mach_info __initdata snappercl15_fb_info = {
-};
-
-static struct platform_device snappercl15_audio_device = {
-	.name		= "snappercl15-audio",
-	.id		= -1,
-};
-
-static void __init snappercl15_register_audio(void)
-{
-	ep93xx_register_i2s();
-	platform_device_register(&snappercl15_audio_device);
-}
-
-static void __init snappercl15_init_machine(void)
-{
-	ep93xx_init_devices();
-	ep93xx_register_eth(&snappercl15_eth_data, 1);
-	ep93xx_register_i2c(snappercl15_i2c_data,
-			    ARRAY_SIZE(snappercl15_i2c_data));
-	ep93xx_register_fb(&snappercl15_fb_info);
-	snappercl15_register_audio();
-	platform_device_register(&snappercl15_nand_device);
-}
-
-MACHINE_START(SNAPPER_CL15, "Bluewater Systems Snapper CL15")
-	/* Maintainer: Ryan Mallon */
-	.atag_offset	= 0x100,
-	.nr_irqs	= NR_EP93XX_IRQS,
-	.map_io		= ep93xx_map_io,
-	.init_irq	= ep93xx_init_irq,
-	.init_time	= ep93xx_timer_init,
-	.init_machine	= snappercl15_init_machine,
-	.restart	= ep93xx_restart,
-MACHINE_END
-- 
2.29.2

