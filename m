Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688E360682C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJTS1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJTS1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:27:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BAA1F524D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:27:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso3501083pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0tIx6HdnxvvsDqhgjFe+ArvgpH3bDXYD7273dNF1cgU=;
        b=dSRDUfwp+jfghkbPv9BNEbmWn5jNVVAAUmaqmB1sJ/4psJI9erOuxkOeUT+D+ih4nG
         6xUsapOGqaGBMHdQh4qHit0J5dNG47yVxcNVmyaIExVIfwerrD6gm6PxoPGAtS3AQVsj
         JNHDFC6w8vK4P0p7ZX7H++T2iwIvk1YwFMBCoPjMPnz/+gEzDHFPivL5/CoUO55fgLQz
         ynywAHWRCJFlI1DgxrN7Shb3aa6XfNT0fc+oYxcptVjY+QuhA5Yu++7CYs5r+D2rf1Wr
         eNPj+PzZo86qf5N+lO7ZIWDWiIzDARuFgsiWpagsKP51ifTw8djpCC0bRYqZfGunPfGX
         4rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tIx6HdnxvvsDqhgjFe+ArvgpH3bDXYD7273dNF1cgU=;
        b=KaHASIqQwsSxVjoliehS1kWwfPUZJv8Bgw9A7hqsFh50bEp5peqEZqb7MZvyrQBOuM
         yoS9ahtQE5YxjWEi45vpZ8llGC0raUP/7AG66B+0TF+Cqjz430LE4ZAO3hGWkSd7q0cz
         ut2cE2zidfoktDg4UW8vhuuGjUzRlGV1h42yoNJypSi3QNIqK6bGzIpYfrbVGgOtrh6g
         NMoTKfP2yYgdRyiTbqBW6LAkgYSeELZZueFSxdg3rc8xQXopQZXfrQ0FIB+qLjxNtfCj
         AhDa0BxtVgsXGk+vB5fQ17/Cw0bd4ochxjohfgp7dE35qXwRDQOiRGPV+JDs8ykuCAaH
         Qu+Q==
X-Gm-Message-State: ACrzQf2XDu6ra93IYwhLBYK1ozVZ3dgANCk1PNO9dTDvByG8rd9c3Owc
        ydCQZwzAnWPxUu/Awl9vzpB94FwKc/RWUAx328Y=
X-Google-Smtp-Source: AMsMyM6l7jPlCkpp6teBaQ2qsDbSYRodsLiWbU/KFD5M8VnN7xNmjW0TSzthjck2HP04OBtttwh34jp+rkZcdngtdYs=
X-Received: by 2002:a17:902:d512:b0:181:f1f4:fcb4 with SMTP id
 b18-20020a170902d51200b00181f1f4fcb4mr15353550plg.102.1666290466641; Thu, 20
 Oct 2022 11:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221018200125.848471-1-jthoughton@google.com>
 <CAHbLzkoAeXhpJ2_eM6uYU9kuqNsT25NubOZZG6E1mFngYREuPg@mail.gmail.com> <CADrL8HU_a_GzM9kMLO19o6uHdZXpT+Gxyg6EhLORQxpfRSwXdg@mail.gmail.com>
In-Reply-To: <CADrL8HU_a_GzM9kMLO19o6uHdZXpT+Gxyg6EhLORQxpfRSwXdg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 Oct 2022 11:27:34 -0700
Message-ID: <CAHbLzkpfU_JgPgaZ6q3HWZZozsSd=q=aCCz5bhOUjMwsyXwwfw@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: don't delete error page from pagecache
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:42 AM James Houghton <jthoughton@google.com> wrote:
>
> On Wed, Oct 19, 2022 at 11:31 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Tue, Oct 18, 2022 at 1:01 PM James Houghton <jthoughton@google.com> wrote:
> > >
> > > This change is very similar to the change that was made for shmem [1],
> > > and it solves the same problem but for HugeTLBFS instead.
> > >
> > > Currently, when poison is found in a HugeTLB page, the page is removed
> > > from the page cache. That means that attempting to map or read that
> > > hugepage in the future will result in a new hugepage being allocated
> > > instead of notifying the user that the page was poisoned. As [1] states,
> > > this is effectively memory corruption.
> > >
> > > The fix is to leave the page in the page cache. If the user attempts to
> > > use a poisoned HugeTLB page with a syscall, the syscall will fail with
> > > EIO, the same error code that shmem uses. For attempts to map the page,
> > > the thread will get a BUS_MCEERR_AR SIGBUS.
> > >
> > > [1]: commit a76054266661 ("mm: shmem: don't truncate page if memory failure happens")
> > >
> > > Signed-off-by: James Houghton <jthoughton@google.com>
> >
> > Thanks for the patch. Yes, we should do the same thing for hugetlbfs.
> > When I was working on shmem I did look into hugetlbfs too. But the
> > problem is we actually make the whole hugetlb page unavailable even
> > though just one 4K sub page is hwpoisoned. It may be fine to 2M
> > hugetlb page, but a lot of memory may be a huge waste for 1G hugetlb
> > page, particular for the page fault path.
>
> Right -- it is wasted until a hole is punched or the file is
> truncated. Although we're wasting the rest of the hugepage for a
> little longer with this patch, I think it's worth it to have correct
> behavior.
>
> >
> > So I discussed this with Mike offline last year, and I was told Google
> > was working on PTE mapped hugetlb page. That should be able to solve
> > the problem. And we'd like to have the high-granularity hugetlb
> > mapping support as the predecessor.
> >
> > There were some other details, but I can't remember all of them, I
> > have to refresh my memory by rereading the email discussions...
>
> Yes! I am working on this. :) I will send up a series in the coming
> weeks that implements basic support for high-granularity mapping
> (HGM). This patch is required for hwpoison semantics to work properly
> for high-granularity mapping (and, as the patch states, for shared
> HugeTLB mappings generally). For HGM, if we partially map a hugepage
> and find poison, faulting on the unmapped bits of it will allocate a
> new hugepage. By keeping the poisoned page in the pagecache, we
> correctly give userspace a SIGBUS. I didn't mention this in the commit
> description because I think this patch is correct on its own.

I don't mean it is not correct. I'm not sure which one (this patch or
HGM) would go first. But it sounds like you thought this patch should
be the predecessor of HGM since it could deliver userspace the correct
signal?

>
> I haven't implemented PAGE_SIZE poisoning of HugeTLB pages yet, but
> high-granularity mapping unblocks this work. Hopefully that will be
> ready in the coming months. :)
>
> - James Houghton
>
> >
> > > ---
> > >  fs/hugetlbfs/inode.c | 13 ++++++-------
> > >  mm/hugetlb.c         |  4 ++++
> > >  mm/memory-failure.c  |  5 ++++-
> > >  3 files changed, 14 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > > index fef5165b73a5..7f836f8f9db1 100644
> > > --- a/fs/hugetlbfs/inode.c
> > > +++ b/fs/hugetlbfs/inode.c
> > > @@ -328,6 +328,12 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > >                 } else {
> > >                         unlock_page(page);
> > >
> > > +                       if (PageHWPoison(page)) {
> > > +                               put_page(page);
> > > +                               retval = -EIO;
> > > +                               break;
> > > +                       }
> > > +
> > >                         /*
> > >                          * We have the page, copy it to user space buffer.
> > >                          */
> > > @@ -1111,13 +1117,6 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
> > >  static int hugetlbfs_error_remove_page(struct address_space *mapping,
> > >                                 struct page *page)
> > >  {
> > > -       struct inode *inode = mapping->host;
> > > -       pgoff_t index = page->index;
> > > -
> > > -       hugetlb_delete_from_page_cache(page_folio(page));
> > > -       if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
> > > -               hugetlb_fix_reserve_counts(inode);
> > > -
> > >         return 0;
> > >  }
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 97896165fd3f..5120a9ccbf5b 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -6101,6 +6101,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> > >
> > >         ptl = huge_pte_lock(h, dst_mm, dst_pte);
> > >
> > > +       ret = -EIO;
> > > +       if (PageHWPoison(page))
> > > +               goto out_release_unlock;
> > > +
> > >         /*
> > >          * We allow to overwrite a pte marker: consider when both MISSING|WP
> > >          * registered, we firstly wr-protect a none pte which has no page cache
> > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > index 145bb561ddb3..bead6bccc7f2 100644
> > > --- a/mm/memory-failure.c
> > > +++ b/mm/memory-failure.c
> > > @@ -1080,6 +1080,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
> > >         int res;
> > >         struct page *hpage = compound_head(p);
> > >         struct address_space *mapping;
> > > +       bool extra_pins = false;
> > >
> > >         if (!PageHuge(hpage))
> > >                 return MF_DELAYED;
> > > @@ -1087,6 +1088,8 @@ static int me_huge_page(struct page_state *ps, struct page *p)
> > >         mapping = page_mapping(hpage);
> > >         if (mapping) {
> > >                 res = truncate_error_page(hpage, page_to_pfn(p), mapping);
> > > +               /* The page is kept in page cache. */
> > > +               extra_pins = true;
> > >                 unlock_page(hpage);
> > >         } else {
> > >                 unlock_page(hpage);
> > > @@ -1104,7 +1107,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
> > >                 }
> > >         }
> > >
> > > -       if (has_extra_refcount(ps, p, false))
> > > +       if (has_extra_refcount(ps, p, extra_pins))
> > >                 res = MF_FAILED;
> > >
> > >         return res;
> > > --
> > > 2.38.0.413.g74048e4d9e-goog
> > >
