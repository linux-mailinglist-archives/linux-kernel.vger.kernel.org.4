Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1B862AE58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbiKOW10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiKOW0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:26:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679CC317E9;
        Tue, 15 Nov 2022 14:26:31 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:26:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668551190;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DcgxX3STYUwWxly17519IsLnQkOgRIvO2ojp6HNvEfw=;
        b=too/gPjNiWybU6NEC1yzFTl0gOJ43FP8ouUP9Mn7q0Q9GgcI/YvpIko6uU0ozY5/YD4hih
        qnWxFmQ+ts8iuyxFCDiBFdlOAeZNp+cVYeoHk+ibCny41azLOId0OifcTZuiD9j/WLUIjX
        nd1w5M3DKbY+SiO1PIbVcL3y5vi61N4omReIjGVwJAAr4Do1ysEAgGGWzy1SasZgWoP79I
        31owgd7ZmylktaZ/1+mC3i5bHl6jQplJ+WyH7ZDh9x/pPBiWJh14LFjdj8DQQ533nwBLxy
        t0R4ZKZZCWXmvPoL5W8vM/v81YJay5UpWTOkSBEDXSfFRH+fGYwublkpWg8zfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668551190;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DcgxX3STYUwWxly17519IsLnQkOgRIvO2ojp6HNvEfw=;
        b=Fqab7t02am5IQ3gq5oz0CA/BvyUfWdGUvBBTQZjs1LbPa+CcFs0JJPBLFgDHFNFrL8H94j
        ckqXeMhKFRBkFxCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Add a few comments
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166855118885.4906.15832099809755736940.tip-bot2@tip-bot2>
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

Commit-ID:     558e2dc0fb7145e7b244dcdd2e287bd9c86d66f3
Gitweb:        https://git.kernel.org/tip/558e2dc0fb7145e7b244dcdd2e287bd9c86d66f3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Nov 2022 13:33:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Nov 2022 22:29:57 +01:00

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
