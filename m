Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCAF604AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiJSPQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJSPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:15:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2001CC3E0;
        Wed, 19 Oct 2022 08:08:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36898B824BE;
        Wed, 19 Oct 2022 15:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F84C433C1;
        Wed, 19 Oct 2022 15:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666191988;
        bh=4pCJEeZb9At0qC25isWEQsNZ7PwhOjcprL1uawADWYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZE0PnfiZgUyFjdWm+njdB1i7IgSohW+6/Nex5KqYLwrMNWv6HOj7UNG5yM3TwJcV
         9kZlHnR4Wob0u521frHYecqUmBg7wLrr3vzm3P1w1PTQQMUkm8fxuCtQCkAVbOtV7v
         mzvbU/bIy0ZHpf4JVkD/NEvzn1eGeclqOj85e87emrvdKoBE5CMbl0RYN44Gv9pa1X
         TnrJOsXGp+eRpH0chaoDc2UwVA1ocl2+0lFeJULbu+bJ9zitF6ESe95NN2DUoTM/aP
         JzATNWLoUN2rK6zTrvBiNZiiPfLllju8Zg0GN7NcSMJ8YsBLAvSGfDQNeKAqBo0YxB
         xERG7115RbZcw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Halasa <khalasa@piap.pl>, linux-usb@vger.kernel.org
Subject: [PATCH 02/17] ARM: cns3xxx: remove entire platform
Date:   Wed, 19 Oct 2022 17:03:24 +0200
Message-Id: <20221019150410.3851944-2-arnd@kernel.org>
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

cns3xxx was marked as unused a while ago, and gets removed
entirely now.

Cc: Krzysztof Halasa <khalasa@piap.pl>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                          |   5 -
 arch/arm/Kconfig                     |   2 -
 arch/arm/Kconfig.debug               |  10 -
 arch/arm/Makefile                    |   1 -
 arch/arm/configs/cns3420vb_defconfig |  63 ---
 arch/arm/mach-cns3xxx/Kconfig        |  21 -
 arch/arm/mach-cns3xxx/Makefile       |   6 -
 arch/arm/mach-cns3xxx/cns3420vb.c    | 252 ------------
 arch/arm/mach-cns3xxx/cns3xxx.h      | 593 ---------------------------
 arch/arm/mach-cns3xxx/core.c         | 410 ------------------
 arch/arm/mach-cns3xxx/core.h         |  32 --
 arch/arm/mach-cns3xxx/devices.c      | 108 -----
 arch/arm/mach-cns3xxx/devices.h      |  17 -
 arch/arm/mach-cns3xxx/pcie.c         | 290 -------------
 arch/arm/mach-cns3xxx/pm.c           | 120 ------
 arch/arm/mach-cns3xxx/pm.h           |  20 -
 drivers/usb/host/Kconfig             |  23 --
 17 files changed, 1973 deletions(-)
 delete mode 100644 arch/arm/configs/cns3420vb_defconfig
 delete mode 100644 arch/arm/mach-cns3xxx/Kconfig
 delete mode 100644 arch/arm/mach-cns3xxx/Makefile
 delete mode 100644 arch/arm/mach-cns3xxx/cns3420vb.c
 delete mode 100644 arch/arm/mach-cns3xxx/cns3xxx.h
 delete mode 100644 arch/arm/mach-cns3xxx/core.c
 delete mode 100644 arch/arm/mach-cns3xxx/core.h
 delete mode 100644 arch/arm/mach-cns3xxx/devices.c
 delete mode 100644 arch/arm/mach-cns3xxx/devices.h
 delete mode 100644 arch/arm/mach-cns3xxx/pcie.c
 delete mode 100644 arch/arm/mach-cns3xxx/pm.c
 delete mode 100644 arch/arm/mach-cns3xxx/pm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index aedb7c008dd6..57b74156df3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1984,11 +1984,6 @@ F:	arch/arm/boot/dts/ecx-*.dts*
 F:	arch/arm/boot/dts/highbank.dts
 F:	arch/arm/mach-highbank/
 
-ARM/CAVIUM NETWORKS CNS3XXX MACHINE SUPPORT
-M:	Krzysztof Halasa <khalasa@piap.pl>
-S:	Maintained
-F:	arch/arm/mach-cns3xxx/
-
 ARM/CAVIUM THUNDER NETWORK DRIVER
 M:	Sunil Goutham <sgoutham@marvell.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a08c9d092a33..e58dab0303e6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -433,8 +433,6 @@ source "arch/arm/mach-berlin/Kconfig"
 
 source "arch/arm/mach-clps711x/Kconfig"
 
-source "arch/arm/mach-cns3xxx/Kconfig"
-
 source "arch/arm/mach-davinci/Kconfig"
 
 source "arch/arm/mach-digicolor/Kconfig"
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index c345775f035b..3b11e1d04625 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -307,14 +307,6 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the second serial port on these devices.
 
-	config DEBUG_CNS3XXX
-		bool "Kernel Kernel low-level debugging on Cavium Networks CNS3xxx"
-		depends on ARCH_CNS3XXX
-		select DEBUG_UART_8250
-		help
-		  Say Y here if you want the debug print routines to direct
-                  their output to the CNS3xxx UART0.
-
 	config DEBUG_DAVINCI_DA8XX_UART1
 		bool "Kernel low-level debugging on DaVinci DA8XX using UART1"
 		depends on ARCH_DAVINCI_DA8XX
@@ -1685,7 +1677,6 @@ config DEBUG_UART_PHYS
 				DEBUG_S3C2410_UART1)
 	default 0x50008000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART2 || \
 				DEBUG_S3C2410_UART2)
-	default 0x78000000 if DEBUG_CNS3XXX
 	default 0x7c0003f8 if DEBUG_FOOTBRIDGE_COM1
 	default 0x7f005000 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART0
 	default 0x7f005400 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART1
@@ -1818,7 +1809,6 @@ config DEBUG_UART_VIRT
 				DEBUG_OMAP4UART2 || DEBUG_OMAP5UART2
 	default 0xfa06e000 if DEBUG_OMAP2UART3 || DEBUG_OMAP4UART4
 	default 0xfa71e000 if DEBUG_QCOM_UARTDM
-	default 0xfb002000 if DEBUG_CNS3XXX
 	default 0xfb009000 if DEBUG_REALVIEW_STD_PORT
 	default 0xfb00c000 if DEBUG_AT91_SAMA5D4_USART3
 	default 0xfb020000 if DEBUG_OMAP3UART3
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c846119c448f..beda22911feb 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -169,7 +169,6 @@ machine-$(CONFIG_ARCH_AXXIA)		+= axxia
 machine-$(CONFIG_ARCH_BCM)		+= bcm
 machine-$(CONFIG_ARCH_BERLIN)		+= berlin
 machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
-machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
 machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
 machine-$(CONFIG_ARCH_DIGICOLOR)	+= digicolor
 machine-$(CONFIG_ARCH_DOVE)		+= dove
diff --git a/arch/arm/configs/cns3420vb_defconfig b/arch/arm/configs/cns3420vb_defconfig
deleted file mode 100644
index b3aab97c0728..000000000000
--- a/arch/arm/configs/cns3420vb_defconfig
+++ /dev/null
@@ -1,63 +0,0 @@
-# CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_SYSVIPC=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CGROUPS=y
-CONFIG_SYSFS_DEPRECATED_V2=y
-CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
-# CONFIG_PERF_EVENTS is not set
-CONFIG_PROFILING=y
-CONFIG_ARCH_MULTI_V6=y
-CONFIG_ARCH_CNS3XXX=y
-CONFIG_MACH_CNS3420VB=y
-CONFIG_UNUSED_BOARD_FILES=y
-CONFIG_CMDLINE="console=ttyS0,38400 mem=128M root=/dev/mmcblk0p1 ro rootwait"
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_IOSCHED_BFQ=m
-#CONFIG_ARCH_MULTI_V7 is not set
-CONFIG_DEBUG_CNS3XXX=y
-CONFIG_AEABI=y
-# CONFIG_SWAP is not set
-CONFIG_SLAB=y
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=20000
-CONFIG_BLK_DEV_SD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_ATA=y
-# CONFIG_SATA_PMP is not set
-# CONFIG_ATA_SFF is not set
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_LEGACY_PTY_COUNT=16
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_MMC=y
-CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_PLTFM=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_AUTOFS4_FS=y
-CONFIG_FSCACHE=y
-CONFIG_TMPFS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
-# CONFIG_ARM_UNWIND is not set
-CONFIG_CRC_CCITT=y
-CONFIG_DEBUG_FS=y
diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
deleted file mode 100644
index 1f85deff2486..000000000000
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ /dev/null
@@ -1,21 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-menuconfig ARCH_CNS3XXX
-	bool "Cavium Networks CNS3XXX family"
-	depends on ARCH_MULTI_V6
-	depends on ATAGS && UNUSED_BOARD_FILES
-	select ARM_GIC
-	help
-	  Support for Cavium Networks CNS3XXX platform.
-
-if ARCH_CNS3XXX
-
-config MACH_CNS3420VB
-	bool "Support for CNS3420 Validation Board"
-	depends on ATAGS
-	help
-	  Include support for the Cavium Networks CNS3420 MPCore Platform
-	  Baseboard.
-	  This is a platform with an on-board ARM11 MPCore and has support
-	  for USB, USB-OTG, MMC/SD/SDIO, SATA, PCI-E, etc.
-
-endif
diff --git a/arch/arm/mach-cns3xxx/Makefile b/arch/arm/mach-cns3xxx/Makefile
deleted file mode 100644
index 52ca6ed62304..000000000000
--- a/arch/arm/mach-cns3xxx/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx.o
-cns3xxx-y				+= core.o pm.o
-cns3xxx-$(CONFIG_ATAGS)			+= devices.o
-cns3xxx-$(CONFIG_PCI)			+= pcie.o
-cns3xxx-$(CONFIG_MACH_CNS3420VB)	+= cns3420vb.o
diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
deleted file mode 100644
index 9099560aa462..000000000000
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ /dev/null
@@ -1,252 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Cavium Networks CNS3420 Validation Board
- *
- * Copyright 2000 Deep Blue Solutions Ltd
- * Copyright 2008 ARM Limited
- * Copyright 2008 Cavium Networks
- *		  Scott Shu
- * Copyright 2010 MontaVista Software, LLC.
- *		  Anton Vorontsov <avorontsov@mvista.com>
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/compiler.h>
-#include <linux/io.h>
-#include <linux/dma-mapping.h>
-#include <linux/serial_core.h>
-#include <linux/serial_8250.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/physmap.h>
-#include <linux/mtd/partitions.h>
-#include <linux/usb/ehci_pdriver.h>
-#include <linux/usb/ohci_pdriver.h>
-#include <asm/setup.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/time.h>
-#include "cns3xxx.h"
-#include "pm.h"
-#include "core.h"
-#include "devices.h"
-
-/*
- * NOR Flash
- */
-static struct mtd_partition cns3420_nor_partitions[] = {
-	{
-		.name		= "uboot",
-		.size		= 0x00040000,
-		.offset		= 0,
-		.mask_flags	= MTD_WRITEABLE,
-	}, {
-		.name		= "kernel",
-		.size		= 0x004C0000,
-		.offset		= MTDPART_OFS_APPEND,
-	}, {
-		.name		= "filesystem",
-		.size		= 0x7000000,
-		.offset		= MTDPART_OFS_APPEND,
-	}, {
-		.name		= "filesystem2",
-		.size		= 0x0AE0000,
-		.offset		= MTDPART_OFS_APPEND,
-	}, {
-		.name		= "ubootenv",
-		.size		= MTDPART_SIZ_FULL,
-		.offset		= MTDPART_OFS_APPEND,
-	},
-};
-
-static struct physmap_flash_data cns3420_nor_pdata = {
-	.width = 2,
-	.parts = cns3420_nor_partitions,
-	.nr_parts = ARRAY_SIZE(cns3420_nor_partitions),
-};
-
-static struct resource cns3420_nor_res = {
-	.start = CNS3XXX_FLASH_BASE,
-	.end = CNS3XXX_FLASH_BASE + SZ_128M - 1,
-	.flags = IORESOURCE_MEM | IORESOURCE_MEM_32BIT,
-};
-
-static struct platform_device cns3420_nor_pdev = {
-	.name = "physmap-flash",
-	.id = 0,
-	.resource = &cns3420_nor_res,
-	.num_resources = 1,
-	.dev = {
-		.platform_data = &cns3420_nor_pdata,
-	},
-};
-
-/*
- * UART
- */
-static void __init cns3420_early_serial_setup(void)
-{
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	static struct uart_port cns3420_serial_port = {
-		.membase        = (void __iomem *)CNS3XXX_UART0_BASE_VIRT,
-		.mapbase        = CNS3XXX_UART0_BASE,
-		.irq            = IRQ_CNS3XXX_UART0,
-		.iotype         = UPIO_MEM,
-		.flags          = UPF_BOOT_AUTOCONF | UPF_FIXED_TYPE,
-		.regshift       = 2,
-		.uartclk        = 24000000,
-		.line           = 0,
-		.type           = PORT_16550A,
-		.fifosize       = 16,
-	};
-
-	early_serial_setup(&cns3420_serial_port);
-#endif
-}
-
-/*
- * USB
- */
-static struct resource cns3xxx_usb_ehci_resources[] = {
-	[0] = {
-		.start = CNS3XXX_USB_BASE,
-		.end   = CNS3XXX_USB_BASE + SZ_16M - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_CNS3XXX_USB_EHCI,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static u64 cns3xxx_usb_ehci_dma_mask = DMA_BIT_MASK(32);
-
-static int csn3xxx_usb_power_on(struct platform_device *pdev)
-{
-	/*
-	 * EHCI and OHCI share the same clock and power,
-	 * resetting twice would cause the 1st controller been reset.
-	 * Therefore only do power up  at the first up device, and
-	 * power down at the last down device.
-	 *
-	 * Set USB AHB INCR length to 16
-	 */
-	if (atomic_inc_return(&usb_pwr_ref) == 1) {
-		cns3xxx_pwr_power_up(1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_PLL_USB);
-		cns3xxx_pwr_clk_en(1 << PM_CLK_GATE_REG_OFFSET_USB_HOST);
-		cns3xxx_pwr_soft_rst(1 << PM_SOFT_RST_REG_OFFST_USB_HOST);
-		__raw_writel((__raw_readl(MISC_CHIP_CONFIG_REG) | (0X2 << 24)),
-			MISC_CHIP_CONFIG_REG);
-	}
-
-	return 0;
-}
-
-static void csn3xxx_usb_power_off(struct platform_device *pdev)
-{
-	/*
-	 * EHCI and OHCI share the same clock and power,
-	 * resetting twice would cause the 1st controller been reset.
-	 * Therefore only do power up  at the first up device, and
-	 * power down at the last down device.
-	 */
-	if (atomic_dec_return(&usb_pwr_ref) == 0)
-		cns3xxx_pwr_clk_dis(1 << PM_CLK_GATE_REG_OFFSET_USB_HOST);
-}
-
-static struct usb_ehci_pdata cns3xxx_usb_ehci_pdata = {
-	.power_on	= csn3xxx_usb_power_on,
-	.power_off	= csn3xxx_usb_power_off,
-};
-
-static struct platform_device cns3xxx_usb_ehci_device = {
-	.name          = "ehci-platform",
-	.num_resources = ARRAY_SIZE(cns3xxx_usb_ehci_resources),
-	.resource      = cns3xxx_usb_ehci_resources,
-	.dev           = {
-		.dma_mask          = &cns3xxx_usb_ehci_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data     = &cns3xxx_usb_ehci_pdata,
-	},
-};
-
-static struct resource cns3xxx_usb_ohci_resources[] = {
-	[0] = {
-		.start = CNS3XXX_USB_OHCI_BASE,
-		.end   = CNS3XXX_USB_OHCI_BASE + SZ_16M - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_CNS3XXX_USB_OHCI,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static u64 cns3xxx_usb_ohci_dma_mask = DMA_BIT_MASK(32);
-
-static struct usb_ohci_pdata cns3xxx_usb_ohci_pdata = {
-	.num_ports	= 1,
-	.power_on	= csn3xxx_usb_power_on,
-	.power_off	= csn3xxx_usb_power_off,
-};
-
-static struct platform_device cns3xxx_usb_ohci_device = {
-	.name          = "ohci-platform",
-	.num_resources = ARRAY_SIZE(cns3xxx_usb_ohci_resources),
-	.resource      = cns3xxx_usb_ohci_resources,
-	.dev           = {
-		.dma_mask          = &cns3xxx_usb_ohci_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data	   = &cns3xxx_usb_ohci_pdata,
-	},
-};
-
-/*
- * Initialization
- */
-static struct platform_device *cns3420_pdevs[] __initdata = {
-	&cns3420_nor_pdev,
-	&cns3xxx_usb_ehci_device,
-	&cns3xxx_usb_ohci_device,
-};
-
-static void __init cns3420_init(void)
-{
-	cns3xxx_l2x0_init();
-
-	platform_add_devices(cns3420_pdevs, ARRAY_SIZE(cns3420_pdevs));
-
-	cns3xxx_ahci_init();
-	cns3xxx_sdhci_init();
-
-	pm_power_off = cns3xxx_power_off;
-}
-
-static struct map_desc cns3420_io_desc[] __initdata = {
-	{
-		.virtual	= CNS3XXX_UART0_BASE_VIRT,
-		.pfn		= __phys_to_pfn(CNS3XXX_UART0_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
-static void __init cns3420_map_io(void)
-{
-	cns3xxx_map_io();
-	iotable_init(cns3420_io_desc, ARRAY_SIZE(cns3420_io_desc));
-
-	cns3420_early_serial_setup();
-}
-
-MACHINE_START(CNS3420VB, "Cavium Networks CNS3420 Validation Board")
-	.atag_offset	= 0x100,
-	.map_io		= cns3420_map_io,
-	.init_irq	= cns3xxx_init_irq,
-	.init_time	= cns3xxx_timer_init,
-	.init_machine	= cns3420_init,
-	.init_late      = cns3xxx_pcie_init_late,
-	.restart	= cns3xxx_restart,
-MACHINE_END
diff --git a/arch/arm/mach-cns3xxx/cns3xxx.h b/arch/arm/mach-cns3xxx/cns3xxx.h
deleted file mode 100644
index cbb105a74f90..000000000000
--- a/arch/arm/mach-cns3xxx/cns3xxx.h
+++ /dev/null
@@ -1,593 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2008 Cavium Networks
- */
-
-#ifndef __MACH_BOARD_CNS3XXXH
-#define __MACH_BOARD_CNS3XXXH
-
-/*
- * Memory map
- */
-#define CNS3XXX_FLASH_BASE			0x10000000	/* Flash/SRAM Memory Bank 0 */
-#define CNS3XXX_FLASH_SIZE			SZ_256M
-
-#define CNS3XXX_DDR2SDRAM_BASE			0x20000000	/* DDR2 SDRAM Memory */
-
-#define CNS3XXX_SPI_FLASH_BASE			0x60000000	/* SPI Serial Flash Memory */
-
-#define CNS3XXX_SWITCH_BASE			0x70000000	/* Switch and HNAT Control */
-
-#define CNS3XXX_PPE_BASE			0x70001000	/* HANT	*/
-
-#define CNS3XXX_EMBEDDED_SRAM_BASE		0x70002000	/* HANT Embedded SRAM */
-
-#define CNS3XXX_SSP_BASE			0x71000000	/* Synchronous Serial Port - SPI/PCM/I2C */
-
-#define CNS3XXX_DMC_BASE			0x72000000	/* DMC Control (DDR2 SDRAM) */
-
-#define CNS3XXX_SMC_BASE			0x73000000	/* SMC Control */
-
-#define SMC_MEMC_STATUS_OFFSET			0x000
-#define SMC_MEMIF_CFG_OFFSET			0x004
-#define SMC_MEMC_CFG_SET_OFFSET			0x008
-#define SMC_MEMC_CFG_CLR_OFFSET			0x00C
-#define SMC_DIRECT_CMD_OFFSET			0x010
-#define SMC_SET_CYCLES_OFFSET			0x014
-#define SMC_SET_OPMODE_OFFSET			0x018
-#define SMC_REFRESH_PERIOD_0_OFFSET		0x020
-#define SMC_REFRESH_PERIOD_1_OFFSET		0x024
-#define SMC_SRAM_CYCLES0_0_OFFSET		0x100
-#define SMC_NAND_CYCLES0_0_OFFSET		0x100
-#define SMC_OPMODE0_0_OFFSET			0x104
-#define SMC_SRAM_CYCLES0_1_OFFSET		0x120
-#define SMC_NAND_CYCLES0_1_OFFSET		0x120
-#define SMC_OPMODE0_1_OFFSET			0x124
-#define SMC_USER_STATUS_OFFSET			0x200
-#define SMC_USER_CONFIG_OFFSET			0x204
-#define SMC_ECC_STATUS_OFFSET			0x300
-#define SMC_ECC_MEMCFG_OFFSET			0x304
-#define SMC_ECC_MEMCOMMAND1_OFFSET		0x308
-#define SMC_ECC_MEMCOMMAND2_OFFSET		0x30C
-#define SMC_ECC_ADDR0_OFFSET			0x310
-#define SMC_ECC_ADDR1_OFFSET			0x314
-#define SMC_ECC_VALUE0_OFFSET			0x318
-#define SMC_ECC_VALUE1_OFFSET			0x31C
-#define SMC_ECC_VALUE2_OFFSET			0x320
-#define SMC_ECC_VALUE3_OFFSET			0x324
-#define SMC_PERIPH_ID_0_OFFSET			0xFE0
-#define SMC_PERIPH_ID_1_OFFSET			0xFE4
-#define SMC_PERIPH_ID_2_OFFSET			0xFE8
-#define SMC_PERIPH_ID_3_OFFSET			0xFEC
-#define SMC_PCELL_ID_0_OFFSET			0xFF0
-#define SMC_PCELL_ID_1_OFFSET			0xFF4
-#define SMC_PCELL_ID_2_OFFSET			0xFF8
-#define SMC_PCELL_ID_3_OFFSET			0xFFC
-
-#define CNS3XXX_GPIOA_BASE			0x74000000	/* GPIO port A */
-
-#define CNS3XXX_GPIOB_BASE			0x74800000	/* GPIO port B */
-
-#define CNS3XXX_RTC_BASE			0x75000000	/* Real Time Clock */
-
-#define RTC_SEC_OFFSET				0x00
-#define RTC_MIN_OFFSET				0x04
-#define RTC_HOUR_OFFSET				0x08
-#define RTC_DAY_OFFSET				0x0C
-#define RTC_SEC_ALM_OFFSET			0x10
-#define RTC_MIN_ALM_OFFSET			0x14
-#define RTC_HOUR_ALM_OFFSET			0x18
-#define RTC_REC_OFFSET				0x1C
-#define RTC_CTRL_OFFSET				0x20
-#define RTC_INTR_STS_OFFSET			0x34
-
-#define CNS3XXX_MISC_BASE			0x76000000	/* Misc Control */
-#define CNS3XXX_MISC_BASE_VIRT			0xFB000000	/* Misc Control */
-
-#define CNS3XXX_PM_BASE				0x77000000	/* Power Management Control */
-#define CNS3XXX_PM_BASE_VIRT			0xFB001000
-
-#define PM_CLK_GATE_OFFSET			0x00
-#define PM_SOFT_RST_OFFSET			0x04
-#define PM_HS_CFG_OFFSET			0x08
-#define PM_CACTIVE_STA_OFFSET			0x0C
-#define PM_PWR_STA_OFFSET			0x10
-#define PM_SYS_CLK_CTRL_OFFSET			0x14
-#define PM_PLL_LCD_I2S_CTRL_OFFSET		0x18
-#define PM_PLL_HM_PD_OFFSET			0x1C
-
-#define CNS3XXX_UART0_BASE			0x78000000	/* UART 0 */
-#define CNS3XXX_UART0_BASE_VIRT			0xFB002000
-
-#define CNS3XXX_UART1_BASE			0x78400000	/* UART 1 */
-
-#define CNS3XXX_UART2_BASE			0x78800000	/* UART 2 */
-
-#define CNS3XXX_DMAC_BASE			0x79000000	/* Generic DMA Control */
-
-#define CNS3XXX_CORESIGHT_BASE			0x7A000000	/* CoreSight */
-
-#define CNS3XXX_CRYPTO_BASE			0x7B000000	/* Crypto */
-
-#define CNS3XXX_I2S_BASE			0x7C000000	/* I2S */
-
-#define CNS3XXX_TIMER1_2_3_BASE			0x7C800000	/* Timer */
-#define CNS3XXX_TIMER1_2_3_BASE_VIRT		0xFB003000
-
-#define TIMER1_COUNTER_OFFSET			0x00
-#define TIMER1_AUTO_RELOAD_OFFSET		0x04
-#define TIMER1_MATCH_V1_OFFSET			0x08
-#define TIMER1_MATCH_V2_OFFSET			0x0C
-
-#define TIMER2_COUNTER_OFFSET			0x10
-#define TIMER2_AUTO_RELOAD_OFFSET		0x14
-#define TIMER2_MATCH_V1_OFFSET			0x18
-#define TIMER2_MATCH_V2_OFFSET			0x1C
-
-#define TIMER1_2_CONTROL_OFFSET			0x30
-#define TIMER1_2_INTERRUPT_STATUS_OFFSET	0x34
-#define TIMER1_2_INTERRUPT_MASK_OFFSET		0x38
-
-#define TIMER_FREERUN_OFFSET			0x40
-#define TIMER_FREERUN_CONTROL_OFFSET		0x44
-
-#define CNS3XXX_HCIE_BASE			0x7D000000	/* HCIE Control */
-
-#define CNS3XXX_RAID_BASE			0x7E000000	/* RAID Control */
-
-#define CNS3XXX_AXI_IXC_BASE			0x7F000000	/* AXI IXC */
-
-#define CNS3XXX_CLCD_BASE			0x80000000	/* LCD Control */
-
-#define CNS3XXX_USBOTG_BASE			0x81000000	/* USB OTG Control */
-
-#define CNS3XXX_USB_BASE			0x82000000	/* USB Host Control */
-
-#define CNS3XXX_SATA2_BASE			0x83000000	/* SATA */
-#define CNS3XXX_SATA2_SIZE			SZ_16M
-
-#define CNS3XXX_CAMERA_BASE			0x84000000	/* Camera Interface */
-
-#define CNS3XXX_SDIO_BASE			0x85000000	/* SDIO */
-
-#define CNS3XXX_I2S_TDM_BASE			0x86000000	/* I2S TDM */
-
-#define CNS3XXX_2DG_BASE			0x87000000	/* 2D Graphic Control */
-
-#define CNS3XXX_USB_OHCI_BASE			0x88000000	/* USB OHCI */
-
-#define CNS3XXX_L2C_BASE			0x92000000	/* L2 Cache Control */
-
-#define CNS3XXX_PCIE0_MEM_BASE			0xA0000000	/* PCIe Port 0 IO/Memory Space */
-
-#define CNS3XXX_PCIE0_HOST_BASE			0xAB000000	/* PCIe Port 0 RC Base */
-#define CNS3XXX_PCIE0_HOST_BASE_VIRT		0xE1000000
-
-#define CNS3XXX_PCIE0_IO_BASE			0xAC000000	/* PCIe Port 0 */
-
-#define CNS3XXX_PCIE0_CFG0_BASE			0xAD000000	/* PCIe Port 0 CFG Type 0 */
-#define CNS3XXX_PCIE0_CFG0_BASE_VIRT		0xE3000000
-
-#define CNS3XXX_PCIE0_CFG1_BASE			0xAE000000	/* PCIe Port 0 CFG Type 1 */
-#define CNS3XXX_PCIE0_CFG1_BASE_VIRT		0xE4000000
-
-#define CNS3XXX_PCIE0_MSG_BASE			0xAF000000	/* PCIe Port 0 Message Space */
-
-#define CNS3XXX_PCIE1_MEM_BASE			0xB0000000	/* PCIe Port 1 IO/Memory Space */
-
-#define CNS3XXX_PCIE1_HOST_BASE			0xBB000000	/* PCIe Port 1 RC Base */
-#define CNS3XXX_PCIE1_HOST_BASE_VIRT		0xE9000000
-
-#define CNS3XXX_PCIE1_IO_BASE			0xBC000000	/* PCIe Port 1 */
-
-#define CNS3XXX_PCIE1_CFG0_BASE			0xBD000000	/* PCIe Port 1 CFG Type 0 */
-#define CNS3XXX_PCIE1_CFG0_BASE_VIRT		0xEB000000
-
-#define CNS3XXX_PCIE1_CFG1_BASE			0xBE000000	/* PCIe Port 1 CFG Type 1 */
-#define CNS3XXX_PCIE1_CFG1_BASE_VIRT		0xEC000000
-
-#define CNS3XXX_PCIE1_MSG_BASE			0xBF000000	/* PCIe Port 1 Message Space */
-
-/*
- * Testchip peripheral and fpga gic regions
- */
-#define CNS3XXX_TC11MP_SCU_BASE			0x90000000	/* IRQ, Test chip */
-#define CNS3XXX_TC11MP_SCU_BASE_VIRT		0xFB004000
-
-#define CNS3XXX_TC11MP_GIC_CPU_BASE		0x90000100	/* Test chip interrupt controller CPU interface */
-#define CNS3XXX_TC11MP_GIC_CPU_BASE_VIRT	(CNS3XXX_TC11MP_SCU_BASE_VIRT + 0x100)
-
-#define CNS3XXX_TC11MP_TWD_BASE			0x90000600
-#define CNS3XXX_TC11MP_TWD_BASE_VIRT		(CNS3XXX_TC11MP_SCU_BASE_VIRT + 0x600)
-
-#define CNS3XXX_TC11MP_GIC_DIST_BASE		0x90001000	/* Test chip interrupt controller distributor */
-#define CNS3XXX_TC11MP_GIC_DIST_BASE_VIRT	(CNS3XXX_TC11MP_SCU_BASE_VIRT + 0x1000)
-
-#define CNS3XXX_TC11MP_L220_BASE		0x92002000	/* L220 registers */
-
-/*
- * Misc block
- */
-#define MISC_MEM_MAP(offs) (void __iomem *)(CNS3XXX_MISC_BASE_VIRT + (offs))
-
-#define MISC_MEMORY_REMAP_REG			MISC_MEM_MAP(0x00)
-#define MISC_CHIP_CONFIG_REG			MISC_MEM_MAP(0x04)
-#define MISC_DEBUG_PROBE_DATA_REG		MISC_MEM_MAP(0x08)
-#define MISC_DEBUG_PROBE_SELECTION_REG		MISC_MEM_MAP(0x0C)
-#define MISC_IO_PIN_FUNC_SELECTION_REG		MISC_MEM_MAP(0x10)
-#define MISC_GPIOA_PIN_ENABLE_REG		MISC_MEM_MAP(0x14)
-#define MISC_GPIOB_PIN_ENABLE_REG		MISC_MEM_MAP(0x18)
-#define MISC_IO_PAD_DRIVE_STRENGTH_CTRL_A	MISC_MEM_MAP(0x1C)
-#define MISC_IO_PAD_DRIVE_STRENGTH_CTRL_B	MISC_MEM_MAP(0x20)
-#define MISC_GPIOA_15_0_PULL_CTRL_REG		MISC_MEM_MAP(0x24)
-#define MISC_GPIOA_16_31_PULL_CTRL_REG		MISC_MEM_MAP(0x28)
-#define MISC_GPIOB_15_0_PULL_CTRL_REG		MISC_MEM_MAP(0x2C)
-#define MISC_GPIOB_16_31_PULL_CTRL_REG		MISC_MEM_MAP(0x30)
-#define MISC_IO_PULL_CTRL_REG			MISC_MEM_MAP(0x34)
-#define MISC_E_FUSE_31_0_REG			MISC_MEM_MAP(0x40)
-#define MISC_E_FUSE_63_32_REG			MISC_MEM_MAP(0x44)
-#define MISC_E_FUSE_95_64_REG			MISC_MEM_MAP(0x48)
-#define MISC_E_FUSE_127_96_REG			MISC_MEM_MAP(0x4C)
-#define MISC_SOFTWARE_TEST_1_REG		MISC_MEM_MAP(0x50)
-#define MISC_SOFTWARE_TEST_2_REG		MISC_MEM_MAP(0x54)
-
-#define MISC_SATA_POWER_MODE			MISC_MEM_MAP(0x310)
-
-#define MISC_USB_CFG_REG			MISC_MEM_MAP(0x800)
-#define MISC_USB_STS_REG			MISC_MEM_MAP(0x804)
-#define MISC_USBPHY00_CFG_REG			MISC_MEM_MAP(0x808)
-#define MISC_USBPHY01_CFG_REG			MISC_MEM_MAP(0x80c)
-#define MISC_USBPHY10_CFG_REG			MISC_MEM_MAP(0x810)
-#define MISC_USBPHY11_CFG_REG			MISC_MEM_MAP(0x814)
-
-#define MISC_PCIEPHY_CMCTL(x)			MISC_MEM_MAP(0x900 + (x) * 0x004)
-#define MISC_PCIEPHY_CTL(x)			MISC_MEM_MAP(0x940 + (x) * 0x100)
-#define MISC_PCIE_AXIS_AWMISC(x)		MISC_MEM_MAP(0x944 + (x) * 0x100)
-#define MISC_PCIE_AXIS_ARMISC(x)		MISC_MEM_MAP(0x948 + (x) * 0x100)
-#define MISC_PCIE_AXIS_RMISC(x)			MISC_MEM_MAP(0x94C + (x) * 0x100)
-#define MISC_PCIE_AXIS_BMISC(x)			MISC_MEM_MAP(0x950 + (x) * 0x100)
-#define MISC_PCIE_AXIM_RMISC(x)			MISC_MEM_MAP(0x954 + (x) * 0x100)
-#define MISC_PCIE_AXIM_BMISC(x)			MISC_MEM_MAP(0x958 + (x) * 0x100)
-#define MISC_PCIE_CTRL(x)			MISC_MEM_MAP(0x95C + (x) * 0x100)
-#define MISC_PCIE_PM_DEBUG(x)			MISC_MEM_MAP(0x960 + (x) * 0x100)
-#define MISC_PCIE_RFC_DEBUG(x)			MISC_MEM_MAP(0x964 + (x) * 0x100)
-#define MISC_PCIE_CXPL_DEBUGL(x)		MISC_MEM_MAP(0x968 + (x) * 0x100)
-#define MISC_PCIE_CXPL_DEBUGH(x)		MISC_MEM_MAP(0x96C + (x) * 0x100)
-#define MISC_PCIE_DIAG_DEBUGH(x)		MISC_MEM_MAP(0x970 + (x) * 0x100)
-#define MISC_PCIE_W1CLR(x)			MISC_MEM_MAP(0x974 + (x) * 0x100)
-#define MISC_PCIE_INT_MASK(x)			MISC_MEM_MAP(0x978 + (x) * 0x100)
-#define MISC_PCIE_INT_STATUS(x)			MISC_MEM_MAP(0x97C + (x) * 0x100)
-
-/*
- * Power management and clock control
- */
-#define PMU_MEM_MAP(offs) (void __iomem *)(CNS3XXX_PM_BASE_VIRT + (offs))
-
-#define PM_CLK_GATE_REG					PMU_MEM_MAP(0x000)
-#define PM_SOFT_RST_REG					PMU_MEM_MAP(0x004)
-#define PM_HS_CFG_REG					PMU_MEM_MAP(0x008)
-#define PM_CACTIVE_STA_REG				PMU_MEM_MAP(0x00C)
-#define PM_PWR_STA_REG					PMU_MEM_MAP(0x010)
-#define PM_CLK_CTRL_REG					PMU_MEM_MAP(0x014)
-#define PM_PLL_LCD_I2S_CTRL_REG				PMU_MEM_MAP(0x018)
-#define PM_PLL_HM_PD_CTRL_REG				PMU_MEM_MAP(0x01C)
-#define PM_REGULAT_CTRL_REG				PMU_MEM_MAP(0x020)
-#define PM_WDT_CTRL_REG					PMU_MEM_MAP(0x024)
-#define PM_WU_CTRL0_REG					PMU_MEM_MAP(0x028)
-#define PM_WU_CTRL1_REG					PMU_MEM_MAP(0x02C)
-#define PM_CSR_REG					PMU_MEM_MAP(0x030)
-
-/* PM_CLK_GATE_REG */
-#define PM_CLK_GATE_REG_OFFSET_SDIO			(25)
-#define PM_CLK_GATE_REG_OFFSET_GPU			(24)
-#define PM_CLK_GATE_REG_OFFSET_CIM			(23)
-#define PM_CLK_GATE_REG_OFFSET_LCDC			(22)
-#define PM_CLK_GATE_REG_OFFSET_I2S			(21)
-#define PM_CLK_GATE_REG_OFFSET_RAID			(20)
-#define PM_CLK_GATE_REG_OFFSET_SATA			(19)
-#define PM_CLK_GATE_REG_OFFSET_PCIE(x)			(17 + (x))
-#define PM_CLK_GATE_REG_OFFSET_USB_HOST			(16)
-#define PM_CLK_GATE_REG_OFFSET_USB_OTG			(15)
-#define PM_CLK_GATE_REG_OFFSET_TIMER			(14)
-#define PM_CLK_GATE_REG_OFFSET_CRYPTO			(13)
-#define PM_CLK_GATE_REG_OFFSET_HCIE			(12)
-#define PM_CLK_GATE_REG_OFFSET_SWITCH			(11)
-#define PM_CLK_GATE_REG_OFFSET_GPIO			(10)
-#define PM_CLK_GATE_REG_OFFSET_UART3			(9)
-#define PM_CLK_GATE_REG_OFFSET_UART2			(8)
-#define PM_CLK_GATE_REG_OFFSET_UART1			(7)
-#define PM_CLK_GATE_REG_OFFSET_RTC			(5)
-#define PM_CLK_GATE_REG_OFFSET_GDMA			(4)
-#define PM_CLK_GATE_REG_OFFSET_SPI_PCM_I2C		(3)
-#define PM_CLK_GATE_REG_OFFSET_SMC_NFI			(1)
-#define PM_CLK_GATE_REG_MASK				(0x03FFFFBA)
-
-/* PM_SOFT_RST_REG */
-#define PM_SOFT_RST_REG_OFFST_WARM_RST_FLAG		(31)
-#define PM_SOFT_RST_REG_OFFST_CPU1			(29)
-#define PM_SOFT_RST_REG_OFFST_CPU0			(28)
-#define PM_SOFT_RST_REG_OFFST_SDIO			(25)
-#define PM_SOFT_RST_REG_OFFST_GPU			(24)
-#define PM_SOFT_RST_REG_OFFST_CIM			(23)
-#define PM_SOFT_RST_REG_OFFST_LCDC			(22)
-#define PM_SOFT_RST_REG_OFFST_I2S			(21)
-#define PM_SOFT_RST_REG_OFFST_RAID			(20)
-#define PM_SOFT_RST_REG_OFFST_SATA			(19)
-#define PM_SOFT_RST_REG_OFFST_PCIE(x)			(17 + (x))
-#define PM_SOFT_RST_REG_OFFST_USB_HOST			(16)
-#define PM_SOFT_RST_REG_OFFST_USB_OTG			(15)
-#define PM_SOFT_RST_REG_OFFST_TIMER			(14)
-#define PM_SOFT_RST_REG_OFFST_CRYPTO			(13)
-#define PM_SOFT_RST_REG_OFFST_HCIE			(12)
-#define PM_SOFT_RST_REG_OFFST_SWITCH			(11)
-#define PM_SOFT_RST_REG_OFFST_GPIO			(10)
-#define PM_SOFT_RST_REG_OFFST_UART3			(9)
-#define PM_SOFT_RST_REG_OFFST_UART2			(8)
-#define PM_SOFT_RST_REG_OFFST_UART1			(7)
-#define PM_SOFT_RST_REG_OFFST_RTC			(5)
-#define PM_SOFT_RST_REG_OFFST_GDMA			(4)
-#define PM_SOFT_RST_REG_OFFST_SPI_PCM_I2C		(3)
-#define PM_SOFT_RST_REG_OFFST_DMC			(2)
-#define PM_SOFT_RST_REG_OFFST_SMC_NFI			(1)
-#define PM_SOFT_RST_REG_OFFST_GLOBAL			(0)
-#define PM_SOFT_RST_REG_MASK				(0xF3FFFFBF)
-
-/* PMHS_CFG_REG */
-#define PM_HS_CFG_REG_OFFSET_SDIO			(25)
-#define PM_HS_CFG_REG_OFFSET_GPU			(24)
-#define PM_HS_CFG_REG_OFFSET_CIM			(23)
-#define PM_HS_CFG_REG_OFFSET_LCDC			(22)
-#define PM_HS_CFG_REG_OFFSET_I2S			(21)
-#define PM_HS_CFG_REG_OFFSET_RAID			(20)
-#define PM_HS_CFG_REG_OFFSET_SATA			(19)
-#define PM_HS_CFG_REG_OFFSET_PCIE1			(18)
-#define PM_HS_CFG_REG_OFFSET_PCIE0			(17)
-#define PM_HS_CFG_REG_OFFSET_USB_HOST			(16)
-#define PM_HS_CFG_REG_OFFSET_USB_OTG			(15)
-#define PM_HS_CFG_REG_OFFSET_TIMER			(14)
-#define PM_HS_CFG_REG_OFFSET_CRYPTO			(13)
-#define PM_HS_CFG_REG_OFFSET_HCIE			(12)
-#define PM_HS_CFG_REG_OFFSET_SWITCH			(11)
-#define PM_HS_CFG_REG_OFFSET_GPIO			(10)
-#define PM_HS_CFG_REG_OFFSET_UART3			(9)
-#define PM_HS_CFG_REG_OFFSET_UART2			(8)
-#define PM_HS_CFG_REG_OFFSET_UART1			(7)
-#define PM_HS_CFG_REG_OFFSET_RTC			(5)
-#define PM_HS_CFG_REG_OFFSET_GDMA			(4)
-#define PM_HS_CFG_REG_OFFSET_SPI_PCM_I2S		(3)
-#define PM_HS_CFG_REG_OFFSET_DMC			(2)
-#define PM_HS_CFG_REG_OFFSET_SMC_NFI			(1)
-#define PM_HS_CFG_REG_MASK				(0x03FFFFBE)
-#define PM_HS_CFG_REG_MASK_SUPPORT			(0x01100806)
-
-/* PM_CACTIVE_STA_REG */
-#define PM_CACTIVE_STA_REG_OFFSET_SDIO			(25)
-#define PM_CACTIVE_STA_REG_OFFSET_GPU			(24)
-#define PM_CACTIVE_STA_REG_OFFSET_CIM			(23)
-#define PM_CACTIVE_STA_REG_OFFSET_LCDC			(22)
-#define PM_CACTIVE_STA_REG_OFFSET_I2S			(21)
-#define PM_CACTIVE_STA_REG_OFFSET_RAID			(20)
-#define PM_CACTIVE_STA_REG_OFFSET_SATA			(19)
-#define PM_CACTIVE_STA_REG_OFFSET_PCIE1			(18)
-#define PM_CACTIVE_STA_REG_OFFSET_PCIE0			(17)
-#define PM_CACTIVE_STA_REG_OFFSET_USB_HOST		(16)
-#define PM_CACTIVE_STA_REG_OFFSET_USB_OTG		(15)
-#define PM_CACTIVE_STA_REG_OFFSET_TIMER			(14)
-#define PM_CACTIVE_STA_REG_OFFSET_CRYPTO		(13)
-#define PM_CACTIVE_STA_REG_OFFSET_HCIE			(12)
-#define PM_CACTIVE_STA_REG_OFFSET_SWITCH		(11)
-#define PM_CACTIVE_STA_REG_OFFSET_GPIO			(10)
-#define PM_CACTIVE_STA_REG_OFFSET_UART3			(9)
-#define PM_CACTIVE_STA_REG_OFFSET_UART2			(8)
-#define PM_CACTIVE_STA_REG_OFFSET_UART1			(7)
-#define PM_CACTIVE_STA_REG_OFFSET_RTC			(5)
-#define PM_CACTIVE_STA_REG_OFFSET_GDMA			(4)
-#define PM_CACTIVE_STA_REG_OFFSET_SPI_PCM_I2S		(3)
-#define PM_CACTIVE_STA_REG_OFFSET_DMC			(2)
-#define PM_CACTIVE_STA_REG_OFFSET_SMC_NFI		(1)
-#define PM_CACTIVE_STA_REG_MASK				(0x03FFFFBE)
-
-/* PM_PWR_STA_REG */
-#define PM_PWR_STA_REG_REG_OFFSET_SDIO			(25)
-#define PM_PWR_STA_REG_REG_OFFSET_GPU			(24)
-#define PM_PWR_STA_REG_REG_OFFSET_CIM			(23)
-#define PM_PWR_STA_REG_REG_OFFSET_LCDC			(22)
-#define PM_PWR_STA_REG_REG_OFFSET_I2S			(21)
-#define PM_PWR_STA_REG_REG_OFFSET_RAID			(20)
-#define PM_PWR_STA_REG_REG_OFFSET_SATA			(19)
-#define PM_PWR_STA_REG_REG_OFFSET_PCIE1			(18)
-#define PM_PWR_STA_REG_REG_OFFSET_PCIE0			(17)
-#define PM_PWR_STA_REG_REG_OFFSET_USB_HOST		(16)
-#define PM_PWR_STA_REG_REG_OFFSET_USB_OTG		(15)
-#define PM_PWR_STA_REG_REG_OFFSET_TIMER			(14)
-#define PM_PWR_STA_REG_REG_OFFSET_CRYPTO		(13)
-#define PM_PWR_STA_REG_REG_OFFSET_HCIE			(12)
-#define PM_PWR_STA_REG_REG_OFFSET_SWITCH		(11)
-#define PM_PWR_STA_REG_REG_OFFSET_GPIO			(10)
-#define PM_PWR_STA_REG_REG_OFFSET_UART3			(9)
-#define PM_PWR_STA_REG_REG_OFFSET_UART2			(8)
-#define PM_PWR_STA_REG_REG_OFFSET_UART1			(7)
-#define PM_PWR_STA_REG_REG_OFFSET_RTC			(5)
-#define PM_PWR_STA_REG_REG_OFFSET_GDMA			(4)
-#define PM_PWR_STA_REG_REG_OFFSET_SPI_PCM_I2S		(3)
-#define PM_PWR_STA_REG_REG_OFFSET_DMC			(2)
-#define PM_PWR_STA_REG_REG_OFFSET_SMC_NFI		(1)
-#define PM_PWR_STA_REG_REG_MASK				(0x03FFFFBE)
-
-/* PM_CLK_CTRL_REG */
-#define PM_CLK_CTRL_REG_OFFSET_I2S_MCLK			(31)
-#define PM_CLK_CTRL_REG_OFFSET_DDR2_CHG_EN		(30)
-#define PM_CLK_CTRL_REG_OFFSET_PCIE_REF1_EN		(29)
-#define PM_CLK_CTRL_REG_OFFSET_PCIE_REF0_EN		(28)
-#define PM_CLK_CTRL_REG_OFFSET_TIMER_SIM_MODE		(27)
-#define PM_CLK_CTRL_REG_OFFSET_I2SCLK_DIV		(24)
-#define PM_CLK_CTRL_REG_OFFSET_I2SCLK_SEL		(22)
-#define PM_CLK_CTRL_REG_OFFSET_CLKOUT_DIV		(20)
-#define PM_CLK_CTRL_REG_OFFSET_CLKOUT_SEL		(16)
-#define PM_CLK_CTRL_REG_OFFSET_MDC_DIV			(14)
-#define PM_CLK_CTRL_REG_OFFSET_CRYPTO_CLK_SEL		(12)
-#define PM_CLK_CTRL_REG_OFFSET_CPU_PWR_MODE		(9)
-#define PM_CLK_CTRL_REG_OFFSET_PLL_DDR2_SEL		(7)
-#define PM_CLK_CTRL_REG_OFFSET_DIV_IMMEDIATE		(6)
-#define PM_CLK_CTRL_REG_OFFSET_CPU_CLK_DIV		(4)
-#define PM_CLK_CTRL_REG_OFFSET_PLL_CPU_SEL		(0)
-
-#define PM_CPU_CLK_DIV(DIV) { \
-	PM_CLK_CTRL_REG &= ~((0x3) << PM_CLK_CTRL_REG_OFFSET_CPU_CLK_DIV); \
-	PM_CLK_CTRL_REG |= (((DIV)&0x3) << PM_CLK_CTRL_REG_OFFSET_CPU_CLK_DIV); \
-}
-
-#define PM_PLL_CPU_SEL(CPU) { \
-	PM_CLK_CTRL_REG &= ~((0xF) << PM_CLK_CTRL_REG_OFFSET_PLL_CPU_SEL); \
-	PM_CLK_CTRL_REG |= (((CPU)&0xF) << PM_CLK_CTRL_REG_OFFSET_PLL_CPU_SEL); \
-}
-
-/* PM_PLL_LCD_I2S_CTRL_REG */
-#define PM_PLL_LCD_I2S_CTRL_REG_OFFSET_MCLK_SMC_DIV	(22)
-#define PM_PLL_LCD_I2S_CTRL_REG_OFFSET_R_SEL		(17)
-#define PM_PLL_LCD_I2S_CTRL_REG_OFFSET_PLL_LCD_P	(11)
-#define PM_PLL_LCD_I2S_CTRL_REG_OFFSET_PLL_LCD_M	(3)
-#define PM_PLL_LCD_I2S_CTRL_REG_OFFSET_PLL_LCD_S	(0)
-
-/* PM_PLL_HM_PD_CTRL_REG */
-#define PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY1		(11)
-#define PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY0		(10)
-#define PM_PLL_HM_PD_CTRL_REG_OFFSET_PLL_I2SCD		(6)
-#define PM_PLL_HM_PD_CTRL_REG_OFFSET_PLL_I2S		(5)
-#define PM_PLL_HM_PD_CTRL_REG_OFFSET_PLL_LCD		(4)
-#define PM_PLL_HM_PD_CTRL_REG_OFFSET_PLL_USB		(3)
-#define PM_PLL_HM_PD_CTRL_REG_OFFSET_PLL_RGMII		(2)
-#define PM_PLL_HM_PD_CTRL_REG_MASK			(0x00000C7C)
-
-/* PM_WDT_CTRL_REG */
-#define PM_WDT_CTRL_REG_OFFSET_RESET_CPU_ONLY		(0)
-
-/* PM_CSR_REG - Clock Scaling Register*/
-#define PM_CSR_REG_OFFSET_CSR_EN			(30)
-#define PM_CSR_REG_OFFSET_CSR_NUM			(0)
-
-#define CNS3XXX_PWR_CLK_EN(BLOCK) (0x1<<PM_CLK_GATE_REG_OFFSET_##BLOCK)
-
-/* Software reset*/
-#define CNS3XXX_PWR_SOFTWARE_RST(BLOCK) (0x1<<PM_SOFT_RST_REG_OFFST_##BLOCK)
-
-/*
- * CNS3XXX support several power saving mode as following,
- * DFS, IDLE, HALT, DOZE, SLEEP, Hibernate
- */
-#define CNS3XXX_PWR_CPU_MODE_DFS			(0)
-#define CNS3XXX_PWR_CPU_MODE_IDLE			(1)
-#define CNS3XXX_PWR_CPU_MODE_HALT			(2)
-#define CNS3XXX_PWR_CPU_MODE_DOZE			(3)
-#define CNS3XXX_PWR_CPU_MODE_SLEEP			(4)
-#define CNS3XXX_PWR_CPU_MODE_HIBERNATE			(5)
-
-#define CNS3XXX_PWR_PLL(BLOCK)	(0x1<<PM_PLL_HM_PD_CTRL_REG_OFFSET_##BLOCK)
-#define CNS3XXX_PWR_PLL_ALL	PM_PLL_HM_PD_CTRL_REG_MASK
-
-/* Change CPU frequency and divider */
-#define CNS3XXX_PWR_PLL_CPU_300MHZ			(0)
-#define CNS3XXX_PWR_PLL_CPU_333MHZ			(1)
-#define CNS3XXX_PWR_PLL_CPU_366MHZ			(2)
-#define CNS3XXX_PWR_PLL_CPU_400MHZ			(3)
-#define CNS3XXX_PWR_PLL_CPU_433MHZ			(4)
-#define CNS3XXX_PWR_PLL_CPU_466MHZ			(5)
-#define CNS3XXX_PWR_PLL_CPU_500MHZ			(6)
-#define CNS3XXX_PWR_PLL_CPU_533MHZ			(7)
-#define CNS3XXX_PWR_PLL_CPU_566MHZ			(8)
-#define CNS3XXX_PWR_PLL_CPU_600MHZ			(9)
-#define CNS3XXX_PWR_PLL_CPU_633MHZ			(10)
-#define CNS3XXX_PWR_PLL_CPU_666MHZ			(11)
-#define CNS3XXX_PWR_PLL_CPU_700MHZ			(12)
-
-#define CNS3XXX_PWR_CPU_CLK_DIV_BY1			(0)
-#define CNS3XXX_PWR_CPU_CLK_DIV_BY2			(1)
-#define CNS3XXX_PWR_CPU_CLK_DIV_BY4			(2)
-
-/* Change DDR2 frequency */
-#define CNS3XXX_PWR_PLL_DDR2_200MHZ			(0)
-#define CNS3XXX_PWR_PLL_DDR2_266MHZ			(1)
-#define CNS3XXX_PWR_PLL_DDR2_333MHZ			(2)
-#define CNS3XXX_PWR_PLL_DDR2_400MHZ			(3)
-
-void cns3xxx_pwr_soft_rst(unsigned int block);
-void cns3xxx_pwr_clk_en(unsigned int block);
-int cns3xxx_cpu_clock(void);
-
-/*
- * ARM11 MPCore interrupt sources (primary GIC)
- */
-#define IRQ_TC11MP_GIC_START	32
-
-#define IRQ_CNS3XXX_PMU			(IRQ_TC11MP_GIC_START + 0)
-#define IRQ_CNS3XXX_SDIO		(IRQ_TC11MP_GIC_START + 1)
-#define IRQ_CNS3XXX_L2CC		(IRQ_TC11MP_GIC_START + 2)
-#define IRQ_CNS3XXX_RTC			(IRQ_TC11MP_GIC_START + 3)
-#define IRQ_CNS3XXX_I2S			(IRQ_TC11MP_GIC_START + 4)
-#define IRQ_CNS3XXX_PCM			(IRQ_TC11MP_GIC_START + 5)
-#define IRQ_CNS3XXX_SPI			(IRQ_TC11MP_GIC_START + 6)
-#define IRQ_CNS3XXX_I2C			(IRQ_TC11MP_GIC_START + 7)
-#define IRQ_CNS3XXX_CIM			(IRQ_TC11MP_GIC_START + 8)
-#define IRQ_CNS3XXX_GPU			(IRQ_TC11MP_GIC_START + 9)
-#define IRQ_CNS3XXX_LCD			(IRQ_TC11MP_GIC_START + 10)
-#define IRQ_CNS3XXX_GPIOA		(IRQ_TC11MP_GIC_START + 11)
-#define IRQ_CNS3XXX_GPIOB		(IRQ_TC11MP_GIC_START + 12)
-#define IRQ_CNS3XXX_UART0		(IRQ_TC11MP_GIC_START + 13)
-#define IRQ_CNS3XXX_UART1		(IRQ_TC11MP_GIC_START + 14)
-#define IRQ_CNS3XXX_UART2		(IRQ_TC11MP_GIC_START + 15)
-#define IRQ_CNS3XXX_ARM11		(IRQ_TC11MP_GIC_START + 16)
-
-#define IRQ_CNS3XXX_SW_STATUS		(IRQ_TC11MP_GIC_START + 17)
-#define IRQ_CNS3XXX_SW_R0TXC		(IRQ_TC11MP_GIC_START + 18)
-#define IRQ_CNS3XXX_SW_R0RXC		(IRQ_TC11MP_GIC_START + 19)
-#define IRQ_CNS3XXX_SW_R0QE		(IRQ_TC11MP_GIC_START + 20)
-#define IRQ_CNS3XXX_SW_R0QF		(IRQ_TC11MP_GIC_START + 21)
-#define IRQ_CNS3XXX_SW_R1TXC		(IRQ_TC11MP_GIC_START + 22)
-#define IRQ_CNS3XXX_SW_R1RXC		(IRQ_TC11MP_GIC_START + 23)
-#define IRQ_CNS3XXX_SW_R1QE		(IRQ_TC11MP_GIC_START + 24)
-#define IRQ_CNS3XXX_SW_R1QF		(IRQ_TC11MP_GIC_START + 25)
-#define IRQ_CNS3XXX_SW_PPE		(IRQ_TC11MP_GIC_START + 26)
-
-#define IRQ_CNS3XXX_CRYPTO		(IRQ_TC11MP_GIC_START + 27)
-#define IRQ_CNS3XXX_HCIE		(IRQ_TC11MP_GIC_START + 28)
-#define IRQ_CNS3XXX_PCIE0_DEVICE	(IRQ_TC11MP_GIC_START + 29)
-#define IRQ_CNS3XXX_PCIE1_DEVICE	(IRQ_TC11MP_GIC_START + 30)
-#define IRQ_CNS3XXX_USB_OTG		(IRQ_TC11MP_GIC_START + 31)
-#define IRQ_CNS3XXX_USB_EHCI		(IRQ_TC11MP_GIC_START + 32)
-#define IRQ_CNS3XXX_SATA		(IRQ_TC11MP_GIC_START + 33)
-#define IRQ_CNS3XXX_RAID		(IRQ_TC11MP_GIC_START + 34)
-#define IRQ_CNS3XXX_SMC			(IRQ_TC11MP_GIC_START + 35)
-
-#define IRQ_CNS3XXX_DMAC_ABORT		(IRQ_TC11MP_GIC_START + 36)
-#define IRQ_CNS3XXX_DMAC0		(IRQ_TC11MP_GIC_START + 37)
-#define IRQ_CNS3XXX_DMAC1		(IRQ_TC11MP_GIC_START + 38)
-#define IRQ_CNS3XXX_DMAC2		(IRQ_TC11MP_GIC_START + 39)
-#define IRQ_CNS3XXX_DMAC3		(IRQ_TC11MP_GIC_START + 40)
-#define IRQ_CNS3XXX_DMAC4		(IRQ_TC11MP_GIC_START + 41)
-#define IRQ_CNS3XXX_DMAC5		(IRQ_TC11MP_GIC_START + 42)
-#define IRQ_CNS3XXX_DMAC6		(IRQ_TC11MP_GIC_START + 43)
-#define IRQ_CNS3XXX_DMAC7		(IRQ_TC11MP_GIC_START + 44)
-#define IRQ_CNS3XXX_DMAC8		(IRQ_TC11MP_GIC_START + 45)
-#define IRQ_CNS3XXX_DMAC9		(IRQ_TC11MP_GIC_START + 46)
-#define IRQ_CNS3XXX_DMAC10		(IRQ_TC11MP_GIC_START + 47)
-#define IRQ_CNS3XXX_DMAC11		(IRQ_TC11MP_GIC_START + 48)
-#define IRQ_CNS3XXX_DMAC12		(IRQ_TC11MP_GIC_START + 49)
-#define IRQ_CNS3XXX_DMAC13		(IRQ_TC11MP_GIC_START + 50)
-#define IRQ_CNS3XXX_DMAC14		(IRQ_TC11MP_GIC_START + 51)
-#define IRQ_CNS3XXX_DMAC15		(IRQ_TC11MP_GIC_START + 52)
-#define IRQ_CNS3XXX_DMAC16		(IRQ_TC11MP_GIC_START + 53)
-#define IRQ_CNS3XXX_DMAC17		(IRQ_TC11MP_GIC_START + 54)
-
-#define IRQ_CNS3XXX_PCIE0_RC		(IRQ_TC11MP_GIC_START + 55)
-#define IRQ_CNS3XXX_PCIE1_RC		(IRQ_TC11MP_GIC_START + 56)
-#define IRQ_CNS3XXX_TIMER0		(IRQ_TC11MP_GIC_START + 57)
-#define IRQ_CNS3XXX_TIMER1		(IRQ_TC11MP_GIC_START + 58)
-#define IRQ_CNS3XXX_USB_OHCI		(IRQ_TC11MP_GIC_START + 59)
-#define IRQ_CNS3XXX_TIMER2		(IRQ_TC11MP_GIC_START + 60)
-#define IRQ_CNS3XXX_EXTERNAL_PIN0	(IRQ_TC11MP_GIC_START + 61)
-#define IRQ_CNS3XXX_EXTERNAL_PIN1	(IRQ_TC11MP_GIC_START + 62)
-#define IRQ_CNS3XXX_EXTERNAL_PIN2	(IRQ_TC11MP_GIC_START + 63)
-
-#define NR_IRQS_CNS3XXX			(IRQ_TC11MP_GIC_START + 64)
-
-#endif	/* __MACH_BOARD_CNS3XXX_H */
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
deleted file mode 100644
index 3fc4ec830e3a..000000000000
--- a/arch/arm/mach-cns3xxx/core.c
+++ /dev/null
@@ -1,410 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 1999 - 2003 ARM Limited
- * Copyright 2000 Deep Blue Solutions Ltd
- * Copyright 2008 Cavium Networks
- */
-
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/clockchips.h>
-#include <linux/io.h>
-#include <linux/irqchip/arm-gic.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
-#include <linux/usb/ehci_pdriver.h>
-#include <linux/usb/ohci_pdriver.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/time.h>
-#include <asm/mach/irq.h>
-#include <asm/hardware/cache-l2x0.h>
-#include "cns3xxx.h"
-#include "core.h"
-#include "pm.h"
-
-static struct map_desc cns3xxx_io_desc[] __initdata = {
-	{
-		.virtual	= CNS3XXX_TC11MP_SCU_BASE_VIRT,
-		.pfn		= __phys_to_pfn(CNS3XXX_TC11MP_SCU_BASE),
-		.length		= SZ_8K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= CNS3XXX_TIMER1_2_3_BASE_VIRT,
-		.pfn		= __phys_to_pfn(CNS3XXX_TIMER1_2_3_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= CNS3XXX_MISC_BASE_VIRT,
-		.pfn		= __phys_to_pfn(CNS3XXX_MISC_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= CNS3XXX_PM_BASE_VIRT,
-		.pfn		= __phys_to_pfn(CNS3XXX_PM_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-#ifdef CONFIG_PCI
-	}, {
-		.virtual	= CNS3XXX_PCIE0_HOST_BASE_VIRT,
-		.pfn		= __phys_to_pfn(CNS3XXX_PCIE0_HOST_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= CNS3XXX_PCIE0_CFG0_BASE_VIRT,
-		.pfn		= __phys_to_pfn(CNS3XXX_PCIE0_CFG0_BASE),
-		.length		= SZ_64K, /* really 4 KiB at offset 32 KiB */
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= CNS3XXX_PCIE0_CFG1_BASE_VIRT,
-		.pfn		= __phys_to_pfn(CNS3XXX_PCIE0_CFG1_BASE),
-		.length		= SZ_16M,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= CNS3XXX_PCIE1_HOST_BASE_VIRT,
-		.pfn		= __phys_to_pfn(CNS3XXX_PCIE1_HOST_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= CNS3XXX_PCIE1_CFG0_BASE_VIRT,
-		.pfn		= __phys_to_pfn(CNS3XXX_PCIE1_CFG0_BASE),
-		.length		= SZ_64K, /* really 4 KiB at offset 32 KiB */
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= CNS3XXX_PCIE1_CFG1_BASE_VIRT,
-		.pfn		= __phys_to_pfn(CNS3XXX_PCIE1_CFG1_BASE),
-		.length		= SZ_16M,
-		.type		= MT_DEVICE,
-#endif
-	},
-};
-
-void __init cns3xxx_map_io(void)
-{
-	iotable_init(cns3xxx_io_desc, ARRAY_SIZE(cns3xxx_io_desc));
-}
-
-/* used by entry-macro.S */
-void __init cns3xxx_init_irq(void)
-{
-	gic_init(IOMEM(CNS3XXX_TC11MP_GIC_DIST_BASE_VIRT),
-		 IOMEM(CNS3XXX_TC11MP_GIC_CPU_BASE_VIRT));
-}
-
-void cns3xxx_power_off(void)
-{
-	u32 __iomem *pm_base = IOMEM(CNS3XXX_PM_BASE_VIRT);
-	u32 clkctrl;
-
-	printk(KERN_INFO "powering system down...\n");
-
-	clkctrl = readl(pm_base + PM_SYS_CLK_CTRL_OFFSET);
-	clkctrl &= 0xfffff1ff;
-	clkctrl |= (0x5 << 9);		/* Hibernate */
-	writel(clkctrl, pm_base + PM_SYS_CLK_CTRL_OFFSET);
-
-}
-
-/*
- * Timer
- */
-static void __iomem *cns3xxx_tmr1;
-
-static int cns3xxx_shutdown(struct clock_event_device *clk)
-{
-	writel(0, cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
-	return 0;
-}
-
-static int cns3xxx_set_oneshot(struct clock_event_device *clk)
-{
-	unsigned long ctrl = readl(cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
-
-	/* period set, and timer enabled in 'next_event' hook */
-	ctrl |= (1 << 2) | (1 << 9);
-	writel(ctrl, cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
-	return 0;
-}
-
-static int cns3xxx_set_periodic(struct clock_event_device *clk)
-{
-	unsigned long ctrl = readl(cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
-	int pclk = cns3xxx_cpu_clock() / 8;
-	int reload;
-
-	reload = pclk * 20 / (3 * HZ) * 0x25000;
-	writel(reload, cns3xxx_tmr1 + TIMER1_AUTO_RELOAD_OFFSET);
-	ctrl |= (1 << 0) | (1 << 2) | (1 << 9);
-	writel(ctrl, cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
-	return 0;
-}
-
-static int cns3xxx_timer_set_next_event(unsigned long evt,
-					struct clock_event_device *unused)
-{
-	unsigned long ctrl = readl(cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
-
-	writel(evt, cns3xxx_tmr1 + TIMER1_AUTO_RELOAD_OFFSET);
-	writel(ctrl | (1 << 0), cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
-
-	return 0;
-}
-
-static struct clock_event_device cns3xxx_tmr1_clockevent = {
-	.name			= "cns3xxx timer1",
-	.features		= CLOCK_EVT_FEAT_PERIODIC |
-				  CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_shutdown	= cns3xxx_shutdown,
-	.set_state_periodic	= cns3xxx_set_periodic,
-	.set_state_oneshot	= cns3xxx_set_oneshot,
-	.tick_resume		= cns3xxx_shutdown,
-	.set_next_event		= cns3xxx_timer_set_next_event,
-	.rating			= 350,
-	.cpumask		= cpu_all_mask,
-};
-
-static void __init cns3xxx_clockevents_init(unsigned int timer_irq)
-{
-	cns3xxx_tmr1_clockevent.irq = timer_irq;
-	clockevents_config_and_register(&cns3xxx_tmr1_clockevent,
-					(cns3xxx_cpu_clock() >> 3) * 1000000,
-					0xf, 0xffffffff);
-}
-
-/*
- * IRQ handler for the timer
- */
-static irqreturn_t cns3xxx_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = &cns3xxx_tmr1_clockevent;
-	u32 __iomem *stat = cns3xxx_tmr1 + TIMER1_2_INTERRUPT_STATUS_OFFSET;
-	u32 val;
-
-	/* Clear the interrupt */
-	val = readl(stat);
-	writel(val & ~(1 << 2), stat);
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-/*
- * Set up the clock source and clock events devices
- */
-static void __init __cns3xxx_timer_init(unsigned int timer_irq)
-{
-	u32 val;
-	u32 irq_mask;
-
-	/*
-	 * Initialise to a known state (all timers off)
-	 */
-
-	/* disable timer1 and timer2 */
-	writel(0, cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
-	/* stop free running timer3 */
-	writel(0, cns3xxx_tmr1 + TIMER_FREERUN_CONTROL_OFFSET);
-
-	/* timer1 */
-	writel(0x5C800, cns3xxx_tmr1 + TIMER1_COUNTER_OFFSET);
-	writel(0x5C800, cns3xxx_tmr1 + TIMER1_AUTO_RELOAD_OFFSET);
-
-	writel(0, cns3xxx_tmr1 + TIMER1_MATCH_V1_OFFSET);
-	writel(0, cns3xxx_tmr1 + TIMER1_MATCH_V2_OFFSET);
-
-	/* mask irq, non-mask timer1 overflow */
-	irq_mask = readl(cns3xxx_tmr1 + TIMER1_2_INTERRUPT_MASK_OFFSET);
-	irq_mask &= ~(1 << 2);
-	irq_mask |= 0x03;
-	writel(irq_mask, cns3xxx_tmr1 + TIMER1_2_INTERRUPT_MASK_OFFSET);
-
-	/* down counter */
-	val = readl(cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
-	val |= (1 << 9);
-	writel(val, cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
-
-	/* timer2 */
-	writel(0, cns3xxx_tmr1 + TIMER2_MATCH_V1_OFFSET);
-	writel(0, cns3xxx_tmr1 + TIMER2_MATCH_V2_OFFSET);
-
-	/* mask irq */
-	irq_mask = readl(cns3xxx_tmr1 + TIMER1_2_INTERRUPT_MASK_OFFSET);
-	irq_mask |= ((1 << 3) | (1 << 4) | (1 << 5));
-	writel(irq_mask, cns3xxx_tmr1 + TIMER1_2_INTERRUPT_MASK_OFFSET);
-
-	/* down counter */
-	val = readl(cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
-	val |= (1 << 10);
-	writel(val, cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
-
-	/* Make irqs happen for the system timer */
-	if (request_irq(timer_irq, cns3xxx_timer_interrupt,
-			IRQF_TIMER | IRQF_IRQPOLL, "timer", NULL))
-		pr_err("Failed to request irq %d (timer)\n", timer_irq);
-
-	cns3xxx_clockevents_init(timer_irq);
-}
-
-void __init cns3xxx_timer_init(void)
-{
-	cns3xxx_tmr1 = IOMEM(CNS3XXX_TIMER1_2_3_BASE_VIRT);
-
-	__cns3xxx_timer_init(IRQ_CNS3XXX_TIMER0);
-}
-
-#ifdef CONFIG_CACHE_L2X0
-
-void __init cns3xxx_l2x0_init(void)
-{
-	void __iomem *base = ioremap(CNS3XXX_L2C_BASE, SZ_4K);
-	u32 val;
-
-	if (WARN_ON(!base))
-		return;
-
-	/*
-	 * Tag RAM Control register
-	 *
-	 * bit[10:8]	- 1 cycle of write accesses latency
-	 * bit[6:4]	- 1 cycle of read accesses latency
-	 * bit[3:0]	- 1 cycle of setup latency
-	 *
-	 * 1 cycle of latency for setup, read and write accesses
-	 */
-	val = readl(base + L310_TAG_LATENCY_CTRL);
-	val &= 0xfffff888;
-	writel(val, base + L310_TAG_LATENCY_CTRL);
-
-	/*
-	 * Data RAM Control register
-	 *
-	 * bit[10:8]	- 1 cycles of write accesses latency
-	 * bit[6:4]	- 1 cycles of read accesses latency
-	 * bit[3:0]	- 1 cycle of setup latency
-	 *
-	 * 1 cycle of latency for setup, read and write accesses
-	 */
-	val = readl(base + L310_DATA_LATENCY_CTRL);
-	val &= 0xfffff888;
-	writel(val, base + L310_DATA_LATENCY_CTRL);
-
-	/* 32 KiB, 8-way, parity disable */
-	l2x0_init(base, 0x00500000, 0xfe0f0fff);
-}
-
-#endif /* CONFIG_CACHE_L2X0 */
-
-static int csn3xxx_usb_power_on(struct platform_device *pdev)
-{
-	/*
-	 * EHCI and OHCI share the same clock and power,
-	 * resetting twice would cause the 1st controller been reset.
-	 * Therefore only do power up  at the first up device, and
-	 * power down at the last down device.
-	 *
-	 * Set USB AHB INCR length to 16
-	 */
-	if (atomic_inc_return(&usb_pwr_ref) == 1) {
-		cns3xxx_pwr_power_up(1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_PLL_USB);
-		cns3xxx_pwr_clk_en(1 << PM_CLK_GATE_REG_OFFSET_USB_HOST);
-		cns3xxx_pwr_soft_rst(1 << PM_SOFT_RST_REG_OFFST_USB_HOST);
-		__raw_writel((__raw_readl(MISC_CHIP_CONFIG_REG) | (0X2 << 24)),
-			MISC_CHIP_CONFIG_REG);
-	}
-
-	return 0;
-}
-
-static void csn3xxx_usb_power_off(struct platform_device *pdev)
-{
-	/*
-	 * EHCI and OHCI share the same clock and power,
-	 * resetting twice would cause the 1st controller been reset.
-	 * Therefore only do power up  at the first up device, and
-	 * power down at the last down device.
-	 */
-	if (atomic_dec_return(&usb_pwr_ref) == 0)
-		cns3xxx_pwr_clk_dis(1 << PM_CLK_GATE_REG_OFFSET_USB_HOST);
-}
-
-static struct usb_ehci_pdata cns3xxx_usb_ehci_pdata = {
-	.power_on	= csn3xxx_usb_power_on,
-	.power_off	= csn3xxx_usb_power_off,
-};
-
-static struct usb_ohci_pdata cns3xxx_usb_ohci_pdata = {
-	.num_ports	= 1,
-	.power_on	= csn3xxx_usb_power_on,
-	.power_off	= csn3xxx_usb_power_off,
-};
-
-static const struct of_dev_auxdata cns3xxx_auxdata[] __initconst = {
-	{ "intel,usb-ehci", CNS3XXX_USB_BASE, "ehci-platform", &cns3xxx_usb_ehci_pdata },
-	{ "intel,usb-ohci", CNS3XXX_USB_OHCI_BASE, "ohci-platform", &cns3xxx_usb_ohci_pdata },
-	{ "cavium,cns3420-ahci", CNS3XXX_SATA2_BASE, "ahci", NULL },
-	{ "cavium,cns3420-sdhci", CNS3XXX_SDIO_BASE, "ahci", NULL },
-	{},
-};
-
-static void __init cns3xxx_init(void)
-{
-	struct device_node *dn;
-
-	cns3xxx_l2x0_init();
-
-	dn = of_find_compatible_node(NULL, NULL, "cavium,cns3420-ahci");
-	if (of_device_is_available(dn)) {
-		u32 tmp;
-	
-		tmp = __raw_readl(MISC_SATA_POWER_MODE);
-		tmp |= 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mode */
-		tmp |= 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mode */
-		__raw_writel(tmp, MISC_SATA_POWER_MODE);
-	
-		/* Enable SATA PHY */
-		cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY0);
-		cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY1);
-	
-		/* Enable SATA Clock */
-		cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
-	
-		/* De-Asscer SATA Reset */
-		cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
-	}
-	of_node_put(dn);
-
-	dn = of_find_compatible_node(NULL, NULL, "cavium,cns3420-sdhci");
-	if (of_device_is_available(dn)) {
-		u32 __iomem *gpioa = IOMEM(CNS3XXX_MISC_BASE_VIRT + 0x0014);
-		u32 gpioa_pins = __raw_readl(gpioa);
-	
-		/* MMC/SD pins share with GPIOA */
-		gpioa_pins |= 0x1fff0004;
-		__raw_writel(gpioa_pins, gpioa);
-	
-		cns3xxx_pwr_clk_en(CNS3XXX_PWR_CLK_EN(SDIO));
-		cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SDIO));
-	}
-	of_node_put(dn);
-
-	pm_power_off = cns3xxx_power_off;
-
-	of_platform_default_populate(NULL, cns3xxx_auxdata, NULL);
-}
-
-static const char *const cns3xxx_dt_compat[] __initconst = {
-	"cavium,cns3410",
-	"cavium,cns3420",
-	NULL,
-};
-
-DT_MACHINE_START(CNS3XXX_DT, "Cavium Networks CNS3xxx")
-	.dt_compat	= cns3xxx_dt_compat,
-	.map_io		= cns3xxx_map_io,
-	.init_irq	= cns3xxx_init_irq,
-	.init_time	= cns3xxx_timer_init,
-	.init_machine	= cns3xxx_init,
-	.init_late	= cns3xxx_pcie_init_late,
-	.restart	= cns3xxx_restart,
-MACHINE_END
diff --git a/arch/arm/mach-cns3xxx/core.h b/arch/arm/mach-cns3xxx/core.h
deleted file mode 100644
index a96eabaea301..000000000000
--- a/arch/arm/mach-cns3xxx/core.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2000 Deep Blue Solutions Ltd
- * Copyright 2004 ARM Limited
- * Copyright 2008 Cavium Networks
- */
-
-#ifndef __CNS3XXX_CORE_H
-#define __CNS3XXX_CORE_H
-
-#include <linux/reboot.h>
-
-extern void cns3xxx_timer_init(void);
-
-#ifdef CONFIG_CACHE_L2X0
-void __init cns3xxx_l2x0_init(void);
-#else
-static inline void cns3xxx_l2x0_init(void) {}
-#endif /* CONFIG_CACHE_L2X0 */
-
-#ifdef CONFIG_PCI
-extern void __init cns3xxx_pcie_init_late(void);
-#else
-static inline void __init cns3xxx_pcie_init_late(void) {}
-#endif
-
-void __init cns3xxx_map_io(void);
-void __init cns3xxx_init_irq(void);
-void cns3xxx_power_off(void);
-void cns3xxx_restart(enum reboot_mode, const char *);
-
-#endif /* __CNS3XXX_CORE_H */
diff --git a/arch/arm/mach-cns3xxx/devices.c b/arch/arm/mach-cns3xxx/devices.c
deleted file mode 100644
index 0f1ba8a0377d..000000000000
--- a/arch/arm/mach-cns3xxx/devices.c
+++ /dev/null
@@ -1,108 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * CNS3xxx common devices
- *
- * Copyright 2008 Cavium Networks
- *		  Scott Shu
- * Copyright 2010 MontaVista Software, LLC.
- *		  Anton Vorontsov <avorontsov@mvista.com>
- */
-
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/compiler.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-#include "cns3xxx.h"
-#include "pm.h"
-#include "core.h"
-#include "devices.h"
-
-/*
- * AHCI
- */
-static struct resource cns3xxx_ahci_resource[] = {
-	[0] = {
-		.start	= CNS3XXX_SATA2_BASE,
-		.end	= CNS3XXX_SATA2_BASE + CNS3XXX_SATA2_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_CNS3XXX_SATA,
-		.end	= IRQ_CNS3XXX_SATA,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 cns3xxx_ahci_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device cns3xxx_ahci_pdev = {
-	.name		= "ahci",
-	.id		= 0,
-	.resource	= cns3xxx_ahci_resource,
-	.num_resources	= ARRAY_SIZE(cns3xxx_ahci_resource),
-	.dev		= {
-		.dma_mask		= &cns3xxx_ahci_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-void __init cns3xxx_ahci_init(void)
-{
-	u32 tmp;
-
-	tmp = __raw_readl(MISC_SATA_POWER_MODE);
-	tmp |= 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mode */
-	tmp |= 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mode */
-	__raw_writel(tmp, MISC_SATA_POWER_MODE);
-
-	/* Enable SATA PHY */
-	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY0);
-	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY1);
-
-	/* Enable SATA Clock */
-	cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
-
-	/* De-Asscer SATA Reset */
-	cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
-
-	platform_device_register(&cns3xxx_ahci_pdev);
-}
-
-/*
- * SDHCI
- */
-static struct resource cns3xxx_sdhci_resources[] = {
-	[0] = {
-		.start = CNS3XXX_SDIO_BASE,
-		.end   = CNS3XXX_SDIO_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_CNS3XXX_SDIO,
-		.end   = IRQ_CNS3XXX_SDIO,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device cns3xxx_sdhci_pdev = {
-	.name		= "sdhci-cns3xxx",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(cns3xxx_sdhci_resources),
-	.resource	= cns3xxx_sdhci_resources,
-};
-
-void __init cns3xxx_sdhci_init(void)
-{
-	u32 __iomem *gpioa = IOMEM(CNS3XXX_MISC_BASE_VIRT + 0x0014);
-	u32 gpioa_pins = __raw_readl(gpioa);
-
-	/* MMC/SD pins share with GPIOA */
-	gpioa_pins |= 0x1fff0004;
-	__raw_writel(gpioa_pins, gpioa);
-
-	cns3xxx_pwr_clk_en(CNS3XXX_PWR_CLK_EN(SDIO));
-	cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SDIO));
-
-	platform_device_register(&cns3xxx_sdhci_pdev);
-}
diff --git a/arch/arm/mach-cns3xxx/devices.h b/arch/arm/mach-cns3xxx/devices.h
deleted file mode 100644
index ab16530d0116..000000000000
--- a/arch/arm/mach-cns3xxx/devices.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * CNS3xxx common devices
- *
- * Copyright 2008 Cavium Networks
- *		  Scott Shu
- * Copyright 2010 MontaVista Software, LLC.
- *		  Anton Vorontsov <avorontsov@mvista.com>
- */
-
-#ifndef __CNS3XXX_DEVICES_H_
-#define __CNS3XXX_DEVICES_H_
-
-void __init cns3xxx_ahci_init(void);
-void __init cns3xxx_sdhci_init(void);
-
-#endif /* __CNS3XXX_DEVICES_H_ */
diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
deleted file mode 100644
index e92fbd679dfb..000000000000
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ /dev/null
@@ -1,290 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * PCI-E support for CNS3xxx
- *
- * Copyright 2008 Cavium Networks
- *		  Richard Liu <richard.liu@caviumnetworks.com>
- * Copyright 2010 MontaVista Software, LLC.
- *		  Anton Vorontsov <avorontsov@mvista.com>
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/bug.h>
-#include <linux/pci.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/interrupt.h>
-#include <linux/ptrace.h>
-#include <asm/mach/map.h>
-#include "cns3xxx.h"
-#include "core.h"
-
-struct cns3xxx_pcie {
-	void __iomem *host_regs; /* PCI config registers for host bridge */
-	void __iomem *cfg0_regs; /* PCI Type 0 config registers */
-	void __iomem *cfg1_regs; /* PCI Type 1 config registers */
-	unsigned int irqs[2];
-	struct resource res_io;
-	struct resource res_mem;
-	int port;
-	bool linked;
-};
-
-static struct cns3xxx_pcie *sysdata_to_cnspci(void *sysdata)
-{
-	struct pci_sys_data *root = sysdata;
-
-	return root->private_data;
-}
-
-static struct cns3xxx_pcie *pdev_to_cnspci(const struct pci_dev *dev)
-{
-	return sysdata_to_cnspci(dev->sysdata);
-}
-
-static struct cns3xxx_pcie *pbus_to_cnspci(struct pci_bus *bus)
-{
-	return sysdata_to_cnspci(bus->sysdata);
-}
-
-static void __iomem *cns3xxx_pci_map_bus(struct pci_bus *bus,
-					 unsigned int devfn, int where)
-{
-	struct cns3xxx_pcie *cnspci = pbus_to_cnspci(bus);
-	int busno = bus->number;
-	int slot = PCI_SLOT(devfn);
-	void __iomem *base;
-
-	/* If there is no link, just show the CNS PCI bridge. */
-	if (!cnspci->linked && busno > 0)
-		return NULL;
-
-	/*
-	 * The CNS PCI bridge doesn't fit into the PCI hierarchy, though
-	 * we still want to access it.
-	 * We place the host bridge on bus 0, and the directly connected
-	 * device on bus 1, slot 0.
-	 */
-	if (busno == 0) { /* internal PCIe bus, host bridge device */
-		if (devfn == 0) /* device# and function# are ignored by hw */
-			base = cnspci->host_regs;
-		else
-			return NULL; /* no such device */
-
-	} else if (busno == 1) { /* directly connected PCIe device */
-		if (slot == 0) /* device# is ignored by hw */
-			base = cnspci->cfg0_regs;
-		else
-			return NULL; /* no such device */
-	} else /* remote PCI bus */
-		base = cnspci->cfg1_regs + ((busno & 0xf) << 20);
-
-	return base + where + (devfn << 12);
-}
-
-static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
-				   int where, int size, u32 *val)
-{
-	int ret;
-	u32 mask = (0x1ull << (size * 8)) - 1;
-	int shift = (where % 4) * 8;
-
-	ret = pci_generic_config_read(bus, devfn, where, size, val);
-
-	if (ret == PCIBIOS_SUCCESSFUL && !bus->number && !devfn &&
-	    (where & 0xffc) == PCI_CLASS_REVISION)
-		/*
-		 * RC's class is 0xb, but Linux PCI driver needs 0x604
-		 * for a PCIe bridge. So we must fixup the class code
-		 * to 0x604 here.
-		 */
-		*val = ((((*val << shift) & 0xff) | (0x604 << 16)) >> shift) & mask;
-
-	return ret;
-}
-
-static int cns3xxx_pci_setup(int nr, struct pci_sys_data *sys)
-{
-	struct cns3xxx_pcie *cnspci = sysdata_to_cnspci(sys);
-	struct resource *res_io = &cnspci->res_io;
-	struct resource *res_mem = &cnspci->res_mem;
-
-	BUG_ON(request_resource(&iomem_resource, res_io) ||
-	       request_resource(&iomem_resource, res_mem));
-
-	pci_add_resource_offset(&sys->resources, res_io, sys->io_offset);
-	pci_add_resource_offset(&sys->resources, res_mem, sys->mem_offset);
-
-	return 1;
-}
-
-static struct pci_ops cns3xxx_pcie_ops = {
-	.map_bus = cns3xxx_pci_map_bus,
-	.read = cns3xxx_pci_read_config,
-	.write = pci_generic_config_write,
-};
-
-static int cns3xxx_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	struct cns3xxx_pcie *cnspci = pdev_to_cnspci(dev);
-	int irq = cnspci->irqs[!!dev->bus->number];
-
-	pr_info("PCIe map irq: %04d:%02x:%02x.%02x slot %d, pin %d, irq: %d\n",
-		pci_domain_nr(dev->bus), dev->bus->number, PCI_SLOT(dev->devfn),
-		PCI_FUNC(dev->devfn), slot, pin, irq);
-
-	return irq;
-}
-
-static struct cns3xxx_pcie cns3xxx_pcie[] = {
-	[0] = {
-		.host_regs = (void __iomem *)CNS3XXX_PCIE0_HOST_BASE_VIRT,
-		.cfg0_regs = (void __iomem *)CNS3XXX_PCIE0_CFG0_BASE_VIRT,
-		.cfg1_regs = (void __iomem *)CNS3XXX_PCIE0_CFG1_BASE_VIRT,
-		.res_io = {
-			.name = "PCIe0 I/O space",
-			.start = CNS3XXX_PCIE0_IO_BASE,
-			.end = CNS3XXX_PCIE0_CFG0_BASE - 1, /* 16 MiB */
-			.flags = IORESOURCE_IO,
-		},
-		.res_mem = {
-			.name = "PCIe0 non-prefetchable",
-			.start = CNS3XXX_PCIE0_MEM_BASE,
-			.end = CNS3XXX_PCIE0_HOST_BASE - 1, /* 176 MiB */
-			.flags = IORESOURCE_MEM,
-		},
-		.irqs = { IRQ_CNS3XXX_PCIE0_RC, IRQ_CNS3XXX_PCIE0_DEVICE, },
-		.port = 0,
-	},
-	[1] = {
-		.host_regs = (void __iomem *)CNS3XXX_PCIE1_HOST_BASE_VIRT,
-		.cfg0_regs = (void __iomem *)CNS3XXX_PCIE1_CFG0_BASE_VIRT,
-		.cfg1_regs = (void __iomem *)CNS3XXX_PCIE1_CFG1_BASE_VIRT,
-		.res_io = {
-			.name = "PCIe1 I/O space",
-			.start = CNS3XXX_PCIE1_IO_BASE,
-			.end = CNS3XXX_PCIE1_CFG0_BASE - 1, /* 16 MiB */
-			.flags = IORESOURCE_IO,
-		},
-		.res_mem = {
-			.name = "PCIe1 non-prefetchable",
-			.start = CNS3XXX_PCIE1_MEM_BASE,
-			.end = CNS3XXX_PCIE1_HOST_BASE - 1, /* 176 MiB */
-			.flags = IORESOURCE_MEM,
-		},
-		.irqs = { IRQ_CNS3XXX_PCIE1_RC, IRQ_CNS3XXX_PCIE1_DEVICE, },
-		.port = 1,
-	},
-};
-
-static void __init cns3xxx_pcie_check_link(struct cns3xxx_pcie *cnspci)
-{
-	int port = cnspci->port;
-	u32 reg;
-	unsigned long time;
-
-	reg = __raw_readl(MISC_PCIE_CTRL(port));
-	/*
-	 * Enable Application Request to 1, it will exit L1 automatically,
-	 * but when chip back, it will use another clock, still can use 0x1.
-	 */
-	reg |= 0x3;
-	__raw_writel(reg, MISC_PCIE_CTRL(port));
-
-	pr_info("PCIe: Port[%d] Enable PCIe LTSSM\n", port);
-	pr_info("PCIe: Port[%d] Check data link layer...", port);
-
-	time = jiffies;
-	while (1) {
-		reg = __raw_readl(MISC_PCIE_PM_DEBUG(port));
-		if (reg & 0x1) {
-			pr_info("Link up.\n");
-			cnspci->linked = 1;
-			break;
-		} else if (time_after(jiffies, time + 50)) {
-			pr_info("Device not found.\n");
-			break;
-		}
-	}
-}
-
-static void cns3xxx_write_config(struct cns3xxx_pcie *cnspci,
-					 int where, int size, u32 val)
-{
-	void __iomem *base = cnspci->host_regs + (where & 0xffc);
-	u32 v;
-	u32 mask = (0x1ull << (size * 8)) - 1;
-	int shift = (where % 4) * 8;
-
-	v = readl_relaxed(base);
-
-	v &= ~(mask << shift);
-	v |= (val & mask) << shift;
-
-	writel_relaxed(v, base);
-	readl_relaxed(base);
-}
-
-static void __init cns3xxx_pcie_hw_init(struct cns3xxx_pcie *cnspci)
-{
-	u16 mem_base  = cnspci->res_mem.start >> 16;
-	u16 mem_limit = cnspci->res_mem.end   >> 16;
-	u16 io_base   = cnspci->res_io.start  >> 16;
-	u16 io_limit  = cnspci->res_io.end    >> 16;
-
-	cns3xxx_write_config(cnspci, PCI_PRIMARY_BUS, 1, 0);
-	cns3xxx_write_config(cnspci, PCI_SECONDARY_BUS, 1, 1);
-	cns3xxx_write_config(cnspci, PCI_SUBORDINATE_BUS, 1, 1);
-	cns3xxx_write_config(cnspci, PCI_MEMORY_BASE, 2, mem_base);
-	cns3xxx_write_config(cnspci, PCI_MEMORY_LIMIT, 2, mem_limit);
-	cns3xxx_write_config(cnspci, PCI_IO_BASE_UPPER16, 2, io_base);
-	cns3xxx_write_config(cnspci, PCI_IO_LIMIT_UPPER16, 2, io_limit);
-
-	if (!cnspci->linked)
-		return;
-
-	/* Set Device Max_Read_Request_Size to 128 byte */
-	pcie_bus_config = PCIE_BUS_PEER2PEER;
-
-	/* Disable PCIe0 Interrupt Mask INTA to INTD */
-	__raw_writel(~0x3FFF, MISC_PCIE_INT_MASK(cnspci->port));
-}
-
-static int cns3xxx_pcie_abort_handler(unsigned long addr, unsigned int fsr,
-				      struct pt_regs *regs)
-{
-	if (fsr & (1 << 10))
-		regs->ARM_pc += 4;
-	return 0;
-}
-
-void __init cns3xxx_pcie_init_late(void)
-{
-	int i;
-	void *private_data;
-	struct hw_pci hw_pci = {
-	       .nr_controllers = 1,
-	       .ops = &cns3xxx_pcie_ops,
-	       .setup = cns3xxx_pci_setup,
-	       .map_irq = cns3xxx_pcie_map_irq,
-	       .private_data = &private_data,
-	};
-
-	pcibios_min_io = 0;
-	pcibios_min_mem = 0;
-
-	hook_fault_code(16 + 6, cns3xxx_pcie_abort_handler, SIGBUS, 0,
-			"imprecise external abort");
-
-	for (i = 0; i < ARRAY_SIZE(cns3xxx_pcie); i++) {
-		cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_PCIE(i));
-		cns3xxx_pwr_soft_rst(0x1 << PM_SOFT_RST_REG_OFFST_PCIE(i));
-		cns3xxx_pcie_check_link(&cns3xxx_pcie[i]);
-		cns3xxx_pcie_hw_init(&cns3xxx_pcie[i]);
-		private_data = &cns3xxx_pcie[i];
-		pci_common_init(&hw_pci);
-	}
-
-	pci_assign_unassigned_resources();
-}
diff --git a/arch/arm/mach-cns3xxx/pm.c b/arch/arm/mach-cns3xxx/pm.c
deleted file mode 100644
index 72e8a7ec7a38..000000000000
--- a/arch/arm/mach-cns3xxx/pm.c
+++ /dev/null
@@ -1,120 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2008 Cavium Networks
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/io.h>
-#include <linux/delay.h>
-#include <linux/atomic.h>
-#include "cns3xxx.h"
-#include "pm.h"
-#include "core.h"
-
-void cns3xxx_pwr_clk_en(unsigned int block)
-{
-	u32 reg = __raw_readl(PM_CLK_GATE_REG);
-
-	reg |= (block & PM_CLK_GATE_REG_MASK);
-	__raw_writel(reg, PM_CLK_GATE_REG);
-}
-EXPORT_SYMBOL(cns3xxx_pwr_clk_en);
-
-void cns3xxx_pwr_clk_dis(unsigned int block)
-{
-	u32 reg = __raw_readl(PM_CLK_GATE_REG);
-
-	reg &= ~(block & PM_CLK_GATE_REG_MASK);
-	__raw_writel(reg, PM_CLK_GATE_REG);
-}
-EXPORT_SYMBOL(cns3xxx_pwr_clk_dis);
-
-void cns3xxx_pwr_power_up(unsigned int block)
-{
-	u32 reg = __raw_readl(PM_PLL_HM_PD_CTRL_REG);
-
-	reg &= ~(block & CNS3XXX_PWR_PLL_ALL);
-	__raw_writel(reg, PM_PLL_HM_PD_CTRL_REG);
-
-	/* Wait for 300us for the PLL output clock locked. */
-	udelay(300);
-};
-EXPORT_SYMBOL(cns3xxx_pwr_power_up);
-
-void cns3xxx_pwr_power_down(unsigned int block)
-{
-	u32 reg = __raw_readl(PM_PLL_HM_PD_CTRL_REG);
-
-	/* write '1' to power down */
-	reg |= (block & CNS3XXX_PWR_PLL_ALL);
-	__raw_writel(reg, PM_PLL_HM_PD_CTRL_REG);
-};
-EXPORT_SYMBOL(cns3xxx_pwr_power_down);
-
-static void cns3xxx_pwr_soft_rst_force(unsigned int block)
-{
-	u32 reg = __raw_readl(PM_SOFT_RST_REG);
-
-	/*
-	 * bit 0, 28, 29 => program low to reset,
-	 * the other else program low and then high
-	 */
-	if (block & 0x30000001) {
-		reg &= ~(block & PM_SOFT_RST_REG_MASK);
-	} else {
-		reg &= ~(block & PM_SOFT_RST_REG_MASK);
-		__raw_writel(reg, PM_SOFT_RST_REG);
-		reg |= (block & PM_SOFT_RST_REG_MASK);
-	}
-
-	__raw_writel(reg, PM_SOFT_RST_REG);
-}
-
-void cns3xxx_pwr_soft_rst(unsigned int block)
-{
-	static unsigned int soft_reset;
-
-	if (soft_reset & block) {
-		/* SPI/I2C/GPIO use the same block, reset once. */
-		return;
-	} else {
-		soft_reset |= block;
-	}
-	cns3xxx_pwr_soft_rst_force(block);
-}
-EXPORT_SYMBOL(cns3xxx_pwr_soft_rst);
-
-void cns3xxx_restart(enum reboot_mode mode, const char *cmd)
-{
-	/*
-	 * To reset, we hit the on-board reset register
-	 * in the system FPGA.
-	 */
-	cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(GLOBAL));
-}
-
-/*
- * cns3xxx_cpu_clock - return CPU/L2 clock
- *  aclk: cpu clock/2
- *  hclk: cpu clock/4
- *  pclk: cpu clock/8
- */
-int cns3xxx_cpu_clock(void)
-{
-	u32 reg = __raw_readl(PM_CLK_CTRL_REG);
-	int cpu;
-	int cpu_sel;
-	int div_sel;
-
-	cpu_sel = (reg >> PM_CLK_CTRL_REG_OFFSET_PLL_CPU_SEL) & 0xf;
-	div_sel = (reg >> PM_CLK_CTRL_REG_OFFSET_CPU_CLK_DIV) & 0x3;
-
-	cpu = (300 + ((cpu_sel / 3) * 100) + ((cpu_sel % 3) * 33)) >> div_sel;
-
-	return cpu;
-}
-EXPORT_SYMBOL(cns3xxx_cpu_clock);
-
-atomic_t usb_pwr_ref = ATOMIC_INIT(0);
-EXPORT_SYMBOL(usb_pwr_ref);
diff --git a/arch/arm/mach-cns3xxx/pm.h b/arch/arm/mach-cns3xxx/pm.h
deleted file mode 100644
index 61b73e59f0ff..000000000000
--- a/arch/arm/mach-cns3xxx/pm.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2000 Deep Blue Solutions Ltd
- * Copyright 2004 ARM Limited
- * Copyright 2008 Cavium Networks
- */
-
-#ifndef __CNS3XXX_PM_H
-#define __CNS3XXX_PM_H
-
-#include <linux/atomic.h>
-
-void cns3xxx_pwr_clk_en(unsigned int block);
-void cns3xxx_pwr_clk_dis(unsigned int block);
-void cns3xxx_pwr_power_up(unsigned int block);
-void cns3xxx_pwr_power_down(unsigned int block);
-
-extern atomic_t usb_pwr_ref;
-
-#endif /* __CNS3XXX_PM_H */
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 247568bc17a2..75b8a3eeb23a 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -316,18 +316,6 @@ config USB_OCTEON_HCD
 	  To compile this driver as a module, choose M here. The module
 	  will be called octeon-hcd.
 
-config USB_CNS3XXX_EHCI
-	bool "Cavium CNS3XXX EHCI Module (DEPRECATED)"
-	depends on ARCH_CNS3XXX || COMPILE_TEST
-	select USB_EHCI_HCD_PLATFORM
-	help
-	  This option is deprecated now and the driver was removed, use
-	  USB_EHCI_HCD_PLATFORM instead.
-
-	  Enable support for the CNS3XXX SOC's on-chip EHCI controller.
-	  It is needed for high-speed (480Mbit/sec) USB 2.0 device
-	  support.
-
 config USB_EHCI_HCD_PLATFORM
 	tristate "Generic EHCI driver for a platform device"
 	help
@@ -577,17 +565,6 @@ config USB_OHCI_EXYNOS
 	  Enable support for the Samsung S5Pv210 and Exynos SOC's on-chip OHCI
 	  controller.
 
-config USB_CNS3XXX_OHCI
-	bool "Cavium CNS3XXX OHCI Module (DEPRECATED)"
-	depends on ARCH_CNS3XXX || COMPILE_TEST
-	select USB_OHCI_HCD_PLATFORM
-	help
-	  This option is deprecated now and the driver was removed, use
-	  USB_OHCI_HCD_PLATFORM instead.
-
-	  Enable support for the CNS3XXX SOC's on-chip OHCI controller.
-	  It is needed for low-speed USB 1.0 device support.
-
 config USB_OHCI_HCD_PLATFORM
 	tristate "Generic OHCI driver for a platform device"
 	help
-- 
2.29.2

