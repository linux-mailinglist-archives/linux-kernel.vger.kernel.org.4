Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D81A686A97
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjBAPqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjBAPp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:45:56 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC012721CE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:45:54 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id h19so18328317vsv.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x1DIQSU4Gk4ZLndPn02P6tg2hSvz3O98xwCj2Dlwfgc=;
        b=gfvuC1v1FoTISQlcngpo0y20lj2HLQkIr87KrSnidHXD353cbtfDCPwGl84hbNpQh3
         MZy38qI0BsSY79wKp45GDWTw1s3aqoSck+neA0LpCl51yp5IP5DmIPxFypMHQWASAl4t
         EoZdcuWkRc3wW+MnD5RX7LZvoUp2bkP98QLs+DZZtx+mcPZDhJNULY4AEDQJKUjS58Yj
         ooWWGjttjNPc9fRUztb0VX6IN1F+isauGXaCVbVXlECB5/ysnyansfN7zYSfbiSl4uCp
         fK9q0AHhLtNASUFQshHUNw5aqbpnq9gLzpSxb9iM20P5lyIsuNDKXyg7Uf1LRL8aUvbz
         L/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1DIQSU4Gk4ZLndPn02P6tg2hSvz3O98xwCj2Dlwfgc=;
        b=LbE/H6k7Iujgzn/xa/eFDxDCE5hT+lvMmzwTSAcEPPMMXGrXW7PVYC+yQyGK+FZa79
         dJ+jf+RxzkZJkZPlCIwKNOB0eXwDdJ9D6tqfYZ0btAmCAN3GbtI02iln0BHvoizbtSEl
         crnW9wMaolVIFBnRU9OJR8dVFhJ90pRJTXPeIWS2cXCCJN3EY6xjmLdTLk+3KfwD0dVa
         ErDd/K00B6kKXvoiLzmvTtKsIUBRgqtosG6OdeO2dPyWRd3mwGxHAEfwcOl96svnY+tk
         rzs351oTlPwKMGuskK6ybQOVXJU1pon9P/9LDItOnl46MEnWOzOa00SYor9TowNQMWXP
         ofrQ==
X-Gm-Message-State: AO0yUKVVKb+QJVHYovll7WIa5fBvObO6NgGd4qIfTC/9781d7+wVPW+e
        OIk122+xZtZRlf0yNXk4TDr0MBfIB1wUPR3U6PDZGg==
X-Google-Smtp-Source: AK7set9kb1Q4bDbFuGfew3Mbn+KhPjXogNdkK0tGL6UXEEAWWdN7QLIwFBtzBwWxKlvVgR8J/L5E9P/p9u5oFPf3CKo=
X-Received: by 2002:a05:6102:34e8:b0:3f7:dda3:f85 with SMTP id
 bi8-20020a05610234e800b003f7dda30f85mr474053vsb.66.1675266353778; Wed, 01 Feb
 2023 07:45:53 -0800 (PST)
MIME-Version: 1.0
References: <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey> <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <CADrL8HV92DaNm5bUwcOxsG8Lg4yLT6F13KWSbjkySPNAsgCfpA@mail.gmail.com>
 <Y9Li93O6Ffwcr+vn@x1n> <CADrL8HVJb9mA3Lbz5UKJ8EudTk9sGDY-pdRqvW3TGawD_bJB0A@mail.gmail.com>
 <Y9f+jMLWy6ngpYuR@x1n> <CADrL8HX3sf6OO3PXS1g6b2dKf8b5phQ7oyNR0dVT=sAOdTmmqw@mail.gmail.com>
 <Y9gzOqwKcu7p/PEw@x1n> <CADrL8HXX9YDFUxmPPsm2s3Pno0XXgAyFB40fV1PdtP9eb-5D2A@mail.gmail.com>
 <Y9m/VVRABt0Blfjh@x1n>
In-Reply-To: <Y9m/VVRABt0Blfjh@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 1 Feb 2023 07:45:17 -0800
Message-ID: <CADrL8HXpfTE1+eE3rNGQyOr1QRtDtG5mBp-b3xcNX22QJRvPaQ@mail.gmail.com>
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

On Tue, Jan 31, 2023 at 5:24 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Jan 31, 2023 at 04:24:15PM -0800, James Houghton wrote:
> > On Mon, Jan 30, 2023 at 1:14 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Mon, Jan 30, 2023 at 10:38:41AM -0800, James Houghton wrote:
> > > > On Mon, Jan 30, 2023 at 9:29 AM Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > On Fri, Jan 27, 2023 at 01:02:02PM -0800, James Houghton wrote:
[snip]
> > > > > Another way to not use thp mapcount, nor break smaps and similar calls to
> > > > > page_mapcount() on small page, is to only increase the hpage mapcount only
> > > > > when hstate pXd (in case of 1G it's PUD) entry being populated (no matter
> > > > > as leaf or a non-leaf), and the mapcount can be decreased when the pXd
> > > > > entry is removed (for leaf, it's the same as for now; for HGM, it's when
> > > > > freeing pgtable of the PUD entry).
> > > >
> > > > Right, and this is doable. Also it seems like this is pretty close to
> > > > the direction Matthew Wilcox wants to go with THPs.
> > >
> > > I may not be familiar with it, do you mean this one?
> > >
> > > https://lore.kernel.org/all/Y9Afwds%2FJl39UjEp@casper.infradead.org/
> >
> > Yep that's it.
> >
> > >
> > > For hugetlb I think it should be easier to maintain rather than any-sized
> > > folios, because there's the pgtable non-leaf entry to track rmap
> > > information and the folio size being static to hpage size.
> > >
> > > It'll be different to folios where it can be random sized pages chunk, so
> > > it needs to be managed by batching the ptes when install/zap.
> >
> > Agreed. It's probably easier for HugeTLB because they're always
> > "naturally aligned" and yeah they can't change sizes.
> >
> > >
> > > >
> > > > Something I noticed though, from the implementation of
> > > > folio_referenced()/folio_referenced_one(), is that folio_mapcount()
> > > > ought to report the total number of PTEs that are pointing on the page
> > > > (or the number of times page_vma_mapped_walk returns true). FWIW,
> > > > folio_referenced() is never called for hugetlb folios.
> > >
> > > FWIU folio_mapcount is the thing it needs for now to do the rmap walks -
> > > it'll walk every leaf page being mapped, big or small, so IIUC that number
> > > should match with what it expects to see later, more or less.
> >
> > I don't fully understand what you mean here.
>
> I meant the rmap_walk pairing with folio_referenced_one() will walk all the
> leaves for the folio, big or small.  I think that will match the number
> with what got returned from folio_mapcount().

See below.

>
> >
> > >
> > > But I agree the mapcount/referenced value itself is debatable to me, just
> > > like what you raised in the other thread on page migration.  Meanwhile, I
> > > am not certain whether the mapcount is accurate either because AFAICT the
> > > mapcount can be modified if e.g. new page mapping established as long as
> > > before taking the page lock later in folio_referenced().
> > >
> > > It's just that I don't see any severe issue either due to any of above, as
> > > long as that information is only used as a hint for next steps, e.g., to
> > > swap which page out.
> >
> > I also don't see a big problem with folio_referenced() (and you're
> > right that folio_mapcount() can be stale by the time it takes the
> > folio lock). It still seems like folio_mapcount() should return the
> > total number of PTEs that map the page though. Are you saying that
> > breaking this would be ok?
>
> I didn't quite follow - isn't that already doing so?
>
> folio_mapcount() is total_compound_mapcount() here, IIUC it is an
> accumulated value of all possible PTEs or PMDs being mapped as long as it's
> all or part of the folio being mapped.

We've talked about 3 ways of handling mapcount:

1. The RFC v2 way, which is head-only, and we increment the compound
mapcount for each PT mapping we have. So a PTE-mapped 2M page,
compound_mapcount=512, subpage->_mapcount=0 (ignoring the -1 bias).
2. The THP-like way. If we are fully mapping the hugetlb page with the
hstate-level PTE, we increment the compound mapcount, otherwise we
increment subpage->_mapcount.
3. The RFC v1 way (the way you have suggested above), which is
head-only, and we increment the compound mapcount if the hstate-level
PTE is made present.

With #1 and #2, there is no concern with folio_mapcount(). But with
#3, folio_mapcount() for a PTE-mapped 2M page mapped in a single VMA
would yield 1 instead of 512 (right?). That's what I mean.

#1 has problems wrt smaps and migration (though there were other
problems with those anyway that Mike has fixed), and #2 makes
MADV_COLLAPSE slow to the point of being unusable for some
applications.

It seems like the least bad option is #1, but maybe we should have a
face-to-face discussion about it? I'm still collecting some more
performance numbers.

- James
