Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FABA607BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJUQAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJUQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699497B786
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B36861EFC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C59C433C1;
        Fri, 21 Oct 2022 15:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666368000;
        bh=rpUml0NiTEW2tYPw8yZVCYjbSZGUTQV8kycHtB/fcq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hulMKz/x2uuBqOZaQNr422JCKBeoEvwAV3v0EBUmgu4zKpQN2YC3oJX+8bR2L8Lt4
         4hgzd9qsDTjTXc9Dk//MPvDC7AV9wGGvLwoG5oeeRvuDWI9ozU+Rtg5YUByJOTAtXY
         CV8yJgx+d4gr3W/psxCb7z2xb24mNuhFd9kj1of8NheQfZL8z41gFCG7RiwijDg2pW
         uM0IcvUnTF/vrlXw7anJEoGoYs75tQ66iV2+5YBTctPkWdzIE9zTVS+P/hS9ywk+Gh
         Zp8VHcHM6t/ThsemomuYDT1lJhStQBFOYYZSpaKA6bc75q5zZk1/iFGm17NH4BkvJI
         kLpXngpzAZLSw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 11/11] ARM: mmp: remove old PM support
Date:   Fri, 21 Oct 2022 17:49:41 +0200
Message-Id: <20221021155000.4108406-12-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021155000.4108406-1-arnd@kernel.org>
References: <20221021155000.4108406-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Assuming that we don't actually want the old-style pm-mmp2.c
and pm-pxa910.c implementation, all these files can go away
as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mmp/Kconfig       |   3 -
 arch/arm/mach-mmp/Makefile      |   9 --
 arch/arm/mach-mmp/irqs.h        |  67 ----------
 arch/arm/mach-mmp/mmp2.c        | 106 ----------------
 arch/arm/mach-mmp/mmp2.h        |   8 --
 arch/arm/mach-mmp/pm-mmp2.c     | 214 --------------------------------
 arch/arm/mach-mmp/pm-mmp2.h     |  59 ---------
 arch/arm/mach-mmp/pm-pxa910.c   | 166 -------------------------
 arch/arm/mach-mmp/pm-pxa910.h   |  75 -----------
 arch/arm/mach-mmp/pxa168.c      |  51 --------
 arch/arm/mach-mmp/pxa168.h      |  16 ---
 arch/arm/mach-mmp/pxa910.c      |  93 --------------
 arch/arm/mach-mmp/pxa910.h      |  11 --
 arch/arm/mach-mmp/regs-icu.h    |  69 ----------
 include/linux/soc/mmp/cputype.h |  24 +---
 15 files changed, 1 insertion(+), 970 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/irqs.h
 delete mode 100644 arch/arm/mach-mmp/mmp2.c
 delete mode 100644 arch/arm/mach-mmp/mmp2.h
 delete mode 100644 arch/arm/mach-mmp/pm-mmp2.c
 delete mode 100644 arch/arm/mach-mmp/pm-mmp2.h
 delete mode 100644 arch/arm/mach-mmp/pm-pxa910.c
 delete mode 100644 arch/arm/mach-mmp/pm-pxa910.h
 delete mode 100644 arch/arm/mach-mmp/pxa168.c
 delete mode 100644 arch/arm/mach-mmp/pxa168.h
 delete mode 100644 arch/arm/mach-mmp/pxa910.c
 delete mode 100644 arch/arm/mach-mmp/pxa910.h
 delete mode 100644 arch/arm/mach-mmp/regs-icu.h

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index a1396c495b85..85b0d9ddb7d8 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -20,8 +20,6 @@ config MACH_MMP_DT
 	select PINCTRL_SINGLE
 	select ARCH_HAS_RESET_CONTROLLER
 	select CPU_MOHAWK
-	select CPU_PXA168 if ATAGS
-	select CPU_PXA910 if ATAGS
 	help
 	  Include support for Marvell MMP2 based platforms using
 	  the device tree. Needn't select any other machine while
@@ -34,7 +32,6 @@ config MACH_MMP2_DT
 	select PINCTRL_SINGLE
 	select ARCH_HAS_RESET_CONTROLLER
 	select CPU_PJ4
-	select CPU_MMP2 if ATAGS
 	select PM_GENERIC_DOMAINS if PM
 	select PM_GENERIC_DOMAINS_OF if PM && OF
 	help
diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 95d4217132eb..5d4a1a4a48cf 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -4,15 +4,6 @@
 #
 obj-y				+= common.o time.o
 
-# SoC support
-obj-$(CONFIG_CPU_PXA168)	+= pxa168.o
-obj-$(CONFIG_CPU_PXA910)	+= pxa910.o
-obj-$(CONFIG_CPU_MMP2)		+= mmp2.o
-
-ifeq ($(CONFIG_PM),y)
-obj-$(CONFIG_CPU_PXA910)	+= pm-pxa910.o
-obj-$(CONFIG_CPU_MMP2)		+= pm-mmp2.o
-endif
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_MACH_MMP3_DT)	+= platsmp.o
 endif
diff --git a/arch/arm/mach-mmp/irqs.h b/arch/arm/mach-mmp/irqs.h
deleted file mode 100644
index b8446a17ea55..000000000000
--- a/arch/arm/mach-mmp/irqs.h
+++ /dev/null
@@ -1,67 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_MACH_IRQS_H
-#define __ASM_MACH_IRQS_H
-
-/*
- * Interrupt numbers for PXA910
- */
-#define IRQ_PXA910_NONE			(-1)
-#define IRQ_PXA910_AIRQ			0
-#define IRQ_PXA910_SSP3			1
-#define IRQ_PXA910_SSP2			2
-#define IRQ_PXA910_SSP1			3
-#define IRQ_PXA910_PMIC_INT		4
-#define IRQ_PXA910_RTC_INT		5
-#define IRQ_PXA910_RTC_ALARM		6
-#define IRQ_PXA910_TWSI0		7
-#define IRQ_PXA910_GPU			8
-#define IRQ_PXA910_KEYPAD		9
-#define IRQ_PXA910_ROTARY		10
-#define IRQ_PXA910_TRACKBALL		11
-#define IRQ_PXA910_ONEWIRE		12
-#define IRQ_PXA910_AP1_TIMER1		13
-#define IRQ_PXA910_AP1_TIMER2		14
-#define IRQ_PXA910_AP1_TIMER3		15
-#define IRQ_PXA910_IPC_AP0		16
-#define IRQ_PXA910_IPC_AP1		17
-#define IRQ_PXA910_IPC_AP2		18
-#define IRQ_PXA910_IPC_AP3		19
-#define IRQ_PXA910_IPC_AP4		20
-#define IRQ_PXA910_IPC_CP0		21
-#define IRQ_PXA910_IPC_CP1		22
-#define IRQ_PXA910_IPC_CP2		23
-#define IRQ_PXA910_IPC_CP3		24
-#define IRQ_PXA910_IPC_CP4		25
-#define IRQ_PXA910_L2_DDR		26
-#define IRQ_PXA910_UART2		27
-#define IRQ_PXA910_UART3		28
-#define IRQ_PXA910_AP2_TIMER1		29
-#define IRQ_PXA910_AP2_TIMER2		30
-#define IRQ_PXA910_CP2_TIMER1		31
-#define IRQ_PXA910_CP2_TIMER2		32
-#define IRQ_PXA910_CP2_TIMER3		33
-#define IRQ_PXA910_GSSP			34
-#define IRQ_PXA910_CP2_WDT		35
-#define IRQ_PXA910_MAIN_PMU		36
-#define IRQ_PXA910_CP_FREQ_CHG		37
-#define IRQ_PXA910_AP_FREQ_CHG		38
-#define IRQ_PXA910_MMC			39
-#define IRQ_PXA910_AEU			40
-#define IRQ_PXA910_LCD			41
-#define IRQ_PXA910_CCIC			42
-#define IRQ_PXA910_IRE			43
-#define IRQ_PXA910_USB1			44
-#define IRQ_PXA910_NAND			45
-#define IRQ_PXA910_HIFI_DMA		46
-#define IRQ_PXA910_DMA_INT0		47
-#define IRQ_PXA910_DMA_INT1		48
-#define IRQ_PXA910_AP_GPIO		49
-#define IRQ_PXA910_AP2_TIMER3		50
-#define IRQ_PXA910_USB2			51
-#define IRQ_PXA910_TWSI1		54
-#define IRQ_PXA910_CP_GPIO		55
-#define IRQ_PXA910_UART1		59	/* Slow UART */
-#define IRQ_PXA910_AP_PMU		60
-#define IRQ_PXA910_SM_INT		63	/* from PinMux */
-
-#endif /* __ASM_MACH_IRQS_H */
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
deleted file mode 100644
index 8ee6a4547731..000000000000
--- a/arch/arm/mach-mmp/mmp2.c
+++ /dev/null
@@ -1,106 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/arch/arm/mach-mmp/mmp2.c
- *
- * code name MMP2
- *
- * Copyright (C) 2009 Marvell International Ltd.
- */
-#include <linux/clk/mmp.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/irqchip/mmp.h>
-#include <linux/platform_device.h>
-
-#include <asm/hardware/cache-tauros2.h>
-
-#include <asm/mach/time.h>
-#include "addr-map.h"
-#include <linux/soc/mmp/cputype.h>
-#include <linux/soc/pxa/mfp.h>
-#include "mmp2.h"
-#include "pm-mmp2.h"
-
-#include "common.h"
-
-#define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
-
-static struct mfp_addr_map mmp2_addr_map[] __initdata = {
-
-	MFP_ADDR_X(GPIO0, GPIO58, 0x54),
-	MFP_ADDR_X(GPIO59, GPIO73, 0x280),
-	MFP_ADDR_X(GPIO74, GPIO101, 0x170),
-
-	MFP_ADDR(GPIO102, 0x0),
-	MFP_ADDR(GPIO103, 0x4),
-	MFP_ADDR(GPIO104, 0x1fc),
-	MFP_ADDR(GPIO105, 0x1f8),
-	MFP_ADDR(GPIO106, 0x1f4),
-	MFP_ADDR(GPIO107, 0x1f0),
-	MFP_ADDR(GPIO108, 0x21c),
-	MFP_ADDR(GPIO109, 0x218),
-	MFP_ADDR(GPIO110, 0x214),
-	MFP_ADDR(GPIO111, 0x200),
-	MFP_ADDR(GPIO112, 0x244),
-	MFP_ADDR(GPIO113, 0x25c),
-	MFP_ADDR(GPIO114, 0x164),
-	MFP_ADDR_X(GPIO115, GPIO122, 0x260),
-
-	MFP_ADDR(GPIO123, 0x148),
-	MFP_ADDR_X(GPIO124, GPIO141, 0xc),
-
-	MFP_ADDR(GPIO142, 0x8),
-	MFP_ADDR_X(GPIO143, GPIO151, 0x220),
-	MFP_ADDR_X(GPIO152, GPIO153, 0x248),
-	MFP_ADDR_X(GPIO154, GPIO155, 0x254),
-	MFP_ADDR_X(GPIO156, GPIO159, 0x14c),
-
-	MFP_ADDR(GPIO160, 0x250),
-	MFP_ADDR(GPIO161, 0x210),
-	MFP_ADDR(GPIO162, 0x20c),
-	MFP_ADDR(GPIO163, 0x208),
-	MFP_ADDR(GPIO164, 0x204),
-	MFP_ADDR(GPIO165, 0x1ec),
-	MFP_ADDR(GPIO166, 0x1e8),
-	MFP_ADDR(GPIO167, 0x1e4),
-	MFP_ADDR(GPIO168, 0x1e0),
-
-	MFP_ADDR_X(TWSI1_SCL, TWSI1_SDA, 0x140),
-	MFP_ADDR_X(TWSI4_SCL, TWSI4_SDA, 0x2bc),
-
-	MFP_ADDR(PMIC_INT, 0x2c4),
-	MFP_ADDR(CLK_REQ, 0x160),
-
-	MFP_ADDR_END,
-};
-
-void mmp2_clear_pmic_int(void)
-{
-	void __iomem *mfpr_pmic;
-	unsigned long data;
-
-	mfpr_pmic = APB_VIRT_BASE + 0x1e000 + 0x2c4;
-	data = __raw_readl(mfpr_pmic);
-	__raw_writel(data | (1 << 6), mfpr_pmic);
-	__raw_writel(data, mfpr_pmic);
-}
-
-static int __init mmp2_init(void)
-{
-	if (cpu_is_mmp2()) {
-#ifdef CONFIG_CACHE_TAUROS2
-		tauros2_init(0);
-#endif
-		mfp_init_base(MFPR_VIRT_BASE);
-		mfp_init_addr(mmp2_addr_map);
-		mmp2_clk_init(APB_PHYS_BASE + 0x50000,
-			      AXI_PHYS_BASE + 0x82800,
-			      APB_PHYS_BASE + 0x15000);
-	}
-
-	return 0;
-}
-postcore_initcall(mmp2_init);
diff --git a/arch/arm/mach-mmp/mmp2.h b/arch/arm/mach-mmp/mmp2.h
deleted file mode 100644
index 6616d3f7a0ac..000000000000
--- a/arch/arm/mach-mmp/mmp2.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_MACH_MMP2_H
-#define __ASM_MACH_MMP2_H
-
-extern void mmp2_clear_pmic_int(void);
-
-#endif /* __ASM_MACH_MMP2_H */
-
diff --git a/arch/arm/mach-mmp/pm-mmp2.c b/arch/arm/mach-mmp/pm-mmp2.c
deleted file mode 100644
index bd6563962d77..000000000000
--- a/arch/arm/mach-mmp/pm-mmp2.c
+++ /dev/null
@@ -1,214 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * MMP2 Power Management Routines
- *
- * (C) Copyright 2012 Marvell International Ltd.
- * All Rights Reserved
- */
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/time.h>
-#include <linux/delay.h>
-#include <linux/suspend.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <asm/mach-types.h>
-
-#include <linux/soc/mmp/cputype.h>
-#include "addr-map.h"
-#include "pm-mmp2.h"
-#include "regs-icu.h"
-
-static void pm_scu_clk_disable(void)
-{
-	unsigned int val;
-
-	/* close AXI fabric clock gate */
-	__raw_writel(0x0, CIU_REG(0x64));
-	__raw_writel(0x0, CIU_REG(0x68));
-
-	/* close MCB master clock gate */
-	val = __raw_readl(CIU_REG(0x1c));
-	val |= 0xf0;
-	__raw_writel(val, CIU_REG(0x1c));
-
-	return ;
-}
-
-static void pm_scu_clk_enable(void)
-{
-	unsigned int val;
-
-	/* open AXI fabric clock gate */
-	__raw_writel(0x03003003, CIU_REG(0x64));
-	__raw_writel(0x00303030, CIU_REG(0x68));
-
-	/* open MCB master clock gate */
-	val = __raw_readl(CIU_REG(0x1c));
-	val &= ~(0xf0);
-	__raw_writel(val, CIU_REG(0x1c));
-
-	return ;
-}
-
-static void pm_mpmu_clk_disable(void)
-{
-	/*
-	 * disable clocks in MPMU_CGR_PJ register
-	 * except clock for APMU_PLL1, APMU_PLL1_2 and AP_26M
-	 */
-	__raw_writel(0x0000a010, MPMU_CGR_PJ);
-}
-
-static void pm_mpmu_clk_enable(void)
-{
-	unsigned int val;
-
-	__raw_writel(0xdffefffe, MPMU_CGR_PJ);
-	val = __raw_readl(MPMU_PLL2_CTRL1);
-	val |= (1 << 29);
-	__raw_writel(val, MPMU_PLL2_CTRL1);
-
-	return ;
-}
-
-void mmp2_pm_enter_lowpower_mode(int state)
-{
-	uint32_t idle_cfg, apcr;
-
-	idle_cfg = __raw_readl(APMU_PJ_IDLE_CFG);
-	apcr = __raw_readl(MPMU_PCR_PJ);
-	apcr &= ~(MPMU_PCR_PJ_SLPEN | MPMU_PCR_PJ_DDRCORSD | MPMU_PCR_PJ_APBSD
-		 | MPMU_PCR_PJ_AXISD | MPMU_PCR_PJ_VCTCXOSD | (1 << 13));
-	idle_cfg &= ~APMU_PJ_IDLE_CFG_PJ_IDLE;
-
-	switch (state) {
-	case POWER_MODE_SYS_SLEEP:
-		apcr |= MPMU_PCR_PJ_SLPEN;		/* set the SLPEN bit */
-		apcr |= MPMU_PCR_PJ_VCTCXOSD;		/* set VCTCXOSD */
-		fallthrough;
-	case POWER_MODE_CHIP_SLEEP:
-		apcr |= MPMU_PCR_PJ_SLPEN;
-		fallthrough;
-	case POWER_MODE_APPS_SLEEP:
-		apcr |= MPMU_PCR_PJ_APBSD;		/* set APBSD */
-		fallthrough;
-	case POWER_MODE_APPS_IDLE:
-		apcr |= MPMU_PCR_PJ_AXISD;		/* set AXISDD bit */
-		apcr |= MPMU_PCR_PJ_DDRCORSD;		/* set DDRCORSD bit */
-		idle_cfg |= APMU_PJ_IDLE_CFG_PJ_PWRDWN;	/* PJ power down */
-		apcr |= MPMU_PCR_PJ_SPSD;
-		fallthrough;
-	case POWER_MODE_CORE_EXTIDLE:
-		idle_cfg |= APMU_PJ_IDLE_CFG_PJ_IDLE;	/* set the IDLE bit */
-		idle_cfg &= ~APMU_PJ_IDLE_CFG_ISO_MODE_CNTRL_MASK;
-		idle_cfg |= APMU_PJ_IDLE_CFG_PWR_SW(3)
-			| APMU_PJ_IDLE_CFG_L2_PWR_SW;
-		break;
-	case POWER_MODE_CORE_INTIDLE:
-		apcr &= ~MPMU_PCR_PJ_SPSD;
-		break;
-	}
-
-	/* set reserve bits */
-	apcr |= (1 << 30) | (1 << 25);
-
-	/* finally write the registers back */
-	__raw_writel(idle_cfg, APMU_PJ_IDLE_CFG);
-	__raw_writel(apcr, MPMU_PCR_PJ);	/* 0xfe086000 */
-}
-
-static int mmp2_pm_enter(suspend_state_t state)
-{
-	int temp;
-
-	temp = __raw_readl(MMP2_ICU_INT4_MASK);
-	if (temp & (1 << 1)) {
-		printk(KERN_ERR "%s: PMIC interrupt is handling\n", __func__);
-		return -EAGAIN;
-	}
-
-	temp = __raw_readl(APMU_SRAM_PWR_DWN);
-	temp |= ((1 << 19) | (1 << 18));
-	__raw_writel(temp, APMU_SRAM_PWR_DWN);
-	pm_mpmu_clk_disable();
-	pm_scu_clk_disable();
-
-	printk(KERN_INFO "%s: before suspend\n", __func__);
-	cpu_do_idle();
-	printk(KERN_INFO "%s: after suspend\n", __func__);
-
-	pm_mpmu_clk_enable();		/* enable clocks in MPMU */
-	pm_scu_clk_enable();		/* enable clocks in SCU */
-
-	return 0;
-}
-
-/*
- * Called after processes are frozen, but before we shut down devices.
- */
-static int mmp2_pm_prepare(void)
-{
-	mmp2_pm_enter_lowpower_mode(POWER_MODE_SYS_SLEEP);
-
-	return 0;
-}
-
-/*
- * Called after devices are re-setup, but before processes are thawed.
- */
-static void mmp2_pm_finish(void)
-{
-	mmp2_pm_enter_lowpower_mode(POWER_MODE_CORE_INTIDLE);
-}
-
-static int mmp2_pm_valid(suspend_state_t state)
-{
-	return ((state == PM_SUSPEND_STANDBY) || (state == PM_SUSPEND_MEM));
-}
-
-/*
- * Set to PM_DISK_FIRMWARE so we can quickly veto suspend-to-disk.
- */
-static const struct platform_suspend_ops mmp2_pm_ops = {
-	.valid		= mmp2_pm_valid,
-	.prepare	= mmp2_pm_prepare,
-	.enter		= mmp2_pm_enter,
-	.finish		= mmp2_pm_finish,
-};
-
-static int __init mmp2_pm_init(void)
-{
-	uint32_t apcr;
-
-	if (!cpu_is_mmp2())
-		return -EIO;
-
-	suspend_set_ops(&mmp2_pm_ops);
-
-	/*
-	 * Set bit 0, Slow clock Select 32K clock input instead of VCXO
-	 * VCXO is chosen by default, which would be disabled in suspend
-	 */
-	__raw_writel(0x5, MPMU_SCCR);
-
-	/*
-	 * Clear bit 23 of CIU_CPU_CONF
-	 * direct PJ4 to DDR access through Memory Controller slow queue
-	 * fast queue has issue and cause lcd will flick
-	 */
-	__raw_writel(__raw_readl(CIU_REG(0x8)) & ~(0x1 << 23), CIU_REG(0x8));
-
-	/* Clear default low power control bit */
-	apcr = __raw_readl(MPMU_PCR_PJ);
-	apcr &= ~(MPMU_PCR_PJ_SLPEN | MPMU_PCR_PJ_DDRCORSD
-			| MPMU_PCR_PJ_APBSD | MPMU_PCR_PJ_AXISD | 1 << 13);
-	__raw_writel(apcr, MPMU_PCR_PJ);
-
-	return 0;
-}
-
-late_initcall(mmp2_pm_init);
diff --git a/arch/arm/mach-mmp/pm-mmp2.h b/arch/arm/mach-mmp/pm-mmp2.h
deleted file mode 100644
index 70cff8bf0cc8..000000000000
--- a/arch/arm/mach-mmp/pm-mmp2.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * MMP2 Power Management Routines
- *
- * (C) Copyright 2010 Marvell International Ltd.
- * All Rights Reserved
- */
-
-#ifndef __MMP2_PM_H__
-#define __MMP2_PM_H__
-
-#include "addr-map.h"
-
-#define APMU_PJ_IDLE_CFG			APMU_REG(0x018)
-#define APMU_PJ_IDLE_CFG_PJ_IDLE		(1 << 1)
-#define APMU_PJ_IDLE_CFG_PJ_PWRDWN		(1 << 5)
-#define APMU_PJ_IDLE_CFG_PWR_SW(x)		((x) << 16)
-#define APMU_PJ_IDLE_CFG_L2_PWR_SW		(1 << 19)
-#define APMU_PJ_IDLE_CFG_ISO_MODE_CNTRL_MASK	(3 << 28)
-
-#define APMU_SRAM_PWR_DWN			APMU_REG(0x08c)
-
-#define MPMU_SCCR				MPMU_REG(0x038)
-#define MPMU_PCR_PJ				MPMU_REG(0x1000)
-#define MPMU_PCR_PJ_AXISD			(1 << 31)
-#define MPMU_PCR_PJ_SLPEN			(1 << 29)
-#define MPMU_PCR_PJ_SPSD			(1 << 28)
-#define MPMU_PCR_PJ_DDRCORSD			(1 << 27)
-#define MPMU_PCR_PJ_APBSD			(1 << 26)
-#define MPMU_PCR_PJ_INTCLR			(1 << 24)
-#define MPMU_PCR_PJ_SLPWP0			(1 << 23)
-#define MPMU_PCR_PJ_SLPWP1			(1 << 22)
-#define MPMU_PCR_PJ_SLPWP2			(1 << 21)
-#define MPMU_PCR_PJ_SLPWP3			(1 << 20)
-#define MPMU_PCR_PJ_VCTCXOSD			(1 << 19)
-#define MPMU_PCR_PJ_SLPWP4			(1 << 18)
-#define MPMU_PCR_PJ_SLPWP5			(1 << 17)
-#define MPMU_PCR_PJ_SLPWP6			(1 << 16)
-#define MPMU_PCR_PJ_SLPWP7			(1 << 15)
-
-#define MPMU_PLL2_CTRL1				MPMU_REG(0x0414)
-#define MPMU_CGR_PJ				MPMU_REG(0x1024)
-#define MPMU_WUCRM_PJ				MPMU_REG(0x104c)
-#define MPMU_WUCRM_PJ_WAKEUP(x)			(1 << (x))
-#define MPMU_WUCRM_PJ_RTC_ALARM			(1 << 17)
-
-enum {
-	POWER_MODE_ACTIVE = 0,
-	POWER_MODE_CORE_INTIDLE,
-	POWER_MODE_CORE_EXTIDLE,
-	POWER_MODE_APPS_IDLE,
-	POWER_MODE_APPS_SLEEP,
-	POWER_MODE_CHIP_SLEEP,
-	POWER_MODE_SYS_SLEEP,
-};
-
-extern void mmp2_pm_enter_lowpower_mode(int state);
-
-#endif
diff --git a/arch/arm/mach-mmp/pm-pxa910.c b/arch/arm/mach-mmp/pm-pxa910.c
deleted file mode 100644
index f6ba6db0aa36..000000000000
--- a/arch/arm/mach-mmp/pm-pxa910.c
+++ /dev/null
@@ -1,166 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * PXA910 Power Management Routines
- *
- * (C) Copyright 2009 Marvell International Ltd.
- * All Rights Reserved
- */
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/time.h>
-#include <linux/delay.h>
-#include <linux/suspend.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <asm/mach-types.h>
-#include <asm/outercache.h>
-
-#include <linux/soc/mmp/cputype.h>
-#include "addr-map.h"
-#include "pm-pxa910.h"
-#include "regs-icu.h"
-
-void pxa910_pm_enter_lowpower_mode(int state)
-{
-	uint32_t idle_cfg, apcr;
-
-	idle_cfg = __raw_readl(APMU_MOH_IDLE_CFG);
-	apcr = __raw_readl(MPMU_APCR);
-
-	apcr &= ~(MPMU_APCR_DDRCORSD | MPMU_APCR_APBSD | MPMU_APCR_AXISD
-		| MPMU_APCR_VCTCXOSD | MPMU_APCR_STBYEN);
-	idle_cfg &= ~(APMU_MOH_IDLE_CFG_MOH_IDLE
-		| APMU_MOH_IDLE_CFG_MOH_PWRDWN);
-
-	switch (state) {
-	case POWER_MODE_UDR:
-		/* only shutdown APB in UDR */
-		apcr |= MPMU_APCR_STBYEN | MPMU_APCR_APBSD;
-		fallthrough;
-	case POWER_MODE_SYS_SLEEP:
-		apcr |= MPMU_APCR_SLPEN;		/* set the SLPEN bit */
-		apcr |= MPMU_APCR_VCTCXOSD;		/* set VCTCXOSD */
-		fallthrough;
-	case POWER_MODE_APPS_SLEEP:
-		apcr |= MPMU_APCR_DDRCORSD;		/* set DDRCORSD */
-		fallthrough;
-	case POWER_MODE_APPS_IDLE:
-		apcr |= MPMU_APCR_AXISD;		/* set AXISDD bit */
-		fallthrough;
-	case POWER_MODE_CORE_EXTIDLE:
-		idle_cfg |= APMU_MOH_IDLE_CFG_MOH_IDLE;
-		idle_cfg |= APMU_MOH_IDLE_CFG_MOH_PWRDWN;
-		idle_cfg |= APMU_MOH_IDLE_CFG_MOH_PWR_SW(3)
-			| APMU_MOH_IDLE_CFG_MOH_L2_PWR_SW(3);
-		fallthrough;
-	case POWER_MODE_CORE_INTIDLE:
-		break;
-	}
-
-	/* program the memory controller hardware sleep type and auto wakeup */
-	idle_cfg |= APMU_MOH_IDLE_CFG_MOH_DIS_MC_SW_REQ;
-	idle_cfg |= APMU_MOH_IDLE_CFG_MOH_MC_WAKE_EN;
-	__raw_writel(0x0, APMU_MC_HW_SLP_TYPE);		/* auto refresh */
-
-	/* set DSPSD, DTCMSD, BBSD, MSASLPEN */
-	apcr |= MPMU_APCR_DSPSD | MPMU_APCR_DTCMSD | MPMU_APCR_BBSD
-		| MPMU_APCR_MSASLPEN;
-
-	/*always set SLEPEN bit mainly for MSA*/
-	apcr |= MPMU_APCR_SLPEN;
-
-	/* finally write the registers back */
-	__raw_writel(idle_cfg, APMU_MOH_IDLE_CFG);
-	__raw_writel(apcr, MPMU_APCR);
-
-}
-
-static int pxa910_pm_enter(suspend_state_t state)
-{
-	unsigned int idle_cfg, reg = 0;
-
-	/*pmic thread not completed,exit;otherwise system can't be waked up*/
-	reg = __raw_readl(ICU_INT_CONF(IRQ_PXA910_PMIC_INT));
-	if ((reg & 0x3) == 0)
-		return -EAGAIN;
-
-	idle_cfg = __raw_readl(APMU_MOH_IDLE_CFG);
-	idle_cfg |= APMU_MOH_IDLE_CFG_MOH_PWRDWN
-		| APMU_MOH_IDLE_CFG_MOH_SRAM_PWRDWN;
-	__raw_writel(idle_cfg, APMU_MOH_IDLE_CFG);
-
-	/* disable L2 */
-	outer_disable();
-	/* wait for l2 idle */
-	while (!(readl(CIU_REG(0x8)) & (1 << 16)))
-		udelay(1);
-
-	cpu_do_idle();
-
-	/* enable L2 */
-	outer_resume();
-	/* wait for l2 idle */
-	while (!(readl(CIU_REG(0x8)) & (1 << 16)))
-		udelay(1);
-
-	idle_cfg = __raw_readl(APMU_MOH_IDLE_CFG);
-	idle_cfg &= ~(APMU_MOH_IDLE_CFG_MOH_PWRDWN
-		| APMU_MOH_IDLE_CFG_MOH_SRAM_PWRDWN);
-	__raw_writel(idle_cfg, APMU_MOH_IDLE_CFG);
-
-	return 0;
-}
-
-/*
- * Called after processes are frozen, but before we shut down devices.
- */
-static int pxa910_pm_prepare(void)
-{
-	pxa910_pm_enter_lowpower_mode(POWER_MODE_UDR);
-	return 0;
-}
-
-/*
- * Called after devices are re-setup, but before processes are thawed.
- */
-static void pxa910_pm_finish(void)
-{
-	pxa910_pm_enter_lowpower_mode(POWER_MODE_CORE_INTIDLE);
-}
-
-static int pxa910_pm_valid(suspend_state_t state)
-{
-	return ((state == PM_SUSPEND_STANDBY) || (state == PM_SUSPEND_MEM));
-}
-
-static const struct platform_suspend_ops pxa910_pm_ops = {
-	.valid		= pxa910_pm_valid,
-	.prepare	= pxa910_pm_prepare,
-	.enter		= pxa910_pm_enter,
-	.finish		= pxa910_pm_finish,
-};
-
-static int __init pxa910_pm_init(void)
-{
-	uint32_t awucrm = 0;
-
-	if (!cpu_is_pxa910())
-		return -EIO;
-
-	suspend_set_ops(&pxa910_pm_ops);
-
-	/* Set the following bits for MMP3 playback with VCTXO on */
-	__raw_writel(__raw_readl(APMU_SQU_CLK_GATE_CTRL) | (1 << 30),
-		APMU_SQU_CLK_GATE_CTRL);
-	__raw_writel(__raw_readl(MPMU_FCCR) | (1 << 28), MPMU_FCCR);
-
-	awucrm |= MPMU_AWUCRM_AP_ASYNC_INT | MPMU_AWUCRM_AP_FULL_IDLE;
-	__raw_writel(awucrm, MPMU_AWUCRM);
-
-	return 0;
-}
-
-late_initcall(pxa910_pm_init);
diff --git a/arch/arm/mach-mmp/pm-pxa910.h b/arch/arm/mach-mmp/pm-pxa910.h
deleted file mode 100644
index 8e6344adaf51..000000000000
--- a/arch/arm/mach-mmp/pm-pxa910.h
+++ /dev/null
@@ -1,75 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * PXA910 Power Management Routines
- *
- * (C) Copyright 2009 Marvell International Ltd.
- * All Rights Reserved
- */
-
-#ifndef __PXA910_PM_H__
-#define __PXA910_PM_H__
-
-#define APMU_MOH_IDLE_CFG			APMU_REG(0x0018)
-#define APMU_MOH_IDLE_CFG_MOH_IDLE		(1 << 1)
-#define APMU_MOH_IDLE_CFG_MOH_PWRDWN		(1 << 5)
-#define APMU_MOH_IDLE_CFG_MOH_SRAM_PWRDWN	(1 << 6)
-#define APMU_MOH_IDLE_CFG_MOH_PWR_SW(x)		(((x) & 0x3) << 16)
-#define APMU_MOH_IDLE_CFG_MOH_L2_PWR_SW(x)	(((x) & 0x3) << 18)
-#define APMU_MOH_IDLE_CFG_MOH_DIS_MC_SW_REQ	(1 << 21)
-#define APMU_MOH_IDLE_CFG_MOH_MC_WAKE_EN	(1 << 20)
-
-#define APMU_SQU_CLK_GATE_CTRL			APMU_REG(0x001c)
-#define APMU_MC_HW_SLP_TYPE			APMU_REG(0x00b0)
-
-#define MPMU_FCCR				MPMU_REG(0x0008)
-#define MPMU_APCR				MPMU_REG(0x1000)
-#define MPMU_APCR_AXISD				(1 << 31)
-#define MPMU_APCR_DSPSD				(1 << 30)
-#define MPMU_APCR_SLPEN				(1 << 29)
-#define MPMU_APCR_DTCMSD			(1 << 28)
-#define MPMU_APCR_DDRCORSD			(1 << 27)
-#define MPMU_APCR_APBSD				(1 << 26)
-#define MPMU_APCR_BBSD				(1 << 25)
-#define MPMU_APCR_SLPWP0			(1 << 23)
-#define MPMU_APCR_SLPWP1			(1 << 22)
-#define MPMU_APCR_SLPWP2			(1 << 21)
-#define MPMU_APCR_SLPWP3			(1 << 20)
-#define MPMU_APCR_VCTCXOSD			(1 << 19)
-#define MPMU_APCR_SLPWP4			(1 << 18)
-#define MPMU_APCR_SLPWP5			(1 << 17)
-#define MPMU_APCR_SLPWP6			(1 << 16)
-#define MPMU_APCR_SLPWP7			(1 << 15)
-#define MPMU_APCR_MSASLPEN			(1 << 14)
-#define MPMU_APCR_STBYEN			(1 << 13)
-
-#define MPMU_AWUCRM				MPMU_REG(0x104c)
-#define MPMU_AWUCRM_AP_ASYNC_INT		(1 << 25)
-#define MPMU_AWUCRM_AP_FULL_IDLE		(1 << 24)
-#define MPMU_AWUCRM_SDH1			(1 << 23)
-#define MPMU_AWUCRM_SDH2			(1 << 22)
-#define MPMU_AWUCRM_KEYPRESS			(1 << 21)
-#define MPMU_AWUCRM_TRACKBALL			(1 << 20)
-#define MPMU_AWUCRM_NEWROTARY			(1 << 19)
-#define MPMU_AWUCRM_RTC_ALARM			(1 << 17)
-#define MPMU_AWUCRM_AP2_TIMER_3			(1 << 13)
-#define MPMU_AWUCRM_AP2_TIMER_2			(1 << 12)
-#define MPMU_AWUCRM_AP2_TIMER_1			(1 << 11)
-#define MPMU_AWUCRM_AP1_TIMER_3			(1 << 10)
-#define MPMU_AWUCRM_AP1_TIMER_2			(1 << 9)
-#define MPMU_AWUCRM_AP1_TIMER_1			(1 << 8)
-#define MPMU_AWUCRM_WAKEUP(x)			(1 << ((x) & 0x7))
-
-enum {
-	POWER_MODE_ACTIVE = 0,
-	POWER_MODE_CORE_INTIDLE,
-	POWER_MODE_CORE_EXTIDLE,
-	POWER_MODE_APPS_IDLE,
-	POWER_MODE_APPS_SLEEP,
-	POWER_MODE_SYS_SLEEP,
-	POWER_MODE_HIBERNATE,
-	POWER_MODE_UDR,
-};
-
-extern int pxa910_set_wake(struct irq_data *data, unsigned int on);
-
-#endif
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
deleted file mode 100644
index 565d4a6c3bd5..000000000000
--- a/arch/arm/mach-mmp/pxa168.c
+++ /dev/null
@@ -1,51 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  linux/arch/arm/mach-mmp/pxa168.c
- *
- *  Code specific to PXA168
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/list.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/clk/mmp.h>
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/mach/time.h>
-#include <asm/system_misc.h>
-
-#include "addr-map.h"
-#include "common.h"
-#include <linux/soc/mmp/cputype.h>
-#include <linux/soc/pxa/mfp.h>
-#include "devices.h"
-#include "pxa168.h"
-
-#define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
-
-static struct mfp_addr_map pxa168_mfp_addr_map[] __initdata =
-{
-	MFP_ADDR_X(GPIO0,   GPIO36,  0x04c),
-	MFP_ADDR_X(GPIO37,  GPIO55,  0x000),
-	MFP_ADDR_X(GPIO56,  GPIO123, 0x0e0),
-	MFP_ADDR_X(GPIO124, GPIO127, 0x0f4),
-
-	MFP_ADDR_END,
-};
-
-static int __init pxa168_init(void)
-{
-	if (cpu_is_pxa168()) {
-		mfp_init_base(MFPR_VIRT_BASE);
-		mfp_init_addr(pxa168_mfp_addr_map);
-		pxa168_clk_init(APB_PHYS_BASE + 0x50000,
-				AXI_PHYS_BASE + 0x82800,
-				APB_PHYS_BASE + 0x15000);
-	}
-
-	return 0;
-}
-postcore_initcall(pxa168_init);
diff --git a/arch/arm/mach-mmp/pxa168.h b/arch/arm/mach-mmp/pxa168.h
deleted file mode 100644
index 279783ef239d..000000000000
--- a/arch/arm/mach-mmp/pxa168.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_MACH_PXA168_H
-#define __ASM_MACH_PXA168_H
-
-#include <linux/reboot.h>
-
-extern void pxa168_timer_init(void);
-extern void __init pxa168_init_irq(void);
-extern void pxa168_restart(enum reboot_mode, const char *);
-extern void pxa168_clear_keypad_wakeup(void);
-
-#include <linux/i2c.h>
-#include <linux/soc/mmp/cputype.h>
-#include <linux/irqchip/mmp.h>
-
-#endif /* __ASM_MACH_PXA168_H */
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
deleted file mode 100644
index f389b99cd9bd..000000000000
--- a/arch/arm/mach-mmp/pxa910.c
+++ /dev/null
@@ -1,93 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  linux/arch/arm/mach-mmp/pxa910.c
- *
- *  Code specific to PXA910
- */
-#include <linux/clk/mmp.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/list.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/irqchip/mmp.h>
-#include <linux/platform_device.h>
-
-#include <asm/hardware/cache-tauros2.h>
-#include <asm/mach/time.h>
-#include "addr-map.h"
-#include <linux/soc/mmp/cputype.h>
-#include <linux/soc/pxa/mfp.h>
-#include "irqs.h"
-#include "pm-pxa910.h"
-
-#include "common.h"
-
-#define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
-
-static struct mfp_addr_map pxa910_mfp_addr_map[] __initdata =
-{
-	MFP_ADDR_X(GPIO0, GPIO54, 0xdc),
-	MFP_ADDR_X(GPIO67, GPIO98, 0x1b8),
-	MFP_ADDR_X(GPIO100, GPIO109, 0x238),
-
-	MFP_ADDR(GPIO123, 0xcc),
-	MFP_ADDR(GPIO124, 0xd0),
-
-	MFP_ADDR(DF_IO0, 0x40),
-	MFP_ADDR(DF_IO1, 0x3c),
-	MFP_ADDR(DF_IO2, 0x38),
-	MFP_ADDR(DF_IO3, 0x34),
-	MFP_ADDR(DF_IO4, 0x30),
-	MFP_ADDR(DF_IO5, 0x2c),
-	MFP_ADDR(DF_IO6, 0x28),
-	MFP_ADDR(DF_IO7, 0x24),
-	MFP_ADDR(DF_IO8, 0x20),
-	MFP_ADDR(DF_IO9, 0x1c),
-	MFP_ADDR(DF_IO10, 0x18),
-	MFP_ADDR(DF_IO11, 0x14),
-	MFP_ADDR(DF_IO12, 0x10),
-	MFP_ADDR(DF_IO13, 0xc),
-	MFP_ADDR(DF_IO14, 0x8),
-	MFP_ADDR(DF_IO15, 0x4),
-
-	MFP_ADDR(DF_nCS0_SM_nCS2, 0x44),
-	MFP_ADDR(DF_nCS1_SM_nCS3, 0x48),
-	MFP_ADDR(SM_nCS0, 0x4c),
-	MFP_ADDR(SM_nCS1, 0x50),
-	MFP_ADDR(DF_WEn, 0x54),
-	MFP_ADDR(DF_REn, 0x58),
-	MFP_ADDR(DF_CLE_SM_OEn, 0x5c),
-	MFP_ADDR(DF_ALE_SM_WEn, 0x60),
-	MFP_ADDR(SM_SCLK, 0x64),
-	MFP_ADDR(DF_RDY0, 0x68),
-	MFP_ADDR(SM_BE0, 0x6c),
-	MFP_ADDR(SM_BE1, 0x70),
-	MFP_ADDR(SM_ADV, 0x74),
-	MFP_ADDR(DF_RDY1, 0x78),
-	MFP_ADDR(SM_ADVMUX, 0x7c),
-	MFP_ADDR(SM_RDY, 0x80),
-
-	MFP_ADDR_X(MMC1_DAT7, MMC1_WP, 0x84),
-
-	MFP_ADDR_END,
-};
-
-static int __init pxa910_init(void)
-{
-	if (cpu_is_pxa910()) {
-#ifdef CONFIG_CACHE_TAUROS2
-		tauros2_init(0);
-#endif
-		mfp_init_base(MFPR_VIRT_BASE);
-		mfp_init_addr(pxa910_mfp_addr_map);
-		pxa910_clk_init(APB_PHYS_BASE + 0x50000,
-				AXI_PHYS_BASE + 0x82800,
-				APB_PHYS_BASE + 0x15000,
-				APB_PHYS_BASE + 0x3b000);
-	}
-
-	return 0;
-}
-postcore_initcall(pxa910_init);
diff --git a/arch/arm/mach-mmp/pxa910.h b/arch/arm/mach-mmp/pxa910.h
deleted file mode 100644
index 66a691d89ae1..000000000000
--- a/arch/arm/mach-mmp/pxa910.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_MACH_PXA910_H
-#define __ASM_MACH_PXA910_H
-
-extern void pxa910_timer_init(void);
-extern void __init pxa910_init_irq(void);
-
-#include <linux/i2c.h>
-#include <linux/irqchip/mmp.h>
-
-#endif /* __ASM_MACH_PXA910_H */
diff --git a/arch/arm/mach-mmp/regs-icu.h b/arch/arm/mach-mmp/regs-icu.h
deleted file mode 100644
index 410743d2b402..000000000000
--- a/arch/arm/mach-mmp/regs-icu.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *   Interrupt Control Unit
- */
-
-#ifndef __ASM_MACH_ICU_H
-#define __ASM_MACH_ICU_H
-
-#include "addr-map.h"
-
-#define ICU_VIRT_BASE	(AXI_VIRT_BASE + 0x82000)
-#define ICU_REG(x)	(ICU_VIRT_BASE + (x))
-
-#define ICU2_VIRT_BASE	(AXI_VIRT_BASE + 0x84000)
-#define ICU2_REG(x)	(ICU2_VIRT_BASE + (x))
-
-#define ICU_INT_CONF(n)		ICU_REG((n) << 2)
-#define ICU_INT_CONF_MASK	(0xf)
-
-/************ PXA168/PXA910 (MMP) *********************/
-#define ICU_INT_CONF_AP_INT	(1 << 6)
-#define ICU_INT_CONF_CP_INT	(1 << 5)
-#define ICU_INT_CONF_IRQ	(1 << 4)
-
-#define ICU_AP_FIQ_SEL_INT_NUM	ICU_REG(0x108)	/* AP FIQ Selected Interrupt */
-#define ICU_AP_IRQ_SEL_INT_NUM	ICU_REG(0x10C)	/* AP IRQ Selected Interrupt */
-#define ICU_AP_GBL_IRQ_MSK	ICU_REG(0x114)	/* AP Global Interrupt Mask */
-#define ICU_INT_STATUS_0	ICU_REG(0x128)	/* Interrupt Stuats 0 */
-#define ICU_INT_STATUS_1	ICU_REG(0x12C)	/* Interrupt Status 1 */
-
-/************************** MMP2 ***********************/
-
-/*
- * IRQ0/FIQ0 is routed to SP IRQ/FIQ.
- * IRQ1 is routed to PJ4 IRQ, and IRQ2 is routes to PJ4 FIQ.
- */
-#define ICU_INT_ROUTE_SP_IRQ		(1 << 4)
-#define ICU_INT_ROUTE_PJ4_IRQ		(1 << 5)
-#define ICU_INT_ROUTE_PJ4_FIQ		(1 << 6)
-
-#define MMP2_ICU_PJ4_IRQ_STATUS0	ICU_REG(0x138)
-#define MMP2_ICU_PJ4_IRQ_STATUS1	ICU_REG(0x13c)
-#define MMP2_ICU_PJ4_FIQ_STATUS0	ICU_REG(0x140)
-#define MMP2_ICU_PJ4_FIQ_STATUS1	ICU_REG(0x144)
-
-#define MMP2_ICU_INT4_STATUS		ICU_REG(0x150)
-#define MMP2_ICU_INT5_STATUS		ICU_REG(0x154)
-#define MMP2_ICU_INT17_STATUS		ICU_REG(0x158)
-#define MMP2_ICU_INT35_STATUS		ICU_REG(0x15c)
-#define MMP2_ICU_INT51_STATUS		ICU_REG(0x160)
-
-#define MMP2_ICU_INT4_MASK		ICU_REG(0x168)
-#define MMP2_ICU_INT5_MASK		ICU_REG(0x16C)
-#define MMP2_ICU_INT17_MASK		ICU_REG(0x170)
-#define MMP2_ICU_INT35_MASK		ICU_REG(0x174)
-#define MMP2_ICU_INT51_MASK		ICU_REG(0x178)
-
-#define MMP2_ICU_SP_IRQ_SEL		ICU_REG(0x100)
-#define MMP2_ICU_PJ4_IRQ_SEL		ICU_REG(0x104)
-#define MMP2_ICU_PJ4_FIQ_SEL		ICU_REG(0x108)
-
-#define MMP2_ICU_INVERT			ICU_REG(0x164)
-
-#define MMP2_ICU_INV_PMIC		(1 << 0)
-#define MMP2_ICU_INV_PERF		(1 << 1)
-#define MMP2_ICU_INV_COMMTX		(1 << 2)
-#define MMP2_ICU_INV_COMMRX		(1 << 3)
-
-#endif /* __ASM_MACH_ICU_H */
diff --git a/include/linux/soc/mmp/cputype.h b/include/linux/soc/mmp/cputype.h
index 221790761e8e..f13d127fadc4 100644
--- a/include/linux/soc/mmp/cputype.h
+++ b/include/linux/soc/mmp/cputype.h
@@ -26,29 +26,7 @@
 
 extern unsigned int mmp_chip_id;
 
-#ifdef CONFIG_CPU_PXA168
-static inline int cpu_is_pxa168(void)
-{
-	return (((read_cpuid_id() >> 8) & 0xff) == 0x84) &&
-		((mmp_chip_id & 0xfff) == 0x168);
-}
-#else
-#define cpu_is_pxa168()	(0)
-#endif
-
-/* cpu_is_pxa910() is shared on both pxa910 and pxa920 */
-#ifdef CONFIG_CPU_PXA910
-static inline int cpu_is_pxa910(void)
-{
-	return (((read_cpuid_id() >> 8) & 0xff) == 0x84) &&
-		(((mmp_chip_id & 0xfff) == 0x910) ||
-		 ((mmp_chip_id & 0xfff) == 0x920));
-}
-#else
-#define cpu_is_pxa910()	(0)
-#endif
-
-#if defined(CONFIG_CPU_MMP2) || defined(CONFIG_MACH_MMP2_DT)
+#if defined(CONFIG_MACH_MMP2_DT)
 static inline int cpu_is_mmp2(void)
 {
 	return (((read_cpuid_id() >> 8) & 0xff) == 0x58) &&
-- 
2.29.2

