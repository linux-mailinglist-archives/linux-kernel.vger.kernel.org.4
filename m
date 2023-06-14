Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0261472F48F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjFNGQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243088AbjFNGQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:16:39 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702B81FC3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:16:38 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgwDM0bMPzBQJYg
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 14:16:35 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686723394; x=1689315395; bh=Er6hCPVj/kJ5dTSSrl1ZSw5zMT9
        ED6VCwDqxHlR2LbI=; b=bz6H1TvZ3SzQwWGK0HkNDqTFke8qqtvNSkaiTE1I3Ep
        BKOdVW2GSQ/L1nxThReizc/QWnbMSUTMB6dsx88YmSWcDtxcRPbsFFTJ4Rgb42+y
        ollCRyHQRGeRJWjwubxCCxpC1u2AGIqad1HTip6m5huF7QJHIOFQjZYnONkZJC5P
        LKbxdk0v1PRyy3bUUjYBDIqJcn4dPfhFIPpW7N7LK8l9R9MbSXn9wQF4FZ0tBaj3
        jr4dvQhip2dV6Suad/rHte2ElMJ1GtmQyPSLazH5v85y83IjOKuwEZGNGd53gYn+
        rNtkNaJw5kL+VNUeVIHjlH4nMx26u75Sm5eZpvmA+yg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Yta3f0qLRN8h for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 14:16:34 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgwDL5P80zBJLB3;
        Wed, 14 Jun 2023 14:16:34 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 14:16:34 +0800
From:   wuyonggang001@208suo.com
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc/kernel: Fix syntax error
In-Reply-To: <20230614061130.64214-1-zhanglibing@cdjrlc.com>
References: <20230614061130.64214-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <5cc396aff142acbc4ba4b2541a5e4d71@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch error:

ERROR: space required before the open parenthesis '('
ERROR: do not initialise statics to 0
ERROR: trailing whitespace

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  arch/sparc/kernel/apc.c | 22 +++++++++++-----------
  1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/kernel/apc.c b/arch/sparc/kernel/apc.c
index ecd05bc0a104..40b9c72ad4d9 100644
--- a/arch/sparc/kernel/apc.c
+++ b/arch/sparc/kernel/apc.c
@@ -24,7 +24,7 @@
  #include <asm/processor.h>

  /* Debugging
- *
+ *
   * #define APC_DEBUG_LED
   */

@@ -33,20 +33,20 @@
  #define APC_DEVNAME "apc"

  static u8 __iomem *regs;
-static int apc_no_idle = 0;
+static int apc_no_idle;

  #define apc_readb(offs)        (sbus_readb(regs+offs))
  #define apc_writeb(val, offs)     (sbus_writeb(val, regs+offs))

-/* Specify "apc=noidle" on the kernel command line to
+/* Specify "apc=noidle" on the kernel command line to
   * disable APC CPU standby support.  Certain prototype
   * systems (SPARCstation-Fox) do not play well with APC
- * CPU idle, so disable this if your system has APC and
+ * CPU idle, so disable this if your system has APC and
   * crashes randomly.
   */
-static int __init apc_setup(char *str)
+static int __init apc_setup(char *str)
  {
-    if(!strncmp(str, "noidle", strlen("noidle"))) {
+    if (!strncmp(str, "noidle", strlen("noidle"))) {
          apc_no_idle = 1;
          return 1;
      }
@@ -54,22 +54,22 @@ static int __init apc_setup(char *str)
  }
  __setup("apc=", apc_setup);

-/*
+/*
   * CPU idle callback function
   * See .../arch/sparc/kernel/process.c
   */
  static void apc_swift_idle(void)
  {
  #ifdef APC_DEBUG_LED
-    set_auxio(0x00, AUXIO_LED);
+    set_auxio(0x00, AUXIO_LED);
  #endif

      apc_writeb(apc_readb(APC_IDLE_REG) | APC_IDLE_ON, APC_IDLE_REG);

  #ifdef APC_DEBUG_LED
-    set_auxio(AUXIO_LED, 0x00);
+    set_auxio(AUXIO_LED, 0x00);
  #endif
-}
+}

  static inline void apc_free(struct platform_device *op)
  {
@@ -162,7 +162,7 @@ static int apc_probe(struct platform_device *op)
      if (!apc_no_idle)
          sparc_idle = apc_swift_idle;

-    printk(KERN_INFO "%s: power management initialized%s\n",
+    pr_info("%s: power management initialized%s\n",
             APC_DEVNAME, apc_no_idle ? " (CPU idle disabled)" : "");

      return 0;
