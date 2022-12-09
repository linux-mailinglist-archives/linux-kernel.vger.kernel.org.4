Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC36648613
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLIQCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLIQCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:02:50 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEE3D2F0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:02:48 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 125-20020a1c0283000000b003d1e906ca23so145076wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 08:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sY/ZXthp3y8PvRPuSl9vfnKu5ZCG+9SwRJym/onr+c0=;
        b=fXqyLOXtHK6Y0ah/C80XmF6ShkHJrhWarIhvgLf9vLDpqV/Ad+wA5gpb614TGqm/Cm
         I2znHm91rq0rlBxbL/QTU97h2zxLBqoIwuAdQ8Mtt7ASwZ0zh0Y8n3y3H69xQnhyFLLk
         obMDCH1XfYHWH1MUr7jGp/6JFJ2seAL4haBLfa6KS5/S3+ITEO255m0nNa+i/6If0lcV
         6fGo7K00skyJxCpVUQjDN2YWsp0vhM2KLkuLYpFWH2KBuHBB7QS+eQ0OD8c423dQdqVu
         o9Dx4Z9QqbUIWBKEBDHx8zd1lebdLnec7rrmYsC6NHoXL3DZW/IF4k7OvcuHcux5YZaK
         04bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sY/ZXthp3y8PvRPuSl9vfnKu5ZCG+9SwRJym/onr+c0=;
        b=vvwRCuE+3GQY+q0ndj9kWOTNgU6YnS1l3qy3tNFQ3YY0A4OdGdwnc+AEpW34EFWXZF
         lHYTHaEWG/ZEN7h5H2OB6X6ET667ZaxFRxWW1V3Zcchf/3mFaTtHcJrZsRK1LKIVMFi5
         a8e0utLs43qLwjNtk5+/FtNdywxVlaflKDKFO7C7LVwA9G69Rz7JE20PVpaFTAavJ7Rh
         dRsLjuJQU5UyGAtLJ18a32CWpR8vjSLEg7iBMU81pcSadIWNK2+5I6uEDd9DCwjQpbKB
         yi5e0NH2CJ45rl4mMPQKbVSPxCvDijUPQc3WOJmriTh2ZTylEWcCdsJCWGRHvxtNqkCZ
         r6zQ==
X-Gm-Message-State: ANoB5pl2JVQ0CWcsnpDqLIod6+z1n8QFI9/upP/Ahs+rRWnWK5mj9msu
        EovYUzBQ/0nnJUFWgv8t90iCI2x+BqoHrQWzdtsPFQ==
X-Google-Smtp-Source: AA0mqf42eME8yJDJtXoi3YcQR29PCLYEDe4uslSXpdw6XfesuuFHWzqCnil7W37M1Nh7UbsEeCQzVN89nHSS/YbsjN4=
X-Received: by 2002:a05:600c:5124:b0:3cf:878c:6555 with SMTP id
 o36-20020a05600c512400b003cf878c6555mr58261784wms.38.1670601767043; Fri, 09
 Dec 2022 08:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-11-jthoughton@google.com> <CAHS8izPYvrviLbtVNkg+bnSXt5zvaXfJJV9+CAZ_0qESyMimBw@mail.gmail.com>
In-Reply-To: <CAHS8izPYvrviLbtVNkg+bnSXt5zvaXfJJV9+CAZ_0qESyMimBw@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Fri, 9 Dec 2022 11:02:35 -0500
Message-ID: <CADrL8HXiNHw2MdgCWmi1JpK=dckJ=D-5-Wm5Ofv0L6Uh7nvqRg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/47] hugetlb: add hugetlb_pte to track HugeTLB
 page table entries
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Dec 7, 2022 at 7:46 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Fri, Oct 21, 2022 at 9:37 AM James Houghton <jthoughton@google.com> wrote:
> >
> > After high-granularity mapping, page table entries for HugeTLB pages can
> > be of any size/type. (For example, we can have a 1G page mapped with a
> > mix of PMDs and PTEs.) This struct is to help keep track of a HugeTLB
> > PTE after we have done a page table walk.
> >
> > Without this, we'd have to pass around the "size" of the PTE everywhere.
> > We effectively did this before; it could be fetched from the hstate,
> > which we pass around pretty much everywhere.
> >
> > hugetlb_pte_present_leaf is included here as a helper function that will
> > be used frequently later on.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  include/linux/hugetlb.h | 88 +++++++++++++++++++++++++++++++++++++++++
> >  mm/hugetlb.c            | 29 ++++++++++++++
> >  2 files changed, 117 insertions(+)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index db3ed6095b1c..d30322108b34 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -50,6 +50,75 @@ enum {
> >         __NR_USED_SUBPAGE,
> >  };
> >
> > +enum hugetlb_level {
> > +       HUGETLB_LEVEL_PTE = 1,
> > +       /*
> > +        * We always include PMD, PUD, and P4D in this enum definition so that,
> > +        * when logged as an integer, we can easily tell which level it is.
> > +        */
> > +       HUGETLB_LEVEL_PMD,
> > +       HUGETLB_LEVEL_PUD,
> > +       HUGETLB_LEVEL_P4D,
> > +       HUGETLB_LEVEL_PGD,
> > +};
> > +
>
> Don't we need to support CONTIG_PTE/PMD levels here for ARM64?

Yeah, which is why shift and level aren't quite the same thing.
Contiguous PMDs would be HUGETLB_LEVEL_PMD but have shift =
CONT_PMD_SHIFT, whereas regular PMDs would have shift = PMD_SHIFT.

>
> > +struct hugetlb_pte {
> > +       pte_t *ptep;
> > +       unsigned int shift;
> > +       enum hugetlb_level level;
>
> Is shift + level redundant? When would those diverge?

Peter asked a very similar question. `shift` can be used to determine
`level` if no levels are being folded. In the case of folded levels,
you might have a single shift that corresponds to multiple "levels".
That isn't necessarily a problem, as folding a level just means
casting your p?d_t* differently, but I think it's good to be able to
*know* if the hugetlb_pte was populated with a pud_t* that we treat it
like a pud_t* always.

If `ptep` was instead a union, then `level` would be the tag. Perhaps
it should be written that way.

>
> > +       spinlock_t *ptl;
> > +};
> > +
> > +static inline
> > +void hugetlb_pte_populate(struct hugetlb_pte *hpte, pte_t *ptep,
> > +                         unsigned int shift, enum hugetlb_level level)
> > +{
> > +       WARN_ON_ONCE(!ptep);
> > +       hpte->ptep = ptep;
> > +       hpte->shift = shift;
> > +       hpte->level = level;
> > +       hpte->ptl = NULL;
> > +}
> > +
> > +static inline
> > +unsigned long hugetlb_pte_size(const struct hugetlb_pte *hpte)
> > +{
> > +       WARN_ON_ONCE(!hpte->ptep);
> > +       return 1UL << hpte->shift;
> > +}
> > +
> > +static inline
> > +unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
> > +{
> > +       WARN_ON_ONCE(!hpte->ptep);
> > +       return ~(hugetlb_pte_size(hpte) - 1);
> > +}
> > +
> > +static inline
> > +unsigned int hugetlb_pte_shift(const struct hugetlb_pte *hpte)
> > +{
> > +       WARN_ON_ONCE(!hpte->ptep);
> > +       return hpte->shift;
> > +}
> > +
> > +static inline
> > +enum hugetlb_level hugetlb_pte_level(const struct hugetlb_pte *hpte)
> > +{
> > +       WARN_ON_ONCE(!hpte->ptep);
> > +       return hpte->level;
> > +}
> > +
> > +static inline
> > +void hugetlb_pte_copy(struct hugetlb_pte *dest, const struct hugetlb_pte *src)
> > +{
> > +       dest->ptep = src->ptep;
> > +       dest->shift = src->shift;
> > +       dest->level = src->level;
> > +       dest->ptl = src->ptl;
> > +}
> > +
> > +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte);
> > +
> >  struct hugepage_subpool {
> >         spinlock_t lock;
> >         long count;
> > @@ -1210,6 +1279,25 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
> >         return ptl;
> >  }
> >
> > +static inline
> > +spinlock_t *hugetlb_pte_lockptr(struct mm_struct *mm, struct hugetlb_pte *hpte)
> > +{
> > +
> > +       BUG_ON(!hpte->ptep);
>
> I think BUG_ON()s will be frowned upon. This function also doesn't
> really need ptep. Maybe let hugetlb_pte_shift() decide to BUG_ON() if
> necessary.

Right. I'll remove this (and others that aren't really necessary).
Peter's suggestion to just let the kernel take a #pf and crash
(thereby logging more info) SGTM.

>
>
> > +       if (hpte->ptl)
> > +               return hpte->ptl;
> > +       return huge_pte_lockptr(hugetlb_pte_shift(hpte), mm, hpte->ptep);
>
> I don't know if this fallback to huge_pte_lockptr() should be obivous
> to the reader. If not, a comment would help.

I'll clean this up a little for the next version. If something like
this branch stays, I'll add a comment.

>
> > +}
> > +
> > +static inline
> > +spinlock_t *hugetlb_pte_lock(struct mm_struct *mm, struct hugetlb_pte *hpte)
> > +{
> > +       spinlock_t *ptl = hugetlb_pte_lockptr(mm, hpte);
> > +
> > +       spin_lock(ptl);
> > +       return ptl;
> > +}
> > +
> >  #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
> >  extern void __init hugetlb_cma_reserve(int order);
> >  #else
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index ef7662bd0068..a0e46d35dabc 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1127,6 +1127,35 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
> >         return false;
> >  }
> >
> > +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte)
>
> I also don't know if this is obvious to other readers, but I'm quite
> confused that we pass both hugetlb_pte and pte_t here, especially when
> hpte has a pte_t inside of it. Maybe a comment would help.

It's possible for the value of the pte to change if we haven't locked
the PTL; we only store a pte_t* in hugetlb_pte, not the value itself.

Thinking about this... we *do* store `shift` which technically depends
on the value of the PTE. If the PTE is pte_none, the true `shift` of
the PTE is ambiguous, and so we just provide what the user asked for.
That could lead to a scenario where UFFDIO_CONTINUE(some 4K page) then
UFFDIO_CONTINUE(CONT_PTE_SIZE range around that page) can both succeed
because we merely check if the *first* PTE in the contiguous bunch is
none/has changed.

So, in the case of a contiguous PTE where we *think* we're overwriting
a bunch of none PTEs, we need to check that each PTE we're overwriting
is still none while holding the PTL. That means that the PTL we use
for cont PTEs and non-cont PTEs of the same level must be the same.

So for the next version, I'll:
- add some requirement that contiguous and non-contiguous PTEs on the
same level must use the same PTL
- think up some kind of API like all_contig_ptes_none(), but it only
really applies for arm64, so I think actually putting it in can wait.
I'll at least put a comment in hugetlb_mcopy_atomic_pte and
hugetlb_no_page (near the final huge_pte_none() and pte_same()
checks).


>
> > +{
> > +       pgd_t pgd;
> > +       p4d_t p4d;
> > +       pud_t pud;
> > +       pmd_t pmd;
> > +
> > +       WARN_ON_ONCE(!hpte->ptep);
> > +       switch (hugetlb_pte_level(hpte)) {
> > +       case HUGETLB_LEVEL_PGD:
> > +               pgd = __pgd(pte_val(pte));
> > +               return pgd_present(pgd) && pgd_leaf(pgd);
> > +       case HUGETLB_LEVEL_P4D:
> > +               p4d = __p4d(pte_val(pte));
> > +               return p4d_present(p4d) && p4d_leaf(p4d);
> > +       case HUGETLB_LEVEL_PUD:
> > +               pud = __pud(pte_val(pte));
> > +               return pud_present(pud) && pud_leaf(pud);
> > +       case HUGETLB_LEVEL_PMD:
> > +               pmd = __pmd(pte_val(pte));
> > +               return pmd_present(pmd) && pmd_leaf(pmd);
> > +       case HUGETLB_LEVEL_PTE:
> > +               return pte_present(pte);
> > +       default:
> > +               WARN_ON_ONCE(1);
> > +               return false;
> > +       }
> > +}
> > +
> >  static void enqueue_huge_page(struct hstate *h, struct page *page)
> >  {
> >         int nid = page_to_nid(page);
> > --
> > 2.38.0.135.g90850a2211-goog
> >
