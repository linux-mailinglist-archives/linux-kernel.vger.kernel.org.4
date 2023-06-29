Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05457430A3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjF2Wfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjF2WfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:35:23 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1456E35A6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:35:21 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55b523cf593so486865a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688078120; x=1690670120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rev6ft8Hp2wppi5PtDWSxFZoJJ4sTiUUKcYwIuu9uo=;
        b=HIuzv10YMTyPzT/R73V+wslTtiZSW3nkvuS79xONZbzt12du/C0n0UJPBewfoqWDZb
         Ju9gu2G2fGQ+xBU7BvbiZct7t/zSypBGmbEq+2ZMBLoM34g8T59QY4bWqBBYoLmBqQUZ
         Kvc6kCKDM6AYryER0GhaRL+n9gvCb+A8/d592BZ6VOJYYNtlaH9NryY7QPP67GqgI4Hd
         UU70tqz0ZCkpZ3xObB3B2X4t8zF8X7SCiHOOKX8sO3O5rmmHSmTphzElNE/4lYO1Roka
         6tPImLWyH5O0xCic00l3JseiZl+EkPXccpeNHRB6NR78WqzXXTg0g+tWEEsQJ7lQS24W
         RHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688078120; x=1690670120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rev6ft8Hp2wppi5PtDWSxFZoJJ4sTiUUKcYwIuu9uo=;
        b=HlaPEMNjWoltbSPshAauyc7gca/wXB7JVQJxgNKhFi5qAh/pURFSezDucZHkm32mA0
         M0nIe6fya22gOQEbSLoZSnRl+lkcChzHzjPo/zODOmcloVUwVpkItwJTagNf5fd8WOam
         VsEZKtnXG3FyAAy2X7nw/cCzlSDYeZG5bMUA1mVPxBkBvUvzTE56q4IRXkImVf7JiewD
         AuzD7VbsHau+6zCIzAJDN0VqM9s+F8afrfpOnVGMxGsftn9U0pTRvoVF2qBiQ6yCg4h1
         HVxU5Q2RdhnKy3dcg/DMD45HJ1gJC2fQ+JYbLTEzb+5muaTXhVwYxgupaw/Yfxy9KXt3
         A1mw==
X-Gm-Message-State: ABy/qLYUrDFAegIi3+bPITbROBRJl1/El90aWS/eZsOQatNbTadqtyry
        dJUiQC+TtCUEzwfIq7lH0fULH78BAH8=
X-Google-Smtp-Source: APBJJlH4BfkarG0YXPpI3xvz2oPp7ujKNQMY+DXvKTu+7jgIQx2ApC/TCbb/kw+Fvec6KrF0MZSa6zybxFE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:f414:0:b0:530:866d:cd15 with SMTP id
 g20-20020a63f414000000b00530866dcd15mr98244pgi.12.1688078120524; Thu, 29 Jun
 2023 15:35:20 -0700 (PDT)
Date:   Thu, 29 Jun 2023 15:35:18 -0700
In-Reply-To: <36295675-2139-266d-4b07-9e029ac88fef@oracle.com>
Mime-Version: 1.0
References: <3d05fcf1-dad3-826e-03e9-599ced7524b4@oracle.com>
 <20230518035806.938517-1-dengqiao.joey@bytedance.com> <2f6210acca81090146bc1decf61996aae2a0bfcf.camel@redhat.com>
 <36295675-2139-266d-4b07-9e029ac88fef@oracle.com>
Message-ID: <ZJ4HJhQytonABUMl@google.com>
Subject: Re: [PATCH] KVM: SVM: Update destination when updating pi irte
From:   Sean Christopherson <seanjc@google.com>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        "dengqiao.joey" <dengqiao.joey@bytedance.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023, Joao Martins wrote:
> 
> On 18/05/2023 09:19, Maxim Levitsky wrote:
> > I think that we do need to a flag indicating if the vCPU is currently
> > running and if yes, then use svm->vcpu.cpu (or put -1 to it when it not
> > running or something) (currently the vcpu->cpu remains set when vCPU is
> > put)
> > 
> > In other words if a vCPU is running, then avic_pi_update_irte should put
> > correct pCPU number, and if it raced with vCPU put/load, then later should
> > win and put the correct value.  This can be done either with a lock or
> > barriers.
> > 
> If this could be done, it could remove cost from other places and avoid this
> little dance of the galog (and avoid its usage as it's not the greatest design
> aspect of the IOMMU). We anyways already need to do IRT flushes in all these
> things with regards to updating any piece of the IRTE, but we need some care
> there two to avoid invalidating too much (which is just as expensive and per-VCPU).

...

> But still quite expensive (as many IPIs as vCPUs updated), but it works as
> intended and guest will immediately see the right vcpu affinity. But I honestly
> prefer going towards your suggestion (via vcpu.pcpu) if we can have some
> insurance that vcpu.cpu is safe to use in pi_update_irte if protected against
> preemption/blocking of the VCPU.

I think we have all the necessary info, and even a handy dandy spinlock to ensure
ordering.  Disclaimers: compile tested only, I know almost nothing about the IOMMU
side of things, and I don't know if I understood the needs for the !IsRunning cases.

Disclaimers aside, this should point the IOMMU at the right pCPU when the target
vCPU changes and the new vCPU is actively running.

---
 arch/x86/kvm/svm/avic.c | 44 +++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index cfc8ab773025..703ad9af73eb 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -791,6 +791,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 	int ret = 0;
 	unsigned long flags;
 	struct amd_svm_iommu_ir *ir;
+	u64 entry;
 
 	/**
 	 * In some cases, the existing irte is updated and re-set,
@@ -824,6 +825,18 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 	ir->data = pi->ir_data;
 
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
+
+	/*
+	 * Update the target pCPU for IOMMU doorbells if the vCPU is running.
+	 * If the vCPU is NOT running, i.e. is blocking or scheduled out, KVM
+	 * will update the pCPU info when the vCPU awkened and/or scheduled in.
+	 * See also avic_vcpu_load().
+	 */
+	entry = READ_ONCE(*(svm->avic_physical_id_cache));
+	if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
+		amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
+				    true, pi->ir_data);
+
 	list_add(&ir->node, &svm->ir_list);
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 out:
@@ -986,10 +999,11 @@ static inline int
 avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu, bool r)
 {
 	int ret = 0;
-	unsigned long flags;
 	struct amd_svm_iommu_ir *ir;
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	lockdep_assert_held(&svm->ir_list_lock);
+
 	if (!kvm_arch_has_assigned_device(vcpu->kvm))
 		return 0;
 
@@ -997,19 +1011,15 @@ avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu, bool r)
 	 * Here, we go through the per-vcpu ir_list to update all existing
 	 * interrupt remapping table entry targeting this vcpu.
 	 */
-	spin_lock_irqsave(&svm->ir_list_lock, flags);
-
 	if (list_empty(&svm->ir_list))
-		goto out;
+		return 0;
 
 	list_for_each_entry(ir, &svm->ir_list, node) {
 		ret = amd_iommu_update_ga(cpu, r, ir->data);
 		if (ret)
-			break;
+			return ret;
 	}
-out:
-	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
-	return ret;
+	return 0;
 }
 
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
@@ -1017,6 +1027,7 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	u64 entry;
 	int h_physical_id = kvm_cpu_get_apicid(cpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
+	unsigned long flags;
 
 	lockdep_assert_preemption_disabled();
 
@@ -1033,6 +1044,15 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (kvm_vcpu_is_blocking(vcpu))
 		return;
 
+	/*
+	 * Grab the per-vCPU interrupt remapping lock even if the VM doesn't
+	 * _currently_ have assigned devices, as that can change.  Holding
+	 * ir_list_lock ensures that either svm_ir_list_add() will consume
+	 * up-to-date entry information, or that this task will wait until
+	 * svm_ir_list_add() completes to set the new target pCPU.
+	 */
+	spin_lock_irqsave(&svm->ir_list_lock, flags);
+
 	entry = READ_ONCE(*(svm->avic_physical_id_cache));
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
 
@@ -1042,12 +1062,15 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
 	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, true);
+
+	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
 
 void avic_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	u64 entry;
 	struct vcpu_svm *svm = to_svm(vcpu);
+	unsigned long flags;
 
 	lockdep_assert_preemption_disabled();
 
@@ -1057,10 +1080,15 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
 		return;
 
+	spin_lock_irqsave(&svm->ir_list_lock, flags);
+
 	avic_update_iommu_vcpu_affinity(vcpu, -1, 0);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
+
+	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
+
 }
 
 void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu)

base-commit: 88bb466c9dec4f70d682cf38c685324e7b1b3d60
-- 

