Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6F65EEBD0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiI2CeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiI2Cdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:33:38 -0400
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2043D1257B1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5564; q=dns/txt; s=iport;
  t=1664418804; x=1665628404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J8FJpY07GQUODCXLNSH1A91a8Eozm/bUH4IvAo0MNTc=;
  b=gIDfw2VZGHV83/PzqTk6p7dGMU8fbvCq1qfBaSnR1P1liEO03gBFPyCq
   i0nH+Dye1bqhL3HmAzhKZ6uckhxmrKS37iysMj9pJ0VfFzc/X5hhrKS0g
   Gd9JUuwDZt8F1tzRB7xnB5ZEFzwdvzMgtAO7MhbaT1RXDhC/qXhp9ucEF
   Q=;
IronPort-Data: =?us-ascii?q?A9a23=3AJhKOVKmfAHluLfib9LOpERfo5gz6J0RdPkR7X?=
 =?us-ascii?q?Q2eYbSJt1+Wr1GztxIXXjvTPf+NN2bzKNsnbtuyp0lSscXQmIQxGVFlrixkF?=
 =?us-ascii?q?ltH+JHPbTi7wugcHM8zwvUuxyuL1u1GAjX7BJ1yHya0SiuFaOC79yEhjP/QH?=
 =?us-ascii?q?9IQNcadUsxPbV48IMseoUoLd94R2uaEsPDha++/kYqaT/73YDdJ7wVJ3lc8s?=
 =?us-ascii?q?Mpvnv/AUMPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnRE?=
 =?us-ascii?q?mLx5RwhDJaulaz2Nx1MSb/JNg/IgX1TM0SgqkEd/WppjeBqb7xFNRs/Zzahx?=
 =?us-ascii?q?7idzP1BvJqxRAM2N4XHmf8WVF9TFCQW0ahuqe+aeCju7ZHOp6HBWz62qxl0N?=
 =?us-ascii?q?2kyPIsF6qN0DHtI+PgwNj8AdFaAiviwzbb9TfNj7uwnLc/2LMYWoHQlzjzDC?=
 =?us-ascii?q?/siaZTCWLnRo95e0i05is1HEbDZfcVxQTFmcB3EYhsJP14NCZQ3h8+hnHy5e?=
 =?us-ascii?q?DpdwHqOqKMxpWHVwAFry7/rGMHYcdvMTsJQ9m6RpXrD12D4BAwKcdKY1DyJ+?=
 =?us-ascii?q?26tgemJmjn0MKoeHbu5+/pCj1yW3mEXBQMXXlv9uvC/z0CkUtRUKlcf/Wwlp?=
 =?us-ascii?q?O4v7ySDVN73XzW7rWSCsxpaXMBfe8Ux6BuM0bbT+waUQGwJVDlQQNc9u9UxW?=
 =?us-ascii?q?CRs20Lht8zoAThHs7CPT3+ZsLCOoluP1YI9RYMZTTUPQQ1A6N75rcRjyBnOV?=
 =?us-ascii?q?d1kVqWyi7XI9fjL62jihEADa3871KbnD5mGwG0=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AvZpxsKutibipFjedVsQ4VExM7skDTdV00z?=
 =?us-ascii?q?EX/kB9WHVpmwKj+/xG+85rsSMc5wx+ZJhNo7q90ey7MBDhHP1OkOws1MmZPT?=
 =?us-ascii?q?UO0VHAROpfBMnZsl/d8kbFmdK1u50MT0FWMqyWMbEDt6bHCM3SKadY/DFBm5?=
 =?us-ascii?q?rY49vj8w=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0A5AADea4Ji/5BdJa1aHQEBAQEJARI?=
 =?us-ascii?q?BBQUBgXsIAQsBgiqBSz1DjG+lUYF8CwEBAQ9CBAEBhQIChT4CJTQJDgECBAE?=
 =?us-ascii?q?BARIBAQUBAQECAQcEgQkThXWGQwYyAUYQUVcGARKCfYMYq1aCK4EBiBmBZRS?=
 =?us-ascii?q?BKAGJQ4UcJxyBSUSCUYIsin8Ek3OCKwMJBgcFgT4SgSFxAQgGBgcKBTIGAgw?=
 =?us-ascii?q?YFAQCExJNBgwSAhMMCgYWDg40EhkMDwMSAxEBBwILEggVLAgDAgMIAwIDIws?=
 =?us-ascii?q?CAxgJBwoDHQgKHBIQFAIEEx8LCAMaHy0JAgQOA0MICwoDEQQDExgLFggQBAY?=
 =?us-ascii?q?DCS8NKAsDBQ8PAQYDBgIFBQEDIAMUAwUnBwMhBwsmDQ0EIx0DAwUmAwICGwc?=
 =?us-ascii?q?CAgMCBhcGAgIZJzEKKA0IBAgEGAQeJQ4FBQIHMQUELwIeBAUGEQkCFgIGBAU?=
 =?us-ascii?q?CBAQWAgISCAIIJxsHFjYZAQVdBgsJIxYGLBEFBhYDJlIGIh2XYQGBD4IFbpJ?=
 =?us-ascii?q?ABpAlniqDVoFDni0aMahXlmYgoVRlhE6BYTyBWTMaCBsVgyNRGQ+OLBaNcQF?=
 =?us-ascii?q?cJDE7AgYLAQEDCZEaAQE?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="985189455"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 29 Sep 2022 02:33:22 +0000
Received: from zorba.cisco.com ([10.25.129.98])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id 28T2X1Yx007711;
        Thu, 29 Sep 2022 02:33:21 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     xe-linux-external@cisco.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] CMDLINE: arm64: convert to generic builtin command line
Date:   Wed, 28 Sep 2022 19:32:54 -0700
Message-Id: <20220929023301.3344694-9-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929023301.3344694-1-danielwa@cisco.com>
References: <20220929023301.3344694-1-danielwa@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.129.98, [10.25.129.98]
X-Outbound-Node: rcdn-core-8.cisco.com
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes arm64 from the device tree handling of the
command line arguments.

The boot_command_line variable is populated inside the earliest
user of the command line, which is in idreg-override.c.

The device tree should not be needed to do any further handling
of the boot command line options.

Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 arch/arm64/Kconfig                  | 33 +----------------------------
 arch/arm64/include/asm/setup.h      |  4 ++++
 arch/arm64/include/uapi/asm/setup.h |  2 ++
 arch/arm64/kernel/idreg-override.c  |  9 ++++----
 arch/arm64/kernel/pi/kaslr_early.c  | 14 ++++++------
 5 files changed, 19 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1ce7685ad5de..a3f38d88bfe6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -123,6 +123,7 @@ config ARM64
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_CLOCKEVENTS_BROADCAST
+	select GENERIC_CMDLINE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
@@ -2137,38 +2138,6 @@ config ARM64_ACPI_PARKING_PROTOCOL
 	  protocol even if the corresponding data is present in the ACPI
 	  MADT table.
 
-config CMDLINE
-	string "Default kernel command string"
-	default ""
-	help
-	  Provide a set of default command-line options at build time by
-	  entering them here. As a minimum, you should specify the the
-	  root device (e.g. root=/dev/nfs).
-
-choice
-	prompt "Kernel command line type" if CMDLINE != ""
-	default CMDLINE_FROM_BOOTLOADER
-	help
-	  Choose how the kernel will handle the provided default kernel
-	  command line string.
-
-config CMDLINE_FROM_BOOTLOADER
-	bool "Use bootloader kernel arguments if available"
-	help
-	  Uses the command-line options passed by the boot loader. If
-	  the boot loader doesn't provide any, the default kernel command
-	  string provided in CMDLINE will be used.
-
-config CMDLINE_FORCE
-	bool "Always use the default kernel command string"
-	help
-	  Always use the default kernel command string, even if the boot
-	  loader passes other arguments to the kernel.
-	  This is useful if you cannot or don't want to change the
-	  command-line options your boot loader passes to the kernel.
-
-endchoice
-
 config EFI_STUB
 	bool
 
diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index f4af547ef54c..5a8037262cbb 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -3,10 +3,13 @@
 #ifndef __ARM64_ASM_SETUP_H
 #define __ARM64_ASM_SETUP_H
 
+#ifndef __ASSEMBLY__
 #include <linux/string.h>
+#endif
 
 #include <uapi/asm/setup.h>
 
+#ifndef __ASSEMBLY__
 void *get_early_fdt_ptr(void);
 void early_fdt_map(u64 dt_phys);
 
@@ -30,5 +33,6 @@ static inline bool arch_parse_debug_rodata(char *arg)
 	return false;
 }
 #define arch_parse_debug_rodata arch_parse_debug_rodata
+#endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/uapi/asm/setup.h b/arch/arm64/include/uapi/asm/setup.h
index 5d703888f351..f5fc5b806369 100644
--- a/arch/arm64/include/uapi/asm/setup.h
+++ b/arch/arm64/include/uapi/asm/setup.h
@@ -20,7 +20,9 @@
 #ifndef __ASM_SETUP_H
 #define __ASM_SETUP_H
 
+#ifndef __ASSEMBLY__
 #include <linux/types.h>
+#endif
 
 #define COMMAND_LINE_SIZE	2048
 
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 1b0542c69738..e1fc7f1d02c1 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -9,6 +9,7 @@
 #include <linux/ctype.h>
 #include <linux/kernel.h>
 #include <linux/libfdt.h>
+#include <linux/cmdline.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
@@ -287,11 +288,11 @@ static __init void parse_cmdline(void)
 {
 	const u8 *prop = get_bootargs_cmdline();
 
-	if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !prop)
-		__parse_cmdline(CONFIG_CMDLINE, true);
+	strscpy(boot_command_line, prop, COMMAND_LINE_SIZE);
+	cmdline_add_builtin(boot_command_line);
+
+	__parse_cmdline(boot_command_line, true);
 
-	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && prop)
-		__parse_cmdline(prop, true);
 }
 
 /* Keep checkers quiet */
diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
index 17bff6e399e4..1e00bc01fa7a 100644
--- a/arch/arm64/kernel/pi/kaslr_early.c
+++ b/arch/arm64/kernel/pi/kaslr_early.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
+#include <linux/cmdline.h>
 
 #include <asm/archrandom.h>
 #include <asm/memory.h>
@@ -42,7 +43,7 @@ static bool cmdline_contains_nokaslr(const u8 *cmdline)
 
 static bool is_kaslr_disabled_cmdline(void *fdt)
 {
-	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
+	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
 		int node;
 		const u8 *prop;
 
@@ -54,16 +55,15 @@ static bool is_kaslr_disabled_cmdline(void *fdt)
 		if (!prop)
 			goto out;
 
+		if (cmdline_contains_nokaslr(CMDLINE_STATIC_APPEND))
+			return true;
 		if (cmdline_contains_nokaslr(prop))
 			return true;
-
-		if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
-			goto out;
-
-		return false;
+		if (cmdline_contains_nokaslr(CMDLINE_STATIC_PREPEND))
+			return true;
 	}
 out:
-	return cmdline_contains_nokaslr(CONFIG_CMDLINE);
+	return cmdline_contains_nokaslr(cmdline_get_static_builtin());
 }
 
 static u64 get_kaslr_seed(void *fdt)
-- 
2.25.1

