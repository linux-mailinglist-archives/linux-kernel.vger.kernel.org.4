Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4952B5B821B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiINHjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiINHjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:39:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DFE726B8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:39:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso13622397pjm.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Q7ELJz663VEYr0/xANKv+qJm02M48B11eT9T1F7usX0=;
        b=fvvYQxzLoxivcQjLGTNZkAkN3o4+FuwBHLpzu8Kb2nFqfWrw6wGMTmT8f2Id2zsDj6
         jvj0UTloe4B+JTjMBD8KcgsJcwPggJ0mqfUNgF/563G//TNOqgQB6ifTNbxJ2CPbh9PR
         zvsauin//cPccgZhpC0s69cOYD3yRHf8pz8xypTeKDgTx48BeGk4NR0iCQ4c8fbVRE+Z
         zls9t3jJv06naViSLaAchs0xI0oTuyIUnQtspHPbkgMBVgUGO91xUD5ahrijsnQsBQV6
         0qUUEozAzTGxgxz/k2akblBbE5Ue0y3fYszby8D0BKsVFu65WoqOtq9wndsCQ3TUDMU1
         d6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Q7ELJz663VEYr0/xANKv+qJm02M48B11eT9T1F7usX0=;
        b=XtIVkTP6sqbv8xGreGASzwarMoqAh5RvXw2i6BYTNr5oj307pGyw39ff0q3ojhcIrr
         C2syMtXHd2VlHvf61+G6RlCz9TyjFJGex8tHVFju8RnFt/+dqN70wQrY7oSVypmsOmSJ
         vGh65XDP+g0YcRyDWfaEIUFULkehz28FAYFJuV9PMI3FZg4kyaRj+2I0kea1uPm/yfyW
         MU+U6TZopv/YWqDq5D2XLRPFa7cjIIm8URoU9OrT83kcMDfb96XLPUQh4AJQqaNoO72v
         Ns2+XbdS34kFGee7XuwRtRHnXm9EkUFxB6CEhB0J09WdcpYK1h3Eg9RANoipfSV7J4Rt
         DlSA==
X-Gm-Message-State: ACrzQf0qSiQrzkpd97ewJ1L0fDEbRJTeovONH/jTuOK2CS9majwIuWjZ
        fpgo/DOGxhVDRT5khqPtKaIOXg==
X-Google-Smtp-Source: AMsMyM4glQ5dSQTu9a94VgKNuXQBJet96wvqFaUL6Gr0Ntc1MBqfsStXQJF+JHzQF8Qi3Svt/Oy5IQ==
X-Received: by 2002:a17:90b:3850:b0:200:b1fd:891f with SMTP id nl16-20020a17090b385000b00200b1fd891fmr3459627pjb.144.1663141150035;
        Wed, 14 Sep 2022 00:39:10 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f62-20020a623841000000b00541c68a0689sm8444252pfa.7.2022.09.14.00.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 00:39:09 -0700 (PDT)
Date:   Wed, 14 Sep 2022 07:39:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH v2 04/23] KVM: x86: Inhibit AVIC SPTEs if any vCPU
 enables x2APIC
Message-ID: <YyGFGXsbgr6WV0B8@google.com>
References: <20220903002254.2411750-1-seanjc@google.com>
 <20220903002254.2411750-5-seanjc@google.com>
 <b6fcb487-56fc-12ea-6f67-b14b0b156ee0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6fcb487-56fc-12ea-6f67-b14b0b156ee0@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022, Suthikulpanit, Suravee wrote:
> Sean,
> 
> This patch inhibits VM running in x2APIC mode on system w/ x2AVIC support.

The intent is that it only inhibits the MMIO page.

> On 9/2/2022 7:22 PM, Sean Christopherson wrote:
> > Reintroduce APICV_INHIBIT_REASON_X2APIC as a "partial" inhibit for AMD
> > to fix a bug where the APIC access page is visible to vCPUs that have
> > x2APIC enabled, i.e. shouldn't be able to "see" the xAPIC MMIO region.
> > 
> > On AMD, due to its "hybrid" mode where AVIC is enabled when x2APIC is
> > enabled even without x2AVIC support, the bug occurs any time AVIC is
> > enabled as x2APIC is fully emulated by KVM.  I.e. hardware isn't aware
> > that the guest is operating in x2APIC mode.
> > 
> > Opportunistically drop the "can" while updating avic_activate_vmcb()'s
> > comment, i.e. to state that KVM _does_ support the hybrid mode.  Move
> > the "Note:" down a line to conform to preferred kernel/KVM multi-line
> > comment style.
> > 
> > Leave Intel as-is for now to avoid a subtle performance regression, even
> > though Intel likely suffers from the same bug.  On Intel, in theory the
> > bug rears its head only when vCPUs share host page tables (extremely
> > likely) and x2APIC enabling is not consistent within the guest, i.e. if
> > some vCPUs have x2APIC enabled and other does do not (unlikely to occur
> > except in certain situations, e.g. bringing up APs).
> > 
> > Fixes: 0e311d33bfbe ("KVM: SVM: Introduce hybrid-AVIC mode")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/include/asm/kvm_host.h | 10 ++++++++++
> >   arch/x86/kvm/lapic.c            |  4 +++-
> >   arch/x86/kvm/mmu/mmu.c          |  2 +-
> >   arch/x86/kvm/svm/avic.c         | 15 +++++++-------
> >   arch/x86/kvm/x86.c              | 35 +++++++++++++++++++++++++++++----
> >   5 files changed, 53 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index 2c96c43c313a..1fd1b66ceeb6 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1132,6 +1132,15 @@ enum kvm_apicv_inhibit {
> >   	 * AVIC is disabled because SEV doesn't support it.
> >   	 */
> >   	APICV_INHIBIT_REASON_SEV,
> > +
> > +	/*
> > +	 * Due to sharing page tables across vCPUs, the xAPIC memslot must be
> > +	 * inhibited if any vCPU has x2APIC enabled.  Note, this is a "partial"
> > +	 * inhibit; APICv can still be activated, but KVM mustn't retain/create
> > +	 * SPTEs for the APIC access page.  Like the APIC ID and APIC base
> > +	 * inhibits, this is sticky for simplicity.
> > +	 */
> > +	APICV_INHIBIT_REASON_X2APIC,
> 
> Actually, shouldn't the APICV_INHIBIT_REASON_X2APIC is set only when vCPU
> has x2APIC enabled on the system with _NO x2AVIC support_ ? For example,
> .....
> 
> >   };
> >   struct kvm_arch {
> > @@ -1903,6 +1912,7 @@ gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
> >   gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
> >   				struct x86_exception *exception);
> > +bool kvm_apicv_memslot_activated(struct kvm *kvm);
> >   bool kvm_apicv_activated(struct kvm *kvm);
> >   bool kvm_vcpu_apicv_activated(struct kvm_vcpu *vcpu);
> >   void kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu);
> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > index 38e9b8e5278c..d956cd37908e 100644
> > --- a/arch/x86/kvm/lapic.c
> > +++ b/arch/x86/kvm/lapic.c
> > @@ -2394,8 +2394,10 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
> >   		}
> >   	}
> > -	if (((old_value ^ value) & X2APIC_ENABLE) && (value & X2APIC_ENABLE))
> > +	if (((old_value ^ value) & X2APIC_ENABLE) && (value & X2APIC_ENABLE)) {
> >   		kvm_apic_set_x2apic_id(apic, vcpu->vcpu_id);
> > +		kvm_set_apicv_inhibit(vcpu->kvm, APICV_INHIBIT_REASON_X2APIC);
> > +	}
> 
> .... Here, since we do not want to inhibit APICV/AVIC on system that can
> support x2AVIC, this should be set in the vendor-specific call-back
> function, where appropriate checks can be made.

No, again the intent is to inhibit only the MMIO page.  The x2APIC inhibit is
ignored when determining whether or not APICv is inhibited, but is included when
checking if the memslot is inhibited.

bool kvm_apicv_memslot_activated(struct kvm *kvm)
{
	return (READ_ONCE(kvm->arch.apicv_inhibit_reasons) == 0);
}

static unsigned long kvm_apicv_get_inhibit_reasons(struct kvm *kvm)
{
	/*
	 * x2APIC only needs to "inhibit" the MMIO region, all other aspects of
	 * APICv can continue to be utilized.
	 */
	return READ_ONCE(kvm->arch.apicv_inhibit_reasons) & ~APICV_INHIBIT_REASON_X2APIC;
}

> > @@ -10122,7 +10136,15 @@ void __kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
> >   	set_or_clear_apicv_inhibit(&new, reason, set);
> > -	if (!!old != !!new) {
> > +	/*
> > +	 * If the overall "is APICv activated" status is unchanged, simply add
> > +	 * or remove the inihbit from the pile.  x2APIC is an exception, as it
> > +	 * is a partial inhibit (only blocks SPTEs for the APIC access page).
> > +	 * If x2APIC is the only inhibit in either the old or the new set, then
> > +	 * vCPUs need to be kicked to transition between partially-inhibited
> > +	 * and fully-inhibited.
> > +	 */
> > +	if ((!!old != !!new) || old == X2APIC_ENABLE || new == X2APIC_ENABLE) {
> 
> Why are we comparing APICV inhibit reasons (old, new) with X2APIC_ENABLE
> here? Do you mean to compare with APICV_INHIBIT_REASON_X2APIC?

Yeaaaaah.
