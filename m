Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4DE690E8F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBIQo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBIQoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:44:25 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE62A5D1FF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:44:23 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k6so2766031vsk.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 08:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1675961063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6ufnwo9LJbhlFuZB107t4X1vUwtzNYzWsNbKQX/S5I=;
        b=crjYNly8goKM1PL6jvQqoL242bnk0fPHB2s/OWy8VaNbVIojCiZjCJ72qunaS77hrF
         62PaK05FPoMs0Z/zyQDTxf8K9eHUyi0WJJKLCEfPJKNQ9455S+YcrMnY5ardc//tn3Kd
         cDOWU50PkMx2juUsPrGriXu3DhubDoeoGJINzUnkQLJQdZPK+UlPklS2CxebX3KPhx3c
         jbz6UaTtwWFjE+fgjiRQy5AyjsISUbvwbi6+icMqHTDZj2NQWY9yQeidrgHajXko3msd
         69tkkc3IubSQxvRQT/uxkedYX5sJxoqsk8ToGROusER2IijIQhgd8FYDGKQWEK+m/NLc
         rTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1675961063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6ufnwo9LJbhlFuZB107t4X1vUwtzNYzWsNbKQX/S5I=;
        b=pGW6HVrshYujaY/MPS5hZT8T+Ek/RN+YtTMuMEQrpydE22Lj/3AZn+s+kWPt6h+vkC
         WmcZXmcU8C9XGqDb7ae3UUSY4QngTDXZCrlksTm14ykP1EUYCQLLNMwEnm30L5t1PzQA
         8JrNZaVTe44FiP1TBVBrL+M13CFMFvV0BcO3O81zpU8WIQ7uMeAoP7/zaBzTjNfyrkDy
         9hlT598uq6hSROWnvU/CxJ+fg8TEi5xUWKGZhfQW+DjmYqMdRMe8pOqqdD/jsMr3s3el
         Sb1n2Zzu6IYTBoPI5szeI5tjsg4LmOtgdyzF/w9vm+eZbbfdEhli5b2lrtR6tTFzrqZC
         Ygsg==
X-Gm-Message-State: AO0yUKUEPFfJLJn/98UM7Z1dCMMO9hdQuYHmNwpbRFM0CyMjV7NP51J4
        3Mjk9gzA+w4CJ+aHQvfaV8jcrDiBLqVYMFyZq5BjOnAkh5wZOACJ5OA=
X-Google-Smtp-Source: AK7set897AhvKSt608HI0HaJ7+dgNerjiq1J9RXlB0xxyeyPMC5N1Q8qnLyWoTIXdyKuaGPi18NqibYej1lkdNzoZnk=
X-Received: by 2002:a05:6102:1592:b0:411:adb8:83f with SMTP id
 g18-20020a056102159200b00411adb8083fmr1760047vsv.15.1675961062680; Thu, 09
 Feb 2023 08:44:22 -0800 (PST)
MIME-Version: 1.0
References: <Y9m/VVRABt0Blfjh@x1n> <CADrL8HXpfTE1+eE3rNGQyOr1QRtDtG5mBp-b3xcNX22QJRvPaQ@mail.gmail.com>
 <Y9qRta3bd4JqjUHx@x1n> <CADrL8HU809O0cPa9hXjf3k+ob139SQqvxOvpqm6UEv=zrPjHSg@mail.gmail.com>
 <Y9re82gctIZf08cX@x1n> <CADrL8HVja_xJ9qczsd-fQfEPvEEXswhXQwoan=a_LSMyORvqww@mail.gmail.com>
 <CADrL8HUSx6=K0QXQtTmv9ZJQmvhe6KEb+FiAviRfO3HjmRUeTw@mail.gmail.com>
 <CADrL8HUm7g4pBLv9vjmB-LhJqxm4jyksGJQAdwRsweKKAnofDg@mail.gmail.com>
 <Y+LbEY62MT/3yo7I@x1n> <CADrL8HUVCXHsaWU7beYQsLw0C7J730PQm45caKE26V8mCFHjKQ@mail.gmail.com>
 <Y+PKwvLT8+wQ6LPA@x1n>
In-Reply-To: <Y+PKwvLT8+wQ6LPA@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 9 Feb 2023 08:43:45 -0800
Message-ID: <CADrL8HUZON-Fc9YxPyTA21AY02OgEXDDsmq9AUSMSxjr83ndYA@mail.gmail.com>
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

On Wed, Feb 8, 2023 at 8:16 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Feb 07, 2023 at 04:26:02PM -0800, James Houghton wrote:
> > On Tue, Feb 7, 2023 at 3:13 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > James,
> > >
> > > On Tue, Feb 07, 2023 at 02:46:04PM -0800, James Houghton wrote:
> > > > > Here is the result: [1] (sorry it took a little while heh). The
> > >
> > > Thanks.  From what I can tell, that number shows that it'll be great we
> > > start with your rfcv1 mapcount approach, which mimics what's proposed by
> > > Matthew for generic folio.
> >
> > Do you think the RFC v1 way is better than doing the THP-like way
> > *with the additional MMU notifier*?
>
> What's the additional MMU notifier you're referring?

An MMU notifier that informs KVM that a collapse has happened without
having to invalidate_range_start() and invalidate_range_end(), the one
you're replying to lower down in the email. :) [ see below... ]

>
> >
> > >
> > > > > implementation of the "RFC v1" way is pretty horrible[2] (and this
> > >
> > > Any more information on why it's horrible? :)
> >
> > I figured the code would speak for itself, heh. It's quite complicated.
> >
> > I really didn't like:
> > 1. The 'inc' business in copy_hugetlb_page_range.
> > 2. How/where I call put_page()/folio_put() to keep the refcount and
> > mapcount synced up.
> > 3. Having to check the page cache in UFFDIO_CONTINUE.
>
> I think the complexity is one thing which I'm fine with so far.  However
> when I think again about the things behind that complexity, I noticed there
> may be at least one flaw that may not be trivial to work around.
>
> It's about truncation.  The problem is now we use the pgtable entry to
> represent the mapcount, but the pgtable entry cannot be zapped easily,
> unless vma unmapped or collapsed.
>
> It means e.g. truncate_inode_folio() may stop working for hugetlb (of
> course, with page lock held).  The mappings will be removed for real, but
> not the mapcount for HGM anymore, because unmap_mapping_folio() only zaps
> the pgtable leaves, not the ones that we used to account for mapcounts.
>
> So the kernel may see weird things, like mapcount>0 after
> truncate_inode_folio() being finished completely.
>
> For HGM to do the right thing, we may want to also remove the non-leaf
> entries when truncating or doing similar things like a rmap walk to drop
> any mappings for a page/folio.  Though that's not doable for now because
> the locks that truncate_inode_folio() is weaker than what we need to free
> the pgtable non-leaf entries - we'll need mmap write lock for that, the
> same as when we unmap or collapse.
>
> Matthew's design doesn't have such issue if the ptes need to be populated,
> because mapcount is still with the leaves; not the case for us here.
>
> If that's the case, _maybe_ we still need to start with the stupid but
> working approach of subpage mapcounts.

Good point. I can't immediately think of a solution. I would prefer to
go with the subpage mapcount approach to simplify HGM for now;
optimizing mapcount for HugeTLB can then be handled separately. If
you're ok with this, I'll go ahead and send v2.

One way that might be possible: using the PAGE_SPECIAL bit on the
hstate-level PTE to indicate if mapcount has been incremented or not
(if the PTE is pointing to page tables). As far as I can tell,
PAGE_SPECIAL doesn't carry any meaning for HugeTLB PTEs, but we would
need to be careful with existing PTE examination code as to not
misinterpret these PTEs.

>
> [...]
>
> > > > > Matthew is trying to solve the same problem with THPs right now: [3].
> > > > > I haven't figured out how we can apply Matthews's approach to HGM
> > > > > right now, but there probably is a way. (If we left the mapcount
> > > > > increment bits in the same place, we couldn't just check the
> > > > > hstate-level PTE; it would have already been made present.)
> > >
> > > I'm just worried that (1) this may add yet another dependency to your work
> > > which is still during discussion phase, and (2) whether the folio approach
> > > is easily applicable here, e.g., we may not want to populate all the ptes
> > > for hugetlb HGMs by default.
> >
> > That's true. I definitely don't want to wait for this either. It seems
> > like Matthew's approach won't work very well for us -- when doing a
> > lot of high-granularity UFFDIO_CONTINUEs on a 1G page, checking all
> > the PTEs to see if any of them are mapped would get really slow.
>
> I think it'll be a common problem to userfaultfd when it comes, e.g.,
> userfaultfd by design is PAGE_SIZE based so far.  It needs page size
> granule on pgtable manipulations, unless we extend the userfaultfd protocol
> to support folios, iiuc.
>
> >
> > >
> > > > >
> > > > > We could:
> > > > > - use the THP-like way and tolerate ~1 second collapses
> > > >
> > > > Another thought here. We don't necessarily *need* to collapse the page
> > > > table mappings in between mmu_notifier_invalidate_range_start() and
> > > > mmu_notifier_invalidate_range_end(), as the pfns aren't changing,
> > > > we aren't punching any holes, and we aren't changing permission bits.
> > > > If we had an MMU notifier that simply informed KVM that we collapsed
> > > > the page tables *after* we finished collapsing, then it would be ok
> > > > for hugetlb_collapse() to be slow.

[ from above... ] This MMU notifier. :)

> > >
> > > That's a great point!  It'll definitely apply to either approach.
> > >
> > > >
> > > > If this MMU notifier is something that makes sense, it probably
> > > > applies to MADV_COLLAPSE for THPs as well.
> > >
> > > THPs are definitely different, mmu notifiers should be required there,
> > > afaict.  Isn't that what the current code does?
> > >
> > > See collapse_and_free_pmd() for shmem and collapse_huge_page() for anon.
> >
> > Oh, yes, of course, MADV_COLLAPSE can actually move things around and
> > properly make THPs. Thanks. But it would apply if we were only
> > collapsing PTE-mapped THPs, I think?
>
> Yes it applies I think.  And if I'm not wrong it's also doing so. :) See
> collapse_pte_mapped_thp().
>
> While for anon we always allocate a new page, hence not applicable.
>
> --
> Peter Xu

Thanks Peter!
- James
