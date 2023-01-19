Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDC3673F68
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjASQ6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjASQ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:58:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD152685
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:58:25 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so4031282wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+GDzdecZ9ZHDc+Kqg/2GlkFErLVEdDgNL8hJqFOSpVo=;
        b=Om2kEGhGW2ZCtcCSpMJCYtO5UQeiNUUPVdu5gkEhK+PDChIW0NBjnWrJ+6hlpJfFVn
         sBvlqYKhckqsfgZqPoX86JrUySCGMawHad5N0nzcHqJXcdSTPGXMo1sDbsM7TeotF3Vw
         I/R4ocVXoOQ5LpiF794sUYXdcsWjZRJzEI05FWSt48/E3botvql4UaLy4F2YIMI0KGWH
         +s2mmVbdTNtSSUaIyrZFbkdm3/4a0VRM6X1A5XQY2foNkb3YP9juV6fvbmdv0DzwT1iC
         GkrOSDHJVBy2AzyoXa5ZbkAVKRirCtcOONlmYeFSAFvy4ifz224cZVy21Z+zWhZyCNV7
         jYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GDzdecZ9ZHDc+Kqg/2GlkFErLVEdDgNL8hJqFOSpVo=;
        b=ZixE2Qa2m9XHI6xp0hCrgUJvaUXpd7e2gKaICQmRYZEm/fB31EzRgdGV2UW7Przc2s
         diYCz5evbnZ4Zo5GlFtsDlyqsPp/Z7wJYk13XTAbeoMhP+EEt4WyMxHkNrF9N4RrRwp0
         b0EE1IsDn+ugbyUdf7Rk9HRFXmUvaxr5SKhO0f8mhoycXPswU3WIK1A5H2W5X4NCYhGy
         UaFpEwkG+HbvTadUaHJPf5lLkT63CCy6mHwDaCZlCWbK6qEco10UKURu+cAtjFNP8b7z
         QVBWTWj92I7GsC3D/VI8y99udGlJpQKZ/0QrhmfPySo5bt8EmPg3ef6jXsccMmUFKcwp
         hydg==
X-Gm-Message-State: AFqh2kqhw585UJdK2ken+T87mf8oLTOeOB4xP0WJfewYu+yrMzHQw2WM
        T1xnOH+WK3lftoiohK1SMiB9YLoBLOurjzN8CJwD+w==
X-Google-Smtp-Source: AMrXdXt2PR0mUmPWd7QKP8pKpMTLeMKIw2y6rof/vSw2CVc1vQi6RBlvaXRYUeKI7ZNuF1ZOklxI5SIx91rwTglQ2ag=
X-Received: by 2002:a05:600c:ad5:b0:3da:1b37:8ff5 with SMTP id
 c21-20020a05600c0ad500b003da1b378ff5mr658748wmr.166.1674147504173; Thu, 19
 Jan 2023 08:58:24 -0800 (PST)
MIME-Version: 1.0
References: <Y8AnROAtMngKntnq@x1n> <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
 <Y8BtJzBLTpw5IR+H@x1n> <CADrL8HUi-j4ais45Xq8Jpb6a7DsWiXrKNeJfsqBRMi1Lier8xA@mail.gmail.com>
 <Y8B8mW2zSWDDwp7G@x1n> <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com> <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com> <Y8hITxr/BBMuO6WX@monkey>
In-Reply-To: <Y8hITxr/BBMuO6WX@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 19 Jan 2023 08:57:47 -0800
Message-ID: <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
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

> > > > I wonder if the following crazy idea has already been discussed: treat the
> > > > whole mapping as a single large logical mapping. One reference and one
> > > > mapping, no matter how the individual parts are mapped into the assigned
> > > > page table sub-tree.
> > > >
> > > > Because for hugetlb with MAP_SHARED, we know that the complete assigned
> > > > sub-tree of page tables can only map the given hugetlb page, no fragments of
> > > > something else. That's very different to THP in private mappings ...
> > > >
> > > > So as soon as the first piece gets mapped, we increment refcount+mapcount.
> > > > Other pieces in the same subtree don't do that.
> > > >
> > > > Once the last piece is unmapped (or simpler: once the complete subtree of
> > > > page tables is gone), we decrement refcount+mapcount. Might require some
> > > > brain power to do this tracking, but I wouldn't call it impossible right
> > > > from the start.
> > > >
> > > > Would such a design violate other design aspects that are important?
> >
> > This is actually how mapcount was treated in HGM RFC v1 (though not
> > refcount); it is doable for both [2].
>
> My apologies for being late to the party :)
>
> When Peter first brought up the issue with ref/map_count overflows I was
> thinking that we should use a scheme like David describes above.  As
> James points out, this was the approach taken in the first RFC.
>
> > One caveat here: if a page is unmapped in small pieces, it is
> > difficult to know if the page is legitimately completely unmapped (we
> > would have to check all the PTEs in the page table).
>
> Are we allowing unmapping of small (non-huge page sized) areas with HGM?
> We must be if you are concerned with it.  What API would cause this?
> I just do not remember this discussion.

There was some discussion about allowing MADV_DONTNEED on
less-than-hugepage pieces [3] (it actually motivated the switch from
UFFD_FEATURE_MINOR_HUGETLBFS_HGM to MADV_SPLIT). It isn't implemented
in this series, but it could be implemented in the future.

In the more immediate future, we want hwpoison to unmap at 4K, so
MADV_HWPOISON would be a mechanism that userspace is granted to do
this.

>
> > would have to check all the PTEs in the page table). In RFC v1, I
> > sidestepped this caveat by saying that "page_mapcount() is incremented
> > if the hstate-level PTE is present". A single unmap on the whole
> > hugepage will clear the hstate-level PTE, thus decrementing the
> > mapcount.
> >
> > On a related note, there still exists an (albeit minor) API difference
> > vs. THPs: a piece of a page that is legitimately unmapped can still
> > have a positive page_mapcount().
> >
> > Given that this approach allows us to retain the hugetlb vmemmap
> > optimization (and it wouldn't require a horrible amount of
> > complexity), I prefer this approach over the THP-like approach.
>
> Me too.
>
> > >
> > > The question is how to maintaining above information.
> > >
> > > It needs to be per-map (so one page mapped multiple times can be accounted
> > > differently), and per-page (so one mapping/vma can contain multiple pages).
> > > So far I think that's exactly the pgtable.  If we can squeeze information
> > > into the pgtable it'll work out, but definitely not trivial.  Or we can
> > > maintain seperate allocates for such information, but that can be extra
> > > overheads too.
> >
> > I don't think we necessarily need to check the page table if we allow
> > for the limitations stated above.
> >
>
> When I was thinking about this I was a bit concerned about having enough
> information to know exactly when to inc or dec counts.  I was actually
> worried about knowing to do the increment.  I don't recall how it was
> done in the first RFC, but from a high level it would need to be done
> when the first hstate level PTE is allocated/added to the page table.
> Right?  My concern was with all the places where we could 'error out'
> after allocating the PTE, but before initializing it.  I was just thinking
> that we might need to scan the page table or keep metadata for better
> or easier accounting.

The only two places where we can *create* a high-granularity page
table are: __mcopy_atomic_hugetlb (UFFDIO_CONTINUE) and
copy_hugetlb_page_range. RFC v1 did not properly deal with the cases
where we error out. To correctly handle these cases, we basically have
to do the pagecache lookup before touching the page table.

1. For __mcopy_atomic_hugetlb, we can lookup the page before doing the
PT walk/alloc. If PT walk tells us to inc the page ref/mapcount, we do
so immediately. We can easily pass the page into
hugetlb_mcopy_atomic_pte() (via 'pagep') .

2. For copy_hugetlb_page_range() for VM_MAYSHARE, we can also do the
lookup before we do the page table walk. I'm not sure how to support
non-shared HGM mappings with this scheme (in this series, we also
don't support non-shared; we return -EINVAL).
NB: The only case where high-granularity mappings for !VM_MAYSHARE
VMAs would come up is as a result of hwpoison.

So we can avoid keeping additional metadata for what this series is
trying to accomplish, but if the above isn't acceptable, then I/we can
try to come up with a scheme that would be acceptable.

There is also the possibility that the scheme implemented in this
version of the series is acceptable (i.e., the page_mapcount() API
difference, which results in slightly modified page migration behavior
and smaps output, is ok... assuming we have the refcount overflow
check).

>
> I think Peter mentioned it elsewhere, we should come up with a workable
> scheme for HGM ref/map counting.  This can be done somewhat independently.

FWIW, what makes the most sense to me right now is to implement the
THP-like scheme and mark HGM as mutually exclusive with the vmemmap
optimization. We can later come up with a scheme that lets us retain
compatibility. (Is that what you mean by "this can be done somewhat
independently", Mike?)

[3]: https://lore.kernel.org/linux-mm/20221021163703.3218176-1-jthoughton@google.com/T/#m9a1090108b61d32c04b68a1f3f2577644823a999

- James
