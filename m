Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0693466857A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240618AbjALVdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbjALVcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:32:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BECC39F9C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:18:06 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q10so37888wrs.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DrXNE6O1vrxrD1CEKf6vkFpfWQ1oSG2GOBigexWoiL4=;
        b=h33CHPbe/9X2MWljpv2Xr/tW49zhCMr+TIDE2sGru8sKIqfCuoxSOU3d4xSLLyJUlF
         1j84GSEHr0Yv7N4B0jZautie473FXaZT372E5qBdXC4gnmPAX2n6K3IXT8EeCS5WxJhg
         701s45vyLN6Sw0XFz/8R1PZAe9gV4rmVfRWJITmMbbKJwtZhCPS7ne808+YmqpKoGZO7
         lwC4eSBTYlmMGggyKM/qGFk3ASnIbEa534Ax47V4aXfFP3ooL0sW3ufPPOmNd8Wlo5Yh
         tJEiNZxjEJgRFBbPAymoOjgIbhoqRhHmmJuioJkiw2N/0LirpF/dDCMz2je2mK4sdnuR
         EB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrXNE6O1vrxrD1CEKf6vkFpfWQ1oSG2GOBigexWoiL4=;
        b=V58hZ8UuKa/qzGkFaVgjIf8Dd0XlUwqEkjIZMeZxBdJOaGZLA8sZj62rI2aXJpLG0m
         sEL8XydSYTEQr3RM3DR+m7yuB+K/BxR9fGkv0v0b2umS0DJ2MZLkCjLjl1DPhdIMy/wU
         P5r3RlMcAq9FkZrXxnujYnlu8kBC5V3ILtuwlynmbOJoMx0c0WX7ZrjPE2IApzp/EvB3
         kBjmqusynioWFa1Mldvl7BU23tokd55xXzEyVT3qyYFpcVIRahCtoNc53+icKNFg9dIN
         qumB/Ngb2E9WUYbS81K13IM+9RM4sbDHn49+h4xdLk0Y+eQBMBoveqCYFMJtPrqQpa7/
         8wyg==
X-Gm-Message-State: AFqh2koZpna1S7tFI5K6/ULOJtHxSkhvDgYYaiNHhXVSmBQRLaD/IOc5
        8Bw3fTfStiTizOQ/s+pzJGBvN49vaMvOoqESTuSIxQ==
X-Google-Smtp-Source: AMrXdXsBKS+guL0zdz6na2rBHlwkFvCf5hdvZLhe7kB9PwC9O1LWTUVWk/io0QKc/0m5KmHZ6UZr+1fLU+mZcwdiwDw=
X-Received: by 2002:a5d:6b51:0:b0:2b7:74c3:560d with SMTP id
 x17-20020a5d6b51000000b002b774c3560dmr1510632wrw.39.1673558284406; Thu, 12
 Jan 2023 13:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-22-jthoughton@google.com> <Y78+/wleTEC3gyqu@x1n>
 <CADrL8HU-prbfx2xxXCi0RPznp5DB68-NjqqmdM+4aUeUUURhiA@mail.gmail.com>
 <Y8AnROAtMngKntnq@x1n> <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
 <Y8BtJzBLTpw5IR+H@x1n>
In-Reply-To: <Y8BtJzBLTpw5IR+H@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 12 Jan 2023 16:17:52 -0500
Message-ID: <CADrL8HUi-j4ais45Xq8Jpb6a7DsWiXrKNeJfsqBRMi1Lier8xA@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
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

On Thu, Jan 12, 2023 at 3:27 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 12, 2023 at 11:45:40AM -0500, James Houghton wrote:
> > On Thu, Jan 12, 2023 at 10:29 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Thu, Jan 12, 2023 at 09:06:48AM -0500, James Houghton wrote:
> > > > On Wed, Jan 11, 2023 at 5:58 PM Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > James,
> > > > >
> > > > > On Thu, Jan 05, 2023 at 10:18:19AM +0000, James Houghton wrote:
> > > > > > @@ -751,9 +761,9 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
> > > > > >               int mapcount = page_mapcount(page);
> > > > > >
> > > > > >               if (mapcount >= 2)
> > > > > > -                     mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
> > > > > > +                     mss->shared_hugetlb += hugetlb_pte_size(hpte);
> > > > > >               else
> > > > > > -                     mss->private_hugetlb += huge_page_size(hstate_vma(vma));
> > > > > > +                     mss->private_hugetlb += hugetlb_pte_size(hpte);
> > > > > >       }
> > > > > >       return 0;
> > > > >
> > > > > One thing interesting I found with hgm right now is mostly everything will
> > > > > be counted as "shared" here, I think it's because mapcount is accounted
> > > > > always to the huge page even if mapped in smaller sizes, so page_mapcount()
> > > > > to a small page should be huge too because the head page mapcount should be
> > > > > huge.  I'm curious the reasons behind the mapcount decision.
> > > > >
> > > > > For example, would that risk overflow with head_compound_mapcount?  One 1G
> > > > > page mapping all 4K takes 0.25M counts, while the limit should be 2G for
> > > > > atomic_t.  Looks like it's possible.
> > > >
> > > > The original mapcount approach was "if the hstate-level PTE is
> > > > present, increment the compound_mapcount by 1" (basically "if any of
> > > > the hugepage is mapped, increment the compound_mapcount by 1"), but
> > > > this was painful to implement,
> > >
> > > Any more info here on why it was painful?  What is the major blocker?
> >
> > The original approach was implemented in RFC v1, but the
> > implementation was broken: the way refcount was handled was wrong; it
> > was incremented once for each new page table mapping. (How?
> > find_lock_page(), called once per hugetlb_no_page/UFFDIO_CONTINUE
> > would increment refcount and we wouldn't drop it, and in
> > __unmap_hugepage_range(), the mmu_gather bits would decrement the
> > refcount once per mapping.)
>
> I'm not sure I fully get the point here, but perhaps it's mostly about how
> hugetlb page cache is managed (in hstate size not PAGE_SIZE)?
>
> static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
> {
>         /* HugeTLBfs indexes the page cache in units of hpage_size */
>         if (folio_test_hugetlb(folio))
>                 return &folio->page;
>         return folio_page(folio, index & (folio_nr_pages(folio) - 1));
> }
>
> I haven't thought through on that either.  Is it possible that we switche
> the pgcache layout to be in PAGE_SIZE granule too when HGM enabled (e.g. a
> simple scheme is we can fail MADV_SPLIT if hugetlb pgcache contains any
> page already).
>
> If keep using the same pgcache scheme (hpage_size stepped indexes),
> find_lock_page() will also easily content on the head page lock, so we may
> not be able to handle concurrent page faults on small mappings on the same
> page as efficient as thp.

We keep the pgcache scheme the same: hpage_size stepped indexes. The
refcount and mapcount are both stored in the head page. The problems
with the implementation in RFC v1 were (1) refcount became much much
larger than mapcount, and (2) refcount would have the same overflow
problem we're discussing.

You're right -- find_lock_page() in hugetlb_no_page() and
hugetlb_mcopy_atomic_pte() will contend on the head page lock, but I
think it's possible to improve things here (i.e., replace them with
find_get_page() somehow).

>
> >
> > At the time, I figured the complexity of handling mapcount AND
> > refcount correctly in the original approach would be quite complex, so
> > I switched to the new one.
> >
> > 1. In places that already change the mapcount, check that we're
> > installing the hstate-level PTE, not a high-granularity PTE. Adjust
> > mapcount AND refcount appropriately.
> > 2. In the HGM walking bits, to the caller if we made the hstate-level
> > PTE present. (hugetlb_[pmd,pte]_alloc is the source of truth.) Need to
> > keep track of this until we figure out which page we're allocating
> > PTEs for, then change mapcount/refcount appropriately.
> > 3. In unmapping bits, change mmu_gather/tlb bits to drop refcount only
> > once per hugepage. (This is probably the hardest of these three things
> > to get right.)
> >
> > >
> > > > so I changed it to what it is now (each new PT mapping increments the
> > > > compound_mapcount by 1). I think you're right, there is absolutely an
> > > > overflow risk. :( I'm not sure what the best solution is. I could just go
> > > > back to the old approach.
> > >
> > > No rush on that; let's discuss it thoroughly before doing anything.  We
> > > have more context than when it was discussed initially in the calls, so
> > > maybe a good time to revisit.
> > >
> > > >
> > > > Regarding when things are accounted in private_hugetlb vs.
> > > > shared_hugetlb, HGM shouldn't change that, because it only applies to
> > > > shared mappings (right now anyway). It seems like "private_hugetlb"
> > > > can include cases where the page is shared but has only one mapping,
> > > > in which case HGM will change it from "private" to "shared".
> > >
> > > The two fields are not defined against VM_SHARED, it seems.  At least not
> > > with current code base.
> > >
> > > Let me quote the code again just to be clear:
> > >
> > >                 int mapcount = page_mapcount(page);    <------------- [1]
> > >
> > >                 if (mapcount >= 2)
> > >                         mss->shared_hugetlb += hugetlb_pte_size(hpte);
> > >                 else
> > >                         mss->private_hugetlb += hugetlb_pte_size(hpte);
> > >
> > >                 smaps_hugetlb_hgm_account(mss, hpte);
> > >
> > > So that information (for some reason) is only relevant to how many mapcount
> > > is there.  If we have one 1G page and only two 4K mapped, with the existing
> > > logic we should see 8K private_hugetlb while in fact I think it should be
> > > 8K shared_hugetlb due to page_mapcount() taking account of both 4K mappings
> > > (as they all goes back to the head).
> > >
> > > I have no idea whether violating that will be a problem or not, I suppose
> > > at least it needs justification if it will be violated, or hopefully it can
> > > be kept as-is.
> >
> > Agreed that this is a problem. I'm not sure what should be done here.
> > It seems like the current upstream implementation is incorrect (surely
> > MAP_SHARED with only one mapping should still be shared_hugetlb not
> > private_hugetlb); the check should really be `if (vma->vm_flags &
> > VM_MAYSHARE)` instead of `mapcount >= 2`. If that change can be taken,
> > we don't have a problem here.
>
> Naoya added relevant code.  Not sure whether he'll chim in.
>
> commit 25ee01a2fca02dfb5a3ce316e77910c468108199
> Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Date:   Thu Nov 5 18:47:11 2015 -0800
>
>     mm: hugetlb: proc: add hugetlb-related fields to /proc/PID/smaps
>
> In all cases, it'll still be a slight ABI change, so worth considering the
> effects to existing users.
>
> >
> > >
> > > >
> > > > >
> > > > > Btw, are the small page* pointers still needed in the latest HGM design?
> > > > > Is there code taking care of disabling of hugetlb vmemmap optimization for
> > > > > HGM?  Or maybe it's not needed anymore for the current design?
> > > >
> > > > The hugetlb vmemmap optimization can still be used with HGM, so there
> > > > is no code to disable it. We don't need small page* pointers either,
> > > > except for when we're dealing with mapping subpages, like in
> > > > hugetlb_no_page. Everything else can handle the hugetlb page as a
> > > > folio.
> > > >
> > > > I hope we can keep compatibility with the vmemmap optimization while
> > > > solving the mapcount overflow risk.
> > >
> > > Yeh that'll be perfect if it works.  But afaiu even with your current
> > > design (ignoring all the issues on either smaps accounting or overflow
> > > risks), we already referenced the small pages, aren't we?  See:
> > >
> > > static inline int page_mapcount(struct page *page)
> > > {
> > >         int mapcount = atomic_read(&page->_mapcount) + 1;  <-------- here
> > >
> > >         if (likely(!PageCompound(page)))
> > >                 return mapcount;
> > >         page = compound_head(page);
> > >         return head_compound_mapcount(page) + mapcount;
> > > }
> > >
> > > Even if we assume small page->_mapcount should always be zero in this case,
> > > we may need to take special care of hugetlb pages in page_mapcount() to not
> > > reference it at all.  Or I think it's reading random values and some days
> > > it can be non-zero.
> >
> > IIUC, it's ok to read from all the hugetlb subpage structs, you just
> > can't *write* to them (except the first few). The first page of page
> > structs is mapped RW; all the others are mapped RO to a single
> > physical page.
>
> I'm not familiar with vmemmap work, but I saw this:
>
>         /*
>          * Remap the vmemmap virtual address range [@vmemmap_start, @vmemmap_end)
>          * to the page which @vmemmap_reuse is mapped to, then free the pages
>          * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
>          */
>         if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse))
>
> It seems it'll reuse the 1st page of the huge page* rather than backing the
> rest vmemmap with zero pages.  Would that be a problem (as I think some
> small page* can actually points to the e.g. head page* if referenced)?

It shouldn't be a problem if we don't use _mapcount and always use
compound_mapcount, which is how mapcount is handled in this version of
this series.

>
> >
> > >
> > > The other approach is probably using the thp approach.  After Hugh's rework
> > > on the thp accounting I assumed it would be even cleaner (at least no
> > > DoubleMap complexity anymore.. even though I can't say I fully digested the
> > > whole history of that).  It's all about what's the major challenges of
> > > using the same approach there with thp.  You may have more knowledge on
> > > that aspect so I'd be willing to know.
> >
> > I need to take a closer look at Hugh's approach to see if we can do it
> > the same way. (I wonder if the 1G THP series has some ideas too.)
>
> https://lore.kernel.org/all/47ad693-717-79c8-e1ba-46c3a6602e48@google.com/
>
> It's already in the mainline.  I think it's mostly internally implemented
> under the rmap code APIs.  For the HGM effort, I'd start with simply
> passing around compound=false when using the rmap APIs, and see what'll
> start to fail.

I'll look into it, but doing it this way will use _mapcount, so we
won't be able to use the vmemmap optimization. I think even if we do
use Hugh's approach, refcount is still being kept on the head page, so
there's still an overflow risk there (but maybe I am
misunderstanding).

>
> >
> > A really simple solution could be just to prevent userspace from doing
> > MADV_SPLIT (or, if we are enabling HGM due to hwpoison, ignore the
> > poison) if it could result in a mapcount overflow. For 1G pages,
> > userspace would need 8192 mappings to overflow mapcount/refcount.
>
> I'm not sure you can calculate it; consider fork()s along the way when pmd
> sharing disabled, or whatever reason when the 1G pages mapped at multiple
> places with more than one mmap()s.

Yeah you're right. :(
