Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC806B11D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCHTMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCHTMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:12:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601F172B0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 11:12:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l24-20020a25b318000000b007eba3f8e3baso18292693ybj.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 11:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678302720;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fw2hLbVqL5SgHu0yC2jKBnr76E23Fn3jrIrBYUu2agc=;
        b=d/8zt05dy3n7YdgyvlG/ZVVUTzcOMdR6coISyHK+JNpiS/QghTGvQoyP01I/rGR+BJ
         lJtM2/uOjEckgQj5foG9YaT1tAV+92pXB4s8ImQVMjPYWnPEM4XRAsy9HXKawnqX0EOs
         dn/gm7nSlK8hoY9Psy3NnWccliKHBc2zbJitYY3k+oybLNEI+g/1XWCE5rvgnxHBbpU4
         mYTwWsTz4ib93zqW0yxJwyFJJmuo/MILCqzqHZJVSXlJ88qK7BTf0XE2e/htSoXbbaT/
         7N54IM4L18cDjJ66Tg9GGrE1I1QXhsv90sWEWB19rJ6OH2hlN+tZUUAILs22Qe/nyK0y
         /jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678302720;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fw2hLbVqL5SgHu0yC2jKBnr76E23Fn3jrIrBYUu2agc=;
        b=Dv1OFx9HJPg/fetFSVvwHwhen1QuY0lFKgIEZGVl9Pt/fsIfyZh08d2rZbG5ZWc8/u
         jkHP9/jNDR2tEOzkjsmzl4qyTylWH2CTHXq63xqaNkcsXGvkLvQegiguiBLL3mj3NRhR
         felomk8/VBt/Mfv2Dv7a2zOHzsWE1ey+ujU44uehryxRrCP/8USf/zJmNja0L24GVF0t
         irFGwWsy0QXG+xwHRKOma/Jn8SPled+om0eea+3CYlsi5kGru3lrg8nHcdMVswf4XCtW
         otT385f46ZTfLsxsF+Nwib6+G70XHPhUw1sM1DeKutMl8QwnybNeDVwYwRXKr9c+hjZL
         VH0A==
X-Gm-Message-State: AO0yUKXhnNnjccuxhJl7dtBkIdmHXnOb2PuzcBbYHo92gZzNx6S1r98R
        kzAKWXuxjIjtpaIbHo2fcEWBsflkAaU=
X-Google-Smtp-Source: AK7set9TU9lXDs4kxvj5e+Thvl8AKWgxlgGcLBUP85taJjXQ9TonCcX0lJT9aDbYwFLweK2nOQllXUnyhl4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4520:0:b0:534:515:e472 with SMTP id
 s32-20020a814520000000b005340515e472mr12577476ywa.4.1678302720319; Wed, 08
 Mar 2023 11:12:00 -0800 (PST)
Date:   Wed, 8 Mar 2023 11:11:58 -0800
In-Reply-To: <fb088e26-8c9c-bcac-6083-5945d2d9c16e@linux.microsoft.com>
Mime-Version: 1.0
References: <20230227171751.1211786-1-jpiotrowski@linux.microsoft.com>
 <ZAd2MRNLw1JAXmOf@google.com> <CABgObfa1578yKuw3sqnCeLXpyyKmMPgNaftP9HCdgHNM9Tztjw@mail.gmail.com>
 <ZAfZPA5Ed7STUT2B@google.com> <fb088e26-8c9c-bcac-6083-5945d2d9c16e@linux.microsoft.com>
Message-ID: <ZAjd/ktCeT8D5anK@google.com>
Subject: Re: [PATCH] KVM: SVM: Disable TDP MMU when running on Hyper-V
From:   Sean Christopherson <seanjc@google.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tianyu Lan <ltykernel@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023, Jeremi Piotrowski wrote:
> On 08/03/2023 01:39, Sean Christopherson wrote:
> > On Wed, Mar 08, 2023, Paolo Bonzini wrote:
> >> On Tue, Mar 7, 2023 at 6:36=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> >>> Thinking about this more, I would rather revert commit 1e0c7d40758b (=
"KVM: SVM:
> >>> hyper-v: Remote TLB flush for SVM") or fix the thing properly straita=
way.  KVM
> >>> doesn't magically handle the flushes correctly for the shadow/legacy =
MMU, KVM just
> >>> happens to get lucky and not run afoul of the underlying bugs.
> >>
> >> I don't think it's about luck---the legacy MMU's zapping/invalidation
> >> seems to invoke the flush hypercall correctly:
> >=20
> > ...for the paths that Jeremi has exercised, and for which a stale TLB e=
ntry is
> > fatal to L2.  E.g. kvm_unmap_gfn_range() does not have a range-based TL=
B flush
> > in its path and fully relies on the buggy kvm_flush_remote_tlbs().
> >
>=20
> Why do you say "buggy kvm_flush_remote_tlbs"? kvm_flush_remote_tlbs calls=
 the
> hypercall that is needed, I don't see how this might be an issue of a mis=
sing
> "range-based TLB flush".

Doh, I forgot that the arch hook in kvm_flush_remote_tlbs() leads to the Hy=
per-V
hook.

svm_flush_tlb_current is very much broken, but in practice it doesn't matte=
r outside
of the direct call from kvm_mmu_load(), because in all other paths KVM will=
 flow
through a Hyper-V flush if KVM actually modifies its MMU in any ways.  E.g.=
 the
request from kvm_mmu_new_pgd() when force_flush_and_sync_on_reuse=3Dtrue is=
 neutered,
but that exists only as a safeguard against MMU bugs.  And for things like
kvm_invalidate_pcid() and kvm_post_set_cr4(), my understanding is that Hype=
r-V
will still flush the bare metal TLB, it's only Hyper-V's shadow page tables=
 that
are stale.

Depending on how Hyper-V handles ASIDs, pre_svm_run() may also be broken.  =
If
Hyper-V tracks and rebuilds only the current ASID, then bumping the ASID wo=
n't
rebuild potentially stale page tables.  But I'm guessing Hyper-V ignores th=
e ASID
since the hypercall takes only the root PA.

The truly problematic case is kvm_mmu_load(), where KVM relies on the flush=
 to
force Hyper-V to rebuild shadow page tables for an old, possibly stale nCR3=
.  This
affects only the TDP MMU because of an explicit optimization in the TDP MMU=
.  So
in practice we could squeak by with something like this:

	if (kvm_x86_ops.tlb_remote_flush =3D=3D hv_remote_flush_tlb)
		hyperv_flush_guest_mapping(vcpu->arch.mmu->root.hpa);
	else
		static_call(kvm_x86_flush_tlb_current)(vcpu);

but I'm not convinced that avoiding a hypercall in svm_flush_tlb_current() =
just
to avoid overhead when running an L3 (nested VM from L1 KVM's perspective) =
is
worthwhile.  The real problem there is that KVM nested SVM TLB/ASID support=
 is an
unoptimized mess, and I can't imagine someone running an L3 is going to be =
super
concerned with performance.

I also think we should have a sanity check in the flush_tlb_all() path, i.e=
. WARN
if kvm_flush_remote_tlbs() falls back.

Something like this (probably doesn't compile, likely needs #ifdefs or help=
ers):

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7ef4f9e3b35a..38afc5cac1c4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3770,7 +3770,7 @@ static void svm_enable_nmi_window(struct kvm_vcpu *vc=
pu)
        svm->vmcb->save.rflags |=3D (X86_EFLAGS_TF | X86_EFLAGS_RF);
 }
=20
-static void svm_flush_tlb_current(struct kvm_vcpu *vcpu)
+static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
 {
        struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -3794,6 +3794,23 @@ static void svm_flush_tlb_current(struct kvm_vcpu *v=
cpu)
                svm->current_vmcb->asid_generation--;
 }
=20
+static void svm_flush_tlb_current(struct kvm_vcpu *vcpu)
+{
+       if (kvm_x86_ops.tlb_remote_flush =3D=3D hv_remote_flush_tlb &&
+           VALID_PAGE(vcpu->arch.mmu->root.hpa))
+               hyperv_flush_guest_mapping(vcpu->arch.mmu->root.hpa);
+
+       svm_flush_tlb_asid(vcpu);
+}
+
+static void svm_flush_tlb_all(struct kvm_vcpu *vcpu)
+{
+       if (WARN_ON_ONCE(kvm_x86_ops.tlb_remote_flush =3D=3D hv_remote_flus=
h_tlb))
+               hv_remote_flush_tlb(vcpu->kvm);
+
+       svm_flush_tlb_asid(vcpu);
+}
+
 static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
 {
        struct vcpu_svm *svm =3D to_svm(vcpu);
@@ -4786,10 +4803,10 @@ static struct kvm_x86_ops svm_x86_ops __initdata =
=3D {
        .set_rflags =3D svm_set_rflags,
        .get_if_flag =3D svm_get_if_flag,
=20
-       .flush_tlb_all =3D svm_flush_tlb_current,
+       .flush_tlb_all =3D svm_flush_tlb_all,
        .flush_tlb_current =3D svm_flush_tlb_current,
        .flush_tlb_gva =3D svm_flush_tlb_gva,
-       .flush_tlb_guest =3D svm_flush_tlb_current,
+       .flush_tlb_guest =3D svm_flush_tlb_asid,
=20
        .vcpu_pre_run =3D svm_vcpu_pre_run,
        .vcpu_run =3D svm_vcpu_run,

