Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C105EEBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiI2Cds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiI2Cde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:33:34 -0400
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5431176D7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4126; q=dns/txt; s=iport;
  t=1664418799; x=1665628399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M8zigXaLcJU6pIz+WM/HCDtxuvpTB9QDBodO+P25ipM=;
  b=hU30l8+Mh+Y369c4eu7/wvc+iIO9WVTt1Sll3MPcg0niJbtGBglmPd+X
   4GrLFiOpugInBW9+jBzci1AoojdGkYGJrHFwF18C40HQvz1JdJsfcNwLK
   f0l9ipnfFNZtNQCWL4uIWJZcv8592+0Cn9Ym//QDsM33JehzOulP15vUQ
   Q=;
IronPort-Data: =?us-ascii?q?A9a23=3AzHmYE67PG3CKaz4P075V8gxRtPfGchMFZxGqf?=
 =?us-ascii?q?qrLsTDasY5as4F+vmdKCj+EbPfbZmT2eIh+ao+2oRxU7ZfXyoJkSlZprShkZ?=
 =?us-ascii?q?n8b8sCt6fZ1gavT04J+FiBIJa5ex512huLocYZlFxcwmj/3auK79SQli/nRL?=
 =?us-ascii?q?lbBILes1h5ZFFcMpBgJ0XqPq8Zh6mJZqYDR7zGl4LsekOWHULOR4AOYB0pPg?=
 =?us-ascii?q?061RLyDi9yp0N8QlgRWifmmJzYynVFNZH4UDfnZw3cV3uBp8uCGq+brlNlV/?=
 =?us-ascii?q?0vD9BsrT9iiiLu+IgsBQ6XZOk6FjX8+t6qK20cZ4HdtlPdgcqNANS+7iB3R9?=
 =?us-ascii?q?zx14NlEs529TRggFqbNg+8aFRJfFkmSOIUfoOKceSjl6pfDp6HBWz62qxl0N?=
 =?us-ascii?q?2kyPIsF6qN0DHtI+PgwNj8AdFaAiviwzbb9TfNj7uw5MdLvNYVZsHBkyi/eC?=
 =?us-ascii?q?d4pRJnCR+PB4tow9Dcoj+hcDOrZfYwSbj8HRASQPTVMN00RBZZ4m/2n7lHze?=
 =?us-ascii?q?iNV7lKco7E65UDXzQpswP7sNsbYfpqBQsA9tkyAjmvC/mn/UlcWObS3zDuD/?=
 =?us-ascii?q?XWEnOLDnSrnHokVEdWQ6vFukHWXx2oOFAcRU1qr5/W04malVttZbUUS9ic0t?=
 =?us-ascii?q?q803FemRd67VBq9yFaNvQYZc95RFfAqrQ+K16zY6hqYAW5CSSROAPQqvck3S?=
 =?us-ascii?q?DgC2V6Mh97tCCJuu73TUnubs7mOpDW5ODMeKikJbGkZVmMt+d7poKkwgwjJQ?=
 =?us-ascii?q?9IlF7S65vX+GSvx2CyNtCgzwbEel8ka/66g8krAnirqq4WhZhE04gH/XW+/6?=
 =?us-ascii?q?A59Iom/aOSVBfLzhRpbBJySQl/Et38elo3OqusPFpqK0ieKRY0w8HiSz67tG?=
 =?us-ascii?q?FXhbZRHRvHNLwiQxkM=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A36U6nqqqJtmjU1cAdVALLf4aV5oQeYIsim?=
 =?us-ascii?q?QD101hICG9vPb1qynIpoV+6faaslgssR0b8+xofZPwIk80lqQFhLX5Q43CYO?=
 =?us-ascii?q?COggLBR72Kr7GSoQEIcBeQygcy78pdmoFFebrN5CBB7foTJGKDYq8dKB7tyt?=
 =?us-ascii?q?HPudvj?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0A5AAAHbIJi/5BdJa1aHQEBAQEJARI?=
 =?us-ascii?q?BBQUBgXsIAQsBgiqBSz1DjG+IaosXkVCBfAsBAQEPQgQBAYUCAoU+AiU0CQ4?=
 =?us-ascii?q?BAgQBAQESAQEFAQEBAgEHBIEJE4V1hkMGMgE4DhBRITYGARKCfYJkAzGrVoI?=
 =?us-ascii?q?rgQGHJQ1ngWUUgSgBhhWDLoEBhBsnHIFJRIJRgiyCIIhfBF+NIYVzgisDCQY?=
 =?us-ascii?q?HBYE+EoEhcQEIBgYHCgUyBgIMGBQEAhMSTQYMEgITDAoGFg4ONBIZDA8DEgM?=
 =?us-ascii?q?RAQcCCxIIFSwIAwIDCAMCAyMLAgMYCQcKAx0IChwSEBQCBBMfCwgDGh8tCQI?=
 =?us-ascii?q?EDgNDCAsKAxEEAxMYCxYIEAQGAwkvDSgLAwUPDwEGAwYCBQUBAyADFAMFJwc?=
 =?us-ascii?q?DIQcLJg0NBCMdAwMFJgMCAhsHAgIDAgYXBgICGScxCigNCAQIBBgEHiUOBQU?=
 =?us-ascii?q?CBzEFBC8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxY2GQEFXQYLCSMWBiw?=
 =?us-ascii?q?RBQYWAyZSBiIdl2EBdRkBCiUBgVWBHZIUA4MMjRmdP2uDVoFDmEqFYxoxqFe?=
 =?us-ascii?q?WZiCQYJYngWE8gVkzGggbFYMjURkPjiwWjXEBXCQxOwIGCwEBAwmRGgEB?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="1053082338"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 29 Sep 2022 02:33:18 +0000
Received: from zorba.cisco.com ([10.25.129.98])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id 28T2X1Yv007711;
        Thu, 29 Sep 2022 02:33:16 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     xe-linux-external@cisco.com,
        Ruslan Ruslichenko <rruslich@cisco.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] CMDLINE: x86: convert to generic builtin command line
Date:   Wed, 28 Sep 2022 19:32:52 -0700
Message-Id: <20220929023301.3344694-7-danielwa@cisco.com>
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

This updates the x86 code to use the CONFIG_GENERIC_CMDLINE
option.

Cc: xe-linux-external@cisco.com
Signed-off-by: Ruslan Ruslichenko <rruslich@cisco.com>
Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 arch/x86/Kconfig        | 44 +----------------------------------------
 arch/x86/kernel/setup.c | 18 ++---------------
 2 files changed, 3 insertions(+), 59 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..ffcb99531dae 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -134,6 +134,7 @@ config X86
 	select EDAC_SUPPORT
 	select GENERIC_CLOCKEVENTS_BROADCAST	if X86_64 || (X86_32 && X86_LOCAL_APIC)
 	select GENERIC_CLOCKEVENTS_MIN_ADJUST
+	select GENERIC_CMDLINE
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
@@ -2342,49 +2343,6 @@ choice
 
 endchoice
 
-config CMDLINE_BOOL
-	bool "Built-in kernel command line"
-	help
-	  Allow for specifying boot arguments to the kernel at
-	  build time.  On some systems (e.g. embedded ones), it is
-	  necessary or convenient to provide some or all of the
-	  kernel boot arguments with the kernel itself (that is,
-	  to not rely on the boot loader to provide them.)
-
-	  To compile command line arguments into the kernel,
-	  set this option to 'Y', then fill in the
-	  boot arguments in CONFIG_CMDLINE.
-
-	  Systems with fully functional boot loaders (i.e. non-embedded)
-	  should leave this option set to 'N'.
-
-config CMDLINE
-	string "Built-in kernel command string"
-	depends on CMDLINE_BOOL
-	default ""
-	help
-	  Enter arguments here that should be compiled into the kernel
-	  image and used at boot time.  If the boot loader provides a
-	  command line at boot time, it is appended to this string to
-	  form the full kernel command line, when the system boots.
-
-	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
-	  change this behavior.
-
-	  In most cases, the command line (whether built-in or provided
-	  by the boot loader) should specify the device for the root
-	  file system.
-
-config CMDLINE_OVERRIDE
-	bool "Built-in command line overrides boot loader arguments"
-	depends on CMDLINE_BOOL && CMDLINE != ""
-	help
-	  Set this option to 'Y' to have the kernel ignore the boot loader
-	  command line, and use ONLY the built-in command line.
-
-	  This is used to work around broken boot loaders.  This should
-	  be set to 'N' under normal conditions.
-
 config MODIFY_LDT_SYSCALL
 	bool "Enable the LDT (local descriptor table)" if EXPERT
 	default y
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 216fee7144ee..b6944b13a9f9 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -53,6 +53,7 @@
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
 #include <linux/vmalloc.h>
+#include <linux/cmdline.h>
 
 /*
  * max_low_pfn_mapped: highest directly mapped pfn < 4 GB
@@ -167,9 +168,6 @@ unsigned long saved_video_mode;
 #define RAMDISK_LOAD_FLAG		0x4000
 
 static char __initdata command_line[COMMAND_LINE_SIZE];
-#ifdef CONFIG_CMDLINE_BOOL
-static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
-#endif
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 struct edd edd;
@@ -969,19 +967,7 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.start = __pa_symbol(__bss_start);
 	bss_resource.end = __pa_symbol(__bss_stop)-1;
 
-#ifdef CONFIG_CMDLINE_BOOL
-#ifdef CONFIG_CMDLINE_OVERRIDE
-	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-#else
-	if (builtin_cmdline[0]) {
-		/* append boot loader cmdline to builtin */
-		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-	}
-#endif
-#endif
-
+	cmdline_add_builtin(boot_command_line);
 	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
-- 
2.25.1

