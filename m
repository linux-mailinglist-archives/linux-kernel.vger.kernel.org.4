Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE0660E5AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiJZQp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiJZQpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:45:55 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB76CE36
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:45:53 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id h203so13959424iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fxTHlIfpvK2/XOz3/tL/wS4RrUbx2mvunQ/ZFXzMWeQ=;
        b=WT+esLeg58MgeuQ+1rmpS52RKHc5+4Args2zNgvxdjA0+krh/MK3yUijxvyu6gkQXE
         vWSlt76ZWSYNm/M2CYc075MKBRC/d0nRnGK3XsmuJKy+CQFPtJ7OFAk576MrZwKFLgKl
         IYri2G8+xpHd+RgZilll4KLD6r2u16OWjVzm5TE4Adyw3bQMFHQ2hBFPvW66z1r9WWSM
         SWX4Tig38kHiPWZuIIiNm6zhirvDtVQLQi3ElVsi0qK36h8T5EPR/BUuhvbD5bmAsWh1
         CJ90qsFb08pjPdxpHIKWAP0mF11M2uXMWv44EgU9uaWv26am7egYWSvs+JF/jDJNxugI
         Gjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxTHlIfpvK2/XOz3/tL/wS4RrUbx2mvunQ/ZFXzMWeQ=;
        b=I3Xuz0dDIDSGUv4J9KiKJrZeFjXuvTIj4UoPhXPKaa2wa1YUBIqAEsCJ6D0i9DvgN9
         XwW3tNuZ0JLtPmzz1cPg8PUsxOCdKVRsIDNa2u3VK8za4DlXzhL+0P1w+DbMW539FQTY
         HF+ONbVyAD1nMtLui6VcwesVBj70DspuA/3cinPRiZ6LIVCX4wPfK07KgDUqVSsPoGvY
         umPbpKQax50gld+S3j4ZnqCpIbuw0yOfX1SEtP2kHV7yts0G7BkNUMmyBGm9nSpYTeqw
         HW7H2mh+N+rl5J3Jar01Ao0PjI0CTs3IOL4/o65ipg+Y3q43vFWd1U+6vIoBHGFhfMel
         6IZw==
X-Gm-Message-State: ACrzQf1LH7gv+rYFSHBne9chv+a5DJtvqFKzBmqkIgKWr8xgEJHs5oUp
        jdZSPRNCcn0zSoAHuWTAc1gHyn+b879BjMR5DUgXgA==
X-Google-Smtp-Source: AMsMyM7gFelwmQ3nX67YX6RCo4WlbOCwBT9+vJfELkygPZtXcuQ7UzJe7QJqQ9/cl5mZZ+hZtMjqWTSFGSI3Y/Lx8tg=
X-Received: by 2002:a05:6602:1588:b0:6bc:d49a:61cc with SMTP id
 e8-20020a056602158800b006bcd49a61ccmr26832467iow.154.1666802752567; Wed, 26
 Oct 2022 09:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net> <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 26 Oct 2022 18:45:16 +0200
Message-ID: <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 5:06 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Oct 25, 2022 at 04:18:20PM +0200, Jann Horn wrote:
> > On Tue, Oct 25, 2022 at 4:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Mon, Oct 24, 2022 at 09:58:07PM +0200, Jann Horn wrote:
> > >
> > > > Unless I'm completely misunderstanding what's going on here, the whole
> > > > "remove_table" thing only happens when you "remove a table", meaning
> > > > you free an entire *pagetable*. Just zapping PTEs doesn't trigger that
> > > > logic.
> > >
> > > Aah; yes true. OTOH even it that were not so, I think it would still be
> > > broken because the current code relies on the TLB flush to have
> > > completed, whereas the RCU scheme is effectively async and can be
> > > considered pending until the callback runs.
> > >
> > > Hurmph... easiest fix is probably to dis-allow kvm_flush_tlb_multi()
> > > for i386-pae builds.
> > >
> > > Something like so... nobody in his right mind should care about i386-pae
> > > virt performance much.
> >
> > I think Xen and HyperV have similar codepaths.
> > hyperv_flush_tlb_multi() looks like it uses remote flush hypercalls,
> > xen_flush_tlb_multi() too.
>
> Sure (not updated).
>
> > On top of that, I think that theoretically, Linux doesn't even ensure
> > that you have a TLB flush in between tearing down one PTE and
> > installing another PTE (see
> > https://lore.kernel.org/all/CAG48ez1Oz4tT-N2Y=Zs6jumu=zOp7SQRZ=V2c+b5bT9P4retJA@mail.gmail.com/),
> > but I haven't tested that, and if it is true, I'm also not entirely
> > sure if it's correct (in the sense that it only creates incoherent-TLB
> > states when userspace is doing something stupid like racing
> > MADV_DONTNEED and page faults on the same region).
> >
> > I think the more clearly correct fix would be to get rid of the split
> > loads and use CMPXCHG16B instead (probably destroying the performance
> > of GUP-fast completely), but that's complicated because some of the
> > architectures that use the split loads path don't have cmpxchg_double
> > (or at least don't have it wired up).
>
> cmpxchg8b; but no, I think we want to fix MADV_DONTNEED, incoherent TLB
> states are a pain nobody needs.
>
> Something like so should force TLB flushes before dropping pte_lock (not
> looked at the various pmd level things yet).
[...]
>  #endif /* _LINUX_MM_H */
> diff --git a/mm/memory.c b/mm/memory.c
> index f88c351aecd4..9bb63b3fbee1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1440,6 +1440,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>                         tlb_remove_tlb_entry(tlb, pte, addr);
>                         zap_install_uffd_wp_if_needed(vma, addr, pte, details,
>                                                       ptent);
> +
> +                       if (!force_flush && !tlb->fullmm && details &&
> +                           details->zap_flags & ZAP_FLAG_FORCE_FLUSH)
> +                               force_flush = 1;
> +

Hmm... I guess that might work, assuming that there is no other
codepath we might race with that first turns the present PTE into a
non-present PTE but keeps the flush queued for later. At least
codepaths that use the tlb_batched infrastructure are unproblematic...
