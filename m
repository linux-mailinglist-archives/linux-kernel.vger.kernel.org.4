Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD460B374
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiJXRGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiJXRE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:04:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B0DD2CF2;
        Mon, 24 Oct 2022 08:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B134B81189;
        Mon, 24 Oct 2022 15:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AAAC433C1;
        Mon, 24 Oct 2022 15:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666625908;
        bh=SLaPfTs1a3Gtf2Cv8VgNvJFeNhYRBRAvgbsFpcI+j58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1gadBiaxyU1BAjiJrJ6HwOHYu7TmIZEJGdg+2rArXcvtEFhI/OyNUCiMwrxoUh0U
         /iphVXuDwhiNL55I1EKwb7rs78CsmU6pDSm+x4kHV/tXO1otF+IWZ0AaE2UOxaxaRF
         Ll7snBIeQCFBG8+MiQ2jynGg/UpyAtEemFSh3AUo18A/HrAcOxJF6lQGJybDAu15K1
         MAf8x0+w1zToAWqxHar2UxdDopYgUTmKhk9Kx/tyB80oEbIx+NYRuhcGRJr5RO9kqG
         4jZyH2egsi3Egti7UzjuGp7AN/jCa8PlR1AWv+aYSOUoHEkKUmNBaVTSJm9gMrCE+3
         dPQrMniXG7edg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 02/10] ARM: omap2: remove unused headers
Date:   Mon, 24 Oct 2022 17:38:06 +0200
Message-Id: <20221024153814.254652-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221024153814.254652-1-arnd@kernel.org>
References: <20221024153814.254652-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The serial.h and clock3xxx.h headers have no contents that
anything else uses, so these can be removed after the other
files stop including them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/clock3xxx.h               | 21 ------
 arch/arm/mach-omap2/common.h                  |  1 -
 arch/arm/mach-omap2/io.c                      |  2 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |  1 -
 .../omap_hwmod_2xxx_interconnect_data.c       |  1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  1 -
 arch/arm/mach-omap2/serial.h                  | 66 -------------------
 7 files changed, 93 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clock3xxx.h
 delete mode 100644 arch/arm/mach-omap2/serial.h

diff --git a/arch/arm/mach-omap2/clock3xxx.h b/arch/arm/mach-omap2/clock3xxx.h
deleted file mode 100644
index 10a9f577dc1a..000000000000
--- a/arch/arm/mach-omap2/clock3xxx.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * OMAP3-common clock function prototypes and macros
- *
- * Copyright (C) 2007-2010 Texas Instruments, Inc.
- * Copyright (C) 2007-2010 Nokia Corporation
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK3XXX_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCK3XXX_H
-
-int omap3xxx_clk_init(void);
-int omap3_core_dpll_m2_set_rate(struct clk_hw *clk, unsigned long rate,
-					unsigned long parent_rate);
-
-extern struct clk *sdrc_ick_p;
-extern struct clk *arm_fck_p;
-
-extern const struct clkops clkops_noncore_dpll_ops;
-
-#endif
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index f8f9cc5b6964..fc041d18809b 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -38,7 +38,6 @@
 #include <asm/hardware/cache-l2x0.h>
 
 #include "i2c.h"
-#include "serial.h"
 
 #define OMAP_INTC_START		NR_IRQS
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index fba0c7aa398c..921c18ccde6d 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -33,10 +33,8 @@
 #include "common.h"
 #include "clock.h"
 #include "clock2xxx.h"
-#include "clock3xxx.h"
 #include "sdrc.h"
 #include "control.h"
-#include "serial.h"
 #include "sram.h"
 #include "cm2xxx.h"
 #include "cm3xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 558fae4375ba..dbd9dc9f0962 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -22,7 +22,6 @@
 #include "prm-regbits-24xx.h"
 #include "i2c.h"
 #include "mmc.h"
-#include "serial.h"
 #include "wd_timer.h"
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
index 518e877bb2a1..761d34914ed9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -13,7 +13,6 @@
 #include "omap_hwmod.h"
 #include "l3_2xxx.h"
 #include "l4_2xxx.h"
-#include "serial.h"
 
 #include "omap_hwmod_common_data.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index b6c7d98a9eff..4dbd56911c95 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -27,7 +27,6 @@
 
 #include "i2c.h"
 #include "wd_timer.h"
-#include "serial.h"
 
 /*
  * OMAP3xxx hardware module integration data
diff --git a/arch/arm/mach-omap2/serial.h b/arch/arm/mach-omap2/serial.h
deleted file mode 100644
index 7ca1fcff453b..000000000000
--- a/arch/arm/mach-omap2/serial.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * Copyright (C) 2009 Texas Instruments
- * Added OMAP4 support- Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-
-/* OMAP2 serial ports */
-#define OMAP2_UART1_BASE	0x4806a000
-#define OMAP2_UART2_BASE	0x4806c000
-#define OMAP2_UART3_BASE	0x4806e000
-
-/* OMAP3 serial ports */
-#define OMAP3_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP3_UART2_BASE	OMAP2_UART2_BASE
-#define OMAP3_UART3_BASE	0x49020000
-#define OMAP3_UART4_BASE	0x49042000	/* Only on 36xx */
-#define OMAP3_UART4_AM35XX_BASE	0x4809E000	/* Only on AM35xx */
-
-/* OMAP4 serial ports */
-#define OMAP4_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP4_UART2_BASE	OMAP2_UART2_BASE
-#define OMAP4_UART3_BASE	0x48020000
-#define OMAP4_UART4_BASE	0x4806e000
-
-/* TI81XX serial ports */
-#define TI81XX_UART1_BASE	0x48020000
-#define TI81XX_UART2_BASE	0x48022000
-#define TI81XX_UART3_BASE	0x48024000
-
-/* AM3505/3517 UART4 */
-#define AM35XX_UART4_BASE	0x4809E000	/* Only on AM3505/3517 */
-
-/* AM33XX serial port */
-#define AM33XX_UART1_BASE	0x44E09000
-
-/* OMAP5 serial ports */
-#define OMAP5_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP5_UART2_BASE	OMAP2_UART2_BASE
-#define OMAP5_UART3_BASE	OMAP4_UART3_BASE
-#define OMAP5_UART4_BASE	OMAP4_UART4_BASE
-#define OMAP5_UART5_BASE	0x48066000
-#define OMAP5_UART6_BASE	0x48068000
-
-/* External port on Zoom2/3 */
-#define ZOOM_UART_BASE		0x10000000
-#define ZOOM_UART_VIRT		0xfa400000
-
-#define OMAP_PORT_SHIFT		2
-#define ZOOM_PORT_SHIFT		1
-
-#define OMAP24XX_BASE_BAUD	(48000000/16)
-
-#ifndef __ASSEMBLER__
-
-struct omap_board_data;
-struct omap_uart_port_info;
-
-extern void omap_serial_init(void);
-extern void omap_serial_board_init(struct omap_uart_port_info *platform_data);
-extern void omap_serial_init_port(struct omap_board_data *bdata,
-		struct omap_uart_port_info *platform_data);
-#endif
-- 
2.29.2

