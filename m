Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3335F72288E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjFEOPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjFEOPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:15:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5349710FC;
        Mon,  5 Jun 2023 07:14:44 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:14:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QY+lB4deJeNs+5LMljDCM92McOB3G+R8psZsInJgy3M=;
        b=b8iO4zLSH2ChyHWOvlcws68+n3SmqOF36W1Z2lTfJckeyoCXEkkE0GDEkeAdrp2a/0PCcF
        OWJJTURbHR40gitdjJM+EOQq2r/Qb75J6JKA+0lp8OVwDVZNDUpyt7sLrIPKXWGoq/yMCs
        xcUNptNjCVIZuOW2s1MKyXgLopEXI0xEvXHZQHsTUfKVG0Hh1I6nksJwDO2ciJI3ltfbDF
        Wgore1tvWDFLIUHdN9mQq3m9rA9gcwlZxk1EZgTGDxCueIO9HLfhiqi/SkmUeslxhbqFHv
        Ba+D+N9doC/xUQiJWFnPLXkS7XUEEgRerqWHDy1Fwy9sdvLNAOOgq5yrPk+eTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QY+lB4deJeNs+5LMljDCM92McOB3G+R8psZsInJgy3M=;
        b=1yLL548NyiRbbwUdmBKKzB0F+LbDC5U39ABeTTdOjmy6IpUril2K8AXb/FjJfyCF4QfRyl
        WouzzjeWikL78ACg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/amd_nb: Re-sort and re-indent PCI defines
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531094212.GHZHcWdMDkCpAp4daj@fat_crate.local>
References: <20230531094212.GHZHcWdMDkCpAp4daj@fat_crate.local>
MIME-Version: 1.0
Message-ID: <168597448250.404.11782473771242053949.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     f5e87cd5114e9c6d15a12922f26bdd6e24e508ee
Gitweb:        https://git.kernel.org/tip/f5e87cd5114e9c6d15a12922f26bdd6e24e508ee
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 31 May 2023 11:39:57 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jun 2023 12:26:54 +02:00

x86/amd_nb: Re-sort and re-indent PCI defines

Sort them by family, model and type and align them vertically for better
readability.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230531094212.GHZHcWdMDkCpAp4daj@fat_crate.local
---
 arch/x86/kernel/amd_nb.c | 49 +++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 8fd9554..035a3db 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -15,30 +15,31 @@
 #include <linux/pci_ids.h>
 #include <asm/amd_nb.h>
 
-#define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
-#define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
-#define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
-#define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
-#define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT	0x14b5
-#define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
-#define PCI_DEVICE_ID_AMD_19H_M60H_ROOT	0x14d8
-#define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
-#define PCI_DEVICE_ID_AMD_MI200_ROOT	0x14bb
-#define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
-#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
-#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
-#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
-#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
-#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4 0x1728
-#define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
-#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4 0x14b1
-#define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
-#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
-#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
-#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
-#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
-#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4 0x12fc
-#define PCI_DEVICE_ID_AMD_MI200_DF_F4	0x14d4
+#define PCI_DEVICE_ID_AMD_17H_ROOT		0x1450
+#define PCI_DEVICE_ID_AMD_17H_M10H_ROOT		0x15d0
+#define PCI_DEVICE_ID_AMD_17H_M30H_ROOT		0x1480
+#define PCI_DEVICE_ID_AMD_17H_M60H_ROOT		0x1630
+#define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT		0x14b5
+#define PCI_DEVICE_ID_AMD_19H_M10H_ROOT		0x14a4
+#define PCI_DEVICE_ID_AMD_19H_M40H_ROOT		0x14b5
+#define PCI_DEVICE_ID_AMD_19H_M60H_ROOT		0x14d8
+#define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
+#define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
+
+#define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
+#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4	0x15ec
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4	0x1494
+#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4	0x144c
+#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4	0x1444
+#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4	0x1728
+#define PCI_DEVICE_ID_AMD_19H_DF_F4		0x1654
+#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4	0x14b1
+#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4	0x167d
+#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4	0x166e
+#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4	0x14e4
+#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
+#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
+#define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
