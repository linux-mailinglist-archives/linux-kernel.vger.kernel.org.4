Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF4E70551E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjEPRhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjEPRhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:37:40 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B776582
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:37:39 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3330afe3d2fso11275ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684258658; x=1686850658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwakRNEZg00nJzKAJVvqSW5mx9DF58xDsBOKOjXcGQA=;
        b=Va677GD+EgqKDGYVHPtg/yYiWqOEuzKaOOD+Z7D7UCbZVV2av4s+E2a4oNSJg/xBYw
         L3yQYVt/G/zalbys9BLJ173Xj/RXn0YN3wi8tqxt3Aobk0gAq84LhMORbG9j4LwICKuY
         eOvSR7kWDB6k4bKINBBM2wcWsDuokUEAhn16ut7YAS+8YkwaaDAz0L15WQN2LBN8AtuN
         N5KeRTi89KtkqZneu3/+tsRHr5uMxNmj28FbT42DieelfGu136Ul+pVSitavQdGybJjw
         39pV0OfJxSKVWHUe5D8I8faFvev94gn931xW5aUZOzMPTrd4+wQ8uIr6eEW7A98He5LH
         UyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684258658; x=1686850658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwakRNEZg00nJzKAJVvqSW5mx9DF58xDsBOKOjXcGQA=;
        b=AR+xK2xWFmDnbjzNvJbY7YypLFMjuewPApftIy3yshffW0c7OTqWLHEJkYw3RPe7cC
         NT7x2A9FqSqrn7oZh1fA5LYfwyVGi5IARWIul4fwIVv/cKjPT62MuNykkuBtWAhfLo22
         HOyTqYlvExcH6YPtIsOAer2givfp2I30N/rsjf50fjsa/Ggn8Gy/j434p1DZ+Uq8666U
         T33El4Zi0qBugT6vF8WOwv4jLUgKlNLoi46y6TPH8enTZ3Wq8Fec/RaQ1ji4ZYVRjl27
         KkcRDUwD6hpFoE6PmG6HoGVTMJ01+yAfsGAGlcW6zIhQ2SLicprtRdl1/n/9KJJvu2X0
         Nh1w==
X-Gm-Message-State: AC+VfDyUcSpU1hBR7sh9n9+DFDyqmfTMSlDnRiOwxfBYacyo1JEDKXhV
        20M8HF/18tS+QTonNXvcSMbpixPJVSnVk9BsCwtsgIOhLnpBQzvvAydK4g==
X-Google-Smtp-Source: ACHHUZ6wWlpTv3IpwTR512FEiD5s98A5U3Lt0r6lTl9BzMmumqhm2ei8LXBGXvZYcIrzuW22YQrsdzk3pHp0zdiWakE=
X-Received: by 2002:a17:903:187:b0:1a6:6a2d:18f0 with SMTP id
 z7-20020a170903018700b001a66a2d18f0mr213668plg.9.1684258352254; Tue, 16 May
 2023 10:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230414172922.812640-1-rananta@google.com> <20230414172922.812640-7-rananta@google.com>
 <ZF51f5tYPjK1aCpd@linux.dev>
In-Reply-To: <ZF51f5tYPjK1aCpd@linux.dev>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Tue, 16 May 2023 10:32:20 -0700
Message-ID: <CAJHc60wJob+VpRN-Z3VDTH1sVHSYUxPSCpyKCrC4rFBRuCcsQA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] KVM: arm64: Add 'skip_flush' arg to stage2_put_pte()
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ricardo Koller <ricarkol@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Oliver,

On Fri, May 12, 2023 at 10:21=E2=80=AFAM Oliver Upton <oliver.upton@linux.d=
ev> wrote:
>
> Hi Raghavendra,
>
> On Fri, Apr 14, 2023 at 05:29:21PM +0000, Raghavendra Rao Ananta wrote:
> > Add a 'skip_flush' argument in stage2_put_pte() to
> > control the TLB invalidations. This will be leveraged
> > by the upcoming patch to defer the individual PTE
> > invalidations until the entire walk is finished.
> >
> > No functional change intended.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  arch/arm64/kvm/hyp/pgtable.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.=
c
> > index b8f0dbd12f773..3f136e35feb5e 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -772,7 +772,7 @@ static void stage2_make_pte(const struct kvm_pgtabl=
e_visit_ctx *ctx, kvm_pte_t n
> >  }
> >
> >  static void stage2_put_pte(const struct kvm_pgtable_visit_ctx *ctx, st=
ruct kvm_s2_mmu *mmu,
> > -                        struct kvm_pgtable_mm_ops *mm_ops)
> > +                        struct kvm_pgtable_mm_ops *mm_ops, bool skip_f=
lush)
>
> Assuming you are going to pull the cpufeature checks into this helper,
> it might me helpful to narrow the scope of it. 'stage2_put_pte()' sounds
> very generic, but it is about to have a very precise meaning in relation
> to kvm_pgtable_stage2_unmap().
>
> So maybe stage2_unmap_put_pte()? While at it, you'd want to have a
> shared helper for the deferral check:
>
Yeah, stage2_unmap_put_pte() sounds better. I'll change that.

> static bool stage2_unmap_defer_tlb_flush(struct kvm_pgtable *pgt)
> {
>         /* your blurb for why FWB is required too */
>         return system_supports_tlb_range() && stage2_has_fwb(pgt);
> }
>
Good idea; I can introduce the helper, now that we'll get rid of
stage2_unmap_data.skip_pte_tlbis (patch 7/7) as per your comments.
Also, since we are now making stage2_put_pte() specific to unmap, I
can also get rid of the 'skip_flush' arg and call
stage2_unmap_defer_tlb_flush() directly, or do you have a preference
for the additional arg?

Thank you.
Raghavendra
> The 'flush' part is annoying, because the exact term is an invalidation,
> but we already have that pattern in all of our TLB invalidation helpers.
>
> >  {
> >       /*
> >        * Clear the existing PTE, and perform break-before-make with
> > @@ -780,7 +780,10 @@ static void stage2_put_pte(const struct kvm_pgtabl=
e_visit_ctx *ctx, struct kvm_s
> >        */
> >       if (kvm_pte_valid(ctx->old)) {
> >               kvm_clear_pte(ctx->ptep);
> > -             kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, ctx->addr, ct=
x->level);
> > +
> > +             if (!skip_flush)
> > +                     kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu,
> > +                                     ctx->addr, ctx->level);
> >       }
> >
> >       mm_ops->put_page(ctx->ptep);
> > @@ -1015,7 +1018,7 @@ static int stage2_unmap_walker(const struct kvm_p=
gtable_visit_ctx *ctx,
> >        * block entry and rely on the remaining portions being faulted
> >        * back lazily.
> >        */
> > -     stage2_put_pte(ctx, mmu, mm_ops);
> > +     stage2_put_pte(ctx, mmu, mm_ops, false);
> >
> >       if (need_flush && mm_ops->dcache_clean_inval_poc)
> >               mm_ops->dcache_clean_inval_poc(kvm_pte_follow(ctx->old, m=
m_ops),
> > --
> > 2.40.0.634.g4ca3ef3211-goog
> >
>
> --
> Thanks,
> Oliver
