Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14B85EEBCF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiI2Cdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiI2Cdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:33:35 -0400
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAAD12578D;
        Wed, 28 Sep 2022 19:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3756; q=dns/txt; s=iport;
  t=1664418802; x=1665628402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EeUjxXFbugP3qHuk1z9NW487+/6qlq6LEqrRKZ1wXAE=;
  b=CxYGkNDaqilR/DpV1aCmwx1utehJhZjM/lYc6p0qVXwhrrSGV8NpWS+N
   bflUAilGp8ANPrfX1G7ZSYmI9S8OTLox5Wvz5OeyINL2sKGV443mlsbSA
   sA+kTwo6xAlfXcj/DfyxLDMgFgPw6+CReMZSACAxtnBIC+S4aEWOHKy0Q
   U=;
IronPort-Data: =?us-ascii?q?A9a23=3ACSrt26vXt9CBrWrUOKwqPl8PG+fnVFtfMUV32?=
 =?us-ascii?q?f8akzHdYApBsoF/qtZmKWqGOqnfMzb2fNwlaY+29UtV75Tcx9NlSAA+q39kE?=
 =?us-ascii?q?S9AgMeUXt7xwmUckM+xwmwvdK/shiknQoGowPscEzmN/39BDpC79SMmjfzRG?=
 =?us-ascii?q?OKlYAL5EnkZqTFMGX9JZS1Lw4bVsqYw6TSIK1vlVeHa+qUzC3f9s9JACV/43?=
 =?us-ascii?q?orYwP9ZUFsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRp?=
 =?us-ascii?q?gs1/j83Ad+j1738aEBPEvjZPBOFjTxdXK3Kbhpq/3NplP1kcqtHLx4L111ln?=
 =?us-ascii?q?PgpoDlJnZC5TwYkOrLFsO8cSBJfVSp5OMWq/ZeeeSbv7JHNkRCXG5fr67A0Z?=
 =?us-ascii?q?K0sBqUc++BqESRN+OYeJTQlcB+OnaS1zai9R+0qgd4sROHnMZ0esXx81zzUJ?=
 =?us-ascii?q?egpTIqFQKjQ49JcmjAqiahmE+zZeMMfZXxrbQ/cSxJKM1YTTpk5mY+AnH71c?=
 =?us-ascii?q?35UtHqWqLAx7myVyxZ+uJD2PdPTPNWMSchPhUGejnnL9GO/CRYfXPSWyiKA2?=
 =?us-ascii?q?natgPLf2C38RYQeHaG58fgsh0ecrkQfARsXWF+Trvi8kkO6VsxeIExS4SMo6?=
 =?us-ascii?q?KYo/UqgT8L2WFuzqTiZpXY0Qd1aE8U55RuLx66S5ByWbkAPTiRAc8AhrM87A?=
 =?us-ascii?q?zgnzFiYt9jyCiZoraXTRG/13qiVqTeaOiUPK2IGIygeQmM4D3PLyG0opgjEQ?=
 =?us-ascii?q?tAmG6mvg5ilXzrx2DuN6iM5gt0uYQcw//3T1Tj6b/iE//AlljII2zg=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ACnEnaq3wfzDCmCd5Rp2FcwqjBIkkLtp133?=
 =?us-ascii?q?Aq2lEZdPWaSKClfqeV7ZAmPHDP5gr5NEtLpTnEAtjifZq+z+8R3WBuB9aftW?=
 =?us-ascii?q?Dd0QPCEGgh1/qB/9SKIULDH4BmuJuIWpIOb+EYdWIbsS4/izPIaurJB7K8gc?=
 =?us-ascii?q?aVuds=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0A5AAB2bIJi/5BdJa1aHQEBAQEJARI?=
 =?us-ascii?q?BBQUBgXsIAQsBgiqBSz1DjG+IapxnFIFoCwEBAQ9CBAEBhQIChT4CJTQJDgE?=
 =?us-ascii?q?CBAEBARIBAQUBAQECAQcEgQkThXWGQwYyAUYQHTRJDgYBEoJ9gxirVoIrgQG?=
 =?us-ascii?q?IGYFlFIEoAYlDhRwnHIFJRIEVgTyCLIQqhlUEk3OCKwMJBgcFgT4SgSFxAQg?=
 =?us-ascii?q?GBgcKBTIGAgwYFAQCExJNBgwSAhMMCgYWDg40EhkMDwMSAxEBBwILEggVLAg?=
 =?us-ascii?q?DAgMIAwIDIwsCAxgJBwoDHQgKHBIQFAIEEx8LCAMaHy0JAgQOA0MICwoDEQQ?=
 =?us-ascii?q?DExgLFggQBAYDCS8NKAsDBQ8PAQYDBgIFBQEDIAMUAwUnBwMhBwsmDQ0EIx0?=
 =?us-ascii?q?DAwUmAwICGwcCAgMCBhcGAgIZJzEKKA0IBAgEGAQeJQ4FBQIHMQUELwIeBAU?=
 =?us-ascii?q?GEQkCFgIGBAUCBAQWAgISCAIIJxsHFjYZAQVdBgsJIxYGLBEFBhYDJlIGIh2?=
 =?us-ascii?q?XWwYBgQ+BCIEgEpJ/kCWeKoNWgUOeLRoxqFeWZiCnB4FhPIFZMxoIGxWDI1E?=
 =?us-ascii?q?ZD5wzAVwkMTsCBgsBAQMJkRoBAQ?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="1068556659"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 29 Sep 2022 02:33:20 +0000
Received: from zorba.cisco.com ([10.25.129.98])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id 28T2X1Yw007711;
        Thu, 29 Sep 2022 02:33:19 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     xe-linux-external@cisco.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] of: replace command line handling
Date:   Wed, 28 Sep 2022 19:32:53 -0700
Message-Id: <20220929023301.3344694-8-danielwa@cisco.com>
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
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring has complained about this section of code. I removed the
command line handling code to the cmdline.h header. This hopefully makes
it easier for Rob to maintain it (at least he doesn't have to look at it
directly anymore). I would like to add a Kconfig option called
OF_DEPRECATED_CMDLINE which an architecture would set if it uses this code.
This would allow a platform to use the cmdline.h and the added function
directly and remove the Kconfig option. This change would be in a subsequent
patch.

This code was boot tested on powerpc 32bit, powerpc 64bit without
any generic command line conversion.

Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 drivers/of/fdt.c        | 22 ++--------------------
 include/linux/cmdline.h | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 1c573e7a60bc..94e8fa277857 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -27,6 +27,7 @@
 #include <linux/sysfs.h>
 #include <linux/random.h>
 #include <linux/kmemleak.h>
+#include <linux/cmdline.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1177,26 +1178,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 
 	/* Retrieve command line */
 	p = of_get_flat_dt_prop(node, "bootargs", &l);
-	if (p != NULL && l > 0)
-		strlcpy(cmdline, p, min(l, COMMAND_LINE_SIZE));
-
-	/*
-	 * CONFIG_CMDLINE is meant to be a default in case nothing else
-	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
-	 * is set in which case we override whatever was found earlier.
-	 */
-#ifdef CONFIG_CMDLINE
-#if defined(CONFIG_CMDLINE_EXTEND)
-	strlcat(cmdline, " ", COMMAND_LINE_SIZE);
-	strlcat(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#elif defined(CONFIG_CMDLINE_FORCE)
-	strlcpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#else
-	/* No arguments from boot loader, use kernel's  cmdl*/
-	if (!((char *)cmdline)[0])
-		strlcpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#endif
-#endif /* CONFIG_CMDLINE */
+	of_deprecated_cmdline_update(cmdline, p, l);
 
 	pr_debug("Command line is: %s\n", (char *)cmdline);
 
diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
index a94758a0f257..dc7793265aa3 100644
--- a/include/linux/cmdline.h
+++ b/include/linux/cmdline.h
@@ -103,4 +103,35 @@ __cmdline_add_builtin(
 
 #define cmdline_get_static_builtin(dest) \
 	(CMDLINE_STATIC_PREPEND CMDLINE_STATIC_APPEND)
-#endif
+
+#ifndef CONFIG_GENERIC_CMDLINE
+static inline bool of_deprecated_cmdline_update(char *cmdline, const char *dt_bootargs, int length)
+{
+	if (dt_bootargs != NULL && length > 0)
+		strlcpy(cmdline, dt_bootargs, min(length, COMMAND_LINE_SIZE));
+	/*
+	 * CONFIG_CMDLINE is meant to be a default in case nothing else
+	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
+	 * is set in which case we override whatever was found earlier.
+	 */
+#ifdef CONFIG_CMDLINE
+#if defined(CONFIG_CMDLINE_EXTEND)
+	strlcat(cmdline, " ", COMMAND_LINE_SIZE);
+	strlcat(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#elif defined(CONFIG_CMDLINE_FORCE)
+	strlcpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#else
+	/* No arguments from boot loader, use kernel's  cmdl*/
+	if (!((char *)cmdline)[0])
+		strlcpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#endif /* CONFIG_CMDLINE_EXTEND */
+#endif /* CONFIG_CMDLINE */
+
+	return true;
+}
+#else
+static inline bool of_deprecated_cmdline_update(char *cmdline, const char *dt_bootargs, int length) { return false; }
+#endif /* CONFIG_GENERIC_CMDLINE */
+
+
+#endif /* _LINUX_CMDLINE_H */
-- 
2.25.1

