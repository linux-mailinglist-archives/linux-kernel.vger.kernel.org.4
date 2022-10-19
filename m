Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AA7604FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJSSmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJSSmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:42:18 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E4F1A0F93
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:42:17 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-367cd2807f2so11426867b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pVpbWk4bBR6nw+ZSuDfbXLMU1jc4pYSjC/JFj+X3inQ=;
        b=YoiHOFl8KBDaxhfE4FWVp0F3P+wbRiWm3ZVBwwYx9MICrivFguDiiv5cZW5NI4kira
         +VfkooKF5ZN3REa98ypGmgSsKMIkcBMW31cxu7zXMAveGuBwbqq5RcUbOle5R8+pxsha
         RMKTwKeFt0p/jwjh9csfF6peqGhDf+MJy07S1PV3JrUE3qCuMSw6X/hT3TQBR7lf6mzp
         xXFEAElFPxGT2wfBBgOJJhK66mxM6WD5zZsb+NV9UZ4scEt2140SRtext481r70394X3
         PaZEbrJ1mfBA2++CzUKuaN7Q7nH2eJ93nHAR01qn7pg2+45nZ/C4flq7EKrYrAk2ifN1
         epxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVpbWk4bBR6nw+ZSuDfbXLMU1jc4pYSjC/JFj+X3inQ=;
        b=kdqq3gB0mGDPyveH+gypUi01HfZo2Mo5p4NKrQ8AAqS4ByZvKI1GDdBgmBgfNgQkJa
         CZCCb5vFQ/J+SXvNeSx0htEtsj/62Y0bG8o/LTGGOdx6LyO5G3xxjbdRyR3WchbgnJp0
         DwOBFdNs5iD/hfDzFtC+qgxodHzGZiDUciOw/Nq+9A7VBm4fOJIkk/1BpgjniuZG76Yi
         R+aMwCNt/RkNjBxC9okrm6zfrTkAJIMkvklZDKzxv72vE6PjGliSP1ee2Fr7jaJu540N
         ZLYlpfciH8YlBnNrq/MHNn7K6qmVAO1ffc3p6qdivy+voFvjOR8x4bYJjhi5H4sXs+B9
         6sRQ==
X-Gm-Message-State: ACrzQf1QnQ57CWcRlvoLwZ5N+X1BpVzDf/biawqp7/FjV8a145NvwV/S
        v/SDxUj2hF6N5EaaEseLyav1F7/BG7jLyRqmBJbRnA==
X-Google-Smtp-Source: AMsMyM6Pe2fz4Ig5qqZ3whp3aVx1Dg3ZQP+klUtMTnCd6iA3J+zPI2VdQMA9MBYc+544+g/g0Iu2ghDNnB4wvR4Khmg=
X-Received: by 2002:a81:8283:0:b0:367:a556:e893 with SMTP id
 s125-20020a818283000000b00367a556e893mr2059965ywf.115.1666204936093; Wed, 19
 Oct 2022 11:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221018200125.848471-1-jthoughton@google.com> <CAHbLzkoAeXhpJ2_eM6uYU9kuqNsT25NubOZZG6E1mFngYREuPg@mail.gmail.com>
In-Reply-To: <CAHbLzkoAeXhpJ2_eM6uYU9kuqNsT25NubOZZG6E1mFngYREuPg@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 19 Oct 2022 11:42:04 -0700
Message-ID: <CADrL8HU_a_GzM9kMLO19o6uHdZXpT+Gxyg6EhLORQxpfRSwXdg@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: don't delete error page from pagecache
To:     Yang Shi <shy828301@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org,
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

On Wed, Oct 19, 2022 at 11:31 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, Oct 18, 2022 at 1:01 PM James Houghton <jthoughton@google.com> wrote:
> >
> > This change is very similar to the change that was made for shmem [1],
> > and it solves the same problem but for HugeTLBFS instead.
> >
> > Currently, when poison is found in a HugeTLB page, the page is removed
> > from the page cache. That means that attempting to map or read that
> > hugepage in the future will result in a new hugepage being allocated
> > instead of notifying the user that the page was poisoned. As [1] states,
> > this is effectively memory corruption.
> >
> > The fix is to leave the page in the page cache. If the user attempts to
> > use a poisoned HugeTLB page with a syscall, the syscall will fail with
> > EIO, the same error code that shmem uses. For attempts to map the page,
> > the thread will get a BUS_MCEERR_AR SIGBUS.
> >
> > [1]: commit a76054266661 ("mm: shmem: don't truncate page if memory failure happens")
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
>
> Thanks for the patch. Yes, we should do the same thing for hugetlbfs.
> When I was working on shmem I did look into hugetlbfs too. But the
> problem is we actually make the whole hugetlb page unavailable even
> though just one 4K sub page is hwpoisoned. It may be fine to 2M
> hugetlb page, but a lot of memory may be a huge waste for 1G hugetlb
> page, particular for the page fault path.

Right -- it is wasted until a hole is punched or the file is
truncated. Although we're wasting the rest of the hugepage for a
little longer with this patch, I think it's worth it to have correct
behavior.

>
> So I discussed this with Mike offline last year, and I was told Google
> was working on PTE mapped hugetlb page. That should be able to solve
> the problem. And we'd like to have the high-granularity hugetlb
> mapping support as the predecessor.
>
> There were some other details, but I can't remember all of them, I
> have to refresh my memory by rereading the email discussions...

Yes! I am working on this. :) I will send up a series in the coming
weeks that implements basic support for high-granularity mapping
(HGM). This patch is required for hwpoison semantics to work properly
for high-granularity mapping (and, as the patch states, for shared
HugeTLB mappings generally). For HGM, if we partially map a hugepage
and find poison, faulting on the unmapped bits of it will allocate a
new hugepage. By keeping the poisoned page in the pagecache, we
correctly give userspace a SIGBUS. I didn't mention this in the commit
description because I think this patch is correct on its own.

I haven't implemented PAGE_SIZE poisoning of HugeTLB pages yet, but
high-granularity mapping unblocks this work. Hopefully that will be
ready in the coming months. :)

- James Houghton

>
> > ---
> >  fs/hugetlbfs/inode.c | 13 ++++++-------
> >  mm/hugetlb.c         |  4 ++++
> >  mm/memory-failure.c  |  5 ++++-
> >  3 files changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index fef5165b73a5..7f836f8f9db1 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -328,6 +328,12 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >                 } else {
> >                         unlock_page(page);
> >
> > +                       if (PageHWPoison(page)) {
> > +                               put_page(page);
> > +                               retval = -EIO;
> > +                               break;
> > +                       }
> > +
> >                         /*
> >                          * We have the page, copy it to user space buffer.
> >                          */
> > @@ -1111,13 +1117,6 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
> >  static int hugetlbfs_error_remove_page(struct address_space *mapping,
> >                                 struct page *page)
> >  {
> > -       struct inode *inode = mapping->host;
> > -       pgoff_t index = page->index;
> > -
> > -       hugetlb_delete_from_page_cache(page_folio(page));
> > -       if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
> > -               hugetlb_fix_reserve_counts(inode);
> > -
> >         return 0;
> >  }
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 97896165fd3f..5120a9ccbf5b 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6101,6 +6101,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >
> >         ptl = huge_pte_lock(h, dst_mm, dst_pte);
> >
> > +       ret = -EIO;
> > +       if (PageHWPoison(page))
> > +               goto out_release_unlock;
> > +
> >         /*
> >          * We allow to overwrite a pte marker: consider when both MISSING|WP
> >          * registered, we firstly wr-protect a none pte which has no page cache
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 145bb561ddb3..bead6bccc7f2 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1080,6 +1080,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
> >         int res;
> >         struct page *hpage = compound_head(p);
> >         struct address_space *mapping;
> > +       bool extra_pins = false;
> >
> >         if (!PageHuge(hpage))
> >                 return MF_DELAYED;
> > @@ -1087,6 +1088,8 @@ static int me_huge_page(struct page_state *ps, struct page *p)
> >         mapping = page_mapping(hpage);
> >         if (mapping) {
> >                 res = truncate_error_page(hpage, page_to_pfn(p), mapping);
> > +               /* The page is kept in page cache. */
> > +               extra_pins = true;
> >                 unlock_page(hpage);
> >         } else {
> >                 unlock_page(hpage);
> > @@ -1104,7 +1107,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
> >                 }
> >         }
> >
> > -       if (has_extra_refcount(ps, p, false))
> > +       if (has_extra_refcount(ps, p, extra_pins))
> >                 res = MF_FAILED;
> >
> >         return res;
> > --
> > 2.38.0.413.g74048e4d9e-goog
> >
