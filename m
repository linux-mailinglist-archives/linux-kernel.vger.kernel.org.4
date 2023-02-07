Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1143768DDFE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjBGQbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBGQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:31:38 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA7DA4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:31:36 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id az37so8125680vkb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5+NWv+v0u+gyuH6pNNxAhrPXIw7rtt876QooeySaSHk=;
        b=jX/debV+lIPZ0PF/j3IleCqARlildVYdAfjlC2mGaqeiWXobB5V8e3jZyWYQnV7fD3
         3OOYKrNJ7YTB0OTiks4vc6eYb7suiYE0U/o0RuAEc/WuO08wrmh9ynl6+K7MgSiIW8N4
         /zoI1OuM2wVUE54n8scRMgW8UDH4sl282cKwO8rUD5O2Pzz0MugqieWpT1mRZ7z0+nTs
         cOe3kcw20eE2lH/RP5k6Cl4GU9tfKFoWF6yLRLvEsfql4Wp7AcG5QjWv/UiSLemihngE
         uJJp0xFwf37k/GqbB3mrUDozrnwZ0DqplHUoPS5gvrTWg79tjtJlsZqIBdvWeicD2uRO
         lXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+NWv+v0u+gyuH6pNNxAhrPXIw7rtt876QooeySaSHk=;
        b=ZeuRkMGaU/MgkZyB7SZM2A+rOEBUvS9LeqknYi0wGeo21sqg2POzWBc1b21icRVz+C
         M/XfWuykwX3Q9TJ7/5vNv+9C1sch726eojMbc5C4mF/5Iw96VURRLSWe0w9V3ZGiol2n
         TisnYIgWUaY3FLep+sFhS5mfQlVM/ZLFJZ/LChuFbVlwFiVIGF31wZl+reOTahNfeW+y
         bKokx7Y11J3b9C3xszBEWhNi0ojW2B4Tak/l9tyrU2agraqUSH4UtEJrLgZZWhvhyW6O
         sk3BGSz794cgqGncLO8jy5N6h4kYWUbwftki0fHZfMuArmEAdDB8VZyfEWRWN1meT50V
         yKVA==
X-Gm-Message-State: AO0yUKWsORm7GEDYAbGmoaVqq5GcJBPbmHbvhrnnaXLFrGvfnq6F0S0t
        QkT5erQ/AYTFP9e8aZzZqSlF5ZL7f2iL1DLdOHekuA==
X-Google-Smtp-Source: AK7set/iNpN4mjYDiW+tgdkpX/+Vgr9inD7DaVgn0BkHC45yap0X+dzLhEmq5Pn/EbzOO7nXRwG8WSh5Ky5x4AaU41A=
X-Received: by 2002:a1f:9f57:0:b0:3fc:475b:1a76 with SMTP id
 i84-20020a1f9f57000000b003fc475b1a76mr543128vke.24.1675787495128; Tue, 07 Feb
 2023 08:31:35 -0800 (PST)
MIME-Version: 1.0
References: <Y9Li93O6Ffwcr+vn@x1n> <CADrL8HVJb9mA3Lbz5UKJ8EudTk9sGDY-pdRqvW3TGawD_bJB0A@mail.gmail.com>
 <Y9f+jMLWy6ngpYuR@x1n> <CADrL8HX3sf6OO3PXS1g6b2dKf8b5phQ7oyNR0dVT=sAOdTmmqw@mail.gmail.com>
 <Y9gzOqwKcu7p/PEw@x1n> <CADrL8HXX9YDFUxmPPsm2s3Pno0XXgAyFB40fV1PdtP9eb-5D2A@mail.gmail.com>
 <Y9m/VVRABt0Blfjh@x1n> <CADrL8HXpfTE1+eE3rNGQyOr1QRtDtG5mBp-b3xcNX22QJRvPaQ@mail.gmail.com>
 <Y9qRta3bd4JqjUHx@x1n> <CADrL8HU809O0cPa9hXjf3k+ob139SQqvxOvpqm6UEv=zrPjHSg@mail.gmail.com>
 <Y9re82gctIZf08cX@x1n> <CADrL8HVja_xJ9qczsd-fQfEPvEEXswhXQwoan=a_LSMyORvqww@mail.gmail.com>
In-Reply-To: <CADrL8HVja_xJ9qczsd-fQfEPvEEXswhXQwoan=a_LSMyORvqww@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 7 Feb 2023 08:30:58 -0800
Message-ID: <CADrL8HUSx6=K0QXQtTmv9ZJQmvhe6KEb+FiAviRfO3HjmRUeTw@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
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

On Wed, Feb 1, 2023 at 4:24 PM James Houghton <jthoughton@google.com> wrote:
>
> On Wed, Feb 1, 2023 at 1:51 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Feb 01, 2023 at 01:32:21PM -0800, James Houghton wrote:
> > > On Wed, Feb 1, 2023 at 8:22 AM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Wed, Feb 01, 2023 at 07:45:17AM -0800, James Houghton wrote:
> > > > > On Tue, Jan 31, 2023 at 5:24 PM Peter Xu <peterx@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Jan 31, 2023 at 04:24:15PM -0800, James Houghton wrote:
> > > > > > > On Mon, Jan 30, 2023 at 1:14 PM Peter Xu <peterx@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Jan 30, 2023 at 10:38:41AM -0800, James Houghton wrote:
> > > > > > > > > On Mon, Jan 30, 2023 at 9:29 AM Peter Xu <peterx@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Jan 27, 2023 at 01:02:02PM -0800, James Houghton wrote:
> > > > > [snip]
> > > > > > > > > > Another way to not use thp mapcount, nor break smaps and similar calls to
> > > > > > > > > > page_mapcount() on small page, is to only increase the hpage mapcount only
> > > > > > > > > > when hstate pXd (in case of 1G it's PUD) entry being populated (no matter
> > > > > > > > > > as leaf or a non-leaf), and the mapcount can be decreased when the pXd
> > > > > > > > > > entry is removed (for leaf, it's the same as for now; for HGM, it's when
> > > > > > > > > > freeing pgtable of the PUD entry).
> > > > > > > > >
> > > > > > > > > Right, and this is doable. Also it seems like this is pretty close to
> > > > > > > > > the direction Matthew Wilcox wants to go with THPs.
> > > > > > > >
> > > > > > > > I may not be familiar with it, do you mean this one?
> > > > > > > >
> > > > > > > > https://lore.kernel.org/all/Y9Afwds%2FJl39UjEp@casper.infradead.org/
> > > > > > >
> > > > > > > Yep that's it.
> > > > > > >
> > > > > > > >
> > > > > > > > For hugetlb I think it should be easier to maintain rather than any-sized
> > > > > > > > folios, because there's the pgtable non-leaf entry to track rmap
> > > > > > > > information and the folio size being static to hpage size.
> > > > > > > >
> > > > > > > > It'll be different to folios where it can be random sized pages chunk, so
> > > > > > > > it needs to be managed by batching the ptes when install/zap.
> > > > > > >
> > > > > > > Agreed. It's probably easier for HugeTLB because they're always
> > > > > > > "naturally aligned" and yeah they can't change sizes.
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Something I noticed though, from the implementation of
> > > > > > > > > folio_referenced()/folio_referenced_one(), is that folio_mapcount()
> > > > > > > > > ought to report the total number of PTEs that are pointing on the page
> > > > > > > > > (or the number of times page_vma_mapped_walk returns true). FWIW,
> > > > > > > > > folio_referenced() is never called for hugetlb folios.
> > > > > > > >
> > > > > > > > FWIU folio_mapcount is the thing it needs for now to do the rmap walks -
> > > > > > > > it'll walk every leaf page being mapped, big or small, so IIUC that number
> > > > > > > > should match with what it expects to see later, more or less.
> > > > > > >
> > > > > > > I don't fully understand what you mean here.
> > > > > >
> > > > > > I meant the rmap_walk pairing with folio_referenced_one() will walk all the
> > > > > > leaves for the folio, big or small.  I think that will match the number
> > > > > > with what got returned from folio_mapcount().
> > > > >
> > > > > See below.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > But I agree the mapcount/referenced value itself is debatable to me, just
> > > > > > > > like what you raised in the other thread on page migration.  Meanwhile, I
> > > > > > > > am not certain whether the mapcount is accurate either because AFAICT the
> > > > > > > > mapcount can be modified if e.g. new page mapping established as long as
> > > > > > > > before taking the page lock later in folio_referenced().
> > > > > > > >
> > > > > > > > It's just that I don't see any severe issue either due to any of above, as
> > > > > > > > long as that information is only used as a hint for next steps, e.g., to
> > > > > > > > swap which page out.
> > > > > > >
> > > > > > > I also don't see a big problem with folio_referenced() (and you're
> > > > > > > right that folio_mapcount() can be stale by the time it takes the
> > > > > > > folio lock). It still seems like folio_mapcount() should return the
> > > > > > > total number of PTEs that map the page though. Are you saying that
> > > > > > > breaking this would be ok?
> > > > > >
> > > > > > I didn't quite follow - isn't that already doing so?
> > > > > >
> > > > > > folio_mapcount() is total_compound_mapcount() here, IIUC it is an
> > > > > > accumulated value of all possible PTEs or PMDs being mapped as long as it's
> > > > > > all or part of the folio being mapped.
> > > > >
> > > > > We've talked about 3 ways of handling mapcount:
> > > > >
> > > > > 1. The RFC v2 way, which is head-only, and we increment the compound
> > > > > mapcount for each PT mapping we have. So a PTE-mapped 2M page,
> > > > > compound_mapcount=512, subpage->_mapcount=0 (ignoring the -1 bias).
> > > > > 2. The THP-like way. If we are fully mapping the hugetlb page with the
> > > > > hstate-level PTE, we increment the compound mapcount, otherwise we
> > > > > increment subpage->_mapcount.
> > > > > 3. The RFC v1 way (the way you have suggested above), which is
> > > > > head-only, and we increment the compound mapcount if the hstate-level
> > > > > PTE is made present.
> > > >
> > > > Oh that's where it come from!  It took quite some months going through all
> > > > these, I can hardly remember the details.
> > > >
> > > > >
> > > > > With #1 and #2, there is no concern with folio_mapcount(). But with
> > > > > #3, folio_mapcount() for a PTE-mapped 2M page mapped in a single VMA
> > > > > would yield 1 instead of 512 (right?). That's what I mean.
> > > > >
> > > > > #1 has problems wrt smaps and migration (though there were other
> > > > > problems with those anyway that Mike has fixed), and #2 makes
> > > > > MADV_COLLAPSE slow to the point of being unusable for some
> > > > > applications.
> > > >
> > > > Ah so you're talking about after HGM being applied..  while I was only
> > > > talking about THPs.
> > > >
> > > > If to apply the logic here with idea 3), the worst case is we'll need to
> > > > have special care of HGM hugetlb in folio_referenced_one(), so the default
> > > > page_vma_mapped_walk() may not apply anymore - the resource is always in
> > > > hstate sized, so counting small ptes do not help too - we can just walk
> > > > until the hstate entry and do referenced++ if it's not none, at the
> > > > entrance of folio_referenced_one().
> > > >
> > > > But I'm not sure whether that'll be necessary at all, as I'm not sure
> > > > whether that path can be triggered at all in any form (where from the top
> > > > it should always be shrink_page_list()).  In that sense maybe we can also
> > > > consider adding a WARN_ON_ONCE() in folio_referenced() where it is a
> > > > hugetlb page that got passed in?  Meanwhile, adding a TODO comment
> > > > explaining that current walk won't work easily for HGM only, so when it
> > > > will be applicable to hugetlb we need to rework?
> > > >
> > > > I confess that's not pretty, though.  But that'll make 3) with no major
> > > > defect from function-wise.
> > >
> > > Another potential idea would be to add something like page_vmacount().
> > > For non-HugeTLB pages, page_vmacount() == page_mapcount(). Then for
> > > HugeTLB pages, we could keep a separate count (in one of the tail
> > > pages, I guess). And then in the places that matter (so smaps,
> > > migration, and maybe CoW and hwpoison), potentially change their calls
> > > to page_vmacount() instead of page_mapcount().
> > >
> > > Then to implement page_vmacount(), we do the RFC v1 mapcount approach
> > > (but like.... correctly this time). And then for page_mapcount(), we
> > > do the RFC v2 mapcount approach (head-only, once per PTE).
> > >
> > > Then we fix folio_referenced() without needing to special-case it for
> > > HugeTLB. :) Or we could just special-case it. *shrug*
> > >
> > > Does that sound reasonable? We still have the problem where a series
> > > of partially unmaps could leave page_vmacount() incremented, but I
> > > don't think that's a big problem.
> >
> > I'm afraid someone will stop you from introducing yet another definition of
> > mapcount, where others are trying to remove it. :)
> >
> > Or, can we just drop folio_referenced_arg.mapcount?  We need to keep:
> >
> >         if (!pra.mapcount)
> >                 return 0;
> >
> > By replacing it with folio_mapcount which is definitely something
> > worthwhile, but what about the rest?
> >
> > If it can be dropped, afaict it'll naturally work with HGM again.
> >
> > IIUC that's an optimization where we want to stop the rmap walk as long as
> > we found all the pages, however (1) IIUC it's not required to function, and
> > (2) it's not guaranteed to work as solid anyway.. As we've discussed
> > before: right after it reads mapcount (but before taking the page lock),
> > the mapcount can get decreased by 1, then it'll still need to loop over all
> > the vmas just to find that there's one "misterious" mapcount lost.
> >
> > Personally I really have no idea on how much that optimization can help.
>
> Ok, yeah, I think pra.mapcount can be removed too. (And we replace
> !pra.mapcount with !folio_mapcount().)
>
> I don't see any other existing users of folio_mapcount() and
> total_mapcount() that are problematic. We do need to make sure to keep
> refcount and mapcount in sync though; it can be done.
>
> So I'll compare this "RFC v1" way with the THP-like way and get you a
> performance comparison.

Here is the result: [1] (sorry it took a little while heh). The
implementation of the "RFC v1" way is pretty horrible[2] (and this
implementation probably has bugs anyway; it doesn't account for the
folio_referenced() problem).

Matthew is trying to solve the same problem with THPs right now: [3].
I haven't figured out how we can apply Matthews's approach to HGM
right now, but there probably is a way. (If we left the mapcount
increment bits in the same place, we couldn't just check the
hstate-level PTE; it would have already been made present.)

We could:
- use the THP-like way and tolerate ~1 second collapses
- use the (non-RFC) v1 way and tolerate the migration/smaps differences
- use the RFC v1 way and tolerate the complicated mapcount accounting
- flesh out [3] and see if it can be applied to HGM nicely

I'm happy to go with any of these approaches.

[1]: https://pastebin.com/raw/hJzFJHiD
[2]: https://github.com/48ca/linux/commit/4495f16a09b660aff44b3edcc125aa3a3df85976
[3]: https://lore.kernel.org/linux-mm/Y+FkV4fBxHlp6FTH@casper.infradead.org/

- James
