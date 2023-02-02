Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C745688689
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjBBSa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjBBSaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:30:14 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BDC67798
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:29:05 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id s76-20020a632c4f000000b0049ceb0f185eso1366043pgs.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NXpeAGdEPSulNPWvHhUL3AAPz0Ix6lkzu8E3W+75JBc=;
        b=dsU/td+8xp0leO2w7PQmQDrRLVy4p/HFJoA82VAfk4ElPpgJQNeyIPufST4m9JSM8x
         sn/Fp0hiIj1iDpo4oSb+h3kxZ1s0jSEc6CGM3PAMMXIAsXOdNQfVWWI1VzLR0lRrTIwV
         wu/ZEVfSv9U1/3EGwxbBaciymb7Fjp1VaYTkt9B7xxT4FqzoaQ2xEDqUGUALILNQVMZs
         D5Z+J+zNsc+S5sTYOEhy+oOF4Ry6e6UzvFGlARBvoY5fn+OVeVpOptjD8H893NbK61MR
         6nKY4HCqESI6ItEmDJWLCnauPvJVXHbI5Ji8C8rdpYM+a75osUi0570GEeEdduDQoZsc
         PsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXpeAGdEPSulNPWvHhUL3AAPz0Ix6lkzu8E3W+75JBc=;
        b=JcgG9BWynumluwwUY5HQXmedFA7TQWwvvm4RKX6hiWzroQx9byqtPl1jWNNFwnSKYY
         JyQxGTvvGxK0HXkFTgqWJikKAyDBSOwoWH+FDon2Tvdjh1xyYXCe9PJModTSovXAEmjG
         nRRyyzOi6ahj3I+qA3B05Y/uIl2CASAdhkzgodYoSjLDeYo1fQVB2wAi6if9fO1LKXOl
         0v0L1uCR5RDI1hhrsJ7P/Tzb/mmPBeV/mEg28PHuLUxllG2G1vc3fBKpFxAWVQvRXnMK
         7XNQ1Vnsf9YuMIVivX8/M3uyixccfHM1y2+h4b/5qcVa2MK0VB+kf1Dxmxibf36Qo6bE
         JoAw==
X-Gm-Message-State: AO0yUKXuTzS1WiHZc7o9VrXjbvwk3HFuAMxuHP9pm96dy+huBLjUsrJI
        +j0eX9+8dhOejsBDuer1PXO7Xq6EjVt9Kyx4IYgeeqS4scqU03EVP07/oh83aoSOXUFk4scwDmo
        wxdRdKdYEcTrjeRimrDbuIaj4hQOUgj/DgDEVrqZGdElrHll/ybLopdalQQ/kxtgv9jOQ78ZG
X-Google-Smtp-Source: AK7set/b1yCP/FerSKiPyPM8xLIL35lEk8M1ZjBZaXr0G0KxaPsZ+C6JCCsS90zsyT9Kiw0fhDdDUBnmNLjX
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:902:7885:b0:196:7545:2cca with SMTP id
 q5-20020a170902788500b0019675452ccamr1670026pll.0.1675362526384; Thu, 02 Feb
 2023 10:28:46 -0800 (PST)
Date:   Thu,  2 Feb 2023 18:28:09 +0000
In-Reply-To: <20230202182809.1929122-1-bgardon@google.com>
Mime-Version: 1.0
References: <20230202182809.1929122-1-bgardon@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202182809.1929122-22-bgardon@google.com>
Subject: [PATCH 21/21] KVM: x86/mmu: Split out Shadow MMU lockless walk begin/end
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

Split out the meat of kvm_shadow_mmu_walk_lockless_begin/end() to
functions in shadow_mmu.c since there's no need for it in the common MMU
code.

Suggested-by: David Matlack <dmatlack@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c        | 31 ++++++-------------------------
 arch/x86/kvm/mmu/shadow_mmu.c | 27 +++++++++++++++++++++++++++
 arch/x86/kvm/mmu/shadow_mmu.h |  3 +++
 3 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 10aff23dea75d..cfccc4c7a1427 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -207,37 +207,18 @@ static inline bool is_tdp_mmu_active(struct kvm_vcpu *vcpu)
 
 void walk_shadow_page_lockless_begin(struct kvm_vcpu *vcpu)
 {
-	if (is_tdp_mmu_active(vcpu)) {
+	if (is_tdp_mmu_active(vcpu))
 		kvm_tdp_mmu_walk_lockless_begin();
-	} else {
-		/*
-		 * Prevent page table teardown by making any free-er wait during
-		 * kvm_flush_remote_tlbs() IPI to all active vcpus.
-		 */
-		local_irq_disable();
-
-		/*
-		 * Make sure a following spte read is not reordered ahead of the write
-		 * to vcpu->mode.
-		 */
-		smp_store_mb(vcpu->mode, READING_SHADOW_PAGE_TABLES);
-	}
+	else
+		kvm_shadow_mmu_walk_lockless_begin(vcpu);
 }
 
 void walk_shadow_page_lockless_end(struct kvm_vcpu *vcpu)
 {
-	if (is_tdp_mmu_active(vcpu)) {
+	if (is_tdp_mmu_active(vcpu))
 		kvm_tdp_mmu_walk_lockless_end();
-	} else {
-		/*
-		 * Make sure the write to vcpu->mode is not reordered in front
-		 * of reads to sptes.  If it does,
-		 * kvm_shadow_mmu_commit_zap_page() can see us
-		 * OUTSIDE_GUEST_MODE and proceed to free the shadow page table.
-		 */
-		smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);
-		local_irq_enable();
-	}
+	else
+		kvm_shadow_mmu_walk_lockless_end(vcpu);
 }
 
 int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
diff --git a/arch/x86/kvm/mmu/shadow_mmu.c b/arch/x86/kvm/mmu/shadow_mmu.c
index 6449ac4de4883..c5d0accd6e057 100644
--- a/arch/x86/kvm/mmu/shadow_mmu.c
+++ b/arch/x86/kvm/mmu/shadow_mmu.c
@@ -3663,3 +3663,30 @@ void kvm_mmu_uninit_shadow_mmu(struct kvm *kvm)
 	kvm_mmu_free_memory_cache(&kvm->arch.split_page_header_cache);
 	kvm_mmu_free_memory_cache(&kvm->arch.split_shadow_page_cache);
 }
+
+void kvm_shadow_mmu_walk_lockless_begin(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Prevent page table teardown by making any free-er wait during
+	 * kvm_flush_remote_tlbs() IPI to all active vcpus.
+	 */
+	local_irq_disable();
+
+	/*
+	 * Make sure a following spte read is not reordered ahead of the write
+	 * to vcpu->mode.
+	 */
+	smp_store_mb(vcpu->mode, READING_SHADOW_PAGE_TABLES);
+}
+
+void kvm_shadow_mmu_walk_lockless_end(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Make sure the write to vcpu->mode is not reordered in front
+	 * of reads to sptes.  If it does,
+	 * kvm_shadow_mmu_commit_zap_page() can see us
+	 * OUTSIDE_GUEST_MODE and proceed to free the shadow page table.
+	 */
+	smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);
+	local_irq_enable();
+}
diff --git a/arch/x86/kvm/mmu/shadow_mmu.h b/arch/x86/kvm/mmu/shadow_mmu.h
index f2e54355ebb19..12835872bda34 100644
--- a/arch/x86/kvm/mmu/shadow_mmu.h
+++ b/arch/x86/kvm/mmu/shadow_mmu.h
@@ -103,6 +103,9 @@ void kvm_shadow_mmu_zap_all(struct kvm *kvm);
 void kvm_mmu_init_shadow_mmu(struct kvm *kvm);
 void kvm_mmu_uninit_shadow_mmu(struct kvm *kvm);
 
+void kvm_shadow_mmu_walk_lockless_begin(struct kvm_vcpu *vcpu);
+void kvm_shadow_mmu_walk_lockless_end(struct kvm_vcpu *vcpu);
+
 /* Exports from paging_tmpl.h */
 gpa_t paging32_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			  gpa_t vaddr, u64 access,
-- 
2.39.1.519.gcb327c4b5f-goog

