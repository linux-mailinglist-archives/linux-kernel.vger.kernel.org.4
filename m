Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0805BD353
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiISRIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiISRIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:08:00 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E589A40E2A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:05:55 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MWWF74ty7z9sl6;
        Mon, 19 Sep 2022 19:02:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JPH3j7p6QAFF; Mon, 19 Sep 2022 19:02:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MWWDr60nxz9slB;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C356A8B775;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id X8zqCz8SfniM; Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.8])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 77F098B781;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 28JH1vAA1549594
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 19:01:57 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 28JH1vxP1549593;
        Mon, 19 Sep 2022 19:01:57 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 05/19] powerpc/cputable: Move __cpu_setup() prototypes out of cputable.h
Date:   Mon, 19 Sep 2022 19:01:29 +0200
Message-Id: <f45118489ee450db654db8bbcdfd8f5907337c22.1663606875.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu>
References: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663606899; l=7788; s=20211009; h=from:subject:message-id; bh=sVD1UbssGC3ZWyGiihC1NO31adaAXqH5RcLy0K+cuQU=; b=x9vs46X4sp3ziMhfac/eFh3Z0A3P9uV33Kug1kNP5pZEC/hh6jcqIiq3v/EBIU7+nQYa5loa98Fb oBe7Gnr8D+J9X5a6AshDPXjJZBvh8pw1CUCjNbRU/0cTbNz9lqpR
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all prototypes out of cputable.h

For that rename cpu_setup_power.h to cpu_setup.h and move all
prototypes in it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/cpu_setup.h       | 49 ++++++++++++++++++++++
 arch/powerpc/include/asm/cpu_setup_power.h | 12 ------
 arch/powerpc/kernel/cpu_setup_power.c      |  2 +-
 arch/powerpc/kernel/cputable.c             | 38 +----------------
 4 files changed, 51 insertions(+), 50 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cpu_setup.h
 delete mode 100644 arch/powerpc/include/asm/cpu_setup_power.h

diff --git a/arch/powerpc/include/asm/cpu_setup.h b/arch/powerpc/include/asm/cpu_setup.h
new file mode 100644
index 000000000000..d497b051598f
--- /dev/null
+++ b/arch/powerpc/include/asm/cpu_setup.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 IBM Corporation
+ */
+
+#ifndef _ASM_POWERPC_CPU_SETUP_H
+#define _ASM_POWERPC_CPU_SETUP_H
+void __setup_cpu_power7(unsigned long offset, struct cpu_spec *spec);
+void __setup_cpu_power8(unsigned long offset, struct cpu_spec *spec);
+void __setup_cpu_power9(unsigned long offset, struct cpu_spec *spec);
+void __setup_cpu_power10(unsigned long offset, struct cpu_spec *spec);
+void __restore_cpu_power7(void);
+void __restore_cpu_power8(void);
+void __restore_cpu_power9(void);
+void __restore_cpu_power10(void);
+
+void __setup_cpu_e500v1(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_e500v2(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_e500mc(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_440ep(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_440epx(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_440gx(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_440grx(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_440spe(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_440x5(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_460ex(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_460gt(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_460sx(unsigned long offset, struct cpu_spec *spec);
+void __setup_cpu_apm821xx(unsigned long offset, struct cpu_spec *spec);
+void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_750cx(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_750fx(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_7400(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_7410(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_745x(unsigned long offset, struct cpu_spec* spec);
+
+void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_ppc970MP(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_pa6t(unsigned long offset, struct cpu_spec* spec);
+void __restore_cpu_pa6t(void);
+void __restore_cpu_ppc970(void);
+
+void __setup_cpu_e5500(unsigned long offset, struct cpu_spec* spec);
+void __setup_cpu_e6500(unsigned long offset, struct cpu_spec* spec);
+void __restore_cpu_e5500(void);
+void __restore_cpu_e6500(void);
+#endif /* _ASM_POWERPC_CPU_SETUP_H */
diff --git a/arch/powerpc/include/asm/cpu_setup_power.h b/arch/powerpc/include/asm/cpu_setup_power.h
deleted file mode 100644
index 24be9131f803..000000000000
--- a/arch/powerpc/include/asm/cpu_setup_power.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2020 IBM Corporation
- */
-void __setup_cpu_power7(unsigned long offset, struct cpu_spec *spec);
-void __restore_cpu_power7(void);
-void __setup_cpu_power8(unsigned long offset, struct cpu_spec *spec);
-void __restore_cpu_power8(void);
-void __setup_cpu_power9(unsigned long offset, struct cpu_spec *spec);
-void __restore_cpu_power9(void);
-void __setup_cpu_power10(unsigned long offset, struct cpu_spec *spec);
-void __restore_cpu_power10(void);
diff --git a/arch/powerpc/kernel/cpu_setup_power.c b/arch/powerpc/kernel/cpu_setup_power.c
index 3dc61e203f37..097c033668f0 100644
--- a/arch/powerpc/kernel/cpu_setup_power.c
+++ b/arch/powerpc/kernel/cpu_setup_power.c
@@ -11,7 +11,7 @@
 #include <asm/synch.h>
 #include <linux/bitops.h>
 #include <asm/cputable.h>
-#include <asm/cpu_setup_power.h>
+#include <asm/cpu_setup.h>
 
 /* Disable CPU_FTR_HVMODE and return false if MSR:HV is not set */
 static bool init_hvmode_206(struct cpu_spec *t)
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 5ace97cccad8..9229e0930332 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -18,6 +18,7 @@
 #include <asm/mce.h>
 #include <asm/mmu.h>
 #include <asm/setup.h>
+#include <asm/cpu_setup.h>
 
 static struct cpu_spec the_cpu_spec __read_mostly;
 
@@ -34,43 +35,6 @@ const char *powerpc_base_platform;
  * part of the cputable though. That has to be fixed for both ppc32
  * and ppc64
  */
-#ifdef CONFIG_PPC32
-extern void __setup_cpu_e500v1(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_e500v2(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_e500mc(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_440ep(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_440epx(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_440gx(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_440grx(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_440spe(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_440x5(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_460ex(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_460gt(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_460sx(unsigned long offset, struct cpu_spec *spec);
-extern void __setup_cpu_apm821xx(unsigned long offset, struct cpu_spec *spec);
-extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_750cx(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_750fx(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_7400(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_7410(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_745x(unsigned long offset, struct cpu_spec* spec);
-#endif /* CONFIG_PPC32 */
-#ifdef CONFIG_PPC64
-#include <asm/cpu_setup_power.h>
-extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_ppc970MP(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_pa6t(unsigned long offset, struct cpu_spec* spec);
-extern void __restore_cpu_pa6t(void);
-extern void __restore_cpu_ppc970(void);
-#endif /* CONFIG_PPC64 */
-#if defined(CONFIG_E500)
-extern void __setup_cpu_e5500(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_e6500(unsigned long offset, struct cpu_spec* spec);
-extern void __restore_cpu_e5500(void);
-extern void __restore_cpu_e6500(void);
-#endif /* CONFIG_E500 */
 
 /* This table only contains "desktop" CPUs, it need to be filled with embedded
  * ones as well...
-- 
2.37.1

