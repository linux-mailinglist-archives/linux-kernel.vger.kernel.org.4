Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D446CC003
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjC1M7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjC1M7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:59:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E10358E;
        Tue, 28 Mar 2023 05:59:28 -0700 (PDT)
Date:   Tue, 28 Mar 2023 12:59:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680008366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xY7Gu0X7NFSrJJ2PYPZHUedWk+GWBVWLgCO0JJisAuI=;
        b=f7qD0NfHuZNAFdUH+Swja5PJ/pb0TxFykGsqCuhbz4dWfFC/di69DUW35g2/LA0BpFuNOc
        9ydBOHP9iR8M59mnABnqbVcqrOiKqajBVVx+FceXw/BE5D6OowfxC3psjn+Z5Kc3Fr0uSH
        DUsNIuAo2Tx4c/QhSjHRlKbPLicd9X1cCEv5f2rMaPZR5siu7+lzBjDpx0a3rkrGGy+4pO
        PlcItfqtM1xDRTp5+EErMNM2ySngp0acprZ9OmyA4ZEh/6DLuPpmAhj7bl+siqIIN/9dse
        fE2gupsFVLVerAbbecxj8cf41ct1ptbRvEax0wrwYLBg9HS1/fjHlVpA3LnwZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680008366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xY7Gu0X7NFSrJJ2PYPZHUedWk+GWBVWLgCO0JJisAuI=;
        b=4Rnswf+XShKl2yNCCdSop5QvT/OHVi/7vA0wUMJXYY9xMbKIKxnypmKTkW2IasOpw0uZ8d
        wUm5hRKc38psWoDA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/coco: Export cc_vendor
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230318115634.9392-2-bp@alien8.de>
References: <20230318115634.9392-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168000836538.5837.8228160837944505902.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     5ae57743f578725a5dadb6f31d7798ee55e6e967
Gitweb:        https://git.kernel.org/tip/5ae57743f578725a5dadb6f31d7798ee55e6e967
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 18 Mar 2023 12:56:33 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 28 Mar 2023 14:52:51 +02:00

x86/coco: Export cc_vendor

It will be used in different checks in future changes. Export it
directly and drop the setter as it is a __ro_after_init variable anyway.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230318115634.9392-2-bp@alien8.de
---
 arch/x86/coco/core.c               | 13 ++++---------
 arch/x86/coco/tdx/tdx.c            |  2 +-
 arch/x86/hyperv/ivm.c              |  2 +-
 arch/x86/include/asm/coco.h        |  2 +-
 arch/x86/mm/mem_encrypt_identity.c |  2 +-
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index f4f0625..73f8323 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -13,7 +13,7 @@
 #include <asm/coco.h>
 #include <asm/processor.h>
 
-static enum cc_vendor vendor __ro_after_init;
+enum cc_vendor cc_vendor __ro_after_init;
 static u64 cc_mask __ro_after_init;
 
 static bool intel_cc_platform_has(enum cc_attr attr)
@@ -99,7 +99,7 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 
 bool cc_platform_has(enum cc_attr attr)
 {
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return amd_cc_platform_has(attr);
 	case CC_VENDOR_INTEL:
@@ -119,7 +119,7 @@ u64 cc_mkenc(u64 val)
 	 * - for AMD, bit *set* means the page is encrypted
 	 * - for AMD with vTOM and for Intel, *clear* means encrypted
 	 */
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		if (sev_status & MSR_AMD64_SNP_VTOM)
 			return val & ~cc_mask;
@@ -135,7 +135,7 @@ u64 cc_mkenc(u64 val)
 u64 cc_mkdec(u64 val)
 {
 	/* See comment in cc_mkenc() */
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		if (sev_status & MSR_AMD64_SNP_VTOM)
 			return val | cc_mask;
@@ -149,11 +149,6 @@ u64 cc_mkdec(u64 val)
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
 
-__init void cc_set_vendor(enum cc_vendor v)
-{
-	vendor = v;
-}
-
 __init void cc_set_mask(u64 mask)
 {
 	cc_mask = mask;
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 055300e..bab29cb 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -852,7 +852,7 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
-	cc_set_vendor(CC_VENDOR_INTEL);
+	cc_vendor = CC_VENDOR_INTEL;
 	tdx_parse_tdinfo(&cc_mask);
 	cc_set_mask(cc_mask);
 
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index f6a020c..4395d2f 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -364,7 +364,7 @@ void __init hv_vtom_init(void)
 	 * Set it here to indicate a vTOM VM.
 	 */
 	sev_status = MSR_AMD64_SNP_VTOM;
-	cc_set_vendor(CC_VENDOR_AMD);
+	cc_vendor = CC_VENDOR_AMD;
 	cc_set_mask(ms_hyperv.shared_gpa_boundary);
 	physical_mask &= ms_hyperv.shared_gpa_boundary - 1;
 
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index d2c6a2e..61fc7c1 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -10,7 +10,7 @@ enum cc_vendor {
 	CC_VENDOR_INTEL,
 };
 
-void cc_set_vendor(enum cc_vendor v);
+extern enum cc_vendor cc_vendor;
 void cc_set_mask(u64 mask);
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index c6efcf5..bfe22fd 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -612,7 +612,7 @@ void __init sme_enable(struct boot_params *bp)
 out:
 	if (sme_me_mask) {
 		physical_mask &= ~sme_me_mask;
-		cc_set_vendor(CC_VENDOR_AMD);
+		cc_vendor = CC_VENDOR_AMD;
 		cc_set_mask(sme_me_mask);
 	}
 }
