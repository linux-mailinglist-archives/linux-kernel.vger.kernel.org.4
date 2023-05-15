Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F8470239F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 07:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbjEOFv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 01:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbjEOFu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 01:50:58 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D5130E8
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 22:50:18 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-52cbd7e73d2so9104243a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 22:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1684129817; x=1686721817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXB6eSvEhnIAtMiQWlMtfWUjRdd7V8Gch2IVA+HK6fk=;
        b=U0mcG8H5YY2Vyomll1SSloHQ7j3xZ3h0taUBYR9HWxuhftAJz77gPcK8JbDKaKITgc
         j/XGK89FFCOjZKqKnXRRnXlf1FTi6WldLXMBlX+0qTlFeB1RQ5Yh/6K3nYVBrI176wAg
         8174L5aIV2VzEbT6+A+MLUBA52h45mGb9FpefsrgT60nAmTu0RlQWeZ/WiqWNVaxwfyx
         YfPMDCmyeIlAYtiZ2Zo3TyCjvIcw7WpIgYhJViXvLG9JWri3dvXz/M5AQYnPdNChZh/j
         yPJJtDmSSMwcM1W4wITa3hmbBcTCmP6tSPnAvOTsfvBhoA3rIvOkljagi+GumGLJwkvp
         IGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684129817; x=1686721817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXB6eSvEhnIAtMiQWlMtfWUjRdd7V8Gch2IVA+HK6fk=;
        b=Sefu+bs28lzFDkPvz+zfiZXnuTm0Kt8YKoPK+Lno343zcvLdvyea86J7kjcqbhEvhT
         Dpu0x8C++OGmfJsZH03G6CWyPu8Huop0BPA4N6Sa7ToeZ5mZ/obJMmtkZe1yepC7VuBq
         rx9UtoiAO0ooynDZPBYN0Fko4X0RWhlhFYkpG1v/JKht3QDUd0UQ+h9BOWPcGTSov67R
         KuXgN9Sj3o0TKi8V7BaqcqtMm8mys4uV0sXxcf9xmHR5M741N+AG+JS57ps3mDERbyJN
         Mj9WDcWD451IIo76ptOFBxWXEuqxE5Kjtm3VSWKUuU7nzY/nEKPUNPQEVjdVRn4VRvU3
         YN0w==
X-Gm-Message-State: AC+VfDz7JE0K1PCkt9Y4lR5IhvtHA9ZhnzhctLm7q17W8Z1Vu9I9JaUl
        +M17uLU8JmVvsqh0fvWwkeNOSQ==
X-Google-Smtp-Source: ACHHUZ4EW47E3fQ5nCmWDv7ZvwL4eMSyxTN/4wQ9IhNnxPkYKwBjKIH2Cr0yPWq98kuwVgrzJefpEQ==
X-Received: by 2002:a17:902:d2c2:b0:1ac:5dfa:3545 with SMTP id n2-20020a170902d2c200b001ac5dfa3545mr35362104plc.68.1684129817560;
        Sun, 14 May 2023 22:50:17 -0700 (PDT)
Received: from localhost.localdomain ([106.51.191.118])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001ab28f620d0sm12423277plt.290.2023.05.14.22.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 22:50:17 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH V6 06/21] RISC-V: Add support to build the ACPI core
Date:   Mon, 15 May 2023 11:19:13 +0530
Message-Id: <20230515054928.2079268-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
References: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ACPI core for RISC-V after adding architecture-specific
interfaces and header files required to build the ACPI core.

1) Couple of header files are required unconditionally by the ACPI
core. Add empty acenv.h and cpu.h header files.

2) If CONFIG_PCI is enabled, a few PCI related interfaces need to
be provided by the architecture. Define dummy interfaces for now
so that build succeeds. Actual implementation will be added when
PCI support is added for ACPI along with external interrupt
controller support.

3) A few globals and memory mapping related functions specific
to the architecture need to be provided.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/Kconfig             |  5 +++
 arch/riscv/include/asm/acenv.h | 11 +++++
 arch/riscv/include/asm/acpi.h  | 61 ++++++++++++++++++++++++++
 arch/riscv/include/asm/cpu.h   |  8 ++++
 arch/riscv/kernel/Makefile     |  1 +
 arch/riscv/kernel/acpi.c       | 80 ++++++++++++++++++++++++++++++++++
 6 files changed, 166 insertions(+)
 create mode 100644 arch/riscv/include/asm/acenv.h
 create mode 100644 arch/riscv/include/asm/acpi.h
 create mode 100644 arch/riscv/include/asm/cpu.h
 create mode 100644 arch/riscv/kernel/acpi.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 348c0fa1fc8c..491ecd7d2336 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,6 +12,8 @@ config 32BIT
 
 config RISCV
 	def_bool y
+	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
@@ -707,6 +709,7 @@ config EFI
 	depends on OF && !XIP_KERNEL
 	depends on MMU
 	default y
+	select ARCH_SUPPORTS_ACPI if 64BIT
 	select EFI_GENERIC_STUB
 	select EFI_PARAMS_FROM_FDT
 	select EFI_RUNTIME_WRAPPERS
@@ -816,3 +819,5 @@ source "drivers/cpufreq/Kconfig"
 endmenu # "CPU Power Management"
 
 source "arch/riscv/kvm/Kconfig"
+
+source "drivers/acpi/Kconfig"
diff --git a/arch/riscv/include/asm/acenv.h b/arch/riscv/include/asm/acenv.h
new file mode 100644
index 000000000000..43ae2e32c779
--- /dev/null
+++ b/arch/riscv/include/asm/acenv.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * RISC-V specific ACPICA environments and implementation
+ */
+
+#ifndef _ASM_ACENV_H
+#define _ASM_ACENV_H
+
+/* This header is required unconditionally by the ACPI core */
+
+#endif /* _ASM_ACENV_H */
diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
new file mode 100644
index 000000000000..bcade255bd6e
--- /dev/null
+++ b/arch/riscv/include/asm/acpi.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  Copyright (C) 2013-2014, Linaro Ltd.
+ *	Author: Al Stone <al.stone@linaro.org>
+ *	Author: Graeme Gregory <graeme.gregory@linaro.org>
+ *	Author: Hanjun Guo <hanjun.guo@linaro.org>
+ *
+ *  Copyright (C) 2021-2023, Ventana Micro Systems Inc.
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ */
+
+#ifndef _ASM_ACPI_H
+#define _ASM_ACPI_H
+
+/* Basic configuration for ACPI */
+#ifdef CONFIG_ACPI
+
+/* ACPI table mapping after acpi_permanent_mmap is set */
+void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
+#define acpi_os_ioremap acpi_os_ioremap
+
+#define acpi_strict 1	/* No out-of-spec workarounds on RISC-V */
+extern int acpi_disabled;
+extern int acpi_noirq;
+extern int acpi_pci_disabled;
+
+static inline void disable_acpi(void)
+{
+	acpi_disabled = 1;
+	acpi_pci_disabled = 1;
+	acpi_noirq = 1;
+}
+
+static inline void enable_acpi(void)
+{
+	acpi_disabled = 0;
+	acpi_pci_disabled = 0;
+	acpi_noirq = 0;
+}
+
+/*
+ * The ACPI processor driver for ACPI core code needs this macro
+ * to find out whether this cpu was already mapped (mapping from CPU hardware
+ * ID to CPU logical ID) or not.
+ */
+#define cpu_physical_id(cpu) cpuid_to_hartid_map(cpu)
+
+/*
+ * Since MADT must provide at least one RINTC structure, the
+ * CPU will be always available in MADT on RISC-V.
+ */
+static inline bool acpi_has_cpu_in_madt(void)
+{
+	return true;
+}
+
+static inline void arch_fix_phys_package_id(int num, u32 slot) { }
+
+#endif /* CONFIG_ACPI */
+
+#endif /*_ASM_ACPI_H*/
diff --git a/arch/riscv/include/asm/cpu.h b/arch/riscv/include/asm/cpu.h
new file mode 100644
index 000000000000..28d45a6678ce
--- /dev/null
+++ b/arch/riscv/include/asm/cpu.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_CPU_H
+#define _ASM_CPU_H
+
+/* This header is required unconditionally by the ACPI core */
+
+#endif /* _ASM_CPU_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index fbdccc21418a..ed5fcd90036e 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -92,3 +92,4 @@ obj-$(CONFIG_COMPAT)		+= compat_signal.o
 obj-$(CONFIG_COMPAT)		+= compat_vdso/
 
 obj-$(CONFIG_64BIT)		+= pi/
+obj-$(CONFIG_ACPI)		+= acpi.o
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
new file mode 100644
index 000000000000..81d448c41714
--- /dev/null
+++ b/arch/riscv/kernel/acpi.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  RISC-V Specific Low-Level ACPI Boot Support
+ *
+ *  Copyright (C) 2013-2014, Linaro Ltd.
+ *	Author: Al Stone <al.stone@linaro.org>
+ *	Author: Graeme Gregory <graeme.gregory@linaro.org>
+ *	Author: Hanjun Guo <hanjun.guo@linaro.org>
+ *	Author: Tomasz Nowicki <tomasz.nowicki@linaro.org>
+ *	Author: Naresh Bhat <naresh.bhat@linaro.org>
+ *
+ *  Copyright (C) 2021-2023, Ventana Micro Systems Inc.
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/io.h>
+#include <linux/pci.h>
+
+int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
+int acpi_disabled = 1;
+EXPORT_SYMBOL(acpi_disabled);
+
+int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
+EXPORT_SYMBOL(acpi_pci_disabled);
+
+/*
+ * __acpi_map_table() will be called before paging_init(), so early_ioremap()
+ * or early_memremap() should be called here to for ACPI table mapping.
+ */
+void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
+{
+	if (!size)
+		return NULL;
+
+	return early_memremap(phys, size);
+}
+
+void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
+{
+	if (!map || !size)
+		return;
+
+	early_memunmap(map, size);
+}
+
+void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
+{
+	return memremap(phys, size, MEMREMAP_WB);
+}
+
+#ifdef CONFIG_PCI
+
+/*
+ * These interfaces are defined just to enable building ACPI core.
+ * TODO: Update it with actual implementation when external interrupt
+ * controller support is added in RISC-V ACPI.
+ */
+int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
+		 int reg, int len, u32 *val)
+{
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
+		  int reg, int len, u32 val)
+{
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+{
+	return -1;
+}
+
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	return NULL;
+}
+#endif	/* CONFIG_PCI */
-- 
2.34.1

