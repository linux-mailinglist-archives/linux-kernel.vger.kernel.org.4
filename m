Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B896A6FF10E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbjEKMG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjEKMG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:06:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A4630CD;
        Thu, 11 May 2023 05:06:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6434e263962so6352935b3a.2;
        Thu, 11 May 2023 05:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683806815; x=1686398815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DpI0LCtbJtrSBcOMQznyzok/DfI57bJp2AeJkWmxrek=;
        b=I9OQDRwSkGBi6hkErMi1fSRGe2ljPMCAGhcTrGSBzJvM+mO3+KJyUjFQolNfhFgBUL
         omRkNM44V3ZA1g9SxM3h/XgCEKrzNTrGJe32PpjLSqfjuK/Kez6jNhzMFUBwWSs8QHUK
         p0X/YmkIUPCn4sgHNCRftPlVF0k8ogafSyB5tiu3ck+nOW+KQsZNyokGa2kzBbHUWLT8
         Q5teeW4I2jChjQwoqJpfUNrGtR5Xpr5yDC3n6x1z4et1zxOX9eU0c0K8XS5O3YfxF2DO
         KpfvtNWxpXQWU5kTbHvyzLZAIog9ie+dBgdBAkMW14Iv4D3fkFhI/9BBIQs93B9D7CIF
         dG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806815; x=1686398815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpI0LCtbJtrSBcOMQznyzok/DfI57bJp2AeJkWmxrek=;
        b=BzSOjww3TswPYYj/ocC0GWj4BP1EPJxtZywXYtaE2nDJb9ins7NxcHb9FSqbi6ztXY
         hI1CKIwU1MFzIGyUn1Gu/1wQqH9uFW325w0iVVMJ/GH67/5ppORP6rdC0T090EONe2TI
         vN+r4yCPifmgDqQOQ4ucRPxLpHg4UWQeyPNygpibVoJdgaYNMwnUwuWFb8BXpFb0YntK
         eIXzFu4HOIorQa3I5Romx5jTSSVis9P2SKHDkewJasda4TeKZ9EttsxgD8rr+8iLYOcl
         SKL47z5tWNBZVkjzdzILiywTLDzn8g3q5u+4ElP5oV6QUGVh1lpTjPKooLqbpnDkeBVo
         FiOg==
X-Gm-Message-State: AC+VfDw2Ug8tB0BRLkpum4qlhrpdBF+qWAKJbf+8Awf1NhnWz6TX1aqg
        meo/0bEB0if7b/24LCFb9XwTvCWz3Si8YN+g
X-Google-Smtp-Source: ACHHUZ7i/tHvXuWzkmPvYNLMRCBKrAkpERgjkz4ntg1uINEDSgVSGhF15yyy9xxbtisHBcpkz5zy+w==
X-Received: by 2002:a05:6a00:2289:b0:625:fe95:f120 with SMTP id f9-20020a056a00228900b00625fe95f120mr28956917pfe.8.1683806815148;
        Thu, 11 May 2023 05:06:55 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id u17-20020aa78491000000b0063d2dae6247sm5179521pfn.77.2023.05.11.05.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 05:06:54 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v3] MIPS: Loongson32: Remove reset.c
Date:   Thu, 11 May 2023 20:06:48 +0800
Message-Id: <20230511120648.463221-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2a31bf20808a ("watchdog: loongson1_wdt: Implement restart handler")
implmented .restart ops, Then, _machine_restart is no longer needed.
The _machine_halt and pm_power_off are also unnecessary,
which contain no hardware operations.

Therefore, remove the entire reset.c and related header file.
Update the Makefile accordingly.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V2 -> V3: Update the commit message
V1 -> V2: Remove the reference to regs-wdt.h
---
 .../include/asm/mach-loongson32/loongson1.h   |  1 -
 .../include/asm/mach-loongson32/regs-wdt.h    | 15 ------
 arch/mips/loongson32/common/Makefile          |  2 +-
 arch/mips/loongson32/common/reset.c           | 51 -------------------
 4 files changed, 1 insertion(+), 68 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-wdt.h
 delete mode 100644 arch/mips/loongson32/common/reset.c

diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index eb3ddbec1752..50358f1a6181 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -49,6 +49,5 @@
 #include <regs-mux.h>
 #include <regs-pwm.h>
 #include <regs-rtc.h>
-#include <regs-wdt.h>
 
 #endif /* __ASM_MACH_LOONGSON32_LOONGSON1_H */
diff --git a/arch/mips/include/asm/mach-loongson32/regs-wdt.h b/arch/mips/include/asm/mach-loongson32/regs-wdt.h
deleted file mode 100644
index c6d345fe13f2..000000000000
--- a/arch/mips/include/asm/mach-loongson32/regs-wdt.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Loongson 1 Watchdog Register Definitions.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_REGS_WDT_H
-#define __ASM_MACH_LOONGSON32_REGS_WDT_H
-
-#define WDT_EN			0x0
-#define WDT_TIMER		0x4
-#define WDT_SET			0x8
-
-#endif /* __ASM_MACH_LOONGSON32_REGS_WDT_H */
diff --git a/arch/mips/loongson32/common/Makefile b/arch/mips/loongson32/common/Makefile
index 7b49c8260706..f3950d308187 100644
--- a/arch/mips/loongson32/common/Makefile
+++ b/arch/mips/loongson32/common/Makefile
@@ -3,4 +3,4 @@
 # Makefile for common code of loongson1 based machines.
 #
 
-obj-y	+= time.o irq.o platform.o prom.o reset.o setup.o
+obj-y	+= time.o irq.o platform.o prom.o setup.o
diff --git a/arch/mips/loongson32/common/reset.c b/arch/mips/loongson32/common/reset.c
deleted file mode 100644
index 0c7399b303fb..000000000000
--- a/arch/mips/loongson32/common/reset.c
+++ /dev/null
@@ -1,51 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
- */
-
-#include <linux/io.h>
-#include <linux/pm.h>
-#include <linux/sizes.h>
-#include <asm/idle.h>
-#include <asm/reboot.h>
-
-#include <loongson1.h>
-
-static void __iomem *wdt_reg_base;
-
-static void ls1x_halt(void)
-{
-	while (1) {
-		if (cpu_wait)
-			cpu_wait();
-	}
-}
-
-static void ls1x_restart(char *command)
-{
-	__raw_writel(0x1, wdt_reg_base + WDT_EN);
-	__raw_writel(0x1, wdt_reg_base + WDT_TIMER);
-	__raw_writel(0x1, wdt_reg_base + WDT_SET);
-
-	ls1x_halt();
-}
-
-static void ls1x_power_off(void)
-{
-	ls1x_halt();
-}
-
-static int __init ls1x_reboot_setup(void)
-{
-	wdt_reg_base = ioremap(LS1X_WDT_BASE, (SZ_4 + SZ_8));
-	if (!wdt_reg_base)
-		panic("Failed to remap watchdog registers");
-
-	_machine_restart = ls1x_restart;
-	_machine_halt = ls1x_halt;
-	pm_power_off = ls1x_power_off;
-
-	return 0;
-}
-
-arch_initcall(ls1x_reboot_setup);

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

