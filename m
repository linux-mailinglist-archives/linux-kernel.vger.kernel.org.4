Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E07604B10
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJSPTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiJSPS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:18:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592F31D5862
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 13C21CE227D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E078C433C1;
        Wed, 19 Oct 2022 15:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666192217;
        bh=3bz3ZJ7W3G70xB3Rbx04E4gW+0Cumc2wlNg08joku3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1N9wdr4v82PQ/U+dKiHdvkba4rPzJRwrpKUQn3ixtl+erVmf5wYsR04XguhAxDmU
         MBtzeyz0JsQqqc3UqbjWCG3l/H6jC+UNcgoPUeEcHhw74Lvar9KazBSpjDbQD1eRWM
         s8Ixdko53fTiCEC9RN/UAdiGqeUlnpR9OaO3+fbsSfaQBRLmGCyQDxpJDzV4KCvLYg
         D0b81rYxmAUxfeWjpj0UxRQRMZB/q+M/kX5BbwEgcxJo4SkLDDVkkmnVR8mGRltCF8
         QfMz9M45YS8BHObgmAhpnmQu+9O8WZweHWJUkJmaWE7N29gL8/P+qHNpNdrYaLvaPX
         qoCdPYHzuulew==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Imre Kaloz <kaloz@openwrt.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 07/17] ARM: orion: remove unused board files
Date:   Wed, 19 Oct 2022 17:03:29 +0200
Message-Id: <20221019150410.3851944-7-arnd@kernel.org>
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

As planned earlier, all board support that was marked unused can be
removed now after nobody explicitly asked for these to be kept.

In particular, all of the reference designs get removed now, as these
are not commonly used productively any more. Also, the machines that
were not supported by Debian or the Debian_on_Buffalo group because of
limitations with RAM size are gone.

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Imre Kaloz <kaloz@openwrt.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/mv78xx0_defconfig           |   2 -
 arch/arm/mach-dove/Kconfig                   |   8 -
 arch/arm/mach-dove/Makefile                  |   1 -
 arch/arm/mach-dove/dove-db-setup.c           | 101 -----
 arch/arm/mach-mv78xx0/Kconfig                |  14 -
 arch/arm/mach-mv78xx0/Makefile               |   2 -
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c     | 101 -----
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c   |  86 -----
 arch/arm/mach-orion5x/Kconfig                |  59 ---
 arch/arm/mach-orion5x/Makefile               |   8 -
 arch/arm/mach-orion5x/db88f5281-setup.c      | 376 -------------------
 arch/arm/mach-orion5x/ls_hgl-setup.c         | 275 --------------
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c | 172 ---------
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c  | 183 ---------
 arch/arm/mach-orion5x/rd88f5182-setup.c      | 288 --------------
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c | 120 ------
 arch/arm/mach-orion5x/wnr854t-setup.c        | 175 ---------
 arch/arm/mach-orion5x/wrt350n-v2-setup.c     | 263 -------------
 18 files changed, 2234 deletions(-)
 delete mode 100644 arch/arm/mach-dove/dove-db-setup.c
 delete mode 100644 arch/arm/mach-mv78xx0/db78x00-bp-setup.c
 delete mode 100644 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
 delete mode 100644 arch/arm/mach-orion5x/db88f5281-setup.c
 delete mode 100644 arch/arm/mach-orion5x/ls_hgl-setup.c
 delete mode 100644 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
 delete mode 100644 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
 delete mode 100644 arch/arm/mach-orion5x/rd88f5182-setup.c
 delete mode 100644 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
 delete mode 100644 arch/arm/mach-orion5x/wnr854t-setup.c
 delete mode 100644 arch/arm/mach-orion5x/wrt350n-v2-setup.c

diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index f02f29d3fecb..3a1088079514 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -11,8 +11,6 @@ CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V6 is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MV78XX0=y
-CONFIG_MACH_DB78X00_BP=y
-CONFIG_MACH_RD78X00_MASA=y
 CONFIG_MACH_TERASTATION_WXL=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
index 2252f465cafd..996888ffcfe7 100644
--- a/arch/arm/mach-dove/Kconfig
+++ b/arch/arm/mach-dove/Kconfig
@@ -18,14 +18,6 @@ if ARCH_DOVE
 config DOVE_LEGACY
 	bool
 
-config MACH_DOVE_DB
-	bool "Marvell DB-MV88AP510 Development Board"
-	select DOVE_LEGACY
-	select I2C_BOARDINFO if I2C
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell DB-MV88AP510 Development Board.
-
 config MACH_CM_A510
 	bool "CompuLab CM-A510 Board"
 	select DOVE_LEGACY
diff --git a/arch/arm/mach-dove/Makefile b/arch/arm/mach-dove/Makefile
index da373a5768ba..0d31390be069 100644
--- a/arch/arm/mach-dove/Makefile
+++ b/arch/arm/mach-dove/Makefile
@@ -4,5 +4,4 @@ ccflags-y := -I$(srctree)/arch/arm/plat-orion/include
 obj-y				+= common.o
 obj-$(CONFIG_DOVE_LEGACY)	+= irq.o mpp.o
 obj-$(CONFIG_PCI)		+= pcie.o
-obj-$(CONFIG_MACH_DOVE_DB)	+= dove-db-setup.o
 obj-$(CONFIG_MACH_CM_A510)	+= cm-a510.o
diff --git a/arch/arm/mach-dove/dove-db-setup.c b/arch/arm/mach-dove/dove-db-setup.c
deleted file mode 100644
index d5bf54040577..000000000000
--- a/arch/arm/mach-dove/dove-db-setup.c
+++ /dev/null
@@ -1,101 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * arch/arm/mach-dove/dove-db-setup.c
- *
- * Marvell DB-MV88AP510-BP Development Board Setup
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/irq.h>
-#include <linux/mtd/physmap.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/timer.h>
-#include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/i2c.h>
-#include <linux/pci.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/flash.h>
-#include <linux/gpio.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include "dove.h"
-#include "common.h"
-
-static struct mv643xx_eth_platform_data dove_db_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR_DEFAULT,
-};
-
-static struct mv_sata_platform_data dove_db_sata_data = {
-	.n_ports        = 1,
-};
-
-/*****************************************************************************
- * SPI Devices:
- * 	SPI0: 4M Flash ST-M25P32-VMF6P
- ****************************************************************************/
-static const struct flash_platform_data dove_db_spi_flash_data = {
-	.type		= "m25p64",
-};
-
-static struct spi_board_info __initdata dove_db_spi_flash_info[] = {
-	{
-		.modalias       = "m25p80",
-		.platform_data  = &dove_db_spi_flash_data,
-		.irq            = -1,
-		.max_speed_hz   = 20000000,
-		.bus_num        = 0,
-		.chip_select    = 0,
-	},
-};
-
-/*****************************************************************************
- * PCI
- ****************************************************************************/
-static int __init dove_db_pci_init(void)
-{
-	if (machine_is_dove_db())
-		dove_pcie_init(1, 1);
-
-	return 0;
-}
-
-subsys_initcall(dove_db_pci_init);
-
-/*****************************************************************************
- * Board Init
- ****************************************************************************/
-static void __init dove_db_init(void)
-{
-	/*
-	 * Basic Dove setup. Needs to be called early.
-	 */
-	dove_init();
-
-	dove_ge00_init(&dove_db_ge00_data);
-	dove_ehci0_init();
-	dove_ehci1_init();
-	dove_sata_init(&dove_db_sata_data);
-	dove_sdio0_init();
-	dove_sdio1_init();
-	dove_spi0_init();
-	dove_spi1_init();
-	dove_uart0_init();
-	dove_uart1_init();
-	dove_i2c_init();
-	spi_register_board_info(dove_db_spi_flash_info,
-				ARRAY_SIZE(dove_db_spi_flash_info));
-}
-
-MACHINE_START(DOVE_DB, "Marvell DB-MV88AP510-BP Development Board")
-	.atag_offset	= 0x100,
-	.nr_irqs	= DOVE_NR_IRQS,
-	.init_machine	= dove_db_init,
-	.map_io		= dove_map_io,
-	.init_early	= dove_init_early,
-	.init_irq	= dove_init_irq,
-	.init_time	= dove_timer_init,
-	.restart	= dove_restart,
-MACHINE_END
diff --git a/arch/arm/mach-mv78xx0/Kconfig b/arch/arm/mach-mv78xx0/Kconfig
index 0464b732ead4..9de3bbc09c3a 100644
--- a/arch/arm/mach-mv78xx0/Kconfig
+++ b/arch/arm/mach-mv78xx0/Kconfig
@@ -15,20 +15,6 @@ menuconfig ARCH_MV78XX0
 
 if ARCH_MV78XX0
 
-config MACH_DB78X00_BP
-	bool "Marvell DB-78x00-BP Development Board"
-	depends on UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell DB-78x00-BP Development Board.
-
-config MACH_RD78X00_MASA
-	bool "Marvell RD-78x00-mASA Reference Design"
-	depends on UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell RD-78x00-mASA Reference Design.
-
 config MACH_TERASTATION_WXL
 	bool "Buffalo WLX (Terastation Duo) NAS"
 	help
diff --git a/arch/arm/mach-mv78xx0/Makefile b/arch/arm/mach-mv78xx0/Makefile
index 50aff70065f2..ddee6ae501bb 100644
--- a/arch/arm/mach-mv78xx0/Makefile
+++ b/arch/arm/mach-mv78xx0/Makefile
@@ -2,6 +2,4 @@
 ccflags-y := -I$(srctree)/arch/arm/plat-orion/include
 
 obj-y				+= common.o mpp.o irq.o pcie.o
-obj-$(CONFIG_MACH_DB78X00_BP)	+= db78x00-bp-setup.o
-obj-$(CONFIG_MACH_RD78X00_MASA)	+= rd78x00-masa-setup.o
 obj-$(CONFIG_MACH_TERASTATION_WXL) += buffalo-wxl-setup.o
diff --git a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
deleted file mode 100644
index da633a33a0c1..000000000000
--- a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
+++ /dev/null
@@ -1,101 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * arch/arm/mach-mv78xx0/db78x00-bp-setup.c
- *
- * Marvell DB-78x00-BP Development Board Setup
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/ethtool.h>
-#include <linux/i2c.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include "mv78xx0.h"
-#include "common.h"
-
-static struct mv643xx_eth_platform_data db78x00_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
-static struct mv643xx_eth_platform_data db78x00_ge01_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(9),
-};
-
-static struct mv643xx_eth_platform_data db78x00_ge10_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(10),
-};
-
-static struct mv643xx_eth_platform_data db78x00_ge11_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(11),
-};
-
-static struct mv_sata_platform_data db78x00_sata_data = {
-	.n_ports	= 2,
-};
-
-static struct i2c_board_info __initdata db78x00_i2c_rtc = {
-	I2C_BOARD_INFO("ds1338", 0x68),
-};
-
-
-static void __init db78x00_init(void)
-{
-	/*
-	 * Basic MV78xx0 setup. Needs to be called early.
-	 */
-	mv78xx0_init();
-
-	/*
-	 * Partition on-chip peripherals between the two CPU cores.
-	 */
-	if (mv78xx0_core_index() == 0) {
-		mv78xx0_ehci0_init();
-		mv78xx0_ehci1_init();
-		mv78xx0_ehci2_init();
-		mv78xx0_ge00_init(&db78x00_ge00_data);
-		mv78xx0_ge01_init(&db78x00_ge01_data);
-		mv78xx0_ge10_init(&db78x00_ge10_data);
-		mv78xx0_ge11_init(&db78x00_ge11_data);
-		mv78xx0_sata_init(&db78x00_sata_data);
-		mv78xx0_uart0_init();
-		mv78xx0_uart2_init();
-		mv78xx0_i2c_init();
-		i2c_register_board_info(0, &db78x00_i2c_rtc, 1);
-	} else {
-		mv78xx0_uart1_init();
-		mv78xx0_uart3_init();
-	}
-}
-
-static int __init db78x00_pci_init(void)
-{
-	if (machine_is_db78x00_bp()) {
-		/*
-		 * Assign the x16 PCIe slot on the board to CPU core
-		 * #0, and let CPU core #1 have the four x1 slots.
-		 */
-		if (mv78xx0_core_index() == 0)
-			mv78xx0_pcie_init(0, 1);
-		else
-			mv78xx0_pcie_init(1, 0);
-	}
-
-	return 0;
-}
-subsys_initcall(db78x00_pci_init);
-
-MACHINE_START(DB78X00_BP, "Marvell DB-78x00-BP Development Board")
-	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= MV78XX0_NR_IRQS,
-	.init_machine	= db78x00_init,
-	.map_io		= mv78xx0_map_io,
-	.init_early	= mv78xx0_init_early,
-	.init_irq	= mv78xx0_init_irq,
-	.init_time	= mv78xx0_timer_init,
-	.restart	= mv78xx0_restart,
-MACHINE_END
diff --git a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
deleted file mode 100644
index 80ca8b1a81de..000000000000
--- a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
+++ /dev/null
@@ -1,86 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * arch/arm/mach-mv78x00/rd78x00-masa-setup.c
- *
- * Marvell RD-78x00-mASA Development Board Setup
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/ethtool.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include "mv78xx0.h"
-#include "common.h"
-
-static struct mv643xx_eth_platform_data rd78x00_masa_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
-static struct mv643xx_eth_platform_data rd78x00_masa_ge01_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(9),
-};
-
-static struct mv643xx_eth_platform_data rd78x00_masa_ge10_data = {
-};
-
-static struct mv643xx_eth_platform_data rd78x00_masa_ge11_data = {
-};
-
-static struct mv_sata_platform_data rd78x00_masa_sata_data = {
-	.n_ports	= 2,
-};
-
-static void __init rd78x00_masa_init(void)
-{
-	/*
-	 * Basic MV78x00 setup. Needs to be called early.
-	 */
-	mv78xx0_init();
-
-	/*
-	 * Partition on-chip peripherals between the two CPU cores.
-	 */
-	if (mv78xx0_core_index() == 0) {
-		mv78xx0_ehci0_init();
-		mv78xx0_ehci1_init();
-		mv78xx0_ge00_init(&rd78x00_masa_ge00_data);
-		mv78xx0_ge10_init(&rd78x00_masa_ge10_data);
-		mv78xx0_sata_init(&rd78x00_masa_sata_data);
-		mv78xx0_uart0_init();
-		mv78xx0_uart2_init();
-	} else {
-		mv78xx0_ehci2_init();
-		mv78xx0_ge01_init(&rd78x00_masa_ge01_data);
-		mv78xx0_ge11_init(&rd78x00_masa_ge11_data);
-		mv78xx0_uart1_init();
-		mv78xx0_uart3_init();
-	}
-}
-
-static int __init rd78x00_pci_init(void)
-{
-	/*
-	 * Assign all PCIe devices to CPU core #0.
-	 */
-	if (machine_is_rd78x00_masa() && mv78xx0_core_index() == 0)
-		mv78xx0_pcie_init(1, 1);
-
-	return 0;
-}
-subsys_initcall(rd78x00_pci_init);
-
-MACHINE_START(RD78X00_MASA, "Marvell RD-78x00-MASA Development Board")
-	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= MV78XX0_NR_IRQS,
-	.init_machine	= rd78x00_masa_init,
-	.map_io		= mv78xx0_map_io,
-	.init_early	= mv78xx0_init_early,
-	.init_irq	= mv78xx0_init_irq,
-	.init_time	= mv78xx0_timer_init,
-	.restart	= mv78xx0_restart,
-MACHINE_END
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 0044b2823710..ee449ca032d2 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -28,22 +28,6 @@ config ARCH_ORION5X_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Orion5x using flattened device tree.
 
-config MACH_DB88F5281
-	bool "Marvell Orion-2 Development Board"
-	select I2C_BOARDINFO if I2C
-	depends on ATAGS && UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell Orion-2 (88F5281) Development Board
-
-config MACH_RD88F5182
-	bool "Marvell Orion-NAS Reference Design"
-	select I2C_BOARDINFO if I2C
-	depends on ATAGS && UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell Orion-NAS (88F5182) RD2
-
 config MACH_RD88F5182_DT
 	bool "Marvell Orion-NAS Reference Design (Flattened Device Tree)"
 	select ARCH_ORION5X_DT
@@ -98,14 +82,6 @@ config MACH_LINKSTATION_MINI
 	  Say 'Y' here if you want your kernel to support the
 	  Buffalo Linkstation Mini (LS-WSGL) platform.
 
-config MACH_LINKSTATION_LS_HGL
-	bool "Buffalo Linkstation LS-HGL"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	select I2C_BOARDINFO if I2C
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Buffalo Linkstation LS-HGL platform.
-
 config MACH_TS409
 	bool "QNAP TS-409"
 	depends on ATAGS
@@ -113,13 +89,6 @@ config MACH_TS409
 	  Say 'Y' here if you want your kernel to support the
 	  QNAP TS-409 platform.
 
-config MACH_WRT350N_V2
-	bool "Linksys WRT350N v2"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Linksys WRT350N v2 platform.
-
 config MACH_TS78XX
 	bool "Technologic Systems TS-78xx"
 	depends on ATAGS
@@ -156,32 +125,4 @@ config MACH_MSS2_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Maxtor Shared Storage II platform.
 
-config MACH_WNR854T
-	bool "Netgear WNR854T"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Netgear WNR854T platform.
-
-config MACH_RD88F5181L_GE
-	bool "Marvell Orion-VoIP GE Reference Design"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell Orion-VoIP GE (88F5181L) RD.
-
-config MACH_RD88F5181L_FXO
-	bool "Marvell Orion-VoIP FXO Reference Design"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell Orion-VoIP FXO (88F5181L) RD.
-
-config MACH_RD88F6183AP_GE
-	bool "Marvell Orion-1-90 AP GE Reference Design"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell Orion-1-90 (88F6183) AP GE RD.
-
 endif
diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
index 572c3520f7fe..6f54d7fef27a 100644
--- a/arch/arm/mach-orion5x/Makefile
+++ b/arch/arm/mach-orion5x/Makefile
@@ -2,23 +2,15 @@
 ccflags-y := -I$(srctree)/arch/arm/plat-orion/include
 
 obj-y				+= common.o pci.o irq.o mpp.o
-obj-$(CONFIG_MACH_DB88F5281)	+= db88f5281-setup.o
-obj-$(CONFIG_MACH_RD88F5182)	+= rd88f5182-setup.o
 obj-$(CONFIG_MACH_KUROBOX_PRO)	+= kurobox_pro-setup.o
 obj-$(CONFIG_MACH_TERASTATION_PRO2)	+= terastation_pro2-setup.o
 obj-$(CONFIG_MACH_LINKSTATION_PRO) += kurobox_pro-setup.o
-obj-$(CONFIG_MACH_LINKSTATION_LS_HGL) += ls_hgl-setup.o
 obj-$(CONFIG_MACH_DNS323)	+= dns323-setup.o
 obj-$(CONFIG_MACH_TS209)	+= ts209-setup.o tsx09-common.o
 obj-$(CONFIG_MACH_TS409)	+= ts409-setup.o tsx09-common.o
-obj-$(CONFIG_MACH_WRT350N_V2)	+= wrt350n-v2-setup.o
 obj-$(CONFIG_MACH_TS78XX)	+= ts78xx-setup.o
 obj-$(CONFIG_MACH_MV2120)	+= mv2120-setup.o
 obj-$(CONFIG_MACH_NET2BIG)	+= net2big-setup.o
-obj-$(CONFIG_MACH_WNR854T)	+= wnr854t-setup.o
-obj-$(CONFIG_MACH_RD88F5181L_GE)	+= rd88f5181l-ge-setup.o
-obj-$(CONFIG_MACH_RD88F5181L_FXO)	+= rd88f5181l-fxo-setup.o
-obj-$(CONFIG_MACH_RD88F6183AP_GE)	+= rd88f6183ap-ge-setup.o
 
 obj-$(CONFIG_ARCH_ORION5X_DT)		+= board-dt.o
 obj-$(CONFIG_MACH_D2NET_DT)	+= board-d2net.o
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
deleted file mode 100644
index fe1a4cef1ba2..000000000000
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ /dev/null
@@ -1,376 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * arch/arm/mach-orion5x/db88f5281-setup.c
- *
- * Marvell Orion-2 Development Board Setup
- *
- * Maintainer: Tzachi Perelstein <tzachi@marvell.com>
- */
-#include <linux/gpio.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
-#include <linux/irq.h>
-#include <linux/mtd/physmap.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/timer.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/i2c.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/pci.h>
-#include <linux/platform_data/mtd-orion_nand.h>
-#include "common.h"
-#include "mpp.h"
-#include "orion5x.h"
-
-/*****************************************************************************
- * DB-88F5281 on board devices
- ****************************************************************************/
-
-/*
- * 512K NOR flash Device bus boot chip select
- */
-
-#define DB88F5281_NOR_BOOT_BASE		0xf4000000
-#define DB88F5281_NOR_BOOT_SIZE		SZ_512K
-
-/*
- * 7-Segment on Device bus chip select 0
- */
-
-#define DB88F5281_7SEG_BASE		0xfa000000
-#define DB88F5281_7SEG_SIZE		SZ_1K
-
-/*
- * 32M NOR flash on Device bus chip select 1
- */
-
-#define DB88F5281_NOR_BASE		0xfc000000
-#define DB88F5281_NOR_SIZE		SZ_32M
-
-/*
- * 32M NAND flash on Device bus chip select 2
- */
-
-#define DB88F5281_NAND_BASE		0xfa800000
-#define DB88F5281_NAND_SIZE		SZ_1K
-
-/*
- * PCI
- */
-
-#define DB88F5281_PCI_SLOT0_OFFS		7
-#define DB88F5281_PCI_SLOT0_IRQ_PIN		12
-#define DB88F5281_PCI_SLOT1_SLOT2_IRQ_PIN	13
-
-/*****************************************************************************
- * 512M NOR Flash on Device bus Boot CS
- ****************************************************************************/
-
-static struct physmap_flash_data db88f5281_boot_flash_data = {
-	.width		= 1,	/* 8 bit bus width */
-};
-
-static struct resource db88f5281_boot_flash_resource = {
-	.flags		= IORESOURCE_MEM,
-	.start		= DB88F5281_NOR_BOOT_BASE,
-	.end		= DB88F5281_NOR_BOOT_BASE + DB88F5281_NOR_BOOT_SIZE - 1,
-};
-
-static struct platform_device db88f5281_boot_flash = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &db88f5281_boot_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &db88f5281_boot_flash_resource,
-};
-
-/*****************************************************************************
- * 32M NOR Flash on Device bus CS1
- ****************************************************************************/
-
-static struct physmap_flash_data db88f5281_nor_flash_data = {
-	.width		= 4,	/* 32 bit bus width */
-};
-
-static struct resource db88f5281_nor_flash_resource = {
-	.flags		= IORESOURCE_MEM,
-	.start		= DB88F5281_NOR_BASE,
-	.end		= DB88F5281_NOR_BASE + DB88F5281_NOR_SIZE - 1,
-};
-
-static struct platform_device db88f5281_nor_flash = {
-	.name		= "physmap-flash",
-	.id		= 1,
-	.dev		= {
-		.platform_data	= &db88f5281_nor_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &db88f5281_nor_flash_resource,
-};
-
-/*****************************************************************************
- * 32M NAND Flash on Device bus CS2
- ****************************************************************************/
-
-static struct mtd_partition db88f5281_nand_parts[] = {
-	{
-		.name = "kernel",
-		.offset = 0,
-		.size = SZ_2M,
-	}, {
-		.name = "root",
-		.offset = SZ_2M,
-		.size = (SZ_16M - SZ_2M),
-	}, {
-		.name = "user",
-		.offset = SZ_16M,
-		.size = SZ_8M,
-	}, {
-		.name = "recovery",
-		.offset = (SZ_16M + SZ_8M),
-		.size = SZ_8M,
-	},
-};
-
-static struct resource db88f5281_nand_resource = {
-	.flags		= IORESOURCE_MEM,
-	.start		= DB88F5281_NAND_BASE,
-	.end		= DB88F5281_NAND_BASE + DB88F5281_NAND_SIZE - 1,
-};
-
-static struct orion_nand_data db88f5281_nand_data = {
-	.parts		= db88f5281_nand_parts,
-	.nr_parts	= ARRAY_SIZE(db88f5281_nand_parts),
-	.cle		= 0,
-	.ale		= 1,
-	.width		= 8,
-};
-
-static struct platform_device db88f5281_nand_flash = {
-	.name		= "orion_nand",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &db88f5281_nand_data,
-	},
-	.resource	= &db88f5281_nand_resource,
-	.num_resources	= 1,
-};
-
-/*****************************************************************************
- * 7-Segment on Device bus CS0
- * Dummy counter every 2 sec
- ****************************************************************************/
-
-static void __iomem *db88f5281_7seg;
-static struct timer_list db88f5281_timer;
-
-static void db88f5281_7seg_event(struct timer_list *unused)
-{
-	static int count = 0;
-	writel(0, db88f5281_7seg + (count << 4));
-	count = (count + 1) & 7;
-	mod_timer(&db88f5281_timer, jiffies + 2 * HZ);
-}
-
-static int __init db88f5281_7seg_init(void)
-{
-	if (machine_is_db88f5281()) {
-		db88f5281_7seg = ioremap(DB88F5281_7SEG_BASE,
-					DB88F5281_7SEG_SIZE);
-		if (!db88f5281_7seg) {
-			printk(KERN_ERR "Failed to ioremap db88f5281_7seg\n");
-			return -EIO;
-		}
-		timer_setup(&db88f5281_timer, db88f5281_7seg_event, 0);
-		mod_timer(&db88f5281_timer, jiffies + 2 * HZ);
-	}
-
-	return 0;
-}
-
-__initcall(db88f5281_7seg_init);
-
-/*****************************************************************************
- * PCI
- ****************************************************************************/
-
-static void __init db88f5281_pci_preinit(void)
-{
-	int pin;
-
-	/*
-	 * Configure PCI GPIO IRQ pins
-	 */
-	pin = DB88F5281_PCI_SLOT0_IRQ_PIN;
-	if (gpio_request(pin, "PCI Int1") == 0) {
-		if (gpio_direction_input(pin) == 0) {
-			irq_set_irq_type(gpio_to_irq(pin), IRQ_TYPE_LEVEL_LOW);
-		} else {
-			printk(KERN_ERR "db88f5281_pci_preinit failed to "
-					"set_irq_type pin %d\n", pin);
-			gpio_free(pin);
-		}
-	} else {
-		printk(KERN_ERR "db88f5281_pci_preinit failed to gpio_request %d\n", pin);
-	}
-
-	pin = DB88F5281_PCI_SLOT1_SLOT2_IRQ_PIN;
-	if (gpio_request(pin, "PCI Int2") == 0) {
-		if (gpio_direction_input(pin) == 0) {
-			irq_set_irq_type(gpio_to_irq(pin), IRQ_TYPE_LEVEL_LOW);
-		} else {
-			printk(KERN_ERR "db88f5281_pci_preinit failed "
-					"to set_irq_type pin %d\n", pin);
-			gpio_free(pin);
-		}
-	} else {
-		printk(KERN_ERR "db88f5281_pci_preinit failed to gpio_request %d\n", pin);
-	}
-}
-
-static int __init db88f5281_pci_map_irq(const struct pci_dev *dev, u8 slot,
-	u8 pin)
-{
-	int irq;
-
-	/*
-	 * Check for devices with hard-wired IRQs.
-	 */
-	irq = orion5x_pci_map_irq(dev, slot, pin);
-	if (irq != -1)
-		return irq;
-
-	/*
-	 * PCI IRQs are connected via GPIOs.
-	 */
-	switch (slot - DB88F5281_PCI_SLOT0_OFFS) {
-	case 0:
-		return gpio_to_irq(DB88F5281_PCI_SLOT0_IRQ_PIN);
-	case 1:
-	case 2:
-		return gpio_to_irq(DB88F5281_PCI_SLOT1_SLOT2_IRQ_PIN);
-	default:
-		return -1;
-	}
-}
-
-static struct hw_pci db88f5281_pci __initdata = {
-	.nr_controllers	= 2,
-	.preinit	= db88f5281_pci_preinit,
-	.setup		= orion5x_pci_sys_setup,
-	.scan		= orion5x_pci_sys_scan_bus,
-	.map_irq	= db88f5281_pci_map_irq,
-};
-
-static int __init db88f5281_pci_init(void)
-{
-	if (machine_is_db88f5281())
-		pci_common_init(&db88f5281_pci);
-
-	return 0;
-}
-
-subsys_initcall(db88f5281_pci_init);
-
-/*****************************************************************************
- * Ethernet
- ****************************************************************************/
-static struct mv643xx_eth_platform_data db88f5281_eth_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
-/*****************************************************************************
- * RTC DS1339 on I2C bus
- ****************************************************************************/
-static struct i2c_board_info __initdata db88f5281_i2c_rtc = {
-	I2C_BOARD_INFO("ds1339", 0x68),
-};
-
-/*****************************************************************************
- * General Setup
- ****************************************************************************/
-static unsigned int db88f5281_mpp_modes[] __initdata = {
-	MPP0_GPIO,		/* USB Over Current */
-	MPP1_GPIO,		/* USB Vbat input */
-	MPP2_PCI_ARB,		/* PCI_REQn[2] */
-	MPP3_PCI_ARB,		/* PCI_GNTn[2] */
-	MPP4_PCI_ARB,		/* PCI_REQn[3] */
-	MPP5_PCI_ARB,		/* PCI_GNTn[3] */
-	MPP6_GPIO,		/* JP0, CON17.2 */
-	MPP7_GPIO,		/* JP1, CON17.1 */
-	MPP8_GPIO,		/* JP2, CON11.2 */
-	MPP9_GPIO,		/* JP3, CON11.3 */
-	MPP10_GPIO,		/* RTC int */
-	MPP11_GPIO,		/* Baud Rate Generator */
-	MPP12_GPIO,		/* PCI int 1 */
-	MPP13_GPIO,		/* PCI int 2 */
-	MPP14_NAND,		/* NAND_REn[2] */
-	MPP15_NAND,		/* NAND_WEn[2] */
-	MPP16_UART,		/* UART1_RX */
-	MPP17_UART,		/* UART1_TX */
-	MPP18_UART,		/* UART1_CTSn */
-	MPP19_UART,		/* UART1_RTSn */
-	0,
-};
-
-static void __init db88f5281_init(void)
-{
-	/*
-	 * Basic Orion setup. Need to be called early.
-	 */
-	orion5x_init();
-
-	orion5x_mpp_conf(db88f5281_mpp_modes);
-	writel(0, MPP_DEV_CTRL);		/* DEV_D[31:16] */
-
-	/*
-	 * Configure peripherals.
-	 */
-	orion5x_ehci0_init();
-	orion5x_eth_init(&db88f5281_eth_data);
-	orion5x_i2c_init();
-	orion5x_uart0_init();
-	orion5x_uart1_init();
-
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
-				    ORION_MBUS_DEVBUS_BOOT_ATTR,
-				    DB88F5281_NOR_BOOT_BASE,
-				    DB88F5281_NOR_BOOT_SIZE);
-	platform_device_register(&db88f5281_boot_flash);
-
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_TARGET(0),
-				    ORION_MBUS_DEVBUS_ATTR(0),
-				    DB88F5281_7SEG_BASE,
-				    DB88F5281_7SEG_SIZE);
-
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_TARGET(1),
-				    ORION_MBUS_DEVBUS_ATTR(1),
-				    DB88F5281_NOR_BASE,
-				    DB88F5281_NOR_SIZE);
-	platform_device_register(&db88f5281_nor_flash);
-
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_TARGET(2),
-				    ORION_MBUS_DEVBUS_ATTR(2),
-				    DB88F5281_NAND_BASE,
-				    DB88F5281_NAND_SIZE);
-	platform_device_register(&db88f5281_nand_flash);
-
-	i2c_register_board_info(0, &db88f5281_i2c_rtc, 1);
-}
-
-MACHINE_START(DB88F5281, "Marvell Orion-2 Development Board")
-	/* Maintainer: Tzachi Perelstein <tzachi@marvell.com> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= ORION5X_NR_IRQS,
-	.init_machine	= db88f5281_init,
-	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_init_early,
-	.init_irq	= orion5x_init_irq,
-	.init_time	= orion5x_timer_init,
-	.restart	= orion5x_restart,
-MACHINE_END
diff --git a/arch/arm/mach-orion5x/ls_hgl-setup.c b/arch/arm/mach-orion5x/ls_hgl-setup.c
deleted file mode 100644
index af07f617465f..000000000000
--- a/arch/arm/mach-orion5x/ls_hgl-setup.c
+++ /dev/null
@@ -1,275 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * arch/arm/mach-orion5x/ls_hgl-setup.c
- *
- * Maintainer: Zhu Qingsen <zhuqs@cn.fujitsu.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/leds.h>
-#include <linux/gpio_keys.h>
-#include <linux/input.h>
-#include <linux/i2c.h>
-#include <linux/ata_platform.h>
-#include <linux/gpio.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include "common.h"
-#include "mpp.h"
-#include "orion5x.h"
-
-/*****************************************************************************
- * Linkstation LS-HGL Info
- ****************************************************************************/
-
-/*
- * 256K NOR flash Device bus boot chip select
- */
-
-#define LS_HGL_NOR_BOOT_BASE	0xf4000000
-#define LS_HGL_NOR_BOOT_SIZE	SZ_256K
-
-/*****************************************************************************
- * 256KB NOR Flash on BOOT Device
- ****************************************************************************/
-
-static struct physmap_flash_data ls_hgl_nor_flash_data = {
-	.width		= 1,
-};
-
-static struct resource ls_hgl_nor_flash_resource = {
-	.flags	= IORESOURCE_MEM,
-	.start	= LS_HGL_NOR_BOOT_BASE,
-	.end	= LS_HGL_NOR_BOOT_BASE + LS_HGL_NOR_BOOT_SIZE - 1,
-};
-
-static struct platform_device ls_hgl_nor_flash = {
-	.name			= "physmap-flash",
-	.id			= 0,
-	.dev		= {
-		.platform_data	= &ls_hgl_nor_flash_data,
-	},
-	.num_resources		= 1,
-	.resource		= &ls_hgl_nor_flash_resource,
-};
-
-/*****************************************************************************
- * Ethernet
- ****************************************************************************/
-
-static struct mv643xx_eth_platform_data ls_hgl_eth_data = {
-	.phy_addr	= 8,
-};
-
-/*****************************************************************************
- * RTC 5C372a on I2C bus
- ****************************************************************************/
-
-static struct i2c_board_info __initdata ls_hgl_i2c_rtc = {
-	I2C_BOARD_INFO("rs5c372a", 0x32),
-};
-
-/*****************************************************************************
- * LEDs attached to GPIO
- ****************************************************************************/
-
-#define LS_HGL_GPIO_LED_ALARM   2
-#define LS_HGL_GPIO_LED_INFO    3
-#define LS_HGL_GPIO_LED_FUNC    17
-#define LS_HGL_GPIO_LED_PWR     0
-
-
-static struct gpio_led ls_hgl_led_pins[] = {
-	{
-		.name	   = "alarm:red",
-		.gpio	   = LS_HGL_GPIO_LED_ALARM,
-		.active_low     = 1,
-	}, {
-		.name	   = "info:amber",
-		.gpio	   = LS_HGL_GPIO_LED_INFO,
-		.active_low     = 1,
-	}, {
-		.name	   = "func:blue:top",
-		.gpio	   = LS_HGL_GPIO_LED_FUNC,
-		.active_low     = 1,
-	}, {
-		.name	   = "power:blue:bottom",
-		.gpio	   = LS_HGL_GPIO_LED_PWR,
-	},
-};
-
-static struct gpio_led_platform_data ls_hgl_led_data = {
-	.leds	   = ls_hgl_led_pins,
-	.num_leds       = ARRAY_SIZE(ls_hgl_led_pins),
-};
-
-static struct platform_device ls_hgl_leds = {
-	.name   = "leds-gpio",
-	.id     = -1,
-	.dev    = {
-		.platform_data  = &ls_hgl_led_data,
-	},
-};
-
-/****************************************************************************
- * GPIO Attached Keys
- ****************************************************************************/
-#define LS_HGL_GPIO_KEY_FUNC       15
-#define LS_HGL_GPIO_KEY_POWER      8
-#define LS_HGL_GPIO_KEY_AUTOPOWER  10
-
-#define LS_HGL_SW_POWER     0x00
-#define LS_HGL_SW_AUTOPOWER 0x01
-
-static struct gpio_keys_button ls_hgl_buttons[] = {
-	{
-		.code	   = KEY_OPTION,
-		.gpio	   = LS_HGL_GPIO_KEY_FUNC,
-		.desc	   = "Function Button",
-		.active_low     = 1,
-	}, {
-		.type		= EV_SW,
-		.code	   = LS_HGL_SW_POWER,
-		.gpio	   = LS_HGL_GPIO_KEY_POWER,
-		.desc	   = "Power-on Switch",
-		.active_low     = 1,
-	}, {
-		.type		= EV_SW,
-		.code	   = LS_HGL_SW_AUTOPOWER,
-		.gpio	   = LS_HGL_GPIO_KEY_AUTOPOWER,
-		.desc	   = "Power-auto Switch",
-		.active_low     = 1,
-	},
-};
-
-static struct gpio_keys_platform_data ls_hgl_button_data = {
-	.buttons	= ls_hgl_buttons,
-	.nbuttons       = ARRAY_SIZE(ls_hgl_buttons),
-};
-
-static struct platform_device ls_hgl_button_device = {
-	.name	   = "gpio-keys",
-	.id	     = -1,
-	.num_resources  = 0,
-	.dev	    = {
-		.platform_data  = &ls_hgl_button_data,
-	},
-};
-
-
-/*****************************************************************************
- * SATA
- ****************************************************************************/
-static struct mv_sata_platform_data ls_hgl_sata_data = {
-	.n_ports	= 2,
-};
-
-
-/*****************************************************************************
- * Linkstation LS-HGL specific power off method: reboot
- ****************************************************************************/
-/*
- * On the Linkstation LS-HGL, the shutdown process is following:
- * - Userland monitors key events until the power switch goes to off position
- * - The board reboots
- * - U-boot starts and goes into an idle mode waiting for the user
- *   to move the switch to ON position
- */
-
-static void ls_hgl_power_off(void)
-{
-	orion5x_restart(REBOOT_HARD, NULL);
-}
-
-
-/*****************************************************************************
- * General Setup
- ****************************************************************************/
-
-#define LS_HGL_GPIO_USB_POWER	9
-#define LS_HGL_GPIO_AUTO_POWER	10
-#define LS_HGL_GPIO_POWER	    8
-
-#define LS_HGL_GPIO_HDD_POWER	1
-
-static unsigned int ls_hgl_mpp_modes[] __initdata = {
-	MPP0_GPIO, /* LED_PWR */
-	MPP1_GPIO, /* HDD_PWR */
-	MPP2_GPIO, /* LED_ALARM */
-	MPP3_GPIO, /* LED_INFO */
-	MPP4_UNUSED,
-	MPP5_UNUSED,
-	MPP6_GPIO, /* FAN_LCK */
-	MPP7_GPIO, /* INIT */
-	MPP8_GPIO, /* POWER */
-	MPP9_GPIO, /* USB_PWR */
-	MPP10_GPIO, /* AUTO_POWER */
-	MPP11_UNUSED, /* LED_ETH (dummy) */
-	MPP12_UNUSED,
-	MPP13_UNUSED,
-	MPP14_UNUSED,
-	MPP15_GPIO, /* FUNC */
-	MPP16_UNUSED,
-	MPP17_GPIO, /* LED_FUNC */
-	MPP18_UNUSED,
-	MPP19_UNUSED,
-	0,
-};
-
-static void __init ls_hgl_init(void)
-{
-	/*
-	 * Setup basic Orion functions. Need to be called early.
-	 */
-	orion5x_init();
-
-	orion5x_mpp_conf(ls_hgl_mpp_modes);
-
-	/*
-	 * Configure peripherals.
-	 */
-	orion5x_ehci0_init();
-	orion5x_ehci1_init();
-	orion5x_eth_init(&ls_hgl_eth_data);
-	orion5x_i2c_init();
-	orion5x_sata_init(&ls_hgl_sata_data);
-	orion5x_uart0_init();
-	orion5x_xor_init();
-
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
-				    ORION_MBUS_DEVBUS_BOOT_ATTR,
-				    LS_HGL_NOR_BOOT_BASE,
-				    LS_HGL_NOR_BOOT_SIZE);
-	platform_device_register(&ls_hgl_nor_flash);
-
-	platform_device_register(&ls_hgl_button_device);
-
-	platform_device_register(&ls_hgl_leds);
-
-	i2c_register_board_info(0, &ls_hgl_i2c_rtc, 1);
-
-	/* enable USB power */
-	gpio_set_value(LS_HGL_GPIO_USB_POWER, 1);
-
-	/* register power-off method */
-	pm_power_off = ls_hgl_power_off;
-
-	pr_info("%s: finished\n", __func__);
-}
-
-MACHINE_START(LINKSTATION_LS_HGL, "Buffalo Linkstation LS-HGL")
-	/* Maintainer: Zhu Qingsen <zhuqs@cn.fujistu.com> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= ORION5X_NR_IRQS,
-	.init_machine	= ls_hgl_init,
-	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_init_early,
-	.init_irq	= orion5x_init_irq,
-	.init_time	= orion5x_timer_init,
-	.fixup		= tag_fixup_mem32,
-	.restart	= orion5x_restart,
-MACHINE_END
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
deleted file mode 100644
index 432fc8357d9e..000000000000
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ /dev/null
@@ -1,172 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
- *
- * Marvell Orion-VoIP FXO Reference Design Setup
- */
-#include <linux/gpio.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
-#include <linux/irq.h>
-#include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/ethtool.h>
-#include <linux/platform_data/dsa.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/pci.h>
-#include "common.h"
-#include "mpp.h"
-#include "orion5x.h"
-
-/*****************************************************************************
- * RD-88F5181L FXO Info
- ****************************************************************************/
-/*
- * 8M NOR flash Device bus boot chip select
- */
-#define RD88F5181L_FXO_NOR_BOOT_BASE		0xff800000
-#define RD88F5181L_FXO_NOR_BOOT_SIZE		SZ_8M
-
-
-/*****************************************************************************
- * 8M NOR Flash on Device bus Boot chip select
- ****************************************************************************/
-static struct physmap_flash_data rd88f5181l_fxo_nor_boot_flash_data = {
-	.width		= 1,
-};
-
-static struct resource rd88f5181l_fxo_nor_boot_flash_resource = {
-	.flags		= IORESOURCE_MEM,
-	.start		= RD88F5181L_FXO_NOR_BOOT_BASE,
-	.end		= RD88F5181L_FXO_NOR_BOOT_BASE +
-			  RD88F5181L_FXO_NOR_BOOT_SIZE - 1,
-};
-
-static struct platform_device rd88f5181l_fxo_nor_boot_flash = {
-	.name			= "physmap-flash",
-	.id			= 0,
-	.dev		= {
-		.platform_data	= &rd88f5181l_fxo_nor_boot_flash_data,
-	},
-	.num_resources		= 1,
-	.resource		= &rd88f5181l_fxo_nor_boot_flash_resource,
-};
-
-
-/*****************************************************************************
- * General Setup
- ****************************************************************************/
-static unsigned int rd88f5181l_fxo_mpp_modes[] __initdata = {
-	MPP0_GPIO,		/* LED1 CardBus LED (front panel) */
-	MPP1_GPIO,		/* PCI_intA */
-	MPP2_GPIO,		/* Hard Reset / Factory Init*/
-	MPP3_GPIO,		/* FXS or DAA select */
-	MPP4_GPIO,		/* LED6 - phone LED (front panel) */
-	MPP5_GPIO,		/* LED5 - phone LED (front panel) */
-	MPP6_PCI_CLK,		/* CPU PCI refclk */
-	MPP7_PCI_CLK,		/* PCI/PCIe refclk */
-	MPP8_GPIO,		/* CardBus reset */
-	MPP9_GPIO,		/* GE_RXERR */
-	MPP10_GPIO,		/* LED2 MiniPCI LED (front panel) */
-	MPP11_GPIO,		/* Lifeline control */
-	MPP12_GIGE,		/* GE_TXD[4] */
-	MPP13_GIGE,		/* GE_TXD[5] */
-	MPP14_GIGE,		/* GE_TXD[6] */
-	MPP15_GIGE,		/* GE_TXD[7] */
-	MPP16_GIGE,		/* GE_RXD[4] */
-	MPP17_GIGE,		/* GE_RXD[5] */
-	MPP18_GIGE,		/* GE_RXD[6] */
-	MPP19_GIGE,		/* GE_RXD[7] */
-	0,
-};
-
-static struct mv643xx_eth_platform_data rd88f5181l_fxo_eth_data = {
-	.phy_addr	= MV643XX_ETH_PHY_NONE,
-	.speed		= SPEED_1000,
-	.duplex		= DUPLEX_FULL,
-};
-
-static struct dsa_chip_data rd88f5181l_fxo_switch_chip_data = {
-	.port_names[0]	= "lan2",
-	.port_names[1]	= "lan1",
-	.port_names[2]	= "wan",
-	.port_names[3]	= "cpu",
-	.port_names[5]	= "lan4",
-	.port_names[7]	= "lan3",
-};
-
-static void __init rd88f5181l_fxo_init(void)
-{
-	/*
-	 * Setup basic Orion functions. Need to be called early.
-	 */
-	orion5x_init();
-
-	orion5x_mpp_conf(rd88f5181l_fxo_mpp_modes);
-
-	/*
-	 * Configure peripherals.
-	 */
-	orion5x_ehci0_init();
-	orion5x_eth_init(&rd88f5181l_fxo_eth_data);
-	orion5x_eth_switch_init(&rd88f5181l_fxo_switch_chip_data);
-	orion5x_uart0_init();
-
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
-				    ORION_MBUS_DEVBUS_BOOT_ATTR,
-				    RD88F5181L_FXO_NOR_BOOT_BASE,
-				    RD88F5181L_FXO_NOR_BOOT_SIZE);
-	platform_device_register(&rd88f5181l_fxo_nor_boot_flash);
-}
-
-static int __init
-rd88f5181l_fxo_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	int irq;
-
-	/*
-	 * Check for devices with hard-wired IRQs.
-	 */
-	irq = orion5x_pci_map_irq(dev, slot, pin);
-	if (irq != -1)
-		return irq;
-
-	/*
-	 * Mini-PCI / Cardbus slot.
-	 */
-	return gpio_to_irq(1);
-}
-
-static struct hw_pci rd88f5181l_fxo_pci __initdata = {
-	.nr_controllers	= 2,
-	.setup		= orion5x_pci_sys_setup,
-	.scan		= orion5x_pci_sys_scan_bus,
-	.map_irq	= rd88f5181l_fxo_pci_map_irq,
-};
-
-static int __init rd88f5181l_fxo_pci_init(void)
-{
-	if (machine_is_rd88f5181l_fxo()) {
-		orion5x_pci_set_cardbus_mode();
-		pci_common_init(&rd88f5181l_fxo_pci);
-	}
-
-	return 0;
-}
-subsys_initcall(rd88f5181l_fxo_pci_init);
-
-MACHINE_START(RD88F5181L_FXO, "Marvell Orion-VoIP FXO Reference Design")
-	/* Maintainer: Nicolas Pitre <nico@marvell.com> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= ORION5X_NR_IRQS,
-	.init_machine	= rd88f5181l_fxo_init,
-	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_init_early,
-	.init_irq	= orion5x_init_irq,
-	.init_time	= orion5x_timer_init,
-	.fixup		= tag_fixup_mem32,
-	.restart	= orion5x_restart,
-MACHINE_END
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
deleted file mode 100644
index d4b1a9c3cd36..000000000000
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ /dev/null
@@ -1,183 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
- *
- * Marvell Orion-VoIP GE Reference Design Setup
- */
-#include <linux/gpio.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
-#include <linux/irq.h>
-#include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/ethtool.h>
-#include <linux/i2c.h>
-#include <linux/platform_data/dsa.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/pci.h>
-#include "common.h"
-#include "mpp.h"
-#include "orion5x.h"
-
-/*****************************************************************************
- * RD-88F5181L GE Info
- ****************************************************************************/
-/*
- * 16M NOR flash Device bus boot chip select
- */
-#define RD88F5181L_GE_NOR_BOOT_BASE		0xff000000
-#define RD88F5181L_GE_NOR_BOOT_SIZE		SZ_16M
-
-
-/*****************************************************************************
- * 16M NOR Flash on Device bus Boot chip select
- ****************************************************************************/
-static struct physmap_flash_data rd88f5181l_ge_nor_boot_flash_data = {
-	.width		= 1,
-};
-
-static struct resource rd88f5181l_ge_nor_boot_flash_resource = {
-	.flags		= IORESOURCE_MEM,
-	.start		= RD88F5181L_GE_NOR_BOOT_BASE,
-	.end		= RD88F5181L_GE_NOR_BOOT_BASE +
-			  RD88F5181L_GE_NOR_BOOT_SIZE - 1,
-};
-
-static struct platform_device rd88f5181l_ge_nor_boot_flash = {
-	.name			= "physmap-flash",
-	.id			= 0,
-	.dev		= {
-		.platform_data	= &rd88f5181l_ge_nor_boot_flash_data,
-	},
-	.num_resources		= 1,
-	.resource		= &rd88f5181l_ge_nor_boot_flash_resource,
-};
-
-
-/*****************************************************************************
- * General Setup
- ****************************************************************************/
-static unsigned int rd88f5181l_ge_mpp_modes[] __initdata = {
-	MPP0_GPIO,		/* LED1 */
-	MPP1_GPIO,		/* LED5 */
-	MPP2_GPIO,		/* LED4 */
-	MPP3_GPIO,		/* LED3 */
-	MPP4_GPIO,		/* PCI_intA */
-	MPP5_GPIO,		/* RTC interrupt */
-	MPP6_PCI_CLK,		/* CPU PCI refclk */
-	MPP7_PCI_CLK,		/* PCI/PCIe refclk */
-	MPP8_GPIO,		/* 88e6131 interrupt */
-	MPP9_GPIO,		/* GE_RXERR */
-	MPP10_GPIO,		/* PCI_intB */
-	MPP11_GPIO,		/* LED2 */
-	MPP12_GIGE,		/* GE_TXD[4] */
-	MPP13_GIGE,		/* GE_TXD[5] */
-	MPP14_GIGE,		/* GE_TXD[6] */
-	MPP15_GIGE,		/* GE_TXD[7] */
-	MPP16_GIGE,		/* GE_RXD[4] */
-	MPP17_GIGE,		/* GE_RXD[5] */
-	MPP18_GIGE,		/* GE_RXD[6] */
-	MPP19_GIGE,		/* GE_RXD[7] */
-	0,
-};
-
-static struct mv643xx_eth_platform_data rd88f5181l_ge_eth_data = {
-	.phy_addr	= MV643XX_ETH_PHY_NONE,
-	.speed		= SPEED_1000,
-	.duplex		= DUPLEX_FULL,
-};
-
-static struct dsa_chip_data rd88f5181l_ge_switch_chip_data = {
-	.port_names[0]	= "lan2",
-	.port_names[1]	= "lan1",
-	.port_names[2]	= "wan",
-	.port_names[3]	= "cpu",
-	.port_names[5]	= "lan4",
-	.port_names[7]	= "lan3",
-};
-
-static struct i2c_board_info __initdata rd88f5181l_ge_i2c_rtc = {
-	I2C_BOARD_INFO("ds1338", 0x68),
-};
-
-static void __init rd88f5181l_ge_init(void)
-{
-	/*
-	 * Setup basic Orion functions. Need to be called early.
-	 */
-	orion5x_init();
-
-	orion5x_mpp_conf(rd88f5181l_ge_mpp_modes);
-
-	/*
-	 * Configure peripherals.
-	 */
-	orion5x_ehci0_init();
-	orion5x_eth_init(&rd88f5181l_ge_eth_data);
-	orion5x_eth_switch_init(&rd88f5181l_ge_switch_chip_data);
-	orion5x_i2c_init();
-	orion5x_uart0_init();
-
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
-				    ORION_MBUS_DEVBUS_BOOT_ATTR,
-				    RD88F5181L_GE_NOR_BOOT_BASE,
-				    RD88F5181L_GE_NOR_BOOT_SIZE);
-	platform_device_register(&rd88f5181l_ge_nor_boot_flash);
-
-	i2c_register_board_info(0, &rd88f5181l_ge_i2c_rtc, 1);
-}
-
-static int __init
-rd88f5181l_ge_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	int irq;
-
-	/*
-	 * Check for devices with hard-wired IRQs.
-	 */
-	irq = orion5x_pci_map_irq(dev, slot, pin);
-	if (irq != -1)
-		return irq;
-
-	/*
-	 * Cardbus slot.
-	 */
-	if (pin == 1)
-		return gpio_to_irq(4);
-	else
-		return gpio_to_irq(10);
-}
-
-static struct hw_pci rd88f5181l_ge_pci __initdata = {
-	.nr_controllers	= 2,
-	.setup		= orion5x_pci_sys_setup,
-	.scan		= orion5x_pci_sys_scan_bus,
-	.map_irq	= rd88f5181l_ge_pci_map_irq,
-};
-
-static int __init rd88f5181l_ge_pci_init(void)
-{
-	if (machine_is_rd88f5181l_ge()) {
-		orion5x_pci_set_cardbus_mode();
-		pci_common_init(&rd88f5181l_ge_pci);
-	}
-
-	return 0;
-}
-subsys_initcall(rd88f5181l_ge_pci_init);
-
-MACHINE_START(RD88F5181L_GE, "Marvell Orion-VoIP GE Reference Design")
-	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= ORION5X_NR_IRQS,
-	.init_machine	= rd88f5181l_ge_init,
-	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_init_early,
-	.init_irq	= orion5x_init_irq,
-	.init_time	= orion5x_timer_init,
-	.fixup		= tag_fixup_mem32,
-	.restart	= orion5x_restart,
-MACHINE_END
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
deleted file mode 100644
index 6ffcfc6445e2..000000000000
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ /dev/null
@@ -1,288 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * arch/arm/mach-orion5x/rd88f5182-setup.c
- *
- * Marvell Orion-NAS Reference Design Setup
- *
- * Maintainer: Ronen Shitrit <rshitrit@marvell.com>
- */
-#include <linux/gpio.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
-#include <linux/irq.h>
-#include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/ata_platform.h>
-#include <linux/i2c.h>
-#include <linux/leds.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/pci.h>
-#include "common.h"
-#include "mpp.h"
-#include "orion5x.h"
-
-/*****************************************************************************
- * RD-88F5182 Info
- ****************************************************************************/
-
-/*
- * 512K NOR flash Device bus boot chip select
- */
-
-#define RD88F5182_NOR_BOOT_BASE		0xf4000000
-#define RD88F5182_NOR_BOOT_SIZE		SZ_512K
-
-/*
- * 16M NOR flash on Device bus chip select 1
- */
-
-#define RD88F5182_NOR_BASE		0xfc000000
-#define RD88F5182_NOR_SIZE		SZ_16M
-
-/*
- * PCI
- */
-
-#define RD88F5182_PCI_SLOT0_OFFS	7
-#define RD88F5182_PCI_SLOT0_IRQ_A_PIN	7
-#define RD88F5182_PCI_SLOT0_IRQ_B_PIN	6
-
-/*****************************************************************************
- * 16M NOR Flash on Device bus CS1
- ****************************************************************************/
-
-static struct physmap_flash_data rd88f5182_nor_flash_data = {
-	.width		= 1,
-};
-
-static struct resource rd88f5182_nor_flash_resource = {
-	.flags			= IORESOURCE_MEM,
-	.start			= RD88F5182_NOR_BASE,
-	.end			= RD88F5182_NOR_BASE + RD88F5182_NOR_SIZE - 1,
-};
-
-static struct platform_device rd88f5182_nor_flash = {
-	.name			= "physmap-flash",
-	.id			= 0,
-	.dev		= {
-		.platform_data	= &rd88f5182_nor_flash_data,
-	},
-	.num_resources		= 1,
-	.resource		= &rd88f5182_nor_flash_resource,
-};
-
-/*****************************************************************************
- * Use GPIO LED as CPU active indication
- ****************************************************************************/
-
-#define RD88F5182_GPIO_LED		0
-
-static struct gpio_led rd88f5182_gpio_led_pins[] = {
-	{
-		.name		= "rd88f5182:cpu",
-		.default_trigger = "cpu0",
-		.gpio		= RD88F5182_GPIO_LED,
-	},
-};
-
-static struct gpio_led_platform_data rd88f5182_gpio_led_data = {
-	.leds		= rd88f5182_gpio_led_pins,
-	.num_leds	= ARRAY_SIZE(rd88f5182_gpio_led_pins),
-};
-
-static struct platform_device rd88f5182_gpio_leds = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data = &rd88f5182_gpio_led_data,
-	},
-};
-
-/*****************************************************************************
- * PCI
- ****************************************************************************/
-
-static void __init rd88f5182_pci_preinit(void)
-{
-	int pin;
-
-	/*
-	 * Configure PCI GPIO IRQ pins
-	 */
-	pin = RD88F5182_PCI_SLOT0_IRQ_A_PIN;
-	if (gpio_request(pin, "PCI IntA") == 0) {
-		if (gpio_direction_input(pin) == 0) {
-			irq_set_irq_type(gpio_to_irq(pin), IRQ_TYPE_LEVEL_LOW);
-		} else {
-			printk(KERN_ERR "rd88f5182_pci_preinit failed to "
-					"set_irq_type pin %d\n", pin);
-			gpio_free(pin);
-		}
-	} else {
-		printk(KERN_ERR "rd88f5182_pci_preinit failed to request gpio %d\n", pin);
-	}
-
-	pin = RD88F5182_PCI_SLOT0_IRQ_B_PIN;
-	if (gpio_request(pin, "PCI IntB") == 0) {
-		if (gpio_direction_input(pin) == 0) {
-			irq_set_irq_type(gpio_to_irq(pin), IRQ_TYPE_LEVEL_LOW);
-		} else {
-			printk(KERN_ERR "rd88f5182_pci_preinit failed to "
-					"set_irq_type pin %d\n", pin);
-			gpio_free(pin);
-		}
-	} else {
-		printk(KERN_ERR "rd88f5182_pci_preinit failed to gpio_request %d\n", pin);
-	}
-}
-
-static int __init rd88f5182_pci_map_irq(const struct pci_dev *dev, u8 slot,
-	u8 pin)
-{
-	int irq;
-
-	/*
-	 * Check for devices with hard-wired IRQs.
-	 */
-	irq = orion5x_pci_map_irq(dev, slot, pin);
-	if (irq != -1)
-		return irq;
-
-	/*
-	 * PCI IRQs are connected via GPIOs
-	 */
-	switch (slot - RD88F5182_PCI_SLOT0_OFFS) {
-	case 0:
-		if (pin == 1)
-			return gpio_to_irq(RD88F5182_PCI_SLOT0_IRQ_A_PIN);
-		else
-			return gpio_to_irq(RD88F5182_PCI_SLOT0_IRQ_B_PIN);
-	default:
-		return -1;
-	}
-}
-
-static struct hw_pci rd88f5182_pci __initdata = {
-	.nr_controllers	= 2,
-	.preinit	= rd88f5182_pci_preinit,
-	.setup		= orion5x_pci_sys_setup,
-	.scan		= orion5x_pci_sys_scan_bus,
-	.map_irq	= rd88f5182_pci_map_irq,
-};
-
-static int __init rd88f5182_pci_init(void)
-{
-	if (machine_is_rd88f5182())
-		pci_common_init(&rd88f5182_pci);
-
-	return 0;
-}
-
-subsys_initcall(rd88f5182_pci_init);
-
-/*****************************************************************************
- * Ethernet
- ****************************************************************************/
-
-static struct mv643xx_eth_platform_data rd88f5182_eth_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
-/*****************************************************************************
- * RTC DS1338 on I2C bus
- ****************************************************************************/
-static struct i2c_board_info __initdata rd88f5182_i2c_rtc = {
-	I2C_BOARD_INFO("ds1338", 0x68),
-};
-
-/*****************************************************************************
- * Sata
- ****************************************************************************/
-static struct mv_sata_platform_data rd88f5182_sata_data = {
-	.n_ports	= 2,
-};
-
-/*****************************************************************************
- * General Setup
- ****************************************************************************/
-static unsigned int rd88f5182_mpp_modes[] __initdata = {
-	MPP0_GPIO,		/* Debug Led */
-	MPP1_GPIO,		/* Reset Switch */
-	MPP2_UNUSED,
-	MPP3_GPIO,		/* RTC Int */
-	MPP4_GPIO,
-	MPP5_GPIO,
-	MPP6_GPIO,		/* PCI_intA */
-	MPP7_GPIO,		/* PCI_intB */
-	MPP8_UNUSED,
-	MPP9_UNUSED,
-	MPP10_UNUSED,
-	MPP11_UNUSED,
-	MPP12_SATA_LED,		/* SATA 0 presence */
-	MPP13_SATA_LED,		/* SATA 1 presence */
-	MPP14_SATA_LED,		/* SATA 0 active */
-	MPP15_SATA_LED,		/* SATA 1 active */
-	MPP16_UNUSED,
-	MPP17_UNUSED,
-	MPP18_UNUSED,
-	MPP19_UNUSED,
-	0,
-};
-
-static void __init rd88f5182_init(void)
-{
-	/*
-	 * Setup basic Orion functions. Need to be called early.
-	 */
-	orion5x_init();
-
-	orion5x_mpp_conf(rd88f5182_mpp_modes);
-
-	/*
-	 * MPP[20] PCI Clock to MV88F5182
-	 * MPP[21] PCI Clock to mini PCI CON11
-	 * MPP[22] USB 0 over current indication
-	 * MPP[23] USB 1 over current indication
-	 * MPP[24] USB 1 over current enable
-	 * MPP[25] USB 0 over current enable
-	 */
-
-	/*
-	 * Configure peripherals.
-	 */
-	orion5x_ehci0_init();
-	orion5x_ehci1_init();
-	orion5x_eth_init(&rd88f5182_eth_data);
-	orion5x_i2c_init();
-	orion5x_sata_init(&rd88f5182_sata_data);
-	orion5x_uart0_init();
-	orion5x_xor_init();
-
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
-				    ORION_MBUS_DEVBUS_BOOT_ATTR,
-				    RD88F5182_NOR_BOOT_BASE,
-				    RD88F5182_NOR_BOOT_SIZE);
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_TARGET(1),
-				    ORION_MBUS_DEVBUS_ATTR(1),
-				    RD88F5182_NOR_BASE,
-				    RD88F5182_NOR_SIZE);
-	platform_device_register(&rd88f5182_nor_flash);
-	platform_device_register(&rd88f5182_gpio_leds);
-
-	i2c_register_board_info(0, &rd88f5182_i2c_rtc, 1);
-}
-
-MACHINE_START(RD88F5182, "Marvell Orion-NAS Reference Design")
-	/* Maintainer: Ronen Shitrit <rshitrit@marvell.com> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= ORION5X_NR_IRQS,
-	.init_machine	= rd88f5182_init,
-	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_init_early,
-	.init_irq	= orion5x_init_irq,
-	.init_time	= orion5x_timer_init,
-	.restart	= orion5x_restart,
-MACHINE_END
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
deleted file mode 100644
index 93f74fd6b4da..000000000000
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ /dev/null
@@ -1,120 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * arch/arm/mach-orion5x/rd88f6183-ap-ge-setup.c
- *
- * Marvell Orion-1-90 AP GE Reference Design Setup
- */
-#include <linux/gpio.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
-#include <linux/irq.h>
-#include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/flash.h>
-#include <linux/ethtool.h>
-#include <linux/platform_data/dsa.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/pci.h>
-#include "common.h"
-#include "orion5x.h"
-
-static struct mv643xx_eth_platform_data rd88f6183ap_ge_eth_data = {
-	.phy_addr	= -1,
-	.speed		= SPEED_1000,
-	.duplex		= DUPLEX_FULL,
-};
-
-static struct dsa_chip_data rd88f6183ap_ge_switch_chip_data = {
-	.port_names[0]	= "lan1",
-	.port_names[1]	= "lan2",
-	.port_names[2]	= "lan3",
-	.port_names[3]	= "lan4",
-	.port_names[4]	= "wan",
-	.port_names[5]	= "cpu",
-};
-
-static struct mtd_partition rd88f6183ap_ge_partitions[] = {
-	{
-		.name	= "kernel",
-		.offset	= 0x00000000,
-		.size	= 0x00200000,
-	}, {
-		.name	= "rootfs",
-		.offset	= 0x00200000,
-		.size	= 0x00500000,
-	}, {
-		.name	= "nvram",
-		.offset	= 0x00700000,
-		.size	= 0x00080000,
-	},
-};
-
-static struct flash_platform_data rd88f6183ap_ge_spi_slave_data = {
-	.type		= "m25p64",
-	.nr_parts	= ARRAY_SIZE(rd88f6183ap_ge_partitions),
-	.parts		= rd88f6183ap_ge_partitions,
-};
-
-static struct spi_board_info __initdata rd88f6183ap_ge_spi_slave_info[] = {
-	{
-		.modalias	= "m25p80",
-		.platform_data	= &rd88f6183ap_ge_spi_slave_data,
-		.max_speed_hz	= 20000000,
-		.bus_num	= 0,
-		.chip_select	= 0,
-	},
-};
-
-static void __init rd88f6183ap_ge_init(void)
-{
-	/*
-	 * Setup basic Orion functions. Need to be called early.
-	 */
-	orion5x_init();
-
-	/*
-	 * Configure peripherals.
-	 */
-	orion5x_ehci0_init();
-	orion5x_eth_init(&rd88f6183ap_ge_eth_data);
-	orion5x_eth_switch_init(&rd88f6183ap_ge_switch_chip_data);
-	spi_register_board_info(rd88f6183ap_ge_spi_slave_info,
-				ARRAY_SIZE(rd88f6183ap_ge_spi_slave_info));
-	orion5x_spi_init();
-	orion5x_uart0_init();
-}
-
-static struct hw_pci rd88f6183ap_ge_pci __initdata = {
-	.nr_controllers	= 2,
-	.setup		= orion5x_pci_sys_setup,
-	.scan		= orion5x_pci_sys_scan_bus,
-	.map_irq	= orion5x_pci_map_irq,
-};
-
-static int __init rd88f6183ap_ge_pci_init(void)
-{
-	if (machine_is_rd88f6183ap_ge()) {
-		orion5x_pci_disable();
-		pci_common_init(&rd88f6183ap_ge_pci);
-	}
-
-	return 0;
-}
-subsys_initcall(rd88f6183ap_ge_pci_init);
-
-MACHINE_START(RD88F6183AP_GE, "Marvell Orion-1-90 AP GE Reference Design")
-	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= ORION5X_NR_IRQS,
-	.init_machine	= rd88f6183ap_ge_init,
-	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_init_early,
-	.init_irq	= orion5x_init_irq,
-	.init_time	= orion5x_timer_init,
-	.fixup		= tag_fixup_mem32,
-	.restart	= orion5x_restart,
-MACHINE_END
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
deleted file mode 100644
index e5f327054dd3..000000000000
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ /dev/null
@@ -1,175 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-// arch/arm/mach-orion5x/wnr854t-setup.c
-#include <linux/gpio.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
-#include <linux/irq.h>
-#include <linux/delay.h>
-#include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/ethtool.h>
-#include <linux/platform_data/dsa.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/pci.h>
-#include "orion5x.h"
-#include "common.h"
-#include "mpp.h"
-
-static unsigned int wnr854t_mpp_modes[] __initdata = {
-	MPP0_GPIO,		/* Power LED green (0=on) */
-	MPP1_GPIO,		/* Reset Button (0=off) */
-	MPP2_GPIO,		/* Power LED blink (0=off) */
-	MPP3_GPIO,		/* WAN Status LED amber (0=off) */
-	MPP4_GPIO,		/* PCI int */
-	MPP5_GPIO,		/* ??? */
-	MPP6_GPIO,		/* ??? */
-	MPP7_GPIO,		/* ??? */
-	MPP8_UNUSED,		/* ??? */
-	MPP9_GIGE,		/* GE_RXERR */
-	MPP10_UNUSED,		/* ??? */
-	MPP11_UNUSED,		/* ??? */
-	MPP12_GIGE,		/* GE_TXD[4] */
-	MPP13_GIGE,		/* GE_TXD[5] */
-	MPP14_GIGE,		/* GE_TXD[6] */
-	MPP15_GIGE,		/* GE_TXD[7] */
-	MPP16_GIGE,		/* GE_RXD[4] */
-	MPP17_GIGE,		/* GE_RXD[5] */
-	MPP18_GIGE,		/* GE_RXD[6] */
-	MPP19_GIGE,		/* GE_RXD[7] */
-	0,
-};
-
-/*
- * 8M NOR flash Device bus boot chip select
- */
-#define WNR854T_NOR_BOOT_BASE	0xf4000000
-#define WNR854T_NOR_BOOT_SIZE	SZ_8M
-
-static struct mtd_partition wnr854t_nor_flash_partitions[] = {
-	{
-		.name		= "kernel",
-		.offset		= 0x00000000,
-		.size		= 0x00100000,
-	}, {
-		.name		= "rootfs",
-		.offset		= 0x00100000,
-		.size		= 0x00660000,
-	}, {
-		.name		= "uboot",
-		.offset		= 0x00760000,
-		.size		= 0x00040000,
-	},
-};
-
-static struct physmap_flash_data wnr854t_nor_flash_data = {
-	.width		= 2,
-	.parts		= wnr854t_nor_flash_partitions,
-	.nr_parts	= ARRAY_SIZE(wnr854t_nor_flash_partitions),
-};
-
-static struct resource wnr854t_nor_flash_resource = {
-	.flags		= IORESOURCE_MEM,
-	.start		= WNR854T_NOR_BOOT_BASE,
-	.end		= WNR854T_NOR_BOOT_BASE + WNR854T_NOR_BOOT_SIZE - 1,
-};
-
-static struct platform_device wnr854t_nor_flash = {
-	.name			= "physmap-flash",
-	.id			= 0,
-	.dev		= {
-		.platform_data	= &wnr854t_nor_flash_data,
-	},
-	.num_resources		= 1,
-	.resource		= &wnr854t_nor_flash_resource,
-};
-
-static struct mv643xx_eth_platform_data wnr854t_eth_data = {
-	.phy_addr	= MV643XX_ETH_PHY_NONE,
-	.speed		= SPEED_1000,
-	.duplex		= DUPLEX_FULL,
-};
-
-static struct dsa_chip_data wnr854t_switch_chip_data = {
-	.port_names[0] = "lan3",
-	.port_names[1] = "lan4",
-	.port_names[2] = "wan",
-	.port_names[3] = "cpu",
-	.port_names[5] = "lan1",
-	.port_names[7] = "lan2",
-};
-
-static void __init wnr854t_init(void)
-{
-	/*
-	 * Setup basic Orion functions. Need to be called early.
-	 */
-	orion5x_init();
-
-	orion5x_mpp_conf(wnr854t_mpp_modes);
-
-	/*
-	 * Configure peripherals.
-	 */
-	orion5x_eth_init(&wnr854t_eth_data);
-	orion5x_eth_switch_init(&wnr854t_switch_chip_data);
-	orion5x_uart0_init();
-
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
-				    ORION_MBUS_DEVBUS_BOOT_ATTR,
-				    WNR854T_NOR_BOOT_BASE,
-				    WNR854T_NOR_BOOT_SIZE);
-	platform_device_register(&wnr854t_nor_flash);
-}
-
-static int __init wnr854t_pci_map_irq(const struct pci_dev *dev, u8 slot,
-	u8 pin)
-{
-	int irq;
-
-	/*
-	 * Check for devices with hard-wired IRQs.
-	 */
-	irq = orion5x_pci_map_irq(dev, slot, pin);
-	if (irq != -1)
-		return irq;
-
-	/*
-	 * Mini-PCI slot.
-	 */
-	if (slot == 7)
-		return gpio_to_irq(4);
-
-	return -1;
-}
-
-static struct hw_pci wnr854t_pci __initdata = {
-	.nr_controllers	= 2,
-	.setup		= orion5x_pci_sys_setup,
-	.scan		= orion5x_pci_sys_scan_bus,
-	.map_irq	= wnr854t_pci_map_irq,
-};
-
-static int __init wnr854t_pci_init(void)
-{
-	if (machine_is_wnr854t())
-		pci_common_init(&wnr854t_pci);
-
-	return 0;
-}
-subsys_initcall(wnr854t_pci_init);
-
-MACHINE_START(WNR854T, "Netgear WNR854T")
-	/* Maintainer: Imre Kaloz <kaloz@openwrt.org> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= ORION5X_NR_IRQS,
-	.init_machine	= wnr854t_init,
-	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_init_early,
-	.init_irq	= orion5x_init_irq,
-	.init_time	= orion5x_timer_init,
-	.fixup		= tag_fixup_mem32,
-	.restart	= orion5x_restart,
-MACHINE_END
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
deleted file mode 100644
index e6a2da6662df..000000000000
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ /dev/null
@@ -1,263 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-// arch/arm/mach-orion5x/wrt350n-v2-setup.c
-#include <linux/gpio.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
-#include <linux/irq.h>
-#include <linux/delay.h>
-#include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/ethtool.h>
-#include <linux/leds.h>
-#include <linux/gpio_keys.h>
-#include <linux/input.h>
-#include <linux/platform_data/dsa.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/pci.h>
-#include "orion5x.h"
-#include "common.h"
-#include "mpp.h"
-
-/*
- * LEDs attached to GPIO
- */
-static struct gpio_led wrt350n_v2_led_pins[] = {
-	{
-		.name		= "wrt350nv2:green:power",
-		.gpio		= 0,
-		.active_low	= 1,
-	}, {
-		.name		= "wrt350nv2:green:security",
-		.gpio		= 1,
-		.active_low	= 1,
-	}, {
-		.name		= "wrt350nv2:orange:power",
-		.gpio		= 5,
-		.active_low	= 1,
-	}, {
-		.name		= "wrt350nv2:green:usb",
-		.gpio		= 6,
-		.active_low	= 1,
-	}, {
-		.name		= "wrt350nv2:green:wireless",
-		.gpio		= 7,
-		.active_low	= 1,
-	},
-};
-
-static struct gpio_led_platform_data wrt350n_v2_led_data = {
-	.leds		= wrt350n_v2_led_pins,
-	.num_leds	= ARRAY_SIZE(wrt350n_v2_led_pins),
-};
-
-static struct platform_device wrt350n_v2_leds = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &wrt350n_v2_led_data,
-	},
-};
-
-/*
- * Buttons attached to GPIO
- */
-static struct gpio_keys_button wrt350n_v2_buttons[] = {
-	{
-		.code		= KEY_RESTART,
-		.gpio		= 3,
-		.desc		= "Reset Button",
-		.active_low	= 1,
-	}, {
-		.code		= KEY_WPS_BUTTON,
-		.gpio		= 2,
-		.desc		= "WPS Button",
-		.active_low	= 1,
-	},
-};
-
-static struct gpio_keys_platform_data wrt350n_v2_button_data = {
-	.buttons	= wrt350n_v2_buttons,
-	.nbuttons	= ARRAY_SIZE(wrt350n_v2_buttons),
-};
-
-static struct platform_device wrt350n_v2_button_device = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.num_resources	= 0,
-	.dev		= {
-		.platform_data	= &wrt350n_v2_button_data,
-	},
-};
-
-/*
- * General setup
- */
-static unsigned int wrt350n_v2_mpp_modes[] __initdata = {
-	MPP0_GPIO,		/* Power LED green (0=on) */
-	MPP1_GPIO,		/* Security LED (0=on) */
-	MPP2_GPIO,		/* Internal Button (0=on) */
-	MPP3_GPIO,		/* Reset Button (0=on) */
-	MPP4_GPIO,		/* PCI int */
-	MPP5_GPIO,		/* Power LED orange (0=on) */
-	MPP6_GPIO,		/* USB LED (0=on) */
-	MPP7_GPIO,		/* Wireless LED (0=on) */
-	MPP8_UNUSED,		/* ??? */
-	MPP9_GIGE,		/* GE_RXERR */
-	MPP10_UNUSED,		/* ??? */
-	MPP11_UNUSED,		/* ??? */
-	MPP12_GIGE,		/* GE_TXD[4] */
-	MPP13_GIGE,		/* GE_TXD[5] */
-	MPP14_GIGE,		/* GE_TXD[6] */
-	MPP15_GIGE,		/* GE_TXD[7] */
-	MPP16_GIGE,		/* GE_RXD[4] */
-	MPP17_GIGE,		/* GE_RXD[5] */
-	MPP18_GIGE,		/* GE_RXD[6] */
-	MPP19_GIGE,		/* GE_RXD[7] */
-	0,
-};
-
-/*
- * 8M NOR flash Device bus boot chip select
- */
-#define WRT350N_V2_NOR_BOOT_BASE	0xf4000000
-#define WRT350N_V2_NOR_BOOT_SIZE	SZ_8M
-
-static struct mtd_partition wrt350n_v2_nor_flash_partitions[] = {
-	{
-		.name		= "kernel",
-		.offset		= 0x00000000,
-		.size		= 0x00760000,
-	}, {
-		.name		= "rootfs",
-		.offset		= 0x001a0000,
-		.size		= 0x005c0000,
-	}, {
-		.name		= "lang",
-		.offset		= 0x00760000,
-		.size		= 0x00040000,
-	}, {
-		.name		= "nvram",
-		.offset		= 0x007a0000,
-		.size		= 0x00020000,
-	}, {
-		.name		= "u-boot",
-		.offset		= 0x007c0000,
-		.size		= 0x00040000,
-	},
-};
-
-static struct physmap_flash_data wrt350n_v2_nor_flash_data = {
-	.width		= 1,
-	.parts		= wrt350n_v2_nor_flash_partitions,
-	.nr_parts	= ARRAY_SIZE(wrt350n_v2_nor_flash_partitions),
-};
-
-static struct resource wrt350n_v2_nor_flash_resource = {
-	.flags		= IORESOURCE_MEM,
-	.start		= WRT350N_V2_NOR_BOOT_BASE,
-	.end		= WRT350N_V2_NOR_BOOT_BASE + WRT350N_V2_NOR_BOOT_SIZE - 1,
-};
-
-static struct platform_device wrt350n_v2_nor_flash = {
-	.name			= "physmap-flash",
-	.id			= 0,
-	.dev		= {
-		.platform_data	= &wrt350n_v2_nor_flash_data,
-	},
-	.num_resources		= 1,
-	.resource		= &wrt350n_v2_nor_flash_resource,
-};
-
-static struct mv643xx_eth_platform_data wrt350n_v2_eth_data = {
-	.phy_addr	= MV643XX_ETH_PHY_NONE,
-	.speed		= SPEED_1000,
-	.duplex		= DUPLEX_FULL,
-};
-
-static struct dsa_chip_data wrt350n_v2_switch_chip_data = {
-	.port_names[0]	= "lan2",
-	.port_names[1]	= "lan1",
-	.port_names[2]	= "wan",
-	.port_names[3]	= "cpu",
-	.port_names[5]	= "lan3",
-	.port_names[7]	= "lan4",
-};
-
-static void __init wrt350n_v2_init(void)
-{
-	/*
-	 * Setup basic Orion functions. Need to be called early.
-	 */
-	orion5x_init();
-
-	orion5x_mpp_conf(wrt350n_v2_mpp_modes);
-
-	/*
-	 * Configure peripherals.
-	 */
-	orion5x_ehci0_init();
-	orion5x_eth_init(&wrt350n_v2_eth_data);
-	orion5x_eth_switch_init(&wrt350n_v2_switch_chip_data);
-	orion5x_uart0_init();
-
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
-				    ORION_MBUS_DEVBUS_BOOT_ATTR,
-				    WRT350N_V2_NOR_BOOT_BASE,
-				    WRT350N_V2_NOR_BOOT_SIZE);
-	platform_device_register(&wrt350n_v2_nor_flash);
-	platform_device_register(&wrt350n_v2_leds);
-	platform_device_register(&wrt350n_v2_button_device);
-}
-
-static int __init wrt350n_v2_pci_map_irq(const struct pci_dev *dev, u8 slot,
-	u8 pin)
-{
-	int irq;
-
-	/*
-	 * Check for devices with hard-wired IRQs.
-	 */
-	irq = orion5x_pci_map_irq(dev, slot, pin);
-	if (irq != -1)
-		return irq;
-
-	/*
-	 * Mini-PCI slot.
-	 */
-	if (slot == 7)
-		return gpio_to_irq(4);
-
-	return -1;
-}
-
-static struct hw_pci wrt350n_v2_pci __initdata = {
-	.nr_controllers	= 2,
-	.setup		= orion5x_pci_sys_setup,
-	.scan		= orion5x_pci_sys_scan_bus,
-	.map_irq	= wrt350n_v2_pci_map_irq,
-};
-
-static int __init wrt350n_v2_pci_init(void)
-{
-	if (machine_is_wrt350n_v2())
-		pci_common_init(&wrt350n_v2_pci);
-
-	return 0;
-}
-subsys_initcall(wrt350n_v2_pci_init);
-
-MACHINE_START(WRT350N_V2, "Linksys WRT350N v2")
-	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= ORION5X_NR_IRQS,
-	.init_machine	= wrt350n_v2_init,
-	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_init_early,
-	.init_irq	= orion5x_init_irq,
-	.init_time	= orion5x_timer_init,
-	.fixup		= tag_fixup_mem32,
-	.restart	= orion5x_restart,
-MACHINE_END
-- 
2.29.2

