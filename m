Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1496F667CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjALRgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjALRgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:36:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6380E869CE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:57:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j34-20020a05600c1c2200b003da1b054057so1329457wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QCC7F6qUZs0eUKDNKlSeqfOsOhCWReUqSztDnstfON4=;
        b=UXcdjNXlaCt4LwQOR/qgcKICTSeBNgwIL+8GO3dHlt3MuoEZC43XwGsFwEf/v4JB+Z
         dNQaf23BlkoXzmUQLsK4kchNdtWUrhLpGY54UUbDeTrqShEDrVLE09j93d6XdmcVw1tT
         k1hmNSso38+RUYUIAd4qGLFk67sczM5tsK2dkDjRvWrSB3Q0lEr7ckkkz5UWfdmpEItx
         wMs0k1vg/LS5KhFkawebl1grSHdaj0CXnqRpE03Q+couNWYIz07L+CZnSM1qKtLJNmxG
         /gZvJ80qCFLumCCoi6RQ3tHsw4PhZBD24GWSzJ2t9jpFn623BnT3bC6N+AZ1So4kT1Q8
         Trcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCC7F6qUZs0eUKDNKlSeqfOsOhCWReUqSztDnstfON4=;
        b=gBlTsqwZpgo5zhmEeBC1pw7CZUC+l4JY40KZm9si4G2RrIhl78UsA85KZCY6AP0Tav
         Z5aX6OF49ezgUKG8JFCKOuFDE/SXUT0Ix+1tvEmZ3sq4i32QcDR8sJmMZ3iUM+lSEQ9J
         ZBsL6rKJqnWV0SgR/dzGty/tkodznvg6Eo43s1YG3MdBryLgPD9OZrXKXa/iBKXEoc+a
         VHz5oBY12pwooeP0uV3wrkIbR9/LbtLYYVUpOh1lKz9f820BT/Gnjg5v9+Apdcl+tPzh
         pTFuh0ToH15n/99e3SLq8crk6WRNFiqFYP4BANaoNCdtpKWYBCLj0XlKQVdDcWx3yju7
         zSfQ==
X-Gm-Message-State: AFqh2kqTKqH6S8V8siyKhYKiHQxWXrCxVbfKsYhht/aAtZ8tpFbzB8Sq
        vEUzMyP1o7hwztflluK+5ihz/YXWvymQG7Wtfg5qqKG0fDjqpGLT
X-Google-Smtp-Source: AMrXdXvJxsgdT1Mu+zOXVWaBzs9HjS3yFquSb47LhdrZigL+Ou0iL5eujvx2GH7nVlGlpWRn1omwLON2B3uVnAPnHmg=
X-Received: by 2002:a05:600c:1684:b0:3da:1b37:8ff5 with SMTP id
 k4-20020a05600c168400b003da1b378ff5mr113519wmn.166.1673541952186; Thu, 12 Jan
 2023 08:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-22-jthoughton@google.com> <Y78+/wleTEC3gyqu@x1n>
 <CADrL8HU-prbfx2xxXCi0RPznp5DB68-NjqqmdM+4aUeUUURhiA@mail.gmail.com> <Y8AnROAtMngKntnq@x1n>
In-Reply-To: <Y8AnROAtMngKntnq@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 12 Jan 2023 11:45:40 -0500
Message-ID: <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
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

On Thu, Jan 12, 2023 at 10:29 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 12, 2023 at 09:06:48AM -0500, James Houghton wrote:
> > On Wed, Jan 11, 2023 at 5:58 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > James,
> > >
> > > On Thu, Jan 05, 2023 at 10:18:19AM +0000, James Houghton wrote:
> > > > @@ -751,9 +761,9 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
> > > >               int mapcount = page_mapcount(page);
> > > >
> > > >               if (mapcount >= 2)
> > > > -                     mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
> > > > +                     mss->shared_hugetlb += hugetlb_pte_size(hpte);
> > > >               else
> > > > -                     mss->private_hugetlb += huge_page_size(hstate_vma(vma));
> > > > +                     mss->private_hugetlb += hugetlb_pte_size(hpte);
> > > >       }
> > > >       return 0;
> > >
> > > One thing interesting I found with hgm right now is mostly everything will
> > > be counted as "shared" here, I think it's because mapcount is accounted
> > > always to the huge page even if mapped in smaller sizes, so page_mapcount()
> > > to a small page should be huge too because the head page mapcount should be
> > > huge.  I'm curious the reasons behind the mapcount decision.
> > >
> > > For example, would that risk overflow with head_compound_mapcount?  One 1G
> > > page mapping all 4K takes 0.25M counts, while the limit should be 2G for
> > > atomic_t.  Looks like it's possible.
> >
> > The original mapcount approach was "if the hstate-level PTE is
> > present, increment the compound_mapcount by 1" (basically "if any of
> > the hugepage is mapped, increment the compound_mapcount by 1"), but
> > this was painful to implement,
>
> Any more info here on why it was painful?  What is the major blocker?

The original approach was implemented in RFC v1, but the
implementation was broken: the way refcount was handled was wrong; it
was incremented once for each new page table mapping. (How?
find_lock_page(), called once per hugetlb_no_page/UFFDIO_CONTINUE
would increment refcount and we wouldn't drop it, and in
__unmap_hugepage_range(), the mmu_gather bits would decrement the
refcount once per mapping.)

At the time, I figured the complexity of handling mapcount AND
refcount correctly in the original approach would be quite complex, so
I switched to the new one.

1. In places that already change the mapcount, check that we're
installing the hstate-level PTE, not a high-granularity PTE. Adjust
mapcount AND refcount appropriately.
2. In the HGM walking bits, to the caller if we made the hstate-level
PTE present. (hugetlb_[pmd,pte]_alloc is the source of truth.) Need to
keep track of this until we figure out which page we're allocating
PTEs for, then change mapcount/refcount appropriately.
3. In unmapping bits, change mmu_gather/tlb bits to drop refcount only
once per hugepage. (This is probably the hardest of these three things
to get right.)

>
> > so I changed it to what it is now (each new PT mapping increments the
> > compound_mapcount by 1). I think you're right, there is absolutely an
> > overflow risk. :( I'm not sure what the best solution is. I could just go
> > back to the old approach.
>
> No rush on that; let's discuss it thoroughly before doing anything.  We
> have more context than when it was discussed initially in the calls, so
> maybe a good time to revisit.
>
> >
> > Regarding when things are accounted in private_hugetlb vs.
> > shared_hugetlb, HGM shouldn't change that, because it only applies to
> > shared mappings (right now anyway). It seems like "private_hugetlb"
> > can include cases where the page is shared but has only one mapping,
> > in which case HGM will change it from "private" to "shared".
>
> The two fields are not defined against VM_SHARED, it seems.  At least not
> with current code base.
>
> Let me quote the code again just to be clear:
>
>                 int mapcount = page_mapcount(page);    <------------- [1]
>
>                 if (mapcount >= 2)
>                         mss->shared_hugetlb += hugetlb_pte_size(hpte);
>                 else
>                         mss->private_hugetlb += hugetlb_pte_size(hpte);
>
>                 smaps_hugetlb_hgm_account(mss, hpte);
>
> So that information (for some reason) is only relevant to how many mapcount
> is there.  If we have one 1G page and only two 4K mapped, with the existing
> logic we should see 8K private_hugetlb while in fact I think it should be
> 8K shared_hugetlb due to page_mapcount() taking account of both 4K mappings
> (as they all goes back to the head).
>
> I have no idea whether violating that will be a problem or not, I suppose
> at least it needs justification if it will be violated, or hopefully it can
> be kept as-is.

Agreed that this is a problem. I'm not sure what should be done here.
It seems like the current upstream implementation is incorrect (surely
MAP_SHARED with only one mapping should still be shared_hugetlb not
private_hugetlb); the check should really be `if (vma->vm_flags &
VM_MAYSHARE)` instead of `mapcount >= 2`. If that change can be taken,
we don't have a problem here.

>
> >
> > >
> > > Btw, are the small page* pointers still needed in the latest HGM design?
> > > Is there code taking care of disabling of hugetlb vmemmap optimization for
> > > HGM?  Or maybe it's not needed anymore for the current design?
> >
> > The hugetlb vmemmap optimization can still be used with HGM, so there
> > is no code to disable it. We don't need small page* pointers either,
> > except for when we're dealing with mapping subpages, like in
> > hugetlb_no_page. Everything else can handle the hugetlb page as a
> > folio.
> >
> > I hope we can keep compatibility with the vmemmap optimization while
> > solving the mapcount overflow risk.
>
> Yeh that'll be perfect if it works.  But afaiu even with your current
> design (ignoring all the issues on either smaps accounting or overflow
> risks), we already referenced the small pages, aren't we?  See:
>
> static inline int page_mapcount(struct page *page)
> {
>         int mapcount = atomic_read(&page->_mapcount) + 1;  <-------- here
>
>         if (likely(!PageCompound(page)))
>                 return mapcount;
>         page = compound_head(page);
>         return head_compound_mapcount(page) + mapcount;
> }
>
> Even if we assume small page->_mapcount should always be zero in this case,
> we may need to take special care of hugetlb pages in page_mapcount() to not
> reference it at all.  Or I think it's reading random values and some days
> it can be non-zero.

IIUC, it's ok to read from all the hugetlb subpage structs, you just
can't *write* to them (except the first few). The first page of page
structs is mapped RW; all the others are mapped RO to a single
physical page.

>
> The other approach is probably using the thp approach.  After Hugh's rework
> on the thp accounting I assumed it would be even cleaner (at least no
> DoubleMap complexity anymore.. even though I can't say I fully digested the
> whole history of that).  It's all about what's the major challenges of
> using the same approach there with thp.  You may have more knowledge on
> that aspect so I'd be willing to know.

I need to take a closer look at Hugh's approach to see if we can do it
the same way. (I wonder if the 1G THP series has some ideas too.)

A really simple solution could be just to prevent userspace from doing
MADV_SPLIT (or, if we are enabling HGM due to hwpoison, ignore the
poison) if it could result in a mapcount overflow. For 1G pages,
userspace would need 8192 mappings to overflow mapcount/refcount.
