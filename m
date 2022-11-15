Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B0962AE50
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiKOW1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiKOW0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:26:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C0E30577;
        Tue, 15 Nov 2022 14:26:24 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:26:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668551183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQJGRFSBDlv3J3EfKhwZHOBNJcxKNUsEWHBDltavQDs=;
        b=Rx8nMrqf0FSNz0/ixrtHwb+T+z4MxpsQ2Qu0aRh2s3PxTmR2bQ72iqsHcJ7j3fA3tWx4Sf
        ZKqnCtpcGc1kTdE8euJTsDme9JvhYlnDvOyJbyaTzLfyGvFANe4X0ZMb2skRP4/jDU8ZtA
        wV/Df3UKepuK+P60OhxbeyRkfPto97yM3kWce1CJV9fp3puM4jk7pYqLjgumpVih5z54Qk
        /ffgT77LrmLGTpt1tPJzc68/dMCYXU5NDBDmnYI8L3jXKz51KP7fQbzXiYMKWAmLR6ZUb5
        F+4rxZgPtT/7zE8PpmcPeO2GzWG9N5JwP1lPb64ZRWV5GqbYJ25WfQGe9LdA0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668551183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQJGRFSBDlv3J3EfKhwZHOBNJcxKNUsEWHBDltavQDs=;
        b=Wl0CNRiX49iQ3NrHMEKWgWgG9nw4OFw1lS+Znp7Z+364B4+Gobma6xFqyeOqIDYQljIoUD
        y0vdIl5MgHiWrCCA==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/kasan: Rename local CPU_ENTRY_AREA variables to
 shorten names
Cc:     Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221110203504.1985010-4-seanjc@google.com>
References: <20221110203504.1985010-4-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <166855118213.4906.10948114639173935510.tip-bot2@tip-bot2>
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

Commit-ID:     e93cc3aa893e74ea391e06aba09cc4bf523c12c8
Gitweb:        https://git.kernel.org/tip/e93cc3aa893e74ea391e06aba09cc4bf523c12c8
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 10 Nov 2022 20:35:02 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Nov 2022 22:29:59 +01:00

x86/kasan: Rename local CPU_ENTRY_AREA variables to shorten names

Rename the CPU entry area variables in kasan_init() to shorten their
names, a future fix will reference the beginning of the per-CPU portion
of the CPU entry area, and shadow_cpu_entry_per_cpu_begin is a bit much.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Link: https://lkml.kernel.org/r/20221110203504.1985010-4-seanjc@google.com
---
 arch/x86/mm/kasan_init_64.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index d141692..ad7872a 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -331,7 +331,7 @@ void __init kasan_populate_shadow_for_vaddr(void *va, size_t size, int nid)
 void __init kasan_init(void)
 {
 	int i;
-	void *shadow_cpu_entry_begin, *shadow_cpu_entry_end;
+	void *shadow_cea_begin, *shadow_cea_end;
 
 	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
 
@@ -372,16 +372,16 @@ void __init kasan_init(void)
 		map_range(&pfn_mapped[i]);
 	}
 
-	shadow_cpu_entry_begin = (void *)CPU_ENTRY_AREA_BASE;
-	shadow_cpu_entry_begin = kasan_mem_to_shadow(shadow_cpu_entry_begin);
-	shadow_cpu_entry_begin = (void *)round_down(
-			(unsigned long)shadow_cpu_entry_begin, PAGE_SIZE);
+	shadow_cea_begin = (void *)CPU_ENTRY_AREA_BASE;
+	shadow_cea_begin = kasan_mem_to_shadow(shadow_cea_begin);
+	shadow_cea_begin = (void *)round_down(
+			(unsigned long)shadow_cea_begin, PAGE_SIZE);
 
-	shadow_cpu_entry_end = (void *)(CPU_ENTRY_AREA_BASE +
+	shadow_cea_end = (void *)(CPU_ENTRY_AREA_BASE +
 					CPU_ENTRY_AREA_MAP_SIZE);
-	shadow_cpu_entry_end = kasan_mem_to_shadow(shadow_cpu_entry_end);
-	shadow_cpu_entry_end = (void *)round_up(
-			(unsigned long)shadow_cpu_entry_end, PAGE_SIZE);
+	shadow_cea_end = kasan_mem_to_shadow(shadow_cea_end);
+	shadow_cea_end = (void *)round_up(
+			(unsigned long)shadow_cea_end, PAGE_SIZE);
 
 	kasan_populate_early_shadow(
 		kasan_mem_to_shadow((void *)PAGE_OFFSET + MAXMEM),
@@ -403,9 +403,9 @@ void __init kasan_init(void)
 
 	kasan_populate_early_shadow(
 		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
-		shadow_cpu_entry_begin);
+		shadow_cea_begin);
 
-	kasan_populate_early_shadow(shadow_cpu_entry_end,
+	kasan_populate_early_shadow(shadow_cea_end,
 			kasan_mem_to_shadow((void *)__START_KERNEL_map));
 
 	kasan_populate_shadow((unsigned long)kasan_mem_to_shadow(_stext),
