Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BEE688676
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjBBSaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjBBS3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:29:24 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B311E9D5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:28:40 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id k15-20020a17090a590f00b002300fe6b09dso3281152pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MglY/RjpYcqUADFANaRWEQQDd9cl7EMg6LVL3/WV9Zo=;
        b=PnUKay1IZj95QB6+OCa89Nu7SKUG4PXK9M9N56Ez/hDS/DkMKQChuX/zpQ+LBk/3yi
         TKjRDdjkSHcfHej5A/WDWz41y4pOpl0eHKg6HXGzddNG4DAsUgyC3AmNOx8Tzc6tnbrF
         MsXnhWT+jJM8XoIfHhmgjAbEOduXrmBsfukeasKfxYszj0+ucVL1lIuON9xNf6rmZcnO
         WKcCTbLxtTE+QVoazNp9YK6Maw1TCo576hnKdzOSGb0yXURJS8a0UW8lefG82MLl9C1U
         jY+UJkj0/wwuLfO+C6nWy8J1HTnqz840YqlEf4xqtgM7VDnNfKqg18uugg9UrvWf6WYk
         wLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MglY/RjpYcqUADFANaRWEQQDd9cl7EMg6LVL3/WV9Zo=;
        b=mHhRzAOa9d+/MxkYvzZP0cCAmN6FZc4LJ8SIL8lD2i8RC59YnMNuRqv4z1SpZY46EJ
         BMFbroQFIOv+xyWxgl4qMG0/AwFGUzVfULHCplKETPrdqFrzRYyFFLjsfwOBhYaFtKn/
         6cyKWRR0khtD06OYDIiMVHRy8DEb6+U2JkblLhu8g8koJpXD+LMDWWomcIOK6zwA/azF
         7tDju8+JDj6BVSOAtPqN+A9/s0adxe4hDtqC7/s+Yk5eUNXFrvH6uV55GoaSf8yIAYXR
         sbGv3easUIXPF7Iv5MtdhUF60kGMNPxfY9WmIZJl83nH0fE9HJ4ofJD2TXNiVbFx+7pp
         PzRQ==
X-Gm-Message-State: AO0yUKURm/fKjcUUAhodWBFgpnrjCQbd7Gw+Bf402Gw5Fs49AJWRkrh7
        +qYEJcZwfe4mmKu7PE4Ze+qrfSWd+NiiGL/k8rqjWdZfddwGhLS2h+6BlYzaOCe1ZWEhVBEDaLT
        zHrFTmw3jRH+KvkINfUN5UHdMvwlXcCnM20aDPFmfbQAfxMePtc30y68edVZirSgD0i0Q/Mqi
X-Google-Smtp-Source: AK7set/7AKotRKnCo3zwV5NFHZnOLpgrbI9wqTCPB7NMQAcFSk8gBlOqHrxv80OiBzbzEd3wdLqF5ixUGWea
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:90a:600d:b0:229:2296:4be3 with SMTP id
 y13-20020a17090a600d00b0022922964be3mr771911pji.5.1675362507870; Thu, 02 Feb
 2023 10:28:27 -0800 (PST)
Date:   Thu,  2 Feb 2023 18:27:58 +0000
In-Reply-To: <20230202182809.1929122-1-bgardon@google.com>
Mime-Version: 1.0
References: <20230202182809.1929122-1-bgardon@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202182809.1929122-11-bgardon@google.com>
Subject: [PATCH 10/21] KVM: x86/MMU: Clean up Shadow MMU exports
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ricardo Koller <ricarkol@google.com>,
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

Now that paging_tmpl.h is included from shadow_mmu.c, there's no need to
export many of the functions currrently in shadow_mmu.h, so remove those
exports and mark the functions static. This cleans up the interface
of the Shadow MMU, and will allow the implementation to keep the details
of rmap_heads internal.

No functional change intended.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/shadow_mmu.c | 78 +++++++++++++++++++++--------------
 arch/x86/kvm/mmu/shadow_mmu.h | 51 +----------------------
 2 files changed, 48 insertions(+), 81 deletions(-)

diff --git a/arch/x86/kvm/mmu/shadow_mmu.c b/arch/x86/kvm/mmu/shadow_mmu.c
index c7cfdc6f51b53..1be680bce15a6 100644
--- a/arch/x86/kvm/mmu/shadow_mmu.c
+++ b/arch/x86/kvm/mmu/shadow_mmu.c
@@ -24,6 +24,20 @@
 #include <asm/cmpxchg.h>
 #include <trace/events/kvm.h>
 
+struct kvm_shadow_walk_iterator {
+	u64 addr;
+	hpa_t shadow_addr;
+	u64 *sptep;
+	int level;
+	unsigned index;
+};
+
+#define for_each_shadow_entry_using_root(_vcpu, _root, _addr, _walker)     \
+	for (shadow_walk_init_using_root(&(_walker), (_vcpu),              \
+					 (_root), (_addr));                \
+	     shadow_walk_okay(&(_walker));			           \
+	     shadow_walk_next(&(_walker)))
+
 #define for_each_shadow_entry(_vcpu, _addr, _walker)            \
 	for (shadow_walk_init(&(_walker), _vcpu, _addr);	\
 	     shadow_walk_okay(&(_walker));			\
@@ -230,7 +244,7 @@ static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
  *
  * Returns true if the TLB needs to be flushed
  */
-bool mmu_spte_update(u64 *sptep, u64 new_spte)
+static bool mmu_spte_update(u64 *sptep, u64 new_spte)
 {
 	bool flush = false;
 	u64 old_spte = mmu_spte_update_no_track(sptep, new_spte);
@@ -314,7 +328,7 @@ static u64 mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
  * Directly clear spte without caring the state bits of sptep,
  * it is used to set the upper level spte.
  */
-void mmu_spte_clear_no_track(u64 *sptep)
+static void mmu_spte_clear_no_track(u64 *sptep)
 {
 	__update_clear_spte_fast(sptep, 0ull);
 }
@@ -357,7 +371,7 @@ static void mmu_free_pte_list_desc(struct pte_list_desc *pte_list_desc)
 
 static bool sp_has_gptes(struct kvm_mmu_page *sp);
 
-gfn_t kvm_mmu_page_get_gfn(struct kvm_mmu_page *sp, int index)
+static gfn_t kvm_mmu_page_get_gfn(struct kvm_mmu_page *sp, int index)
 {
 	if (sp->role.passthrough)
 		return sp->gfn;
@@ -413,8 +427,8 @@ static void kvm_mmu_page_set_translation(struct kvm_mmu_page *sp, int index,
 	          sp->gfn, kvm_mmu_page_get_gfn(sp, index), gfn);
 }
 
-void kvm_mmu_page_set_access(struct kvm_mmu_page *sp, int index,
-			     unsigned int access)
+static void kvm_mmu_page_set_access(struct kvm_mmu_page *sp, int index,
+				    unsigned int access)
 {
 	gfn_t gfn = kvm_mmu_page_get_gfn(sp, index);
 
@@ -629,7 +643,7 @@ struct kvm_rmap_head *gfn_to_rmap(gfn_t gfn, int level,
 	return &slot->arch.rmap[level - PG_LEVEL_4K][idx];
 }
 
-bool rmap_can_add(struct kvm_vcpu *vcpu)
+static bool rmap_can_add(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu_memory_cache *mc;
 
@@ -737,7 +751,7 @@ static u64 *rmap_get_next(struct rmap_iterator *iter)
 	for (_spte_ = rmap_get_first(_rmap_head_, _iter_);		\
 	     _spte_; _spte_ = rmap_get_next(_iter_))
 
-void drop_spte(struct kvm *kvm, u64 *sptep)
+static void drop_spte(struct kvm *kvm, u64 *sptep)
 {
 	u64 old_spte = mmu_spte_clear_track_bits(kvm, sptep);
 
@@ -1114,7 +1128,7 @@ static void mmu_page_remove_parent_pte(struct kvm_mmu_page *sp,
 	pte_list_remove(parent_pte, &sp->parent_ptes);
 }
 
-void drop_parent_pte(struct kvm_mmu_page *sp, u64 *parent_pte)
+static void drop_parent_pte(struct kvm_mmu_page *sp, u64 *parent_pte)
 {
 	mmu_page_remove_parent_pte(sp, parent_pte);
 	mmu_spte_clear_no_track(parent_pte);
@@ -1344,8 +1358,8 @@ static void mmu_pages_clear_parents(struct mmu_page_path *parents)
 	} while (!sp->unsync_children);
 }
 
-int mmu_sync_children(struct kvm_vcpu *vcpu, struct kvm_mmu_page *parent,
-		      bool can_yield)
+static int mmu_sync_children(struct kvm_vcpu *vcpu, struct kvm_mmu_page *parent,
+			     bool can_yield)
 {
 	int i;
 	struct kvm_mmu_page *sp;
@@ -1391,7 +1405,7 @@ void __clear_sp_write_flooding_count(struct kvm_mmu_page *sp)
 	atomic_set(&sp->write_flooding_count,  0);
 }
 
-void clear_sp_write_flooding_count(u64 *spte)
+static void clear_sp_write_flooding_count(u64 *spte)
 {
 	__clear_sp_write_flooding_count(sptep_to_sp(spte));
 }
@@ -1604,9 +1618,9 @@ static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direct,
 	return role;
 }
 
-struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu, u64 *sptep,
-					  gfn_t gfn, bool direct,
-					  unsigned int access)
+static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
+						 u64 *sptep, gfn_t gfn,
+						 bool direct, unsigned int access)
 {
 	union kvm_mmu_page_role role;
 
@@ -1617,8 +1631,9 @@ struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu, u64 *sptep,
 	return kvm_mmu_get_shadow_page(vcpu, gfn, role);
 }
 
-void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterator,
-				 struct kvm_vcpu *vcpu, hpa_t root, u64 addr)
+static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterator,
+					struct kvm_vcpu *vcpu, hpa_t root,
+					u64 addr)
 {
 	iterator->addr = addr;
 	iterator->shadow_addr = root;
@@ -1645,14 +1660,14 @@ void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterator,
 	}
 }
 
-void shadow_walk_init(struct kvm_shadow_walk_iterator *iterator,
-		      struct kvm_vcpu *vcpu, u64 addr)
+static void shadow_walk_init(struct kvm_shadow_walk_iterator *iterator,
+			     struct kvm_vcpu *vcpu, u64 addr)
 {
 	shadow_walk_init_using_root(iterator, vcpu, vcpu->arch.mmu->root.hpa,
 				    addr);
 }
 
-bool shadow_walk_okay(struct kvm_shadow_walk_iterator *iterator)
+static bool shadow_walk_okay(struct kvm_shadow_walk_iterator *iterator)
 {
 	if (iterator->level < PG_LEVEL_4K)
 		return false;
@@ -1674,7 +1689,7 @@ static void __shadow_walk_next(struct kvm_shadow_walk_iterator *iterator,
 	--iterator->level;
 }
 
-void shadow_walk_next(struct kvm_shadow_walk_iterator *iterator)
+static void shadow_walk_next(struct kvm_shadow_walk_iterator *iterator)
 {
 	__shadow_walk_next(iterator, *iterator->sptep);
 }
@@ -1714,13 +1729,14 @@ static void __link_shadow_page(struct kvm *kvm,
 		mark_unsync(sptep);
 }
 
-void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep, struct kvm_mmu_page *sp)
+static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
+			     struct kvm_mmu_page *sp)
 {
 	__link_shadow_page(vcpu->kvm, &vcpu->arch.mmu_pte_list_desc_cache, sptep, sp, true);
 }
 
-void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
-			  unsigned direct_access)
+static void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
+				 unsigned direct_access)
 {
 	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep)) {
 		struct kvm_mmu_page *child;
@@ -1742,8 +1758,8 @@ void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 }
 
 /* Returns the number of zapped non-leaf child shadow pages. */
-int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp, u64 *spte,
-		     struct list_head *invalid_list)
+static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp, u64 *spte,
+			    struct list_head *invalid_list)
 {
 	u64 pte;
 	struct kvm_mmu_page *child;
@@ -2156,9 +2172,9 @@ int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
 	return 0;
 }
 
-int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
-		 u64 *sptep, unsigned int pte_access, gfn_t gfn,
-		 kvm_pfn_t pfn, struct kvm_page_fault *fault)
+static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
+			u64 *sptep, unsigned int pte_access, gfn_t gfn,
+			kvm_pfn_t pfn, struct kvm_page_fault *fault)
 {
 	struct kvm_mmu_page *sp = sptep_to_sp(sptep);
 	int level = sp->role.level;
@@ -2263,8 +2279,8 @@ static int direct_pte_prefetch_many(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-void __direct_pte_prefetch(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
-			   u64 *sptep)
+static void __direct_pte_prefetch(struct kvm_vcpu *vcpu,
+				  struct kvm_mmu_page *sp, u64 *sptep)
 {
 	u64 *spte, *start = NULL;
 	int i;
@@ -2800,7 +2816,7 @@ int get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes, int *root_level)
 	return leaf;
 }
 
-void shadow_page_table_clear_flood(struct kvm_vcpu *vcpu, gva_t addr)
+static void shadow_page_table_clear_flood(struct kvm_vcpu *vcpu, gva_t addr)
 {
 	struct kvm_shadow_walk_iterator iterator;
 	u64 spte;
diff --git a/arch/x86/kvm/mmu/shadow_mmu.h b/arch/x86/kvm/mmu/shadow_mmu.h
index 7faf8b06e68f1..9f16c4782bfbf 100644
--- a/arch/x86/kvm/mmu/shadow_mmu.h
+++ b/arch/x86/kvm/mmu/shadow_mmu.h
@@ -36,32 +36,11 @@ struct pte_list_desc {
 	u64 *sptes[PTE_LIST_EXT];
 };
 
+/* Only exported for debugfs.c. */
 unsigned int pte_list_count(struct kvm_rmap_head *rmap_head);
 
-struct kvm_shadow_walk_iterator {
-	u64 addr;
-	hpa_t shadow_addr;
-	u64 *sptep;
-	int level;
-	unsigned index;
-};
-
-#define for_each_shadow_entry_using_root(_vcpu, _root, _addr, _walker)     \
-	for (shadow_walk_init_using_root(&(_walker), (_vcpu),              \
-					 (_root), (_addr));                \
-	     shadow_walk_okay(&(_walker));			           \
-	     shadow_walk_next(&(_walker)))
-
-bool mmu_spte_update(u64 *sptep, u64 new_spte);
-void mmu_spte_clear_no_track(u64 *sptep);
-gfn_t kvm_mmu_page_get_gfn(struct kvm_mmu_page *sp, int index);
-void kvm_mmu_page_set_access(struct kvm_mmu_page *sp, int index,
-			     unsigned int access);
-
 struct kvm_rmap_head *gfn_to_rmap(gfn_t gfn, int level,
 				  const struct kvm_memory_slot *slot);
-bool rmap_can_add(struct kvm_vcpu *vcpu);
-void drop_spte(struct kvm *kvm, u64 *sptep);
 bool rmap_write_protect(struct kvm_rmap_head *rmap_head, bool pt_protect);
 bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			const struct kvm_memory_slot *slot);
@@ -85,30 +64,8 @@ bool kvm_test_age_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 		       struct kvm_memory_slot *slot, gfn_t gfn,
 		       int level, pte_t unused);
 
-void drop_parent_pte(struct kvm_mmu_page *sp, u64 *parent_pte);
-int mmu_sync_children(struct kvm_vcpu *vcpu, struct kvm_mmu_page *parent,
-		      bool can_yield);
 void __clear_sp_write_flooding_count(struct kvm_mmu_page *sp);
-void clear_sp_write_flooding_count(u64 *spte);
-
-struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu, u64 *sptep,
-					  gfn_t gfn, bool direct,
-					  unsigned int access);
-
-void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterator,
-				 struct kvm_vcpu *vcpu, hpa_t root, u64 addr);
-void shadow_walk_init(struct kvm_shadow_walk_iterator *iterator,
-		      struct kvm_vcpu *vcpu, u64 addr);
-bool shadow_walk_okay(struct kvm_shadow_walk_iterator *iterator);
-void shadow_walk_next(struct kvm_shadow_walk_iterator *iterator);
-
-void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep, struct kvm_mmu_page *sp);
-
-void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
-			  unsigned direct_access);
 
-int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp, u64 *spte,
-		     struct list_head *invalid_list);
 bool __kvm_mmu_prepare_zap_page(struct kvm *kvm, struct kvm_mmu_page *sp,
 				struct list_head *invalid_list,
 				int *nr_zapped);
@@ -120,11 +77,6 @@ int make_mmu_pages_available(struct kvm_vcpu *vcpu);
 
 int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva);
 
-int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
-		 u64 *sptep, unsigned int pte_access, gfn_t gfn,
-		 kvm_pfn_t pfn, struct kvm_page_fault *fault);
-void __direct_pte_prefetch(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
-			   u64 *sptep);
 int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
 u64 *fast_pf_get_last_sptep(struct kvm_vcpu *vcpu, gpa_t gpa, u64 *spte);
 
@@ -134,7 +86,6 @@ int mmu_alloc_special_roots(struct kvm_vcpu *vcpu);
 
 int get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes, int *root_level);
 
-void shadow_page_table_clear_flood(struct kvm_vcpu *vcpu, gva_t addr);
 void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
 		       int bytes, struct kvm_page_track_notifier_node *node);
 
-- 
2.39.1.519.gcb327c4b5f-goog

