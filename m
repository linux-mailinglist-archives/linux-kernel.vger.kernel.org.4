Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21933699F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjBPV7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBPV7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:59:09 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57AF3609C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:59:07 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d2so3278533pjd.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2cQYnkXv7L7qhiGEdO0H9rKipVy8lLGlyCZOqqsAcqU=;
        b=gmPBUl59wTFyJIl/E/EcCS3HT6nMuh+KY8yAitPi9tUu6iS10t+FlMb3mW+ybZOIio
         sqdUmnyeWF+vRVa/23T9dqWvrDOv8EBLsjOcjtBEDXHx/ImTx5XluaHbQZbPiqM4sQfr
         YLOgHIUMeHbnNFLEJNn3ZIhiGxYseq+rLjQviMKWdOdjnAJC9PSL3OMTcahyyWrAMETj
         6FQmxMRPIX+wg+ohlEZTUyHpYYj6cVn0chYCycA7W/DK7ZfWAbZBkonMqPDTkrMP/czI
         i/ejcHcmF9FGMe2xxmGsc5nsK3CHSDkNXmfc8j8foKzzNJhlEKPljAwkMLTpHTj9pPhY
         k6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cQYnkXv7L7qhiGEdO0H9rKipVy8lLGlyCZOqqsAcqU=;
        b=iVNDgOcSjQMjIu9MtGr95ydnBKwpG5ispK6pbL9ed4iAi2bx+lueE8/hRGIyhMMmkH
         3/j28Ztcwa/vLK2uhoh7puzKV0wm+muAP+agMb9/Lofm5zEWujJu/Ok355irTNk8LBvI
         pOrQaz6aq4JoMtUln4qjb9tQr7XX5OJ5+dyOdzekHvdg8TRQRJhz/JvJr/05mCJ9HI78
         BFMkpz8stIwzKPyPbgUISa5WVnAtsWDOkChaaUz6lbu4X6pB4YoD40DOYXjNcaI5hzq3
         eM9aUn0C/HxoyeG+ip0Vqu/Jw5GL+bWu0ZwpZ9W0EE7wqvY1wTfnlSTfsGZNzh9bcm0r
         OPbA==
X-Gm-Message-State: AO0yUKVyVuLTIljs1qSDXj2uSrrCN6iFeQd/5GLe5/bHgP0A5IIA1+mM
        QTw31PfHG43DDjfheEDONh29pRSk7iII8EYdUn4=
X-Google-Smtp-Source: AK7set8Gij72ajPVD9Xe2MJng02VISC3uIHSu7lyyH+Mf3nS1U+xR+oo072qbV8rbGgihEewLSGRE1AzpKA6eUfbyWk=
X-Received: by 2002:a17:90b:1e47:b0:230:b973:a726 with SMTP id
 pi7-20020a17090b1e4700b00230b973a726mr943751pjb.23.1676584747311; Thu, 16 Feb
 2023 13:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20230214075710.2401855-1-stevensd@google.com> <20230214075710.2401855-2-stevensd@google.com>
 <Y+1hMsm4eQIUtag5@x1n> <CAD=HUj69L2e-Z4TB19qFt8h1cn0r1oGbWovJGMOjjyvfDcQ7NA@mail.gmail.com>
 <Y+5Akpz4CvGywt6R@x1n>
In-Reply-To: <Y+5Akpz4CvGywt6R@x1n>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 16 Feb 2023 13:58:55 -0800
Message-ID: <CAHbLzkqUF8Y759ZBVGXWdKwDS4f+ZJakUhoqf8Dqvx0Jam4c1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/khugepaged: skip shmem with userfaultfd
To:     Peter Xu <peterx@redhat.com>
Cc:     David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
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

On Thu, Feb 16, 2023 at 6:41 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Feb 16, 2023 at 10:37:47AM +0900, David Stevens wrote:
> > On Thu, Feb 16, 2023 at 7:48 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Tue, Feb 14, 2023 at 04:57:10PM +0900, David Stevens wrote:
> > > > From: David Stevens <stevensd@chromium.org>
> > > >
> > > > Make sure that collapse_file respects any userfaultfds registered with
> > > > MODE_MISSING. If userspace has any such userfaultfds registered, then
> > > > for any page which it knows to be missing, it may expect a
> > > > UFFD_EVENT_PAGEFAULT. This means collapse_file needs to take care when
> > > > collapsing a shmem range would result in replacing an empty page with a
> > > > THP, so that it doesn't break userfaultfd.
> > > >
> > > > Synchronization when checking for userfaultfds in collapse_file is
> > > > tricky because the mmap locks can't be used to prevent races with the
> > > > registration of new userfaultfds. Instead, we provide synchronization by
> > > > ensuring that userspace cannot observe the fact that pages are missing
> > > > before we check for userfaultfds. Although this allows registration of a
> > > > userfaultfd to race with collapse_file, it ensures that userspace cannot
> > > > observe any pages transition from missing to present after such a race.
> > > > This makes such a race indistinguishable to the collapse occurring
> > > > immediately before the userfaultfd registration.
> > > >
> > > > The first step to provide this synchronization is to stop filling gaps
> > > > during the loop iterating over the target range, since the page cache
> > > > lock can be dropped during that loop. The second step is to fill the
> > > > gaps with XA_RETRY_ENTRY after the page cache lock is acquired the final
> > > > time, to avoid races with accesses to the page cache that only take the
> > > > RCU read lock.
> > > >
> > > > This fix is targeted at khugepaged, but the change also applies to
> > > > MADV_COLLAPSE. MADV_COLLAPSE on a range with a userfaultfd will now
> > > > return EBUSY if there are any missing pages (instead of succeeding on
> > > > shmem and returning EINVAL on anonymous memory). There is also now a
> > > > window during MADV_COLLAPSE where a fault on a missing page will cause
> > > > the syscall to fail with EAGAIN.
> > > >
> > > > The fact that intermediate page cache state can no longer be observed
> > > > before the rollback of a failed collapse is also technically a
> > > > userspace-visible change (via at least SEEK_DATA and SEEK_END), but it
> > > > is exceedingly unlikely that anything relies on being able to observe
> > > > that transient state.
> > > >
> > > > Signed-off-by: David Stevens <stevensd@chromium.org>
> > > > ---
> > > >  mm/khugepaged.c | 66 +++++++++++++++++++++++++++++++++++++++++++------
> > > >  1 file changed, 58 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > index b648f1053d95..8c2e2349e883 100644
> > > > --- a/mm/khugepaged.c
> > > > +++ b/mm/khugepaged.c
> > > > @@ -55,6 +55,7 @@ enum scan_result {
> > > >       SCAN_CGROUP_CHARGE_FAIL,
> > > >       SCAN_TRUNCATED,
> > > >       SCAN_PAGE_HAS_PRIVATE,
> > > > +     SCAN_PAGE_FILLED,
> > >
> > > PS: You may want to also touch SCAN_STATUS in huge_memory.h next time.
> > >
> > > >  };
> > > >
> > > >  #define CREATE_TRACE_POINTS
> > > > @@ -1725,8 +1726,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> > > >   *  - allocate and lock a new huge page;
> > > >   *  - scan page cache replacing old pages with the new one
> > > >   *    + swap/gup in pages if necessary;
> > > > - *    + fill in gaps;
> > >
> > > IIUC it's not a complete removal, but just moved downwards:
> > >
> > > >   *    + keep old pages around in case rollback is required;
> > > > + *  - finalize updates to the page cache;
> > >
> > >          + fill in gaps with RETRY entries
> > >          + detect race conditions with userfaultfds
> > >
> > > >   *  - if replacing succeeds:
> > > >   *    + copy data over;
> > > >   *    + free old pages;
> > > > @@ -1805,13 +1806,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > > >                                               result = SCAN_TRUNCATED;
> > > >                                               goto xa_locked;
> > > >                                       }
> > > > -                                     xas_set(&xas, index);
> > > > +                                     xas_set(&xas, index + 1);
> > > >                               }
> > > >                               if (!shmem_charge(mapping->host, 1)) {
> > > >                                       result = SCAN_FAIL;
> > > >                                       goto xa_locked;
> > > >                               }
> > > > -                             xas_store(&xas, hpage);
> > > >                               nr_none++;
> > > >                               continue;
> > > >                       }
> > > > @@ -1970,6 +1970,56 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > > >               put_page(page);
> > > >               goto xa_unlocked;
> > > >       }
> > > > +
> > > > +     if (nr_none) {
> > > > +             struct vm_area_struct *vma;
> > > > +             int nr_none_check = 0;
> > > > +
> > > > +             xas_unlock_irq(&xas);
> > > > +             i_mmap_lock_read(mapping);
> > > > +             xas_lock_irq(&xas);
> > > > +
> > > > +             xas_set(&xas, start);
> > > > +             for (index = start; index < end; index++) {
> > > > +                     if (!xas_next(&xas)) {
> > > > +                             xas_store(&xas, XA_RETRY_ENTRY);
> > > > +                             nr_none_check++;
> > > > +                     }
> > > > +             }
> > > > +
> > > > +             if (nr_none != nr_none_check) {
> > > > +                     result = SCAN_PAGE_FILLED;
> > > > +                     goto immap_locked;
> > > > +             }
> > > > +
> > > > +             /*
> > > > +              * If userspace observed a missing page in a VMA with an armed
> > > > +              * userfaultfd, then it might expect a UFFD_EVENT_PAGEFAULT for
> > > > +              * that page, so we need to roll back to avoid suppressing such
> > > > +              * an event. Any userfaultfds armed after this point will not be
> > > > +              * able to observe any missing pages due to the previously
> > > > +              * inserted retry entries.
> > > > +              */
> > > > +             vma_interval_tree_foreach(vma, &mapping->i_mmap, start, start) {
> > > > +                     if (userfaultfd_missing(vma)) {
> > > > +                             result = SCAN_EXCEED_NONE_PTE;
> > > > +                             goto immap_locked;
> > > > +                     }
> > > > +             }
> > > > +
> > > > +immap_locked:
> > > > +             i_mmap_unlock_read(mapping);
> > > > +             if (result != SCAN_SUCCEED) {
> > > > +                     xas_set(&xas, start);
> > > > +                     for (index = start; index < end; index++) {
> > > > +                             if (xas_next(&xas) == XA_RETRY_ENTRY)
> > > > +                                     xas_store(&xas, NULL);
> > > > +                     }
> > > > +
> > > > +                     goto xa_locked;
> > > > +             }
> > > > +     }
> > > > +
> > >
> > > Until here, all look fine to me (ignoring patch 1 for now; assuming the
> > > hpage is always uptodate).
> > >
> > > My question is after here we'll release page cache lock again before
> > > try_to_unmap_flush(), but is it safe to keep RETRY entries after releasing
> > > page cache lock?  It means other threads can be spinning.  I assume page
> > > lock is always safe and sleepable, but not sure about the page cache lock
> > > here.
> >
> > We insert the multi-index entry for hpage before releasing the page
> > cache lock, which should replace all of the XA_RETRY_ENTRYs. So the
> > page cache will be fully up to date when we release the lock, at least
> > in terms of which pages it contains.
>
> IIUC we released it before copying the pages:

The huge page is locked until the copy is done. It should be fine
unless the users inspect the page content without acquiring page lock.

>
> xa_locked:
>         xas_unlock_irq(&xas);  <-------------------------------- here
> xa_unlocked:
>
>         /*
>          * If collapse is successful, flush must be done now before copying.
>          * If collapse is unsuccessful, does flush actually need to be done?
>          * Do it anyway, to clear the state.
>          */
>         try_to_unmap_flush();
>
> Before insertion of the multi-index:
>
>         /* Join all the small entries into a single multi-index entry. */
>         xas_set_order(&xas, start, HPAGE_PMD_ORDER);
>         xas_store(&xas, hpage);
>
> Thanks,
>
> --
> Peter Xu
>
