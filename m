Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650A365C480
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbjACRAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238188AbjACRAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:00:11 -0500
Received: from fx303.security-mail.net (mxout.security-mail.net [85.31.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66A113CDC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:00:05 -0800 (PST)
Received: from localhost (fx303.security-mail.net [127.0.0.1])
        by fx303.security-mail.net (Postfix) with ESMTP id BAE1430F77E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764272;
        bh=EdnqG1KAqgYmpYE/tmmeoO8740z4EC//J13ezpA3GYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=v/xhSml/gceNiensXSTBcisYEn3IpbdmM46BmR5HjB/LfiPkbHy5rvXG2dkl1U9Vk
         TvJMELllRIp6d8LTUU3tpb2JY1hcR/fwnLI2NLFn9X2uj3F50AAGhrPa1gcs5pMNby
         AO7F5klqI1z/oHE9bJAndAHklfNJ/R5X80ONHiBw=
Received: from fx303 (fx303.security-mail.net [127.0.0.1]) by
 fx303.security-mail.net (Postfix) with ESMTP id 9701B30F746; Tue,  3 Jan
 2023 17:44:32 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx303.security-mail.net (Postfix) with ESMTPS id CF43230F704; Tue,  3 Jan
 2023 17:44:31 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 8EED027E03FF; Tue,  3 Jan 2023
 17:44:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 5FD5D27E03F6; Tue,  3 Jan 2023 17:44:31 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 ttGdzzmOOqyj; Tue,  3 Jan 2023 17:44:31 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 2DF8C27E03FD; Tue,  3 Jan 2023
 17:44:31 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <f4db.63b45b6f.cd419.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 5FD5D27E03F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764271;
 bh=KRQirq2AToEyUpS8QLt8KTFo/ZufFO4C9kC8toqLHTs=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=QB2gkx6Ywd8W0/xGzBy8LIK3z+0cXDxINkSCOtFDzAodFn5Y8dvqXVzo5mbVTda8V
 vMEgBDWyH06lqbo0m55q2tMUrALmuAcyhFK/pcHSgHpl04z8/DNDE+a+7BoKAjb+J+
 fvxhLysMa9CvD3HnWRX3YOETC0X59Cp/e+Asx9aA=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Julian Vetter <jvetter@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
Subject: [RFC PATCH 06/25] kvx: Add other common headers
Date:   Tue,  3 Jan 2023 17:43:40 +0100
Message-ID: <20230103164359.24347-7-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some other common headers for basic kvx support.

CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Will Deacon <will@kernel.org>
CC: Waiman Long <longman@redhat.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-kernel@vger.kernel.org
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 arch/kvx/include/asm/asm-prototypes.h   | 14 ++++++++
 arch/kvx/include/asm/clocksource.h      | 17 +++++++++
 arch/kvx/include/asm/linkage.h          | 13 +++++++
 arch/kvx/include/asm/pci.h              | 36 +++++++++++++++++++
 arch/kvx/include/asm/sections.h         | 18 ++++++++++
 arch/kvx/include/asm/spinlock.h         | 16 +++++++++
 arch/kvx/include/asm/spinlock_types.h   | 17 +++++++++
 arch/kvx/include/asm/stackprotector.h   | 47 +++++++++++++++++++++++++
 arch/kvx/include/asm/timex.h            | 20 +++++++++++
 arch/kvx/include/asm/types.h            | 12 +++++++
 arch/kvx/include/uapi/asm/bitsperlong.h | 14 ++++++++
 arch/kvx/include/uapi/asm/byteorder.h   | 12 +++++++
 tools/include/uapi/asm/bitsperlong.h    |  2 ++
 13 files changed, 238 insertions(+)
 create mode 100644 arch/kvx/include/asm/asm-prototypes.h
 create mode 100644 arch/kvx/include/asm/clocksource.h
 create mode 100644 arch/kvx/include/asm/linkage.h
 create mode 100644 arch/kvx/include/asm/pci.h
 create mode 100644 arch/kvx/include/asm/sections.h
 create mode 100644 arch/kvx/include/asm/spinlock.h
 create mode 100644 arch/kvx/include/asm/spinlock_types.h
 create mode 100644 arch/kvx/include/asm/stackprotector.h
 create mode 100644 arch/kvx/include/asm/timex.h
 create mode 100644 arch/kvx/include/asm/types.h
 create mode 100644 arch/kvx/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/kvx/include/uapi/asm/byteorder.h

diff --git a/arch/kvx/include/asm/asm-prototypes.h b/arch/kvx/include/asm/asm-prototypes.h
new file mode 100644
index 000000000000..af032508e30c
--- /dev/null
+++ b/arch/kvx/include/asm/asm-prototypes.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_ASM_PROTOTYPES_H
+#define _ASM_KVX_ASM_PROTOTYPES_H
+
+#include <asm/string.h>
+
+#include <asm-generic/asm-prototypes.h>
+
+#endif /* _ASM_KVX_ASM_PROTOTYPES_H */
diff --git a/arch/kvx/include/asm/clocksource.h b/arch/kvx/include/asm/clocksource.h
new file mode 100644
index 000000000000..4df7c66ffbb5
--- /dev/null
+++ b/arch/kvx/include/asm/clocksource.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Yann Sionneau
+ *            Clement Leger
+ */
+
+#ifndef _ASM_KVX_CLOCKSOURCE_H
+#define _ASM_KVX_CLOCKSOURCE_H
+
+#include <linux/compiler.h>
+
+struct arch_clocksource_data {
+	void __iomem *regs;
+};
+
+#endif /* _ASM_KVX_CLOCKSOURCE_H */
diff --git a/arch/kvx/include/asm/linkage.h b/arch/kvx/include/asm/linkage.h
new file mode 100644
index 000000000000..84e1cacf67c2
--- /dev/null
+++ b/arch/kvx/include/asm/linkage.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Yann Sionneau
+ */
+
+#ifndef __ASM_KVX_LINKAGE_H
+#define __ASM_KVX_LINKAGE_H
+
+#define __ALIGN		.align 4
+#define __ALIGN_STR	".align 4"
+
+#endif
diff --git a/arch/kvx/include/asm/pci.h b/arch/kvx/include/asm/pci.h
new file mode 100644
index 000000000000..d5bbaaf041b5
--- /dev/null
+++ b/arch/kvx/include/asm/pci.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Vincent Chardon
+ *            Clement Leger
+ */
+
+#ifndef __ASM_KVX_PCI_H_
+#define __ASM_KVX_PCI_H_
+
+#include <linux/dma-mapping.h>
+#include <linux/pci.h>
+#include <linux/of_gpio.h>
+
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
+#define HAVE_PCI_MMAP			1
+
+extern int isa_dma_bridge_buggy;
+
+/* Can be used to override the logic in pci_scan_bus for skipping
+ * already-configured bus numbers - to be used for buggy BIOSes
+ * or architectures with incomplete PCI setup by the loader.
+ */
+#define pcibios_assign_all_busses()	0
+
+#define PCIBIOS_MIN_IO          0UL
+#define PCIBIOS_MIN_MEM         0UL
+
+#ifdef CONFIG_PCI_DOMAINS
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+		return pci_domain_nr(bus);
+}
+#endif /*  CONFIG_PCI_DOMAINS */
+
+#endif /* _ASM_KVX_PCI_H */
diff --git a/arch/kvx/include/asm/sections.h b/arch/kvx/include/asm/sections.h
new file mode 100644
index 000000000000..0777675ef264
--- /dev/null
+++ b/arch/kvx/include/asm/sections.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SECTIONS_H
+#define _ASM_KVX_SECTIONS_H
+
+#include <asm-generic/sections.h>
+
+extern char __rodata_start[], __rodata_end[];
+extern char __initdata_start[], __initdata_end[];
+extern char __inittext_start[], __inittext_end[];
+extern char __exception_start[], __exception_end[];
+extern char __rm_firmware_regs_start[];
+
+#endif
diff --git a/arch/kvx/include/asm/spinlock.h b/arch/kvx/include/asm/spinlock.h
new file mode 100644
index 000000000000..ed32fdba1e19
--- /dev/null
+++ b/arch/kvx/include/asm/spinlock.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SPINLOCK_H
+#define _ASM_KVX_SPINLOCK_H
+
+#include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
+
+/* See include/linux/spinlock.h */
+#define smp_mb__after_spinlock()	smp_mb()
+
+#endif
diff --git a/arch/kvx/include/asm/spinlock_types.h b/arch/kvx/include/asm/spinlock_types.h
new file mode 100644
index 000000000000..929a7df16ef3
--- /dev/null
+++ b/arch/kvx/include/asm/spinlock_types.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SPINLOCK_TYPES_H
+#define _ASM_KVX_SPINLOCK_TYPES_H
+
+#if !defined(__LINUX_SPINLOCK_TYPES_RAW_H) && !defined(__ASM_SPINLOCK_H)
+# error "please don't include this file directly"
+#endif
+
+#include <asm-generic/qspinlock_types.h>
+#include <asm-generic/qrwlock_types.h>
+
+#endif /* _ASM_KVX_SPINLOCK_TYPES_H */
diff --git a/arch/kvx/include/asm/stackprotector.h b/arch/kvx/include/asm/stackprotector.h
new file mode 100644
index 000000000000..2c190bbb5efc
--- /dev/null
+++ b/arch/kvx/include/asm/stackprotector.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * derived from arch/mips/include/asm/stackprotector.h
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+/*
+ * GCC stack protector support.
+ *
+ * Stack protector works by putting predefined pattern at the start of
+ * the stack frame and verifying that it hasn't been overwritten when
+ * returning from the function.  The pattern is called stack canary
+ * and gcc expects it to be defined by a global variable called
+ * "__stack_chk_guard" on KVX.  This unfortunately means that on SMP
+ * we cannot have a different canary value per task.
+ */
+
+#ifndef __ASM_STACKPROTECTOR_H
+#define __ASM_STACKPROTECTOR_H
+
+#include <linux/random.h>
+#include <linux/version.h>
+
+extern unsigned long __stack_chk_guard;
+
+/*
+ * Initialize the stackprotector canary value.
+ *
+ * NOTE: this must only be called from functions that never return,
+ * and it must always be inlined.
+ */
+static __always_inline void boot_init_stack_canary(void)
+{
+	unsigned long canary;
+
+	/* Try to get a semi random initial value. */
+	get_random_bytes(&canary, sizeof(canary));
+	canary ^= LINUX_VERSION_CODE;
+	canary &= CANARY_MASK;
+
+	current->stack_canary = canary;
+	__stack_chk_guard = current->stack_canary;
+}
+
+#endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/kvx/include/asm/timex.h b/arch/kvx/include/asm/timex.h
new file mode 100644
index 000000000000..51e346faa887
--- /dev/null
+++ b/arch/kvx/include/asm/timex.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_TIMEX_H
+#define _ASM_KVX_TIMEX_H
+
+#define get_cycles get_cycles
+
+#include <asm/sfr.h>
+#include <asm-generic/timex.h>
+
+static inline cycles_t get_cycles(void)
+{
+	return kvx_sfr_get(PM0);
+}
+
+#endif	/* _ASM_KVX_TIMEX_H */
diff --git a/arch/kvx/include/asm/types.h b/arch/kvx/include/asm/types.h
new file mode 100644
index 000000000000..1e6c024ee892
--- /dev/null
+++ b/arch/kvx/include/asm/types.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_TYPES_H
+#define _ASM_KVX_TYPES_H
+
+#include <asm-generic/int-ll64.h>
+
+#endif	/* _ASM_KVX_TYPES_H */
diff --git a/arch/kvx/include/uapi/asm/bitsperlong.h b/arch/kvx/include/uapi/asm/bitsperlong.h
new file mode 100644
index 000000000000..02a91596d567
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/bitsperlong.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _UAPI_ASM_KVX_BITSPERLONG_H
+#define _UAPI_ASM_KVX_BITSPERLONG_H
+
+#define __BITS_PER_LONG 64
+
+#include <asm-generic/bitsperlong.h>
+
+#endif /* _UAPI_ASM_KVX_BITSPERLONG_H */
diff --git a/arch/kvx/include/uapi/asm/byteorder.h b/arch/kvx/include/uapi/asm/byteorder.h
new file mode 100644
index 000000000000..b7d827daec73
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/byteorder.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_BYTEORDER_H
+#define _ASM_KVX_BYTEORDER_H
+
+#include <linux/byteorder/little_endian.h>
+
+#endif	/* _ASM_KVX_BYTEORDER_H */
diff --git a/tools/include/uapi/asm/bitsperlong.h b/tools/include/uapi/asm/bitsperlong.h
index da5206517158..40272ffa9c32 100644
--- a/tools/include/uapi/asm/bitsperlong.h
+++ b/tools/include/uapi/asm/bitsperlong.h
@@ -19,6 +19,8 @@
 #include "../../../arch/alpha/include/uapi/asm/bitsperlong.h"
 #elif defined(__loongarch__)
 #include "../../../arch/loongarch/include/uapi/asm/bitsperlong.h"
+#elif defined(__kvx__)
+#include "../../../arch/kvx/include/uapi/asm/bitsperlong.h"
 #else
 #include <asm-generic/bitsperlong.h>
 #endif
-- 
2.37.2





