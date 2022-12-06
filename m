Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F8644A64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbiLFRgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbiLFRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:36:18 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52623B9C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:36:14 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b13-20020a056a000a8d00b0057348c50123so13531014pfl.18
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TVyB4/pSme/cFmmgXmwyjFM6o5GyBUdN87C0tWnxAo=;
        b=oVPJ2nG7PFgq3bksWsgionXC79t3Kk/k1kgfLgV8FmLQwSFfrzXfhIv7LJ4yoS4zML
         KxXcvA273d0cpEacTsrs3CPwZ0QeGzc/wrtfBDP8vEEiwzvY9qAx/YXCee4fbzCDlyPA
         wf12/QEcjIC8x4ZQyEhI4RVPSyH0ittgNyouIntMcJOj9jEe20vMURToED9sTUyrn/4z
         9oQV3HNShZ/sB9f4KGupI+YqgXr8EERfZU+z+oZiaGH+zBRcZ0PjIAAJsyAjMUzSm7Vs
         4g6VdBhmU7ZsH3z3DVifdx/0F/p8Z+JwDN7p3vpkEeG1Qde7kp/1dlDnT2BnY/1VIB4d
         dowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TVyB4/pSme/cFmmgXmwyjFM6o5GyBUdN87C0tWnxAo=;
        b=0G/cwGlhqMZPkjZE5N0Mckc7JvXYU7h37H7im+5IO7I/ygV1CCrkchSIZcB/HVyR8V
         f9ZhILh2/LrKpqIzBKcZKe+xjI6qanJsDT3B+iMRuYDsbQ4XXwu5VBept/rK8DJKb8bU
         dbYRNhlcZQvR90RMxW36X3JzE1R/Kodii2LU4WNpdzGSJYMrbBCUq6FMA0CTbtZ36loM
         i/8tyQ/yjdqGF09+yFk8ZU0qi5IEwis4P/AAD9kj3hkzAArBhq1Ikb5Wo4czh0dtGdWA
         iYd8icycoie0lUaewD8UpBpvSRbEK+Jr7kXrCdAAAXZR5kfJguNcmT8C7DZggiqS+jaL
         TpAg==
X-Gm-Message-State: ANoB5pnhGngahw7OZmt9ezfRq7kqBxiSZhgPag1eG6X7XlY5Al8VqKD3
        JavBCwPXoaasE2UCpGUiNFhMzr9YpCKgX9i8aWuG7bwwrEVOX3Wy19qWFpH/Snn2+5lvKx0921w
        T/09Vr+22iV5ifPUzlo68FglQKZhOQoUD+qfWLV2YxCGxOYlI2VWQxXJ3u8he3EqGZ55g9BfW
X-Google-Smtp-Source: AA0mqf7SW6OB8Y2Moh616DcgP97JKus7htQeSRUpj5qdfuWqrXLEsHouDMvq55z0jw4zpn9+Xt6dTXMtuqKH
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:90a:8b03:b0:213:16d2:4d4c with SMTP id
 y3-20020a17090a8b0300b0021316d24d4cmr96765107pjn.70.1670348174449; Tue, 06
 Dec 2022 09:36:14 -0800 (PST)
Date:   Tue,  6 Dec 2022 17:35:59 +0000
In-Reply-To: <20221206173601.549281-1-bgardon@google.com>
Mime-Version: 1.0
References: <20221206173601.549281-1-bgardon@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221206173601.549281-6-bgardon@google.com>
Subject: [PATCH 5/7] KVM: x86/MMU: Move the rmap walk iterator out of mmu.c
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move slot_rmap_walk_iterator and its associated functions out of mmu.c
to rmap.(c|h).

No functional change intended.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c  | 73 -----------------------------------------
 arch/x86/kvm/mmu/rmap.c | 43 ++++++++++++++++++++++++
 arch/x86/kvm/mmu/rmap.h | 36 ++++++++++++++++++++
 3 files changed, 79 insertions(+), 73 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 52e487d89d54..88da2abc2375 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1198,79 +1198,6 @@ static bool kvm_set_pte_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 	return need_flush;
 }
 
-struct slot_rmap_walk_iterator {
-	/* input fields. */
-	const struct kvm_memory_slot *slot;
-	gfn_t start_gfn;
-	gfn_t end_gfn;
-	int start_level;
-	int end_level;
-
-	/* output fields. */
-	gfn_t gfn;
-	struct kvm_rmap_head *rmap;
-	int level;
-
-	/* private field. */
-	struct kvm_rmap_head *end_rmap;
-};
-
-static void
-rmap_walk_init_level(struct slot_rmap_walk_iterator *iterator, int level)
-{
-	iterator->level = level;
-	iterator->gfn = iterator->start_gfn;
-	iterator->rmap = gfn_to_rmap(iterator->gfn, level, iterator->slot);
-	iterator->end_rmap = gfn_to_rmap(iterator->end_gfn, level, iterator->slot);
-}
-
-static void
-slot_rmap_walk_init(struct slot_rmap_walk_iterator *iterator,
-		    const struct kvm_memory_slot *slot, int start_level,
-		    int end_level, gfn_t start_gfn, gfn_t end_gfn)
-{
-	iterator->slot = slot;
-	iterator->start_level = start_level;
-	iterator->end_level = end_level;
-	iterator->start_gfn = start_gfn;
-	iterator->end_gfn = end_gfn;
-
-	rmap_walk_init_level(iterator, iterator->start_level);
-}
-
-static bool slot_rmap_walk_okay(struct slot_rmap_walk_iterator *iterator)
-{
-	return !!iterator->rmap;
-}
-
-static void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
-{
-	while (++iterator->rmap <= iterator->end_rmap) {
-		iterator->gfn += (1UL << KVM_HPAGE_GFN_SHIFT(iterator->level));
-
-		if (iterator->rmap->val)
-			return;
-	}
-
-	if (++iterator->level > iterator->end_level) {
-		iterator->rmap = NULL;
-		return;
-	}
-
-	rmap_walk_init_level(iterator, iterator->level);
-}
-
-#define for_each_slot_rmap_range(_slot_, _start_level_, _end_level_,	\
-	   _start_gfn, _end_gfn, _iter_)				\
-	for (slot_rmap_walk_init(_iter_, _slot_, _start_level_,		\
-				 _end_level_, _start_gfn, _end_gfn);	\
-	     slot_rmap_walk_okay(_iter_);				\
-	     slot_rmap_walk_next(_iter_))
-
-typedef bool (*rmap_handler_t)(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-			       struct kvm_memory_slot *slot, gfn_t gfn,
-			       int level, pte_t pte);
-
 static __always_inline bool kvm_handle_gfn_range(struct kvm *kvm,
 						 struct kvm_gfn_range *range,
 						 rmap_handler_t handler)
diff --git a/arch/x86/kvm/mmu/rmap.c b/arch/x86/kvm/mmu/rmap.c
index 6833676aa9ea..91af5b32cffb 100644
--- a/arch/x86/kvm/mmu/rmap.c
+++ b/arch/x86/kvm/mmu/rmap.c
@@ -240,3 +240,46 @@ void rmap_remove(struct kvm *kvm, u64 *spte)
 
 	pte_list_remove(spte, rmap_head);
 }
+
+void rmap_walk_init_level(struct slot_rmap_walk_iterator *iterator, int level)
+{
+	iterator->level = level;
+	iterator->gfn = iterator->start_gfn;
+	iterator->rmap = gfn_to_rmap(iterator->gfn, level, iterator->slot);
+	iterator->end_rmap = gfn_to_rmap(iterator->end_gfn, level, iterator->slot);
+}
+
+void slot_rmap_walk_init(struct slot_rmap_walk_iterator *iterator,
+			 const struct kvm_memory_slot *slot, int start_level,
+			 int end_level, gfn_t start_gfn, gfn_t end_gfn)
+{
+	iterator->slot = slot;
+	iterator->start_level = start_level;
+	iterator->end_level = end_level;
+	iterator->start_gfn = start_gfn;
+	iterator->end_gfn = end_gfn;
+
+	rmap_walk_init_level(iterator, iterator->start_level);
+}
+
+bool slot_rmap_walk_okay(struct slot_rmap_walk_iterator *iterator)
+{
+	return !!iterator->rmap;
+}
+
+void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
+{
+	while (++iterator->rmap <= iterator->end_rmap) {
+		iterator->gfn += (1UL << KVM_HPAGE_GFN_SHIFT(iterator->level));
+
+		if (iterator->rmap->val)
+			return;
+	}
+
+	if (++iterator->level > iterator->end_level) {
+		iterator->rmap = NULL;
+		return;
+	}
+
+	rmap_walk_init_level(iterator, iterator->level);
+}
diff --git a/arch/x86/kvm/mmu/rmap.h b/arch/x86/kvm/mmu/rmap.h
index 81df186ba3c3..dc4bf7e609ec 100644
--- a/arch/x86/kvm/mmu/rmap.h
+++ b/arch/x86/kvm/mmu/rmap.h
@@ -54,4 +54,40 @@ struct kvm_rmap_head *gfn_to_rmap(gfn_t gfn, int level,
 
 bool rmap_can_add(struct kvm_vcpu *vcpu);
 void rmap_remove(struct kvm *kvm, u64 *spte);
+
+struct slot_rmap_walk_iterator {
+	/* input fields. */
+	const struct kvm_memory_slot *slot;
+	gfn_t start_gfn;
+	gfn_t end_gfn;
+	int start_level;
+	int end_level;
+
+	/* output fields. */
+	gfn_t gfn;
+	struct kvm_rmap_head *rmap;
+	int level;
+
+	/* private field. */
+	struct kvm_rmap_head *end_rmap;
+};
+
+void rmap_walk_init_level(struct slot_rmap_walk_iterator *iterator, int level);
+void slot_rmap_walk_init(struct slot_rmap_walk_iterator *iterator,
+			 const struct kvm_memory_slot *slot, int start_level,
+			 int end_level, gfn_t start_gfn, gfn_t end_gfn);
+bool slot_rmap_walk_okay(struct slot_rmap_walk_iterator *iterator);
+void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator);
+
+#define for_each_slot_rmap_range(_slot_, _start_level_, _end_level_,	\
+	   _start_gfn, _end_gfn, _iter_)				\
+	for (slot_rmap_walk_init(_iter_, _slot_, _start_level_,		\
+				 _end_level_, _start_gfn, _end_gfn);	\
+	     slot_rmap_walk_okay(_iter_);				\
+	     slot_rmap_walk_next(_iter_))
+
+typedef bool (*rmap_handler_t)(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			       struct kvm_memory_slot *slot, gfn_t gfn,
+			       int level, pte_t pte);
+
 #endif /* __KVM_X86_MMU_RMAP_H */
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

