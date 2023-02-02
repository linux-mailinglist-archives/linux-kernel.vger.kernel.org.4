Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0DC688664
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjBBS2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjBBS21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:28:27 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58611E9DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:28:20 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id ls15-20020a17090b350f00b0022e601fa9e6so3257947pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxKe7Lw8l+Mx0w7jZKX1pH/HEpUfPWqwIgLzjXVd3Vk=;
        b=rebAKGLvNp+3ijcwuDqkO0k3UA+4y2RWEIs2g5bQcv3wWKbvJ6yGLbiJ3ICht38aq2
         MyN0zR8GK30mk+DrTJUNwc442qYjZtx8xJKdnGNW2bNbp1CHrmL4ML44zV/LyH/sJQvT
         ddK+3gv4X6aO0ctRLj+5Dt6PZIYQqcX/UHvSDm3S1xPWac+108ylZrqVkVIAOdDsHl0O
         8KU9+zKhVBQczB2IBPY4W0ASZjtW7kX9o04RqN4wx8FKQk9oETxmLuiDzHmmNwFKRwpF
         drKFftkZ32hj9UTmBECN5SVx7R8R/yyeGi6L/yU8cii2FzHk/oJTz4XJCpL9EfQp2qMX
         7taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxKe7Lw8l+Mx0w7jZKX1pH/HEpUfPWqwIgLzjXVd3Vk=;
        b=aabiw3LBGDyZXcX6NCYHEA1RHjCohpHJ5wuekZQS7JxyxngBnuasOuMf1lwrtFTjYJ
         RzrChgQL7JhFJVCiL3NEmECzCU/xdkW3Yli8uES0YvWwqDjyQauY7niXWTrHu1A3tm8A
         F/gkbNeKoBxtQBVcLL9510V0UuAqE+f+JHGFRbEvJYJT8mYgxFBSrhfK2ZVGQmsDdwme
         l+oYT7aaf4cyZoFlI78A0Npv34iL7XR0/flcdGEbbM4zBkdutWidXO1s8SYjDixHHVTC
         Tk7C5dsIpg+KnUB6wBydUX9B7FtTZoBKXjehamCKXooQZOeF5QjxmTIbpFscxYyNX7dr
         JTxA==
X-Gm-Message-State: AO0yUKV4L8yrqM37oYRATVvL9oV9ta8gnHLTqVIkmjxKmF1ZWHCT5hli
        MyNdTwukf7AZuXGbCoepY/F5laRuK4N7q51OnNfwFt5ImzmV0qWEU49zVSux5oWCrHQuzaC3/Bb
        U5gDUcdzMJfjaHa/R81Bj8YhIOHBnZBpYLZWVf2l4gKEAoui5u2JcHmJ73lVELKOjNMuT4xd5
X-Google-Smtp-Source: AK7set+MaZjurroyVtKz4jhyNoP1rvY97OkptVFZcIxySuecoOVDqftqOneq0uSyKfvPCKH+wzWuH3Z85m7r
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:902:d508:b0:196:7127:2240 with SMTP id
 b8-20020a170902d50800b0019671272240mr1761378plg.11.1675362499606; Thu, 02 Feb
 2023 10:28:19 -0800 (PST)
Date:   Thu,  2 Feb 2023 18:27:53 +0000
In-Reply-To: <20230202182809.1929122-1-bgardon@google.com>
Mime-Version: 1.0
References: <20230202182809.1929122-1-bgardon@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202182809.1929122-6-bgardon@google.com>
Subject: [PATCH 05/21] KVM: x86/MMU: Expose functions for the Shadow MMU
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

Expose various common MMU functions which the Shadow MMU will need via
mmu_internal.h. This slightly reduces the work needed to move the
shadow MMU code out of mmu.c, which will already be a massive change.

No functional change intended.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 41 ++++++++++++++-------------------
 arch/x86/kvm/mmu/mmu_internal.h | 24 +++++++++++++++++++
 2 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 752c38d625a32..12d38a8772a80 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -164,9 +164,9 @@ struct kvm_shadow_walk_iterator {
 		({ spte = mmu_spte_get_lockless(_walker.sptep); 1; });	\
 	     __shadow_walk_next(&(_walker), spte))
 
-static struct kmem_cache *pte_list_desc_cache;
+struct kmem_cache *pte_list_desc_cache;
 struct kmem_cache *mmu_page_header_cache;
-static struct percpu_counter kvm_total_used_mmu_pages;
+struct percpu_counter kvm_total_used_mmu_pages;
 
 static void mmu_spte_set(u64 *sptep, u64 spte);
 
@@ -242,11 +242,6 @@ static struct kvm_mmu_role_regs vcpu_to_role_regs(struct kvm_vcpu *vcpu)
 	return regs;
 }
 
-static inline bool kvm_available_flush_tlb_with_range(void)
-{
-	return kvm_x86_ops.tlb_remote_flush_with_range;
-}
-
 static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
 		struct kvm_tlb_range *range)
 {
@@ -270,8 +265,8 @@ void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 	kvm_flush_remote_tlbs_with_range(kvm, &range);
 }
 
-static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
-			   unsigned int access)
+void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
+		    unsigned int access)
 {
 	u64 spte = make_mmio_spte(vcpu, gfn, access);
 
@@ -623,7 +618,7 @@ static inline bool is_tdp_mmu_active(struct kvm_vcpu *vcpu)
 	return tdp_mmu_enabled && vcpu->arch.mmu->root_role.direct;
 }
 
-static void walk_shadow_page_lockless_begin(struct kvm_vcpu *vcpu)
+void walk_shadow_page_lockless_begin(struct kvm_vcpu *vcpu)
 {
 	if (is_tdp_mmu_active(vcpu)) {
 		kvm_tdp_mmu_walk_lockless_begin();
@@ -642,7 +637,7 @@ static void walk_shadow_page_lockless_begin(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void walk_shadow_page_lockless_end(struct kvm_vcpu *vcpu)
+void walk_shadow_page_lockless_end(struct kvm_vcpu *vcpu)
 {
 	if (is_tdp_mmu_active(vcpu)) {
 		kvm_tdp_mmu_walk_lockless_end();
@@ -835,8 +830,8 @@ void track_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 		      &kvm->arch.possible_nx_huge_pages);
 }
 
-static void account_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
-				 bool nx_huge_page_possible)
+void account_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
+			  bool nx_huge_page_possible)
 {
 	sp->nx_huge_page_disallowed = true;
 
@@ -870,16 +865,15 @@ void untrack_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 	list_del_init(&sp->possible_nx_huge_page_link);
 }
 
-static void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	sp->nx_huge_page_disallowed = false;
 
 	untrack_possible_nx_huge_page(kvm, sp);
 }
 
-static struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu,
-							   gfn_t gfn,
-							   bool no_dirty_log)
+struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu,
+						    gfn_t gfn, bool no_dirty_log)
 {
 	struct kvm_memory_slot *slot;
 
@@ -1415,7 +1409,7 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 	return write_protected;
 }
 
-static bool kvm_vcpu_write_protect_gfn(struct kvm_vcpu *vcpu, u64 gfn)
+bool kvm_vcpu_write_protect_gfn(struct kvm_vcpu *vcpu, u64 gfn)
 {
 	struct kvm_memory_slot *slot;
 
@@ -1914,9 +1908,8 @@ static int kvm_sync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	return ret;
 }
 
-static bool kvm_mmu_remote_flush_or_zap(struct kvm *kvm,
-					struct list_head *invalid_list,
-					bool remote_flush)
+bool kvm_mmu_remote_flush_or_zap(struct kvm *kvm, struct list_head *invalid_list,
+				 bool remote_flush)
 {
 	if (!remote_flush && list_empty(invalid_list))
 		return false;
@@ -1928,7 +1921,7 @@ static bool kvm_mmu_remote_flush_or_zap(struct kvm *kvm,
 	return true;
 }
 
-static bool is_obsolete_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
+bool is_obsolete_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	if (sp->role.invalid)
 		return true;
@@ -6216,7 +6209,7 @@ static inline bool need_topup(struct kvm_mmu_memory_cache *cache, int min)
 	return kvm_mmu_memory_cache_nr_free_objects(cache) < min;
 }
 
-static bool need_topup_split_caches_or_resched(struct kvm *kvm)
+bool need_topup_split_caches_or_resched(struct kvm *kvm)
 {
 	if (need_resched() || rwlock_needbreak(&kvm->mmu_lock))
 		return true;
@@ -6231,7 +6224,7 @@ static bool need_topup_split_caches_or_resched(struct kvm *kvm)
 	       need_topup(&kvm->arch.split_shadow_page_cache, 1);
 }
 
-static int topup_split_caches(struct kvm *kvm)
+int topup_split_caches(struct kvm *kvm)
 {
 	/*
 	 * Allocating rmap list entries when splitting huge pages for nested
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index ac00bfbf32f67..95f0adfb3b0b4 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -131,7 +131,9 @@ struct kvm_mmu_page {
 #endif
 };
 
+extern struct kmem_cache *pte_list_desc_cache;
 extern struct kmem_cache *mmu_page_header_cache;
+extern struct percpu_counter kvm_total_used_mmu_pages;
 
 static inline int kvm_mmu_role_as_id(union kvm_mmu_page_role role)
 {
@@ -323,6 +325,28 @@ void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_
 void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 
 void track_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
+void account_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
+			  bool nx_huge_page_possible);
 void untrack_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
+void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 
+static inline bool kvm_available_flush_tlb_with_range(void)
+{
+	return kvm_x86_ops.tlb_remote_flush_with_range;
+}
+
+void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
+		    unsigned int access);
+struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu,
+						    gfn_t gfn, bool no_dirty_log);
+bool kvm_vcpu_write_protect_gfn(struct kvm_vcpu *vcpu, u64 gfn);
+bool kvm_mmu_remote_flush_or_zap(struct kvm *kvm, struct list_head *invalid_list,
+				 bool remote_flush);
+bool is_obsolete_sp(struct kvm *kvm, struct kvm_mmu_page *sp);
+
+void walk_shadow_page_lockless_begin(struct kvm_vcpu *vcpu);
+void walk_shadow_page_lockless_end(struct kvm_vcpu *vcpu);
+
+bool need_topup_split_caches_or_resched(struct kvm *kvm);
+int topup_split_caches(struct kvm *kvm);
 #endif /* __KVM_X86_MMU_INTERNAL_H */
-- 
2.39.1.519.gcb327c4b5f-goog

