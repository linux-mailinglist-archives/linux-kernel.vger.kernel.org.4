Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B75674309
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjASTnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjASTnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:43:15 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4589A5BA4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:43:05 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k16so2381327wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eKem4CrvsN6UzjteZLRdzpKBaL5/XKV3SElZ27ChjVU=;
        b=J963c0a2Puoxu9j1z0lGFtHvCheHJcNXglvr1U3HBRbhI8+ZZC9lnAQ9rhFSV59S4K
         +SHoRI9ZBUxGgOneFBGLuvYGimULI5dWBK6lMS7Dv2EV70dwzIRwxxvEVAsE7Rd5Oh57
         znylKtCnUV5XBknUunRRm7HIXNJMdLSFt9msEjnMhRiXU1lN10/WbGecEUzhtHoRQ+9F
         M85I0dWKvowbBMeucSarHRsNEgJfA5O6jFJQcIS4bWdPXGnPQF2EgKiQHJTUMP//wpYq
         4fyw3nMp2p8uWcMW+n4+horZsooGz3VUbvuZIRGMmIUuO76u50GfVQrS6zyZ1Q9aYuVi
         el3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKem4CrvsN6UzjteZLRdzpKBaL5/XKV3SElZ27ChjVU=;
        b=hyfWSk0YMFd5ZREeFZr/y1M3rd6zsy9/63Zgv17e3x4bT3H1LVH1t4olQX5v/sz2+4
         z+Xl0u+eGmam1qzSHltQt4uX4+ukuOemNeJH4jclISzw/nZvs8I8+NTJ3qcz8uOOKYG8
         x3w0zkBJxpHi2csSyORROXjusODDx+mf/zBornJ7J4uqHANfSiI973Tx5HW7M7Z3wOS6
         j9HRYDvYzjyaQK0Xw6vyC1S/vDTjrtvJG/SN1uhgl+CVSrLYHy1FGBHCJeagJXclwHRp
         vzB5hn9qOa5nKz2b+pZUDg2fBKzY2qvUW9FnVFSdR+PZn3/0PYVgT9JEzppfFVMlJzlh
         8IeA==
X-Gm-Message-State: AFqh2kpP7lhVhYhVhV5IoN5q7Mfl9SvR0hFG6wO/oqbRhNhQAbyJPq7N
        3RWcKC69c7wEGRcL6rRzMkke0Zix2pjiEQb6SJ64WQ==
X-Google-Smtp-Source: AMrXdXvRLBcTg3N1mRggUj0aMqxC2ECHD8OQdGzX9zGmxFQ14LYwePLR9DxDSA9cJ9DEvpeq13GsV0os4HYRLRzABN0=
X-Received: by 2002:a05:600c:3583:b0:3da:221b:fc1f with SMTP id
 p3-20020a05600c358300b003da221bfc1fmr765056wmq.175.1674157383482; Thu, 19 Jan
 2023 11:43:03 -0800 (PST)
MIME-Version: 1.0
References: <Y8BtJzBLTpw5IR+H@x1n> <CADrL8HUi-j4ais45Xq8Jpb6a7DsWiXrKNeJfsqBRMi1Lier8xA@mail.gmail.com>
 <Y8B8mW2zSWDDwp7G@x1n> <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com> <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey> <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey>
In-Reply-To: <Y8l+f2wNp2gAjvYg@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 19 Jan 2023 11:42:26 -0800
Message-ID: <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
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

On Thu, Jan 19, 2023 at 9:32 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 01/19/23 08:57, James Houghton wrote:
> > > > > > I wonder if the following crazy idea has already been discussed: treat the
> > > > > > whole mapping as a single large logical mapping. One reference and one
> > > > > > mapping, no matter how the individual parts are mapped into the assigned
> > > > > > page table sub-tree.
> > > > > >
> > > > > > Because for hugetlb with MAP_SHARED, we know that the complete assigned
> > > > > > sub-tree of page tables can only map the given hugetlb page, no fragments of
> > > > > > something else. That's very different to THP in private mappings ...
> > > > > >
> > > > > > So as soon as the first piece gets mapped, we increment refcount+mapcount.
> > > > > > Other pieces in the same subtree don't do that.
> > > > > >
> > > > > > Once the last piece is unmapped (or simpler: once the complete subtree of
> > > > > > page tables is gone), we decrement refcount+mapcount. Might require some
> > > > > > brain power to do this tracking, but I wouldn't call it impossible right
> > > > > > from the start.
> > > > > >
> > > > > > Would such a design violate other design aspects that are important?
> > > >
> > > > This is actually how mapcount was treated in HGM RFC v1 (though not
> > > > refcount); it is doable for both [2].
> > >
> > > My apologies for being late to the party :)
> > >
> > > When Peter first brought up the issue with ref/map_count overflows I was
> > > thinking that we should use a scheme like David describes above.  As
> > > James points out, this was the approach taken in the first RFC.
> > >
> > > > One caveat here: if a page is unmapped in small pieces, it is
> > > > difficult to know if the page is legitimately completely unmapped (we
> > > > would have to check all the PTEs in the page table).
> > >
> > > Are we allowing unmapping of small (non-huge page sized) areas with HGM?
> > > We must be if you are concerned with it.  What API would cause this?
> > > I just do not remember this discussion.
> >
> > There was some discussion about allowing MADV_DONTNEED on
> > less-than-hugepage pieces [3] (it actually motivated the switch from
> > UFFD_FEATURE_MINOR_HUGETLBFS_HGM to MADV_SPLIT). It isn't implemented
> > in this series, but it could be implemented in the future.
>
> OK, so we do not actually create HGM mappings until a uffd operation is
> done at a less than huge page size granularity.  MADV_SPLIT just says
> that HGM mappings are 'possible' for this vma.  Hopefully, my understanding
> is correct.

Right, that's the current meaning of MADV_SPLIT for hugetlb.

> I was concerned about things like the page fault path, but in that case
> we have already 'entered HGM mode' via a uffd operation.
>
> Both David and Peter have asked whether eliminating intermediate mapping
> levels would be a simplification.  I trust your response that it would
> not help much in the current design/implementation.  But, it did get me
> thinking about something else.
>
> Perhaps we have discussed this before, and perhaps it does not meet all
> user needs, but one way possibly simplify this is:
>
> - 'Enable HGM' via MADV_SPLIT.  Must be done at huge page (hstate)
>   granularity.
> - MADV_SPLIT implicitly unmaps everything with in the range.
> - MADV_SPLIT says all mappings for this vma will now be done at a base
>   (4K) page size granularity.  vma would be marked some way.
> - I think this eliminates the need for hugetlb_pte's as we KNOW the
>   mapping size.
> - We still use huge pages to back 4K mappings, and we still have to deal
>   with the ref/map_count issues.
> - Code touching hugetlb page tables would KNOW the mapping size up front.
>
> Again, apologies if we talked about and previously dismissed this type
> of approach.

I think Peter was the one who originally suggested an approach like
this, and it meets my needs. However, I still think the way that
things are currently implemented is the right way to go.

Assuming we want decent performance, we can't get away with the same
strategy of just passing pte_t*s everywhere. The PTL for a 4K PTE
should be based on the PMD above the PTE, so we need to either pass
around the PMD above our PTE, or we need to pass around the PTL. This
is something that hugetlb_pte does for us, so, in some sense, even
going with this simpler approach, we still need a hugetlb_pte-like
construct.

Although most of the other complexity that HGM introduces would have
to be introduced either way (like having to deal with putting
compound_head()/page_folio() in more places and doing some
per-architecture updates), there are some complexities that the
simpler approach avoids:

- We avoid problems related to compound PTEs (the problem being: two
threads racing to populate a contiguous and non-contiguous PTE that
take up the same space could lead to user-detectable incorrect
behavior. This isn't hard to fix; it will be when I send the arm64
patches up.)

- We don't need to check if PTEs get split from under us in PT walks.
(In a lot of cases, the appropriate action is just to treat the PTE as
if it were pte_none().) In the same vein, we don't need
hugetlb_pte_present_leaf() at all, because PTEs we find will always be
leaves.

- We don't have to deal with sorting hstates or implementing
for_each_hgm_shift()/hugetlb_alloc_largest_pte().

None of these complexities are particularly major in my opinion.

This might seem kind of contrived, but let's say you have a VM with 1T
of memory, and you find 100 memory errors all in different 1G pages
over the life of this VM (years, potentially). Having 10% of your
memory be 4K-mapped is definitely worse than having 10% be 2M-mapped
(lost performance and increased memory overhead). There might be other
cases in the future where being able to have intermediate mapping
sizes could be helpful.

> > > When I was thinking about this I was a bit concerned about having enough
> > > information to know exactly when to inc or dec counts.  I was actually
> > > worried about knowing to do the increment.  I don't recall how it was
> > > done in the first RFC, but from a high level it would need to be done
> > > when the first hstate level PTE is allocated/added to the page table.
> > > Right?  My concern was with all the places where we could 'error out'
> > > after allocating the PTE, but before initializing it.  I was just thinking
> > > that we might need to scan the page table or keep metadata for better
> > > or easier accounting.
> >
> > The only two places where we can *create* a high-granularity page
> > table are: __mcopy_atomic_hugetlb (UFFDIO_CONTINUE) and
> > copy_hugetlb_page_range. RFC v1 did not properly deal with the cases
> > where we error out. To correctly handle these cases, we basically have
> > to do the pagecache lookup before touching the page table.
> >
> > 1. For __mcopy_atomic_hugetlb, we can lookup the page before doing the
> > PT walk/alloc. If PT walk tells us to inc the page ref/mapcount, we do
> > so immediately. We can easily pass the page into
> > hugetlb_mcopy_atomic_pte() (via 'pagep') .
> >
> > 2. For copy_hugetlb_page_range() for VM_MAYSHARE, we can also do the
> > lookup before we do the page table walk. I'm not sure how to support
> > non-shared HGM mappings with this scheme (in this series, we also
> > don't support non-shared; we return -EINVAL).
> > NB: The only case where high-granularity mappings for !VM_MAYSHARE
> > VMAs would come up is as a result of hwpoison.
> >
> > So we can avoid keeping additional metadata for what this series is
> > trying to accomplish, but if the above isn't acceptable, then I/we can
> > try to come up with a scheme that would be acceptable.
>
> Ok, I was thinking we had to deal with other code paths such as page
> fault.  But, now I understand that is not the case with this design.
>
> > There is also the possibility that the scheme implemented in this
> > version of the series is acceptable (i.e., the page_mapcount() API
> > difference, which results in slightly modified page migration behavior
> > and smaps output, is ok... assuming we have the refcount overflow
> > check).
> >
> > >
> > > I think Peter mentioned it elsewhere, we should come up with a workable
> > > scheme for HGM ref/map counting.  This can be done somewhat independently.
> >
> > FWIW, what makes the most sense to me right now is to implement the
> > THP-like scheme and mark HGM as mutually exclusive with the vmemmap
> > optimization. We can later come up with a scheme that lets us retain
> > compatibility. (Is that what you mean by "this can be done somewhat
> > independently", Mike?)
>
> Sort of, I was only saying that getting the ref/map counting right seems
> like a task than can be independently worked.  Using the THP-like scheme
> is good.

Ok! So if you're ok with the intermediate mapping sizes, it sounds
like I should go ahead and implement the THP-like scheme.

- James
