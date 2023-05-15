Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D680703212
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242315AbjEOQDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241655AbjEOQDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:03:08 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC9BA3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:03:06 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FG2cah004414;
        Mon, 15 May 2023 11:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684166559;
        bh=fWiAiLfECMa60sdqN8J4wC3WNRsL94eqtGa4ZSYPaxE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FgAVNlsQc4wJDMCaLdZYMH6cPBEjDI4PsHP49t5TDJYfbOdmOtspKjIE3i4V9dNIz
         Z1i4FBwkmTFvDv6Y8nZYM4LtibqwP+PsQ7qbx0wisCkxTBdtIS5S79mC1G7Qm2QSs4
         lTE4KrrE7O7EHCtGchKFmwuLHGw6epV86RsmM4Ww=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FG2cBZ060800
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 11:02:38 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 11:02:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 11:02:38 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FG2ZR4029578;
        Mon, 15 May 2023 11:02:37 -0500
From:   Andrew Davis <afd@ti.com>
To:     Russell King <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 05/10] ARM: mach-moxart: Move MOXA ART support into Kconfig.platforms
Date:   Mon, 15 May 2023 11:02:29 -0500
Message-ID: <20230515160234.289631-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515160234.289631-1-afd@ti.com>
References: <20230515160234.289631-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the need for a dedicated Kconfig and empty mach directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/Kconfig              |  2 --
 arch/arm/Kconfig.platforms    | 28 ++++++++++++++++++++++++++++
 arch/arm/Makefile             |  1 -
 arch/arm/mach-moxart/Kconfig  | 28 ----------------------------
 arch/arm/mach-moxart/Makefile |  4 ----
 arch/arm/mach-moxart/moxart.c |  6 ------
 6 files changed, 28 insertions(+), 41 deletions(-)
 delete mode 100644 arch/arm/mach-moxart/Kconfig
 delete mode 100644 arch/arm/mach-moxart/Makefile
 delete mode 100644 arch/arm/mach-moxart/moxart.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 75d56ad5eb27..e7351a683545 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -408,8 +408,6 @@ source "arch/arm/mach-milbeaut/Kconfig"
 
 source "arch/arm/mach-mmp/Kconfig"
 
-source "arch/arm/mach-moxart/Kconfig"
-
 source "arch/arm/mach-mstar/Kconfig"
 
 source "arch/arm/mach-mv78xx0/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index 0e6d7172bf61..4b5fad18ca8b 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -76,6 +76,34 @@ config MACH_ASM9260
 	help
 	  Support for Alphascale ASM9260 based platform.
 
+menuconfig ARCH_MOXART
+	bool "MOXA ART SoC"
+	depends on ARCH_MULTI_V4
+	depends on CPU_LITTLE_ENDIAN
+	select CPU_FA526
+	select ARM_DMA_MEM_BUFFERABLE
+	select FARADAY_FTINTC010
+	select FTTMR010_TIMER
+	select GPIOLIB
+	select PHYLIB if NETDEVICES
+	help
+	  Say Y here if you want to run your kernel on hardware with a
+	  MOXA ART SoC.
+	  The MOXA ART SoC is based on a Faraday FA526 ARMv4 32-bit
+	  192 MHz CPU with MMU and 16KB/8KB D/I-cache (UC-7112-LX).
+	  Used on models UC-7101, UC-7112/UC-7110, IA240/IA241, IA3341.
+
+if ARCH_MOXART
+
+config MACH_UC7112LX
+	bool "MOXA UC-7112-LX"
+	depends on ARCH_MOXART
+	help
+	  Say Y here if you intend to run this kernel on a MOXA
+	  UC-7112-LX embedded computer.
+
+endif
+
 config ARCH_RDA
 	bool "RDA Micro SoCs"
 	depends on ARCH_MULTI_V7
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 547e5856eaa0..32e99aa282bf 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -192,7 +192,6 @@ machine-$(CONFIG_ARCH_LPC18XX)		+= lpc18xx
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
 machine-$(CONFIG_ARCH_MESON)		+= meson
 machine-$(CONFIG_ARCH_MMP)		+= mmp
-machine-$(CONFIG_ARCH_MOXART)		+= moxart
 machine-$(CONFIG_ARCH_MV78XX0)		+= mv78xx0
 machine-$(CONFIG_ARCH_MVEBU)		+= mvebu
 machine-$(CONFIG_ARCH_MXC)		+= imx
diff --git a/arch/arm/mach-moxart/Kconfig b/arch/arm/mach-moxart/Kconfig
deleted file mode 100644
index 909c6573ba8b..000000000000
--- a/arch/arm/mach-moxart/Kconfig
+++ /dev/null
@@ -1,28 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-menuconfig ARCH_MOXART
-	bool "MOXA ART SoC"
-	depends on ARCH_MULTI_V4
-	depends on CPU_LITTLE_ENDIAN
-	select CPU_FA526
-	select ARM_DMA_MEM_BUFFERABLE
-	select FARADAY_FTINTC010
-	select FTTMR010_TIMER
-	select GPIOLIB
-	select PHYLIB if NETDEVICES
-	help
-	  Say Y here if you want to run your kernel on hardware with a
-	  MOXA ART SoC.
-	  The MOXA ART SoC is based on a Faraday FA526 ARMv4 32-bit
-	  192 MHz CPU with MMU and 16KB/8KB D/I-cache (UC-7112-LX).
-	  Used on models UC-7101, UC-7112/UC-7110, IA240/IA241, IA3341.
-
-if ARCH_MOXART
-
-config MACH_UC7112LX
-	bool "MOXA UC-7112-LX"
-	depends on ARCH_MOXART
-	help
-	  Say Y here if you intend to run this kernel on a MOXA
-	  UC-7112-LX embedded computer.
-
-endif
diff --git a/arch/arm/mach-moxart/Makefile b/arch/arm/mach-moxart/Makefile
deleted file mode 100644
index ded3e38fb98d..000000000000
--- a/arch/arm/mach-moxart/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-# Object file lists.
-
-obj-$(CONFIG_MACH_UC7112LX)	+= moxart.o
diff --git a/arch/arm/mach-moxart/moxart.c b/arch/arm/mach-moxart/moxart.c
deleted file mode 100644
index f1f58c0c0fa1..000000000000
--- a/arch/arm/mach-moxart/moxart.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * arch/arm/mach-moxart/moxart.c
- *
- * (C) Copyright 2013, Jonas Jensen <jonas.jensen@gmail.com>
- */
-- 
2.39.2

