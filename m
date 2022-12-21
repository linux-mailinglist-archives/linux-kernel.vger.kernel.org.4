Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415B8653885
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiLUWYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiLUWYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:24:31 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4A52715F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:24:27 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id pm5-20020a17090b3c4500b00219864a46f0so7490807pjb.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jqx+xXNPXyPMfyXZCg/z/s6ey1PJTXuwDa7ZZcqNa58=;
        b=FN9cvFaFQ0lDrnMfZlJ4Nw5QOVw0uGnDqGaQknumVRuppyrWoDHSBVuz6NL4ToY0RS
         9vOuxkJ3/AofaX1iRjfpMBpMgUldPva9VTuxI+GzgvG3hUFpmFSghYUy2sJIfS9ttwfI
         XGhvxESKye6WvJLOGBgDYOxoD6CLBGJe+6xT4rDQG52AH4WnFl9PGc3AFw28vZayBBBn
         j9feajSJ2epeUE/GkU2rquziJiIxC8vdf+fWfieOmBNDpJ3ddN06FuqeOipY9Sg3aDoz
         XwJks6viAmjyebvL5gq7BHgmgh1daETNoQf/LVxOK/ho3WPukaLII5DxvdsU1/MnZ2Ma
         QC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqx+xXNPXyPMfyXZCg/z/s6ey1PJTXuwDa7ZZcqNa58=;
        b=Eg8qZe86sz82txRsI9fFukjQmWUn+Ebs5pt4cy6fSXju7FBeGRMJB919xa7m/dOy/M
         kN6aDfaNjxrcALC4fXwDGq2RUiTBl97mgtBHvTe3SVeZsA8oy6qOc1AS7Uj7siG0oX0R
         m5v/HXG9j8rwghbw6Btsbowxxghtu6dF/LG2RinX42B5c8gdN/GkeD+FIyV6qT6w/khN
         udsyWxxqMd4TWB3y4iVGASqcAN+uooGwQ24hKDRE7iPs3S1Kgie6E8aVU8dKID+7D3P2
         9+8INMZof+lV57NIDSZtoPzahU9F5IVPbtN27jYo73YvHjeVIqaNXML0Ttyf2h5V3kKE
         VZjg==
X-Gm-Message-State: AFqh2kr82DhwZbCsYZkcGJHdprSiQiaHBrNQfM5X+U5zQmWGsdjzB4hD
        hWoyTTQLiXJa6AHTX2HzhS0JEelcKvtUNGKRfWq/b0sxB1EUUQozo9pic0kmdu0+wl/Yw+3LWBl
        pLGMM6Z7E2D20dPyf0tx1bJnlFBI6ox4i0CoW6GzyPXIgPHxTl0zpmBfSuO4w/ilniASghnrW
X-Google-Smtp-Source: AMrXdXsRwELtCVcDYIn4WVp/1zYTUgL46D9BaMXeMR1iG/pgNUJALjlkFjzJzRBFAXoZE1p6DcmlbK9DkiNE
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:90a:4b03:b0:224:c5cb:ce1b with SMTP id
 g3-20020a17090a4b0300b00224c5cbce1bmr308212pjh.209.1671661467110; Wed, 21 Dec
 2022 14:24:27 -0800 (PST)
Date:   Wed, 21 Dec 2022 22:24:07 +0000
In-Reply-To: <20221221222418.3307832-1-bgardon@google.com>
Mime-Version: 1.0
References: <20221221222418.3307832-1-bgardon@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221221222418.3307832-4-bgardon@google.com>
Subject: [RFC 03/14] KVM: x86/MMU: Move the Shadow MMU implementation to shadow_mmu.c
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Nagareddy Reddy <nspreddy@google.com>,
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

Cut and paste the implementation of the Shadow MMU to shadow_mmu.(c|h).
This is a monsterously large commit, moving ~3500 lines. With such a
large move, there's no way to make it easy. Do the move in one massive
step to simplify dealing with merge conflicts and to make the git
history a little easier to dig through. Several cleanup commits follow
this one rather than preceed it so that their git history will remain
easy to see.

No functional change intended.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/debugfs.c          |    1 +
 arch/x86/kvm/mmu/mmu.c          | 4526 ++++---------------------------
 arch/x86/kvm/mmu/mmu_internal.h |    4 +-
 arch/x86/kvm/mmu/shadow_mmu.c   | 3408 +++++++++++++++++++++++
 arch/x86/kvm/mmu/shadow_mmu.h   |  145 +
 5 files changed, 4086 insertions(+), 3998 deletions(-)

diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index c1390357126a..e304243d2041 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -9,6 +9,7 @@
 #include "lapic.h"
 #include "mmu.h"
 #include "mmu/mmu_internal.h"
+#include "mmu/shadow_mmu.h"
 
 static int vcpu_get_timer_advance_ns(void *data, u64 *val)
 {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 729a2799d4d7..bf14e181eb12 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -109,59 +109,12 @@ bool dbg = 0;
 module_param(dbg, bool, 0644);
 #endif
 
-#define PTE_PREFETCH_NUM		8
-
 #include <trace/events/kvm.h>
 
-/* make pte_list_desc fit well in cache lines */
-#define PTE_LIST_EXT 14
-
-/*
- * Slight optimization of cacheline layout, by putting `more' and `spte_count'
- * at the start; then accessing it will only use one single cacheline for
- * either full (entries==PTE_LIST_EXT) case or entries<=6.
- */
-struct pte_list_desc {
-	struct pte_list_desc *more;
-	/*
-	 * Stores number of entries stored in the pte_list_desc.  No need to be
-	 * u64 but just for easier alignment.  When PTE_LIST_EXT, means full.
-	 */
-	u64 spte_count;
-	u64 *sptes[PTE_LIST_EXT];
-};
-
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
-#define for_each_shadow_entry(_vcpu, _addr, _walker)            \
-	for (shadow_walk_init(&(_walker), _vcpu, _addr);	\
-	     shadow_walk_okay(&(_walker));			\
-	     shadow_walk_next(&(_walker)))
-
-#define for_each_shadow_entry_lockless(_vcpu, _addr, _walker, spte)	\
-	for (shadow_walk_init(&(_walker), _vcpu, _addr);		\
-	     shadow_walk_okay(&(_walker)) &&				\
-		({ spte = mmu_spte_get_lockless(_walker.sptep); 1; });	\
-	     __shadow_walk_next(&(_walker), spte))
-
 struct kmem_cache *pte_list_desc_cache;
 struct kmem_cache *mmu_page_header_cache;
 struct percpu_counter kvm_total_used_mmu_pages;
 
-static void mmu_spte_set(u64 *sptep, u64 spte);
-
 struct kvm_mmu_role_regs {
 	const unsigned long cr0;
 	const unsigned long cr4;
@@ -257,15 +210,6 @@ void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 	kvm_flush_remote_tlbs_with_range(kvm, &range);
 }
 
-void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
-		    unsigned int access)
-{
-	u64 spte = make_mmio_spte(vcpu, gfn, access);
-
-	trace_mark_mmio_spte(sptep, gfn, spte);
-	mmu_spte_set(sptep, spte);
-}
-
 static gfn_t get_mmio_spte_gfn(u64 spte)
 {
 	u64 gpa = spte & shadow_nonpresent_or_rsvd_lower_gfn_mask;
@@ -301,310 +245,6 @@ static int is_cpuid_PSE36(void)
 	return 1;
 }
 
-#ifdef CONFIG_X86_64
-static void __set_spte(u64 *sptep, u64 spte)
-{
-	WRITE_ONCE(*sptep, spte);
-}
-
-static void __update_clear_spte_fast(u64 *sptep, u64 spte)
-{
-	WRITE_ONCE(*sptep, spte);
-}
-
-static u64 __update_clear_spte_slow(u64 *sptep, u64 spte)
-{
-	return xchg(sptep, spte);
-}
-
-static u64 __get_spte_lockless(u64 *sptep)
-{
-	return READ_ONCE(*sptep);
-}
-#else
-union split_spte {
-	struct {
-		u32 spte_low;
-		u32 spte_high;
-	};
-	u64 spte;
-};
-
-static void count_spte_clear(u64 *sptep, u64 spte)
-{
-	struct kvm_mmu_page *sp =  sptep_to_sp(sptep);
-
-	if (is_shadow_present_pte(spte))
-		return;
-
-	/* Ensure the spte is completely set before we increase the count */
-	smp_wmb();
-	sp->clear_spte_count++;
-}
-
-static void __set_spte(u64 *sptep, u64 spte)
-{
-	union split_spte *ssptep, sspte;
-
-	ssptep = (union split_spte *)sptep;
-	sspte = (union split_spte)spte;
-
-	ssptep->spte_high = sspte.spte_high;
-
-	/*
-	 * If we map the spte from nonpresent to present, We should store
-	 * the high bits firstly, then set present bit, so cpu can not
-	 * fetch this spte while we are setting the spte.
-	 */
-	smp_wmb();
-
-	WRITE_ONCE(ssptep->spte_low, sspte.spte_low);
-}
-
-static void __update_clear_spte_fast(u64 *sptep, u64 spte)
-{
-	union split_spte *ssptep, sspte;
-
-	ssptep = (union split_spte *)sptep;
-	sspte = (union split_spte)spte;
-
-	WRITE_ONCE(ssptep->spte_low, sspte.spte_low);
-
-	/*
-	 * If we map the spte from present to nonpresent, we should clear
-	 * present bit firstly to avoid vcpu fetch the old high bits.
-	 */
-	smp_wmb();
-
-	ssptep->spte_high = sspte.spte_high;
-	count_spte_clear(sptep, spte);
-}
-
-static u64 __update_clear_spte_slow(u64 *sptep, u64 spte)
-{
-	union split_spte *ssptep, sspte, orig;
-
-	ssptep = (union split_spte *)sptep;
-	sspte = (union split_spte)spte;
-
-	/* xchg acts as a barrier before the setting of the high bits */
-	orig.spte_low = xchg(&ssptep->spte_low, sspte.spte_low);
-	orig.spte_high = ssptep->spte_high;
-	ssptep->spte_high = sspte.spte_high;
-	count_spte_clear(sptep, spte);
-
-	return orig.spte;
-}
-
-/*
- * The idea using the light way get the spte on x86_32 guest is from
- * gup_get_pte (mm/gup.c).
- *
- * An spte tlb flush may be pending, because kvm_set_pte_rmap
- * coalesces them and we are running out of the MMU lock.  Therefore
- * we need to protect against in-progress updates of the spte.
- *
- * Reading the spte while an update is in progress may get the old value
- * for the high part of the spte.  The race is fine for a present->non-present
- * change (because the high part of the spte is ignored for non-present spte),
- * but for a present->present change we must reread the spte.
- *
- * All such changes are done in two steps (present->non-present and
- * non-present->present), hence it is enough to count the number of
- * present->non-present updates: if it changed while reading the spte,
- * we might have hit the race.  This is done using clear_spte_count.
- */
-static u64 __get_spte_lockless(u64 *sptep)
-{
-	struct kvm_mmu_page *sp =  sptep_to_sp(sptep);
-	union split_spte spte, *orig = (union split_spte *)sptep;
-	int count;
-
-retry:
-	count = sp->clear_spte_count;
-	smp_rmb();
-
-	spte.spte_low = orig->spte_low;
-	smp_rmb();
-
-	spte.spte_high = orig->spte_high;
-	smp_rmb();
-
-	if (unlikely(spte.spte_low != orig->spte_low ||
-	      count != sp->clear_spte_count))
-		goto retry;
-
-	return spte.spte;
-}
-#endif
-
-/* Rules for using mmu_spte_set:
- * Set the sptep from nonpresent to present.
- * Note: the sptep being assigned *must* be either not present
- * or in a state where the hardware will not attempt to update
- * the spte.
- */
-static void mmu_spte_set(u64 *sptep, u64 new_spte)
-{
-	WARN_ON(is_shadow_present_pte(*sptep));
-	__set_spte(sptep, new_spte);
-}
-
-/*
- * Update the SPTE (excluding the PFN), but do not track changes in its
- * accessed/dirty status.
- */
-static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
-{
-	u64 old_spte = *sptep;
-
-	WARN_ON(!is_shadow_present_pte(new_spte));
-	check_spte_writable_invariants(new_spte);
-
-	if (!is_shadow_present_pte(old_spte)) {
-		mmu_spte_set(sptep, new_spte);
-		return old_spte;
-	}
-
-	if (!spte_has_volatile_bits(old_spte))
-		__update_clear_spte_fast(sptep, new_spte);
-	else
-		old_spte = __update_clear_spte_slow(sptep, new_spte);
-
-	WARN_ON(spte_to_pfn(old_spte) != spte_to_pfn(new_spte));
-
-	return old_spte;
-}
-
-/* Rules for using mmu_spte_update:
- * Update the state bits, it means the mapped pfn is not changed.
- *
- * Whenever an MMU-writable SPTE is overwritten with a read-only SPTE, remote
- * TLBs must be flushed. Otherwise rmap_write_protect will find a read-only
- * spte, even though the writable spte might be cached on a CPU's TLB.
- *
- * Returns true if the TLB needs to be flushed
- */
-static bool mmu_spte_update(u64 *sptep, u64 new_spte)
-{
-	bool flush = false;
-	u64 old_spte = mmu_spte_update_no_track(sptep, new_spte);
-
-	if (!is_shadow_present_pte(old_spte))
-		return false;
-
-	/*
-	 * For the spte updated out of mmu-lock is safe, since
-	 * we always atomically update it, see the comments in
-	 * spte_has_volatile_bits().
-	 */
-	if (is_mmu_writable_spte(old_spte) &&
-	      !is_writable_pte(new_spte))
-		flush = true;
-
-	/*
-	 * Flush TLB when accessed/dirty states are changed in the page tables,
-	 * to guarantee consistency between TLB and page tables.
-	 */
-
-	if (is_accessed_spte(old_spte) && !is_accessed_spte(new_spte)) {
-		flush = true;
-		kvm_set_pfn_accessed(spte_to_pfn(old_spte));
-	}
-
-	if (is_dirty_spte(old_spte) && !is_dirty_spte(new_spte)) {
-		flush = true;
-		kvm_set_pfn_dirty(spte_to_pfn(old_spte));
-	}
-
-	return flush;
-}
-
-/*
- * Rules for using mmu_spte_clear_track_bits:
- * It sets the sptep from present to nonpresent, and track the
- * state bits, it is used to clear the last level sptep.
- * Returns the old PTE.
- */
-static u64 mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
-{
-	kvm_pfn_t pfn;
-	u64 old_spte = *sptep;
-	int level = sptep_to_sp(sptep)->role.level;
-	struct page *page;
-
-	if (!is_shadow_present_pte(old_spte) ||
-	    !spte_has_volatile_bits(old_spte))
-		__update_clear_spte_fast(sptep, 0ull);
-	else
-		old_spte = __update_clear_spte_slow(sptep, 0ull);
-
-	if (!is_shadow_present_pte(old_spte))
-		return old_spte;
-
-	kvm_update_page_stats(kvm, level, -1);
-
-	pfn = spte_to_pfn(old_spte);
-
-	/*
-	 * KVM doesn't hold a reference to any pages mapped into the guest, and
-	 * instead uses the mmu_notifier to ensure that KVM unmaps any pages
-	 * before they are reclaimed.  Sanity check that, if the pfn is backed
-	 * by a refcounted page, the refcount is elevated.
-	 */
-	page = kvm_pfn_to_refcounted_page(pfn);
-	WARN_ON(page && !page_count(page));
-
-	if (is_accessed_spte(old_spte))
-		kvm_set_pfn_accessed(pfn);
-
-	if (is_dirty_spte(old_spte))
-		kvm_set_pfn_dirty(pfn);
-
-	return old_spte;
-}
-
-/*
- * Rules for using mmu_spte_clear_no_track:
- * Directly clear spte without caring the state bits of sptep,
- * it is used to set the upper level spte.
- */
-static void mmu_spte_clear_no_track(u64 *sptep)
-{
-	__update_clear_spte_fast(sptep, 0ull);
-}
-
-static u64 mmu_spte_get_lockless(u64 *sptep)
-{
-	return __get_spte_lockless(sptep);
-}
-
-/* Returns the Accessed status of the PTE and resets it at the same time. */
-static bool mmu_spte_age(u64 *sptep)
-{
-	u64 spte = mmu_spte_get_lockless(sptep);
-
-	if (!is_accessed_spte(spte))
-		return false;
-
-	if (spte_ad_enabled(spte)) {
-		clear_bit((ffs(shadow_accessed_mask) - 1),
-			  (unsigned long *)sptep);
-	} else {
-		/*
-		 * Capture the dirty status of the page, so that it doesn't get
-		 * lost when the SPTE is marked for access tracking.
-		 */
-		if (is_writable_pte(spte))
-			kvm_set_pfn_dirty(spte_to_pfn(spte));
-
-		spte = mark_spte_for_access_track(spte);
-		mmu_spte_update_no_track(sptep, spte);
-	}
-
-	return true;
-}
-
 void walk_shadow_page_lockless_begin(struct kvm_vcpu *vcpu)
 {
 	if (is_tdp_mmu(vcpu->arch.mmu)) {
@@ -670,77 +310,6 @@ static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_header_cache);
 }
 
-static void mmu_free_pte_list_desc(struct pte_list_desc *pte_list_desc)
-{
-	kmem_cache_free(pte_list_desc_cache, pte_list_desc);
-}
-
-static bool sp_has_gptes(struct kvm_mmu_page *sp);
-
-static gfn_t kvm_mmu_page_get_gfn(struct kvm_mmu_page *sp, int index)
-{
-	if (sp->role.passthrough)
-		return sp->gfn;
-
-	if (!sp->role.direct)
-		return sp->shadowed_translation[index] >> PAGE_SHIFT;
-
-	return sp->gfn + (index << ((sp->role.level - 1) * SPTE_LEVEL_BITS));
-}
-
-/*
- * For leaf SPTEs, fetch the *guest* access permissions being shadowed. Note
- * that the SPTE itself may have a more constrained access permissions that
- * what the guest enforces. For example, a guest may create an executable
- * huge PTE but KVM may disallow execution to mitigate iTLB multihit.
- */
-static u32 kvm_mmu_page_get_access(struct kvm_mmu_page *sp, int index)
-{
-	if (sp_has_gptes(sp))
-		return sp->shadowed_translation[index] & ACC_ALL;
-
-	/*
-	 * For direct MMUs (e.g. TDP or non-paging guests) or passthrough SPs,
-	 * KVM is not shadowing any guest page tables, so the "guest access
-	 * permissions" are just ACC_ALL.
-	 *
-	 * For direct SPs in indirect MMUs (shadow paging), i.e. when KVM
-	 * is shadowing a guest huge page with small pages, the guest access
-	 * permissions being shadowed are the access permissions of the huge
-	 * page.
-	 *
-	 * In both cases, sp->role.access contains the correct access bits.
-	 */
-	return sp->role.access;
-}
-
-static void kvm_mmu_page_set_translation(struct kvm_mmu_page *sp, int index,
-					 gfn_t gfn, unsigned int access)
-{
-	if (sp_has_gptes(sp)) {
-		sp->shadowed_translation[index] = (gfn << PAGE_SHIFT) | access;
-		return;
-	}
-
-	WARN_ONCE(access != kvm_mmu_page_get_access(sp, index),
-	          "access mismatch under %s page %llx (expected %u, got %u)\n",
-	          sp->role.passthrough ? "passthrough" : "direct",
-	          sp->gfn, kvm_mmu_page_get_access(sp, index), access);
-
-	WARN_ONCE(gfn != kvm_mmu_page_get_gfn(sp, index),
-	          "gfn mismatch under %s page %llx (expected %llx, got %llx)\n",
-	          sp->role.passthrough ? "passthrough" : "direct",
-	          sp->gfn, kvm_mmu_page_get_gfn(sp, index), gfn);
-}
-
-static void kvm_mmu_page_set_access(struct kvm_mmu_page *sp, int index,
-				    unsigned int access)
-{
-	gfn_t gfn = kvm_mmu_page_get_gfn(sp, index);
-
-	kvm_mmu_page_set_translation(sp, index, gfn, access);
-}
-
 /*
  * Return the pointer to the large page information for a given gfn,
  * handling slots that are not large page aligned.
@@ -777,28 +346,6 @@ void kvm_mmu_gfn_allow_lpage(const struct kvm_memory_slot *slot, gfn_t gfn)
 	update_gfn_disallow_lpage_count(slot, gfn, -1);
 }
 
-static void account_shadowed(struct kvm *kvm, struct kvm_mmu_page *sp)
-{
-	struct kvm_memslots *slots;
-	struct kvm_memory_slot *slot;
-	gfn_t gfn;
-
-	kvm->arch.indirect_shadow_pages++;
-	gfn = sp->gfn;
-	slots = kvm_memslots_for_spte_role(kvm, sp->role);
-	slot = __gfn_to_memslot(slots, gfn);
-
-	/* the non-leaf shadow pages are keeping readonly. */
-	if (sp->role.level > PG_LEVEL_4K)
-		return kvm_slot_page_track_add_page(kvm, slot, gfn,
-						    KVM_PAGE_TRACK_WRITE);
-
-	kvm_mmu_gfn_disallow_lpage(slot, gfn);
-
-	if (kvm_mmu_slot_gfn_write_protect(kvm, slot, gfn, PG_LEVEL_4K))
-		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
-}
-
 void track_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	/*
@@ -826,23 +373,6 @@ void account_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
 		track_possible_nx_huge_page(kvm, sp);
 }
 
-static void unaccount_shadowed(struct kvm *kvm, struct kvm_mmu_page *sp)
-{
-	struct kvm_memslots *slots;
-	struct kvm_memory_slot *slot;
-	gfn_t gfn;
-
-	kvm->arch.indirect_shadow_pages--;
-	gfn = sp->gfn;
-	slots = kvm_memslots_for_spte_role(kvm, sp->role);
-	slot = __gfn_to_memslot(slots, gfn);
-	if (sp->role.level > PG_LEVEL_4K)
-		return kvm_slot_page_track_remove_page(kvm, slot, gfn,
-						       KVM_PAGE_TRACK_WRITE);
-
-	kvm_mmu_gfn_allow_lpage(slot, gfn);
-}
-
 void untrack_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	if (list_empty(&sp->possible_nx_huge_page_link))
@@ -873,437 +403,51 @@ struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu,
 	return slot;
 }
 
-/*
- * About rmap_head encoding:
+/**
+ * kvm_mmu_write_protect_pt_masked - write protect selected PT level pages
+ * @kvm: kvm instance
+ * @slot: slot to protect
+ * @gfn_offset: start of the BITS_PER_LONG pages we care about
+ * @mask: indicates which pages we should protect
  *
- * If the bit zero of rmap_head->val is clear, then it points to the only spte
- * in this rmap chain. Otherwise, (rmap_head->val & ~1) points to a struct
- * pte_list_desc containing more mappings.
- */
-
-/*
- * Returns the number of pointers in the rmap chain, not counting the new one.
+ * Used when we do not need to care about huge page mappings.
  */
-static int pte_list_add(struct kvm_mmu_memory_cache *cache, u64 *spte,
-			struct kvm_rmap_head *rmap_head)
-{
-	struct pte_list_desc *desc;
-	int count = 0;
-
-	if (!rmap_head->val) {
-		rmap_printk("%p %llx 0->1\n", spte, *spte);
-		rmap_head->val = (unsigned long)spte;
-	} else if (!(rmap_head->val & 1)) {
-		rmap_printk("%p %llx 1->many\n", spte, *spte);
-		desc = kvm_mmu_memory_cache_alloc(cache);
-		desc->sptes[0] = (u64 *)rmap_head->val;
-		desc->sptes[1] = spte;
-		desc->spte_count = 2;
-		rmap_head->val = (unsigned long)desc | 1;
-		++count;
-	} else {
-		rmap_printk("%p %llx many->many\n", spte, *spte);
-		desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
-		while (desc->spte_count == PTE_LIST_EXT) {
-			count += PTE_LIST_EXT;
-			if (!desc->more) {
-				desc->more = kvm_mmu_memory_cache_alloc(cache);
-				desc = desc->more;
-				desc->spte_count = 0;
-				break;
-			}
-			desc = desc->more;
-		}
-		count += desc->spte_count;
-		desc->sptes[desc->spte_count++] = spte;
-	}
-	return count;
-}
-
-static void
-pte_list_desc_remove_entry(struct kvm_rmap_head *rmap_head,
-			   struct pte_list_desc *desc, int i,
-			   struct pte_list_desc *prev_desc)
+static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
+				     struct kvm_memory_slot *slot,
+				     gfn_t gfn_offset, unsigned long mask)
 {
-	int j = desc->spte_count - 1;
+	struct kvm_rmap_head *rmap_head;
+
+	if (is_tdp_mmu_enabled(kvm))
+		kvm_tdp_mmu_clear_dirty_pt_masked(kvm, slot,
+				slot->base_gfn + gfn_offset, mask, true);
 
-	desc->sptes[i] = desc->sptes[j];
-	desc->sptes[j] = NULL;
-	desc->spte_count--;
-	if (desc->spte_count)
+	if (!kvm_memslots_have_rmaps(kvm))
 		return;
-	if (!prev_desc && !desc->more)
-		rmap_head->val = 0;
-	else
-		if (prev_desc)
-			prev_desc->more = desc->more;
-		else
-			rmap_head->val = (unsigned long)desc->more | 1;
-	mmu_free_pte_list_desc(desc);
-}
 
-static void pte_list_remove(u64 *spte, struct kvm_rmap_head *rmap_head)
-{
-	struct pte_list_desc *desc;
-	struct pte_list_desc *prev_desc;
-	int i;
+	while (mask) {
+		rmap_head = gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
+					PG_LEVEL_4K, slot);
+		rmap_write_protect(rmap_head, false);
 
-	if (!rmap_head->val) {
-		pr_err("%s: %p 0->BUG\n", __func__, spte);
-		BUG();
-	} else if (!(rmap_head->val & 1)) {
-		rmap_printk("%p 1->0\n", spte);
-		if ((u64 *)rmap_head->val != spte) {
-			pr_err("%s:  %p 1->BUG\n", __func__, spte);
-			BUG();
-		}
-		rmap_head->val = 0;
-	} else {
-		rmap_printk("%p many->many\n", spte);
-		desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
-		prev_desc = NULL;
-		while (desc) {
-			for (i = 0; i < desc->spte_count; ++i) {
-				if (desc->sptes[i] == spte) {
-					pte_list_desc_remove_entry(rmap_head,
-							desc, i, prev_desc);
-					return;
-				}
-			}
-			prev_desc = desc;
-			desc = desc->more;
-		}
-		pr_err("%s: %p many->many\n", __func__, spte);
-		BUG();
+		/* clear the first set bit */
+		mask &= mask - 1;
 	}
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
-		mmu_free_pte_list_desc(desc);
-	}
-out:
-	/* rmap_head is meaningless now, remember to reset it */
-	rmap_head->val = 0;
-	return true;
-}
-
-unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
-{
-	struct pte_list_desc *desc;
-	unsigned int count = 0;
-
-	if (!rmap_head->val)
-		return 0;
-	else if (!(rmap_head->val & 1))
-		return 1;
-
-	desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
-
-	while (desc) {
-		count += desc->spte_count;
-		desc = desc->more;
-	}
-
-	return count;
-}
-
-static struct kvm_rmap_head *gfn_to_rmap(gfn_t gfn, int level,
-					 const struct kvm_memory_slot *slot)
-{
-	unsigned long idx;
-
-	idx = gfn_to_index(gfn, slot->base_gfn, level);
-	return &slot->arch.rmap[level - PG_LEVEL_4K][idx];
-}
-
-static bool rmap_can_add(struct kvm_vcpu *vcpu)
-{
-	struct kvm_mmu_memory_cache *mc;
-
-	mc = &vcpu->arch.mmu_pte_list_desc_cache;
-	return kvm_mmu_memory_cache_nr_free_objects(mc);
-}
-
-static void rmap_remove(struct kvm *kvm, u64 *spte)
-{
-	struct kvm_memslots *slots;
-	struct kvm_memory_slot *slot;
-	struct kvm_mmu_page *sp;
-	gfn_t gfn;
-	struct kvm_rmap_head *rmap_head;
-
-	sp = sptep_to_sp(spte);
-	gfn = kvm_mmu_page_get_gfn(sp, spte_index(spte));
-
-	/*
-	 * Unlike rmap_add, rmap_remove does not run in the context of a vCPU
-	 * so we have to determine which memslots to use based on context
-	 * information in sp->role.
-	 */
-	slots = kvm_memslots_for_spte_role(kvm, sp->role);
-
-	slot = __gfn_to_memslot(slots, gfn);
-	rmap_head = gfn_to_rmap(gfn, sp->role.level, slot);
-
-	pte_list_remove(spte, rmap_head);
-}
-
-/*
- * Used by the following functions to iterate through the sptes linked by a
- * rmap.  All fields are private and not assumed to be used outside.
- */
-struct rmap_iterator {
-	/* private fields */
-	struct pte_list_desc *desc;	/* holds the sptep if not NULL */
-	int pos;			/* index of the sptep */
-};
-
-/*
- * Iteration must be started by this function.  This should also be used after
- * removing/dropping sptes from the rmap link because in such cases the
- * information in the iterator may not be valid.
- *
- * Returns sptep if found, NULL otherwise.
- */
-static u64 *rmap_get_first(struct kvm_rmap_head *rmap_head,
-			   struct rmap_iterator *iter)
-{
-	u64 *sptep;
-
-	if (!rmap_head->val)
-		return NULL;
-
-	if (!(rmap_head->val & 1)) {
-		iter->desc = NULL;
-		sptep = (u64 *)rmap_head->val;
-		goto out;
-	}
-
-	iter->desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
-	iter->pos = 0;
-	sptep = iter->desc->sptes[iter->pos];
-out:
-	BUG_ON(!is_shadow_present_pte(*sptep));
-	return sptep;
-}
-
-/*
- * Must be used with a valid iterator: e.g. after rmap_get_first().
- *
- * Returns sptep if found, NULL otherwise.
- */
-static u64 *rmap_get_next(struct rmap_iterator *iter)
-{
-	u64 *sptep;
-
-	if (iter->desc) {
-		if (iter->pos < PTE_LIST_EXT - 1) {
-			++iter->pos;
-			sptep = iter->desc->sptes[iter->pos];
-			if (sptep)
-				goto out;
-		}
-
-		iter->desc = iter->desc->more;
-
-		if (iter->desc) {
-			iter->pos = 0;
-			/* desc->sptes[0] cannot be NULL */
-			sptep = iter->desc->sptes[iter->pos];
-			goto out;
-		}
-	}
-
-	return NULL;
-out:
-	BUG_ON(!is_shadow_present_pte(*sptep));
-	return sptep;
-}
-
-#define for_each_rmap_spte(_rmap_head_, _iter_, _spte_)			\
-	for (_spte_ = rmap_get_first(_rmap_head_, _iter_);		\
-	     _spte_; _spte_ = rmap_get_next(_iter_))
-
-static void drop_spte(struct kvm *kvm, u64 *sptep)
-{
-	u64 old_spte = mmu_spte_clear_track_bits(kvm, sptep);
-
-	if (is_shadow_present_pte(old_spte))
-		rmap_remove(kvm, sptep);
-}
-
-static void drop_large_spte(struct kvm *kvm, u64 *sptep, bool flush)
-{
-	struct kvm_mmu_page *sp;
-
-	sp = sptep_to_sp(sptep);
-	WARN_ON(sp->role.level == PG_LEVEL_4K);
-
-	drop_spte(kvm, sptep);
-
-	if (flush)
-		kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
-			KVM_PAGES_PER_HPAGE(sp->role.level));
-}
-
-/*
- * Write-protect on the specified @sptep, @pt_protect indicates whether
- * spte write-protection is caused by protecting shadow page table.
- *
- * Note: write protection is difference between dirty logging and spte
- * protection:
- * - for dirty logging, the spte can be set to writable at anytime if
- *   its dirty bitmap is properly set.
- * - for spte protection, the spte can be writable only after unsync-ing
- *   shadow page.
- *
- * Return true if tlb need be flushed.
- */
-static bool spte_write_protect(u64 *sptep, bool pt_protect)
-{
-	u64 spte = *sptep;
-
-	if (!is_writable_pte(spte) &&
-	    !(pt_protect && is_mmu_writable_spte(spte)))
-		return false;
-
-	rmap_printk("spte %p %llx\n", sptep, *sptep);
-
-	if (pt_protect)
-		spte &= ~shadow_mmu_writable_mask;
-	spte = spte & ~PT_WRITABLE_MASK;
-
-	return mmu_spte_update(sptep, spte);
-}
-
-static bool rmap_write_protect(struct kvm_rmap_head *rmap_head,
-			       bool pt_protect)
-{
-	u64 *sptep;
-	struct rmap_iterator iter;
-	bool flush = false;
-
-	for_each_rmap_spte(rmap_head, &iter, sptep)
-		flush |= spte_write_protect(sptep, pt_protect);
-
-	return flush;
-}
-
-static bool spte_clear_dirty(u64 *sptep)
-{
-	u64 spte = *sptep;
-
-	rmap_printk("spte %p %llx\n", sptep, *sptep);
-
-	MMU_WARN_ON(!spte_ad_enabled(spte));
-	spte &= ~shadow_dirty_mask;
-	return mmu_spte_update(sptep, spte);
-}
-
-static bool spte_wrprot_for_clear_dirty(u64 *sptep)
-{
-	bool was_writable = test_and_clear_bit(PT_WRITABLE_SHIFT,
-					       (unsigned long *)sptep);
-	if (was_writable && !spte_ad_enabled(*sptep))
-		kvm_set_pfn_dirty(spte_to_pfn(*sptep));
-
-	return was_writable;
-}
-
-/*
- * Gets the GFN ready for another round of dirty logging by clearing the
- *	- D bit on ad-enabled SPTEs, and
- *	- W bit on ad-disabled SPTEs.
- * Returns true iff any D or W bits were cleared.
- */
-static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-			       const struct kvm_memory_slot *slot)
-{
-	u64 *sptep;
-	struct rmap_iterator iter;
-	bool flush = false;
-
-	for_each_rmap_spte(rmap_head, &iter, sptep)
-		if (spte_ad_need_write_protect(*sptep))
-			flush |= spte_wrprot_for_clear_dirty(sptep);
-		else
-			flush |= spte_clear_dirty(sptep);
-
-	return flush;
-}
-
-/**
- * kvm_mmu_write_protect_pt_masked - write protect selected PT level pages
- * @kvm: kvm instance
- * @slot: slot to protect
- * @gfn_offset: start of the BITS_PER_LONG pages we care about
- * @mask: indicates which pages we should protect
- *
- * Used when we do not need to care about huge page mappings.
- */
-static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
-				     struct kvm_memory_slot *slot,
-				     gfn_t gfn_offset, unsigned long mask)
-{
-	struct kvm_rmap_head *rmap_head;
-
-	if (is_tdp_mmu_enabled(kvm))
-		kvm_tdp_mmu_clear_dirty_pt_masked(kvm, slot,
-				slot->base_gfn + gfn_offset, mask, true);
-
-	if (!kvm_memslots_have_rmaps(kvm))
-		return;
-
-	while (mask) {
-		rmap_head = gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
-					PG_LEVEL_4K, slot);
-		rmap_write_protect(rmap_head, false);
-
-		/* clear the first set bit */
-		mask &= mask - 1;
-	}
-}
-
-/**
- * kvm_mmu_clear_dirty_pt_masked - clear MMU D-bit for PT level pages, or write
- * protect the page if the D-bit isn't supported.
- * @kvm: kvm instance
- * @slot: slot to clear D-bit
- * @gfn_offset: start of the BITS_PER_LONG pages we care about
- * @mask: indicates which pages we should clear D-bit
- *
- * Used for PML to re-log the dirty GPAs after userspace querying dirty_bitmap.
- */
-static void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
-					 struct kvm_memory_slot *slot,
-					 gfn_t gfn_offset, unsigned long mask)
+/**
+ * kvm_mmu_clear_dirty_pt_masked - clear MMU D-bit for PT level pages, or write
+ * protect the page if the D-bit isn't supported.
+ * @kvm: kvm instance
+ * @slot: slot to clear D-bit
+ * @gfn_offset: start of the BITS_PER_LONG pages we care about
+ * @mask: indicates which pages we should clear D-bit
+ *
+ * Used for PML to re-log the dirty GPAs after userspace querying dirty_bitmap.
+ */
+static void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
+					 struct kvm_memory_slot *slot,
+					 gfn_t gfn_offset, unsigned long mask)
 {
 	struct kvm_rmap_head *rmap_head;
 
@@ -1405,147 +549,6 @@ bool kvm_vcpu_write_protect_gfn(struct kvm_vcpu *vcpu, u64 gfn)
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
-static bool kvm_set_pte_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-			     struct kvm_memory_slot *slot, gfn_t gfn, int level,
-			     pte_t pte)
-{
-	u64 *sptep;
-	struct rmap_iterator iter;
-	bool need_flush = false;
-	u64 new_spte;
-	kvm_pfn_t new_pfn;
-
-	WARN_ON(pte_huge(pte));
-	new_pfn = pte_pfn(pte);
-
-restart:
-	for_each_rmap_spte(rmap_head, &iter, sptep) {
-		rmap_printk("spte %p %llx gfn %llx (%d)\n",
-			    sptep, *sptep, gfn, level);
-
-		need_flush = true;
-
-		if (pte_write(pte)) {
-			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
-			goto restart;
-		} else {
-			new_spte = kvm_mmu_changed_pte_notifier_make_spte(
-					*sptep, new_pfn);
-
-			mmu_spte_clear_track_bits(kvm, sptep);
-			mmu_spte_set(sptep, new_spte);
-		}
-	}
-
-	if (need_flush && kvm_available_flush_tlb_with_range()) {
-		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
-		return false;
-	}
-
-	return need_flush;
-}
-
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
-static __always_inline bool kvm_handle_gfn_range(struct kvm *kvm,
-						 struct kvm_gfn_range *range,
-						 rmap_handler_t handler)
-{
-	struct slot_rmap_walk_iterator iterator;
-	bool ret = false;
-
-	for_each_slot_rmap_range(range->slot, PG_LEVEL_4K, KVM_MAX_HUGEPAGE_LEVEL,
-				 range->start, range->end - 1, &iterator)
-		ret |= handler(kvm, iterator.rmap, range->slot, iterator.gfn,
-			       iterator.level, range->pte);
-
-	return ret;
-}
-
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	bool flush = false;
@@ -1572,2392 +575,596 @@ bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	return flush;
 }
 
-static bool kvm_age_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-			 struct kvm_memory_slot *slot, gfn_t gfn, int level,
-			 pte_t unused)
+bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	u64 *sptep;
-	struct rmap_iterator iter;
-	int young = 0;
-
-	for_each_rmap_spte(rmap_head, &iter, sptep)
-		young |= mmu_spte_age(sptep);
+	bool young = false;
 
-	return young;
-}
+	if (kvm_memslots_have_rmaps(kvm))
+		young = kvm_handle_gfn_range(kvm, range, kvm_age_rmap);
 
-static bool kvm_test_age_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-			      struct kvm_memory_slot *slot, gfn_t gfn,
-			      int level, pte_t unused)
-{
-	u64 *sptep;
-	struct rmap_iterator iter;
+	if (is_tdp_mmu_enabled(kvm))
+		young |= kvm_tdp_mmu_age_gfn_range(kvm, range);
 
-	for_each_rmap_spte(rmap_head, &iter, sptep)
-		if (is_accessed_spte(*sptep))
-			return true;
-	return false;
+	return young;
 }
 
-#define RMAP_RECYCLE_THRESHOLD 1000
-
-static void __rmap_add(struct kvm *kvm,
-		       struct kvm_mmu_memory_cache *cache,
-		       const struct kvm_memory_slot *slot,
-		       u64 *spte, gfn_t gfn, unsigned int access)
+bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	struct kvm_mmu_page *sp;
-	struct kvm_rmap_head *rmap_head;
-	int rmap_count;
+	bool young = false;
 
-	sp = sptep_to_sp(spte);
-	kvm_mmu_page_set_translation(sp, spte_index(spte), gfn, access);
-	kvm_update_page_stats(kvm, sp->role.level, 1);
+	if (kvm_memslots_have_rmaps(kvm))
+		young = kvm_handle_gfn_range(kvm, range, kvm_test_age_rmap);
 
-	rmap_head = gfn_to_rmap(gfn, sp->role.level, slot);
-	rmap_count = pte_list_add(cache, spte, rmap_head);
+	if (is_tdp_mmu_enabled(kvm))
+		young |= kvm_tdp_mmu_test_age_gfn(kvm, range);
 
-	if (rmap_count > kvm->stat.max_mmu_rmap_size)
-		kvm->stat.max_mmu_rmap_size = rmap_count;
-	if (rmap_count > RMAP_RECYCLE_THRESHOLD) {
-		kvm_zap_all_rmap_sptes(kvm, rmap_head);
-		kvm_flush_remote_tlbs_with_address(
-				kvm, sp->gfn, KVM_PAGES_PER_HPAGE(sp->role.level));
-	}
+	return young;
 }
 
-static void rmap_add(struct kvm_vcpu *vcpu, const struct kvm_memory_slot *slot,
-		     u64 *spte, gfn_t gfn, unsigned int access)
+bool kvm_mmu_remote_flush_or_zap(struct kvm *kvm, struct list_head *invalid_list,
+				 bool remote_flush)
 {
-	struct kvm_mmu_memory_cache *cache = &vcpu->arch.mmu_pte_list_desc_cache;
+	if (!remote_flush && list_empty(invalid_list))
+		return false;
 
-	__rmap_add(vcpu->kvm, cache, slot, spte, gfn, access);
+	if (!list_empty(invalid_list))
+		kvm_mmu_commit_zap_page(kvm, invalid_list);
+	else
+		kvm_flush_remote_tlbs(kvm);
+	return true;
 }
 
-bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
+bool is_obsolete_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
-	bool young = false;
-
-	if (kvm_memslots_have_rmaps(kvm))
-		young = kvm_handle_gfn_range(kvm, range, kvm_age_rmap);
-
-	if (is_tdp_mmu_enabled(kvm))
-		young |= kvm_tdp_mmu_age_gfn_range(kvm, range);
+	if (sp->role.invalid)
+		return true;
 
-	return young;
+	/* TDP MMU pages do not use the MMU generation. */
+	return !sp->tdp_mmu_page &&
+	       unlikely(sp->mmu_valid_gen != kvm->arch.mmu_valid_gen);
 }
 
-bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
+/*
+ * Lookup the mapping level for @gfn in the current mm.
+ *
+ * WARNING!  Use of host_pfn_mapping_level() requires the caller and the end
+ * consumer to be tied into KVM's handlers for MMU notifier events!
+ *
+ * There are several ways to safely use this helper:
+ *
+ * - Check mmu_invalidate_retry_hva() after grabbing the mapping level, before
+ *   consuming it.  In this case, mmu_lock doesn't need to be held during the
+ *   lookup, but it does need to be held while checking the MMU notifier.
+ *
+ * - Hold mmu_lock AND ensure there is no in-progress MMU notifier invalidation
+ *   event for the hva.  This can be done by explicit checking the MMU notifier
+ *   or by ensuring that KVM already has a valid mapping that covers the hva.
+ *
+ * - Do not use the result to install new mappings, e.g. use the host mapping
+ *   level only to decide whether or not to zap an entry.  In this case, it's
+ *   not required to hold mmu_lock (though it's highly likely the caller will
+ *   want to hold mmu_lock anyways, e.g. to modify SPTEs).
+ *
+ * Note!  The lookup can still race with modifications to host page tables, but
+ * the above "rules" ensure KVM will not _consume_ the result of the walk if a
+ * race with the primary MMU occurs.
+ */
+static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
+				  const struct kvm_memory_slot *slot)
 {
-	bool young = false;
+	int level = PG_LEVEL_4K;
+	unsigned long hva;
+	unsigned long flags;
+	pgd_t pgd;
+	p4d_t p4d;
+	pud_t pud;
+	pmd_t pmd;
 
-	if (kvm_memslots_have_rmaps(kvm))
-		young = kvm_handle_gfn_range(kvm, range, kvm_test_age_rmap);
+	/*
+	 * Note, using the already-retrieved memslot and __gfn_to_hva_memslot()
+	 * is not solely for performance, it's also necessary to avoid the
+	 * "writable" check in __gfn_to_hva_many(), which will always fail on
+	 * read-only memslots due to gfn_to_hva() assuming writes.  Earlier
+	 * page fault steps have already verified the guest isn't writing a
+	 * read-only memslot.
+	 */
+	hva = __gfn_to_hva_memslot(slot, gfn);
 
-	if (is_tdp_mmu_enabled(kvm))
-		young |= kvm_tdp_mmu_test_age_gfn(kvm, range);
+	/*
+	 * Disable IRQs to prevent concurrent tear down of host page tables,
+	 * e.g. if the primary MMU promotes a P*D to a huge page and then frees
+	 * the original page table.
+	 */
+	local_irq_save(flags);
 
-	return young;
-}
+	/*
+	 * Read each entry once.  As above, a non-leaf entry can be promoted to
+	 * a huge page _during_ this walk.  Re-reading the entry could send the
+	 * walk into the weeks, e.g. p*d_large() returns false (sees the old
+	 * value) and then p*d_offset() walks into the target huge page instead
+	 * of the old page table (sees the new value).
+	 */
+	pgd = READ_ONCE(*pgd_offset(kvm->mm, hva));
+	if (pgd_none(pgd))
+		goto out;
 
-#ifdef MMU_DEBUG
-static int is_empty_shadow_page(u64 *spt)
-{
-	u64 *pos;
-	u64 *end;
+	p4d = READ_ONCE(*p4d_offset(&pgd, hva));
+	if (p4d_none(p4d) || !p4d_present(p4d))
+		goto out;
 
-	for (pos = spt, end = pos + SPTE_ENT_PER_PAGE; pos != end; pos++)
-		if (is_shadow_present_pte(*pos)) {
-			printk(KERN_ERR "%s: %p %llx\n", __func__,
-			       pos, *pos);
-			return 0;
-		}
-	return 1;
-}
-#endif
+	pud = READ_ONCE(*pud_offset(&p4d, hva));
+	if (pud_none(pud) || !pud_present(pud))
+		goto out;
 
-/*
- * This value is the sum of all of the kvm instances's
- * kvm->arch.n_used_mmu_pages values.  We need a global,
- * aggregate version in order to make the slab shrinker
- * faster
- */
-static inline void kvm_mod_used_mmu_pages(struct kvm *kvm, long nr)
-{
-	kvm->arch.n_used_mmu_pages += nr;
-	percpu_counter_add(&kvm_total_used_mmu_pages, nr);
-}
+	if (pud_large(pud)) {
+		level = PG_LEVEL_1G;
+		goto out;
+	}
 
-static void kvm_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
-{
-	kvm_mod_used_mmu_pages(kvm, +1);
-	kvm_account_pgtable_pages((void *)sp->spt, +1);
-}
+	pmd = READ_ONCE(*pmd_offset(&pud, hva));
+	if (pmd_none(pmd) || !pmd_present(pmd))
+		goto out;
 
-static void kvm_unaccount_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
-{
-	kvm_mod_used_mmu_pages(kvm, -1);
-	kvm_account_pgtable_pages((void *)sp->spt, -1);
-}
+	if (pmd_large(pmd))
+		level = PG_LEVEL_2M;
 
-static void kvm_mmu_free_shadow_page(struct kvm_mmu_page *sp)
-{
-	MMU_WARN_ON(!is_empty_shadow_page(sp->spt));
-	hlist_del(&sp->hash_link);
-	list_del(&sp->link);
-	free_page((unsigned long)sp->spt);
-	if (!sp->role.direct)
-		free_page((unsigned long)sp->shadowed_translation);
-	kmem_cache_free(mmu_page_header_cache, sp);
+out:
+	local_irq_restore(flags);
+	return level;
 }
 
-static unsigned kvm_page_table_hashfn(gfn_t gfn)
+int kvm_mmu_max_mapping_level(struct kvm *kvm,
+			      const struct kvm_memory_slot *slot, gfn_t gfn,
+			      int max_level)
 {
-	return hash_64(gfn, KVM_MMU_HASH_SHIFT);
-}
+	struct kvm_lpage_info *linfo;
+	int host_level;
 
-static void mmu_page_add_parent_pte(struct kvm_mmu_memory_cache *cache,
-				    struct kvm_mmu_page *sp, u64 *parent_pte)
-{
-	if (!parent_pte)
-		return;
+	max_level = min(max_level, max_huge_page_level);
+	for ( ; max_level > PG_LEVEL_4K; max_level--) {
+		linfo = lpage_info_slot(gfn, slot, max_level);
+		if (!linfo->disallow_lpage)
+			break;
+	}
 
-	pte_list_add(cache, parent_pte, &sp->parent_ptes);
-}
+	if (max_level == PG_LEVEL_4K)
+		return PG_LEVEL_4K;
 
-static void mmu_page_remove_parent_pte(struct kvm_mmu_page *sp,
-				       u64 *parent_pte)
-{
-	pte_list_remove(parent_pte, &sp->parent_ptes);
+	host_level = host_pfn_mapping_level(kvm, gfn, slot);
+	return min(host_level, max_level);
 }
 
-static void drop_parent_pte(struct kvm_mmu_page *sp,
-			    u64 *parent_pte)
+void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
-	mmu_page_remove_parent_pte(sp, parent_pte);
-	mmu_spte_clear_no_track(parent_pte);
-}
+	struct kvm_memory_slot *slot = fault->slot;
+	kvm_pfn_t mask;
 
-static void mark_unsync(u64 *spte);
-static void kvm_mmu_mark_parents_unsync(struct kvm_mmu_page *sp)
-{
-	u64 *sptep;
-	struct rmap_iterator iter;
+	fault->huge_page_disallowed = fault->exec && fault->nx_huge_page_workaround_enabled;
 
-	for_each_rmap_spte(&sp->parent_ptes, &iter, sptep) {
-		mark_unsync(sptep);
-	}
-}
+	if (unlikely(fault->max_level == PG_LEVEL_4K))
+		return;
 
-static void mark_unsync(u64 *spte)
-{
-	struct kvm_mmu_page *sp;
+	if (is_error_noslot_pfn(fault->pfn))
+		return;
 
-	sp = sptep_to_sp(spte);
-	if (__test_and_set_bit(spte_index(spte), sp->unsync_child_bitmap))
+	if (kvm_slot_dirty_track_enabled(slot))
 		return;
-	if (sp->unsync_children++)
+
+	/*
+	 * Enforce the iTLB multihit workaround after capturing the requested
+	 * level, which will be used to do precise, accurate accounting.
+	 */
+	fault->req_level = kvm_mmu_max_mapping_level(vcpu->kvm, slot,
+						     fault->gfn, fault->max_level);
+	if (fault->req_level == PG_LEVEL_4K || fault->huge_page_disallowed)
 		return;
-	kvm_mmu_mark_parents_unsync(sp);
-}
 
-static int nonpaging_sync_page(struct kvm_vcpu *vcpu,
-			       struct kvm_mmu_page *sp)
-{
-	return -1;
+	/*
+	 * mmu_invalidate_retry() was successful and mmu_lock is held, so
+	 * the pmd can't be split from under us.
+	 */
+	fault->goal_level = fault->req_level;
+	mask = KVM_PAGES_PER_HPAGE(fault->goal_level) - 1;
+	VM_BUG_ON((fault->gfn & mask) != (fault->pfn & mask));
+	fault->pfn &= ~mask;
 }
 
-#define KVM_PAGE_ARRAY_NR 16
-
-struct kvm_mmu_pages {
-	struct mmu_page_and_offset {
-		struct kvm_mmu_page *sp;
-		unsigned int idx;
-	} page[KVM_PAGE_ARRAY_NR];
-	unsigned int nr;
-};
-
-static int mmu_pages_add(struct kvm_mmu_pages *pvec, struct kvm_mmu_page *sp,
-			 int idx)
+void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_level)
 {
-	int i;
-
-	if (sp->unsync)
-		for (i=0; i < pvec->nr; i++)
-			if (pvec->page[i].sp == sp)
-				return 0;
-
-	pvec->page[pvec->nr].sp = sp;
-	pvec->page[pvec->nr].idx = idx;
-	pvec->nr++;
-	return (pvec->nr == KVM_PAGE_ARRAY_NR);
+	if (cur_level > PG_LEVEL_4K &&
+	    cur_level == fault->goal_level &&
+	    is_shadow_present_pte(spte) &&
+	    !is_large_pte(spte) &&
+	    spte_to_child_sp(spte)->nx_huge_page_disallowed) {
+		/*
+		 * A small SPTE exists for this pfn, but FNAME(fetch)
+		 * and __direct_map would like to create a large PTE
+		 * instead: just force them to go down another level,
+		 * patching back for them into pfn the next 9 bits of
+		 * the address.
+		 */
+		u64 page_mask = KVM_PAGES_PER_HPAGE(cur_level) -
+				KVM_PAGES_PER_HPAGE(cur_level - 1);
+		fault->pfn |= fault->gfn & page_mask;
+		fault->goal_level--;
+	}
 }
 
-static inline void clear_unsync_child_bit(struct kvm_mmu_page *sp, int idx)
+static void kvm_send_hwpoison_signal(unsigned long address, struct task_struct *tsk)
 {
-	--sp->unsync_children;
-	WARN_ON((int)sp->unsync_children < 0);
-	__clear_bit(idx, sp->unsync_child_bitmap);
+	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, PAGE_SHIFT, tsk);
 }
 
-static int __mmu_unsync_walk(struct kvm_mmu_page *sp,
-			   struct kvm_mmu_pages *pvec)
+static int kvm_handle_error_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 {
-	int i, ret, nr_unsync_leaf = 0;
-
-	for_each_set_bit(i, sp->unsync_child_bitmap, 512) {
-		struct kvm_mmu_page *child;
-		u64 ent = sp->spt[i];
+	if (is_sigpending_pfn(pfn)) {
+		kvm_handle_signal_exit(vcpu);
+		return -EINTR;
+	}
 
-		if (!is_shadow_present_pte(ent) || is_large_pte(ent)) {
-			clear_unsync_child_bit(sp, i);
-			continue;
-		}
+	/*
+	 * Do not cache the mmio info caused by writing the readonly gfn
+	 * into the spte otherwise read access on readonly gfn also can
+	 * caused mmio page fault and treat it as mmio access.
+	 */
+	if (pfn == KVM_PFN_ERR_RO_FAULT)
+		return RET_PF_EMULATE;
 
-		child = spte_to_child_sp(ent);
-
-		if (child->unsync_children) {
-			if (mmu_pages_add(pvec, child, i))
-				return -ENOSPC;
-
-			ret = __mmu_unsync_walk(child, pvec);
-			if (!ret) {
-				clear_unsync_child_bit(sp, i);
-				continue;
-			} else if (ret > 0) {
-				nr_unsync_leaf += ret;
-			} else
-				return ret;
-		} else if (child->unsync) {
-			nr_unsync_leaf++;
-			if (mmu_pages_add(pvec, child, i))
-				return -ENOSPC;
-		} else
-			clear_unsync_child_bit(sp, i);
+	if (pfn == KVM_PFN_ERR_HWPOISON) {
+		kvm_send_hwpoison_signal(kvm_vcpu_gfn_to_hva(vcpu, gfn), current);
+		return RET_PF_RETRY;
 	}
 
-	return nr_unsync_leaf;
+	return -EFAULT;
 }
 
-#define INVALID_INDEX (-1)
-
-static int mmu_unsync_walk(struct kvm_mmu_page *sp,
-			   struct kvm_mmu_pages *pvec)
+static int handle_abnormal_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
+			       unsigned int access)
 {
-	pvec->nr = 0;
-	if (!sp->unsync_children)
-		return 0;
+	/* The pfn is invalid, report the error! */
+	if (unlikely(is_error_pfn(fault->pfn)))
+		return kvm_handle_error_pfn(vcpu, fault->gfn, fault->pfn);
 
-	mmu_pages_add(pvec, sp, INVALID_INDEX);
-	return __mmu_unsync_walk(sp, pvec);
-}
+	if (unlikely(!fault->slot)) {
+		gva_t gva = fault->is_tdp ? 0 : fault->addr;
 
-static void kvm_unlink_unsync_page(struct kvm *kvm, struct kvm_mmu_page *sp)
-{
-	WARN_ON(!sp->unsync);
-	trace_kvm_mmu_sync_page(sp);
-	sp->unsync = 0;
-	--kvm->stat.mmu_unsync;
-}
+		vcpu_cache_mmio_info(vcpu, gva, fault->gfn,
+				     access & shadow_mmio_access_mask);
+		/*
+		 * If MMIO caching is disabled, emulate immediately without
+		 * touching the shadow page tables as attempting to install an
+		 * MMIO SPTE will just be an expensive nop.  Do not cache MMIO
+		 * whose gfn is greater than host.MAXPHYADDR, any guest that
+		 * generates such gfns is running nested and is being tricked
+		 * by L0 userspace (you can observe gfn > L1.MAXPHYADDR if
+		 * and only if L1's MAXPHYADDR is inaccurate with respect to
+		 * the hardware's).
+		 */
+		if (unlikely(!enable_mmio_caching) ||
+		    unlikely(fault->gfn > kvm_mmu_max_gfn()))
+			return RET_PF_EMULATE;
+	}
 
-static bool kvm_mmu_prepare_zap_page(struct kvm *kvm, struct kvm_mmu_page *sp,
-				     struct list_head *invalid_list);
-static void kvm_mmu_commit_zap_page(struct kvm *kvm,
-				    struct list_head *invalid_list);
+	return RET_PF_CONTINUE;
+}
 
-static bool sp_has_gptes(struct kvm_mmu_page *sp)
+static bool page_fault_can_be_fast(struct kvm_page_fault *fault)
 {
-	if (sp->role.direct)
-		return false;
-
-	if (sp->role.passthrough)
+	/*
+	 * Page faults with reserved bits set, i.e. faults on MMIO SPTEs, only
+	 * reach the common page fault handler if the SPTE has an invalid MMIO
+	 * generation number.  Refreshing the MMIO generation needs to go down
+	 * the slow path.  Note, EPT Misconfigs do NOT set the PRESENT flag!
+	 */
+	if (fault->rsvd)
 		return false;
 
-	return true;
-}
-
-#define for_each_valid_sp(_kvm, _sp, _list)				\
-	hlist_for_each_entry(_sp, _list, hash_link)			\
-		if (is_obsolete_sp((_kvm), (_sp))) {			\
-		} else
-
-#define for_each_gfn_valid_sp_with_gptes(_kvm, _sp, _gfn)		\
-	for_each_valid_sp(_kvm, _sp,					\
-	  &(_kvm)->arch.mmu_page_hash[kvm_page_table_hashfn(_gfn)])	\
-		if ((_sp)->gfn != (_gfn) || !sp_has_gptes(_sp)) {} else
-
-static int kvm_sync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
-			 struct list_head *invalid_list)
-{
-	int ret = vcpu->arch.mmu->sync_page(vcpu, sp);
+	/*
+	 * #PF can be fast if:
+	 *
+	 * 1. The shadow page table entry is not present and A/D bits are
+	 *    disabled _by KVM_, which could mean that the fault is potentially
+	 *    caused by access tracking (if enabled).  If A/D bits are enabled
+	 *    by KVM, but disabled by L1 for L2, KVM is forced to disable A/D
+	 *    bits for L2 and employ access tracking, but the fast page fault
+	 *    mechanism only supports direct MMUs.
+	 * 2. The shadow page table entry is present, the access is a write,
+	 *    and no reserved bits are set (MMIO SPTEs cannot be "fixed"), i.e.
+	 *    the fault was caused by a write-protection violation.  If the
+	 *    SPTE is MMU-writable (determined later), the fault can be fixed
+	 *    by setting the Writable bit, which can be done out of mmu_lock.
+	 */
+	if (!fault->present)
+		return !kvm_ad_enabled();
 
-	if (ret < 0)
-		kvm_mmu_prepare_zap_page(vcpu->kvm, sp, invalid_list);
-	return ret;
+	/*
+	 * Note, instruction fetches and writes are mutually exclusive, ignore
+	 * the "exec" flag.
+	 */
+	return fault->write;
 }
 
-bool kvm_mmu_remote_flush_or_zap(struct kvm *kvm, struct list_head *invalid_list,
-				 bool remote_flush)
+/*
+ * Returns true if the SPTE was fixed successfully. Otherwise,
+ * someone else modified the SPTE from its original value.
+ */
+static bool
+fast_pf_fix_direct_spte(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
+			u64 *sptep, u64 old_spte, u64 new_spte)
 {
-	if (!remote_flush && list_empty(invalid_list))
+	/*
+	 * Theoretically we could also set dirty bit (and flush TLB) here in
+	 * order to eliminate unnecessary PML logging. See comments in
+	 * set_spte. But fast_page_fault is very unlikely to happen with PML
+	 * enabled, so we do not do this. This might result in the same GPA
+	 * to be logged in PML buffer again when the write really happens, and
+	 * eventually to be called by mark_page_dirty twice. But it's also no
+	 * harm. This also avoids the TLB flush needed after setting dirty bit
+	 * so non-PML cases won't be impacted.
+	 *
+	 * Compare with set_spte where instead shadow_dirty_mask is set.
+	 */
+	if (!try_cmpxchg64(sptep, &old_spte, new_spte))
 		return false;
 
-	if (!list_empty(invalid_list))
-		kvm_mmu_commit_zap_page(kvm, invalid_list);
-	else
-		kvm_flush_remote_tlbs(kvm);
-	return true;
-}
-
-bool is_obsolete_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
-{
-	if (sp->role.invalid)
-		return true;
+	if (is_writable_pte(new_spte) && !is_writable_pte(old_spte))
+		mark_page_dirty_in_slot(vcpu->kvm, fault->slot, fault->gfn);
 
-	/* TDP MMU pages do not use the MMU generation. */
-	return !sp->tdp_mmu_page &&
-	       unlikely(sp->mmu_valid_gen != kvm->arch.mmu_valid_gen);
+	return true;
 }
 
-struct mmu_page_path {
-	struct kvm_mmu_page *parent[PT64_ROOT_MAX_LEVEL];
-	unsigned int idx[PT64_ROOT_MAX_LEVEL];
-};
-
-#define for_each_sp(pvec, sp, parents, i)			\
-		for (i = mmu_pages_first(&pvec, &parents);	\
-			i < pvec.nr && ({ sp = pvec.page[i].sp; 1;});	\
-			i = mmu_pages_next(&pvec, &parents, i))
-
-static int mmu_pages_next(struct kvm_mmu_pages *pvec,
-			  struct mmu_page_path *parents,
-			  int i)
+static bool is_access_allowed(struct kvm_page_fault *fault, u64 spte)
 {
-	int n;
-
-	for (n = i+1; n < pvec->nr; n++) {
-		struct kvm_mmu_page *sp = pvec->page[n].sp;
-		unsigned idx = pvec->page[n].idx;
-		int level = sp->role.level;
-
-		parents->idx[level-1] = idx;
-		if (level == PG_LEVEL_4K)
-			break;
+	if (fault->exec)
+		return is_executable_pte(spte);
 
-		parents->parent[level-2] = sp;
-	}
+	if (fault->write)
+		return is_writable_pte(spte);
 
-	return n;
+	/* Fault was on Read access */
+	return spte & PT_PRESENT_MASK;
 }
 
-static int mmu_pages_first(struct kvm_mmu_pages *pvec,
-			   struct mmu_page_path *parents)
+/*
+ * Returns one of RET_PF_INVALID, RET_PF_FIXED or RET_PF_SPURIOUS.
+ */
+static int fast_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_mmu_page *sp;
-	int level;
-
-	if (pvec->nr == 0)
-		return 0;
-
-	WARN_ON(pvec->page[0].idx != INVALID_INDEX);
-
-	sp = pvec->page[0].sp;
-	level = sp->role.level;
-	WARN_ON(level == PG_LEVEL_4K);
-
-	parents->parent[level-2] = sp;
+	int ret = RET_PF_INVALID;
+	u64 spte = 0ull;
+	u64 *sptep = NULL;
+	uint retry_count = 0;
 
-	/* Also set up a sentinel.  Further entries in pvec are all
-	 * children of sp, so this element is never overwritten.
-	 */
-	parents->parent[level-1] = NULL;
-	return mmu_pages_next(pvec, parents, 0);
-}
+	if (!page_fault_can_be_fast(fault))
+		return ret;
 
-static void mmu_pages_clear_parents(struct mmu_page_path *parents)
-{
-	struct kvm_mmu_page *sp;
-	unsigned int level = 0;
+	walk_shadow_page_lockless_begin(vcpu);
 
 	do {
-		unsigned int idx = parents->idx[level];
-		sp = parents->parent[level];
-		if (!sp)
-			return;
-
-		WARN_ON(idx == INVALID_INDEX);
-		clear_unsync_child_bit(sp, idx);
-		level++;
-	} while (!sp->unsync_children);
-}
-
-static int mmu_sync_children(struct kvm_vcpu *vcpu,
-			     struct kvm_mmu_page *parent, bool can_yield)
-{
-	int i;
-	struct kvm_mmu_page *sp;
-	struct mmu_page_path parents;
-	struct kvm_mmu_pages pages;
-	LIST_HEAD(invalid_list);
-	bool flush = false;
-
-	while (mmu_unsync_walk(parent, &pages)) {
-		bool protected = false;
-
-		for_each_sp(pages, sp, parents, i)
-			protected |= kvm_vcpu_write_protect_gfn(vcpu, sp->gfn);
-
-		if (protected) {
-			kvm_mmu_remote_flush_or_zap(vcpu->kvm, &invalid_list, true);
-			flush = false;
-		}
-
-		for_each_sp(pages, sp, parents, i) {
-			kvm_unlink_unsync_page(vcpu->kvm, sp);
-			flush |= kvm_sync_page(vcpu, sp, &invalid_list) > 0;
-			mmu_pages_clear_parents(&parents);
-		}
-		if (need_resched() || rwlock_needbreak(&vcpu->kvm->mmu_lock)) {
-			kvm_mmu_remote_flush_or_zap(vcpu->kvm, &invalid_list, flush);
-			if (!can_yield) {
-				kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
-				return -EINTR;
-			}
-
-			cond_resched_rwlock_write(&vcpu->kvm->mmu_lock);
-			flush = false;
-		}
-	}
-
-	kvm_mmu_remote_flush_or_zap(vcpu->kvm, &invalid_list, flush);
-	return 0;
-}
+		u64 new_spte;
 
-static void __clear_sp_write_flooding_count(struct kvm_mmu_page *sp)
-{
-	atomic_set(&sp->write_flooding_count,  0);
-}
+		if (is_tdp_mmu(vcpu->arch.mmu))
+			sptep = kvm_tdp_mmu_fast_pf_get_last_sptep(vcpu, fault->addr, &spte);
+		else
+			sptep = fast_pf_get_last_sptep(vcpu, fault->addr, &spte);
 
-static void clear_sp_write_flooding_count(u64 *spte)
-{
-	__clear_sp_write_flooding_count(sptep_to_sp(spte));
-}
+		if (!is_shadow_present_pte(spte))
+			break;
 
-/*
- * The vCPU is required when finding indirect shadow pages; the shadow
- * page may already exist and syncing it needs the vCPU pointer in
- * order to read guest page tables.  Direct shadow pages are never
- * unsync, thus @vcpu can be NULL if @role.direct is true.
- */
-static struct kvm_mmu_page *kvm_mmu_find_shadow_page(struct kvm *kvm,
-						     struct kvm_vcpu *vcpu,
-						     gfn_t gfn,
-						     struct hlist_head *sp_list,
-						     union kvm_mmu_page_role role)
-{
-	struct kvm_mmu_page *sp;
-	int ret;
-	int collisions = 0;
-	LIST_HEAD(invalid_list);
+		sp = sptep_to_sp(sptep);
+		if (!is_last_spte(spte, sp->role.level))
+			break;
 
-	for_each_valid_sp(kvm, sp, sp_list) {
-		if (sp->gfn != gfn) {
-			collisions++;
-			continue;
+		/*
+		 * Check whether the memory access that caused the fault would
+		 * still cause it if it were to be performed right now. If not,
+		 * then this is a spurious fault caused by TLB lazily flushed,
+		 * or some other CPU has already fixed the PTE after the
+		 * current CPU took the fault.
+		 *
+		 * Need not check the access of upper level table entries since
+		 * they are always ACC_ALL.
+		 */
+		if (is_access_allowed(fault, spte)) {
+			ret = RET_PF_SPURIOUS;
+			break;
 		}
 
-		if (sp->role.word != role.word) {
-			/*
-			 * If the guest is creating an upper-level page, zap
-			 * unsync pages for the same gfn.  While it's possible
-			 * the guest is using recursive page tables, in all
-			 * likelihood the guest has stopped using the unsync
-			 * page and is installing a completely unrelated page.
-			 * Unsync pages must not be left as is, because the new
-			 * upper-level page will be write-protected.
-			 */
-			if (role.level > PG_LEVEL_4K && sp->unsync)
-				kvm_mmu_prepare_zap_page(kvm, sp,
-							 &invalid_list);
-			continue;
-		}
+		new_spte = spte;
 
-		/* unsync and write-flooding only apply to indirect SPs. */
-		if (sp->role.direct)
-			goto out;
+		/*
+		 * KVM only supports fixing page faults outside of MMU lock for
+		 * direct MMUs, nested MMUs are always indirect, and KVM always
+		 * uses A/D bits for non-nested MMUs.  Thus, if A/D bits are
+		 * enabled, the SPTE can't be an access-tracked SPTE.
+		 */
+		if (unlikely(!kvm_ad_enabled()) && is_access_track_spte(spte))
+			new_spte = restore_acc_track_spte(new_spte);
 
-		if (sp->unsync) {
-			if (KVM_BUG_ON(!vcpu, kvm))
-				break;
+		/*
+		 * To keep things simple, only SPTEs that are MMU-writable can
+		 * be made fully writable outside of mmu_lock, e.g. only SPTEs
+		 * that were write-protected for dirty-logging or access
+		 * tracking are handled here.  Don't bother checking if the
+		 * SPTE is writable to prioritize running with A/D bits enabled.
+		 * The is_access_allowed() check above handles the common case
+		 * of the fault being spurious, and the SPTE is known to be
+		 * shadow-present, i.e. except for access tracking restoration
+		 * making the new SPTE writable, the check is wasteful.
+		 */
+		if (fault->write && is_mmu_writable_spte(spte)) {
+			new_spte |= PT_WRITABLE_MASK;
 
 			/*
-			 * The page is good, but is stale.  kvm_sync_page does
-			 * get the latest guest state, but (unlike mmu_unsync_children)
-			 * it doesn't write-protect the page or mark it synchronized!
-			 * This way the validity of the mapping is ensured, but the
-			 * overhead of write protection is not incurred until the
-			 * guest invalidates the TLB mapping.  This allows multiple
-			 * SPs for a single gfn to be unsync.
+			 * Do not fix write-permission on the large spte when
+			 * dirty logging is enabled. Since we only dirty the
+			 * first page into the dirty-bitmap in
+			 * fast_pf_fix_direct_spte(), other pages are missed
+			 * if its slot has dirty logging enabled.
 			 *
-			 * If the sync fails, the page is zapped.  If so, break
-			 * in order to rebuild it.
+			 * Instead, we let the slow page fault path create a
+			 * normal spte to fix the access.
 			 */
-			ret = kvm_sync_page(vcpu, sp, &invalid_list);
-			if (ret < 0)
+			if (sp->role.level > PG_LEVEL_4K &&
+			    kvm_slot_dirty_track_enabled(fault->slot))
 				break;
-
-			WARN_ON(!list_empty(&invalid_list));
-			if (ret > 0)
-				kvm_flush_remote_tlbs(kvm);
 		}
 
-		__clear_sp_write_flooding_count(sp);
-
-		goto out;
-	}
-
-	sp = NULL;
-	++kvm->stat.mmu_cache_miss;
-
-out:
-	kvm_mmu_commit_zap_page(kvm, &invalid_list);
-
-	if (collisions > kvm->stat.max_mmu_page_hash_collisions)
-		kvm->stat.max_mmu_page_hash_collisions = collisions;
-	return sp;
-}
-
-/* Caches used when allocating a new shadow page. */
-struct shadow_page_caches {
-	struct kvm_mmu_memory_cache *page_header_cache;
-	struct kvm_mmu_memory_cache *shadow_page_cache;
-	struct kvm_mmu_memory_cache *shadowed_info_cache;
-};
-
-static struct kvm_mmu_page *kvm_mmu_alloc_shadow_page(struct kvm *kvm,
-						      struct shadow_page_caches *caches,
-						      gfn_t gfn,
-						      struct hlist_head *sp_list,
-						      union kvm_mmu_page_role role)
-{
-	struct kvm_mmu_page *sp;
-
-	sp = kvm_mmu_memory_cache_alloc(caches->page_header_cache);
-	sp->spt = kvm_mmu_memory_cache_alloc(caches->shadow_page_cache);
-	if (!role.direct)
-		sp->shadowed_translation = kvm_mmu_memory_cache_alloc(caches->shadowed_info_cache);
-
-	set_page_private(virt_to_page(sp->spt), (unsigned long)sp);
-
-	INIT_LIST_HEAD(&sp->possible_nx_huge_page_link);
-
-	/*
-	 * active_mmu_pages must be a FIFO list, as kvm_zap_obsolete_pages()
-	 * depends on valid pages being added to the head of the list.  See
-	 * comments in kvm_zap_obsolete_pages().
-	 */
-	sp->mmu_valid_gen = kvm->arch.mmu_valid_gen;
-	list_add(&sp->link, &kvm->arch.active_mmu_pages);
-	kvm_account_mmu_page(kvm, sp);
-
-	sp->gfn = gfn;
-	sp->role = role;
-	hlist_add_head(&sp->hash_link, sp_list);
-	if (sp_has_gptes(sp))
-		account_shadowed(kvm, sp);
-
-	return sp;
-}
-
-/* Note, @vcpu may be NULL if @role.direct is true; see kvm_mmu_find_shadow_page. */
-static struct kvm_mmu_page *__kvm_mmu_get_shadow_page(struct kvm *kvm,
-						      struct kvm_vcpu *vcpu,
-						      struct shadow_page_caches *caches,
-						      gfn_t gfn,
-						      union kvm_mmu_page_role role)
-{
-	struct hlist_head *sp_list;
-	struct kvm_mmu_page *sp;
-	bool created = false;
-
-	sp_list = &kvm->arch.mmu_page_hash[kvm_page_table_hashfn(gfn)];
-
-	sp = kvm_mmu_find_shadow_page(kvm, vcpu, gfn, sp_list, role);
-	if (!sp) {
-		created = true;
-		sp = kvm_mmu_alloc_shadow_page(kvm, caches, gfn, sp_list, role);
-	}
-
-	trace_kvm_mmu_get_page(sp, created);
-	return sp;
-}
-
-static struct kvm_mmu_page *kvm_mmu_get_shadow_page(struct kvm_vcpu *vcpu,
-						    gfn_t gfn,
-						    union kvm_mmu_page_role role)
-{
-	struct shadow_page_caches caches = {
-		.page_header_cache = &vcpu->arch.mmu_page_header_cache,
-		.shadow_page_cache = &vcpu->arch.mmu_shadow_page_cache,
-		.shadowed_info_cache = &vcpu->arch.mmu_shadowed_info_cache,
-	};
-
-	return __kvm_mmu_get_shadow_page(vcpu->kvm, vcpu, &caches, gfn, role);
-}
-
-static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direct,
-						  unsigned int access)
-{
-	struct kvm_mmu_page *parent_sp = sptep_to_sp(sptep);
-	union kvm_mmu_page_role role;
+		/* Verify that the fault can be handled in the fast path */
+		if (new_spte == spte ||
+		    !is_access_allowed(fault, new_spte))
+			break;
 
-	role = parent_sp->role;
-	role.level--;
-	role.access = access;
-	role.direct = direct;
-	role.passthrough = 0;
+		/*
+		 * Currently, fast page fault only works for direct mapping
+		 * since the gfn is not stable for indirect shadow page. See
+		 * Documentation/virt/kvm/locking.rst to get more detail.
+		 */
+		if (fast_pf_fix_direct_spte(vcpu, fault, sptep, spte, new_spte)) {
+			ret = RET_PF_FIXED;
+			break;
+		}
 
-	/*
-	 * If the guest has 4-byte PTEs then that means it's using 32-bit,
-	 * 2-level, non-PAE paging. KVM shadows such guests with PAE paging
-	 * (i.e. 8-byte PTEs). The difference in PTE size means that KVM must
-	 * shadow each guest page table with multiple shadow page tables, which
-	 * requires extra bookkeeping in the role.
-	 *
-	 * Specifically, to shadow the guest's page directory (which covers a
-	 * 4GiB address space), KVM uses 4 PAE page directories, each mapping
-	 * 1GiB of the address space. @role.quadrant encodes which quarter of
-	 * the address space each maps.
-	 *
-	 * To shadow the guest's page tables (which each map a 4MiB region), KVM
-	 * uses 2 PAE page tables, each mapping a 2MiB region. For these,
-	 * @role.quadrant encodes which half of the region they map.
-	 *
-	 * Concretely, a 4-byte PDE consumes bits 31:22, while an 8-byte PDE
-	 * consumes bits 29:21.  To consume bits 31:30, KVM's uses 4 shadow
-	 * PDPTEs; those 4 PAE page directories are pre-allocated and their
-	 * quadrant is assigned in mmu_alloc_root().   A 4-byte PTE consumes
-	 * bits 21:12, while an 8-byte PTE consumes bits 20:12.  To consume
-	 * bit 21 in the PTE (the child here), KVM propagates that bit to the
-	 * quadrant, i.e. sets quadrant to '0' or '1'.  The parent 8-byte PDE
-	 * covers bit 21 (see above), thus the quadrant is calculated from the
-	 * _least_ significant bit of the PDE index.
-	 */
-	if (role.has_4_byte_gpte) {
-		WARN_ON_ONCE(role.level != PG_LEVEL_4K);
-		role.quadrant = spte_index(sptep) & 1;
-	}
-
-	return role;
-}
-
-static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
-						 u64 *sptep, gfn_t gfn,
-						 bool direct, unsigned int access)
-{
-	union kvm_mmu_page_role role;
-
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
-		return ERR_PTR(-EEXIST);
-
-	role = kvm_mmu_child_role(sptep, direct, access);
-	return kvm_mmu_get_shadow_page(vcpu, gfn, role);
-}
-
-static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterator,
-					struct kvm_vcpu *vcpu, hpa_t root,
-					u64 addr)
-{
-	iterator->addr = addr;
-	iterator->shadow_addr = root;
-	iterator->level = vcpu->arch.mmu->root_role.level;
-
-	if (iterator->level >= PT64_ROOT_4LEVEL &&
-	    vcpu->arch.mmu->cpu_role.base.level < PT64_ROOT_4LEVEL &&
-	    !vcpu->arch.mmu->root_role.direct)
-		iterator->level = PT32E_ROOT_LEVEL;
-
-	if (iterator->level == PT32E_ROOT_LEVEL) {
-		/*
-		 * prev_root is currently only used for 64-bit hosts. So only
-		 * the active root_hpa is valid here.
-		 */
-		BUG_ON(root != vcpu->arch.mmu->root.hpa);
-
-		iterator->shadow_addr
-			= vcpu->arch.mmu->pae_root[(addr >> 30) & 3];
-		iterator->shadow_addr &= SPTE_BASE_ADDR_MASK;
-		--iterator->level;
-		if (!iterator->shadow_addr)
-			iterator->level = 0;
-	}
-}
-
-static void shadow_walk_init(struct kvm_shadow_walk_iterator *iterator,
-			     struct kvm_vcpu *vcpu, u64 addr)
-{
-	shadow_walk_init_using_root(iterator, vcpu, vcpu->arch.mmu->root.hpa,
-				    addr);
-}
-
-static bool shadow_walk_okay(struct kvm_shadow_walk_iterator *iterator)
-{
-	if (iterator->level < PG_LEVEL_4K)
-		return false;
-
-	iterator->index = SPTE_INDEX(iterator->addr, iterator->level);
-	iterator->sptep	= ((u64 *)__va(iterator->shadow_addr)) + iterator->index;
-	return true;
-}
-
-static void __shadow_walk_next(struct kvm_shadow_walk_iterator *iterator,
-			       u64 spte)
-{
-	if (!is_shadow_present_pte(spte) || is_last_spte(spte, iterator->level)) {
-		iterator->level = 0;
-		return;
-	}
-
-	iterator->shadow_addr = spte & SPTE_BASE_ADDR_MASK;
-	--iterator->level;
-}
-
-static void shadow_walk_next(struct kvm_shadow_walk_iterator *iterator)
-{
-	__shadow_walk_next(iterator, *iterator->sptep);
-}
-
-static void __link_shadow_page(struct kvm *kvm,
-			       struct kvm_mmu_memory_cache *cache, u64 *sptep,
-			       struct kvm_mmu_page *sp, bool flush)
-{
-	u64 spte;
-
-	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK != PT_WRITABLE_MASK);
-
-	/*
-	 * If an SPTE is present already, it must be a leaf and therefore
-	 * a large one.  Drop it, and flush the TLB if needed, before
-	 * installing sp.
-	 */
-	if (is_shadow_present_pte(*sptep))
-		drop_large_spte(kvm, sptep, flush);
-
-	spte = make_nonleaf_spte(sp->spt, sp_ad_disabled(sp));
-
-	mmu_spte_set(sptep, spte);
-
-	mmu_page_add_parent_pte(cache, sp, sptep);
-
-	if (sp->unsync_children || sp->unsync)
-		mark_unsync(sptep);
-}
-
-static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
-			     struct kvm_mmu_page *sp)
-{
-	__link_shadow_page(vcpu->kvm, &vcpu->arch.mmu_pte_list_desc_cache, sptep, sp, true);
-}
-
-static void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
-				   unsigned direct_access)
-{
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep)) {
-		struct kvm_mmu_page *child;
-
-		/*
-		 * For the direct sp, if the guest pte's dirty bit
-		 * changed form clean to dirty, it will corrupt the
-		 * sp's access: allow writable in the read-only sp,
-		 * so we should update the spte at this point to get
-		 * a new sp with the correct access.
-		 */
-		child = spte_to_child_sp(*sptep);
-		if (child->role.access == direct_access)
-			return;
-
-		drop_parent_pte(child, sptep);
-		kvm_flush_remote_tlbs_with_address(vcpu->kvm, child->gfn, 1);
-	}
-}
-
-/* Returns the number of zapped non-leaf child shadow pages. */
-static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
-			    u64 *spte, struct list_head *invalid_list)
-{
-	u64 pte;
-	struct kvm_mmu_page *child;
-
-	pte = *spte;
-	if (is_shadow_present_pte(pte)) {
-		if (is_last_spte(pte, sp->role.level)) {
-			drop_spte(kvm, spte);
-		} else {
-			child = spte_to_child_sp(pte);
-			drop_parent_pte(child, spte);
-
-			/*
-			 * Recursively zap nested TDP SPs, parentless SPs are
-			 * unlikely to be used again in the near future.  This
-			 * avoids retaining a large number of stale nested SPs.
-			 */
-			if (tdp_enabled && invalid_list &&
-			    child->role.guest_mode && !child->parent_ptes.val)
-				return kvm_mmu_prepare_zap_page(kvm, child,
-								invalid_list);
-		}
-	} else if (is_mmio_spte(pte)) {
-		mmu_spte_clear_no_track(spte);
-	}
-	return 0;
-}
-
-static int kvm_mmu_page_unlink_children(struct kvm *kvm,
-					struct kvm_mmu_page *sp,
-					struct list_head *invalid_list)
-{
-	int zapped = 0;
-	unsigned i;
-
-	for (i = 0; i < SPTE_ENT_PER_PAGE; ++i)
-		zapped += mmu_page_zap_pte(kvm, sp, sp->spt + i, invalid_list);
-
-	return zapped;
-}
-
-static void kvm_mmu_unlink_parents(struct kvm_mmu_page *sp)
-{
-	u64 *sptep;
-	struct rmap_iterator iter;
-
-	while ((sptep = rmap_get_first(&sp->parent_ptes, &iter)))
-		drop_parent_pte(sp, sptep);
-}
-
-static int mmu_zap_unsync_children(struct kvm *kvm,
-				   struct kvm_mmu_page *parent,
-				   struct list_head *invalid_list)
-{
-	int i, zapped = 0;
-	struct mmu_page_path parents;
-	struct kvm_mmu_pages pages;
-
-	if (parent->role.level == PG_LEVEL_4K)
-		return 0;
-
-	while (mmu_unsync_walk(parent, &pages)) {
-		struct kvm_mmu_page *sp;
-
-		for_each_sp(pages, sp, parents, i) {
-			kvm_mmu_prepare_zap_page(kvm, sp, invalid_list);
-			mmu_pages_clear_parents(&parents);
-			zapped++;
-		}
-	}
-
-	return zapped;
-}
-
-static bool __kvm_mmu_prepare_zap_page(struct kvm *kvm,
-				       struct kvm_mmu_page *sp,
-				       struct list_head *invalid_list,
-				       int *nr_zapped)
-{
-	bool list_unstable, zapped_root = false;
-
-	trace_kvm_mmu_prepare_zap_page(sp);
-	++kvm->stat.mmu_shadow_zapped;
-	*nr_zapped = mmu_zap_unsync_children(kvm, sp, invalid_list);
-	*nr_zapped += kvm_mmu_page_unlink_children(kvm, sp, invalid_list);
-	kvm_mmu_unlink_parents(sp);
-
-	/* Zapping children means active_mmu_pages has become unstable. */
-	list_unstable = *nr_zapped;
-
-	if (!sp->role.invalid && sp_has_gptes(sp))
-		unaccount_shadowed(kvm, sp);
-
-	if (sp->unsync)
-		kvm_unlink_unsync_page(kvm, sp);
-	if (!sp->root_count) {
-		/* Count self */
-		(*nr_zapped)++;
-
-		/*
-		 * Already invalid pages (previously active roots) are not on
-		 * the active page list.  See list_del() in the "else" case of
-		 * !sp->root_count.
-		 */
-		if (sp->role.invalid)
-			list_add(&sp->link, invalid_list);
-		else
-			list_move(&sp->link, invalid_list);
-		kvm_unaccount_mmu_page(kvm, sp);
-	} else {
-		/*
-		 * Remove the active root from the active page list, the root
-		 * will be explicitly freed when the root_count hits zero.
-		 */
-		list_del(&sp->link);
-
-		/*
-		 * Obsolete pages cannot be used on any vCPUs, see the comment
-		 * in kvm_mmu_zap_all_fast().  Note, is_obsolete_sp() also
-		 * treats invalid shadow pages as being obsolete.
-		 */
-		zapped_root = !is_obsolete_sp(kvm, sp);
-	}
-
-	if (sp->nx_huge_page_disallowed)
-		unaccount_nx_huge_page(kvm, sp);
-
-	sp->role.invalid = 1;
-
-	/*
-	 * Make the request to free obsolete roots after marking the root
-	 * invalid, otherwise other vCPUs may not see it as invalid.
-	 */
-	if (zapped_root)
-		kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_FREE_OBSOLETE_ROOTS);
-	return list_unstable;
-}
-
-static bool kvm_mmu_prepare_zap_page(struct kvm *kvm, struct kvm_mmu_page *sp,
-				     struct list_head *invalid_list)
-{
-	int nr_zapped;
-
-	__kvm_mmu_prepare_zap_page(kvm, sp, invalid_list, &nr_zapped);
-	return nr_zapped;
-}
-
-static void kvm_mmu_commit_zap_page(struct kvm *kvm,
-				    struct list_head *invalid_list)
-{
-	struct kvm_mmu_page *sp, *nsp;
-
-	if (list_empty(invalid_list))
-		return;
-
-	/*
-	 * We need to make sure everyone sees our modifications to
-	 * the page tables and see changes to vcpu->mode here. The barrier
-	 * in the kvm_flush_remote_tlbs() achieves this. This pairs
-	 * with vcpu_enter_guest and walk_shadow_page_lockless_begin/end.
-	 *
-	 * In addition, kvm_flush_remote_tlbs waits for all vcpus to exit
-	 * guest mode and/or lockless shadow page table walks.
-	 */
-	kvm_flush_remote_tlbs(kvm);
-
-	list_for_each_entry_safe(sp, nsp, invalid_list, link) {
-		WARN_ON(!sp->role.invalid || sp->root_count);
-		kvm_mmu_free_shadow_page(sp);
-	}
-}
-
-static unsigned long kvm_mmu_zap_oldest_mmu_pages(struct kvm *kvm,
-						  unsigned long nr_to_zap)
-{
-	unsigned long total_zapped = 0;
-	struct kvm_mmu_page *sp, *tmp;
-	LIST_HEAD(invalid_list);
-	bool unstable;
-	int nr_zapped;
-
-	if (list_empty(&kvm->arch.active_mmu_pages))
-		return 0;
-
-restart:
-	list_for_each_entry_safe_reverse(sp, tmp, &kvm->arch.active_mmu_pages, link) {
-		/*
-		 * Don't zap active root pages, the page itself can't be freed
-		 * and zapping it will just force vCPUs to realloc and reload.
-		 */
-		if (sp->root_count)
-			continue;
-
-		unstable = __kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list,
-						      &nr_zapped);
-		total_zapped += nr_zapped;
-		if (total_zapped >= nr_to_zap)
-			break;
-
-		if (unstable)
-			goto restart;
-	}
-
-	kvm_mmu_commit_zap_page(kvm, &invalid_list);
-
-	kvm->stat.mmu_recycled += total_zapped;
-	return total_zapped;
-}
-
-static inline unsigned long kvm_mmu_available_pages(struct kvm *kvm)
-{
-	if (kvm->arch.n_max_mmu_pages > kvm->arch.n_used_mmu_pages)
-		return kvm->arch.n_max_mmu_pages -
-			kvm->arch.n_used_mmu_pages;
-
-	return 0;
-}
-
-static int make_mmu_pages_available(struct kvm_vcpu *vcpu)
-{
-	unsigned long avail = kvm_mmu_available_pages(vcpu->kvm);
-
-	if (likely(avail >= KVM_MIN_FREE_MMU_PAGES))
-		return 0;
-
-	kvm_mmu_zap_oldest_mmu_pages(vcpu->kvm, KVM_REFILL_PAGES - avail);
-
-	/*
-	 * Note, this check is intentionally soft, it only guarantees that one
-	 * page is available, while the caller may end up allocating as many as
-	 * four pages, e.g. for PAE roots or for 5-level paging.  Temporarily
-	 * exceeding the (arbitrary by default) limit will not harm the host,
-	 * being too aggressive may unnecessarily kill the guest, and getting an
-	 * exact count is far more trouble than it's worth, especially in the
-	 * page fault paths.
-	 */
-	if (!kvm_mmu_available_pages(vcpu->kvm))
-		return -ENOSPC;
-	return 0;
-}
-
-/*
- * Changing the number of mmu pages allocated to the vm
- * Note: if goal_nr_mmu_pages is too small, you will get dead lock
- */
-void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long goal_nr_mmu_pages)
-{
-	write_lock(&kvm->mmu_lock);
-
-	if (kvm->arch.n_used_mmu_pages > goal_nr_mmu_pages) {
-		kvm_mmu_zap_oldest_mmu_pages(kvm, kvm->arch.n_used_mmu_pages -
-						  goal_nr_mmu_pages);
-
-		goal_nr_mmu_pages = kvm->arch.n_used_mmu_pages;
-	}
-
-	kvm->arch.n_max_mmu_pages = goal_nr_mmu_pages;
-
-	write_unlock(&kvm->mmu_lock);
-}
-
-int kvm_mmu_unprotect_page(struct kvm *kvm, gfn_t gfn)
-{
-	struct kvm_mmu_page *sp;
-	LIST_HEAD(invalid_list);
-	int r;
-
-	pgprintk("%s: looking for gfn %llx\n", __func__, gfn);
-	r = 0;
-	write_lock(&kvm->mmu_lock);
-	for_each_gfn_valid_sp_with_gptes(kvm, sp, gfn) {
-		pgprintk("%s: gfn %llx role %x\n", __func__, gfn,
-			 sp->role.word);
-		r = 1;
-		kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
-	}
-	kvm_mmu_commit_zap_page(kvm, &invalid_list);
-	write_unlock(&kvm->mmu_lock);
-
-	return r;
-}
-
-static int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva)
-{
-	gpa_t gpa;
-	int r;
-
-	if (vcpu->arch.mmu->root_role.direct)
-		return 0;
-
-	gpa = kvm_mmu_gva_to_gpa_read(vcpu, gva, NULL);
-
-	r = kvm_mmu_unprotect_page(vcpu->kvm, gpa >> PAGE_SHIFT);
-
-	return r;
-}
-
-static void kvm_unsync_page(struct kvm *kvm, struct kvm_mmu_page *sp)
-{
-	trace_kvm_mmu_unsync_page(sp);
-	++kvm->stat.mmu_unsync;
-	sp->unsync = 1;
-
-	kvm_mmu_mark_parents_unsync(sp);
-}
-
-/*
- * Attempt to unsync any shadow pages that can be reached by the specified gfn,
- * KVM is creating a writable mapping for said gfn.  Returns 0 if all pages
- * were marked unsync (or if there is no shadow page), -EPERM if the SPTE must
- * be write-protected.
- */
-int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
-			    gfn_t gfn, bool can_unsync, bool prefetch)
-{
-	struct kvm_mmu_page *sp;
-	bool locked = false;
-
-	/*
-	 * Force write-protection if the page is being tracked.  Note, the page
-	 * track machinery is used to write-protect upper-level shadow pages,
-	 * i.e. this guards the role.level == 4K assertion below!
-	 */
-	if (kvm_slot_page_track_is_active(kvm, slot, gfn, KVM_PAGE_TRACK_WRITE))
-		return -EPERM;
-
-	/*
-	 * The page is not write-tracked, mark existing shadow pages unsync
-	 * unless KVM is synchronizing an unsync SP (can_unsync = false).  In
-	 * that case, KVM must complete emulation of the guest TLB flush before
-	 * allowing shadow pages to become unsync (writable by the guest).
-	 */
-	for_each_gfn_valid_sp_with_gptes(kvm, sp, gfn) {
-		if (!can_unsync)
-			return -EPERM;
-
-		if (sp->unsync)
-			continue;
-
-		if (prefetch)
-			return -EEXIST;
-
-		/*
-		 * TDP MMU page faults require an additional spinlock as they
-		 * run with mmu_lock held for read, not write, and the unsync
-		 * logic is not thread safe.  Take the spinklock regardless of
-		 * the MMU type to avoid extra conditionals/parameters, there's
-		 * no meaningful penalty if mmu_lock is held for write.
-		 */
-		if (!locked) {
-			locked = true;
-			spin_lock(&kvm->arch.mmu_unsync_pages_lock);
-
-			/*
-			 * Recheck after taking the spinlock, a different vCPU
-			 * may have since marked the page unsync.  A false
-			 * positive on the unprotected check above is not
-			 * possible as clearing sp->unsync _must_ hold mmu_lock
-			 * for write, i.e. unsync cannot transition from 0->1
-			 * while this CPU holds mmu_lock for read (or write).
-			 */
-			if (READ_ONCE(sp->unsync))
-				continue;
-		}
-
-		WARN_ON(sp->role.level != PG_LEVEL_4K);
-		kvm_unsync_page(kvm, sp);
-	}
-	if (locked)
-		spin_unlock(&kvm->arch.mmu_unsync_pages_lock);
-
-	/*
-	 * We need to ensure that the marking of unsync pages is visible
-	 * before the SPTE is updated to allow writes because
-	 * kvm_mmu_sync_roots() checks the unsync flags without holding
-	 * the MMU lock and so can race with this. If the SPTE was updated
-	 * before the page had been marked as unsync-ed, something like the
-	 * following could happen:
-	 *
-	 * CPU 1                    CPU 2
-	 * ---------------------------------------------------------------------
-	 * 1.2 Host updates SPTE
-	 *     to be writable
-	 *                      2.1 Guest writes a GPTE for GVA X.
-	 *                          (GPTE being in the guest page table shadowed
-	 *                           by the SP from CPU 1.)
-	 *                          This reads SPTE during the page table walk.
-	 *                          Since SPTE.W is read as 1, there is no
-	 *                          fault.
-	 *
-	 *                      2.2 Guest issues TLB flush.
-	 *                          That causes a VM Exit.
-	 *
-	 *                      2.3 Walking of unsync pages sees sp->unsync is
-	 *                          false and skips the page.
-	 *
-	 *                      2.4 Guest accesses GVA X.
-	 *                          Since the mapping in the SP was not updated,
-	 *                          so the old mapping for GVA X incorrectly
-	 *                          gets used.
-	 * 1.1 Host marks SP
-	 *     as unsync
-	 *     (sp->unsync = true)
-	 *
-	 * The write barrier below ensures that 1.1 happens before 1.2 and thus
-	 * the situation in 2.4 does not arise.  It pairs with the read barrier
-	 * in is_unsync_root(), placed between 2.1's load of SPTE.W and 2.3.
-	 */
-	smp_wmb();
-
-	return 0;
-}
-
-static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
-			u64 *sptep, unsigned int pte_access, gfn_t gfn,
-			kvm_pfn_t pfn, struct kvm_page_fault *fault)
-{
-	struct kvm_mmu_page *sp = sptep_to_sp(sptep);
-	int level = sp->role.level;
-	int was_rmapped = 0;
-	int ret = RET_PF_FIXED;
-	bool flush = false;
-	bool wrprot;
-	u64 spte;
-
-	/* Prefetching always gets a writable pfn.  */
-	bool host_writable = !fault || fault->map_writable;
-	bool prefetch = !fault || fault->prefetch;
-	bool write_fault = fault && fault->write;
-
-	pgprintk("%s: spte %llx write_fault %d gfn %llx\n", __func__,
-		 *sptep, write_fault, gfn);
-
-	if (unlikely(is_noslot_pfn(pfn))) {
-		vcpu->stat.pf_mmio_spte_created++;
-		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
-		return RET_PF_EMULATE;
-	}
-
-	if (is_shadow_present_pte(*sptep)) {
-		/*
-		 * If we overwrite a PTE page pointer with a 2MB PMD, unlink
-		 * the parent of the now unreachable PTE.
-		 */
-		if (level > PG_LEVEL_4K && !is_large_pte(*sptep)) {
-			struct kvm_mmu_page *child;
-			u64 pte = *sptep;
-
-			child = spte_to_child_sp(pte);
-			drop_parent_pte(child, sptep);
-			flush = true;
-		} else if (pfn != spte_to_pfn(*sptep)) {
-			pgprintk("hfn old %llx new %llx\n",
-				 spte_to_pfn(*sptep), pfn);
-			drop_spte(vcpu->kvm, sptep);
-			flush = true;
-		} else
-			was_rmapped = 1;
-	}
-
-	wrprot = make_spte(vcpu, sp, slot, pte_access, gfn, pfn, *sptep, prefetch,
-			   true, host_writable, &spte);
-
-	if (*sptep == spte) {
-		ret = RET_PF_SPURIOUS;
-	} else {
-		flush |= mmu_spte_update(sptep, spte);
-		trace_kvm_mmu_set_spte(level, gfn, sptep);
-	}
-
-	if (wrprot) {
-		if (write_fault)
-			ret = RET_PF_EMULATE;
-	}
-
-	if (flush)
-		kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn,
-				KVM_PAGES_PER_HPAGE(level));
-
-	pgprintk("%s: setting spte %llx\n", __func__, *sptep);
-
-	if (!was_rmapped) {
-		WARN_ON_ONCE(ret == RET_PF_SPURIOUS);
-		rmap_add(vcpu, slot, sptep, gfn, pte_access);
-	} else {
-		/* Already rmapped but the pte_access bits may have changed. */
-		kvm_mmu_page_set_access(sp, spte_index(sptep), pte_access);
-	}
-
-	return ret;
-}
-
-static int direct_pte_prefetch_many(struct kvm_vcpu *vcpu,
-				    struct kvm_mmu_page *sp,
-				    u64 *start, u64 *end)
-{
-	struct page *pages[PTE_PREFETCH_NUM];
-	struct kvm_memory_slot *slot;
-	unsigned int access = sp->role.access;
-	int i, ret;
-	gfn_t gfn;
-
-	gfn = kvm_mmu_page_get_gfn(sp, spte_index(start));
-	slot = gfn_to_memslot_dirty_bitmap(vcpu, gfn, access & ACC_WRITE_MASK);
-	if (!slot)
-		return -1;
-
-	ret = gfn_to_page_many_atomic(slot, gfn, pages, end - start);
-	if (ret <= 0)
-		return -1;
-
-	for (i = 0; i < ret; i++, gfn++, start++) {
-		mmu_set_spte(vcpu, slot, start, access, gfn,
-			     page_to_pfn(pages[i]), NULL);
-		put_page(pages[i]);
-	}
-
-	return 0;
-}
-
-static void __direct_pte_prefetch(struct kvm_vcpu *vcpu,
-				  struct kvm_mmu_page *sp, u64 *sptep)
-{
-	u64 *spte, *start = NULL;
-	int i;
-
-	WARN_ON(!sp->role.direct);
-
-	i = spte_index(sptep) & ~(PTE_PREFETCH_NUM - 1);
-	spte = sp->spt + i;
-
-	for (i = 0; i < PTE_PREFETCH_NUM; i++, spte++) {
-		if (is_shadow_present_pte(*spte) || spte == sptep) {
-			if (!start)
-				continue;
-			if (direct_pte_prefetch_many(vcpu, sp, start, spte) < 0)
-				return;
-			start = NULL;
-		} else if (!start)
-			start = spte;
-	}
-	if (start)
-		direct_pte_prefetch_many(vcpu, sp, start, spte);
-}
-
-static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
-{
-	struct kvm_mmu_page *sp;
-
-	sp = sptep_to_sp(sptep);
-
-	/*
-	 * Without accessed bits, there's no way to distinguish between
-	 * actually accessed translations and prefetched, so disable pte
-	 * prefetch if accessed bits aren't available.
-	 */
-	if (sp_ad_disabled(sp))
-		return;
-
-	if (sp->role.level > PG_LEVEL_4K)
-		return;
-
-	/*
-	 * If addresses are being invalidated, skip prefetching to avoid
-	 * accidentally prefetching those addresses.
-	 */
-	if (unlikely(vcpu->kvm->mmu_invalidate_in_progress))
-		return;
-
-	__direct_pte_prefetch(vcpu, sp, sptep);
-}
-
-/*
- * Lookup the mapping level for @gfn in the current mm.
- *
- * WARNING!  Use of host_pfn_mapping_level() requires the caller and the end
- * consumer to be tied into KVM's handlers for MMU notifier events!
- *
- * There are several ways to safely use this helper:
- *
- * - Check mmu_invalidate_retry_hva() after grabbing the mapping level, before
- *   consuming it.  In this case, mmu_lock doesn't need to be held during the
- *   lookup, but it does need to be held while checking the MMU notifier.
- *
- * - Hold mmu_lock AND ensure there is no in-progress MMU notifier invalidation
- *   event for the hva.  This can be done by explicit checking the MMU notifier
- *   or by ensuring that KVM already has a valid mapping that covers the hva.
- *
- * - Do not use the result to install new mappings, e.g. use the host mapping
- *   level only to decide whether or not to zap an entry.  In this case, it's
- *   not required to hold mmu_lock (though it's highly likely the caller will
- *   want to hold mmu_lock anyways, e.g. to modify SPTEs).
- *
- * Note!  The lookup can still race with modifications to host page tables, but
- * the above "rules" ensure KVM will not _consume_ the result of the walk if a
- * race with the primary MMU occurs.
- */
-static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
-				  const struct kvm_memory_slot *slot)
-{
-	int level = PG_LEVEL_4K;
-	unsigned long hva;
-	unsigned long flags;
-	pgd_t pgd;
-	p4d_t p4d;
-	pud_t pud;
-	pmd_t pmd;
-
-	/*
-	 * Note, using the already-retrieved memslot and __gfn_to_hva_memslot()
-	 * is not solely for performance, it's also necessary to avoid the
-	 * "writable" check in __gfn_to_hva_many(), which will always fail on
-	 * read-only memslots due to gfn_to_hva() assuming writes.  Earlier
-	 * page fault steps have already verified the guest isn't writing a
-	 * read-only memslot.
-	 */
-	hva = __gfn_to_hva_memslot(slot, gfn);
-
-	/*
-	 * Disable IRQs to prevent concurrent tear down of host page tables,
-	 * e.g. if the primary MMU promotes a P*D to a huge page and then frees
-	 * the original page table.
-	 */
-	local_irq_save(flags);
-
-	/*
-	 * Read each entry once.  As above, a non-leaf entry can be promoted to
-	 * a huge page _during_ this walk.  Re-reading the entry could send the
-	 * walk into the weeks, e.g. p*d_large() returns false (sees the old
-	 * value) and then p*d_offset() walks into the target huge page instead
-	 * of the old page table (sees the new value).
-	 */
-	pgd = READ_ONCE(*pgd_offset(kvm->mm, hva));
-	if (pgd_none(pgd))
-		goto out;
-
-	p4d = READ_ONCE(*p4d_offset(&pgd, hva));
-	if (p4d_none(p4d) || !p4d_present(p4d))
-		goto out;
-
-	pud = READ_ONCE(*pud_offset(&p4d, hva));
-	if (pud_none(pud) || !pud_present(pud))
-		goto out;
-
-	if (pud_large(pud)) {
-		level = PG_LEVEL_1G;
-		goto out;
-	}
-
-	pmd = READ_ONCE(*pmd_offset(&pud, hva));
-	if (pmd_none(pmd) || !pmd_present(pmd))
-		goto out;
-
-	if (pmd_large(pmd))
-		level = PG_LEVEL_2M;
-
-out:
-	local_irq_restore(flags);
-	return level;
-}
-
-int kvm_mmu_max_mapping_level(struct kvm *kvm,
-			      const struct kvm_memory_slot *slot, gfn_t gfn,
-			      int max_level)
-{
-	struct kvm_lpage_info *linfo;
-	int host_level;
-
-	max_level = min(max_level, max_huge_page_level);
-	for ( ; max_level > PG_LEVEL_4K; max_level--) {
-		linfo = lpage_info_slot(gfn, slot, max_level);
-		if (!linfo->disallow_lpage)
-			break;
-	}
-
-	if (max_level == PG_LEVEL_4K)
-		return PG_LEVEL_4K;
-
-	host_level = host_pfn_mapping_level(kvm, gfn, slot);
-	return min(host_level, max_level);
-}
-
-void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
-{
-	struct kvm_memory_slot *slot = fault->slot;
-	kvm_pfn_t mask;
-
-	fault->huge_page_disallowed = fault->exec && fault->nx_huge_page_workaround_enabled;
-
-	if (unlikely(fault->max_level == PG_LEVEL_4K))
-		return;
-
-	if (is_error_noslot_pfn(fault->pfn))
-		return;
-
-	if (kvm_slot_dirty_track_enabled(slot))
-		return;
-
-	/*
-	 * Enforce the iTLB multihit workaround after capturing the requested
-	 * level, which will be used to do precise, accurate accounting.
-	 */
-	fault->req_level = kvm_mmu_max_mapping_level(vcpu->kvm, slot,
-						     fault->gfn, fault->max_level);
-	if (fault->req_level == PG_LEVEL_4K || fault->huge_page_disallowed)
-		return;
-
-	/*
-	 * mmu_invalidate_retry() was successful and mmu_lock is held, so
-	 * the pmd can't be split from under us.
-	 */
-	fault->goal_level = fault->req_level;
-	mask = KVM_PAGES_PER_HPAGE(fault->goal_level) - 1;
-	VM_BUG_ON((fault->gfn & mask) != (fault->pfn & mask));
-	fault->pfn &= ~mask;
-}
-
-void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_level)
-{
-	if (cur_level > PG_LEVEL_4K &&
-	    cur_level == fault->goal_level &&
-	    is_shadow_present_pte(spte) &&
-	    !is_large_pte(spte) &&
-	    spte_to_child_sp(spte)->nx_huge_page_disallowed) {
-		/*
-		 * A small SPTE exists for this pfn, but FNAME(fetch)
-		 * and __direct_map would like to create a large PTE
-		 * instead: just force them to go down another level,
-		 * patching back for them into pfn the next 9 bits of
-		 * the address.
-		 */
-		u64 page_mask = KVM_PAGES_PER_HPAGE(cur_level) -
-				KVM_PAGES_PER_HPAGE(cur_level - 1);
-		fault->pfn |= fault->gfn & page_mask;
-		fault->goal_level--;
-	}
-}
-
-static int __direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
-{
-	struct kvm_shadow_walk_iterator it;
-	struct kvm_mmu_page *sp;
-	int ret;
-	gfn_t base_gfn = fault->gfn;
-
-	kvm_mmu_hugepage_adjust(vcpu, fault);
-
-	trace_kvm_mmu_spte_requested(fault);
-	for_each_shadow_entry(vcpu, fault->addr, it) {
-		/*
-		 * We cannot overwrite existing page tables with an NX
-		 * large page, as the leaf could be executable.
-		 */
-		if (fault->nx_huge_page_workaround_enabled)
-			disallowed_hugepage_adjust(fault, *it.sptep, it.level);
-
-		base_gfn = fault->gfn & ~(KVM_PAGES_PER_HPAGE(it.level) - 1);
-		if (it.level == fault->goal_level)
-			break;
-
-		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, ACC_ALL);
-		if (sp == ERR_PTR(-EEXIST))
-			continue;
-
-		link_shadow_page(vcpu, it.sptep, sp);
-		if (fault->huge_page_disallowed)
-			account_nx_huge_page(vcpu->kvm, sp,
-					     fault->req_level >= it.level);
-	}
-
-	if (WARN_ON_ONCE(it.level != fault->goal_level))
-		return -EFAULT;
-
-	ret = mmu_set_spte(vcpu, fault->slot, it.sptep, ACC_ALL,
-			   base_gfn, fault->pfn, fault);
-	if (ret == RET_PF_SPURIOUS)
-		return ret;
-
-	direct_pte_prefetch(vcpu, it.sptep);
-	return ret;
-}
-
-static void kvm_send_hwpoison_signal(unsigned long address, struct task_struct *tsk)
-{
-	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, PAGE_SHIFT, tsk);
-}
-
-static int kvm_handle_error_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
-{
-	if (is_sigpending_pfn(pfn)) {
-		kvm_handle_signal_exit(vcpu);
-		return -EINTR;
-	}
-
-	/*
-	 * Do not cache the mmio info caused by writing the readonly gfn
-	 * into the spte otherwise read access on readonly gfn also can
-	 * caused mmio page fault and treat it as mmio access.
-	 */
-	if (pfn == KVM_PFN_ERR_RO_FAULT)
-		return RET_PF_EMULATE;
-
-	if (pfn == KVM_PFN_ERR_HWPOISON) {
-		kvm_send_hwpoison_signal(kvm_vcpu_gfn_to_hva(vcpu, gfn), current);
-		return RET_PF_RETRY;
-	}
-
-	return -EFAULT;
-}
-
-static int handle_abnormal_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
-			       unsigned int access)
-{
-	/* The pfn is invalid, report the error! */
-	if (unlikely(is_error_pfn(fault->pfn)))
-		return kvm_handle_error_pfn(vcpu, fault->gfn, fault->pfn);
-
-	if (unlikely(!fault->slot)) {
-		gva_t gva = fault->is_tdp ? 0 : fault->addr;
-
-		vcpu_cache_mmio_info(vcpu, gva, fault->gfn,
-				     access & shadow_mmio_access_mask);
-		/*
-		 * If MMIO caching is disabled, emulate immediately without
-		 * touching the shadow page tables as attempting to install an
-		 * MMIO SPTE will just be an expensive nop.  Do not cache MMIO
-		 * whose gfn is greater than host.MAXPHYADDR, any guest that
-		 * generates such gfns is running nested and is being tricked
-		 * by L0 userspace (you can observe gfn > L1.MAXPHYADDR if
-		 * and only if L1's MAXPHYADDR is inaccurate with respect to
-		 * the hardware's).
-		 */
-		if (unlikely(!enable_mmio_caching) ||
-		    unlikely(fault->gfn > kvm_mmu_max_gfn()))
-			return RET_PF_EMULATE;
-	}
-
-	return RET_PF_CONTINUE;
-}
-
-static bool page_fault_can_be_fast(struct kvm_page_fault *fault)
-{
-	/*
-	 * Page faults with reserved bits set, i.e. faults on MMIO SPTEs, only
-	 * reach the common page fault handler if the SPTE has an invalid MMIO
-	 * generation number.  Refreshing the MMIO generation needs to go down
-	 * the slow path.  Note, EPT Misconfigs do NOT set the PRESENT flag!
-	 */
-	if (fault->rsvd)
-		return false;
-
-	/*
-	 * #PF can be fast if:
-	 *
-	 * 1. The shadow page table entry is not present and A/D bits are
-	 *    disabled _by KVM_, which could mean that the fault is potentially
-	 *    caused by access tracking (if enabled).  If A/D bits are enabled
-	 *    by KVM, but disabled by L1 for L2, KVM is forced to disable A/D
-	 *    bits for L2 and employ access tracking, but the fast page fault
-	 *    mechanism only supports direct MMUs.
-	 * 2. The shadow page table entry is present, the access is a write,
-	 *    and no reserved bits are set (MMIO SPTEs cannot be "fixed"), i.e.
-	 *    the fault was caused by a write-protection violation.  If the
-	 *    SPTE is MMU-writable (determined later), the fault can be fixed
-	 *    by setting the Writable bit, which can be done out of mmu_lock.
-	 */
-	if (!fault->present)
-		return !kvm_ad_enabled();
-
-	/*
-	 * Note, instruction fetches and writes are mutually exclusive, ignore
-	 * the "exec" flag.
-	 */
-	return fault->write;
-}
-
-/*
- * Returns true if the SPTE was fixed successfully. Otherwise,
- * someone else modified the SPTE from its original value.
- */
-static bool
-fast_pf_fix_direct_spte(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
-			u64 *sptep, u64 old_spte, u64 new_spte)
-{
-	/*
-	 * Theoretically we could also set dirty bit (and flush TLB) here in
-	 * order to eliminate unnecessary PML logging. See comments in
-	 * set_spte. But fast_page_fault is very unlikely to happen with PML
-	 * enabled, so we do not do this. This might result in the same GPA
-	 * to be logged in PML buffer again when the write really happens, and
-	 * eventually to be called by mark_page_dirty twice. But it's also no
-	 * harm. This also avoids the TLB flush needed after setting dirty bit
-	 * so non-PML cases won't be impacted.
-	 *
-	 * Compare with set_spte where instead shadow_dirty_mask is set.
-	 */
-	if (!try_cmpxchg64(sptep, &old_spte, new_spte))
-		return false;
-
-	if (is_writable_pte(new_spte) && !is_writable_pte(old_spte))
-		mark_page_dirty_in_slot(vcpu->kvm, fault->slot, fault->gfn);
-
-	return true;
-}
-
-static bool is_access_allowed(struct kvm_page_fault *fault, u64 spte)
-{
-	if (fault->exec)
-		return is_executable_pte(spte);
-
-	if (fault->write)
-		return is_writable_pte(spte);
-
-	/* Fault was on Read access */
-	return spte & PT_PRESENT_MASK;
-}
-
-/*
- * Returns the last level spte pointer of the shadow page walk for the given
- * gpa, and sets *spte to the spte value. This spte may be non-preset. If no
- * walk could be performed, returns NULL and *spte does not contain valid data.
- *
- * Contract:
- *  - Must be called between walk_shadow_page_lockless_{begin,end}.
- *  - The returned sptep must not be used after walk_shadow_page_lockless_end.
- */
-static u64 *fast_pf_get_last_sptep(struct kvm_vcpu *vcpu, gpa_t gpa, u64 *spte)
-{
-	struct kvm_shadow_walk_iterator iterator;
-	u64 old_spte;
-	u64 *sptep = NULL;
-
-	for_each_shadow_entry_lockless(vcpu, gpa, iterator, old_spte) {
-		sptep = iterator.sptep;
-		*spte = old_spte;
-	}
-
-	return sptep;
-}
-
-/*
- * Returns one of RET_PF_INVALID, RET_PF_FIXED or RET_PF_SPURIOUS.
- */
-static int fast_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
-{
-	struct kvm_mmu_page *sp;
-	int ret = RET_PF_INVALID;
-	u64 spte = 0ull;
-	u64 *sptep = NULL;
-	uint retry_count = 0;
-
-	if (!page_fault_can_be_fast(fault))
-		return ret;
-
-	walk_shadow_page_lockless_begin(vcpu);
-
-	do {
-		u64 new_spte;
-
-		if (is_tdp_mmu(vcpu->arch.mmu))
-			sptep = kvm_tdp_mmu_fast_pf_get_last_sptep(vcpu, fault->addr, &spte);
-		else
-			sptep = fast_pf_get_last_sptep(vcpu, fault->addr, &spte);
-
-		if (!is_shadow_present_pte(spte))
-			break;
-
-		sp = sptep_to_sp(sptep);
-		if (!is_last_spte(spte, sp->role.level))
-			break;
-
-		/*
-		 * Check whether the memory access that caused the fault would
-		 * still cause it if it were to be performed right now. If not,
-		 * then this is a spurious fault caused by TLB lazily flushed,
-		 * or some other CPU has already fixed the PTE after the
-		 * current CPU took the fault.
-		 *
-		 * Need not check the access of upper level table entries since
-		 * they are always ACC_ALL.
-		 */
-		if (is_access_allowed(fault, spte)) {
-			ret = RET_PF_SPURIOUS;
-			break;
-		}
-
-		new_spte = spte;
-
-		/*
-		 * KVM only supports fixing page faults outside of MMU lock for
-		 * direct MMUs, nested MMUs are always indirect, and KVM always
-		 * uses A/D bits for non-nested MMUs.  Thus, if A/D bits are
-		 * enabled, the SPTE can't be an access-tracked SPTE.
-		 */
-		if (unlikely(!kvm_ad_enabled()) && is_access_track_spte(spte))
-			new_spte = restore_acc_track_spte(new_spte);
-
-		/*
-		 * To keep things simple, only SPTEs that are MMU-writable can
-		 * be made fully writable outside of mmu_lock, e.g. only SPTEs
-		 * that were write-protected for dirty-logging or access
-		 * tracking are handled here.  Don't bother checking if the
-		 * SPTE is writable to prioritize running with A/D bits enabled.
-		 * The is_access_allowed() check above handles the common case
-		 * of the fault being spurious, and the SPTE is known to be
-		 * shadow-present, i.e. except for access tracking restoration
-		 * making the new SPTE writable, the check is wasteful.
-		 */
-		if (fault->write && is_mmu_writable_spte(spte)) {
-			new_spte |= PT_WRITABLE_MASK;
-
-			/*
-			 * Do not fix write-permission on the large spte when
-			 * dirty logging is enabled. Since we only dirty the
-			 * first page into the dirty-bitmap in
-			 * fast_pf_fix_direct_spte(), other pages are missed
-			 * if its slot has dirty logging enabled.
-			 *
-			 * Instead, we let the slow page fault path create a
-			 * normal spte to fix the access.
-			 */
-			if (sp->role.level > PG_LEVEL_4K &&
-			    kvm_slot_dirty_track_enabled(fault->slot))
-				break;
-		}
-
-		/* Verify that the fault can be handled in the fast path */
-		if (new_spte == spte ||
-		    !is_access_allowed(fault, new_spte))
-			break;
-
-		/*
-		 * Currently, fast page fault only works for direct mapping
-		 * since the gfn is not stable for indirect shadow page. See
-		 * Documentation/virt/kvm/locking.rst to get more detail.
-		 */
-		if (fast_pf_fix_direct_spte(vcpu, fault, sptep, spte, new_spte)) {
-			ret = RET_PF_FIXED;
-			break;
-		}
-
-		if (++retry_count > 4) {
-			printk_once(KERN_WARNING
-				"kvm: Fast #PF retrying more than 4 times.\n");
-			break;
-		}
-
-	} while (true);
-
-	trace_fast_page_fault(vcpu, fault, sptep, spte, ret);
-	walk_shadow_page_lockless_end(vcpu);
-
-	if (ret != RET_PF_INVALID)
-		vcpu->stat.pf_fast++;
-
-	return ret;
-}
-
-static void mmu_free_root_page(struct kvm *kvm, hpa_t *root_hpa,
-			       struct list_head *invalid_list)
-{
-	struct kvm_mmu_page *sp;
-
-	if (!VALID_PAGE(*root_hpa))
-		return;
-
-	/*
-	 * The "root" may be a special root, e.g. a PAE entry, treat it as a
-	 * SPTE to ensure any non-PA bits are dropped.
-	 */
-	sp = spte_to_child_sp(*root_hpa);
-	if (WARN_ON(!sp))
-		return;
-
-	if (is_tdp_mmu_page(sp))
-		kvm_tdp_mmu_put_root(kvm, sp, false);
-	else if (!--sp->root_count && sp->role.invalid)
-		kvm_mmu_prepare_zap_page(kvm, sp, invalid_list);
-
-	*root_hpa = INVALID_PAGE;
-}
-
-/* roots_to_free must be some combination of the KVM_MMU_ROOT_* flags */
-void kvm_mmu_free_roots(struct kvm *kvm, struct kvm_mmu *mmu,
-			ulong roots_to_free)
-{
-	int i;
-	LIST_HEAD(invalid_list);
-	bool free_active_root;
-
-	BUILD_BUG_ON(KVM_MMU_NUM_PREV_ROOTS >= BITS_PER_LONG);
-
-	/* Before acquiring the MMU lock, see if we need to do any real work. */
-	free_active_root = (roots_to_free & KVM_MMU_ROOT_CURRENT)
-		&& VALID_PAGE(mmu->root.hpa);
-
-	if (!free_active_root) {
-		for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
-			if ((roots_to_free & KVM_MMU_ROOT_PREVIOUS(i)) &&
-			    VALID_PAGE(mmu->prev_roots[i].hpa))
-				break;
-
-		if (i == KVM_MMU_NUM_PREV_ROOTS)
-			return;
-	}
-
-	write_lock(&kvm->mmu_lock);
-
-	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
-		if (roots_to_free & KVM_MMU_ROOT_PREVIOUS(i))
-			mmu_free_root_page(kvm, &mmu->prev_roots[i].hpa,
-					   &invalid_list);
-
-	if (free_active_root) {
-		if (to_shadow_page(mmu->root.hpa)) {
-			mmu_free_root_page(kvm, &mmu->root.hpa, &invalid_list);
-		} else if (mmu->pae_root) {
-			for (i = 0; i < 4; ++i) {
-				if (!IS_VALID_PAE_ROOT(mmu->pae_root[i]))
-					continue;
-
-				mmu_free_root_page(kvm, &mmu->pae_root[i],
-						   &invalid_list);
-				mmu->pae_root[i] = INVALID_PAE_ROOT;
-			}
-		}
-		mmu->root.hpa = INVALID_PAGE;
-		mmu->root.pgd = 0;
-	}
-
-	kvm_mmu_commit_zap_page(kvm, &invalid_list);
-	write_unlock(&kvm->mmu_lock);
-}
-EXPORT_SYMBOL_GPL(kvm_mmu_free_roots);
-
-void kvm_mmu_free_guest_mode_roots(struct kvm *kvm, struct kvm_mmu *mmu)
-{
-	unsigned long roots_to_free = 0;
-	hpa_t root_hpa;
-	int i;
-
-	/*
-	 * This should not be called while L2 is active, L2 can't invalidate
-	 * _only_ its own roots, e.g. INVVPID unconditionally exits.
-	 */
-	WARN_ON_ONCE(mmu->root_role.guest_mode);
-
-	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
-		root_hpa = mmu->prev_roots[i].hpa;
-		if (!VALID_PAGE(root_hpa))
-			continue;
-
-		if (!to_shadow_page(root_hpa) ||
-			to_shadow_page(root_hpa)->role.guest_mode)
-			roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
-	}
-
-	kvm_mmu_free_roots(kvm, mmu, roots_to_free);
-}
-EXPORT_SYMBOL_GPL(kvm_mmu_free_guest_mode_roots);
-
-
-static int mmu_check_root(struct kvm_vcpu *vcpu, gfn_t root_gfn)
-{
-	int ret = 0;
-
-	if (!kvm_vcpu_is_visible_gfn(vcpu, root_gfn)) {
-		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
-		ret = 1;
-	}
-
-	return ret;
-}
-
-static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
-			    u8 level)
-{
-	union kvm_mmu_page_role role = vcpu->arch.mmu->root_role;
-	struct kvm_mmu_page *sp;
-
-	role.level = level;
-	role.quadrant = quadrant;
-
-	WARN_ON_ONCE(quadrant && !role.has_4_byte_gpte);
-	WARN_ON_ONCE(role.direct && role.has_4_byte_gpte);
-
-	sp = kvm_mmu_get_shadow_page(vcpu, gfn, role);
-	++sp->root_count;
-
-	return __pa(sp->spt);
-}
-
-static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
-{
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
-	u8 shadow_root_level = mmu->root_role.level;
-	hpa_t root;
-	unsigned i;
-	int r;
-
-	write_lock(&vcpu->kvm->mmu_lock);
-	r = make_mmu_pages_available(vcpu);
-	if (r < 0)
-		goto out_unlock;
-
-	if (is_tdp_mmu_enabled(vcpu->kvm)) {
-		root = kvm_tdp_mmu_get_vcpu_root_hpa(vcpu);
-		mmu->root.hpa = root;
-	} else if (shadow_root_level >= PT64_ROOT_4LEVEL) {
-		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level);
-		mmu->root.hpa = root;
-	} else if (shadow_root_level == PT32E_ROOT_LEVEL) {
-		if (WARN_ON_ONCE(!mmu->pae_root)) {
-			r = -EIO;
-			goto out_unlock;
-		}
-
-		for (i = 0; i < 4; ++i) {
-			WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
-
-			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), 0,
-					      PT32_ROOT_LEVEL);
-			mmu->pae_root[i] = root | PT_PRESENT_MASK |
-					   shadow_me_value;
-		}
-		mmu->root.hpa = __pa(mmu->pae_root);
-	} else {
-		WARN_ONCE(1, "Bad TDP root level = %d\n", shadow_root_level);
-		r = -EIO;
-		goto out_unlock;
-	}
-
-	/* root.pgd is ignored for direct MMUs. */
-	mmu->root.pgd = 0;
-out_unlock:
-	write_unlock(&vcpu->kvm->mmu_lock);
-	return r;
-}
-
-static int mmu_first_shadow_root_alloc(struct kvm *kvm)
-{
-	struct kvm_memslots *slots;
-	struct kvm_memory_slot *slot;
-	int r = 0, i, bkt;
-
-	/*
-	 * Check if this is the first shadow root being allocated before
-	 * taking the lock.
-	 */
-	if (kvm_shadow_root_allocated(kvm))
-		return 0;
-
-	mutex_lock(&kvm->slots_arch_lock);
-
-	/* Recheck, under the lock, whether this is the first shadow root. */
-	if (kvm_shadow_root_allocated(kvm))
-		goto out_unlock;
-
-	/*
-	 * Check if anything actually needs to be allocated, e.g. all metadata
-	 * will be allocated upfront if TDP is disabled.
-	 */
-	if (kvm_memslots_have_rmaps(kvm) &&
-	    kvm_page_track_write_tracking_enabled(kvm))
-		goto out_success;
-
-	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
-		slots = __kvm_memslots(kvm, i);
-		kvm_for_each_memslot(slot, bkt, slots) {
-			/*
-			 * Both of these functions are no-ops if the target is
-			 * already allocated, so unconditionally calling both
-			 * is safe.  Intentionally do NOT free allocations on
-			 * failure to avoid having to track which allocations
-			 * were made now versus when the memslot was created.
-			 * The metadata is guaranteed to be freed when the slot
-			 * is freed, and will be kept/used if userspace retries
-			 * KVM_RUN instead of killing the VM.
-			 */
-			r = memslot_rmap_alloc(slot, slot->npages);
-			if (r)
-				goto out_unlock;
-			r = kvm_page_track_write_tracking_alloc(slot);
-			if (r)
-				goto out_unlock;
-		}
-	}
-
-	/*
-	 * Ensure that shadow_root_allocated becomes true strictly after
-	 * all the related pointers are set.
-	 */
-out_success:
-	smp_store_release(&kvm->arch.shadow_root_allocated, true);
-
-out_unlock:
-	mutex_unlock(&kvm->slots_arch_lock);
-	return r;
-}
-
-static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
-{
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
-	u64 pdptrs[4], pm_mask;
-	gfn_t root_gfn, root_pgd;
-	int quadrant, i, r;
-	hpa_t root;
-
-	root_pgd = mmu->get_guest_pgd(vcpu);
-	root_gfn = root_pgd >> PAGE_SHIFT;
-
-	if (mmu_check_root(vcpu, root_gfn))
-		return 1;
-
-	/*
-	 * On SVM, reading PDPTRs might access guest memory, which might fault
-	 * and thus might sleep.  Grab the PDPTRs before acquiring mmu_lock.
-	 */
-	if (mmu->cpu_role.base.level == PT32E_ROOT_LEVEL) {
-		for (i = 0; i < 4; ++i) {
-			pdptrs[i] = mmu->get_pdptr(vcpu, i);
-			if (!(pdptrs[i] & PT_PRESENT_MASK))
-				continue;
-
-			if (mmu_check_root(vcpu, pdptrs[i] >> PAGE_SHIFT))
-				return 1;
-		}
-	}
-
-	r = mmu_first_shadow_root_alloc(vcpu->kvm);
-	if (r)
-		return r;
-
-	write_lock(&vcpu->kvm->mmu_lock);
-	r = make_mmu_pages_available(vcpu);
-	if (r < 0)
-		goto out_unlock;
-
-	/*
-	 * Do we shadow a long mode page table? If so we need to
-	 * write-protect the guests page table root.
-	 */
-	if (mmu->cpu_role.base.level >= PT64_ROOT_4LEVEL) {
-		root = mmu_alloc_root(vcpu, root_gfn, 0,
-				      mmu->root_role.level);
-		mmu->root.hpa = root;
-		goto set_root_pgd;
-	}
-
-	if (WARN_ON_ONCE(!mmu->pae_root)) {
-		r = -EIO;
-		goto out_unlock;
-	}
-
-	/*
-	 * We shadow a 32 bit page table. This may be a legacy 2-level
-	 * or a PAE 3-level page table. In either case we need to be aware that
-	 * the shadow page table may be a PAE or a long mode page table.
-	 */
-	pm_mask = PT_PRESENT_MASK | shadow_me_value;
-	if (mmu->root_role.level >= PT64_ROOT_4LEVEL) {
-		pm_mask |= PT_ACCESSED_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
-
-		if (WARN_ON_ONCE(!mmu->pml4_root)) {
-			r = -EIO;
-			goto out_unlock;
-		}
-		mmu->pml4_root[0] = __pa(mmu->pae_root) | pm_mask;
-
-		if (mmu->root_role.level == PT64_ROOT_5LEVEL) {
-			if (WARN_ON_ONCE(!mmu->pml5_root)) {
-				r = -EIO;
-				goto out_unlock;
-			}
-			mmu->pml5_root[0] = __pa(mmu->pml4_root) | pm_mask;
-		}
-	}
-
-	for (i = 0; i < 4; ++i) {
-		WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
-
-		if (mmu->cpu_role.base.level == PT32E_ROOT_LEVEL) {
-			if (!(pdptrs[i] & PT_PRESENT_MASK)) {
-				mmu->pae_root[i] = INVALID_PAE_ROOT;
-				continue;
-			}
-			root_gfn = pdptrs[i] >> PAGE_SHIFT;
-		}
-
-		/*
-		 * If shadowing 32-bit non-PAE page tables, each PAE page
-		 * directory maps one quarter of the guest's non-PAE page
-		 * directory. Othwerise each PAE page direct shadows one guest
-		 * PAE page directory so that quadrant should be 0.
-		 */
-		quadrant = (mmu->cpu_role.base.level == PT32_ROOT_LEVEL) ? i : 0;
-
-		root = mmu_alloc_root(vcpu, root_gfn, quadrant, PT32_ROOT_LEVEL);
-		mmu->pae_root[i] = root | pm_mask;
-	}
-
-	if (mmu->root_role.level == PT64_ROOT_5LEVEL)
-		mmu->root.hpa = __pa(mmu->pml5_root);
-	else if (mmu->root_role.level == PT64_ROOT_4LEVEL)
-		mmu->root.hpa = __pa(mmu->pml4_root);
-	else
-		mmu->root.hpa = __pa(mmu->pae_root);
-
-set_root_pgd:
-	mmu->root.pgd = root_pgd;
-out_unlock:
-	write_unlock(&vcpu->kvm->mmu_lock);
-
-	return r;
-}
-
-static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
-{
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
-	bool need_pml5 = mmu->root_role.level > PT64_ROOT_4LEVEL;
-	u64 *pml5_root = NULL;
-	u64 *pml4_root = NULL;
-	u64 *pae_root;
-
-	/*
-	 * When shadowing 32-bit or PAE NPT with 64-bit NPT, the PML4 and PDP
-	 * tables are allocated and initialized at root creation as there is no
-	 * equivalent level in the guest's NPT to shadow.  Allocate the tables
-	 * on demand, as running a 32-bit L1 VMM on 64-bit KVM is very rare.
-	 */
-	if (mmu->root_role.direct ||
-	    mmu->cpu_role.base.level >= PT64_ROOT_4LEVEL ||
-	    mmu->root_role.level < PT64_ROOT_4LEVEL)
-		return 0;
-
-	/*
-	 * NPT, the only paging mode that uses this horror, uses a fixed number
-	 * of levels for the shadow page tables, e.g. all MMUs are 4-level or
-	 * all MMus are 5-level.  Thus, this can safely require that pml5_root
-	 * is allocated if the other roots are valid and pml5 is needed, as any
-	 * prior MMU would also have required pml5.
-	 */
-	if (mmu->pae_root && mmu->pml4_root && (!need_pml5 || mmu->pml5_root))
-		return 0;
-
-	/*
-	 * The special roots should always be allocated in concert.  Yell and
-	 * bail if KVM ends up in a state where only one of the roots is valid.
-	 */
-	if (WARN_ON_ONCE(!tdp_enabled || mmu->pae_root || mmu->pml4_root ||
-			 (need_pml5 && mmu->pml5_root)))
-		return -EIO;
-
-	/*
-	 * Unlike 32-bit NPT, the PDP table doesn't need to be in low mem, and
-	 * doesn't need to be decrypted.
-	 */
-	pae_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
-	if (!pae_root)
-		return -ENOMEM;
-
-#ifdef CONFIG_X86_64
-	pml4_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
-	if (!pml4_root)
-		goto err_pml4;
+		if (++retry_count > 4) {
+			printk_once(KERN_WARNING
+				"kvm: Fast #PF retrying more than 4 times.\n");
+			break;
+		}
 
-	if (need_pml5) {
-		pml5_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
-		if (!pml5_root)
-			goto err_pml5;
-	}
-#endif
+	} while (true);
 
-	mmu->pae_root = pae_root;
-	mmu->pml4_root = pml4_root;
-	mmu->pml5_root = pml5_root;
+	trace_fast_page_fault(vcpu, fault, sptep, spte, ret);
+	walk_shadow_page_lockless_end(vcpu);
 
-	return 0;
+	if (ret != RET_PF_INVALID)
+		vcpu->stat.pf_fast++;
 
-#ifdef CONFIG_X86_64
-err_pml5:
-	free_page((unsigned long)pml4_root);
-err_pml4:
-	free_page((unsigned long)pae_root);
-	return -ENOMEM;
-#endif
+	return ret;
 }
 
-static bool is_unsync_root(hpa_t root)
+static void mmu_free_root_page(struct kvm *kvm, hpa_t *root_hpa,
+			       struct list_head *invalid_list)
 {
 	struct kvm_mmu_page *sp;
 
-	if (!VALID_PAGE(root))
-		return false;
-
-	/*
-	 * The read barrier orders the CPU's read of SPTE.W during the page table
-	 * walk before the reads of sp->unsync/sp->unsync_children here.
-	 *
-	 * Even if another CPU was marking the SP as unsync-ed simultaneously,
-	 * any guest page table changes are not guaranteed to be visible anyway
-	 * until this VCPU issues a TLB flush strictly after those changes are
-	 * made.  We only need to ensure that the other CPU sets these flags
-	 * before any actual changes to the page tables are made.  The comments
-	 * in mmu_try_to_unsync_pages() describe what could go wrong if this
-	 * requirement isn't satisfied.
-	 */
-	smp_rmb();
-	sp = to_shadow_page(root);
+	if (!VALID_PAGE(*root_hpa))
+		return;
 
 	/*
-	 * PAE roots (somewhat arbitrarily) aren't backed by shadow pages, the
-	 * PDPTEs for a given PAE root need to be synchronized individually.
+	 * The "root" may be a special root, e.g. a PAE entry, treat it as a
+	 * SPTE to ensure any non-PA bits are dropped.
 	 */
-	if (WARN_ON_ONCE(!sp))
-		return false;
+	sp = spte_to_child_sp(*root_hpa);
+	if (WARN_ON(!sp))
+		return;
 
-	if (sp->unsync || sp->unsync_children)
-		return true;
+	if (is_tdp_mmu_page(sp))
+		kvm_tdp_mmu_put_root(kvm, sp, false);
+	else if (!--sp->root_count && sp->role.invalid)
+		kvm_mmu_prepare_zap_page(kvm, sp, invalid_list);
 
-	return false;
+	*root_hpa = INVALID_PAGE;
 }
 
-void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
+/* roots_to_free must be some combination of the KVM_MMU_ROOT_* flags */
+void kvm_mmu_free_roots(struct kvm *kvm, struct kvm_mmu *mmu,
+			ulong roots_to_free)
 {
 	int i;
-	struct kvm_mmu_page *sp;
-
-	if (vcpu->arch.mmu->root_role.direct)
-		return;
+	LIST_HEAD(invalid_list);
+	bool free_active_root;
 
-	if (!VALID_PAGE(vcpu->arch.mmu->root.hpa))
-		return;
+	BUILD_BUG_ON(KVM_MMU_NUM_PREV_ROOTS >= BITS_PER_LONG);
 
-	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
+	/* Before acquiring the MMU lock, see if we need to do any real work. */
+	free_active_root = (roots_to_free & KVM_MMU_ROOT_CURRENT)
+		&& VALID_PAGE(mmu->root.hpa);
 
-	if (vcpu->arch.mmu->cpu_role.base.level >= PT64_ROOT_4LEVEL) {
-		hpa_t root = vcpu->arch.mmu->root.hpa;
-		sp = to_shadow_page(root);
+	if (!free_active_root) {
+		for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
+			if ((roots_to_free & KVM_MMU_ROOT_PREVIOUS(i)) &&
+			    VALID_PAGE(mmu->prev_roots[i].hpa))
+				break;
 
-		if (!is_unsync_root(root))
+		if (i == KVM_MMU_NUM_PREV_ROOTS)
 			return;
-
-		write_lock(&vcpu->kvm->mmu_lock);
-		mmu_sync_children(vcpu, sp, true);
-		write_unlock(&vcpu->kvm->mmu_lock);
-		return;
 	}
 
-	write_lock(&vcpu->kvm->mmu_lock);
+	write_lock(&kvm->mmu_lock);
+
+	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
+		if (roots_to_free & KVM_MMU_ROOT_PREVIOUS(i))
+			mmu_free_root_page(kvm, &mmu->prev_roots[i].hpa,
+					   &invalid_list);
 
-	for (i = 0; i < 4; ++i) {
-		hpa_t root = vcpu->arch.mmu->pae_root[i];
+	if (free_active_root) {
+		if (to_shadow_page(mmu->root.hpa)) {
+			mmu_free_root_page(kvm, &mmu->root.hpa, &invalid_list);
+		} else if (mmu->pae_root) {
+			for (i = 0; i < 4; ++i) {
+				if (!IS_VALID_PAE_ROOT(mmu->pae_root[i]))
+					continue;
 
-		if (IS_VALID_PAE_ROOT(root)) {
-			sp = spte_to_child_sp(root);
-			mmu_sync_children(vcpu, sp, true);
+				mmu_free_root_page(kvm, &mmu->pae_root[i],
+						   &invalid_list);
+				mmu->pae_root[i] = INVALID_PAE_ROOT;
+			}
 		}
+		mmu->root.hpa = INVALID_PAGE;
+		mmu->root.pgd = 0;
 	}
 
-	write_unlock(&vcpu->kvm->mmu_lock);
+	kvm_mmu_commit_zap_page(kvm, &invalid_list);
+	write_unlock(&kvm->mmu_lock);
 }
+EXPORT_SYMBOL_GPL(kvm_mmu_free_roots);
 
-void kvm_mmu_sync_prev_roots(struct kvm_vcpu *vcpu)
+static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 {
-	unsigned long roots_to_free = 0;
-	int i;
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	u8 shadow_root_level = mmu->root_role.level;
+	hpa_t root;
+	unsigned i;
+	int r;
 
-	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
-		if (is_unsync_root(vcpu->arch.mmu->prev_roots[i].hpa))
-			roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
+	write_lock(&vcpu->kvm->mmu_lock);
+	r = make_mmu_pages_available(vcpu);
+	if (r < 0)
+		goto out_unlock;
+
+	if (is_tdp_mmu_enabled(vcpu->kvm)) {
+		root = kvm_tdp_mmu_get_vcpu_root_hpa(vcpu);
+		mmu->root.hpa = root;
+	} else if (shadow_root_level >= PT64_ROOT_4LEVEL) {
+		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level);
+		mmu->root.hpa = root;
+	} else if (shadow_root_level == PT32E_ROOT_LEVEL) {
+		if (WARN_ON_ONCE(!mmu->pae_root)) {
+			r = -EIO;
+			goto out_unlock;
+		}
+
+		for (i = 0; i < 4; ++i) {
+			WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
 
-	/* sync prev_roots by simply freeing them */
-	kvm_mmu_free_roots(vcpu->kvm, vcpu->arch.mmu, roots_to_free);
+			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), 0,
+					      PT32_ROOT_LEVEL);
+			mmu->pae_root[i] = root | PT_PRESENT_MASK |
+					   shadow_me_value;
+		}
+		mmu->root.hpa = __pa(mmu->pae_root);
+	} else {
+		WARN_ONCE(1, "Bad TDP root level = %d\n", shadow_root_level);
+		r = -EIO;
+		goto out_unlock;
+	}
+
+	/* root.pgd is ignored for direct MMUs. */
+	mmu->root.pgd = 0;
+out_unlock:
+	write_unlock(&vcpu->kvm->mmu_lock);
+	return r;
 }
 
 static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
@@ -3984,31 +1191,6 @@ static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
 	return vcpu_match_mmio_gva(vcpu, addr);
 }
 
-/*
- * Return the level of the lowest level SPTE added to sptes.
- * That SPTE may be non-present.
- *
- * Must be called between walk_shadow_page_lockless_{begin,end}.
- */
-static int get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes, int *root_level)
-{
-	struct kvm_shadow_walk_iterator iterator;
-	int leaf = -1;
-	u64 spte;
-
-	for (shadow_walk_init(&iterator, vcpu, addr),
-	     *root_level = iterator.level;
-	     shadow_walk_okay(&iterator);
-	     __shadow_walk_next(&iterator, spte)) {
-		leaf = iterator.level;
-		spte = mmu_spte_get_lockless(iterator.sptep);
-
-		sptes[leaf] = spte;
-	}
-
-	return leaf;
-}
-
 /* return true if reserved bit(s) are detected on a valid, non-MMIO SPTE. */
 static bool get_mmio_spte(struct kvm_vcpu *vcpu, u64 addr, u64 *sptep)
 {
@@ -4112,17 +1294,6 @@ static bool page_fault_handle_page_track(struct kvm_vcpu *vcpu,
 	return false;
 }
 
-static void shadow_page_table_clear_flood(struct kvm_vcpu *vcpu, gva_t addr)
-{
-	struct kvm_shadow_walk_iterator iterator;
-	u64 spte;
-
-	walk_shadow_page_lockless_begin(vcpu);
-	for_each_shadow_entry_lockless(vcpu, addr, iterator, spte)
-		clear_sp_write_flooding_count(iterator.sptep);
-	walk_shadow_page_lockless_end(vcpu);
-}
-
 static u32 alloc_apf_token(struct kvm_vcpu *vcpu)
 {
 	/* make sure the token value is not 0 */
@@ -5305,264 +2476,65 @@ void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu->arch.nested_mmu.root_role.word = 0;
 	vcpu->arch.root_mmu.cpu_role.ext.valid = 0;
 	vcpu->arch.guest_mmu.cpu_role.ext.valid = 0;
-	vcpu->arch.nested_mmu.cpu_role.ext.valid = 0;
-	kvm_mmu_reset_context(vcpu);
-
-	/*
-	 * Changing guest CPUID after KVM_RUN is forbidden, see the comment in
-	 * kvm_arch_vcpu_ioctl().
-	 */
-	KVM_BUG_ON(vcpu->arch.last_vmentry_cpu != -1, vcpu->kvm);
-}
-
-void kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
-{
-	kvm_mmu_unload(vcpu);
-	kvm_init_mmu(vcpu);
-}
-EXPORT_SYMBOL_GPL(kvm_mmu_reset_context);
-
-int kvm_mmu_load(struct kvm_vcpu *vcpu)
-{
-	int r;
-
-	r = mmu_topup_memory_caches(vcpu, !vcpu->arch.mmu->root_role.direct);
-	if (r)
-		goto out;
-	r = mmu_alloc_special_roots(vcpu);
-	if (r)
-		goto out;
-	if (vcpu->arch.mmu->root_role.direct)
-		r = mmu_alloc_direct_roots(vcpu);
-	else
-		r = mmu_alloc_shadow_roots(vcpu);
-	if (r)
-		goto out;
-
-	kvm_mmu_sync_roots(vcpu);
-
-	kvm_mmu_load_pgd(vcpu);
-
-	/*
-	 * Flush any TLB entries for the new root, the provenance of the root
-	 * is unknown.  Even if KVM ensures there are no stale TLB entries
-	 * for a freed root, in theory another hypervisor could have left
-	 * stale entries.  Flushing on alloc also allows KVM to skip the TLB
-	 * flush when freeing a root (see kvm_tdp_mmu_put_root()).
-	 */
-	static_call(kvm_x86_flush_tlb_current)(vcpu);
-out:
-	return r;
-}
-
-void kvm_mmu_unload(struct kvm_vcpu *vcpu)
-{
-	struct kvm *kvm = vcpu->kvm;
-
-	kvm_mmu_free_roots(kvm, &vcpu->arch.root_mmu, KVM_MMU_ROOTS_ALL);
-	WARN_ON(VALID_PAGE(vcpu->arch.root_mmu.root.hpa));
-	kvm_mmu_free_roots(kvm, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
-	WARN_ON(VALID_PAGE(vcpu->arch.guest_mmu.root.hpa));
-	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
-}
-
-static bool is_obsolete_root(struct kvm *kvm, hpa_t root_hpa)
-{
-	struct kvm_mmu_page *sp;
-
-	if (!VALID_PAGE(root_hpa))
-		return false;
-
-	/*
-	 * When freeing obsolete roots, treat roots as obsolete if they don't
-	 * have an associated shadow page.  This does mean KVM will get false
-	 * positives and free roots that don't strictly need to be freed, but
-	 * such false positives are relatively rare:
-	 *
-	 *  (a) only PAE paging and nested NPT has roots without shadow pages
-	 *  (b) remote reloads due to a memslot update obsoletes _all_ roots
-	 *  (c) KVM doesn't track previous roots for PAE paging, and the guest
-	 *      is unlikely to zap an in-use PGD.
-	 */
-	sp = to_shadow_page(root_hpa);
-	return !sp || is_obsolete_sp(kvm, sp);
-}
-
-static void __kvm_mmu_free_obsolete_roots(struct kvm *kvm, struct kvm_mmu *mmu)
-{
-	unsigned long roots_to_free = 0;
-	int i;
-
-	if (is_obsolete_root(kvm, mmu->root.hpa))
-		roots_to_free |= KVM_MMU_ROOT_CURRENT;
-
-	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
-		if (is_obsolete_root(kvm, mmu->prev_roots[i].hpa))
-			roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
-	}
-
-	if (roots_to_free)
-		kvm_mmu_free_roots(kvm, mmu, roots_to_free);
-}
-
-void kvm_mmu_free_obsolete_roots(struct kvm_vcpu *vcpu)
-{
-	__kvm_mmu_free_obsolete_roots(vcpu->kvm, &vcpu->arch.root_mmu);
-	__kvm_mmu_free_obsolete_roots(vcpu->kvm, &vcpu->arch.guest_mmu);
-}
-
-static u64 mmu_pte_write_fetch_gpte(struct kvm_vcpu *vcpu, gpa_t *gpa,
-				    int *bytes)
-{
-	u64 gentry = 0;
-	int r;
-
-	/*
-	 * Assume that the pte write on a page table of the same type
-	 * as the current vcpu paging mode since we update the sptes only
-	 * when they have the same mode.
-	 */
-	if (is_pae(vcpu) && *bytes == 4) {
-		/* Handle a 32-bit guest writing two halves of a 64-bit gpte */
-		*gpa &= ~(gpa_t)7;
-		*bytes = 8;
-	}
-
-	if (*bytes == 4 || *bytes == 8) {
-		r = kvm_vcpu_read_guest_atomic(vcpu, *gpa, &gentry, *bytes);
-		if (r)
-			gentry = 0;
-	}
-
-	return gentry;
-}
-
-/*
- * If we're seeing too many writes to a page, it may no longer be a page table,
- * or we may be forking, in which case it is better to unmap the page.
- */
-static bool detect_write_flooding(struct kvm_mmu_page *sp)
-{
-	/*
-	 * Skip write-flooding detected for the sp whose level is 1, because
-	 * it can become unsync, then the guest page is not write-protected.
-	 */
-	if (sp->role.level == PG_LEVEL_4K)
-		return false;
-
-	atomic_inc(&sp->write_flooding_count);
-	return atomic_read(&sp->write_flooding_count) >= 3;
-}
-
-/*
- * Misaligned accesses are too much trouble to fix up; also, they usually
- * indicate a page is not used as a page table.
- */
-static bool detect_write_misaligned(struct kvm_mmu_page *sp, gpa_t gpa,
-				    int bytes)
-{
-	unsigned offset, pte_size, misaligned;
-
-	pgprintk("misaligned: gpa %llx bytes %d role %x\n",
-		 gpa, bytes, sp->role.word);
-
-	offset = offset_in_page(gpa);
-	pte_size = sp->role.has_4_byte_gpte ? 4 : 8;
+	vcpu->arch.nested_mmu.cpu_role.ext.valid = 0;
+	kvm_mmu_reset_context(vcpu);
 
 	/*
-	 * Sometimes, the OS only writes the last one bytes to update status
-	 * bits, for example, in linux, andb instruction is used in clear_bit().
+	 * Changing guest CPUID after KVM_RUN is forbidden, see the comment in
+	 * kvm_arch_vcpu_ioctl().
 	 */
-	if (!(offset & (pte_size - 1)) && bytes == 1)
-		return false;
-
-	misaligned = (offset ^ (offset + bytes - 1)) & ~(pte_size - 1);
-	misaligned |= bytes < 4;
-
-	return misaligned;
+	KVM_BUG_ON(vcpu->arch.last_vmentry_cpu != -1, vcpu->kvm);
 }
 
-static u64 *get_written_sptes(struct kvm_mmu_page *sp, gpa_t gpa, int *nspte)
+void kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
 {
-	unsigned page_offset, quadrant;
-	u64 *spte;
-	int level;
-
-	page_offset = offset_in_page(gpa);
-	level = sp->role.level;
-	*nspte = 1;
-	if (sp->role.has_4_byte_gpte) {
-		page_offset <<= 1;	/* 32->64 */
-		/*
-		 * A 32-bit pde maps 4MB while the shadow pdes map
-		 * only 2MB.  So we need to double the offset again
-		 * and zap two pdes instead of one.
-		 */
-		if (level == PT32_ROOT_LEVEL) {
-			page_offset &= ~7; /* kill rounding error */
-			page_offset <<= 1;
-			*nspte = 2;
-		}
-		quadrant = page_offset >> PAGE_SHIFT;
-		page_offset &= ~PAGE_MASK;
-		if (quadrant != sp->role.quadrant)
-			return NULL;
-	}
-
-	spte = &sp->spt[page_offset / sizeof(*spte)];
-	return spte;
+	kvm_mmu_unload(vcpu);
+	kvm_init_mmu(vcpu);
 }
+EXPORT_SYMBOL_GPL(kvm_mmu_reset_context);
 
-static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
-			      const u8 *new, int bytes,
-			      struct kvm_page_track_notifier_node *node)
+int kvm_mmu_load(struct kvm_vcpu *vcpu)
 {
-	gfn_t gfn = gpa >> PAGE_SHIFT;
-	struct kvm_mmu_page *sp;
-	LIST_HEAD(invalid_list);
-	u64 entry, gentry, *spte;
-	int npte;
-	bool flush = false;
-
-	/*
-	 * If we don't have indirect shadow pages, it means no page is
-	 * write-protected, so we can exit simply.
-	 */
-	if (!READ_ONCE(vcpu->kvm->arch.indirect_shadow_pages))
-		return;
-
-	pgprintk("%s: gpa %llx bytes %d\n", __func__, gpa, bytes);
+	int r;
 
-	write_lock(&vcpu->kvm->mmu_lock);
+	r = mmu_topup_memory_caches(vcpu, !vcpu->arch.mmu->root_role.direct);
+	if (r)
+		goto out;
+	r = mmu_alloc_special_roots(vcpu);
+	if (r)
+		goto out;
+	if (vcpu->arch.mmu->root_role.direct)
+		r = mmu_alloc_direct_roots(vcpu);
+	else
+		r = mmu_alloc_shadow_roots(vcpu);
+	if (r)
+		goto out;
 
-	gentry = mmu_pte_write_fetch_gpte(vcpu, &gpa, &bytes);
+	kvm_mmu_sync_roots(vcpu);
 
-	++vcpu->kvm->stat.mmu_pte_write;
+	kvm_mmu_load_pgd(vcpu);
 
-	for_each_gfn_valid_sp_with_gptes(vcpu->kvm, sp, gfn) {
-		if (detect_write_misaligned(sp, gpa, bytes) ||
-		      detect_write_flooding(sp)) {
-			kvm_mmu_prepare_zap_page(vcpu->kvm, sp, &invalid_list);
-			++vcpu->kvm->stat.mmu_flooded;
-			continue;
-		}
+	/*
+	 * Flush any TLB entries for the new root, the provenance of the root
+	 * is unknown.  Even if KVM ensures there are no stale TLB entries
+	 * for a freed root, in theory another hypervisor could have left
+	 * stale entries.  Flushing on alloc also allows KVM to skip the TLB
+	 * flush when freeing a root (see kvm_tdp_mmu_put_root()).
+	 */
+	static_call(kvm_x86_flush_tlb_current)(vcpu);
+out:
+	return r;
+}
 
-		spte = get_written_sptes(sp, gpa, &npte);
-		if (!spte)
-			continue;
+void kvm_mmu_unload(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
 
-		while (npte--) {
-			entry = *spte;
-			mmu_page_zap_pte(vcpu->kvm, sp, spte, NULL);
-			if (gentry && sp->role.level != PG_LEVEL_4K)
-				++vcpu->kvm->stat.mmu_pde_zapped;
-			if (is_shadow_present_pte(entry))
-				flush = true;
-			++spte;
-		}
-	}
-	kvm_mmu_remote_flush_or_zap(vcpu->kvm, &invalid_list, flush);
-	write_unlock(&vcpu->kvm->mmu_lock);
+	kvm_mmu_free_roots(kvm, &vcpu->arch.root_mmu, KVM_MMU_ROOTS_ALL);
+	WARN_ON(VALID_PAGE(vcpu->arch.root_mmu.root.hpa));
+	kvm_mmu_free_roots(kvm, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+	WARN_ON(VALID_PAGE(vcpu->arch.guest_mmu.root.hpa));
+	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
 }
 
 int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
@@ -5728,58 +2700,6 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
 }
 EXPORT_SYMBOL_GPL(kvm_configure_mmu);
 
-/* The return value indicates if tlb flush on all vcpus is needed. */
-typedef bool (*slot_level_handler) (struct kvm *kvm,
-				    struct kvm_rmap_head *rmap_head,
-				    const struct kvm_memory_slot *slot);
-
-/* The caller should hold mmu-lock before calling this function. */
-static __always_inline bool
-slot_handle_level_range(struct kvm *kvm, const struct kvm_memory_slot *memslot,
-			slot_level_handler fn, int start_level, int end_level,
-			gfn_t start_gfn, gfn_t end_gfn, bool flush_on_yield,
-			bool flush)
-{
-	struct slot_rmap_walk_iterator iterator;
-
-	for_each_slot_rmap_range(memslot, start_level, end_level, start_gfn,
-			end_gfn, &iterator) {
-		if (iterator.rmap)
-			flush |= fn(kvm, iterator.rmap, memslot);
-
-		if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
-			if (flush && flush_on_yield) {
-				kvm_flush_remote_tlbs_with_address(kvm,
-						start_gfn,
-						iterator.gfn - start_gfn + 1);
-				flush = false;
-			}
-			cond_resched_rwlock_write(&kvm->mmu_lock);
-		}
-	}
-
-	return flush;
-}
-
-static __always_inline bool
-slot_handle_level(struct kvm *kvm, const struct kvm_memory_slot *memslot,
-		  slot_level_handler fn, int start_level, int end_level,
-		  bool flush_on_yield)
-{
-	return slot_handle_level_range(kvm, memslot, fn, start_level,
-			end_level, memslot->base_gfn,
-			memslot->base_gfn + memslot->npages - 1,
-			flush_on_yield, false);
-}
-
-static __always_inline bool
-slot_handle_level_4k(struct kvm *kvm, const struct kvm_memory_slot *memslot,
-		     slot_level_handler fn, bool flush_on_yield)
-{
-	return slot_handle_level(kvm, memslot, fn, PG_LEVEL_4K,
-				 PG_LEVEL_4K, flush_on_yield);
-}
-
 static void free_mmu_pages(struct kvm_mmu *mmu)
 {
 	if (!tdp_enabled && mmu->pae_root)
@@ -5871,63 +2791,6 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
-#define BATCH_ZAP_PAGES	10
-static void kvm_zap_obsolete_pages(struct kvm *kvm)
-{
-	struct kvm_mmu_page *sp, *node;
-	int nr_zapped, batch = 0;
-	bool unstable;
-
-restart:
-	list_for_each_entry_safe_reverse(sp, node,
-	      &kvm->arch.active_mmu_pages, link) {
-		/*
-		 * No obsolete valid page exists before a newly created page
-		 * since active_mmu_pages is a FIFO list.
-		 */
-		if (!is_obsolete_sp(kvm, sp))
-			break;
-
-		/*
-		 * Invalid pages should never land back on the list of active
-		 * pages.  Skip the bogus page, otherwise we'll get stuck in an
-		 * infinite loop if the page gets put back on the list (again).
-		 */
-		if (WARN_ON(sp->role.invalid))
-			continue;
-
-		/*
-		 * No need to flush the TLB since we're only zapping shadow
-		 * pages with an obsolete generation number and all vCPUS have
-		 * loaded a new root, i.e. the shadow pages being zapped cannot
-		 * be in active use by the guest.
-		 */
-		if (batch >= BATCH_ZAP_PAGES &&
-		    cond_resched_rwlock_write(&kvm->mmu_lock)) {
-			batch = 0;
-			goto restart;
-		}
-
-		unstable = __kvm_mmu_prepare_zap_page(kvm, sp,
-				&kvm->arch.zapped_obsolete_pages, &nr_zapped);
-		batch += nr_zapped;
-
-		if (unstable)
-			goto restart;
-	}
-
-	/*
-	 * Kick all vCPUs (via remote TLB flush) before freeing the page tables
-	 * to ensure KVM is not in the middle of a lockless shadow page table
-	 * walk, which may reference the pages.  The remote TLB flush itself is
-	 * not required and is simply a convenient way to kick vCPUs as needed.
-	 * KVM performs a local TLB flush when allocating a new root (see
-	 * kvm_mmu_load()), and the reload in the caller ensure no vCPUs are
-	 * running with an obsolete MMU.
-	 */
-	kvm_mmu_commit_zap_page(kvm, &kvm->arch.zapped_obsolete_pages);
-}
-
 /*
  * Fast invalidate all shadow pages and use lock-break technique
  * to zap obsolete pages.
@@ -5988,11 +2851,6 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 		kvm_tdp_mmu_zap_invalidated_roots(kvm);
 }
 
-static bool kvm_has_zapped_obsolete_pages(struct kvm *kvm)
-{
-	return unlikely(!list_empty_careful(&kvm->arch.zapped_obsolete_pages));
-}
-
 static void kvm_mmu_invalidate_zap_pages_in_memslot(struct kvm *kvm,
 			struct kvm_memory_slot *slot,
 			struct kvm_page_track_notifier_node *node)
@@ -6047,37 +2905,6 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
 	mmu_free_vm_memory_caches(kvm);
 }
 
-static bool kvm_rmap_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
-{
-	const struct kvm_memory_slot *memslot;
-	struct kvm_memslots *slots;
-	struct kvm_memslot_iter iter;
-	bool flush = false;
-	gfn_t start, end;
-	int i;
-
-	if (!kvm_memslots_have_rmaps(kvm))
-		return flush;
-
-	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
-		slots = __kvm_memslots(kvm, i);
-
-		kvm_for_each_memslot_in_gfn_range(&iter, slots, gfn_start, gfn_end) {
-			memslot = iter.slot;
-			start = max(gfn_start, memslot->base_gfn);
-			end = min(gfn_end, memslot->base_gfn + memslot->npages);
-			if (WARN_ON_ONCE(start >= end))
-				continue;
-
-			flush = slot_handle_level_range(kvm, memslot, __kvm_zap_rmap,
-							PG_LEVEL_4K, KVM_MAX_HUGEPAGE_LEVEL,
-							start, end - 1, true, flush);
-		}
-	}
-
-	return flush;
-}
-
 /*
  * Invalidate (zap) SPTEs that cover GFNs from gfn_start and up to gfn_end
  * (not including it)
@@ -6111,13 +2938,6 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 	write_unlock(&kvm->mmu_lock);
 }
 
-static bool slot_rmap_write_protect(struct kvm *kvm,
-				    struct kvm_rmap_head *rmap_head,
-				    const struct kvm_memory_slot *slot)
-{
-	return rmap_write_protect(rmap_head, false);
-}
-
 void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 				      const struct kvm_memory_slot *memslot,
 				      int start_level)
@@ -6189,183 +3009,6 @@ int topup_split_caches(struct kvm *kvm)
 	return kvm_mmu_topup_memory_cache(&kvm->arch.split_shadow_page_cache, 1);
 }
 
-static struct kvm_mmu_page *shadow_mmu_get_sp_for_split(struct kvm *kvm, u64 *huge_sptep)
-{
-	struct kvm_mmu_page *huge_sp = sptep_to_sp(huge_sptep);
-	struct shadow_page_caches caches = {};
-	union kvm_mmu_page_role role;
-	unsigned int access;
-	gfn_t gfn;
-
-	gfn = kvm_mmu_page_get_gfn(huge_sp, spte_index(huge_sptep));
-	access = kvm_mmu_page_get_access(huge_sp, spte_index(huge_sptep));
-
-	/*
-	 * Note, huge page splitting always uses direct shadow pages, regardless
-	 * of whether the huge page itself is mapped by a direct or indirect
-	 * shadow page, since the huge page region itself is being directly
-	 * mapped with smaller pages.
-	 */
-	role = kvm_mmu_child_role(huge_sptep, /*direct=*/true, access);
-
-	/* Direct SPs do not require a shadowed_info_cache. */
-	caches.page_header_cache = &kvm->arch.split_page_header_cache;
-	caches.shadow_page_cache = &kvm->arch.split_shadow_page_cache;
-
-	/* Safe to pass NULL for vCPU since requesting a direct SP. */
-	return __kvm_mmu_get_shadow_page(kvm, NULL, &caches, gfn, role);
-}
-
-static void shadow_mmu_split_huge_page(struct kvm *kvm,
-				       const struct kvm_memory_slot *slot,
-				       u64 *huge_sptep)
-
-{
-	struct kvm_mmu_memory_cache *cache = &kvm->arch.split_desc_cache;
-	u64 huge_spte = READ_ONCE(*huge_sptep);
-	struct kvm_mmu_page *sp;
-	bool flush = false;
-	u64 *sptep, spte;
-	gfn_t gfn;
-	int index;
-
-	sp = shadow_mmu_get_sp_for_split(kvm, huge_sptep);
-
-	for (index = 0; index < SPTE_ENT_PER_PAGE; index++) {
-		sptep = &sp->spt[index];
-		gfn = kvm_mmu_page_get_gfn(sp, index);
-
-		/*
-		 * The SP may already have populated SPTEs, e.g. if this huge
-		 * page is aliased by multiple sptes with the same access
-		 * permissions. These entries are guaranteed to map the same
-		 * gfn-to-pfn translation since the SP is direct, so no need to
-		 * modify them.
-		 *
-		 * However, if a given SPTE points to a lower level page table,
-		 * that lower level page table may only be partially populated.
-		 * Installing such SPTEs would effectively unmap a potion of the
-		 * huge page. Unmapping guest memory always requires a TLB flush
-		 * since a subsequent operation on the unmapped regions would
-		 * fail to detect the need to flush.
-		 */
-		if (is_shadow_present_pte(*sptep)) {
-			flush |= !is_last_spte(*sptep, sp->role.level);
-			continue;
-		}
-
-		spte = make_huge_page_split_spte(kvm, huge_spte, sp->role, index);
-		mmu_spte_set(sptep, spte);
-		__rmap_add(kvm, cache, slot, sptep, gfn, sp->role.access);
-	}
-
-	__link_shadow_page(kvm, cache, huge_sptep, sp, flush);
-}
-
-static int shadow_mmu_try_split_huge_page(struct kvm *kvm,
-					  const struct kvm_memory_slot *slot,
-					  u64 *huge_sptep)
-{
-	struct kvm_mmu_page *huge_sp = sptep_to_sp(huge_sptep);
-	int level, r = 0;
-	gfn_t gfn;
-	u64 spte;
-
-	/* Grab information for the tracepoint before dropping the MMU lock. */
-	gfn = kvm_mmu_page_get_gfn(huge_sp, spte_index(huge_sptep));
-	level = huge_sp->role.level;
-	spte = *huge_sptep;
-
-	if (kvm_mmu_available_pages(kvm) <= KVM_MIN_FREE_MMU_PAGES) {
-		r = -ENOSPC;
-		goto out;
-	}
-
-	if (need_topup_split_caches_or_resched(kvm)) {
-		write_unlock(&kvm->mmu_lock);
-		cond_resched();
-		/*
-		 * If the topup succeeds, return -EAGAIN to indicate that the
-		 * rmap iterator should be restarted because the MMU lock was
-		 * dropped.
-		 */
-		r = topup_split_caches(kvm) ?: -EAGAIN;
-		write_lock(&kvm->mmu_lock);
-		goto out;
-	}
-
-	shadow_mmu_split_huge_page(kvm, slot, huge_sptep);
-
-out:
-	trace_kvm_mmu_split_huge_page(gfn, spte, level, r);
-	return r;
-}
-
-static bool shadow_mmu_try_split_huge_pages(struct kvm *kvm,
-					    struct kvm_rmap_head *rmap_head,
-					    const struct kvm_memory_slot *slot)
-{
-	struct rmap_iterator iter;
-	struct kvm_mmu_page *sp;
-	u64 *huge_sptep;
-	int r;
-
-restart:
-	for_each_rmap_spte(rmap_head, &iter, huge_sptep) {
-		sp = sptep_to_sp(huge_sptep);
-
-		/* TDP MMU is enabled, so rmap only contains nested MMU SPs. */
-		if (WARN_ON_ONCE(!sp->role.guest_mode))
-			continue;
-
-		/* The rmaps should never contain non-leaf SPTEs. */
-		if (WARN_ON_ONCE(!is_large_pte(*huge_sptep)))
-			continue;
-
-		/* SPs with level >PG_LEVEL_4K should never by unsync. */
-		if (WARN_ON_ONCE(sp->unsync))
-			continue;
-
-		/* Don't bother splitting huge pages on invalid SPs. */
-		if (sp->role.invalid)
-			continue;
-
-		r = shadow_mmu_try_split_huge_page(kvm, slot, huge_sptep);
-
-		/*
-		 * The split succeeded or needs to be retried because the MMU
-		 * lock was dropped. Either way, restart the iterator to get it
-		 * back into a consistent state.
-		 */
-		if (!r || r == -EAGAIN)
-			goto restart;
-
-		/* The split failed and shouldn't be retried (e.g. -ENOMEM). */
-		break;
-	}
-
-	return false;
-}
-
-static void kvm_shadow_mmu_try_split_huge_pages(struct kvm *kvm,
-						const struct kvm_memory_slot *slot,
-						gfn_t start, gfn_t end,
-						int target_level)
-{
-	int level;
-
-	/*
-	 * Split huge pages starting with KVM_MAX_HUGEPAGE_LEVEL and working
-	 * down to the target level. This ensures pages are recursively split
-	 * all the way to the target level. There's no need to split pages
-	 * already at the target level.
-	 */
-	for (level = KVM_MAX_HUGEPAGE_LEVEL; level > target_level; level--) {
-		slot_handle_level_range(kvm, slot, shadow_mmu_try_split_huge_pages,
-					level, level, start, end - 1, true, false);
-	}
-}
-
 /* Must be called with the mmu_lock held in write-mode. */
 void kvm_mmu_try_split_huge_pages(struct kvm *kvm,
 				   const struct kvm_memory_slot *memslot,
@@ -6417,56 +3060,6 @@ void kvm_mmu_slot_try_split_huge_pages(struct kvm *kvm,
 	 */
 }
 
-static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
-					 struct kvm_rmap_head *rmap_head,
-					 const struct kvm_memory_slot *slot)
-{
-	u64 *sptep;
-	struct rmap_iterator iter;
-	int need_tlb_flush = 0;
-	struct kvm_mmu_page *sp;
-
-restart:
-	for_each_rmap_spte(rmap_head, &iter, sptep) {
-		sp = sptep_to_sp(sptep);
-
-		/*
-		 * We cannot do huge page mapping for indirect shadow pages,
-		 * which are found on the last rmap (level = 1) when not using
-		 * tdp; such shadow pages are synced with the page table in
-		 * the guest, and the guest page table is using 4K page size
-		 * mapping if the indirect sp has level = 1.
-		 */
-		if (sp->role.direct &&
-		    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
-							       PG_LEVEL_NUM)) {
-			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
-
-			if (kvm_available_flush_tlb_with_range())
-				kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
-					KVM_PAGES_PER_HPAGE(sp->role.level));
-			else
-				need_tlb_flush = 1;
-
-			goto restart;
-		}
-	}
-
-	return need_tlb_flush;
-}
-
-static void kvm_rmap_zap_collapsible_sptes(struct kvm *kvm,
-					   const struct kvm_memory_slot *slot)
-{
-	/*
-	 * Note, use KVM_MAX_HUGEPAGE_LEVEL - 1 since there's no need to zap
-	 * pages that are already mapped at the maximum hugepage level.
-	 */
-	if (slot_handle_level(kvm, slot, kvm_mmu_zap_collapsible_spte,
-			      PG_LEVEL_4K, KVM_MAX_HUGEPAGE_LEVEL - 1, true))
-		kvm_arch_flush_remote_tlbs_memslot(kvm, slot);
-}
-
 void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 				   const struct kvm_memory_slot *slot)
 {
@@ -6577,67 +3170,8 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
 	}
 }
 
-static unsigned long
-mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
-{
-	struct kvm *kvm;
-	int nr_to_scan = sc->nr_to_scan;
-	unsigned long freed = 0;
-
-	mutex_lock(&kvm_lock);
-
-	list_for_each_entry(kvm, &vm_list, vm_list) {
-		int idx;
-		LIST_HEAD(invalid_list);
-
-		/*
-		 * Never scan more than sc->nr_to_scan VM instances.
-		 * Will not hit this condition practically since we do not try
-		 * to shrink more than one VM and it is very unlikely to see
-		 * !n_used_mmu_pages so many times.
-		 */
-		if (!nr_to_scan--)
-			break;
-		/*
-		 * n_used_mmu_pages is accessed without holding kvm->mmu_lock
-		 * here. We may skip a VM instance errorneosly, but we do not
-		 * want to shrink a VM that only started to populate its MMU
-		 * anyway.
-		 */
-		if (!kvm->arch.n_used_mmu_pages &&
-		    !kvm_has_zapped_obsolete_pages(kvm))
-			continue;
-
-		idx = srcu_read_lock(&kvm->srcu);
-		write_lock(&kvm->mmu_lock);
-
-		if (kvm_has_zapped_obsolete_pages(kvm)) {
-			kvm_mmu_commit_zap_page(kvm,
-			      &kvm->arch.zapped_obsolete_pages);
-			goto unlock;
-		}
-
-		freed = kvm_mmu_zap_oldest_mmu_pages(kvm, sc->nr_to_scan);
-
-unlock:
-		write_unlock(&kvm->mmu_lock);
-		srcu_read_unlock(&kvm->srcu, idx);
-
-		/*
-		 * unfair on small ones
-		 * per-vm shrinkers cry out
-		 * sadness comes quickly
-		 */
-		list_move_tail(&kvm->vm_list, &vm_list);
-		break;
-	}
-
-	mutex_unlock(&kvm_lock);
-	return freed;
-}
-
-static unsigned long
-mmu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+static unsigned long mmu_shrink_count(struct shrinker *shrink,
+				      struct shrink_control *sc)
 {
 	return percpu_counter_read_positive(&kvm_total_used_mmu_pages);
 }
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 856e2e0a8420..74a99b67f09e 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -44,6 +44,8 @@ extern bool dbg;
 #define INVALID_PAE_ROOT	0
 #define IS_VALID_PAE_ROOT(x)	(!!(x))
 
+#define PTE_PREFETCH_NUM		8
+
 typedef u64 __rcu *tdp_ptep_t;
 
 struct kvm_mmu_page {
@@ -168,8 +170,6 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 				    int min_level);
 void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 					u64 start_gfn, u64 pages);
-unsigned int pte_list_count(struct kvm_rmap_head *rmap_head);
-
 extern int nx_huge_pages;
 static inline bool is_nx_huge_page_enabled(struct kvm *kvm)
 {
diff --git a/arch/x86/kvm/mmu/shadow_mmu.c b/arch/x86/kvm/mmu/shadow_mmu.c
index 7bce5ec52b2e..05d8f5be559d 100644
--- a/arch/x86/kvm/mmu/shadow_mmu.c
+++ b/arch/x86/kvm/mmu/shadow_mmu.c
@@ -19,3 +19,3411 @@
 #include <asm/vmx.h>
 #include <asm/cmpxchg.h>
 #include <trace/events/kvm.h>
+
+#define for_each_shadow_entry(_vcpu, _addr, _walker)            \
+	for (shadow_walk_init(&(_walker), _vcpu, _addr);	\
+	     shadow_walk_okay(&(_walker));			\
+	     shadow_walk_next(&(_walker)))
+
+#define for_each_shadow_entry_lockless(_vcpu, _addr, _walker, spte)	\
+	for (shadow_walk_init(&(_walker), _vcpu, _addr);		\
+	     shadow_walk_okay(&(_walker)) &&				\
+		({ spte = mmu_spte_get_lockless(_walker.sptep); 1; });	\
+	     __shadow_walk_next(&(_walker), spte))
+
+static void mmu_spte_set(u64 *sptep, u64 spte);
+
+void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
+		    unsigned int access)
+{
+	u64 spte = make_mmio_spte(vcpu, gfn, access);
+
+	trace_mark_mmio_spte(sptep, gfn, spte);
+	mmu_spte_set(sptep, spte);
+}
+
+#ifdef CONFIG_X86_64
+static void __set_spte(u64 *sptep, u64 spte)
+{
+	WRITE_ONCE(*sptep, spte);
+}
+
+static void __update_clear_spte_fast(u64 *sptep, u64 spte)
+{
+	WRITE_ONCE(*sptep, spte);
+}
+
+static u64 __update_clear_spte_slow(u64 *sptep, u64 spte)
+{
+	return xchg(sptep, spte);
+}
+
+static u64 __get_spte_lockless(u64 *sptep)
+{
+	return READ_ONCE(*sptep);
+}
+#else
+union split_spte {
+	struct {
+		u32 spte_low;
+		u32 spte_high;
+	};
+	u64 spte;
+};
+
+static void count_spte_clear(u64 *sptep, u64 spte)
+{
+	struct kvm_mmu_page *sp =  sptep_to_sp(sptep);
+
+	if (is_shadow_present_pte(spte))
+		return;
+
+	/* Ensure the spte is completely set before we increase the count */
+	smp_wmb();
+	sp->clear_spte_count++;
+}
+
+static void __set_spte(u64 *sptep, u64 spte)
+{
+	union split_spte *ssptep, sspte;
+
+	ssptep = (union split_spte *)sptep;
+	sspte = (union split_spte)spte;
+
+	ssptep->spte_high = sspte.spte_high;
+
+	/*
+	 * If we map the spte from nonpresent to present, We should store
+	 * the high bits firstly, then set present bit, so cpu can not
+	 * fetch this spte while we are setting the spte.
+	 */
+	smp_wmb();
+
+	WRITE_ONCE(ssptep->spte_low, sspte.spte_low);
+}
+
+static void __update_clear_spte_fast(u64 *sptep, u64 spte)
+{
+	union split_spte *ssptep, sspte;
+
+	ssptep = (union split_spte *)sptep;
+	sspte = (union split_spte)spte;
+
+	WRITE_ONCE(ssptep->spte_low, sspte.spte_low);
+
+	/*
+	 * If we map the spte from present to nonpresent, we should clear
+	 * present bit firstly to avoid vcpu fetch the old high bits.
+	 */
+	smp_wmb();
+
+	ssptep->spte_high = sspte.spte_high;
+	count_spte_clear(sptep, spte);
+}
+
+static u64 __update_clear_spte_slow(u64 *sptep, u64 spte)
+{
+	union split_spte *ssptep, sspte, orig;
+
+	ssptep = (union split_spte *)sptep;
+	sspte = (union split_spte)spte;
+
+	/* xchg acts as a barrier before the setting of the high bits */
+	orig.spte_low = xchg(&ssptep->spte_low, sspte.spte_low);
+	orig.spte_high = ssptep->spte_high;
+	ssptep->spte_high = sspte.spte_high;
+	count_spte_clear(sptep, spte);
+
+	return orig.spte;
+}
+
+/*
+ * The idea using the light way get the spte on x86_32 guest is from
+ * gup_get_pte (mm/gup.c).
+ *
+ * An spte tlb flush may be pending, because kvm_set_pte_rmap
+ * coalesces them and we are running out of the MMU lock.  Therefore
+ * we need to protect against in-progress updates of the spte.
+ *
+ * Reading the spte while an update is in progress may get the old value
+ * for the high part of the spte.  The race is fine for a present->non-present
+ * change (because the high part of the spte is ignored for non-present spte),
+ * but for a present->present change we must reread the spte.
+ *
+ * All such changes are done in two steps (present->non-present and
+ * non-present->present), hence it is enough to count the number of
+ * present->non-present updates: if it changed while reading the spte,
+ * we might have hit the race.  This is done using clear_spte_count.
+ */
+static u64 __get_spte_lockless(u64 *sptep)
+{
+	struct kvm_mmu_page *sp =  sptep_to_sp(sptep);
+	union split_spte spte, *orig = (union split_spte *)sptep;
+	int count;
+
+retry:
+	count = sp->clear_spte_count;
+	smp_rmb();
+
+	spte.spte_low = orig->spte_low;
+	smp_rmb();
+
+	spte.spte_high = orig->spte_high;
+	smp_rmb();
+
+	if (unlikely(spte.spte_low != orig->spte_low ||
+	      count != sp->clear_spte_count))
+		goto retry;
+
+	return spte.spte;
+}
+#endif
+
+/* Rules for using mmu_spte_set:
+ * Set the sptep from nonpresent to present.
+ * Note: the sptep being assigned *must* be either not present
+ * or in a state where the hardware will not attempt to update
+ * the spte.
+ */
+static void mmu_spte_set(u64 *sptep, u64 new_spte)
+{
+	WARN_ON(is_shadow_present_pte(*sptep));
+	__set_spte(sptep, new_spte);
+}
+
+/*
+ * Update the SPTE (excluding the PFN), but do not track changes in its
+ * accessed/dirty status.
+ */
+static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
+{
+	u64 old_spte = *sptep;
+
+	WARN_ON(!is_shadow_present_pte(new_spte));
+	check_spte_writable_invariants(new_spte);
+
+	if (!is_shadow_present_pte(old_spte)) {
+		mmu_spte_set(sptep, new_spte);
+		return old_spte;
+	}
+
+	if (!spte_has_volatile_bits(old_spte))
+		__update_clear_spte_fast(sptep, new_spte);
+	else
+		old_spte = __update_clear_spte_slow(sptep, new_spte);
+
+	WARN_ON(spte_to_pfn(old_spte) != spte_to_pfn(new_spte));
+
+	return old_spte;
+}
+
+/* Rules for using mmu_spte_update:
+ * Update the state bits, it means the mapped pfn is not changed.
+ *
+ * Whenever an MMU-writable SPTE is overwritten with a read-only SPTE, remote
+ * TLBs must be flushed. Otherwise rmap_write_protect will find a read-only
+ * spte, even though the writable spte might be cached on a CPU's TLB.
+ *
+ * Returns true if the TLB needs to be flushed
+ */
+bool mmu_spte_update(u64 *sptep, u64 new_spte)
+{
+	bool flush = false;
+	u64 old_spte = mmu_spte_update_no_track(sptep, new_spte);
+
+	if (!is_shadow_present_pte(old_spte))
+		return false;
+
+	/*
+	 * For the spte updated out of mmu-lock is safe, since
+	 * we always atomically update it, see the comments in
+	 * spte_has_volatile_bits().
+	 */
+	if (is_mmu_writable_spte(old_spte) &&
+	      !is_writable_pte(new_spte))
+		flush = true;
+
+	/*
+	 * Flush TLB when accessed/dirty states are changed in the page tables,
+	 * to guarantee consistency between TLB and page tables.
+	 */
+
+	if (is_accessed_spte(old_spte) && !is_accessed_spte(new_spte)) {
+		flush = true;
+		kvm_set_pfn_accessed(spte_to_pfn(old_spte));
+	}
+
+	if (is_dirty_spte(old_spte) && !is_dirty_spte(new_spte)) {
+		flush = true;
+		kvm_set_pfn_dirty(spte_to_pfn(old_spte));
+	}
+
+	return flush;
+}
+
+/*
+ * Rules for using mmu_spte_clear_track_bits:
+ * It sets the sptep from present to nonpresent, and track the
+ * state bits, it is used to clear the last level sptep.
+ * Returns the old PTE.
+ */
+static u64 mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
+{
+	kvm_pfn_t pfn;
+	u64 old_spte = *sptep;
+	int level = sptep_to_sp(sptep)->role.level;
+	struct page *page;
+
+	if (!is_shadow_present_pte(old_spte) ||
+	    !spte_has_volatile_bits(old_spte))
+		__update_clear_spte_fast(sptep, 0ull);
+	else
+		old_spte = __update_clear_spte_slow(sptep, 0ull);
+
+	if (!is_shadow_present_pte(old_spte))
+		return old_spte;
+
+	kvm_update_page_stats(kvm, level, -1);
+
+	pfn = spte_to_pfn(old_spte);
+
+	/*
+	 * KVM doesn't hold a reference to any pages mapped into the guest, and
+	 * instead uses the mmu_notifier to ensure that KVM unmaps any pages
+	 * before they are reclaimed.  Sanity check that, if the pfn is backed
+	 * by a refcounted page, the refcount is elevated.
+	 */
+	page = kvm_pfn_to_refcounted_page(pfn);
+	WARN_ON(page && !page_count(page));
+
+	if (is_accessed_spte(old_spte))
+		kvm_set_pfn_accessed(pfn);
+
+	if (is_dirty_spte(old_spte))
+		kvm_set_pfn_dirty(pfn);
+
+	return old_spte;
+}
+
+/*
+ * Rules for using mmu_spte_clear_no_track:
+ * Directly clear spte without caring the state bits of sptep,
+ * it is used to set the upper level spte.
+ */
+void mmu_spte_clear_no_track(u64 *sptep)
+{
+	__update_clear_spte_fast(sptep, 0ull);
+}
+
+static u64 mmu_spte_get_lockless(u64 *sptep)
+{
+	return __get_spte_lockless(sptep);
+}
+
+/* Returns the Accessed status of the PTE and resets it at the same time. */
+static bool mmu_spte_age(u64 *sptep)
+{
+	u64 spte = mmu_spte_get_lockless(sptep);
+
+	if (!is_accessed_spte(spte))
+		return false;
+
+	if (spte_ad_enabled(spte)) {
+		clear_bit((ffs(shadow_accessed_mask) - 1),
+			  (unsigned long *)sptep);
+	} else {
+		/*
+		 * Capture the dirty status of the page, so that it doesn't get
+		 * lost when the SPTE is marked for access tracking.
+		 */
+		if (is_writable_pte(spte))
+			kvm_set_pfn_dirty(spte_to_pfn(spte));
+
+		spte = mark_spte_for_access_track(spte);
+		mmu_spte_update_no_track(sptep, spte);
+	}
+
+	return true;
+}
+
+static void mmu_free_pte_list_desc(struct pte_list_desc *pte_list_desc)
+{
+	kmem_cache_free(pte_list_desc_cache, pte_list_desc);
+}
+
+static bool sp_has_gptes(struct kvm_mmu_page *sp);
+
+gfn_t kvm_mmu_page_get_gfn(struct kvm_mmu_page *sp, int index)
+{
+	if (sp->role.passthrough)
+		return sp->gfn;
+
+	if (!sp->role.direct)
+		return sp->shadowed_translation[index] >> PAGE_SHIFT;
+
+	return sp->gfn + (index << ((sp->role.level - 1) * SPTE_LEVEL_BITS));
+}
+
+/*
+ * For leaf SPTEs, fetch the *guest* access permissions being shadowed. Note
+ * that the SPTE itself may have a more constrained access permissions that
+ * what the guest enforces. For example, a guest may create an executable
+ * huge PTE but KVM may disallow execution to mitigate iTLB multihit.
+ */
+static u32 kvm_mmu_page_get_access(struct kvm_mmu_page *sp, int index)
+{
+	if (sp_has_gptes(sp))
+		return sp->shadowed_translation[index] & ACC_ALL;
+
+	/*
+	 * For direct MMUs (e.g. TDP or non-paging guests) or passthrough SPs,
+	 * KVM is not shadowing any guest page tables, so the "guest access
+	 * permissions" are just ACC_ALL.
+	 *
+	 * For direct SPs in indirect MMUs (shadow paging), i.e. when KVM
+	 * is shadowing a guest huge page with small pages, the guest access
+	 * permissions being shadowed are the access permissions of the huge
+	 * page.
+	 *
+	 * In both cases, sp->role.access contains the correct access bits.
+	 */
+	return sp->role.access;
+}
+
+static void kvm_mmu_page_set_translation(struct kvm_mmu_page *sp, int index,
+					 gfn_t gfn, unsigned int access)
+{
+	if (sp_has_gptes(sp)) {
+		sp->shadowed_translation[index] = (gfn << PAGE_SHIFT) | access;
+		return;
+	}
+
+	WARN_ONCE(access != kvm_mmu_page_get_access(sp, index),
+	          "access mismatch under %s page %llx (expected %u, got %u)\n",
+	          sp->role.passthrough ? "passthrough" : "direct",
+	          sp->gfn, kvm_mmu_page_get_access(sp, index), access);
+
+	WARN_ONCE(gfn != kvm_mmu_page_get_gfn(sp, index),
+	          "gfn mismatch under %s page %llx (expected %llx, got %llx)\n",
+	          sp->role.passthrough ? "passthrough" : "direct",
+	          sp->gfn, kvm_mmu_page_get_gfn(sp, index), gfn);
+}
+
+void kvm_mmu_page_set_access(struct kvm_mmu_page *sp, int index,
+			     unsigned int access)
+{
+	gfn_t gfn = kvm_mmu_page_get_gfn(sp, index);
+
+	kvm_mmu_page_set_translation(sp, index, gfn, access);
+}
+
+static void account_shadowed(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *slot;
+	gfn_t gfn;
+
+	kvm->arch.indirect_shadow_pages++;
+	gfn = sp->gfn;
+	slots = kvm_memslots_for_spte_role(kvm, sp->role);
+	slot = __gfn_to_memslot(slots, gfn);
+
+	/* the non-leaf shadow pages are keeping readonly. */
+	if (sp->role.level > PG_LEVEL_4K)
+		return kvm_slot_page_track_add_page(kvm, slot, gfn,
+						    KVM_PAGE_TRACK_WRITE);
+
+	kvm_mmu_gfn_disallow_lpage(slot, gfn);
+
+	if (kvm_mmu_slot_gfn_write_protect(kvm, slot, gfn, PG_LEVEL_4K))
+		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
+}
+
+static void unaccount_shadowed(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *slot;
+	gfn_t gfn;
+
+	kvm->arch.indirect_shadow_pages--;
+	gfn = sp->gfn;
+	slots = kvm_memslots_for_spte_role(kvm, sp->role);
+	slot = __gfn_to_memslot(slots, gfn);
+	if (sp->role.level > PG_LEVEL_4K)
+		return kvm_slot_page_track_remove_page(kvm, slot, gfn,
+						       KVM_PAGE_TRACK_WRITE);
+
+	kvm_mmu_gfn_allow_lpage(slot, gfn);
+}
+
+/*
+ * About rmap_head encoding:
+ *
+ * If the bit zero of rmap_head->val is clear, then it points to the only spte
+ * in this rmap chain. Otherwise, (rmap_head->val & ~1) points to a struct
+ * pte_list_desc containing more mappings.
+ */
+
+/*
+ * Returns the number of pointers in the rmap chain, not counting the new one.
+ */
+static int pte_list_add(struct kvm_mmu_memory_cache *cache, u64 *spte,
+			struct kvm_rmap_head *rmap_head)
+{
+	struct pte_list_desc *desc;
+	int count = 0;
+
+	if (!rmap_head->val) {
+		rmap_printk("%p %llx 0->1\n", spte, *spte);
+		rmap_head->val = (unsigned long)spte;
+	} else if (!(rmap_head->val & 1)) {
+		rmap_printk("%p %llx 1->many\n", spte, *spte);
+		desc = kvm_mmu_memory_cache_alloc(cache);
+		desc->sptes[0] = (u64 *)rmap_head->val;
+		desc->sptes[1] = spte;
+		desc->spte_count = 2;
+		rmap_head->val = (unsigned long)desc | 1;
+		++count;
+	} else {
+		rmap_printk("%p %llx many->many\n", spte, *spte);
+		desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
+		while (desc->spte_count == PTE_LIST_EXT) {
+			count += PTE_LIST_EXT;
+			if (!desc->more) {
+				desc->more = kvm_mmu_memory_cache_alloc(cache);
+				desc = desc->more;
+				desc->spte_count = 0;
+				break;
+			}
+			desc = desc->more;
+		}
+		count += desc->spte_count;
+		desc->sptes[desc->spte_count++] = spte;
+	}
+	return count;
+}
+
+static void
+pte_list_desc_remove_entry(struct kvm_rmap_head *rmap_head,
+			   struct pte_list_desc *desc, int i,
+			   struct pte_list_desc *prev_desc)
+{
+	int j = desc->spte_count - 1;
+
+	desc->sptes[i] = desc->sptes[j];
+	desc->sptes[j] = NULL;
+	desc->spte_count--;
+	if (desc->spte_count)
+		return;
+	if (!prev_desc && !desc->more)
+		rmap_head->val = 0;
+	else
+		if (prev_desc)
+			prev_desc->more = desc->more;
+		else
+			rmap_head->val = (unsigned long)desc->more | 1;
+	mmu_free_pte_list_desc(desc);
+}
+
+static void pte_list_remove(u64 *spte, struct kvm_rmap_head *rmap_head)
+{
+	struct pte_list_desc *desc;
+	struct pte_list_desc *prev_desc;
+	int i;
+
+	if (!rmap_head->val) {
+		pr_err("%s: %p 0->BUG\n", __func__, spte);
+		BUG();
+	} else if (!(rmap_head->val & 1)) {
+		rmap_printk("%p 1->0\n", spte);
+		if ((u64 *)rmap_head->val != spte) {
+			pr_err("%s:  %p 1->BUG\n", __func__, spte);
+			BUG();
+		}
+		rmap_head->val = 0;
+	} else {
+		rmap_printk("%p many->many\n", spte);
+		desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
+		prev_desc = NULL;
+		while (desc) {
+			for (i = 0; i < desc->spte_count; ++i) {
+				if (desc->sptes[i] == spte) {
+					pte_list_desc_remove_entry(rmap_head,
+							desc, i, prev_desc);
+					return;
+				}
+			}
+			prev_desc = desc;
+			desc = desc->more;
+		}
+		pr_err("%s: %p many->many\n", __func__, spte);
+		BUG();
+	}
+}
+
+static void kvm_zap_one_rmap_spte(struct kvm *kvm,
+				  struct kvm_rmap_head *rmap_head, u64 *sptep)
+{
+	mmu_spte_clear_track_bits(kvm, sptep);
+	pte_list_remove(sptep, rmap_head);
+}
+
+/* Return true if at least one SPTE was zapped, false otherwise */
+static bool kvm_zap_all_rmap_sptes(struct kvm *kvm,
+				   struct kvm_rmap_head *rmap_head)
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
+		mmu_free_pte_list_desc(desc);
+	}
+out:
+	/* rmap_head is meaningless now, remember to reset it */
+	rmap_head->val = 0;
+	return true;
+}
+
+unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
+{
+	struct pte_list_desc *desc;
+	unsigned int count = 0;
+
+	if (!rmap_head->val)
+		return 0;
+	else if (!(rmap_head->val & 1))
+		return 1;
+
+	desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
+
+	while (desc) {
+		count += desc->spte_count;
+		desc = desc->more;
+	}
+
+	return count;
+}
+
+struct kvm_rmap_head *gfn_to_rmap(gfn_t gfn, int level,
+				  const struct kvm_memory_slot *slot)
+{
+	unsigned long idx;
+
+	idx = gfn_to_index(gfn, slot->base_gfn, level);
+	return &slot->arch.rmap[level - PG_LEVEL_4K][idx];
+}
+
+bool rmap_can_add(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mmu_memory_cache *mc;
+
+	mc = &vcpu->arch.mmu_pte_list_desc_cache;
+	return kvm_mmu_memory_cache_nr_free_objects(mc);
+}
+
+static void rmap_remove(struct kvm *kvm, u64 *spte)
+{
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *slot;
+	struct kvm_mmu_page *sp;
+	gfn_t gfn;
+	struct kvm_rmap_head *rmap_head;
+
+	sp = sptep_to_sp(spte);
+	gfn = kvm_mmu_page_get_gfn(sp, spte_index(spte));
+
+	/*
+	 * Unlike rmap_add, rmap_remove does not run in the context of a vCPU
+	 * so we have to determine which memslots to use based on context
+	 * information in sp->role.
+	 */
+	slots = kvm_memslots_for_spte_role(kvm, sp->role);
+
+	slot = __gfn_to_memslot(slots, gfn);
+	rmap_head = gfn_to_rmap(gfn, sp->role.level, slot);
+
+	pte_list_remove(spte, rmap_head);
+}
+
+/*
+ * Used by the following functions to iterate through the sptes linked by a
+ * rmap.  All fields are private and not assumed to be used outside.
+ */
+struct rmap_iterator {
+	/* private fields */
+	struct pte_list_desc *desc;	/* holds the sptep if not NULL */
+	int pos;			/* index of the sptep */
+};
+
+/*
+ * Iteration must be started by this function.  This should also be used after
+ * removing/dropping sptes from the rmap link because in such cases the
+ * information in the iterator may not be valid.
+ *
+ * Returns sptep if found, NULL otherwise.
+ */
+static u64 *rmap_get_first(struct kvm_rmap_head *rmap_head,
+			   struct rmap_iterator *iter)
+{
+	u64 *sptep;
+
+	if (!rmap_head->val)
+		return NULL;
+
+	if (!(rmap_head->val & 1)) {
+		iter->desc = NULL;
+		sptep = (u64 *)rmap_head->val;
+		goto out;
+	}
+
+	iter->desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
+	iter->pos = 0;
+	sptep = iter->desc->sptes[iter->pos];
+out:
+	BUG_ON(!is_shadow_present_pte(*sptep));
+	return sptep;
+}
+
+/*
+ * Must be used with a valid iterator: e.g. after rmap_get_first().
+ *
+ * Returns sptep if found, NULL otherwise.
+ */
+static u64 *rmap_get_next(struct rmap_iterator *iter)
+{
+	u64 *sptep;
+
+	if (iter->desc) {
+		if (iter->pos < PTE_LIST_EXT - 1) {
+			++iter->pos;
+			sptep = iter->desc->sptes[iter->pos];
+			if (sptep)
+				goto out;
+		}
+
+		iter->desc = iter->desc->more;
+
+		if (iter->desc) {
+			iter->pos = 0;
+			/* desc->sptes[0] cannot be NULL */
+			sptep = iter->desc->sptes[iter->pos];
+			goto out;
+		}
+	}
+
+	return NULL;
+out:
+	BUG_ON(!is_shadow_present_pte(*sptep));
+	return sptep;
+}
+
+#define for_each_rmap_spte(_rmap_head_, _iter_, _spte_)			\
+	for (_spte_ = rmap_get_first(_rmap_head_, _iter_);		\
+	     _spte_; _spte_ = rmap_get_next(_iter_))
+
+void drop_spte(struct kvm *kvm, u64 *sptep)
+{
+	u64 old_spte = mmu_spte_clear_track_bits(kvm, sptep);
+
+	if (is_shadow_present_pte(old_spte))
+		rmap_remove(kvm, sptep);
+}
+
+static void drop_large_spte(struct kvm *kvm, u64 *sptep, bool flush)
+{
+	struct kvm_mmu_page *sp;
+
+	sp = sptep_to_sp(sptep);
+	WARN_ON(sp->role.level == PG_LEVEL_4K);
+
+	drop_spte(kvm, sptep);
+
+	if (flush)
+		kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
+			KVM_PAGES_PER_HPAGE(sp->role.level));
+}
+
+/*
+ * Write-protect on the specified @sptep, @pt_protect indicates whether
+ * spte write-protection is caused by protecting shadow page table.
+ *
+ * Note: write protection is difference between dirty logging and spte
+ * protection:
+ * - for dirty logging, the spte can be set to writable at anytime if
+ *   its dirty bitmap is properly set.
+ * - for spte protection, the spte can be writable only after unsync-ing
+ *   shadow page.
+ *
+ * Return true if tlb need be flushed.
+ */
+static bool spte_write_protect(u64 *sptep, bool pt_protect)
+{
+	u64 spte = *sptep;
+
+	if (!is_writable_pte(spte) &&
+	    !(pt_protect && is_mmu_writable_spte(spte)))
+		return false;
+
+	rmap_printk("spte %p %llx\n", sptep, *sptep);
+
+	if (pt_protect)
+		spte &= ~shadow_mmu_writable_mask;
+	spte = spte & ~PT_WRITABLE_MASK;
+
+	return mmu_spte_update(sptep, spte);
+}
+
+bool rmap_write_protect(struct kvm_rmap_head *rmap_head, bool pt_protect)
+{
+	u64 *sptep;
+	struct rmap_iterator iter;
+	bool flush = false;
+
+	for_each_rmap_spte(rmap_head, &iter, sptep)
+		flush |= spte_write_protect(sptep, pt_protect);
+
+	return flush;
+}
+
+static bool spte_clear_dirty(u64 *sptep)
+{
+	u64 spte = *sptep;
+
+	rmap_printk("spte %p %llx\n", sptep, *sptep);
+
+	MMU_WARN_ON(!spte_ad_enabled(spte));
+	spte &= ~shadow_dirty_mask;
+	return mmu_spte_update(sptep, spte);
+}
+
+static bool spte_wrprot_for_clear_dirty(u64 *sptep)
+{
+	bool was_writable = test_and_clear_bit(PT_WRITABLE_SHIFT,
+					       (unsigned long *)sptep);
+	if (was_writable && !spte_ad_enabled(*sptep))
+		kvm_set_pfn_dirty(spte_to_pfn(*sptep));
+
+	return was_writable;
+}
+
+/*
+ * Gets the GFN ready for another round of dirty logging by clearing the
+ *	- D bit on ad-enabled SPTEs, and
+ *	- W bit on ad-disabled SPTEs.
+ * Returns true iff any D or W bits were cleared.
+ */
+bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			const struct kvm_memory_slot *slot)
+{
+	u64 *sptep;
+	struct rmap_iterator iter;
+	bool flush = false;
+
+	for_each_rmap_spte(rmap_head, &iter, sptep)
+		if (spte_ad_need_write_protect(*sptep))
+			flush |= spte_wrprot_for_clear_dirty(sptep);
+		else
+			flush |= spte_clear_dirty(sptep);
+
+	return flush;
+}
+
+static bool __kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			   const struct kvm_memory_slot *slot)
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
+
+bool kvm_set_pte_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		      struct kvm_memory_slot *slot, gfn_t gfn, int level,
+		      pte_t pte)
+{
+	u64 *sptep;
+	struct rmap_iterator iter;
+	bool need_flush = false;
+	u64 new_spte;
+	kvm_pfn_t new_pfn;
+
+	WARN_ON(pte_huge(pte));
+	new_pfn = pte_pfn(pte);
+
+restart:
+	for_each_rmap_spte(rmap_head, &iter, sptep) {
+		rmap_printk("spte %p %llx gfn %llx (%d)\n",
+			    sptep, *sptep, gfn, level);
+
+		need_flush = true;
+
+		if (pte_write(pte)) {
+			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
+			goto restart;
+		} else {
+			new_spte = kvm_mmu_changed_pte_notifier_make_spte(
+					*sptep, new_pfn);
+
+			mmu_spte_clear_track_bits(kvm, sptep);
+			mmu_spte_set(sptep, new_spte);
+		}
+	}
+
+	if (need_flush && kvm_available_flush_tlb_with_range()) {
+		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
+		return false;
+	}
+
+	return need_flush;
+}
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
+static void
+rmap_walk_init_level(struct slot_rmap_walk_iterator *iterator, int level)
+{
+	iterator->level = level;
+	iterator->gfn = iterator->start_gfn;
+	iterator->rmap = gfn_to_rmap(iterator->gfn, level, iterator->slot);
+	iterator->end_rmap = gfn_to_rmap(iterator->end_gfn, level, iterator->slot);
+}
+
+static void
+slot_rmap_walk_init(struct slot_rmap_walk_iterator *iterator,
+		    const struct kvm_memory_slot *slot, int start_level,
+		    int end_level, gfn_t start_gfn, gfn_t end_gfn)
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
+static bool slot_rmap_walk_okay(struct slot_rmap_walk_iterator *iterator)
+{
+	return !!iterator->rmap;
+}
+
+static void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
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
+
+#define for_each_slot_rmap_range(_slot_, _start_level_, _end_level_,	\
+	   _start_gfn, _end_gfn, _iter_)				\
+	for (slot_rmap_walk_init(_iter_, _slot_, _start_level_,		\
+				 _end_level_, _start_gfn, _end_gfn);	\
+	     slot_rmap_walk_okay(_iter_);				\
+	     slot_rmap_walk_next(_iter_))
+
+__always_inline bool kvm_handle_gfn_range(struct kvm *kvm,
+					  struct kvm_gfn_range *range,
+					  rmap_handler_t handler)
+{
+	struct slot_rmap_walk_iterator iterator;
+	bool ret = false;
+
+	for_each_slot_rmap_range(range->slot, PG_LEVEL_4K, KVM_MAX_HUGEPAGE_LEVEL,
+				 range->start, range->end - 1, &iterator)
+		ret |= handler(kvm, iterator.rmap, range->slot, iterator.gfn,
+			       iterator.level, range->pte);
+
+	return ret;
+}
+
+bool kvm_age_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		  struct kvm_memory_slot *slot, gfn_t gfn, int level,
+		  pte_t unused)
+{
+	u64 *sptep;
+	struct rmap_iterator iter;
+	int young = 0;
+
+	for_each_rmap_spte(rmap_head, &iter, sptep)
+		young |= mmu_spte_age(sptep);
+
+	return young;
+}
+
+bool kvm_test_age_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		       struct kvm_memory_slot *slot, gfn_t gfn,
+		       int level, pte_t unused)
+{
+	u64 *sptep;
+	struct rmap_iterator iter;
+
+	for_each_rmap_spte(rmap_head, &iter, sptep)
+		if (is_accessed_spte(*sptep))
+			return true;
+	return false;
+}
+
+#define RMAP_RECYCLE_THRESHOLD 1000
+
+static void __rmap_add(struct kvm *kvm,
+		       struct kvm_mmu_memory_cache *cache,
+		       const struct kvm_memory_slot *slot,
+		       u64 *spte, gfn_t gfn, unsigned int access)
+{
+	struct kvm_mmu_page *sp;
+	struct kvm_rmap_head *rmap_head;
+	int rmap_count;
+
+	sp = sptep_to_sp(spte);
+	kvm_mmu_page_set_translation(sp, spte_index(spte), gfn, access);
+	kvm_update_page_stats(kvm, sp->role.level, 1);
+
+	rmap_head = gfn_to_rmap(gfn, sp->role.level, slot);
+	rmap_count = pte_list_add(cache, spte, rmap_head);
+
+	if (rmap_count > kvm->stat.max_mmu_rmap_size)
+		kvm->stat.max_mmu_rmap_size = rmap_count;
+	if (rmap_count > RMAP_RECYCLE_THRESHOLD) {
+		kvm_zap_all_rmap_sptes(kvm, rmap_head);
+		kvm_flush_remote_tlbs_with_address(
+				kvm, sp->gfn, KVM_PAGES_PER_HPAGE(sp->role.level));
+	}
+}
+
+static void rmap_add(struct kvm_vcpu *vcpu, const struct kvm_memory_slot *slot,
+		     u64 *spte, gfn_t gfn, unsigned int access)
+{
+	struct kvm_mmu_memory_cache *cache = &vcpu->arch.mmu_pte_list_desc_cache;
+
+	__rmap_add(vcpu->kvm, cache, slot, spte, gfn, access);
+}
+
+#ifdef MMU_DEBUG
+static int is_empty_shadow_page(u64 *spt)
+{
+	u64 *pos;
+	u64 *end;
+
+	for (pos = spt, end = pos + SPTE_ENT_PER_PAGE; pos != end; pos++)
+		if (is_shadow_present_pte(*pos)) {
+			printk(KERN_ERR "%s: %p %llx\n", __func__,
+			       pos, *pos);
+			return 0;
+		}
+	return 1;
+}
+#endif
+
+/*
+ * This value is the sum of all of the kvm instances's
+ * kvm->arch.n_used_mmu_pages values.  We need a global,
+ * aggregate version in order to make the slab shrinker
+ * faster
+ */
+static inline void kvm_mod_used_mmu_pages(struct kvm *kvm, long nr)
+{
+	kvm->arch.n_used_mmu_pages += nr;
+	percpu_counter_add(&kvm_total_used_mmu_pages, nr);
+}
+
+static void kvm_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	kvm_mod_used_mmu_pages(kvm, +1);
+	kvm_account_pgtable_pages((void *)sp->spt, +1);
+}
+
+static void kvm_unaccount_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	kvm_mod_used_mmu_pages(kvm, -1);
+	kvm_account_pgtable_pages((void *)sp->spt, -1);
+}
+
+static void kvm_mmu_free_shadow_page(struct kvm_mmu_page *sp)
+{
+	MMU_WARN_ON(!is_empty_shadow_page(sp->spt));
+	hlist_del(&sp->hash_link);
+	list_del(&sp->link);
+	free_page((unsigned long)sp->spt);
+	if (!sp->role.direct)
+		free_page((unsigned long)sp->shadowed_translation);
+	kmem_cache_free(mmu_page_header_cache, sp);
+}
+
+static unsigned kvm_page_table_hashfn(gfn_t gfn)
+{
+	return hash_64(gfn, KVM_MMU_HASH_SHIFT);
+}
+
+static void mmu_page_add_parent_pte(struct kvm_mmu_memory_cache *cache,
+				    struct kvm_mmu_page *sp, u64 *parent_pte)
+{
+	if (!parent_pte)
+		return;
+
+	pte_list_add(cache, parent_pte, &sp->parent_ptes);
+}
+
+static void mmu_page_remove_parent_pte(struct kvm_mmu_page *sp,
+				       u64 *parent_pte)
+{
+	pte_list_remove(parent_pte, &sp->parent_ptes);
+}
+
+void drop_parent_pte(struct kvm_mmu_page *sp, u64 *parent_pte)
+{
+	mmu_page_remove_parent_pte(sp, parent_pte);
+	mmu_spte_clear_no_track(parent_pte);
+}
+
+static void mark_unsync(u64 *spte);
+static void kvm_mmu_mark_parents_unsync(struct kvm_mmu_page *sp)
+{
+	u64 *sptep;
+	struct rmap_iterator iter;
+
+	for_each_rmap_spte(&sp->parent_ptes, &iter, sptep) {
+		mark_unsync(sptep);
+	}
+}
+
+static void mark_unsync(u64 *spte)
+{
+	struct kvm_mmu_page *sp;
+
+	sp = sptep_to_sp(spte);
+	if (__test_and_set_bit(spte_index(spte), sp->unsync_child_bitmap))
+		return;
+	if (sp->unsync_children++)
+		return;
+	kvm_mmu_mark_parents_unsync(sp);
+}
+
+int nonpaging_sync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
+{
+	return -1;
+}
+
+#define KVM_PAGE_ARRAY_NR 16
+
+struct kvm_mmu_pages {
+	struct mmu_page_and_offset {
+		struct kvm_mmu_page *sp;
+		unsigned int idx;
+	} page[KVM_PAGE_ARRAY_NR];
+	unsigned int nr;
+};
+
+static int mmu_pages_add(struct kvm_mmu_pages *pvec, struct kvm_mmu_page *sp,
+			 int idx)
+{
+	int i;
+
+	if (sp->unsync)
+		for (i=0; i < pvec->nr; i++)
+			if (pvec->page[i].sp == sp)
+				return 0;
+
+	pvec->page[pvec->nr].sp = sp;
+	pvec->page[pvec->nr].idx = idx;
+	pvec->nr++;
+	return (pvec->nr == KVM_PAGE_ARRAY_NR);
+}
+
+static inline void clear_unsync_child_bit(struct kvm_mmu_page *sp, int idx)
+{
+	--sp->unsync_children;
+	WARN_ON((int)sp->unsync_children < 0);
+	__clear_bit(idx, sp->unsync_child_bitmap);
+}
+
+static int __mmu_unsync_walk(struct kvm_mmu_page *sp,
+			   struct kvm_mmu_pages *pvec)
+{
+	int i, ret, nr_unsync_leaf = 0;
+
+	for_each_set_bit(i, sp->unsync_child_bitmap, 512) {
+		struct kvm_mmu_page *child;
+		u64 ent = sp->spt[i];
+
+		if (!is_shadow_present_pte(ent) || is_large_pte(ent)) {
+			clear_unsync_child_bit(sp, i);
+			continue;
+		}
+
+		child = spte_to_child_sp(ent);
+
+		if (child->unsync_children) {
+			if (mmu_pages_add(pvec, child, i))
+				return -ENOSPC;
+
+			ret = __mmu_unsync_walk(child, pvec);
+			if (!ret) {
+				clear_unsync_child_bit(sp, i);
+				continue;
+			} else if (ret > 0) {
+				nr_unsync_leaf += ret;
+			} else
+				return ret;
+		} else if (child->unsync) {
+			nr_unsync_leaf++;
+			if (mmu_pages_add(pvec, child, i))
+				return -ENOSPC;
+		} else
+			clear_unsync_child_bit(sp, i);
+	}
+
+	return nr_unsync_leaf;
+}
+
+#define INVALID_INDEX (-1)
+
+static int mmu_unsync_walk(struct kvm_mmu_page *sp,
+			   struct kvm_mmu_pages *pvec)
+{
+	pvec->nr = 0;
+	if (!sp->unsync_children)
+		return 0;
+
+	mmu_pages_add(pvec, sp, INVALID_INDEX);
+	return __mmu_unsync_walk(sp, pvec);
+}
+
+static void kvm_unlink_unsync_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	WARN_ON(!sp->unsync);
+	trace_kvm_mmu_sync_page(sp);
+	sp->unsync = 0;
+	--kvm->stat.mmu_unsync;
+}
+
+static bool sp_has_gptes(struct kvm_mmu_page *sp)
+{
+	if (sp->role.direct)
+		return false;
+
+	if (sp->role.passthrough)
+		return false;
+
+	return true;
+}
+
+#define for_each_valid_sp(_kvm, _sp, _list)				\
+	hlist_for_each_entry(_sp, _list, hash_link)			\
+		if (is_obsolete_sp((_kvm), (_sp))) {			\
+		} else
+
+#define for_each_gfn_valid_sp_with_gptes(_kvm, _sp, _gfn)		\
+	for_each_valid_sp(_kvm, _sp,					\
+	  &(_kvm)->arch.mmu_page_hash[kvm_page_table_hashfn(_gfn)])	\
+		if ((_sp)->gfn != (_gfn) || !sp_has_gptes(_sp)) {} else
+
+static int kvm_sync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
+			 struct list_head *invalid_list)
+{
+	int ret = vcpu->arch.mmu->sync_page(vcpu, sp);
+
+	if (ret < 0)
+		kvm_mmu_prepare_zap_page(vcpu->kvm, sp, invalid_list);
+	return ret;
+}
+
+struct mmu_page_path {
+	struct kvm_mmu_page *parent[PT64_ROOT_MAX_LEVEL];
+	unsigned int idx[PT64_ROOT_MAX_LEVEL];
+};
+
+#define for_each_sp(pvec, sp, parents, i)			\
+		for (i = mmu_pages_first(&pvec, &parents);	\
+			i < pvec.nr && ({ sp = pvec.page[i].sp; 1;});	\
+			i = mmu_pages_next(&pvec, &parents, i))
+
+static int mmu_pages_next(struct kvm_mmu_pages *pvec,
+			  struct mmu_page_path *parents,
+			  int i)
+{
+	int n;
+
+	for (n = i+1; n < pvec->nr; n++) {
+		struct kvm_mmu_page *sp = pvec->page[n].sp;
+		unsigned idx = pvec->page[n].idx;
+		int level = sp->role.level;
+
+		parents->idx[level-1] = idx;
+		if (level == PG_LEVEL_4K)
+			break;
+
+		parents->parent[level-2] = sp;
+	}
+
+	return n;
+}
+
+static int mmu_pages_first(struct kvm_mmu_pages *pvec,
+			   struct mmu_page_path *parents)
+{
+	struct kvm_mmu_page *sp;
+	int level;
+
+	if (pvec->nr == 0)
+		return 0;
+
+	WARN_ON(pvec->page[0].idx != INVALID_INDEX);
+
+	sp = pvec->page[0].sp;
+	level = sp->role.level;
+	WARN_ON(level == PG_LEVEL_4K);
+
+	parents->parent[level-2] = sp;
+
+	/* Also set up a sentinel.  Further entries in pvec are all
+	 * children of sp, so this element is never overwritten.
+	 */
+	parents->parent[level-1] = NULL;
+	return mmu_pages_next(pvec, parents, 0);
+}
+
+static void mmu_pages_clear_parents(struct mmu_page_path *parents)
+{
+	struct kvm_mmu_page *sp;
+	unsigned int level = 0;
+
+	do {
+		unsigned int idx = parents->idx[level];
+		sp = parents->parent[level];
+		if (!sp)
+			return;
+
+		WARN_ON(idx == INVALID_INDEX);
+		clear_unsync_child_bit(sp, idx);
+		level++;
+	} while (!sp->unsync_children);
+}
+
+int mmu_sync_children(struct kvm_vcpu *vcpu, struct kvm_mmu_page *parent,
+		      bool can_yield)
+{
+	int i;
+	struct kvm_mmu_page *sp;
+	struct mmu_page_path parents;
+	struct kvm_mmu_pages pages;
+	LIST_HEAD(invalid_list);
+	bool flush = false;
+
+	while (mmu_unsync_walk(parent, &pages)) {
+		bool protected = false;
+
+		for_each_sp(pages, sp, parents, i)
+			protected |= kvm_vcpu_write_protect_gfn(vcpu, sp->gfn);
+
+		if (protected) {
+			kvm_mmu_remote_flush_or_zap(vcpu->kvm, &invalid_list, true);
+			flush = false;
+		}
+
+		for_each_sp(pages, sp, parents, i) {
+			kvm_unlink_unsync_page(vcpu->kvm, sp);
+			flush |= kvm_sync_page(vcpu, sp, &invalid_list) > 0;
+			mmu_pages_clear_parents(&parents);
+		}
+		if (need_resched() || rwlock_needbreak(&vcpu->kvm->mmu_lock)) {
+			kvm_mmu_remote_flush_or_zap(vcpu->kvm, &invalid_list, flush);
+			if (!can_yield) {
+				kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
+				return -EINTR;
+			}
+
+			cond_resched_rwlock_write(&vcpu->kvm->mmu_lock);
+			flush = false;
+		}
+	}
+
+	kvm_mmu_remote_flush_or_zap(vcpu->kvm, &invalid_list, flush);
+	return 0;
+}
+
+void __clear_sp_write_flooding_count(struct kvm_mmu_page *sp)
+{
+	atomic_set(&sp->write_flooding_count,  0);
+}
+
+void clear_sp_write_flooding_count(u64 *spte)
+{
+	__clear_sp_write_flooding_count(sptep_to_sp(spte));
+}
+
+/*
+ * The vCPU is required when finding indirect shadow pages; the shadow
+ * page may already exist and syncing it needs the vCPU pointer in
+ * order to read guest page tables.  Direct shadow pages are never
+ * unsync, thus @vcpu can be NULL if @role.direct is true.
+ */
+static struct kvm_mmu_page *kvm_mmu_find_shadow_page(struct kvm *kvm,
+						     struct kvm_vcpu *vcpu,
+						     gfn_t gfn,
+						     struct hlist_head *sp_list,
+						     union kvm_mmu_page_role role)
+{
+	struct kvm_mmu_page *sp;
+	int ret;
+	int collisions = 0;
+	LIST_HEAD(invalid_list);
+
+	for_each_valid_sp(kvm, sp, sp_list) {
+		if (sp->gfn != gfn) {
+			collisions++;
+			continue;
+		}
+
+		if (sp->role.word != role.word) {
+			/*
+			 * If the guest is creating an upper-level page, zap
+			 * unsync pages for the same gfn.  While it's possible
+			 * the guest is using recursive page tables, in all
+			 * likelihood the guest has stopped using the unsync
+			 * page and is installing a completely unrelated page.
+			 * Unsync pages must not be left as is, because the new
+			 * upper-level page will be write-protected.
+			 */
+			if (role.level > PG_LEVEL_4K && sp->unsync)
+				kvm_mmu_prepare_zap_page(kvm, sp,
+							 &invalid_list);
+			continue;
+		}
+
+		/* unsync and write-flooding only apply to indirect SPs. */
+		if (sp->role.direct)
+			goto out;
+
+		if (sp->unsync) {
+			if (KVM_BUG_ON(!vcpu, kvm))
+				break;
+
+			/*
+			 * The page is good, but is stale.  kvm_sync_page does
+			 * get the latest guest state, but (unlike mmu_unsync_children)
+			 * it doesn't write-protect the page or mark it synchronized!
+			 * This way the validity of the mapping is ensured, but the
+			 * overhead of write protection is not incurred until the
+			 * guest invalidates the TLB mapping.  This allows multiple
+			 * SPs for a single gfn to be unsync.
+			 *
+			 * If the sync fails, the page is zapped.  If so, break
+			 * in order to rebuild it.
+			 */
+			ret = kvm_sync_page(vcpu, sp, &invalid_list);
+			if (ret < 0)
+				break;
+
+			WARN_ON(!list_empty(&invalid_list));
+			if (ret > 0)
+				kvm_flush_remote_tlbs(kvm);
+		}
+
+		__clear_sp_write_flooding_count(sp);
+
+		goto out;
+	}
+
+	sp = NULL;
+	++kvm->stat.mmu_cache_miss;
+
+out:
+	kvm_mmu_commit_zap_page(kvm, &invalid_list);
+
+	if (collisions > kvm->stat.max_mmu_page_hash_collisions)
+		kvm->stat.max_mmu_page_hash_collisions = collisions;
+	return sp;
+}
+
+/* Caches used when allocating a new shadow page. */
+struct shadow_page_caches {
+	struct kvm_mmu_memory_cache *page_header_cache;
+	struct kvm_mmu_memory_cache *shadow_page_cache;
+	struct kvm_mmu_memory_cache *shadowed_info_cache;
+};
+
+static struct kvm_mmu_page *kvm_mmu_alloc_shadow_page(struct kvm *kvm,
+						      struct shadow_page_caches *caches,
+						      gfn_t gfn,
+						      struct hlist_head *sp_list,
+						      union kvm_mmu_page_role role)
+{
+	struct kvm_mmu_page *sp;
+
+	sp = kvm_mmu_memory_cache_alloc(caches->page_header_cache);
+	sp->spt = kvm_mmu_memory_cache_alloc(caches->shadow_page_cache);
+	if (!role.direct)
+		sp->shadowed_translation = kvm_mmu_memory_cache_alloc(caches->shadowed_info_cache);
+
+	set_page_private(virt_to_page(sp->spt), (unsigned long)sp);
+
+	INIT_LIST_HEAD(&sp->possible_nx_huge_page_link);
+
+	/*
+	 * active_mmu_pages must be a FIFO list, as kvm_zap_obsolete_pages()
+	 * depends on valid pages being added to the head of the list.  See
+	 * comments in kvm_zap_obsolete_pages().
+	 */
+	sp->mmu_valid_gen = kvm->arch.mmu_valid_gen;
+	list_add(&sp->link, &kvm->arch.active_mmu_pages);
+	kvm_account_mmu_page(kvm, sp);
+
+	sp->gfn = gfn;
+	sp->role = role;
+	hlist_add_head(&sp->hash_link, sp_list);
+	if (sp_has_gptes(sp))
+		account_shadowed(kvm, sp);
+
+	return sp;
+}
+
+/* Note, @vcpu may be NULL if @role.direct is true; see kvm_mmu_find_shadow_page. */
+static struct kvm_mmu_page *__kvm_mmu_get_shadow_page(struct kvm *kvm,
+						      struct kvm_vcpu *vcpu,
+						      struct shadow_page_caches *caches,
+						      gfn_t gfn,
+						      union kvm_mmu_page_role role)
+{
+	struct hlist_head *sp_list;
+	struct kvm_mmu_page *sp;
+	bool created = false;
+
+	sp_list = &kvm->arch.mmu_page_hash[kvm_page_table_hashfn(gfn)];
+
+	sp = kvm_mmu_find_shadow_page(kvm, vcpu, gfn, sp_list, role);
+	if (!sp) {
+		created = true;
+		sp = kvm_mmu_alloc_shadow_page(kvm, caches, gfn, sp_list, role);
+	}
+
+	trace_kvm_mmu_get_page(sp, created);
+	return sp;
+}
+
+static struct kvm_mmu_page *kvm_mmu_get_shadow_page(struct kvm_vcpu *vcpu,
+						    gfn_t gfn,
+						    union kvm_mmu_page_role role)
+{
+	struct shadow_page_caches caches = {
+		.page_header_cache = &vcpu->arch.mmu_page_header_cache,
+		.shadow_page_cache = &vcpu->arch.mmu_shadow_page_cache,
+		.shadowed_info_cache = &vcpu->arch.mmu_shadowed_info_cache,
+	};
+
+	return __kvm_mmu_get_shadow_page(vcpu->kvm, vcpu, &caches, gfn, role);
+}
+
+static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direct,
+						  unsigned int access)
+{
+	struct kvm_mmu_page *parent_sp = sptep_to_sp(sptep);
+	union kvm_mmu_page_role role;
+
+	role = parent_sp->role;
+	role.level--;
+	role.access = access;
+	role.direct = direct;
+	role.passthrough = 0;
+
+	/*
+	 * If the guest has 4-byte PTEs then that means it's using 32-bit,
+	 * 2-level, non-PAE paging. KVM shadows such guests with PAE paging
+	 * (i.e. 8-byte PTEs). The difference in PTE size means that KVM must
+	 * shadow each guest page table with multiple shadow page tables, which
+	 * requires extra bookkeeping in the role.
+	 *
+	 * Specifically, to shadow the guest's page directory (which covers a
+	 * 4GiB address space), KVM uses 4 PAE page directories, each mapping
+	 * 1GiB of the address space. @role.quadrant encodes which quarter of
+	 * the address space each maps.
+	 *
+	 * To shadow the guest's page tables (which each map a 4MiB region), KVM
+	 * uses 2 PAE page tables, each mapping a 2MiB region. For these,
+	 * @role.quadrant encodes which half of the region they map.
+	 *
+	 * Concretely, a 4-byte PDE consumes bits 31:22, while an 8-byte PDE
+	 * consumes bits 29:21.  To consume bits 31:30, KVM's uses 4 shadow
+	 * PDPTEs; those 4 PAE page directories are pre-allocated and their
+	 * quadrant is assigned in mmu_alloc_root().   A 4-byte PTE consumes
+	 * bits 21:12, while an 8-byte PTE consumes bits 20:12.  To consume
+	 * bit 21 in the PTE (the child here), KVM propagates that bit to the
+	 * quadrant, i.e. sets quadrant to '0' or '1'.  The parent 8-byte PDE
+	 * covers bit 21 (see above), thus the quadrant is calculated from the
+	 * _least_ significant bit of the PDE index.
+	 */
+	if (role.has_4_byte_gpte) {
+		WARN_ON_ONCE(role.level != PG_LEVEL_4K);
+		role.quadrant = spte_index(sptep) & 1;
+	}
+
+	return role;
+}
+
+struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu, u64 *sptep,
+					  gfn_t gfn, bool direct,
+					  unsigned int access)
+{
+	union kvm_mmu_page_role role;
+
+	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
+		return ERR_PTR(-EEXIST);
+
+	role = kvm_mmu_child_role(sptep, direct, access);
+	return kvm_mmu_get_shadow_page(vcpu, gfn, role);
+}
+
+void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterator,
+				 struct kvm_vcpu *vcpu, hpa_t root, u64 addr)
+{
+	iterator->addr = addr;
+	iterator->shadow_addr = root;
+	iterator->level = vcpu->arch.mmu->root_role.level;
+
+	if (iterator->level >= PT64_ROOT_4LEVEL &&
+	    vcpu->arch.mmu->cpu_role.base.level < PT64_ROOT_4LEVEL &&
+	    !vcpu->arch.mmu->root_role.direct)
+		iterator->level = PT32E_ROOT_LEVEL;
+
+	if (iterator->level == PT32E_ROOT_LEVEL) {
+		/*
+		 * prev_root is currently only used for 64-bit hosts. So only
+		 * the active root_hpa is valid here.
+		 */
+		BUG_ON(root != vcpu->arch.mmu->root.hpa);
+
+		iterator->shadow_addr
+			= vcpu->arch.mmu->pae_root[(addr >> 30) & 3];
+		iterator->shadow_addr &= SPTE_BASE_ADDR_MASK;
+		--iterator->level;
+		if (!iterator->shadow_addr)
+			iterator->level = 0;
+	}
+}
+
+void shadow_walk_init(struct kvm_shadow_walk_iterator *iterator,
+		      struct kvm_vcpu *vcpu, u64 addr)
+{
+	shadow_walk_init_using_root(iterator, vcpu, vcpu->arch.mmu->root.hpa,
+				    addr);
+}
+
+bool shadow_walk_okay(struct kvm_shadow_walk_iterator *iterator)
+{
+	if (iterator->level < PG_LEVEL_4K)
+		return false;
+
+	iterator->index = SPTE_INDEX(iterator->addr, iterator->level);
+	iterator->sptep	= ((u64 *)__va(iterator->shadow_addr)) + iterator->index;
+	return true;
+}
+
+static void __shadow_walk_next(struct kvm_shadow_walk_iterator *iterator,
+			       u64 spte)
+{
+	if (!is_shadow_present_pte(spte) || is_last_spte(spte, iterator->level)) {
+		iterator->level = 0;
+		return;
+	}
+
+	iterator->shadow_addr = spte & SPTE_BASE_ADDR_MASK;
+	--iterator->level;
+}
+
+void shadow_walk_next(struct kvm_shadow_walk_iterator *iterator)
+{
+	__shadow_walk_next(iterator, *iterator->sptep);
+}
+
+static void __link_shadow_page(struct kvm *kvm,
+			       struct kvm_mmu_memory_cache *cache, u64 *sptep,
+			       struct kvm_mmu_page *sp, bool flush)
+{
+	u64 spte;
+
+	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK != PT_WRITABLE_MASK);
+
+	/*
+	 * If an SPTE is present already, it must be a leaf and therefore
+	 * a large one.  Drop it, and flush the TLB if needed, before
+	 * installing sp.
+	 */
+	if (is_shadow_present_pte(*sptep))
+		drop_large_spte(kvm, sptep, flush);
+
+	spte = make_nonleaf_spte(sp->spt, sp_ad_disabled(sp));
+
+	mmu_spte_set(sptep, spte);
+
+	mmu_page_add_parent_pte(cache, sp, sptep);
+
+	if (sp->unsync_children || sp->unsync)
+		mark_unsync(sptep);
+}
+
+void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep, struct kvm_mmu_page *sp)
+{
+	__link_shadow_page(vcpu->kvm, &vcpu->arch.mmu_pte_list_desc_cache, sptep, sp, true);
+}
+
+void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
+			  unsigned direct_access)
+{
+	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep)) {
+		struct kvm_mmu_page *child;
+
+		/*
+		 * For the direct sp, if the guest pte's dirty bit
+		 * changed form clean to dirty, it will corrupt the
+		 * sp's access: allow writable in the read-only sp,
+		 * so we should update the spte at this point to get
+		 * a new sp with the correct access.
+		 */
+		child = spte_to_child_sp(*sptep);
+		if (child->role.access == direct_access)
+			return;
+
+		drop_parent_pte(child, sptep);
+		kvm_flush_remote_tlbs_with_address(vcpu->kvm, child->gfn, 1);
+	}
+}
+
+/* Returns the number of zapped non-leaf child shadow pages. */
+int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp, u64 *spte,
+		     struct list_head *invalid_list)
+{
+	u64 pte;
+	struct kvm_mmu_page *child;
+
+	pte = *spte;
+	if (is_shadow_present_pte(pte)) {
+		if (is_last_spte(pte, sp->role.level)) {
+			drop_spte(kvm, spte);
+		} else {
+			child = spte_to_child_sp(pte);
+			drop_parent_pte(child, spte);
+
+			/*
+			 * Recursively zap nested TDP SPs, parentless SPs are
+			 * unlikely to be used again in the near future.  This
+			 * avoids retaining a large number of stale nested SPs.
+			 */
+			if (tdp_enabled && invalid_list &&
+			    child->role.guest_mode && !child->parent_ptes.val)
+				return kvm_mmu_prepare_zap_page(kvm, child,
+								invalid_list);
+		}
+	} else if (is_mmio_spte(pte)) {
+		mmu_spte_clear_no_track(spte);
+	}
+	return 0;
+}
+
+static int kvm_mmu_page_unlink_children(struct kvm *kvm,
+					struct kvm_mmu_page *sp,
+					struct list_head *invalid_list)
+{
+	int zapped = 0;
+	unsigned i;
+
+	for (i = 0; i < SPTE_ENT_PER_PAGE; ++i)
+		zapped += mmu_page_zap_pte(kvm, sp, sp->spt + i, invalid_list);
+
+	return zapped;
+}
+
+static void kvm_mmu_unlink_parents(struct kvm_mmu_page *sp)
+{
+	u64 *sptep;
+	struct rmap_iterator iter;
+
+	while ((sptep = rmap_get_first(&sp->parent_ptes, &iter)))
+		drop_parent_pte(sp, sptep);
+}
+
+static int mmu_zap_unsync_children(struct kvm *kvm,
+				   struct kvm_mmu_page *parent,
+				   struct list_head *invalid_list)
+{
+	int i, zapped = 0;
+	struct mmu_page_path parents;
+	struct kvm_mmu_pages pages;
+
+	if (parent->role.level == PG_LEVEL_4K)
+		return 0;
+
+	while (mmu_unsync_walk(parent, &pages)) {
+		struct kvm_mmu_page *sp;
+
+		for_each_sp(pages, sp, parents, i) {
+			kvm_mmu_prepare_zap_page(kvm, sp, invalid_list);
+			mmu_pages_clear_parents(&parents);
+			zapped++;
+		}
+	}
+
+	return zapped;
+}
+
+bool __kvm_mmu_prepare_zap_page(struct kvm *kvm, struct kvm_mmu_page *sp,
+				struct list_head *invalid_list,
+				int *nr_zapped)
+{
+	bool list_unstable, zapped_root = false;
+
+	trace_kvm_mmu_prepare_zap_page(sp);
+	++kvm->stat.mmu_shadow_zapped;
+	*nr_zapped = mmu_zap_unsync_children(kvm, sp, invalid_list);
+	*nr_zapped += kvm_mmu_page_unlink_children(kvm, sp, invalid_list);
+	kvm_mmu_unlink_parents(sp);
+
+	/* Zapping children means active_mmu_pages has become unstable. */
+	list_unstable = *nr_zapped;
+
+	if (!sp->role.invalid && sp_has_gptes(sp))
+		unaccount_shadowed(kvm, sp);
+
+	if (sp->unsync)
+		kvm_unlink_unsync_page(kvm, sp);
+	if (!sp->root_count) {
+		/* Count self */
+		(*nr_zapped)++;
+
+		/*
+		 * Already invalid pages (previously active roots) are not on
+		 * the active page list.  See list_del() in the "else" case of
+		 * !sp->root_count.
+		 */
+		if (sp->role.invalid)
+			list_add(&sp->link, invalid_list);
+		else
+			list_move(&sp->link, invalid_list);
+		kvm_unaccount_mmu_page(kvm, sp);
+	} else {
+		/*
+		 * Remove the active root from the active page list, the root
+		 * will be explicitly freed when the root_count hits zero.
+		 */
+		list_del(&sp->link);
+
+		/*
+		 * Obsolete pages cannot be used on any vCPUs, see the comment
+		 * in kvm_mmu_zap_all_fast().  Note, is_obsolete_sp() also
+		 * treats invalid shadow pages as being obsolete.
+		 */
+		zapped_root = !is_obsolete_sp(kvm, sp);
+	}
+
+	if (sp->nx_huge_page_disallowed)
+		unaccount_nx_huge_page(kvm, sp);
+
+	sp->role.invalid = 1;
+
+	/*
+	 * Make the request to free obsolete roots after marking the root
+	 * invalid, otherwise other vCPUs may not see it as invalid.
+	 */
+	if (zapped_root)
+		kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_FREE_OBSOLETE_ROOTS);
+	return list_unstable;
+}
+
+bool kvm_mmu_prepare_zap_page(struct kvm *kvm, struct kvm_mmu_page *sp,
+			      struct list_head *invalid_list)
+{
+	int nr_zapped;
+
+	__kvm_mmu_prepare_zap_page(kvm, sp, invalid_list, &nr_zapped);
+	return nr_zapped;
+}
+
+void kvm_mmu_commit_zap_page(struct kvm *kvm, struct list_head *invalid_list)
+{
+	struct kvm_mmu_page *sp, *nsp;
+
+	if (list_empty(invalid_list))
+		return;
+
+	/*
+	 * We need to make sure everyone sees our modifications to
+	 * the page tables and see changes to vcpu->mode here. The barrier
+	 * in the kvm_flush_remote_tlbs() achieves this. This pairs
+	 * with vcpu_enter_guest and walk_shadow_page_lockless_begin/end.
+	 *
+	 * In addition, kvm_flush_remote_tlbs waits for all vcpus to exit
+	 * guest mode and/or lockless shadow page table walks.
+	 */
+	kvm_flush_remote_tlbs(kvm);
+
+	list_for_each_entry_safe(sp, nsp, invalid_list, link) {
+		WARN_ON(!sp->role.invalid || sp->root_count);
+		kvm_mmu_free_shadow_page(sp);
+	}
+}
+
+static unsigned long kvm_mmu_zap_oldest_mmu_pages(struct kvm *kvm,
+						  unsigned long nr_to_zap)
+{
+	unsigned long total_zapped = 0;
+	struct kvm_mmu_page *sp, *tmp;
+	LIST_HEAD(invalid_list);
+	bool unstable;
+	int nr_zapped;
+
+	if (list_empty(&kvm->arch.active_mmu_pages))
+		return 0;
+
+restart:
+	list_for_each_entry_safe_reverse(sp, tmp, &kvm->arch.active_mmu_pages, link) {
+		/*
+		 * Don't zap active root pages, the page itself can't be freed
+		 * and zapping it will just force vCPUs to realloc and reload.
+		 */
+		if (sp->root_count)
+			continue;
+
+		unstable = __kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list,
+						      &nr_zapped);
+		total_zapped += nr_zapped;
+		if (total_zapped >= nr_to_zap)
+			break;
+
+		if (unstable)
+			goto restart;
+	}
+
+	kvm_mmu_commit_zap_page(kvm, &invalid_list);
+
+	kvm->stat.mmu_recycled += total_zapped;
+	return total_zapped;
+}
+
+static inline unsigned long kvm_mmu_available_pages(struct kvm *kvm)
+{
+	if (kvm->arch.n_max_mmu_pages > kvm->arch.n_used_mmu_pages)
+		return kvm->arch.n_max_mmu_pages -
+			kvm->arch.n_used_mmu_pages;
+
+	return 0;
+}
+
+int make_mmu_pages_available(struct kvm_vcpu *vcpu)
+{
+	unsigned long avail = kvm_mmu_available_pages(vcpu->kvm);
+
+	if (likely(avail >= KVM_MIN_FREE_MMU_PAGES))
+		return 0;
+
+	kvm_mmu_zap_oldest_mmu_pages(vcpu->kvm, KVM_REFILL_PAGES - avail);
+
+	/*
+	 * Note, this check is intentionally soft, it only guarantees that one
+	 * page is available, while the caller may end up allocating as many as
+	 * four pages, e.g. for PAE roots or for 5-level paging.  Temporarily
+	 * exceeding the (arbitrary by default) limit will not harm the host,
+	 * being too aggressive may unnecessarily kill the guest, and getting an
+	 * exact count is far more trouble than it's worth, especially in the
+	 * page fault paths.
+	 */
+	if (!kvm_mmu_available_pages(vcpu->kvm))
+		return -ENOSPC;
+	return 0;
+}
+
+/*
+ * Changing the number of mmu pages allocated to the vm
+ * Note: if goal_nr_mmu_pages is too small, you will get dead lock
+ */
+void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long goal_nr_mmu_pages)
+{
+	write_lock(&kvm->mmu_lock);
+
+	if (kvm->arch.n_used_mmu_pages > goal_nr_mmu_pages) {
+		kvm_mmu_zap_oldest_mmu_pages(kvm, kvm->arch.n_used_mmu_pages -
+						  goal_nr_mmu_pages);
+
+		goal_nr_mmu_pages = kvm->arch.n_used_mmu_pages;
+	}
+
+	kvm->arch.n_max_mmu_pages = goal_nr_mmu_pages;
+
+	write_unlock(&kvm->mmu_lock);
+}
+
+int kvm_mmu_unprotect_page(struct kvm *kvm, gfn_t gfn)
+{
+	struct kvm_mmu_page *sp;
+	LIST_HEAD(invalid_list);
+	int r;
+
+	pgprintk("%s: looking for gfn %llx\n", __func__, gfn);
+	r = 0;
+	write_lock(&kvm->mmu_lock);
+	for_each_gfn_valid_sp_with_gptes(kvm, sp, gfn) {
+		pgprintk("%s: gfn %llx role %x\n", __func__, gfn,
+			 sp->role.word);
+		r = 1;
+		kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
+	}
+	kvm_mmu_commit_zap_page(kvm, &invalid_list);
+	write_unlock(&kvm->mmu_lock);
+
+	return r;
+}
+
+int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva)
+{
+	gpa_t gpa;
+	int r;
+
+	if (vcpu->arch.mmu->root_role.direct)
+		return 0;
+
+	gpa = kvm_mmu_gva_to_gpa_read(vcpu, gva, NULL);
+
+	r = kvm_mmu_unprotect_page(vcpu->kvm, gpa >> PAGE_SHIFT);
+
+	return r;
+}
+
+static void kvm_unsync_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	trace_kvm_mmu_unsync_page(sp);
+	++kvm->stat.mmu_unsync;
+	sp->unsync = 1;
+
+	kvm_mmu_mark_parents_unsync(sp);
+}
+
+/*
+ * Attempt to unsync any shadow pages that can be reached by the specified gfn,
+ * KVM is creating a writable mapping for said gfn.  Returns 0 if all pages
+ * were marked unsync (or if there is no shadow page), -EPERM if the SPTE must
+ * be write-protected.
+ */
+int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
+			    gfn_t gfn, bool can_unsync, bool prefetch)
+{
+	struct kvm_mmu_page *sp;
+	bool locked = false;
+
+	/*
+	 * Force write-protection if the page is being tracked.  Note, the page
+	 * track machinery is used to write-protect upper-level shadow pages,
+	 * i.e. this guards the role.level == 4K assertion below!
+	 */
+	if (kvm_slot_page_track_is_active(kvm, slot, gfn, KVM_PAGE_TRACK_WRITE))
+		return -EPERM;
+
+	/*
+	 * The page is not write-tracked, mark existing shadow pages unsync
+	 * unless KVM is synchronizing an unsync SP (can_unsync = false).  In
+	 * that case, KVM must complete emulation of the guest TLB flush before
+	 * allowing shadow pages to become unsync (writable by the guest).
+	 */
+	for_each_gfn_valid_sp_with_gptes(kvm, sp, gfn) {
+		if (!can_unsync)
+			return -EPERM;
+
+		if (sp->unsync)
+			continue;
+
+		if (prefetch)
+			return -EEXIST;
+
+		/*
+		 * TDP MMU page faults require an additional spinlock as they
+		 * run with mmu_lock held for read, not write, and the unsync
+		 * logic is not thread safe.  Take the spinklock regardless of
+		 * the MMU type to avoid extra conditionals/parameters, there's
+		 * no meaningful penalty if mmu_lock is held for write.
+		 */
+		if (!locked) {
+			locked = true;
+			spin_lock(&kvm->arch.mmu_unsync_pages_lock);
+
+			/*
+			 * Recheck after taking the spinlock, a different vCPU
+			 * may have since marked the page unsync.  A false
+			 * positive on the unprotected check above is not
+			 * possible as clearing sp->unsync _must_ hold mmu_lock
+			 * for write, i.e. unsync cannot transition from 0->1
+			 * while this CPU holds mmu_lock for read (or write).
+			 */
+			if (READ_ONCE(sp->unsync))
+				continue;
+		}
+
+		WARN_ON(sp->role.level != PG_LEVEL_4K);
+		kvm_unsync_page(kvm, sp);
+	}
+	if (locked)
+		spin_unlock(&kvm->arch.mmu_unsync_pages_lock);
+
+	/*
+	 * We need to ensure that the marking of unsync pages is visible
+	 * before the SPTE is updated to allow writes because
+	 * kvm_mmu_sync_roots() checks the unsync flags without holding
+	 * the MMU lock and so can race with this. If the SPTE was updated
+	 * before the page had been marked as unsync-ed, something like the
+	 * following could happen:
+	 *
+	 * CPU 1                    CPU 2
+	 * ---------------------------------------------------------------------
+	 * 1.2 Host updates SPTE
+	 *     to be writable
+	 *                      2.1 Guest writes a GPTE for GVA X.
+	 *                          (GPTE being in the guest page table shadowed
+	 *                           by the SP from CPU 1.)
+	 *                          This reads SPTE during the page table walk.
+	 *                          Since SPTE.W is read as 1, there is no
+	 *                          fault.
+	 *
+	 *                      2.2 Guest issues TLB flush.
+	 *                          That causes a VM Exit.
+	 *
+	 *                      2.3 Walking of unsync pages sees sp->unsync is
+	 *                          false and skips the page.
+	 *
+	 *                      2.4 Guest accesses GVA X.
+	 *                          Since the mapping in the SP was not updated,
+	 *                          so the old mapping for GVA X incorrectly
+	 *                          gets used.
+	 * 1.1 Host marks SP
+	 *     as unsync
+	 *     (sp->unsync = true)
+	 *
+	 * The write barrier below ensures that 1.1 happens before 1.2 and thus
+	 * the situation in 2.4 does not arise.  It pairs with the read barrier
+	 * in is_unsync_root(), placed between 2.1's load of SPTE.W and 2.3.
+	 */
+	smp_wmb();
+
+	return 0;
+}
+
+int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
+		 u64 *sptep, unsigned int pte_access, gfn_t gfn,
+		 kvm_pfn_t pfn, struct kvm_page_fault *fault)
+{
+	struct kvm_mmu_page *sp = sptep_to_sp(sptep);
+	int level = sp->role.level;
+	int was_rmapped = 0;
+	int ret = RET_PF_FIXED;
+	bool flush = false;
+	bool wrprot;
+	u64 spte;
+
+	/* Prefetching always gets a writable pfn.  */
+	bool host_writable = !fault || fault->map_writable;
+	bool prefetch = !fault || fault->prefetch;
+	bool write_fault = fault && fault->write;
+
+	pgprintk("%s: spte %llx write_fault %d gfn %llx\n", __func__,
+		 *sptep, write_fault, gfn);
+
+	if (unlikely(is_noslot_pfn(pfn))) {
+		vcpu->stat.pf_mmio_spte_created++;
+		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
+		return RET_PF_EMULATE;
+	}
+
+	if (is_shadow_present_pte(*sptep)) {
+		/*
+		 * If we overwrite a PTE page pointer with a 2MB PMD, unlink
+		 * the parent of the now unreachable PTE.
+		 */
+		if (level > PG_LEVEL_4K && !is_large_pte(*sptep)) {
+			struct kvm_mmu_page *child;
+			u64 pte = *sptep;
+
+			child = spte_to_child_sp(pte);
+			drop_parent_pte(child, sptep);
+			flush = true;
+		} else if (pfn != spte_to_pfn(*sptep)) {
+			pgprintk("hfn old %llx new %llx\n",
+				 spte_to_pfn(*sptep), pfn);
+			drop_spte(vcpu->kvm, sptep);
+			flush = true;
+		} else
+			was_rmapped = 1;
+	}
+
+	wrprot = make_spte(vcpu, sp, slot, pte_access, gfn, pfn, *sptep, prefetch,
+			   true, host_writable, &spte);
+
+	if (*sptep == spte) {
+		ret = RET_PF_SPURIOUS;
+	} else {
+		flush |= mmu_spte_update(sptep, spte);
+		trace_kvm_mmu_set_spte(level, gfn, sptep);
+	}
+
+	if (wrprot) {
+		if (write_fault)
+			ret = RET_PF_EMULATE;
+	}
+
+	if (flush)
+		kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn,
+				KVM_PAGES_PER_HPAGE(level));
+
+	pgprintk("%s: setting spte %llx\n", __func__, *sptep);
+
+	if (!was_rmapped) {
+		WARN_ON_ONCE(ret == RET_PF_SPURIOUS);
+		rmap_add(vcpu, slot, sptep, gfn, pte_access);
+	} else {
+		/* Already rmapped but the pte_access bits may have changed. */
+		kvm_mmu_page_set_access(sp, spte_index(sptep), pte_access);
+	}
+
+	return ret;
+}
+
+static int direct_pte_prefetch_many(struct kvm_vcpu *vcpu,
+				    struct kvm_mmu_page *sp,
+				    u64 *start, u64 *end)
+{
+	struct page *pages[PTE_PREFETCH_NUM];
+	struct kvm_memory_slot *slot;
+	unsigned int access = sp->role.access;
+	int i, ret;
+	gfn_t gfn;
+
+	gfn = kvm_mmu_page_get_gfn(sp, spte_index(start));
+	slot = gfn_to_memslot_dirty_bitmap(vcpu, gfn, access & ACC_WRITE_MASK);
+	if (!slot)
+		return -1;
+
+	ret = gfn_to_page_many_atomic(slot, gfn, pages, end - start);
+	if (ret <= 0)
+		return -1;
+
+	for (i = 0; i < ret; i++, gfn++, start++) {
+		mmu_set_spte(vcpu, slot, start, access, gfn,
+			     page_to_pfn(pages[i]), NULL);
+		put_page(pages[i]);
+	}
+
+	return 0;
+}
+
+void __direct_pte_prefetch(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
+			   u64 *sptep)
+{
+	u64 *spte, *start = NULL;
+	int i;
+
+	WARN_ON(!sp->role.direct);
+
+	i = spte_index(sptep) & ~(PTE_PREFETCH_NUM - 1);
+	spte = sp->spt + i;
+
+	for (i = 0; i < PTE_PREFETCH_NUM; i++, spte++) {
+		if (is_shadow_present_pte(*spte) || spte == sptep) {
+			if (!start)
+				continue;
+			if (direct_pte_prefetch_many(vcpu, sp, start, spte) < 0)
+				return;
+			start = NULL;
+		} else if (!start)
+			start = spte;
+	}
+	if (start)
+		direct_pte_prefetch_many(vcpu, sp, start, spte);
+}
+
+static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
+{
+	struct kvm_mmu_page *sp;
+
+	sp = sptep_to_sp(sptep);
+
+	/*
+	 * Without accessed bits, there's no way to distinguish between
+	 * actually accessed translations and prefetched, so disable pte
+	 * prefetch if accessed bits aren't available.
+	 */
+	if (sp_ad_disabled(sp))
+		return;
+
+	if (sp->role.level > PG_LEVEL_4K)
+		return;
+
+	/*
+	 * If addresses are being invalidated, skip prefetching to avoid
+	 * accidentally prefetching those addresses.
+	 */
+	if (unlikely(vcpu->kvm->mmu_invalidate_in_progress))
+		return;
+
+	__direct_pte_prefetch(vcpu, sp, sptep);
+}
+
+int __direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
+{
+	struct kvm_shadow_walk_iterator it;
+	struct kvm_mmu_page *sp;
+	int ret;
+	gfn_t base_gfn = fault->gfn;
+
+	kvm_mmu_hugepage_adjust(vcpu, fault);
+
+	trace_kvm_mmu_spte_requested(fault);
+	for_each_shadow_entry(vcpu, fault->addr, it) {
+		/*
+		 * We cannot overwrite existing page tables with an NX
+		 * large page, as the leaf could be executable.
+		 */
+		if (fault->nx_huge_page_workaround_enabled)
+			disallowed_hugepage_adjust(fault, *it.sptep, it.level);
+
+		base_gfn = fault->gfn & ~(KVM_PAGES_PER_HPAGE(it.level) - 1);
+		if (it.level == fault->goal_level)
+			break;
+
+		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, ACC_ALL);
+		if (sp == ERR_PTR(-EEXIST))
+			continue;
+
+		link_shadow_page(vcpu, it.sptep, sp);
+		if (fault->huge_page_disallowed)
+			account_nx_huge_page(vcpu->kvm, sp,
+					     fault->req_level >= it.level);
+	}
+
+	if (WARN_ON_ONCE(it.level != fault->goal_level))
+		return -EFAULT;
+
+	ret = mmu_set_spte(vcpu, fault->slot, it.sptep, ACC_ALL,
+			   base_gfn, fault->pfn, fault);
+	if (ret == RET_PF_SPURIOUS)
+		return ret;
+
+	direct_pte_prefetch(vcpu, it.sptep);
+	return ret;
+}
+
+/*
+ * Returns the last level spte pointer of the shadow page walk for the given
+ * gpa, and sets *spte to the spte value. This spte may be non-preset. If no
+ * walk could be performed, returns NULL and *spte does not contain valid data.
+ *
+ * Contract:
+ *  - Must be called between walk_shadow_page_lockless_{begin,end}.
+ *  - The returned sptep must not be used after walk_shadow_page_lockless_end.
+ */
+u64 *fast_pf_get_last_sptep(struct kvm_vcpu *vcpu, gpa_t gpa, u64 *spte)
+{
+	struct kvm_shadow_walk_iterator iterator;
+	u64 old_spte;
+	u64 *sptep = NULL;
+
+	for_each_shadow_entry_lockless(vcpu, gpa, iterator, old_spte) {
+		sptep = iterator.sptep;
+		*spte = old_spte;
+	}
+
+	return sptep;
+}
+
+void kvm_mmu_free_guest_mode_roots(struct kvm *kvm, struct kvm_mmu *mmu)
+{
+	unsigned long roots_to_free = 0;
+	hpa_t root_hpa;
+	int i;
+
+	/*
+	 * This should not be called while L2 is active, L2 can't invalidate
+	 * _only_ its own roots, e.g. INVVPID unconditionally exits.
+	 */
+	WARN_ON_ONCE(mmu->root_role.guest_mode);
+
+	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
+		root_hpa = mmu->prev_roots[i].hpa;
+		if (!VALID_PAGE(root_hpa))
+			continue;
+
+		if (!to_shadow_page(root_hpa) ||
+			to_shadow_page(root_hpa)->role.guest_mode)
+			roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
+	}
+
+	kvm_mmu_free_roots(kvm, mmu, roots_to_free);
+}
+EXPORT_SYMBOL_GPL(kvm_mmu_free_guest_mode_roots);
+
+
+static int mmu_check_root(struct kvm_vcpu *vcpu, gfn_t root_gfn)
+{
+	int ret = 0;
+
+	if (!kvm_vcpu_is_visible_gfn(vcpu, root_gfn)) {
+		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
+		ret = 1;
+	}
+
+	return ret;
+}
+
+hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant, u8 level)
+{
+	union kvm_mmu_page_role role = vcpu->arch.mmu->root_role;
+	struct kvm_mmu_page *sp;
+
+	role.level = level;
+	role.quadrant = quadrant;
+
+	WARN_ON_ONCE(quadrant && !role.has_4_byte_gpte);
+	WARN_ON_ONCE(role.direct && role.has_4_byte_gpte);
+
+	sp = kvm_mmu_get_shadow_page(vcpu, gfn, role);
+	++sp->root_count;
+
+	return __pa(sp->spt);
+}
+
+static int mmu_first_shadow_root_alloc(struct kvm *kvm)
+{
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *slot;
+	int r = 0, i, bkt;
+
+	/*
+	 * Check if this is the first shadow root being allocated before
+	 * taking the lock.
+	 */
+	if (kvm_shadow_root_allocated(kvm))
+		return 0;
+
+	mutex_lock(&kvm->slots_arch_lock);
+
+	/* Recheck, under the lock, whether this is the first shadow root. */
+	if (kvm_shadow_root_allocated(kvm))
+		goto out_unlock;
+
+	/*
+	 * Check if anything actually needs to be allocated, e.g. all metadata
+	 * will be allocated upfront if TDP is disabled.
+	 */
+	if (kvm_memslots_have_rmaps(kvm) &&
+	    kvm_page_track_write_tracking_enabled(kvm))
+		goto out_success;
+
+	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+		slots = __kvm_memslots(kvm, i);
+		kvm_for_each_memslot(slot, bkt, slots) {
+			/*
+			 * Both of these functions are no-ops if the target is
+			 * already allocated, so unconditionally calling both
+			 * is safe.  Intentionally do NOT free allocations on
+			 * failure to avoid having to track which allocations
+			 * were made now versus when the memslot was created.
+			 * The metadata is guaranteed to be freed when the slot
+			 * is freed, and will be kept/used if userspace retries
+			 * KVM_RUN instead of killing the VM.
+			 */
+			r = memslot_rmap_alloc(slot, slot->npages);
+			if (r)
+				goto out_unlock;
+			r = kvm_page_track_write_tracking_alloc(slot);
+			if (r)
+				goto out_unlock;
+		}
+	}
+
+	/*
+	 * Ensure that shadow_root_allocated becomes true strictly after
+	 * all the related pointers are set.
+	 */
+out_success:
+	smp_store_release(&kvm->arch.shadow_root_allocated, true);
+
+out_unlock:
+	mutex_unlock(&kvm->slots_arch_lock);
+	return r;
+}
+
+int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	u64 pdptrs[4], pm_mask;
+	gfn_t root_gfn, root_pgd;
+	int quadrant, i, r;
+	hpa_t root;
+
+	root_pgd = mmu->get_guest_pgd(vcpu);
+	root_gfn = root_pgd >> PAGE_SHIFT;
+
+	if (mmu_check_root(vcpu, root_gfn))
+		return 1;
+
+	/*
+	 * On SVM, reading PDPTRs might access guest memory, which might fault
+	 * and thus might sleep.  Grab the PDPTRs before acquiring mmu_lock.
+	 */
+	if (mmu->cpu_role.base.level == PT32E_ROOT_LEVEL) {
+		for (i = 0; i < 4; ++i) {
+			pdptrs[i] = mmu->get_pdptr(vcpu, i);
+			if (!(pdptrs[i] & PT_PRESENT_MASK))
+				continue;
+
+			if (mmu_check_root(vcpu, pdptrs[i] >> PAGE_SHIFT))
+				return 1;
+		}
+	}
+
+	r = mmu_first_shadow_root_alloc(vcpu->kvm);
+	if (r)
+		return r;
+
+	write_lock(&vcpu->kvm->mmu_lock);
+	r = make_mmu_pages_available(vcpu);
+	if (r < 0)
+		goto out_unlock;
+
+	/*
+	 * Do we shadow a long mode page table? If so we need to
+	 * write-protect the guests page table root.
+	 */
+	if (mmu->cpu_role.base.level >= PT64_ROOT_4LEVEL) {
+		root = mmu_alloc_root(vcpu, root_gfn, 0,
+				      mmu->root_role.level);
+		mmu->root.hpa = root;
+		goto set_root_pgd;
+	}
+
+	if (WARN_ON_ONCE(!mmu->pae_root)) {
+		r = -EIO;
+		goto out_unlock;
+	}
+
+	/*
+	 * We shadow a 32 bit page table. This may be a legacy 2-level
+	 * or a PAE 3-level page table. In either case we need to be aware that
+	 * the shadow page table may be a PAE or a long mode page table.
+	 */
+	pm_mask = PT_PRESENT_MASK | shadow_me_value;
+	if (mmu->root_role.level >= PT64_ROOT_4LEVEL) {
+		pm_mask |= PT_ACCESSED_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
+
+		if (WARN_ON_ONCE(!mmu->pml4_root)) {
+			r = -EIO;
+			goto out_unlock;
+		}
+		mmu->pml4_root[0] = __pa(mmu->pae_root) | pm_mask;
+
+		if (mmu->root_role.level == PT64_ROOT_5LEVEL) {
+			if (WARN_ON_ONCE(!mmu->pml5_root)) {
+				r = -EIO;
+				goto out_unlock;
+			}
+			mmu->pml5_root[0] = __pa(mmu->pml4_root) | pm_mask;
+		}
+	}
+
+	for (i = 0; i < 4; ++i) {
+		WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
+
+		if (mmu->cpu_role.base.level == PT32E_ROOT_LEVEL) {
+			if (!(pdptrs[i] & PT_PRESENT_MASK)) {
+				mmu->pae_root[i] = INVALID_PAE_ROOT;
+				continue;
+			}
+			root_gfn = pdptrs[i] >> PAGE_SHIFT;
+		}
+
+		/*
+		 * If shadowing 32-bit non-PAE page tables, each PAE page
+		 * directory maps one quarter of the guest's non-PAE page
+		 * directory. Othwerise each PAE page direct shadows one guest
+		 * PAE page directory so that quadrant should be 0.
+		 */
+		quadrant = (mmu->cpu_role.base.level == PT32_ROOT_LEVEL) ? i : 0;
+
+		root = mmu_alloc_root(vcpu, root_gfn, quadrant, PT32_ROOT_LEVEL);
+		mmu->pae_root[i] = root | pm_mask;
+	}
+
+	if (mmu->root_role.level == PT64_ROOT_5LEVEL)
+		mmu->root.hpa = __pa(mmu->pml5_root);
+	else if (mmu->root_role.level == PT64_ROOT_4LEVEL)
+		mmu->root.hpa = __pa(mmu->pml4_root);
+	else
+		mmu->root.hpa = __pa(mmu->pae_root);
+
+set_root_pgd:
+	mmu->root.pgd = root_pgd;
+out_unlock:
+	write_unlock(&vcpu->kvm->mmu_lock);
+
+	return r;
+}
+
+int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	bool need_pml5 = mmu->root_role.level > PT64_ROOT_4LEVEL;
+	u64 *pml5_root = NULL;
+	u64 *pml4_root = NULL;
+	u64 *pae_root;
+
+	/*
+	 * When shadowing 32-bit or PAE NPT with 64-bit NPT, the PML4 and PDP
+	 * tables are allocated and initialized at root creation as there is no
+	 * equivalent level in the guest's NPT to shadow.  Allocate the tables
+	 * on demand, as running a 32-bit L1 VMM on 64-bit KVM is very rare.
+	 */
+	if (mmu->root_role.direct ||
+	    mmu->cpu_role.base.level >= PT64_ROOT_4LEVEL ||
+	    mmu->root_role.level < PT64_ROOT_4LEVEL)
+		return 0;
+
+	/*
+	 * NPT, the only paging mode that uses this horror, uses a fixed number
+	 * of levels for the shadow page tables, e.g. all MMUs are 4-level or
+	 * all MMus are 5-level.  Thus, this can safely require that pml5_root
+	 * is allocated if the other roots are valid and pml5 is needed, as any
+	 * prior MMU would also have required pml5.
+	 */
+	if (mmu->pae_root && mmu->pml4_root && (!need_pml5 || mmu->pml5_root))
+		return 0;
+
+	/*
+	 * The special roots should always be allocated in concert.  Yell and
+	 * bail if KVM ends up in a state where only one of the roots is valid.
+	 */
+	if (WARN_ON_ONCE(!tdp_enabled || mmu->pae_root || mmu->pml4_root ||
+			 (need_pml5 && mmu->pml5_root)))
+		return -EIO;
+
+	/*
+	 * Unlike 32-bit NPT, the PDP table doesn't need to be in low mem, and
+	 * doesn't need to be decrypted.
+	 */
+	pae_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+	if (!pae_root)
+		return -ENOMEM;
+
+#ifdef CONFIG_X86_64
+	pml4_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+	if (!pml4_root)
+		goto err_pml4;
+
+	if (need_pml5) {
+		pml5_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+		if (!pml5_root)
+			goto err_pml5;
+	}
+#endif
+
+	mmu->pae_root = pae_root;
+	mmu->pml4_root = pml4_root;
+	mmu->pml5_root = pml5_root;
+
+	return 0;
+
+#ifdef CONFIG_X86_64
+err_pml5:
+	free_page((unsigned long)pml4_root);
+err_pml4:
+	free_page((unsigned long)pae_root);
+	return -ENOMEM;
+#endif
+}
+
+static bool is_unsync_root(hpa_t root)
+{
+	struct kvm_mmu_page *sp;
+
+	if (!VALID_PAGE(root))
+		return false;
+
+	/*
+	 * The read barrier orders the CPU's read of SPTE.W during the page table
+	 * walk before the reads of sp->unsync/sp->unsync_children here.
+	 *
+	 * Even if another CPU was marking the SP as unsync-ed simultaneously,
+	 * any guest page table changes are not guaranteed to be visible anyway
+	 * until this VCPU issues a TLB flush strictly after those changes are
+	 * made.  We only need to ensure that the other CPU sets these flags
+	 * before any actual changes to the page tables are made.  The comments
+	 * in mmu_try_to_unsync_pages() describe what could go wrong if this
+	 * requirement isn't satisfied.
+	 */
+	smp_rmb();
+	sp = to_shadow_page(root);
+
+	/*
+	 * PAE roots (somewhat arbitrarily) aren't backed by shadow pages, the
+	 * PDPTEs for a given PAE root need to be synchronized individually.
+	 */
+	if (WARN_ON_ONCE(!sp))
+		return false;
+
+	if (sp->unsync || sp->unsync_children)
+		return true;
+
+	return false;
+}
+
+void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
+{
+	int i;
+	struct kvm_mmu_page *sp;
+
+	if (vcpu->arch.mmu->root_role.direct)
+		return;
+
+	if (!VALID_PAGE(vcpu->arch.mmu->root.hpa))
+		return;
+
+	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
+
+	if (vcpu->arch.mmu->cpu_role.base.level >= PT64_ROOT_4LEVEL) {
+		hpa_t root = vcpu->arch.mmu->root.hpa;
+		sp = to_shadow_page(root);
+
+		if (!is_unsync_root(root))
+			return;
+
+		write_lock(&vcpu->kvm->mmu_lock);
+		mmu_sync_children(vcpu, sp, true);
+		write_unlock(&vcpu->kvm->mmu_lock);
+		return;
+	}
+
+	write_lock(&vcpu->kvm->mmu_lock);
+
+	for (i = 0; i < 4; ++i) {
+		hpa_t root = vcpu->arch.mmu->pae_root[i];
+
+		if (IS_VALID_PAE_ROOT(root)) {
+			sp = spte_to_child_sp(root);
+			mmu_sync_children(vcpu, sp, true);
+		}
+	}
+
+	write_unlock(&vcpu->kvm->mmu_lock);
+}
+
+void kvm_mmu_sync_prev_roots(struct kvm_vcpu *vcpu)
+{
+	unsigned long roots_to_free = 0;
+	int i;
+
+	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
+		if (is_unsync_root(vcpu->arch.mmu->prev_roots[i].hpa))
+			roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
+
+	/* sync prev_roots by simply freeing them */
+	kvm_mmu_free_roots(vcpu->kvm, vcpu->arch.mmu, roots_to_free);
+}
+
+/*
+ * Return the level of the lowest level SPTE added to sptes.
+ * That SPTE may be non-present.
+ *
+ * Must be called between walk_shadow_page_lockless_{begin,end}.
+ */
+int get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes, int *root_level)
+{
+	struct kvm_shadow_walk_iterator iterator;
+	int leaf = -1;
+	u64 spte;
+
+	for (shadow_walk_init(&iterator, vcpu, addr),
+	     *root_level = iterator.level;
+	     shadow_walk_okay(&iterator);
+	     __shadow_walk_next(&iterator, spte)) {
+		leaf = iterator.level;
+		spte = mmu_spte_get_lockless(iterator.sptep);
+
+		sptes[leaf] = spte;
+	}
+
+	return leaf;
+}
+
+void shadow_page_table_clear_flood(struct kvm_vcpu *vcpu, gva_t addr)
+{
+	struct kvm_shadow_walk_iterator iterator;
+	u64 spte;
+
+	walk_shadow_page_lockless_begin(vcpu);
+	for_each_shadow_entry_lockless(vcpu, addr, iterator, spte)
+		clear_sp_write_flooding_count(iterator.sptep);
+	walk_shadow_page_lockless_end(vcpu);
+}
+
+static bool is_obsolete_root(struct kvm *kvm, hpa_t root_hpa)
+{
+	struct kvm_mmu_page *sp;
+
+	if (!VALID_PAGE(root_hpa))
+		return false;
+
+	/*
+	 * When freeing obsolete roots, treat roots as obsolete if they don't
+	 * have an associated shadow page.  This does mean KVM will get false
+	 * positives and free roots that don't strictly need to be freed, but
+	 * such false positives are relatively rare:
+	 *
+	 *  (a) only PAE paging and nested NPT has roots without shadow pages
+	 *  (b) remote reloads due to a memslot update obsoletes _all_ roots
+	 *  (c) KVM doesn't track previous roots for PAE paging, and the guest
+	 *      is unlikely to zap an in-use PGD.
+	 */
+	sp = to_shadow_page(root_hpa);
+	return !sp || is_obsolete_sp(kvm, sp);
+}
+
+static void __kvm_mmu_free_obsolete_roots(struct kvm *kvm, struct kvm_mmu *mmu)
+{
+	unsigned long roots_to_free = 0;
+	int i;
+
+	if (is_obsolete_root(kvm, mmu->root.hpa))
+		roots_to_free |= KVM_MMU_ROOT_CURRENT;
+
+	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
+		if (is_obsolete_root(kvm, mmu->prev_roots[i].hpa))
+			roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
+	}
+
+	if (roots_to_free)
+		kvm_mmu_free_roots(kvm, mmu, roots_to_free);
+}
+
+void kvm_mmu_free_obsolete_roots(struct kvm_vcpu *vcpu)
+{
+	__kvm_mmu_free_obsolete_roots(vcpu->kvm, &vcpu->arch.root_mmu);
+	__kvm_mmu_free_obsolete_roots(vcpu->kvm, &vcpu->arch.guest_mmu);
+}
+
+static u64 mmu_pte_write_fetch_gpte(struct kvm_vcpu *vcpu, gpa_t *gpa,
+				    int *bytes)
+{
+	u64 gentry = 0;
+	int r;
+
+	/*
+	 * Assume that the pte write on a page table of the same type
+	 * as the current vcpu paging mode since we update the sptes only
+	 * when they have the same mode.
+	 */
+	if (is_pae(vcpu) && *bytes == 4) {
+		/* Handle a 32-bit guest writing two halves of a 64-bit gpte */
+		*gpa &= ~(gpa_t)7;
+		*bytes = 8;
+	}
+
+	if (*bytes == 4 || *bytes == 8) {
+		r = kvm_vcpu_read_guest_atomic(vcpu, *gpa, &gentry, *bytes);
+		if (r)
+			gentry = 0;
+	}
+
+	return gentry;
+}
+
+/*
+ * If we're seeing too many writes to a page, it may no longer be a page table,
+ * or we may be forking, in which case it is better to unmap the page.
+ */
+static bool detect_write_flooding(struct kvm_mmu_page *sp)
+{
+	/*
+	 * Skip write-flooding detected for the sp whose level is 1, because
+	 * it can become unsync, then the guest page is not write-protected.
+	 */
+	if (sp->role.level == PG_LEVEL_4K)
+		return false;
+
+	atomic_inc(&sp->write_flooding_count);
+	return atomic_read(&sp->write_flooding_count) >= 3;
+}
+
+/*
+ * Misaligned accesses are too much trouble to fix up; also, they usually
+ * indicate a page is not used as a page table.
+ */
+static bool detect_write_misaligned(struct kvm_mmu_page *sp, gpa_t gpa,
+				    int bytes)
+{
+	unsigned offset, pte_size, misaligned;
+
+	pgprintk("misaligned: gpa %llx bytes %d role %x\n",
+		 gpa, bytes, sp->role.word);
+
+	offset = offset_in_page(gpa);
+	pte_size = sp->role.has_4_byte_gpte ? 4 : 8;
+
+	/*
+	 * Sometimes, the OS only writes the last one bytes to update status
+	 * bits, for example, in linux, andb instruction is used in clear_bit().
+	 */
+	if (!(offset & (pte_size - 1)) && bytes == 1)
+		return false;
+
+	misaligned = (offset ^ (offset + bytes - 1)) & ~(pte_size - 1);
+	misaligned |= bytes < 4;
+
+	return misaligned;
+}
+
+static u64 *get_written_sptes(struct kvm_mmu_page *sp, gpa_t gpa, int *nspte)
+{
+	unsigned page_offset, quadrant;
+	u64 *spte;
+	int level;
+
+	page_offset = offset_in_page(gpa);
+	level = sp->role.level;
+	*nspte = 1;
+	if (sp->role.has_4_byte_gpte) {
+		page_offset <<= 1;	/* 32->64 */
+		/*
+		 * A 32-bit pde maps 4MB while the shadow pdes map
+		 * only 2MB.  So we need to double the offset again
+		 * and zap two pdes instead of one.
+		 */
+		if (level == PT32_ROOT_LEVEL) {
+			page_offset &= ~7; /* kill rounding error */
+			page_offset <<= 1;
+			*nspte = 2;
+		}
+		quadrant = page_offset >> PAGE_SHIFT;
+		page_offset &= ~PAGE_MASK;
+		if (quadrant != sp->role.quadrant)
+			return NULL;
+	}
+
+	spte = &sp->spt[page_offset / sizeof(*spte)];
+	return spte;
+}
+
+void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
+		       int bytes, struct kvm_page_track_notifier_node *node)
+{
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+	struct kvm_mmu_page *sp;
+	LIST_HEAD(invalid_list);
+	u64 entry, gentry, *spte;
+	int npte;
+	bool flush = false;
+
+	/*
+	 * If we don't have indirect shadow pages, it means no page is
+	 * write-protected, so we can exit simply.
+	 */
+	if (!READ_ONCE(vcpu->kvm->arch.indirect_shadow_pages))
+		return;
+
+	pgprintk("%s: gpa %llx bytes %d\n", __func__, gpa, bytes);
+
+	write_lock(&vcpu->kvm->mmu_lock);
+
+	gentry = mmu_pte_write_fetch_gpte(vcpu, &gpa, &bytes);
+
+	++vcpu->kvm->stat.mmu_pte_write;
+
+	for_each_gfn_valid_sp_with_gptes(vcpu->kvm, sp, gfn) {
+		if (detect_write_misaligned(sp, gpa, bytes) ||
+		      detect_write_flooding(sp)) {
+			kvm_mmu_prepare_zap_page(vcpu->kvm, sp, &invalid_list);
+			++vcpu->kvm->stat.mmu_flooded;
+			continue;
+		}
+
+		spte = get_written_sptes(sp, gpa, &npte);
+		if (!spte)
+			continue;
+
+		while (npte--) {
+			entry = *spte;
+			mmu_page_zap_pte(vcpu->kvm, sp, spte, NULL);
+			if (gentry && sp->role.level != PG_LEVEL_4K)
+				++vcpu->kvm->stat.mmu_pde_zapped;
+			if (is_shadow_present_pte(entry))
+				flush = true;
+			++spte;
+		}
+	}
+	kvm_mmu_remote_flush_or_zap(vcpu->kvm, &invalid_list, flush);
+	write_unlock(&vcpu->kvm->mmu_lock);
+}
+
+/* The caller should hold mmu-lock before calling this function. */
+static __always_inline bool
+slot_handle_level_range(struct kvm *kvm, const struct kvm_memory_slot *memslot,
+			slot_level_handler fn, int start_level, int end_level,
+			gfn_t start_gfn, gfn_t end_gfn, bool flush_on_yield,
+			bool flush)
+{
+	struct slot_rmap_walk_iterator iterator;
+
+	for_each_slot_rmap_range(memslot, start_level, end_level, start_gfn,
+			end_gfn, &iterator) {
+		if (iterator.rmap)
+			flush |= fn(kvm, iterator.rmap, memslot);
+
+		if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
+			if (flush && flush_on_yield) {
+				kvm_flush_remote_tlbs_with_address(kvm,
+						start_gfn,
+						iterator.gfn - start_gfn + 1);
+				flush = false;
+			}
+			cond_resched_rwlock_write(&kvm->mmu_lock);
+		}
+	}
+
+	return flush;
+}
+
+__always_inline bool slot_handle_level(struct kvm *kvm,
+				       const struct kvm_memory_slot *memslot,
+				       slot_level_handler fn, int start_level,
+				       int end_level, bool flush_on_yield)
+{
+	return slot_handle_level_range(kvm, memslot, fn, start_level,
+			end_level, memslot->base_gfn,
+			memslot->base_gfn + memslot->npages - 1,
+			flush_on_yield, false);
+}
+
+__always_inline bool slot_handle_level_4k(struct kvm *kvm,
+					  const struct kvm_memory_slot *memslot,
+					  slot_level_handler fn,
+					  bool flush_on_yield)
+{
+	return slot_handle_level(kvm, memslot, fn, PG_LEVEL_4K,
+				 PG_LEVEL_4K, flush_on_yield);
+}
+
+#define BATCH_ZAP_PAGES	10
+void kvm_zap_obsolete_pages(struct kvm *kvm)
+{
+	struct kvm_mmu_page *sp, *node;
+	int nr_zapped, batch = 0;
+	bool unstable;
+
+restart:
+	list_for_each_entry_safe_reverse(sp, node,
+	      &kvm->arch.active_mmu_pages, link) {
+		/*
+		 * No obsolete valid page exists before a newly created page
+		 * since active_mmu_pages is a FIFO list.
+		 */
+		if (!is_obsolete_sp(kvm, sp))
+			break;
+
+		/*
+		 * Invalid pages should never land back on the list of active
+		 * pages.  Skip the bogus page, otherwise we'll get stuck in an
+		 * infinite loop if the page gets put back on the list (again).
+		 */
+		if (WARN_ON(sp->role.invalid))
+			continue;
+
+		/*
+		 * No need to flush the TLB since we're only zapping shadow
+		 * pages with an obsolete generation number and all vCPUS have
+		 * loaded a new root, i.e. the shadow pages being zapped cannot
+		 * be in active use by the guest.
+		 */
+		if (batch >= BATCH_ZAP_PAGES &&
+		    cond_resched_rwlock_write(&kvm->mmu_lock)) {
+			batch = 0;
+			goto restart;
+		}
+
+		unstable = __kvm_mmu_prepare_zap_page(kvm, sp,
+				&kvm->arch.zapped_obsolete_pages, &nr_zapped);
+		batch += nr_zapped;
+
+		if (unstable)
+			goto restart;
+	}
+
+	/*
+	 * Kick all vCPUs (via remote TLB flush) before freeing the page tables
+	 * to ensure KVM is not in the middle of a lockless shadow page table
+	 * walk, which may reference the pages.  The remote TLB flush itself is
+	 * not required and is simply a convenient way to kick vCPUs as needed.
+	 * KVM performs a local TLB flush when allocating a new root (see
+	 * kvm_mmu_load()), and the reload in the caller ensure no vCPUs are
+	 * running with an obsolete MMU.
+	 */
+	kvm_mmu_commit_zap_page(kvm, &kvm->arch.zapped_obsolete_pages);
+}
+
+static bool kvm_has_zapped_obsolete_pages(struct kvm *kvm)
+{
+	return unlikely(!list_empty_careful(&kvm->arch.zapped_obsolete_pages));
+}
+
+bool kvm_rmap_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
+{
+	const struct kvm_memory_slot *memslot;
+	struct kvm_memslots *slots;
+	struct kvm_memslot_iter iter;
+	bool flush = false;
+	gfn_t start, end;
+	int i;
+
+	if (!kvm_memslots_have_rmaps(kvm))
+		return flush;
+
+	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+		slots = __kvm_memslots(kvm, i);
+
+		kvm_for_each_memslot_in_gfn_range(&iter, slots, gfn_start, gfn_end) {
+			memslot = iter.slot;
+			start = max(gfn_start, memslot->base_gfn);
+			end = min(gfn_end, memslot->base_gfn + memslot->npages);
+			if (WARN_ON_ONCE(start >= end))
+				continue;
+
+			flush = slot_handle_level_range(kvm, memslot, __kvm_zap_rmap,
+							PG_LEVEL_4K, KVM_MAX_HUGEPAGE_LEVEL,
+							start, end - 1, true, flush);
+		}
+	}
+
+	return flush;
+}
+
+bool slot_rmap_write_protect(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			     const struct kvm_memory_slot *slot)
+{
+	return rmap_write_protect(rmap_head, false);
+}
+
+static struct kvm_mmu_page *shadow_mmu_get_sp_for_split(struct kvm *kvm, u64 *huge_sptep)
+{
+	struct kvm_mmu_page *huge_sp = sptep_to_sp(huge_sptep);
+	struct shadow_page_caches caches = {};
+	union kvm_mmu_page_role role;
+	unsigned int access;
+	gfn_t gfn;
+
+	gfn = kvm_mmu_page_get_gfn(huge_sp, spte_index(huge_sptep));
+	access = kvm_mmu_page_get_access(huge_sp, spte_index(huge_sptep));
+
+	/*
+	 * Note, huge page splitting always uses direct shadow pages, regardless
+	 * of whether the huge page itself is mapped by a direct or indirect
+	 * shadow page, since the huge page region itself is being directly
+	 * mapped with smaller pages.
+	 */
+	role = kvm_mmu_child_role(huge_sptep, /*direct=*/true, access);
+
+	/* Direct SPs do not require a shadowed_info_cache. */
+	caches.page_header_cache = &kvm->arch.split_page_header_cache;
+	caches.shadow_page_cache = &kvm->arch.split_shadow_page_cache;
+
+	/* Safe to pass NULL for vCPU since requesting a direct SP. */
+	return __kvm_mmu_get_shadow_page(kvm, NULL, &caches, gfn, role);
+}
+
+static void shadow_mmu_split_huge_page(struct kvm *kvm,
+				       const struct kvm_memory_slot *slot,
+				       u64 *huge_sptep)
+
+{
+	struct kvm_mmu_memory_cache *cache = &kvm->arch.split_desc_cache;
+	u64 huge_spte = READ_ONCE(*huge_sptep);
+	struct kvm_mmu_page *sp;
+	bool flush = false;
+	u64 *sptep, spte;
+	gfn_t gfn;
+	int index;
+
+	sp = shadow_mmu_get_sp_for_split(kvm, huge_sptep);
+
+	for (index = 0; index < SPTE_ENT_PER_PAGE; index++) {
+		sptep = &sp->spt[index];
+		gfn = kvm_mmu_page_get_gfn(sp, index);
+
+		/*
+		 * The SP may already have populated SPTEs, e.g. if this huge
+		 * page is aliased by multiple sptes with the same access
+		 * permissions. These entries are guaranteed to map the same
+		 * gfn-to-pfn translation since the SP is direct, so no need to
+		 * modify them.
+		 *
+		 * However, if a given SPTE points to a lower level page table,
+		 * that lower level page table may only be partially populated.
+		 * Installing such SPTEs would effectively unmap a potion of the
+		 * huge page. Unmapping guest memory always requires a TLB flush
+		 * since a subsequent operation on the unmapped regions would
+		 * fail to detect the need to flush.
+		 */
+		if (is_shadow_present_pte(*sptep)) {
+			flush |= !is_last_spte(*sptep, sp->role.level);
+			continue;
+		}
+
+		spte = make_huge_page_split_spte(kvm, huge_spte, sp->role, index);
+		mmu_spte_set(sptep, spte);
+		__rmap_add(kvm, cache, slot, sptep, gfn, sp->role.access);
+	}
+
+	__link_shadow_page(kvm, cache, huge_sptep, sp, flush);
+}
+
+static int shadow_mmu_try_split_huge_page(struct kvm *kvm,
+					  const struct kvm_memory_slot *slot,
+					  u64 *huge_sptep)
+{
+	struct kvm_mmu_page *huge_sp = sptep_to_sp(huge_sptep);
+	int level, r = 0;
+	gfn_t gfn;
+	u64 spte;
+
+	/* Grab information for the tracepoint before dropping the MMU lock. */
+	gfn = kvm_mmu_page_get_gfn(huge_sp, spte_index(huge_sptep));
+	level = huge_sp->role.level;
+	spte = *huge_sptep;
+
+	if (kvm_mmu_available_pages(kvm) <= KVM_MIN_FREE_MMU_PAGES) {
+		r = -ENOSPC;
+		goto out;
+	}
+
+	if (need_topup_split_caches_or_resched(kvm)) {
+		write_unlock(&kvm->mmu_lock);
+		cond_resched();
+		/*
+		 * If the topup succeeds, return -EAGAIN to indicate that the
+		 * rmap iterator should be restarted because the MMU lock was
+		 * dropped.
+		 */
+		r = topup_split_caches(kvm) ?: -EAGAIN;
+		write_lock(&kvm->mmu_lock);
+		goto out;
+	}
+
+	shadow_mmu_split_huge_page(kvm, slot, huge_sptep);
+
+out:
+	trace_kvm_mmu_split_huge_page(gfn, spte, level, r);
+	return r;
+}
+
+static bool shadow_mmu_try_split_huge_pages(struct kvm *kvm,
+					    struct kvm_rmap_head *rmap_head,
+					    const struct kvm_memory_slot *slot)
+{
+	struct rmap_iterator iter;
+	struct kvm_mmu_page *sp;
+	u64 *huge_sptep;
+	int r;
+
+restart:
+	for_each_rmap_spte(rmap_head, &iter, huge_sptep) {
+		sp = sptep_to_sp(huge_sptep);
+
+		/* TDP MMU is enabled, so rmap only contains nested MMU SPs. */
+		if (WARN_ON_ONCE(!sp->role.guest_mode))
+			continue;
+
+		/* The rmaps should never contain non-leaf SPTEs. */
+		if (WARN_ON_ONCE(!is_large_pte(*huge_sptep)))
+			continue;
+
+		/* SPs with level >PG_LEVEL_4K should never by unsync. */
+		if (WARN_ON_ONCE(sp->unsync))
+			continue;
+
+		/* Don't bother splitting huge pages on invalid SPs. */
+		if (sp->role.invalid)
+			continue;
+
+		r = shadow_mmu_try_split_huge_page(kvm, slot, huge_sptep);
+
+		/*
+		 * The split succeeded or needs to be retried because the MMU
+		 * lock was dropped. Either way, restart the iterator to get it
+		 * back into a consistent state.
+		 */
+		if (!r || r == -EAGAIN)
+			goto restart;
+
+		/* The split failed and shouldn't be retried (e.g. -ENOMEM). */
+		break;
+	}
+
+	return false;
+}
+
+void kvm_shadow_mmu_try_split_huge_pages(struct kvm *kvm,
+					 const struct kvm_memory_slot *slot,
+					 gfn_t start, gfn_t end,
+					 int target_level)
+{
+	int level;
+
+	/*
+	 * Split huge pages starting with KVM_MAX_HUGEPAGE_LEVEL and working
+	 * down to the target level. This ensures pages are recursively split
+	 * all the way to the target level. There's no need to split pages
+	 * already at the target level.
+	 */
+	for (level = KVM_MAX_HUGEPAGE_LEVEL; level > target_level; level--) {
+		slot_handle_level_range(kvm, slot, shadow_mmu_try_split_huge_pages,
+					level, level, start, end - 1, true, false);
+	}
+}
+
+static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
+					 struct kvm_rmap_head *rmap_head,
+					 const struct kvm_memory_slot *slot)
+{
+	u64 *sptep;
+	struct rmap_iterator iter;
+	int need_tlb_flush = 0;
+	struct kvm_mmu_page *sp;
+
+restart:
+	for_each_rmap_spte(rmap_head, &iter, sptep) {
+		sp = sptep_to_sp(sptep);
+
+		/*
+		 * We cannot do huge page mapping for indirect shadow pages,
+		 * which are found on the last rmap (level = 1) when not using
+		 * tdp; such shadow pages are synced with the page table in
+		 * the guest, and the guest page table is using 4K page size
+		 * mapping if the indirect sp has level = 1.
+		 */
+		if (sp->role.direct &&
+		    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
+							       PG_LEVEL_NUM)) {
+			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
+
+			if (kvm_available_flush_tlb_with_range())
+				kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
+					KVM_PAGES_PER_HPAGE(sp->role.level));
+			else
+				need_tlb_flush = 1;
+
+			goto restart;
+		}
+	}
+
+	return need_tlb_flush;
+}
+
+void kvm_rmap_zap_collapsible_sptes(struct kvm *kvm,
+				    const struct kvm_memory_slot *slot)
+{
+	/*
+	 * Note, use KVM_MAX_HUGEPAGE_LEVEL - 1 since there's no need to zap
+	 * pages that are already mapped at the maximum hugepage level.
+	 */
+	if (slot_handle_level(kvm, slot, kvm_mmu_zap_collapsible_spte,
+			      PG_LEVEL_4K, KVM_MAX_HUGEPAGE_LEVEL - 1, true))
+		kvm_arch_flush_remote_tlbs_memslot(kvm, slot);
+}
+
+unsigned long mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	struct kvm *kvm;
+	int nr_to_scan = sc->nr_to_scan;
+	unsigned long freed = 0;
+
+	mutex_lock(&kvm_lock);
+
+	list_for_each_entry(kvm, &vm_list, vm_list) {
+		int idx;
+		LIST_HEAD(invalid_list);
+
+		/*
+		 * Never scan more than sc->nr_to_scan VM instances.
+		 * Will not hit this condition practically since we do not try
+		 * to shrink more than one VM and it is very unlikely to see
+		 * !n_used_mmu_pages so many times.
+		 */
+		if (!nr_to_scan--)
+			break;
+		/*
+		 * n_used_mmu_pages is accessed without holding kvm->mmu_lock
+		 * here. We may skip a VM instance errorneosly, but we do not
+		 * want to shrink a VM that only started to populate its MMU
+		 * anyway.
+		 */
+		if (!kvm->arch.n_used_mmu_pages &&
+		    !kvm_has_zapped_obsolete_pages(kvm))
+			continue;
+
+		idx = srcu_read_lock(&kvm->srcu);
+		write_lock(&kvm->mmu_lock);
+
+		if (kvm_has_zapped_obsolete_pages(kvm)) {
+			kvm_mmu_commit_zap_page(kvm,
+			      &kvm->arch.zapped_obsolete_pages);
+			goto unlock;
+		}
+
+		freed = kvm_mmu_zap_oldest_mmu_pages(kvm, sc->nr_to_scan);
+
+unlock:
+		write_unlock(&kvm->mmu_lock);
+		srcu_read_unlock(&kvm->srcu, idx);
+
+		/*
+		 * unfair on small ones
+		 * per-vm shrinkers cry out
+		 * sadness comes quickly
+		 */
+		list_move_tail(&kvm->vm_list, &vm_list);
+		break;
+	}
+
+	mutex_unlock(&kvm_lock);
+	return freed;
+}
diff --git a/arch/x86/kvm/mmu/shadow_mmu.h b/arch/x86/kvm/mmu/shadow_mmu.h
index 719b10f6c403..83876047c1f5 100644
--- a/arch/x86/kvm/mmu/shadow_mmu.h
+++ b/arch/x86/kvm/mmu/shadow_mmu.h
@@ -5,4 +5,149 @@
 
 #include <linux/kvm_host.h>
 
+/* make pte_list_desc fit well in cache lines */
+#define PTE_LIST_EXT 14
+
+/*
+ * Slight optimization of cacheline layout, by putting `more' and `spte_count'
+ * at the start; then accessing it will only use one single cacheline for
+ * either full (entries==PTE_LIST_EXT) case or entries<=6.
+ */
+struct pte_list_desc {
+	struct pte_list_desc *more;
+	/*
+	 * Stores number of entries stored in the pte_list_desc.  No need to be
+	 * u64 but just for easier alignment.  When PTE_LIST_EXT, means full.
+	 */
+	u64 spte_count;
+	u64 *sptes[PTE_LIST_EXT];
+};
+
+unsigned int pte_list_count(struct kvm_rmap_head *rmap_head);
+
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
+bool mmu_spte_update(u64 *sptep, u64 new_spte);
+void mmu_spte_clear_no_track(u64 *sptep);
+gfn_t kvm_mmu_page_get_gfn(struct kvm_mmu_page *sp, int index);
+void kvm_mmu_page_set_access(struct kvm_mmu_page *sp, int index,
+			     unsigned int access);
+
+struct kvm_rmap_head *gfn_to_rmap(gfn_t gfn, int level,
+				  const struct kvm_memory_slot *slot);
+bool rmap_can_add(struct kvm_vcpu *vcpu);
+void drop_spte(struct kvm *kvm, u64 *sptep);
+bool rmap_write_protect(struct kvm_rmap_head *rmap_head, bool pt_protect);
+bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			const struct kvm_memory_slot *slot);
+bool kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		  struct kvm_memory_slot *slot, gfn_t gfn, int level,
+		  pte_t unused);
+bool kvm_set_pte_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		      struct kvm_memory_slot *slot, gfn_t gfn, int level,
+		      pte_t pte);
+
+typedef bool (*rmap_handler_t)(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			       struct kvm_memory_slot *slot, gfn_t gfn,
+			       int level, pte_t pte);
+bool kvm_handle_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range,
+			  rmap_handler_t handler);
+
+bool kvm_age_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		  struct kvm_memory_slot *slot, gfn_t gfn, int level,
+		  pte_t unused);
+bool kvm_test_age_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		       struct kvm_memory_slot *slot, gfn_t gfn,
+		       int level, pte_t unused);
+
+void drop_parent_pte(struct kvm_mmu_page *sp, u64 *parent_pte);
+int nonpaging_sync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp);
+int mmu_sync_children(struct kvm_vcpu *vcpu, struct kvm_mmu_page *parent,
+		      bool can_yield);
+void __clear_sp_write_flooding_count(struct kvm_mmu_page *sp);
+void clear_sp_write_flooding_count(u64 *spte);
+
+struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu, u64 *sptep,
+					  gfn_t gfn, bool direct,
+					  unsigned int access);
+
+void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterator,
+				 struct kvm_vcpu *vcpu, hpa_t root, u64 addr);
+void shadow_walk_init(struct kvm_shadow_walk_iterator *iterator,
+		      struct kvm_vcpu *vcpu, u64 addr);
+bool shadow_walk_okay(struct kvm_shadow_walk_iterator *iterator);
+void shadow_walk_next(struct kvm_shadow_walk_iterator *iterator);
+
+void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep, struct kvm_mmu_page *sp);
+
+void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
+			  unsigned direct_access);
+
+int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp, u64 *spte,
+		     struct list_head *invalid_list);
+bool __kvm_mmu_prepare_zap_page(struct kvm *kvm, struct kvm_mmu_page *sp,
+				struct list_head *invalid_list,
+				int *nr_zapped);
+bool kvm_mmu_prepare_zap_page(struct kvm *kvm, struct kvm_mmu_page *sp,
+			      struct list_head *invalid_list);
+void kvm_mmu_commit_zap_page(struct kvm *kvm, struct list_head *invalid_list);
+
+int make_mmu_pages_available(struct kvm_vcpu *vcpu);
+
+int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva);
+
+int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
+		 u64 *sptep, unsigned int pte_access, gfn_t gfn,
+		 kvm_pfn_t pfn, struct kvm_page_fault *fault);
+void __direct_pte_prefetch(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
+			   u64 *sptep);
+int __direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
+u64 *fast_pf_get_last_sptep(struct kvm_vcpu *vcpu, gpa_t gpa, u64 *spte);
+
+hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant, u8 level);
+int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu);
+int mmu_alloc_special_roots(struct kvm_vcpu *vcpu);
+
+int get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes, int *root_level);
+
+void shadow_page_table_clear_flood(struct kvm_vcpu *vcpu, gva_t addr);
+void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
+		       int bytes, struct kvm_page_track_notifier_node *node);
+
+/* The return value indicates if tlb flush on all vcpus is needed. */
+typedef bool (*slot_level_handler) (struct kvm *kvm,
+				    struct kvm_rmap_head *rmap_head,
+				    const struct kvm_memory_slot *slot);
+bool slot_handle_level(struct kvm *kvm, const struct kvm_memory_slot *memslot,
+		       slot_level_handler fn, int start_level, int end_level,
+		       bool flush_on_yield);
+bool slot_handle_level_4k(struct kvm *kvm, const struct kvm_memory_slot *memslot,
+			  slot_level_handler fn, bool flush_on_yield);
+
+void kvm_zap_obsolete_pages(struct kvm *kvm);
+bool kvm_rmap_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
+
+bool slot_rmap_write_protect(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			     const struct kvm_memory_slot *slot);
+
+void kvm_shadow_mmu_try_split_huge_pages(struct kvm *kvm,
+					 const struct kvm_memory_slot *slot,
+					 gfn_t start, gfn_t end,
+					 int target_level);
+void kvm_rmap_zap_collapsible_sptes(struct kvm *kvm,
+				    const struct kvm_memory_slot *slot);
+
+unsigned long mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc);
 #endif /* __KVM_X86_MMU_SHADOW_MMU_H */
-- 
2.39.0.314.g84b9a713c41-goog

