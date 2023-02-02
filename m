Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D56068865B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjBBS2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjBBS2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:28:18 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2C3265B8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:28:17 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id k16-20020a635a50000000b0042986056df6so1366117pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OApy4O0jSWZaxP9yRDTnwWGTbe0pAxcU+yFhklbFDjU=;
        b=E6j6K2Cd3cHV60TkGdQXzHn0GMsSZ+APABGIDp9NcizWH0fxalbd2/UOO7UoBv2DrB
         gxQtS3CRY6dUNStY5iKnL+BtTrvlacr6wqlD+WDHbBY6LB6jKpd+fpv7gHPQl9J6wbX7
         R1WUD07zUy03S6GRJz3I5femHFrlHEwS+NUE1KSf3/fkJiOt1cRpLR5/kTexMxtVJy0I
         tM0yhd7ZKR81cFTAN7N8uPCbzghtqPWcP4SAlzhI4f3sX7YkzWAJ0M4Pn2Qn+BJuAHKX
         et2Y5KW0mcUSCOHiHE0z6i7Wm0k8cIMKYPcEOP3NY+xEkSSjyEPc+USyS3mUXrKv4S1H
         QKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OApy4O0jSWZaxP9yRDTnwWGTbe0pAxcU+yFhklbFDjU=;
        b=4CUbRjCKXnR48ix0f6b4tdvRTxzBiwg312WY8BBqJ81kq+2lFgYN/hwEVFajB8O/V8
         mn7RnzMGD8pDmeOrBiiD80QQe9PIPsWaoXwUnB5Bsuj4m65E2Hj6AxOMVU7BRKALNtnE
         1YJoU6mtpY0Xea1t91FhhBDHjYiPtC0zFkkdGTilADMhID5NframnI8dMn2yQSQnyvib
         7wWXkuVrBu/IXKOHs3Vivv9Drb5mku7XDnqQnluCza2YxQUVXNu3+RGOY4BioIvy/eM8
         eyB7KgEpg/hc6Kh2xdnqw86qKiUf29H/MOlPXvspN5qFC2L2FQ1CyayVegA2pva8zaaO
         98cg==
X-Gm-Message-State: AO0yUKVA3hRaAY2KLE5iwjgVlMvHVmGWM6XLpIN5IzTJ7rN9zgvunC5r
        Wv7ma8X0gzmjiL5vX9UsHwjb+zzksQmhfYQggviVO+fcySN6yc9c88eped0noM4EqendyDJQNLM
        Xm4N/QPBW1LjnM2s1OhZKOejigJYGTM6t0V/fccyhT8/dO+uEd5nz/e3V81ZI1ToKpPoCXIiO
X-Google-Smtp-Source: AK7set8amElDK0tuA+45x3He3tCI1LLVvZRUiwy/7da+rwCJCPtTzrLR2Jp2wIuR3GghmCBzeQ3D6/7vceCk
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:90a:17ef:b0:22c:5369:8a36 with SMTP id
 q102-20020a17090a17ef00b0022c53698a36mr52pja.0.1675362496248; Thu, 02 Feb
 2023 10:28:16 -0800 (PST)
Date:   Thu,  2 Feb 2023 18:27:51 +0000
In-Reply-To: <20230202182809.1929122-1-bgardon@google.com>
Mime-Version: 1.0
References: <20230202182809.1929122-1-bgardon@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202182809.1929122-4-bgardon@google.com>
Subject: [PATCH 03/21] KVM: x86/mmu: Clean up mmu.c functions that put return
 type on separate line
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

From: Sean Christopherson <seanjc@google.com>

Adjust a variety of functions in mmu.c to put the function return type on
the same line as the function declaration.  As stated in the Linus
specification:

  But the "on their own line" is complete garbage to begin with. That
  will NEVER be a kernel rule. We should never have a rule that assumes
  things are so long that they need to be on multiple lines.

  We don't put function return types on their own lines either, even if
  some other projects have that rule (just to get function names at the
  beginning of lines or some other odd reason).

Leave the functions generated by BUILD_MMU_ROLE_REGS_ACCESSOR() as-is,
that code is basically illegible no matter how it's formatted.

No functional change intended.

Link: https://lore.kernel.org/mm-commits/CAHk-=wjS-Jg7sGMwUPpDsjv392nDOOs0CtUtVkp=S6Q7JzFJRw@mail.gmail.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 59 ++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2ea8e58f83256..3674bde2203b2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -876,9 +876,9 @@ static void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 	untrack_possible_nx_huge_page(kvm, sp);
 }
 
-static struct kvm_memory_slot *
-gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu, gfn_t gfn,
-			    bool no_dirty_log)
+static struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu,
+							   gfn_t gfn,
+							   bool no_dirty_log)
 {
 	struct kvm_memory_slot *slot;
 
@@ -938,10 +938,9 @@ static int pte_list_add(struct kvm_mmu_memory_cache *cache, u64 *spte,
 	return count;
 }
 
-static void
-pte_list_desc_remove_entry(struct kvm_rmap_head *rmap_head,
-			   struct pte_list_desc *desc, int i,
-			   struct pte_list_desc *prev_desc)
+static void pte_list_desc_remove_entry(struct kvm_rmap_head *rmap_head,
+				       struct pte_list_desc *desc, int i,
+				       struct pte_list_desc *prev_desc)
 {
 	int j = desc->spte_count - 1;
 
@@ -1493,8 +1492,8 @@ struct slot_rmap_walk_iterator {
 	struct kvm_rmap_head *end_rmap;
 };
 
-static void
-rmap_walk_init_level(struct slot_rmap_walk_iterator *iterator, int level)
+static void rmap_walk_init_level(struct slot_rmap_walk_iterator *iterator,
+				 int level)
 {
 	iterator->level = level;
 	iterator->gfn = iterator->start_gfn;
@@ -1502,10 +1501,10 @@ rmap_walk_init_level(struct slot_rmap_walk_iterator *iterator, int level)
 	iterator->end_rmap = gfn_to_rmap(iterator->end_gfn, level, iterator->slot);
 }
 
-static void
-slot_rmap_walk_init(struct slot_rmap_walk_iterator *iterator,
-		    const struct kvm_memory_slot *slot, int start_level,
-		    int end_level, gfn_t start_gfn, gfn_t end_gfn)
+static void slot_rmap_walk_init(struct slot_rmap_walk_iterator *iterator,
+				const struct kvm_memory_slot *slot,
+				int start_level, int end_level,
+				gfn_t start_gfn, gfn_t end_gfn)
 {
 	iterator->slot = slot;
 	iterator->start_level = start_level;
@@ -3295,9 +3294,9 @@ static bool page_fault_can_be_fast(struct kvm_page_fault *fault)
  * Returns true if the SPTE was fixed successfully. Otherwise,
  * someone else modified the SPTE from its original value.
  */
-static bool
-fast_pf_fix_direct_spte(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
-			u64 *sptep, u64 old_spte, u64 new_spte)
+static bool fast_pf_fix_direct_spte(struct kvm_vcpu *vcpu,
+				    struct kvm_page_fault *fault,
+				    u64 *sptep, u64 old_spte, u64 new_spte)
 {
 	/*
 	 * Theoretically we could also set dirty bit (and flush TLB) here in
@@ -4626,10 +4625,9 @@ static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
 #include "paging_tmpl.h"
 #undef PTTYPE
 
-static void
-__reset_rsvds_bits_mask(struct rsvd_bits_validate *rsvd_check,
-			u64 pa_bits_rsvd, int level, bool nx, bool gbpages,
-			bool pse, bool amd)
+static void __reset_rsvds_bits_mask(struct rsvd_bits_validate *rsvd_check,
+				    u64 pa_bits_rsvd, int level, bool nx,
+				    bool gbpages, bool pse, bool amd)
 {
 	u64 gbpages_bit_rsvd = 0;
 	u64 nonleaf_bit8_rsvd = 0;
@@ -4742,9 +4740,9 @@ static void reset_guest_rsvds_bits_mask(struct kvm_vcpu *vcpu,
 				guest_cpuid_is_amd_or_hygon(vcpu));
 }
 
-static void
-__reset_rsvds_bits_mask_ept(struct rsvd_bits_validate *rsvd_check,
-			    u64 pa_bits_rsvd, bool execonly, int huge_page_level)
+static void __reset_rsvds_bits_mask_ept(struct rsvd_bits_validate *rsvd_check,
+					u64 pa_bits_rsvd, bool execonly,
+					int huge_page_level)
 {
 	u64 high_bits_rsvd = pa_bits_rsvd & rsvd_bits(0, 51);
 	u64 large_1g_rsvd = 0, large_2m_rsvd = 0;
@@ -4844,8 +4842,7 @@ static inline bool boot_cpu_is_amd(void)
  * the direct page table on host, use as much mmu features as
  * possible, however, kvm currently does not do execution-protection.
  */
-static void
-reset_tdp_shadow_zero_bits_mask(struct kvm_mmu *context)
+static void reset_tdp_shadow_zero_bits_mask(struct kvm_mmu *context)
 {
 	struct rsvd_bits_validate *shadow_zero_check;
 	int i;
@@ -5060,8 +5057,8 @@ static void paging32_init_context(struct kvm_mmu *context)
 	context->invlpg = paging32_invlpg;
 }
 
-static union kvm_cpu_role
-kvm_calc_cpu_role(struct kvm_vcpu *vcpu, const struct kvm_mmu_role_regs *regs)
+static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
+					    const struct kvm_mmu_role_regs *regs)
 {
 	union kvm_cpu_role role = {0};
 
@@ -6653,8 +6650,8 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
 	}
 }
 
-static unsigned long
-mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+static unsigned long mmu_shrink_scan(struct shrinker *shrink,
+				     struct shrink_control *sc)
 {
 	struct kvm *kvm;
 	int nr_to_scan = sc->nr_to_scan;
@@ -6712,8 +6709,8 @@ mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	return freed;
 }
 
-static unsigned long
-mmu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+static unsigned long mmu_shrink_count(struct shrinker *shrink,
+				      struct shrink_control *sc)
 {
 	return percpu_counter_read_positive(&kvm_total_used_mmu_pages);
 }
-- 
2.39.1.519.gcb327c4b5f-goog

