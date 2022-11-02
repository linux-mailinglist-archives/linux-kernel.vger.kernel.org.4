Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE18F615F4C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiKBJOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiKBJNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:13:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A0228E37;
        Wed,  2 Nov 2022 02:12:48 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=06Saxu+llcAwf1QI8k1oKeHyockoF7y2i5LjSBewS5k=;
        b=Z+b39LgGsSPADaUEHUKSzZfyDbOznRkHbeiZnixD4zxZ6CHTe/72brWOn7hwciVsvzzwJ7
        amL1UjsgJGSwbrXWALe27SqDj1rOZoRWmTmT7TmQ5wqpXg/pa9U7wFHPRhcXypziNgTMor
        ppyM280hN7IWoIEdFiFP7mLeShkLZFSbDbukJZZDwXdMj8xvAeOgbcoFQP2XcxYxiIH62R
        PVwL8xcgfCbeNnsDUbq3T7IrTiuR+nnjemHxX0ZBn4xoYWiAZvYL6XXMXhdOu4zpB95oyC
        /XxicA5hEk2PwyuYWhZ6VdFejpQ4PIfc80vpRz6TNlVPSguSsblwC/gunad+7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=06Saxu+llcAwf1QI8k1oKeHyockoF7y2i5LjSBewS5k=;
        b=Uybz8V2hZuXRS5xyeTkuov9cE0xHnoTsMmU/dG6abAojEgDWQs6HTk8axzjQ3UCem0rFVz
        Rk1g3e9gEXXjBACA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm: Update ptep_get_lockless()'s comment
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166738036632.7716.16970239696245313783.tip-bot2@tip-bot2>
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

Commit-ID:     88993b1627f2a2205b2f3112c4d22448cd863df3
Gitweb:        https://git.kernel.org/tip/88993b1627f2a2205b2f3112c4d22448cd863df3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 14:04:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:43:59 +01:00

mm: Update ptep_get_lockless()'s comment

Improve the comment.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114424.515572025%40infradead.org
---
 include/linux/pgtable.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a108b60..c0b2900 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -300,15 +300,12 @@ static inline pte_t ptep_get(pte_t *ptep)
 
 #ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
 /*
- * WARNING: only to be used in the get_user_pages_fast() implementation.
- *
- * With get_user_pages_fast(), we walk down the pagetables without taking any
- * locks.  For this we would like to load the pointers atomically, but sometimes
- * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
- * we do have is the guarantee that a PTE will only either go from not present
- * to present, or present to not present or both -- it will not switch to a
- * completely different present page without a TLB flush in between; something
- * that we are blocking by holding interrupts off.
+ * For walking the pagetables without holding any locks.  Some architectures
+ * (eg x86-32 PAE) cannot load the entries atomically without using expensive
+ * instructions.  We are guaranteed that a PTE will only either go from not
+ * present to present, or present to not present -- it will not switch to a
+ * completely different present page without a TLB flush inbetween; which we
+ * are blocking by holding interrupts off.
  *
  * Setting ptes from not present to present goes:
  *
