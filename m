Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F9B722891
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjFEOPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjFEOPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:15:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1A110FE;
        Mon,  5 Jun 2023 07:14:46 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:14:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQZ6SRS5x8bgPaqEeeWHjdO1EFJS0M297BAy1c6J36E=;
        b=TAJfWksWDLN7gyAyT5zplUa7zgQily/Y8S82bIkUX34c50wFl5OhdNhKXM48BL1Gbpzo1p
        Bght8o+8YVRzwYLB3VsnS79Veqg39OAqUThszaSGH5KhAjjMmzZL686yyMyG1bAALhikm6
        UFFaaWahFqH+Aml07pzk+EoGeVg6Rh184081pzmxxLdST4pR4ykvpTnrd2XdAy+bFKiKmR
        IrbMb3VsJgyOd0K1lkLDp3Y7sNlYLaHdyZoQ2QGy5GeKEKKpARO0naWYcILNPqz1pFOGJK
        2oNHmQX0eG1eoF3nK6pxb2GXgwzB7hkoap9+gRyf/IIqq19bQyj5Uox5YihSWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQZ6SRS5x8bgPaqEeeWHjdO1EFJS0M297BAy1c6J36E=;
        b=FdHWD5HRyBRAm46cQ3jQ1Host2ppinrYdXIivLzUnmt9pgXCJWRjntVhRh0OZEVANhCVp3
        OGk5ZMT5T3c9N4Dg==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/amd_nb: Add MI200 PCI IDs
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515113537.1052146-2-muralimk@amd.com>
References: <20230515113537.1052146-2-muralimk@amd.com>
MIME-Version: 1.0
Message-ID: <168597448285.404.12187039044997383031.tip-bot2@tip-bot2>
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

Commit-ID:     e15885689cf4bc92356e52ea6ef38379a749819a
Gitweb:        https://git.kernel.org/tip/e15885689cf4bc92356e52ea6ef38379a749819a
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 15 May 2023 11:35:33 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jun 2023 12:26:37 +02:00

x86/amd_nb: Add MI200 PCI IDs

The AMD MI200 series accelerators are data center GPUs. They include
unified memory controllers and a data fabric similar to those used in
AMD x86 CPU products. The memory controllers report errors using MCA,
though these errors are generally handled through GPU drivers that
directly manage the accelerator device.

In some configurations, memory errors from these devices will be
reported through MCA and managed by x86 CPUs. The OS is expected to
handle these errors in similar fashion to MCA errors originating from
memory controllers on the CPUs. In Linux, this flow includes passing MCA
errors to a notifier chain with handlers in the EDAC subsystem.

The AMD64 EDAC module requires information from the memory controllers
and data fabric in order to provide detailed decoding of memory errors.
The information is read from hardware registers accessed through
interfaces in the data fabric.

The accelerator data fabrics are visible to the host x86 CPUs as PCI
devices just like x86 CPU data fabrics are already. However, the
accelerator fabrics have new and unique PCI IDs.

Add PCI IDs for the MI200 series of accelerator devices in order to
enable EDAC support. The data fabrics of the accelerator devices will be
enumerated as any other fabric already supported.  System-specific
implementation details will be handled within the AMD64 EDAC module.

  [ bp: Scrub off marketing speak. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Co-developed-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230515113537.1052146-2-muralimk@amd.com
---
 arch/x86/kernel/amd_nb.c | 5 +++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 7e331e8..8fd9554 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -23,6 +23,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
 #define PCI_DEVICE_ID_AMD_19H_M60H_ROOT	0x14d8
 #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
+#define PCI_DEVICE_ID_AMD_MI200_ROOT	0x14bb
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
@@ -37,6 +38,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4 0x12fc
+#define PCI_DEVICE_ID_AMD_MI200_DF_F4	0x14d4
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -53,6 +55,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
 	{}
 };
 
@@ -81,6 +84,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
 	{}
 };
 
@@ -101,6 +105,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
 	{}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 95f33da..a99b1fc 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -568,6 +568,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
+#define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
