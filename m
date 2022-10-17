Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947226011C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiJQOzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiJQOyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31B0691AD;
        Mon, 17 Oct 2022 07:53:45 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018419;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ubd/DIoeJ/OIwn9O60Fds2i+sO91FJSLSaxfilo2cTM=;
        b=HdhJaKzYXh2Rqs34vC4yW5xhBCJcc0LOm3NYR9CI+ivNdaXEWmflJpZdIkv9RecT1huLc1
        8croHnrPqIMsjQTaetb6HwKus7JQzZPwe/JYbXQd2tQW1LcGHwZ8Zm+le7fJ3Mg6V8hR+c
        5AjQxBnDXMfCATPpR5FaqK4eN+VFB+0aqOzcC0smgm9ne3uI0qAnjSRUggn/nB0/vcfZjV
        P9K3IRrDzEZiqgl9bquDeH3p5lZpQmh0Vf+AIwLKwjnRh+0zAy/3bVTSSH9+5elK54zBml
        DkaHawnf3igybgowqfHuJkw9co3mXan3fBEmyFjMJgyoBhUN0fV90Wlt1XqF2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018419;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ubd/DIoeJ/OIwn9O60Fds2i+sO91FJSLSaxfilo2cTM=;
        b=b3m9bV/m3mA5pAXPgOvsi8WFi2pf1fgZM9bgpmTXZ9N6v+M3u4goRtwDFMvWkdt8hyTjJ/
        VZSgBJV6TpyyYNDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/retbleed: Add SKL call thunk
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111148.101125588@infradead.org>
References: <20220915111148.101125588@infradead.org>
MIME-Version: 1.0
Message-ID: <166601841845.401.850662909719524117.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     bbaceb189a21d7245e8063701fe10985396028f9
Gitweb:        https://git.kernel.org/tip/bbaceb189a21d7245e8063701fe10985396028f9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:15 +02:00

x86/retbleed: Add SKL call thunk

Add the actual SKL call thunk for call depth accounting.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111148.101125588@infradead.org
---
 arch/x86/kernel/callthunks.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 7b9d998..01f6f6b 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -7,6 +7,7 @@
 #include <linux/moduleloader.h>
 
 #include <asm/alternative.h>
+#include <asm/asm-offsets.h>
 #include <asm/cpu.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
@@ -55,7 +56,21 @@ static const struct core_text builtin_coretext = {
 	.name = "builtin",
 };
 
-static struct thunk_desc callthunk_desc __ro_after_init;
+asm (
+	".pushsection .rodata				\n"
+	".global skl_call_thunk_template		\n"
+	"skl_call_thunk_template:			\n"
+		__stringify(INCREMENT_CALL_DEPTH)"	\n"
+	".global skl_call_thunk_tail			\n"
+	"skl_call_thunk_tail:				\n"
+	".popsection					\n"
+);
+
+extern u8 skl_call_thunk_template[];
+extern u8 skl_call_thunk_tail[];
+
+#define SKL_TMPL_SIZE \
+	((unsigned int)(skl_call_thunk_tail - skl_call_thunk_template))
 
 extern void error_entry(void);
 extern void xen_error_entry(void);
@@ -157,11 +172,11 @@ static const u8 nops[] = {
 
 static __init_or_module void *patch_dest(void *dest, bool direct)
 {
-	unsigned int tsize = callthunk_desc.template_size;
+	unsigned int tsize = SKL_TMPL_SIZE;
 	u8 *pad = dest - tsize;
 
 	/* Already patched? */
-	if (!bcmp(pad, callthunk_desc.template, tsize))
+	if (!bcmp(pad, skl_call_thunk_template, tsize))
 		return pad;
 
 	/* Ensure there are nops */
@@ -171,9 +186,9 @@ static __init_or_module void *patch_dest(void *dest, bool direct)
 	}
 
 	if (direct)
-		memcpy(pad, callthunk_desc.template, tsize);
+		memcpy(pad, skl_call_thunk_template, tsize);
 	else
-		text_poke_copy_locked(pad, callthunk_desc.template, tsize, true);
+		text_poke_copy_locked(pad, skl_call_thunk_template, tsize, true);
 	return pad;
 }
 
