Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4191764FBDB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiLQS40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLQSzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9118210FC2;
        Sat, 17 Dec 2022 10:55:35 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=E53RHJcelb4AnLKZMjCK+9UEbOGOVcHWJYrXV9uNWa0=;
        b=yH+mnT4RYIgcvr902on/EAwQspQAB5i6UAX0p0QRQ+Eifa6FjFz3XtjZRt+U8rxfzkwhOF
        5x9bdvSpSWK4NYnMDmZ0kDOw773hTjApeeL4R5MATNDFbaH2iH2YzqJREZIUdv/zsfo8Vj
        Jvw0A3n+lqRdnuHds7gH9eelXd92/91WppoG+cZHR5+cMXPNN4h8ZBqOh6D7saLopi/CRk
        lUMfwdQLlwONMI8riylxzoc5+tT2fkhz7DBg8OHukXa5IOOprSZEIeSl2TjbLVqoCOacPc
        ez1HgJnDdBgww88h7eOxOnARoEOm4PvemSWhfucoyg1wc8/1gM/Yb3b/xR2D+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=E53RHJcelb4AnLKZMjCK+9UEbOGOVcHWJYrXV9uNWa0=;
        b=8RbTgiRHZ2lW+CfrexmWMarLVi2YezGcVHdpFuu1UYXX1nMmBEoD3W0NB1/8C75H2mF5fR
        hVviw8XRIdH8f3AQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Add a few comments
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167130333104.4906.15196955293503615286.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     5ceeee7571b7628f439ae0444ec41d132558f47e
Gitweb:        https://git.kernel.org/tip/5ceeee7571b7628f439ae0444ec41d132558f47e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Nov 2022 13:33:50 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:28 -08:00

x86/mm: Add a few comments

It's a shame to hide useful comments in Changelogs, add some to the
code.

Shamelessly stolen from commit:

  c40a56a7818c ("x86/mm/init: Remove freed kernel image areas from alias mapping")

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221110125544.460677011%40infradead.org
---
 arch/x86/mm/pat/set_memory.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 06eb891..50f81ea 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -219,6 +219,23 @@ within_inclusive(unsigned long addr, unsigned long start, unsigned long end)
 
 #ifdef CONFIG_X86_64
 
+/*
+ * The kernel image is mapped into two places in the virtual address space
+ * (addresses without KASLR, of course):
+ *
+ * 1. The kernel direct map (0xffff880000000000)
+ * 2. The "high kernel map" (0xffffffff81000000)
+ *
+ * We actually execute out of #2. If we get the address of a kernel symbol, it
+ * points to #2, but almost all physical-to-virtual translations point to #1.
+ *
+ * This is so that we can have both a directmap of all physical memory *and*
+ * take full advantage of the the limited (s32) immediate addressing range (2G)
+ * of x86_64.
+ *
+ * See Documentation/x86/x86_64/mm.rst for more detail.
+ */
+
 static inline unsigned long highmap_start_pfn(void)
 {
 	return __pa_symbol(_text) >> PAGE_SHIFT;
@@ -1626,6 +1643,9 @@ repeat:
 
 static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias);
 
+/*
+ * Check the directmap and "high kernel map" 'aliases'.
+ */
 static int cpa_process_alias(struct cpa_data *cpa)
 {
 	struct cpa_data alias_cpa;
