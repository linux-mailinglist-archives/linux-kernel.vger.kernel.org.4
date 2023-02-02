Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9102E688680
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjBBSaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjBBS3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:29:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA9E7BBCE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:28:55 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u186-20020a2560c3000000b007c8e2cf3668so2499599ybb.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BER/1IEMd55LQsJILKozxqxXLopbafo2dDttN7vu9E=;
        b=ISrUx6Kuco9AWdauP5MGzGSzbbY+lXEVtPZgbIuskIdrCJHulKZdtW9tchPow/b65W
         r6mzDiLmuobwuNPQSb1bV2KFT+HyPogGNXEaSWcOfj8x1Q5iMIxrAUa0DmThF98fwoaS
         zrXX6j1MEqV1WZqqSOGJOzErglfd4ZKsJ6cNUrgxapKSOurF4vPgRRSPMp6Q0nhA1B08
         mTBtKS0K8UDTCVZQP+sWrDG3XitQfLOE9PayJASe6vHecnUas6f7iheUi6OydFSnCl0x
         ruPNuic9DuThsqzjqnuyIc4piacsKGtz2B2XTB/3IqRTheKSefBJ4Qd/O0UzCVYaxZV2
         7CRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BER/1IEMd55LQsJILKozxqxXLopbafo2dDttN7vu9E=;
        b=H2mvV67FZ2wgIgu2LiTKYvcYDf3GfC3Ec4R2MtIELJT1e4oODmOaAtE81+kCxAzh9I
         s9USIXMpJfzimyEHRFW8uTCNmtbeTV7fQdVqIWdtFDxmwD/e2HMrfROj5jEDHYSr9KqS
         4cgdYC8YtfiCIb0OmFfNrFk6tw9VfLhUpQtXCZbVxRgEdE3RJOfe6xy3GmN/GgIP/FiL
         zDk6GJxENIsn5DTEn/V4/DXMuUE6RQFjU5+Nw7aThncyg0T1X7njgUDMNxhb5iJqdqBo
         r6sHpH4E6cTpIC7gzKoRNpwuL33yjt3p1RZHwldEJF/G87KyptUXxR6eYWWCTvpbYB37
         /VRw==
X-Gm-Message-State: AO0yUKVo0ywVc7ixNo85D/TaWod87WZfvCoQZ0o2uKD/jvwbKq31/rAB
        0eicU4OE+cju2/GV8Fi2ms9AEaQ1zLyrGIrvALgbivtATwIhdOQT5RrKvsl2+jNE3HmZeX/r2q5
        HzPfRddsQHthqbAIjlw4KXiw7yIzwPCnHUP4a6bXqPwxhiL+Nju+On/2cSNeZZi++Zb3zHciD
X-Google-Smtp-Source: AK7set+39HFoPNq8UWIR8jmmvH/HsHhRQwm/tZzjufgYKKYKcDLx4/yXFYU+R1bqa0FXq3rZoHEDmPqDOoVM
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a81:1952:0:b0:521:e063:71e7 with SMTP id
 79-20020a811952000000b00521e06371e7mr5ywz.9.1675362516022; Thu, 02 Feb 2023
 10:28:36 -0800 (PST)
Date:   Thu,  2 Feb 2023 18:28:03 +0000
In-Reply-To: <20230202182809.1929122-1-bgardon@google.com>
Mime-Version: 1.0
References: <20230202182809.1929122-1-bgardon@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202182809.1929122-16-bgardon@google.com>
Subject: [PATCH 15/21] KVM: x86/MMU: Remove unneeded exports from shadow_mmu.c
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

Now that the various dirty logging / wrprot function implementations are
in shadow_mmu.c, do another round of cleanups to remove functions which
no longer need to be exposed and can be marked static.

No functional change intended.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/shadow_mmu.c | 32 +++++++++++++++++++-------------
 arch/x86/kvm/mmu/shadow_mmu.h | 18 ------------------
 2 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/mmu/shadow_mmu.c b/arch/x86/kvm/mmu/shadow_mmu.c
index b93a6174717d3..dc5c4b9899cc6 100644
--- a/arch/x86/kvm/mmu/shadow_mmu.c
+++ b/arch/x86/kvm/mmu/shadow_mmu.c
@@ -634,8 +634,8 @@ unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
 	return count;
 }
 
-struct kvm_rmap_head *gfn_to_rmap(gfn_t gfn, int level,
-				  const struct kvm_memory_slot *slot)
+static struct kvm_rmap_head *gfn_to_rmap(gfn_t gfn, int level,
+					 const struct kvm_memory_slot *slot)
 {
 	unsigned long idx;
 
@@ -803,7 +803,7 @@ static bool spte_write_protect(u64 *sptep, bool pt_protect)
 	return mmu_spte_update(sptep, spte);
 }
 
-bool rmap_write_protect(struct kvm_rmap_head *rmap_head, bool pt_protect)
+static bool rmap_write_protect(struct kvm_rmap_head *rmap_head, bool pt_protect)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -842,8 +842,8 @@ static bool spte_wrprot_for_clear_dirty(u64 *sptep)
  *	- W bit on ad-disabled SPTEs.
  * Returns true iff any D or W bits were cleared.
  */
-bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-			const struct kvm_memory_slot *slot)
+static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			       const struct kvm_memory_slot *slot)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -3057,6 +3057,11 @@ void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
 	write_unlock(&vcpu->kvm->mmu_lock);
 }
 
+/* The return value indicates if tlb flush on all vcpus is needed. */
+typedef bool (*slot_rmaps_handler) (struct kvm *kvm,
+				    struct kvm_rmap_head *rmap_head,
+				    const struct kvm_memory_slot *slot);
+
 static __always_inline bool __walk_slot_rmaps(struct kvm *kvm,
 					      const struct kvm_memory_slot *slot,
 					      slot_rmaps_handler fn,
@@ -3087,20 +3092,21 @@ static __always_inline bool __walk_slot_rmaps(struct kvm *kvm,
 	return flush;
 }
 
-__always_inline bool walk_slot_rmaps(struct kvm *kvm,
-				     const struct kvm_memory_slot *slot,
-				     slot_rmaps_handler fn, int start_level,
-				     int end_level, bool flush_on_yield)
+static __always_inline bool walk_slot_rmaps(struct kvm *kvm,
+					    const struct kvm_memory_slot *slot,
+					    slot_rmaps_handler fn,
+					    int start_level, int end_level,
+					    bool flush_on_yield)
 {
 	return __walk_slot_rmaps(kvm, slot, fn, start_level, end_level,
 				 slot->base_gfn, slot->base_gfn + slot->npages - 1,
 				 flush_on_yield, false);
 }
 
-__always_inline bool walk_slot_rmaps_4k(struct kvm *kvm,
-					const struct kvm_memory_slot *slot,
-					slot_rmaps_handler fn,
-					bool flush_on_yield)
+static __always_inline bool walk_slot_rmaps_4k(struct kvm *kvm,
+					       const struct kvm_memory_slot *slot,
+					       slot_rmaps_handler fn,
+					       bool flush_on_yield)
 {
 	return walk_slot_rmaps(kvm, slot, fn, PG_LEVEL_4K,
 			       PG_LEVEL_4K, flush_on_yield);
diff --git a/arch/x86/kvm/mmu/shadow_mmu.h b/arch/x86/kvm/mmu/shadow_mmu.h
index 58f48293b4773..36fe8013931d2 100644
--- a/arch/x86/kvm/mmu/shadow_mmu.h
+++ b/arch/x86/kvm/mmu/shadow_mmu.h
@@ -39,11 +39,6 @@ struct pte_list_desc {
 /* Only exported for debugfs.c. */
 unsigned int pte_list_count(struct kvm_rmap_head *rmap_head);
 
-struct kvm_rmap_head *gfn_to_rmap(gfn_t gfn, int level,
-				  const struct kvm_memory_slot *slot);
-bool rmap_write_protect(struct kvm_rmap_head *rmap_head, bool pt_protect);
-bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-			const struct kvm_memory_slot *slot);
 bool kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 		  struct kvm_memory_slot *slot, gfn_t gfn, int level,
 		  pte_t unused);
@@ -91,22 +86,9 @@ int kvm_shadow_mmu_get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes,
 void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
 		       int bytes, struct kvm_page_track_notifier_node *node);
 
-/* The return value indicates if tlb flush on all vcpus is needed. */
-typedef bool (*slot_rmaps_handler) (struct kvm *kvm,
-				    struct kvm_rmap_head *rmap_head,
-				    const struct kvm_memory_slot *slot);
-bool walk_slot_rmaps(struct kvm *kvm, const struct kvm_memory_slot *slot,
-		       slot_rmaps_handler fn, int start_level, int end_level,
-		       bool flush_on_yield);
-bool walk_slot_rmaps_4k(struct kvm *kvm, const struct kvm_memory_slot *slot,
-			slot_rmaps_handler fn, bool flush_on_yield);
-
 void kvm_shadow_mmu_zap_obsolete_pages(struct kvm *kvm);
 bool kvm_shadow_mmu_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
 
-bool slot_rmap_write_protect(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-			     const struct kvm_memory_slot *slot);
-
 void kvm_shadow_mmu_try_split_huge_pages(struct kvm *kvm,
 					 const struct kvm_memory_slot *slot,
 					 gfn_t start, gfn_t end,
-- 
2.39.1.519.gcb327c4b5f-goog

