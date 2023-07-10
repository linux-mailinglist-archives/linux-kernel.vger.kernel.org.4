Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CA574CFAD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjGJIPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjGJIOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:14:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D2C106;
        Mon, 10 Jul 2023 01:14:00 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:13:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688976838;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XdyazlaR2vkeRMooQSXhSLbL72/JIV9G5hPYgdB8Xxo=;
        b=ESLdYvVqX3qf0VuJmZYG/+WWs3g+Zq6ECI2+51mmYeA/C3HQ/IsfM73u03Z/NbRCrdI7v5
        YU+pjY0FWmjksKPRmznLLfgQPan4yjHqCGZTMHN1nNvTtj0cYSyyBURZAYQVjYZXhh+lBm
        H9KFUrrcwvJaBNhpaYJmBAWkezzr5a7cHURXUaSI6CiYgtY5p61QSTt4mAQLJiKGlOxp0A
        GXobPzJ98mpe64X8tDq88UMvnrP9EqUu/098DFvdl1YbASIh1uozTtXlGXZJrMKL4djDTM
        iML3bMXOpjSF+L12dk5FxWCGIyoLVYh7PnfaQ4Jhm+tDbPPAjMB2iaeiigTAUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688976838;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XdyazlaR2vkeRMooQSXhSLbL72/JIV9G5hPYgdB8Xxo=;
        b=2yAXpxS47/Y9AItOvG830z7uXQD8OiX5judgbtO10elNNyR1gzPBPwnJjszNBwYOYOve4H
        B3n0K7alH6s11WAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/alternative: Rename apply_ibt_endbr()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168897683815.404.9610507600520458133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     be0fffa5ca894a971a31c5e28aa77b633a97d1dc
Gitweb:        https://git.kernel.org/tip/be0fffa5ca894a971a31c5e28aa77b633a97d1dc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 22 Jun 2023 15:36:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:23 +02:00

x86/alternative: Rename apply_ibt_endbr()

The current name doesn't reflect what it does very well.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lkml.kernel.org/r/20230622144321.427441595%40infradead.org
---
 arch/um/kernel/um_arch.c           |  2 +-
 arch/x86/include/asm/alternative.h |  2 +-
 arch/x86/include/asm/ibt.h         |  2 +-
 arch/x86/kernel/alternative.c      |  9 ++++++---
 arch/x86/kernel/module.c           |  2 +-
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 918fed7..b1bfed0 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -437,7 +437,7 @@ void __init arch_cpu_finalize_init(void)
 	os_check_bugs();
 }
 
-void apply_ibt_endbr(s32 *start, s32 *end)
+void apply_seal_endbr(s32 *start, s32 *end)
 {
 }
 
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 6c15a62..9c4da69 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -96,7 +96,7 @@ extern void alternative_instructions(void);
 extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 extern void apply_retpolines(s32 *start, s32 *end);
 extern void apply_returns(s32 *start, s32 *end);
-extern void apply_ibt_endbr(s32 *start, s32 *end);
+extern void apply_seal_endbr(s32 *start, s32 *end);
 extern void apply_fineibt(s32 *start_retpoline, s32 *end_retpoine,
 			  s32 *start_cfi, s32 *end_cfi);
 
diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index baae6b4..1e59581 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -34,7 +34,7 @@
 /*
  * Create a dummy function pointer reference to prevent objtool from marking
  * the function as needing to be "sealed" (i.e. ENDBR converted to NOP by
- * apply_ibt_endbr()).
+ * apply_seal_endbr()).
  */
 #define IBT_NOSEAL(fname)				\
 	".pushsection .discard.ibt_endbr_noseal\n\t"	\
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 72646d7..27e0cb4 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -803,7 +803,7 @@ static void __init_or_module poison_endbr(void *addr, bool warn)
 /*
  * Generated by: objtool --ibt
  */
-void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
+void __init_or_module noinline apply_seal_endbr(s32 *start, s32 *end)
 {
 	s32 *s;
 
@@ -818,7 +818,7 @@ void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
 
 #else
 
-void __init_or_module apply_ibt_endbr(s32 *start, s32 *end) { }
+void __init_or_module apply_seal_endbr(s32 *start, s32 *end) { }
 
 #endif /* CONFIG_X86_KERNEL_IBT */
 
@@ -1565,7 +1565,10 @@ void __init alternative_instructions(void)
 	 */
 	callthunks_patch_builtin_calls();
 
-	apply_ibt_endbr(__ibt_endbr_seal, __ibt_endbr_seal_end);
+	/*
+	 * Seal all functions that do not have their address taken.
+	 */
+	apply_seal_endbr(__ibt_endbr_seal, __ibt_endbr_seal_end);
 
 #ifdef CONFIG_SMP
 	/* Patch to UP if other cpus not imminent. */
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index b05f62e..5f71a0c 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -358,7 +358,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 	}
 	if (ibt_endbr) {
 		void *iseg = (void *)ibt_endbr->sh_addr;
-		apply_ibt_endbr(iseg, iseg + ibt_endbr->sh_size);
+		apply_seal_endbr(iseg, iseg + ibt_endbr->sh_size);
 	}
 	if (locks) {
 		void *lseg = (void *)locks->sh_addr;
