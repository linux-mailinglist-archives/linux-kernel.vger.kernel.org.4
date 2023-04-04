Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7706D6BB6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbjDDSYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDDSXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:23:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BCC61B7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:22:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so34861744pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680632538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0yVz+rx5mJyuV/igvCpVezJBLvGHPHOHFjhwqh4528=;
        b=oEps0B7/DRSDt7bmDQYZ0dBfuyVUjzaipEBZoaExzXEqzsQMPLL9DUjQK+NxXQ88Mo
         QavpjuheqcQal2txIqOI+efI25mzgX9Y1IQpUhYVttp1lL8+k4iMq7i2pJYM/LgqMneU
         Z7UvFh5byuD3lCl4oLc3SK/KteJ9lYrD7EDFx0qTyCaIhqdsfDF/sijS3MXtxWfwmF4N
         Uvb8cIJ0PAWn+i6td6w6ysH+tC9NHniNj1dh3hInHEdibXbvcArsFlWDKSpSp2CL27Ak
         reOjjWWbC+6tAboZU7ZWaxcW3QuhWhrM5A/2C/j7zflSdn4AI4RmgnvrI4DoaoLF+R46
         Px/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0yVz+rx5mJyuV/igvCpVezJBLvGHPHOHFjhwqh4528=;
        b=Mkep6Dfn1UzHD21A5dI+S9UuOT6Qn/qUVDEUauM7T0fWQ0KxyKfSkdtv+wZC6/EEu/
         LsZdVf8n5aSn3tdkkYkyBiiJINNFzLXdhTPKkUuYkE5dl3m4IQbQ95jDT+bthvx2nQmH
         vnd0WLRZMg9Fwi0N91MLwOyDulRie3SldwSwoSiBbTfTy5UpdO1fi/Gc2sbTHRH0IDwL
         LvxNyHAIOg2pGCHVpX3WnMs/vrrlEvosqxfuSMdIXjLXBZYGG7PKltFZK6x3LLIkxoZ0
         MOGL+zKRiGDNkh08pfEg40ZwMvWHA+zGcy5oTPSz/gN89cDqslJYBtGf1UqN3LV2OdQu
         WS1A==
X-Gm-Message-State: AAQBX9cfE4Aq09hyw6VQzuRzfEdAbtbhvqgMqYedL5tbiWa6bG8uga2L
        8lqefjEYu8S+rZy+9qzFXUNHcQ==
X-Google-Smtp-Source: AKy350aDIqed68Tg6fTeWtMp8izSaSZsVOimTSd1vrtt0fPi1Ga8SebKpp0Erae9ssuYrl2S+uCy0A==
X-Received: by 2002:a05:6a20:4d97:b0:bc:80bd:462d with SMTP id gj23-20020a056a204d9700b000bc80bd462dmr2867307pzb.46.1680632538022;
        Tue, 04 Apr 2023 11:22:18 -0700 (PDT)
Received: from localhost.localdomain ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b0062dcf5c01f9sm9018524pfw.36.2023.04.04.11.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:22:17 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH V4 13/23] RISC-V: cpufeature: Add ACPI support in riscv_fill_hwcap()
Date:   Tue,  4 Apr 2023 23:50:27 +0530
Message-Id: <20230404182037.863533-14-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404182037.863533-1-sunilvl@ventanamicro.com>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ACPI based systems, the information about the hart
like ISA is provided by the RISC-V Hart Capabilities Table (RHCT).
Enable filling up hwcap structure based on the information in RHCT.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/cpufeature.c | 39 ++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 63e56ce04162..5d2065b937e5 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
 #include <linux/libfdt.h>
@@ -13,6 +14,8 @@
 #include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
+#include <asm/acpi.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/errata_list.h>
@@ -91,6 +94,9 @@ void __init riscv_fill_hwcap(void)
 	char print_str[NUM_ALPHA_EXTS + 1];
 	int i, j, rc;
 	unsigned long isa2hwcap[26] = {0};
+	struct acpi_table_header *rhct;
+	acpi_status status;
+	unsigned int cpu;
 
 	isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
 	isa2hwcap['m' - 'a'] = COMPAT_HWCAP_ISA_M;
@@ -103,14 +109,36 @@ void __init riscv_fill_hwcap(void)
 
 	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
 
-	for_each_of_cpu_node(node) {
+	if (!acpi_disabled) {
+		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
+		if (ACPI_FAILURE(status))
+			return;
+	}
+
+	for_each_possible_cpu(cpu) {
 		unsigned long this_hwcap = 0;
 		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
 		const char *temp;
 
-		if (of_property_read_string(node, "riscv,isa", &isa)) {
-			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
-			continue;
+		if (acpi_disabled) {
+			node = of_cpu_device_node_get(cpu);
+			if (node) {
+				rc = of_property_read_string(node, "riscv,isa", &isa);
+				of_node_put(node);
+				if (rc) {
+					pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
+					continue;
+				}
+			} else {
+				pr_warn("Unable to find cpu node\n");
+				continue;
+			}
+		} else {
+			rc = acpi_get_riscv_isa(rhct, cpu, &isa);
+			if (rc < 0) {
+				pr_warn("Unable to get ISA for the hart - %d\n", cpu);
+				continue;
+			}
 		}
 
 		temp = isa;
@@ -243,6 +271,9 @@ void __init riscv_fill_hwcap(void)
 			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
 	}
 
+	if (!acpi_disabled && rhct)
+		acpi_put_table((struct acpi_table_header *)rhct);
+
 	/* We don't support systems with F but without D, so mask those out
 	 * here. */
 	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
-- 
2.34.1

