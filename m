Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E96D718EF3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 01:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjEaXLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 19:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjEaXLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:11:32 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A6C123
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:11:29 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f804665702so92271cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685574688; x=1688166688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/MWN6rejTskcfCq1jo0OT/p1QBXsLATfA+P3wCJaoY=;
        b=Fl9wqKb8OYiVPVPir2ykRI7L87RcY3p24K4mWUjopqQTvt6/CSKSwE9qVHRGO6ZIyW
         IGgJ7ajDetdyJJ3J0awBrq/8PPsnnFT2U0Y+VQZlF3ypjJSsz6wb3/99o33RUgdV8q9D
         LxgAmYusm5FQ9UhHpudVCbDtgWoGgI+YBGozKHPGQpt2VgcJVtpWrvFEyOgNyTyxzZmg
         y4FzNbCCExTZsYgnHR8rb0eLgQOqCa2HOYwcjAeJPG8Rf8wPXO/lWazTGQJhdwBxCct5
         ro3o47PFqt8NJqRflzi2ECtQf6klWmKPHu/KYN9vgBMNLtr5ELk17kW3gYx2FDQJWqVF
         wK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685574688; x=1688166688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/MWN6rejTskcfCq1jo0OT/p1QBXsLATfA+P3wCJaoY=;
        b=aDXaixYfTY5xyWQRx+I92C2oQS3lJBP3zdcgwXtp9qpIiw5AbKENI8qF6Wvh9BhDVL
         9Fchy8owXI2E6mMnBzcQToIaWNdL1lQwUOAmdwf4kk/Q/mQR+h1dHTjaLFBjjlS483Fi
         OsJuBN0/TLeyh7Rol3sUzPyKZvpge9WjqwsG3JzILk707afF/1VKt2Q7D8wIoMRBSjA+
         PU2+Bzkk0QRJRmnNiPSkU9I4r55FgEoRVrlAgQdJ+aop+/NKa0PO6vSjpvserinOINFN
         EOy+RqR+2//CuV9r82CPFoHri1kMraEW+fsdSY5JQhnbM44CbTNp6TyDHr0U5uApNOVU
         gehQ==
X-Gm-Message-State: AC+VfDyTKGqUMaPen547xCakwgcpRmDycE+q8xv9SCrz00iykcQyfT0C
        lX6IwO1dfFEjzlcf9DqqnCUlL7K8yo9pzA8aJidv8A==
X-Google-Smtp-Source: ACHHUZ4fYvopsUDf0tKZluhlRdIiL+dMyvw/iJd7HM69nbbpN2GCk7JOyoWyB+QIJLSvn8t1n1/kKB5iqs8Czcu+kSs=
X-Received: by 2002:ac8:4e45:0:b0:3db:1c01:9d95 with SMTP id
 e5-20020ac84e45000000b003db1c019d95mr104964qtw.4.1685574688480; Wed, 31 May
 2023 16:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230526234435.662652-1-yuzhao@google.com> <20230526234435.662652-5-yuzhao@google.com>
 <ZHJHJPBF6euzOFdw@linux.dev> <CAOUHufa74CufHziHSquO5bZwbFXz2MNssBzW+AH7=Xo5RCnQ0A@mail.gmail.com>
 <ZHZQdQAApIrw6fBu@linux.dev> <CAOUHufZOkBmZJgCU2xW2B8S3P3TWERHezy0xKWY9_TeyV9K7Rg@mail.gmail.com>
 <ZHef0VsZvZ1Vnz0u@linux.dev>
In-Reply-To: <ZHef0VsZvZ1Vnz0u@linux.dev>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 31 May 2023 17:10:52 -0600
Message-ID: <CAOUHufZrfnfcbrqSzmHkejR5MA2gmGKZ3LMRhbLHV+1427z=Tw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2 04/10] kvm/arm64: make stage2 page tables
 RCU safe
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Anup Patel <anup@brainfault.org>,
        Ben Gardon <bgardon@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Gavin Shan <gshan@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Larabel <michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-trace-kernel@vger.kernel.org, x86@kernel.org,
        linux-mm@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 1:28=E2=80=AFPM Oliver Upton <oliver.upton@linux.de=
v> wrote:
>
> On Tue, May 30, 2023 at 02:06:55PM -0600, Yu Zhao wrote:
> > On Tue, May 30, 2023 at 1:37=E2=80=AFPM Oliver Upton <oliver.upton@linu=
x.dev> wrote:
> > >
> > > Hi Yu,
> > >
> > > On Sat, May 27, 2023 at 02:13:07PM -0600, Yu Zhao wrote:
> > > > On Sat, May 27, 2023 at 12:08=E2=80=AFPM Oliver Upton <oliver.upton=
@linux.dev> wrote:
> > > > > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pg=
table.c
> > > > > index 3d61bd3e591d..bfbebdcb4ef0 100644
> > > > > --- a/arch/arm64/kvm/hyp/pgtable.c
> > > > > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > > > > @@ -1019,7 +1019,7 @@ static int stage2_unmap_walker(const struct=
 kvm_pgtable_visit_ctx *ctx,
> > > > >                                                kvm_granule_size(c=
tx->level));
> > > > >
> > > > >         if (childp)
> > > > > -               mm_ops->put_page(childp);
> > > > > +               mm_ops->free_removed_table(childp, ctx->level);
> > > >
> > > > Thanks, Oliver.
> > > >
> > > > A couple of things I haven't had the chance to verify -- I'm hoping
> > > > you could help clarify:
> > > > 1. For unmapping, with free_removed_table(), wouldn't we have to lo=
ok
> > > > into the table we know it's empty unnecessarily?
> > >
> > > As it is currently implemented, yes. But, there's potential to fast-p=
ath
> > > the implementation by checking page_count() before starting the walk.
> >
> > Do you mind posting another patch? I'd be happy to ack it, as well as
> > the one you suggested above.
>
> I'd rather not take such a patch independent of the test_clear_young
> series if you're OK with that. Do you mind implementing something
> similar to the above patch w/ the proposed optimization if you need it?

No worries. I can take the above together with the following, which
would form a new series with its own merits, since apparently you
think the !AF case is important.

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 26a8d955b49c..6ce73ce9f146 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1453,10 +1453,10 @@ static void handle_access_fault(struct
kvm_vcpu *vcpu, phys_addr_t fault_ipa)

        trace_kvm_access_fault(fault_ipa);

-       read_lock(&vcpu->kvm->mmu_lock);
+       rcu_read_lock();
        mmu =3D vcpu->arch.hw_mmu;
        pte =3D kvm_pgtable_stage2_mkyoung(mmu->pgt, fault_ipa);
-       read_unlock(&vcpu->kvm->mmu_lock);
+       rcu_read_unlock();

        if (kvm_pte_valid(pte))
                kvm_set_pfn_accessed(kvm_pte_to_pfn(pte));
