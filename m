Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7026C57A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjCVUa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjCVUaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:30:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8359BE02;
        Wed, 22 Mar 2023 13:21:21 -0700 (PDT)
Date:   Wed, 22 Mar 2023 20:14:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679516094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SirrcNGjJd8qTjAXCDvK74Q1/5ugn2H17xCJeG7U+EU=;
        b=EK2bXwKIuBrIFIyiuVsD4FsEkC7iw4wDCVqXwscPPG8E88RmrBzl2PAQKm+0J99EPF2qBO
        Ktnl/A1wNR0OgRh7RDHZL58+xkrgRfoDSgvOJB0BTk7gYMBzq6BsqsyVC1QzGcbrS26u4G
        lmv57IeQcieLRbDkI8+LGKBwPcurE+47ayvli/cfHrjxVcezQI7LydFYAZdFZOZ/XITDWy
        6QWvlzkz0ECdysMmIJXUSAoGyC5UYv0ImikCU+puVLjVVink3YLkcSZFKwlgv979k2K/3+
        NyLakfyYbC5I7faC/vpWTA6pNv7wIjMD/GXpAP/0jxrkFqZIJtZav8PeLf220g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679516094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SirrcNGjJd8qTjAXCDvK74Q1/5ugn2H17xCJeG7U+EU=;
        b=gEyJXRudKj3AaKqfgECyCtxD2sdhOQemQhQHrOP2E1zqtDjEnW2HJcAV+vq20IxQKVLoWQ
        C9Pxf6yTjobGFEDA==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] Documentation/x86: Add the AMX enabling example
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thiago Macieira <thiago.macieira@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167951609373.5837.2925763899751490246.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     7f9daaf59e14d62b29b6f4ca743e17bf96ff42ae
Gitweb:        https://git.kernel.org/tip/7f9daaf59e14d62b29b6f4ca743e17bf96ff42ae
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Fri, 20 Jan 2023 16:18:59 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 22 Mar 2023 13:07:58 -07:00

Documentation/x86: Add the AMX enabling example

Explain steps to enable the dynamic feature with a code example.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thiago Macieira <thiago.macieira@intel.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/all/20230121001900.14900-4-chang.seok.bae%40intel.com
---
 Documentation/x86/xstate.rst | 55 +++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+)

diff --git a/Documentation/x86/xstate.rst b/Documentation/x86/xstate.rst
index e954e79..23b1c9f 100644
--- a/Documentation/x86/xstate.rst
+++ b/Documentation/x86/xstate.rst
@@ -80,6 +80,61 @@ the handler allocates a larger xstate buffer for the task so the large
 state can be context switched. In the unlikely cases that the allocation
 fails, the kernel sends SIGSEGV.
 
+AMX TILE_DATA enabling example
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Below is the example of how userspace applications enable
+TILE_DATA dynamically:
+
+  1. The application first needs to query the kernel for AMX
+     support::
+
+        #include <asm/prctl.h>
+        #include <sys/syscall.h>
+        #include <stdio.h>
+        #include <unistd.h>
+
+        #ifndef ARCH_GET_XCOMP_SUPP
+        #define ARCH_GET_XCOMP_SUPP  0x1021
+        #endif
+
+        #ifndef ARCH_XCOMP_TILECFG
+        #define ARCH_XCOMP_TILECFG   17
+        #endif
+
+        #ifndef ARCH_XCOMP_TILEDATA
+        #define ARCH_XCOMP_TILEDATA  18
+        #endif
+
+        #define MASK_XCOMP_TILE      ((1 << ARCH_XCOMP_TILECFG) | \
+                                      (1 << ARCH_XCOMP_TILEDATA))
+
+        unsigned long features;
+        long rc;
+
+        ...
+
+        rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
+
+        if (!rc && (features & MASK_XCOMP_TILE) == MASK_XCOMP_TILE)
+            printf("AMX is available.\n");
+
+  2. After that, determining support for AMX, an application must
+     explicitly ask permission to use it::
+
+        #ifndef ARCH_REQ_XCOMP_PERM
+        #define ARCH_REQ_XCOMP_PERM  0x1023
+        #endif
+
+        ...
+
+        rc = syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_PERM, ARCH_XCOMP_TILEDATA);
+
+        if (!rc)
+            printf("AMX is ready for use.\n");
+
+Note this example does not include the sigaltstack preparation.
+
 Dynamic features in signal frames
 ---------------------------------
 
