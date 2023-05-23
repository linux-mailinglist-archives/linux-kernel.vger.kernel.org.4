Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B39B70E947
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 00:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbjEWWv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 18:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjEWWvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 18:51:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD7FCA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:51:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bac6a453dd5so344535276.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684882311; x=1687474311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnP2L+PrkWu+EM485P08sdt6RHU4vMuznsdnNr0qL8A=;
        b=6jvb+8fWvUa0FJhCsBbdAx0Gab06ZAKeDU5sd+rqDD93rfnU7/tSjqY0W4McHKFGKQ
         3jXcoN5POkVcQKDS9nLxUopBmY/pwIL7nrwRbeTIW4zN6IxM585nuPw2ghkD85/g65Zc
         1qLYRSmVMewc6t6zpOODlJnnfCFREoO6Kw/SIGg+afx5ysEomN0IvOYoTOeh5v/ynPNv
         rapoYYKDMd+TcG7mb7I5ooy6jR3tpIpcD4eNE00yhj5H9MrcqKJ8gAkWClza95gsdG6/
         GWlwQ8j5ZCOCJ0wEVy8h1Yg4bPHVrUPkD22+z+VEZR6BaIBzdXs5H/Rs2F9rHltFcm9B
         0fpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684882311; x=1687474311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnP2L+PrkWu+EM485P08sdt6RHU4vMuznsdnNr0qL8A=;
        b=igY0TbGXzthFRP9yqE7r5D8RjqZTKP4lYHqTkJ2CEqgt0N2wJHbOcZazbuZ5VpItaG
         870fCEGD2SO9AcDYgXHIazgaOAcJiKb6h9AMmD/yZ/zPNNfMNDo4+lSF2IutxQtTScVk
         c7S4JeWfGFjm8Pyjm9AlST6+TT0qTKD/xDxYBa8oU1QB+uG9r/W1GdWQAIK688StP59e
         XkZh4SyM9c3tDG9Oejt6zA71iHfS7yNh6BRd1Jq+Q7JBdI4z5XX9lzB3ymLyYCSJUEOz
         AO/j5z7uUXo9dYjMQZGQTLQJePz8P1F3WqmRQOQVNjpf9bzhEA5iPnr+Xop9zSO4ZzhU
         r8/g==
X-Gm-Message-State: AC+VfDzei1Lovm5KKbioXM8TWprWh4bpUzaruHpqBbxskT/O0QdX8Wyd
        7bPFpJe24Lhs7S9vbywQ6JZ6PRYZScA=
X-Google-Smtp-Source: ACHHUZ4sG+cvyiEhk9tjcIIq1PsOtHI409kEMx110CD8dQmZdMZ7A/Pr3eHV3RVYFcAQwZev31rW/6cMZEg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:110:0:b0:ba7:5d7a:b50d with SMTP id
 16-20020a5b0110000000b00ba75d7ab50dmr9356262ybx.10.1684882310974; Tue, 23 May
 2023 15:51:50 -0700 (PDT)
Date:   Tue, 23 May 2023 15:51:49 -0700
In-Reply-To: <ZFtQeLNuXP6tDMne@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230509134825.1523-1-yan.y.zhao@intel.com> <20230509135006.1604-1-yan.y.zhao@intel.com>
 <ZFsr9TynkA/CyPgg@chao-email> <ZFtQeLNuXP6tDMne@yzhao56-desk.sh.intel.com>
Message-ID: <ZG1DhSdhpTkxrfCq@google.com>
Subject: Re: [PATCH v2 1/6] KVM: x86/mmu: add a new mmu zap helper to indicate
 memtype changes
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023, Yan Zhao wrote:
> On Wed, May 10, 2023 at 01:30:29PM +0800, Chao Gao wrote:
> > On Tue, May 09, 2023 at 09:50:06PM +0800, Yan Zhao wrote:
> > >Add a helper to indicate that the kvm_zap_gfn_range() request is to update
> > >memory type.
> > >
> > >Then the zap can be avoided in cases:
> > >1. TDP is not enabled.
> > >2. EPT is not enabled.
> > >
> > >This is because only memory type of EPT leaf entries are subjected to
> > >change when noncoherent DMA/guest CR0.CD/guest MTRR settings change.
> > >
> > >Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > >---
> > > arch/x86/kvm/mmu.h     |  1 +
> > > arch/x86/kvm/mmu/mmu.c | 16 ++++++++++++++++
> > > 2 files changed, 17 insertions(+)
> > >
> > >diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> > >index 92d5a1924fc1..a04577afbc71 100644
> > >--- a/arch/x86/kvm/mmu.h
> > >+++ b/arch/x86/kvm/mmu.h
> > >@@ -236,6 +236,7 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > }
> > > 
> > > void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
> > >+void kvm_zap_gfn_for_memtype(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
> > > 
> > > int kvm_arch_write_log_dirty(struct kvm_vcpu *vcpu);
> > > 
> > >diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > >index c8961f45e3b1..2706754794d1 100644
> > >--- a/arch/x86/kvm/mmu/mmu.c
> > >+++ b/arch/x86/kvm/mmu/mmu.c
> > >@@ -6272,6 +6272,22 @@ static bool kvm_rmap_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_e
> > > 	return flush;
> > > }
> > > 
> > >+/*
> > >+ * Invalidate (zap) TDP SPTEs that cover GFNs from gfn_start and up to gfn_end
> > >+ * (not including it) for reason of memory type being updated.
> > >+ */
> > >+void kvm_zap_gfn_for_memtype(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
> > >+{
> > >+	/* Currently only memory type of EPT leaf entries are affected by
> > >+	 * guest CR0.CD and guest MTRR.
> > >+	 * So skip invalidation (zap) in other cases
> > >+	 */
> > >+	if (!shadow_memtype_mask)
> > 
> > Do you need to check kvm_arch_has_noncoherent_dma()? if yes, maybe just extract
> > the first if() statement and its associated comment from kvm_tdp_page_fault()?
> >
> This kvm_zap_gfn_for_memtype() helper will be called in
> kvm_arch_unregister_noncoherent_dma() as well when noncoherent_dma_count
> goes from 1 to 0.
> So, checking kvm_arch_has_noncoherent_dma() is not desired.
> 
> > >+		return;
> > >+
> > >+	kvm_zap_gfn_range(kvm, gpa_to_gfn(0), gpa_to_gfn(~0ULL));
> > 
> > This should be:
> > 
> > 	kvm_zap_gfn_range(kvm, start, end);
> >
> Oops. sorry about this mistake. Will fix it in next version.

Rather than add a helper to zap "for memtype", add a helper to query if KVM honors
guest MTRRs.  The "for memtype" isn't intuitive and ends up being incomplete.
That will also allow for deduplicating other code (and a comment).  Waiting until
the zap also wastes cycles in the MTRR case, there's no need to compute start and
end if the zap will ultimately be skipped.

E.g. over two or three patches:

---
 arch/x86/kvm/mmu.h     |  1 +
 arch/x86/kvm/mmu/mmu.c | 19 ++++++++++++++-----
 arch/x86/kvm/mtrr.c    |  2 +-
 arch/x86/kvm/x86.c     |  2 +-
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 92d5a1924fc1..c3c50ec9d9db 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -103,6 +103,7 @@ static inline u8 kvm_get_shadow_phys_bits(void)
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 access_mask);
 void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask);
 void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_exec_only);
+bool kvm_mmu_honors_guest_mtrrs(struct kvm *kvm);
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu);
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c8961f45e3b1..a2b1723bc6a4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4512,12 +4512,10 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu,
 }
 #endif
 
-int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
+bool kvm_mmu_honors_guest_mtrrs(struct kvm *kvm)
 {
 	/*
-	 * If the guest's MTRRs may be used to compute the "real" memtype,
-	 * restrict the mapping level to ensure KVM uses a consistent memtype
-	 * across the entire mapping.  If the host MTRRs are ignored by TDP
+	 * If the TDP is enabled, the host MTRRs are ignored by TDP
 	 * (shadow_memtype_mask is non-zero), and the VM has non-coherent DMA
 	 * (DMA doesn't snoop CPU caches), KVM's ABI is to honor the memtype
 	 * from the guest's MTRRs so that guest accesses to memory that is
@@ -4526,7 +4524,18 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	 * Note, KVM may still ultimately ignore guest MTRRs for certain PFNs,
 	 * e.g. KVM will force UC memtype for host MMIO.
 	 */
-	if (shadow_memtype_mask && kvm_arch_has_noncoherent_dma(vcpu->kvm)) {
+	return tdp_enabled && shadow_memtype_mask &&
+	       kvm_arch_has_noncoherent_dma(kvm);
+}
+
+int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
+{
+	/*
+	 * If the guest's MTRRs may be used to compute the "real" memtype,
+	 * restrict the mapping level to ensure KVM uses a consistent memtype
+	 * across the entire mapping.
+	 */
+	if (kvm_mmu_honors_guest_mtrrs(vcpu->kvm)) {
 		for ( ; fault->max_level > PG_LEVEL_4K; --fault->max_level) {
 			int page_num = KVM_PAGES_PER_HPAGE(fault->max_level);
 			gfn_t base = gfn_round_for_level(fault->gfn,
diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
index 3eb6e7f47e96..a67c28a56417 100644
--- a/arch/x86/kvm/mtrr.c
+++ b/arch/x86/kvm/mtrr.c
@@ -320,7 +320,7 @@ static void update_mtrr(struct kvm_vcpu *vcpu, u32 msr)
 	struct kvm_mtrr *mtrr_state = &vcpu->arch.mtrr_state;
 	gfn_t start, end;
 
-	if (!tdp_enabled || !kvm_arch_has_noncoherent_dma(vcpu->kvm))
+	if (!kvm_mmu_honors_guest_mtrrs(vcpu->kvm))
 		return;
 
 	if (!mtrr_is_enabled(mtrr_state) && msr != MSR_MTRRdefType)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 076d50f6321b..977dceb7ba7e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -942,7 +942,7 @@ void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned lon
 		kvm_mmu_reset_context(vcpu);
 
 	if (((cr0 ^ old_cr0) & X86_CR0_CD) &&
-	    kvm_arch_has_noncoherent_dma(vcpu->kvm) &&
+	    kvm_mmu_honors_guest_mtrrs(vcpu->kvm) &&
 	    !kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_CD_NW_CLEARED))
 		kvm_zap_gfn_range(vcpu->kvm, 0, ~0ULL);
 }

base-commit: 8d4a1b4011c125b1510254b724433aaae746ce14
-- 

