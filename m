Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B8968BD69
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBFNAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjBFNAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:00:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F3F1CF4C;
        Mon,  6 Feb 2023 05:00:09 -0800 (PST)
Date:   Mon, 06 Feb 2023 13:00:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675688406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZprBstTOqPQNUVzH8lKuarOk5l5ZxWynbUDWcTHiQWE=;
        b=02XWstYU7ysw5dx7YOkUqIOhHcdVWfkpEmPC4ylncPR/sYVr5ky6lf/nMwDYZh5EGeCZcJ
        t9pLNz2cVgb3vNEn2XVcAjnzg4SquXSuGdHIc48Yi8bDoU1i5SgAE0osDskTfy3sCOOrOz
        Bac6OSE5+LSyRurQxzV0j2MDf7FnVcHPNrGKevMlE+wzejqN1QGuQ0oz6jZDuhSUm2pLs1
        DxYUj99FNeypdUfloIkjncZzeulfLx/xPlnC42wPFV2lbMRzJkU2bIB4cTCGes5LAglxF8
        Lig4324aGyQTiFDg8LwJ6r7BdgJvWTSSPyanHeKhU0lwkUpLW7Zm5bgllFzOeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675688406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZprBstTOqPQNUVzH8lKuarOk5l5ZxWynbUDWcTHiQWE=;
        b=y5HhsgMifpJvzL6VsnUjGnzIqI0faKoWRZzLnJRkXfLwOpG9mdSi8yKPhq9kEJjJ2gtimX
        wU3411zPwlPXLABA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Add a @cpu parameter to the
 reloading functions
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230130161709.11615-3-bp@alien8.de>
References: <20230130161709.11615-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167568840608.4906.12424480215139026797.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     a5ad92134bd153a9ccdcddf09a95b088f36c3cce
Gitweb:        https://git.kernel.org/tip/a5ad92134bd153a9ccdcddf09a95b088f36c3cce
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 26 Jan 2023 00:08:03 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 06 Feb 2023 12:14:20 +01:00

x86/microcode/AMD: Add a @cpu parameter to the reloading functions

Will be used in a subsequent change.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230130161709.11615-3-bp@alien8.de
---
 arch/x86/include/asm/microcode.h     | 4 ++--
 arch/x86/include/asm/microcode_amd.h | 4 ++--
 arch/x86/kernel/cpu/microcode/amd.c  | 2 +-
 arch/x86/kernel/cpu/microcode/core.c | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index d5a58bd..320566a 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -125,13 +125,13 @@ static inline unsigned int x86_cpuid_family(void)
 #ifdef CONFIG_MICROCODE
 extern void __init load_ucode_bsp(void);
 extern void load_ucode_ap(void);
-void reload_early_microcode(void);
+void reload_early_microcode(unsigned int cpu);
 extern bool initrd_gone;
 void microcode_bsp_resume(void);
 #else
 static inline void __init load_ucode_bsp(void)			{ }
 static inline void load_ucode_ap(void)				{ }
-static inline void reload_early_microcode(void)			{ }
+static inline void reload_early_microcode(unsigned int cpu)	{ }
 static inline void microcode_bsp_resume(void)			{ }
 #endif
 
diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index ac31f91..e6662ad 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -47,12 +47,12 @@ struct microcode_amd {
 extern void __init load_ucode_amd_bsp(unsigned int family);
 extern void load_ucode_amd_ap(unsigned int family);
 extern int __init save_microcode_in_initrd_amd(unsigned int family);
-void reload_ucode_amd(void);
+void reload_ucode_amd(unsigned int cpu);
 #else
 static inline void __init load_ucode_amd_bsp(unsigned int family) {}
 static inline void load_ucode_amd_ap(unsigned int family) {}
 static inline int __init
 save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
-static inline void reload_ucode_amd(void) {}
+static inline void reload_ucode_amd(unsigned int cpu) {}
 #endif
 #endif /* _ASM_X86_MICROCODE_AMD_H */
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index c2ac6c4..1023be6 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -578,7 +578,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 	return 0;
 }
 
-void reload_ucode_amd(void)
+void reload_ucode_amd(unsigned int cpu)
 {
 	struct microcode_amd *mc;
 	u32 rev, dummy __always_unused;
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index fdd1e7e..ddc0958 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -298,7 +298,7 @@ struct cpio_data find_microcode_in_initrd(const char *path, bool use_pa)
 #endif
 }
 
-void reload_early_microcode(void)
+void reload_early_microcode(unsigned int cpu)
 {
 	int vendor, family;
 
@@ -312,7 +312,7 @@ void reload_early_microcode(void)
 		break;
 	case X86_VENDOR_AMD:
 		if (family >= 0x10)
-			reload_ucode_amd();
+			reload_ucode_amd(cpu);
 		break;
 	default:
 		break;
@@ -564,7 +564,7 @@ void microcode_bsp_resume(void)
 	if (uci->mc)
 		microcode_ops->apply_microcode(cpu);
 	else
-		reload_early_microcode();
+		reload_early_microcode(cpu);
 }
 
 static struct syscore_ops mc_syscore_ops = {
