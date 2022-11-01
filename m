Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C951F6155B2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKAXEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiKAXEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:04:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238A43886;
        Tue,  1 Nov 2022 16:04:10 -0700 (PDT)
Date:   Tue, 01 Nov 2022 23:04:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667343848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=haHb+S1YE/NtEqaCmNcfdopQbJW7AGZVbvkBSrqABjU=;
        b=Yuh+RzxvwhSfl57vnAKM/EKxxzAye62eKk7o/YYWQn5X94haIDnYCDjt0HWX5b5v2O3EKQ
        0TIRI+or1mxUtn8ibAsyJ/m4k+FnB1ognQU+pOsP0Wxe4FL/1h6DVYsB3N6LpUOgwddHd4
        KUjpcsrkzH6ly8ljbjrxsvpX4u4JOTn5lfzDxJHMbo+KgyqUbdGY1zpa/lCWqNXaj1qmAg
        Q6BnF2sKwk8LyuLy2De26N5DU2hGEjxwa45ECwh6/2pNk53FzFKA9QX4QWeQx68FV0xSxs
        4FjPnhqgUpP1H9r6lgNlO9qVmjoZhPRNrocZJEXNM1XgROha12gxs52Eji+H0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667343848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=haHb+S1YE/NtEqaCmNcfdopQbJW7AGZVbvkBSrqABjU=;
        b=myvp3ejDzn7ImE7RVCQWhxGkCT9vS3FG9mKlFV9XvpWunbIiPGFI9uXBduEYawir8RgDpd
        kAJIK/P3CMTVCjAA==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Improve formatting of user_regset arrays
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166734384759.7716.16719897430836500626.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     0ba5df84d06363b6112d8c5e538582e557b41ad2
Gitweb:        https://git.kernel.org/tip/0ba5df84d06363b6112d8c5e538582e557b41ad2
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Fri, 21 Oct 2022 15:18:03 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 01 Nov 2022 15:36:52 -07:00

x86: Improve formatting of user_regset arrays

Back in 2018, Ingo Molnar suggested[0] to improve the formatting of the
struct user_regset arrays. They have multiple member initializations per
line and some lines exceed 100 chars. Reformat them like he suggested.

[0] https://lore.kernel.org/lkml/20180711102035.GB8574@gmail.com/

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20221021221803.10910-3-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/ptrace.c | 107 +++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 356495a..dfaa270 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1235,28 +1235,37 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 static struct user_regset x86_64_regsets[] __ro_after_init = {
 	[REGSET64_GENERAL] = {
-		.core_note_type = NT_PRSTATUS,
-		.n = sizeof(struct user_regs_struct) / sizeof(long),
-		.size = sizeof(long), .align = sizeof(long),
-		.regset_get = genregs_get, .set = genregs_set
+		.core_note_type	= NT_PRSTATUS,
+		.n		= sizeof(struct user_regs_struct) / sizeof(long),
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.regset_get	= genregs_get,
+		.set		= genregs_set
 	},
 	[REGSET64_FP] = {
-		.core_note_type = NT_PRFPREG,
-		.n = sizeof(struct fxregs_state) / sizeof(long),
-		.size = sizeof(long), .align = sizeof(long),
-		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
+		.core_note_type	= NT_PRFPREG,
+		.n		= sizeof(struct fxregs_state) / sizeof(long),
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.active		= regset_xregset_fpregs_active,
+		.regset_get	= xfpregs_get,
+		.set		= xfpregs_set
 	},
 	[REGSET64_XSTATE] = {
-		.core_note_type = NT_X86_XSTATE,
-		.size = sizeof(u64), .align = sizeof(u64),
-		.active = xstateregs_active, .regset_get = xstateregs_get,
-		.set = xstateregs_set
+		.core_note_type	= NT_X86_XSTATE,
+		.size		= sizeof(u64),
+		.align		= sizeof(u64),
+		.active		= xstateregs_active,
+		.regset_get	= xstateregs_get,
+		.set		= xstateregs_set
 	},
 	[REGSET64_IOPERM] = {
-		.core_note_type = NT_386_IOPERM,
-		.n = IO_BITMAP_LONGS,
-		.size = sizeof(long), .align = sizeof(long),
-		.active = ioperm_active, .regset_get = ioperm_get
+		.core_note_type	= NT_386_IOPERM,
+		.n		= IO_BITMAP_LONGS,
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.active		= ioperm_active,
+		.regset_get	= ioperm_get
 	},
 };
 
@@ -1276,42 +1285,56 @@ static const struct user_regset_view user_x86_64_view = {
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 static struct user_regset x86_32_regsets[] __ro_after_init = {
 	[REGSET32_GENERAL] = {
-		.core_note_type = NT_PRSTATUS,
-		.n = sizeof(struct user_regs_struct32) / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.regset_get = genregs32_get, .set = genregs32_set
+		.core_note_type	= NT_PRSTATUS,
+		.n		= sizeof(struct user_regs_struct32) / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.regset_get	= genregs32_get,
+		.set		= genregs32_set
 	},
 	[REGSET32_FP] = {
-		.core_note_type = NT_PRFPREG,
-		.n = sizeof(struct user_i387_ia32_struct) / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.active = regset_fpregs_active, .regset_get = fpregs_get, .set = fpregs_set
+		.core_note_type	= NT_PRFPREG,
+		.n		= sizeof(struct user_i387_ia32_struct) / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.active		= regset_fpregs_active,
+		.regset_get	= fpregs_get,
+		.set		= fpregs_set
 	},
 	[REGSET32_XFP] = {
-		.core_note_type = NT_PRXFPREG,
-		.n = sizeof(struct fxregs_state) / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
+		.core_note_type	= NT_PRXFPREG,
+		.n		= sizeof(struct fxregs_state) / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.active		= regset_xregset_fpregs_active,
+		.regset_get	= xfpregs_get,
+		.set		= xfpregs_set
 	},
 	[REGSET32_XSTATE] = {
-		.core_note_type = NT_X86_XSTATE,
-		.size = sizeof(u64), .align = sizeof(u64),
-		.active = xstateregs_active, .regset_get = xstateregs_get,
-		.set = xstateregs_set
+		.core_note_type	= NT_X86_XSTATE,
+		.size		= sizeof(u64),
+		.align		= sizeof(u64),
+		.active		= xstateregs_active,
+		.regset_get	= xstateregs_get,
+		.set		= xstateregs_set
 	},
 	[REGSET32_TLS] = {
-		.core_note_type = NT_386_TLS,
-		.n = GDT_ENTRY_TLS_ENTRIES, .bias = GDT_ENTRY_TLS_MIN,
-		.size = sizeof(struct user_desc),
-		.align = sizeof(struct user_desc),
-		.active = regset_tls_active,
-		.regset_get = regset_tls_get, .set = regset_tls_set
+		.core_note_type	= NT_386_TLS,
+		.n		= GDT_ENTRY_TLS_ENTRIES,
+		.bias		= GDT_ENTRY_TLS_MIN,
+		.size		= sizeof(struct user_desc),
+		.align		= sizeof(struct user_desc),
+		.active		= regset_tls_active,
+		.regset_get	= regset_tls_get,
+		.set		= regset_tls_set
 	},
 	[REGSET32_IOPERM] = {
-		.core_note_type = NT_386_IOPERM,
-		.n = IO_BITMAP_BYTES / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.active = ioperm_active, .regset_get = ioperm_get
+		.core_note_type	= NT_386_IOPERM,
+		.n		= IO_BITMAP_BYTES / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.active		= ioperm_active,
+		.regset_get	= ioperm_get
 	},
 };
 
