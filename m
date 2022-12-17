Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC7464FBE9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiLQS53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiLQSzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A24B38E;
        Sat, 17 Dec 2022 10:55:38 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=d0+esdgO6T9UxQJKcyAonNefuPC0/JggTFaq3f3GHfE=;
        b=WhCSEDXz6NxyYUo3JvDlqcf5s6RWEY3P2K+5RnSJJ4WR5ihW7+QzuNe12mMCoGpXxgPZ6Y
        lGiOHJ/XsKvff3DfYWEYKt1pz2fuFv5dxv4vDcFsYEcFd1caNP0IsvwRf31zdpY9rhVl7Q
        8fB3Ei9y+JRYXrD2bXP+ZPGJ90DG1kJmyiWKOAXgzoha10jo5lV3FI/+ZJqVw8KsUQu7yH
        ypxwNm3IPQv4p83xUxAx6QjII6pqKhGS8P1aMLpK2KI+H0qDpfvMq2XGivt/14bD27xZ0g
        o7Ew6hnS8Vw4vt/tW91QAD6Pu/qrZFQrK1DvjPAVbzewxBc78HeTHS7q59d1ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=d0+esdgO6T9UxQJKcyAonNefuPC0/JggTFaq3f3GHfE=;
        b=DUlvk8sWlOPt/1SGEZ/iqcKCNlIcjcyWYlsTuCPPbj7OIZr+qR27eev2PUeL+wnvjYm/2e
        e3acgxqCabgAnUBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm: Update ptep_get_lockless()'s comment
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167130333420.4906.9822372007953321398.tip-bot2@tip-bot2>
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

Commit-ID:     93b3037a1482758349f3b0431406bcc457ca1cbc
Gitweb:        https://git.kernel.org/tip/93b3037a1482758349f3b0431406bcc457ca1cbc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 14:04:46 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:27 -08:00

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
