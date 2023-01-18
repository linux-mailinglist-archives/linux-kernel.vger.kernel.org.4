Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D516723AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjARQlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjARQkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:40:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A73C442F9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:40:19 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b7so8545379wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qQYof1rzM9OPVtPkPMcQRp6WBUjiK5Yy8H4SwamJRY=;
        b=VG6Cz2LvAfulA0azTGLUlWzoVER6/Yx3W0ItuH2qKR21r2mxjmOjx0ZqVU76UhSKIn
         9bC3ZbVu/sINUTqn/t2c9L4TqRgvsm+OMbwsqfUZVD3NBpPE1+yGTHkWYfJdp3gbnu7m
         8bKL4e8DYc+fEnQR4QsGWu5wfIV5BemAEhF/Qo0Ynkf+a0tlbwCDjyGE367KmAJ4TRTx
         fmRf7UVOACoHJFQFTPCx2GshWR2k4m1BedSKC8yxkmUia/RoRezNe7eLlJ3bZIqI8SUn
         Tthf/6euefzgf1hJl5eUTBs2yQduyLBXBrWuhUnGgLMk7jzxSG7L9a0mozekzSp0G9g7
         1dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qQYof1rzM9OPVtPkPMcQRp6WBUjiK5Yy8H4SwamJRY=;
        b=zzaVAgNfVPcBiCxZIjZWWfbZ/W0QXgZWzBUZoAHPUq4nJIp0dLouw1b3WZ6Bsf+vpj
         YaMPJHaGA4+8adlUo+hZRJKiCEBdubNNeb8ivVvuDPE+OLNhwJ4z2AZZhos5QLRSygok
         EvA4CBlWvZJRuK/mQ+dAcNCs+2MZ6QAXs/B635sGnBmOhKHt9eRfW6PLGFO74Xn47olR
         HdwQhQH80z/VzoDnuNeVhpiqSGXXqHw90EtiYrNgTym7IWMiS9q9OGcqs7uhpebAkwcS
         WWrg00zgNBrcv03WY0EtVNy+DLwqzpHwdIyJa0hrajDEAesMlTRLa1tR9h4owwHoj68s
         7cXw==
X-Gm-Message-State: AFqh2krP+t4tJal25iJFKKGIyxXNeocu3jmxtaCIFnYKUPlT3IGQjfWW
        svzqIhcTjHiU1+tINpivpzh0t0kQXyAJcVOh4qwWJA==
X-Google-Smtp-Source: AMrXdXuy5GueqEe5taRrloMehhG3uj1QyAwpw6rLuSNaM90LXQega5pKvkvG0H0rbwct2nx/QUIsKIZhySPhS/GnA6Q=
X-Received: by 2002:a5d:6205:0:b0:2be:1447:c36d with SMTP id
 y5-20020a5d6205000000b002be1447c36dmr444142wru.39.1674060017262; Wed, 18 Jan
 2023 08:40:17 -0800 (PST)
MIME-Version: 1.0
References: <Y78+/wleTEC3gyqu@x1n> <CADrL8HU-prbfx2xxXCi0RPznp5DB68-NjqqmdM+4aUeUUURhiA@mail.gmail.com>
 <Y8AnROAtMngKntnq@x1n> <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
 <Y8BtJzBLTpw5IR+H@x1n> <CADrL8HUi-j4ais45Xq8Jpb6a7DsWiXrKNeJfsqBRMi1Lier8xA@mail.gmail.com>
 <Y8B8mW2zSWDDwp7G@x1n> <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com> <Y8gRpEonhXgqfb41@x1n>
In-Reply-To: <Y8gRpEonhXgqfb41@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 18 Jan 2023 08:39:40 -0800
Message-ID: <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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

> > > To deal with this, the best solution we've been able to come up with
> > > is to check if refcount is > INT_MAX/2 (similar to try_get_page()),
> > > and if it is, stop the operation (UFFDIO_CONTINUE or a page fault)
> > > from proceeding. In the UFFDIO_CONTINUE case, return ENOMEM. In the
> > > page fault cause, return VM_FAULT_SIGBUS (not VM_FAULT_OOM; we don't
> > > want to kill a random process).
> >
> > You'd have to also make sure that fork() won't do the same. At least with
> > uffd-wp, Peter also added page table copying during fork() for MAP_SHARED
> > mappings, which would have to be handled.

Indeed, thank you! copy_hugetlb_page_range() (and therefore fork() in
some cases) would need this check too.

>
> If we want such a check to make a real difference, IIUC we may want to
> consider having similar check in:
>
>         page_ref_add
>         page_ref_inc
>         page_ref_inc_return
>         page_ref_add_unless
>
> But it's unfortunate that mostly all the callers to these functions
> (especially the first two) do not have a retval yet at all.  Considering
> the low possibility so far on having it overflow, maybe it can also be done
> for later (and I think checking negative as try_get_page would suffice too).

I think as long as we annotate the few cases that userspace can
exploit to overflow refcount, we should be ok. I think this was the
same idea with try_get_page(): it is supposed to be used in places
that userspace could reasonably exploit to overflow refcount.

>
> >
> > Of course, one can just disallow fork() with any HGM right from the start
> > and keep it all simpler to not open up a can of worms there.
> >
> > Is it reasonable, to have more than one (or a handful) of VMAs mapping a
> > huge page via a HGM? Restricting it to a single one, would make handling
> > much easier.
> >
> > If there is ever demand for more HGM mappings, that whole problem (and
> > complexity) could be dealt with later. ... but I assume it will already be a
> > requirement for VMs (e.g., under QEMU) that share memory with other
> > processes (virtiofsd and friends?)
>
> Yes, any form of multi-proc QEMU will need that for supporting HGM
> postcopy.

+1. Disallowing fork() entirely is quite a restrictive limitation.

[snip]
> > > I'm curious what others think (Mike, Matthew?). I'm guessing the
> > > THP-like way is probably what most people would want, though it would
> > > be a real shame to lose the vmemmap optimization.
> >
> > Heh, not me :) Having a single mapcount is certainly much cleaner. ... and
> > if we're dealing with refcount overflows already, mapcount overflows are not
> > an issue.
> >
> >
> > I wonder if the following crazy idea has already been discussed: treat the
> > whole mapping as a single large logical mapping. One reference and one
> > mapping, no matter how the individual parts are mapped into the assigned
> > page table sub-tree.
> >
> > Because for hugetlb with MAP_SHARED, we know that the complete assigned
> > sub-tree of page tables can only map the given hugetlb page, no fragments of
> > something else. That's very different to THP in private mappings ...
> >
> > So as soon as the first piece gets mapped, we increment refcount+mapcount.
> > Other pieces in the same subtree don't do that.
> >
> > Once the last piece is unmapped (or simpler: once the complete subtree of
> > page tables is gone), we decrement refcount+mapcount. Might require some
> > brain power to do this tracking, but I wouldn't call it impossible right
> > from the start.
> >
> > Would such a design violate other design aspects that are important?

This is actually how mapcount was treated in HGM RFC v1 (though not
refcount); it is doable for both [2].

One caveat here: if a page is unmapped in small pieces, it is
difficult to know if the page is legitimately completely unmapped (we
would have to check all the PTEs in the page table). In RFC v1, I
sidestepped this caveat by saying that "page_mapcount() is incremented
if the hstate-level PTE is present". A single unmap on the whole
hugepage will clear the hstate-level PTE, thus decrementing the
mapcount.

On a related note, there still exists an (albeit minor) API difference
vs. THPs: a piece of a page that is legitimately unmapped can still
have a positive page_mapcount().

Given that this approach allows us to retain the hugetlb vmemmap
optimization (and it wouldn't require a horrible amount of
complexity), I prefer this approach over the THP-like approach.

>
> The question is how to maintaining above information.
>
> It needs to be per-map (so one page mapped multiple times can be accounted
> differently), and per-page (so one mapping/vma can contain multiple pages).
> So far I think that's exactly the pgtable.  If we can squeeze information
> into the pgtable it'll work out, but definitely not trivial.  Or we can
> maintain seperate allocates for such information, but that can be extra
> overheads too.

I don't think we necessarily need to check the page table if we allow
for the limitations stated above.

>
> So far I'd still consider going with reusing thp mapcounts, which will
> mostly be what James mentioned above. The only difference is I'm not sure
> whether we should allow mapping e.g. 2M ranges for 1G pages.  THP mapcount
> doesn't have intermediate layer to maintain mapcount information like 2M,
> so to me it's easier we start with only mapping either the hpage size or
> PAGE_SIZE, not any intermediate size allowed.
>
> Having intermediate size mapping allowed can at least be error prone to
> me.  One example is if some pgtable walker found a 2M page, it may easily
> fetch the PFN out of it, assuming it's a compound page and it should
> satisfy PageHead(pfn)==true but it'll start to break here, because the 2M
> PFN will only be a small page pfn for the 1G huge page in this case.

I assume you mean PageHuge(page). There are cases where assumptions
are made about hugetlb pages and VMAs; they need to be corrected. It
sounds like you're really talking about errors wrt missing a
compound_head()/page_folio(), but it can be even more general than
that. For example, the arm64 KVM MMU assumes that hugetlb HGM doesn't
exist, and so it needs to be fixed before HGM can be enabled for
arm64.

If a page is HGM-mapped, I think it's more error-prone to somehow make
PageHuge() come back with false. So the only solution I see here is
careful auditing and testing.

I don't really see how allow/disallowing intermediate sizes changes
this problem either.

>
> To me, intermediate sized mappings are good to have but not required to
> resolve HGM problems, at least so far.  Said that, I'm fine with looking at
> what it'll look like if James would like to keep persuing that direction.

I've mentioned this to Peter already, but I don't think discarding
intermediate mapping levels really reduces complexity all that much.

[2]: Using the names of functions as of v1 (Peter has since suggested
a name change): hugetlb_alloc_{pte,pmd} will tell us if we really
allocated the PTE. That info can be passed up through
hugetlb_walk_step()=>hugetlb_hgm_walk() (where we only care if the
*hstate-level* PTE got allocated) and hugetlb_full_walk*() for the
caller to determine if refcount/mapcount should be incremented.

Thank you both for your thoughts so far. :)

- James
