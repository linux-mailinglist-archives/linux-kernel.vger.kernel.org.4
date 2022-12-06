Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86131644A65
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiLFRgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiLFRgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:36:22 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD10A3B9D5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:36:16 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id l10-20020a170902f68a00b00189d1728848so6739896plg.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOLoTsUdfTgKzlK6Hy0CC7NNiyXgF9iSm7cJp2Q7w9I=;
        b=EGiIlaHT8ks2bvi5YXJjx9YD9KUtl5Bv7ychIQYtNPVEquCrgQSKDZ3acg5PgVPIVe
         pA28XThubo+ao/p3YKAxinQQWFyIQQSFkmKsnVY8WZCzhxljx0GJPSk1N3aJKeKOnyzO
         y3L6C6OLq9XYYqt7xwnr4+YTvztFafCbhJZxAymemVVXLgFhs4mJlMvh9daCOWTjifxU
         tHgiZumwPGXMLfuo+hZRZ6k7aZq4LV1VJveUo3alSBxbMD7MvMmBtQTJ66hHFiQOaMJ4
         UB2QL9SzWEUQbGKo7llrKdknPgVwZyt1vBwC1vd6/WMmb9z36w4uwQ5uWqH0Hqjl2gat
         pqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOLoTsUdfTgKzlK6Hy0CC7NNiyXgF9iSm7cJp2Q7w9I=;
        b=2/g0/L3zGYbmqIA2lZDyBOFL134CXGNEAwnSAexTCQHKjpAfQ0ayWyHNQ8BSGTT5yu
         yRDHvSuag/9idyvK/onG/FNv0iAPL+ZbETwrIp7Hg6uzE2Bh7uCz0l1dcv1K7F/L1Y+5
         XILZ05QXyUy0jVSKKYCCKOGrUjQgoxJ1M3TqxEPUn39qhhZsYeAqGsHOMzEzi+rASnP6
         xZ3u1bKaUfKjsgqHcKShkdNiOH0VKpEPUbKQ7jKfhDsXYQEiRokHTKP5eSTuiCub4CaR
         l6+EnSW9B6kgjFx1RX7e6DRFwIeqCxz+Tiwrmxj/zZu1diZxudSTEHZljAgqZ5ISRaJ5
         3U3w==
X-Gm-Message-State: ANoB5pl8ioQPUAvofX0xpdjKegfzxfo2i79GhC/j+ZwlN/rqLqZKSmXm
        BR0K5miOZrlyKoDU5bTa2A0kSrVIYBXofm7EIhvIiOSYHonOiTpSG0xl04pyOkGx+L8/DabHbXy
        Lokyn6sU/C/4+ARTu+J9mpmHrQ2SclPCX6wxSAeQjTlqwHHoo6nEWNqZnFl6UzSwTiDWU6m2W
X-Google-Smtp-Source: AA0mqf6SMlVyiA0N9Q0gw7pZUuNmuzbXTUgkBqIAbP6ewRDGoB4dQ9xMEoHDig2j00UC567TTm2tAOf3qMjb
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:90a:43a4:b0:219:1d0a:34a6 with SMTP id
 r33-20020a17090a43a400b002191d0a34a6mr5141962pjg.1.1670348175816; Tue, 06 Dec
 2022 09:36:15 -0800 (PST)
Date:   Tue,  6 Dec 2022 17:36:00 +0000
In-Reply-To: <20221206173601.549281-1-bgardon@google.com>
Mime-Version: 1.0
References: <20221206173601.549281-1-bgardon@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221206173601.549281-7-bgardon@google.com>
Subject: [PATCH 6/7] KVM: x86/MMU: Move rmap zap operations to rmap.c
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the various rmap zap functions to rmap.c. These functions are less
"pure" rmap operations in that they also contain some SPTE manipulation,
however they're mostly about rmap / pte list manipulation.

No functional change intended.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 51 +--------------------------------
 arch/x86/kvm/mmu/mmu_internal.h |  1 +
 arch/x86/kvm/mmu/rmap.c         | 50 +++++++++++++++++++++++++++++++-
 arch/x86/kvm/mmu/rmap.h         |  9 +++++-
 4 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 88da2abc2375..12082314d82d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -512,7 +512,7 @@ static bool mmu_spte_update(u64 *sptep, u64 new_spte)
  * state bits, it is used to clear the last level sptep.
  * Returns the old PTE.
  */
-static u64 mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
+u64 mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
 {
 	kvm_pfn_t pfn;
 	u64 old_spte = *sptep;
@@ -855,42 +855,6 @@ gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu, gfn_t gfn,
 	return slot;
 }
 
-static void kvm_zap_one_rmap_spte(struct kvm *kvm,
-				  struct kvm_rmap_head *rmap_head, u64 *sptep)
-{
-	mmu_spte_clear_track_bits(kvm, sptep);
-	pte_list_remove(sptep, rmap_head);
-}
-
-/* Return true if at least one SPTE was zapped, false otherwise */
-static bool kvm_zap_all_rmap_sptes(struct kvm *kvm,
-				   struct kvm_rmap_head *rmap_head)
-{
-	struct pte_list_desc *desc, *next;
-	int i;
-
-	if (!rmap_head->val)
-		return false;
-
-	if (!(rmap_head->val & 1)) {
-		mmu_spte_clear_track_bits(kvm, (u64 *)rmap_head->val);
-		goto out;
-	}
-
-	desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
-
-	for (; desc; desc = next) {
-		for (i = 0; i < desc->spte_count; i++)
-			mmu_spte_clear_track_bits(kvm, desc->sptes[i]);
-		next = desc->more;
-		free_pte_list_desc(desc);
-	}
-out:
-	/* rmap_head is meaningless now, remember to reset it */
-	rmap_head->val = 0;
-	return true;
-}
-
 static void drop_spte(struct kvm *kvm, u64 *sptep)
 {
 	u64 old_spte = mmu_spte_clear_track_bits(kvm, sptep);
@@ -1145,19 +1109,6 @@ static bool kvm_vcpu_write_protect_gfn(struct kvm_vcpu *vcpu, u64 gfn)
 	return kvm_mmu_slot_gfn_write_protect(vcpu->kvm, slot, gfn, PG_LEVEL_4K);
 }
 
-static bool __kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-			   const struct kvm_memory_slot *slot)
-{
-	return kvm_zap_all_rmap_sptes(kvm, rmap_head);
-}
-
-static bool kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-			 struct kvm_memory_slot *slot, gfn_t gfn, int level,
-			 pte_t unused)
-{
-	return __kvm_zap_rmap(kvm, rmap_head, slot);
-}
-
 static bool kvm_set_pte_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			     struct kvm_memory_slot *slot, gfn_t gfn, int level,
 			     pte_t pte)
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 3de703c2a5d4..a219c8e556e9 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -319,4 +319,5 @@ void track_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 void untrack_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 
 gfn_t kvm_mmu_page_get_gfn(struct kvm_mmu_page *sp, int index);
+u64 mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep);
 #endif /* __KVM_X86_MMU_INTERNAL_H */
diff --git a/arch/x86/kvm/mmu/rmap.c b/arch/x86/kvm/mmu/rmap.c
index 91af5b32cffb..9cc4252aaabb 100644
--- a/arch/x86/kvm/mmu/rmap.c
+++ b/arch/x86/kvm/mmu/rmap.c
@@ -56,7 +56,7 @@ int pte_list_add(struct kvm_mmu_memory_cache *cache, u64 *spte,
 	return count;
 }
 
-void free_pte_list_desc(struct pte_list_desc *pte_list_desc)
+static void free_pte_list_desc(struct pte_list_desc *pte_list_desc)
 {
 	kmem_cache_free(pte_list_desc_cache, pte_list_desc);
 }
@@ -283,3 +283,51 @@ void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
 
 	rmap_walk_init_level(iterator, iterator->level);
 }
+
+void kvm_zap_one_rmap_spte(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			   u64 *sptep)
+{
+	mmu_spte_clear_track_bits(kvm, sptep);
+	pte_list_remove(sptep, rmap_head);
+}
+
+/* Return true if at least one SPTE was zapped, false otherwise */
+bool kvm_zap_all_rmap_sptes(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+{
+	struct pte_list_desc *desc, *next;
+	int i;
+
+	if (!rmap_head->val)
+		return false;
+
+	if (!(rmap_head->val & 1)) {
+		mmu_spte_clear_track_bits(kvm, (u64 *)rmap_head->val);
+		goto out;
+	}
+
+	desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
+
+	for (; desc; desc = next) {
+		for (i = 0; i < desc->spte_count; i++)
+			mmu_spte_clear_track_bits(kvm, desc->sptes[i]);
+		next = desc->more;
+		free_pte_list_desc(desc);
+	}
+out:
+	/* rmap_head is meaningless now, remember to reset it */
+	rmap_head->val = 0;
+	return true;
+}
+
+bool __kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		    const struct kvm_memory_slot *slot)
+{
+	return kvm_zap_all_rmap_sptes(kvm, rmap_head);
+}
+
+bool kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		  struct kvm_memory_slot *slot, gfn_t gfn, int level,
+		  pte_t unused)
+{
+	return __kvm_zap_rmap(kvm, rmap_head, slot);
+}
diff --git a/arch/x86/kvm/mmu/rmap.h b/arch/x86/kvm/mmu/rmap.h
index dc4bf7e609ec..a9bf48494e1a 100644
--- a/arch/x86/kvm/mmu/rmap.h
+++ b/arch/x86/kvm/mmu/rmap.h
@@ -27,7 +27,6 @@ static struct kmem_cache *pte_list_desc_cache;
 
 int pte_list_add(struct kvm_mmu_memory_cache *cache, u64 *spte,
 		 struct kvm_rmap_head *rmap_head);
-void free_pte_list_desc(struct pte_list_desc *pte_list_desc);
 void pte_list_remove(u64 *spte, struct kvm_rmap_head *rmap_head);
 unsigned int pte_list_count(struct kvm_rmap_head *rmap_head);
 
@@ -90,4 +89,12 @@ typedef bool (*rmap_handler_t)(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			       struct kvm_memory_slot *slot, gfn_t gfn,
 			       int level, pte_t pte);
 
+void kvm_zap_one_rmap_spte(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			   u64 *sptep);
+bool kvm_zap_all_rmap_sptes(struct kvm *kvm, struct kvm_rmap_head *rmap_head);
+bool __kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		    const struct kvm_memory_slot *slot);
+bool kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		  struct kvm_memory_slot *slot, gfn_t gfn, int level,
+		  pte_t unused);
 #endif /* __KVM_X86_MMU_RMAP_H */
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

