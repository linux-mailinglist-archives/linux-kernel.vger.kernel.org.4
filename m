Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D6C73ADED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjFWAps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjFWApq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:45:46 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DD1DD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:45:45 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-57012b2973eso86704467b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687481144; x=1690073144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKIfRbAJZ0FsYoJoh9IDm1KIaCcGTYPwnDQc9veeEAs=;
        b=px0po+wV+QaKxqXfNUnOnwJ2AkoIIJw7Je1MDRkW8R9xWZb5k6DvrnbarZJRLzdyw3
         j1mn+1Yf54DWLjGADaO68C+hcH/gPJ5H6WwlB2DMg94xQ5tYhJ3N7uqGeGVIUh+b72Ww
         8A6nHDdlzUtHi1QKQyPmAwF4gRJHrJ1NI5yzfPFOtmeqHp3l0FmzfZmTTPGFZGBQPdfR
         Gqi20MO0o9+hTydugxDR4SQd4jG2SMsILvyAS6xSCFr5gh+uzUhv/811NCPHOOWX4DQ9
         tAIS1etXRwofZULqQSQxRKyXwiOHgYKnZGMAGQ5ed/aiM1rkRXSJKa24H7xTpGl/gKKf
         N9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687481144; x=1690073144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKIfRbAJZ0FsYoJoh9IDm1KIaCcGTYPwnDQc9veeEAs=;
        b=NC7sfn0ldfRbBecwCbywjJ3Jzt54Ssq3N/boU/aKhWNYMAECpQMsO4rYiFJ6UiaryO
         4glJVMxm/qE7FRmIJHEz4u5G8un1yjNTv7MPjPbGXaJS4+Pbln/aOKT0upX6x6M+oTI+
         z3cyvEofon5gb5eiyr+dXIZFkYy6Ydnt7+ApkfMFtCAqFpbALOlgn9qvq3UFOuWcQKuk
         x+0oVNFJjT0LaqgfnsMgc+gf0/FLIVmdR/M+lylttTya6qZuWdtbE9Ej3bgWTemRl1sh
         WQEVtMDmbAtaM+sUChQDFg2tFydkqF3Pax90tAIC5vM0Jnr+cMjeZl0o0zmi7M0VOJUI
         9zvw==
X-Gm-Message-State: AC+VfDwLQFZWogtL7Sv9ccetoj+4KllLQe6yyyTYqcK5vTOWYdw78bmm
        yDCIIgG6Gn/VJM67EOqDEwRywBlFarKHaAqJ5U+MNg==
X-Google-Smtp-Source: ACHHUZ6GWoN4GSCylJJKRDmKwgB7NgBuBS/8Y0nXHNbRvzi6glMEtToSY2CWWKqjUEzqLZDez3sPzudFQbfFvSUE7E8=
X-Received: by 2002:a81:6e56:0:b0:573:2fea:39a6 with SMTP id
 j83-20020a816e56000000b005732fea39a6mr13957854ywc.32.1687481144094; Thu, 22
 Jun 2023 17:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230523024305.GA920098@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F53C0f_Ph0etD+BgkAz4P8pX3YArjFgSPaLh_d6rUqMUCw@mail.gmail.com>
 <CACw3F52k=fhYpLpvDoVPcmKnOALLkPsGk08PdS_H0+miSYvhEQ@mail.gmail.com>
 <20230612041901.GA3083591@ik1-406-35019.vs.sakura.ne.jp> <CACw3F51o1ZFSYZa+XLnk4Wwjy2w_q=Kn+aOQs0=qpfG-ZYDFKg@mail.gmail.com>
 <20230616233447.GB7371@monkey> <CACw3F52iG5bqQbvZ9QkkRkVfy+NbSOu9hnkVOt5khukNNG73OQ@mail.gmail.com>
 <20230617225927.GA3540@monkey> <20230619082330.GA1612447@ik1-406-35019.vs.sakura.ne.jp>
 <20230620180533.GA3567@monkey> <20230620223909.GB3567@monkey>
In-Reply-To: <20230620223909.GB3567@monkey>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Thu, 22 Jun 2023 17:45:32 -0700
Message-ID: <CACw3F53iPiLrJt4pyaX2aaZ5BVg9tj8x_k6-v7=9Xn1nrh=UCw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 3:39=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 06/20/23 11:05, Mike Kravetz wrote:
> > On 06/19/23 17:23, Naoya Horiguchi wrote:
> > >
> > > Considering this issue as one specific to memory error handling, chec=
king
> > > HPG_vmemmap_optimized in __get_huge_page_for_hwpoison() might be help=
ful to
> > > detect the race.  Then, an idea like the below diff (not tested) can =
make
> > > try_memory_failure_hugetlb() retry (with retaking hugetlb_lock) to wa=
it
> > > for complete the allocation of vmemmap pages.
> > >
> > > @@ -1938,8 +1938,11 @@ int __get_huge_page_for_hwpoison(unsigned long=
 pfn, int flags,
> > >         int ret =3D 2;    /* fallback to normal page handling */
> > >         bool count_increased =3D false;
> > >
> > > -       if (!folio_test_hugetlb(folio))
> > > +       if (!folio_test_hugetlb(folio)) {
> > > +               if (folio_test_hugetlb_vmemmap_optimized(folio))
> > > +                       ret =3D -EBUSY;
> >
> > The hugetlb specific page flags (HPG_vmemmap_optimized here) reside in
> > the folio->private field.
> >
> > In the case where the folio is a non-hugetlb folio, the folio->private =
field
> > could be any arbitrary value.  As such, the test for vmemmap_optimized =
may
> > return a false positive.  We could end up retrying for an arbitrarily
> > long time.
> >
> > I am looking at how to restructure the code which removes and frees
> > hugetlb pages so that folio_test_hugetlb() would remain true until
> > vmemmap pages are allocated.  The easiest way to do this would introduc=
e
> > another hugetlb lock/unlock cycle in the page freeing path.  This would
> > undo some of the speedups in the series:
> > https://lore.kernel.org/all/20210409205254.242291-4-mike.kravetz@oracle=
.com/T/#m34321fbcbdf8bb35dfe083b05d445e90ecc1efab
> >
>
> Perhaps something like this?  Minimal testing.

Thanks for putting up a fix, Mike!

>
> From e709fb4da0b6249973f9bf0540c9da0e4c585fe2 Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Tue, 20 Jun 2023 14:48:39 -0700
> Subject: [PATCH] hugetlb: Do not clear hugetlb dtor until allocating vmem=
map
>
> Freeing a hugetlb page and releasing base pages back to the underlying
> allocator such as buddy or cma is performed in two steps:
> - remove_hugetlb_folio() is called to remove the folio from hugetlb
>   lists, get a ref on the page and remove hugetlb destructor.  This
>   all must be done under the hugetlb lock.  After this call, the page
>   can be treated as a normal compound page or a collection of base
>   size pages.
> - update_and_free_hugetlb_folio() is called to allocate vmemmap if
>   needed and the free routine of the underlying allocator is called
>   on the resulting page.  We can not hold the hugetlb lock here.
>
> One issue with this scheme is that a memory error could occur between
> these two steps.  In this case, the memory error handling code treats
> the old hugetlb page as a normal compound page or collection of base
> pages.  It will then try to SetPageHWPoison(page) on the page with an
> error.  If the page with error is a tail page without vmemmap, a write
> error will occur when trying to set the flag.
>
> Address this issue by modifying remove_hugetlb_folio() and
> update_and_free_hugetlb_folio() such that the hugetlb destructor is not
> cleared until after allocating vmemmap.  Since clearing the destructor
> required holding the hugetlb lock, the clearing is done in
> remove_hugetlb_folio() if the vmemmap is present.  This saves a
> lock/unlock cycle.  Otherwise, destructor is cleared in
> update_and_free_hugetlb_folio() after allocating vmemmap.
>
> Note that this will leave hugetlb pages in a state where they are marked
> free (by hugetlb specific page flag) and have a ref count.  This is not
> a normal state.  The only code that would notice is the memory error
> code, and it is set up to retry in such a case.
>
> A subsequent patch will create a routine to do bulk processing of
> vmemmap allocation.  This will eliminate a lock/unlock cycle for each
> hugetlb page in the case where we are freeing a bunch of pages.
>
> Fixes: ???
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 75 +++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 51 insertions(+), 24 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d76574425da3..f7f64470aee0 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1579,9 +1579,37 @@ static inline void destroy_compound_gigantic_folio=
(struct folio *folio,
>                                                 unsigned int order) { }
>  #endif
>
> +static inline void __clear_hugetlb_destructor(struct hstate *h,
> +                                               struct folio *folio)
> +{
> +       lockdep_assert_held(&hugetlb_lock);
> +
> +       /*
> +        * Very subtle
> +        *
> +        * For non-gigantic pages set the destructor to the normal compou=
nd
> +        * page dtor.  This is needed in case someone takes an additional
> +        * temporary ref to the page, and freeing is delayed until they d=
rop
> +        * their reference.
> +        *
> +        * For gigantic pages set the destructor to the null dtor.  This
> +        * destructor will never be called.  Before freeing the gigantic
> +        * page destroy_compound_gigantic_folio will turn the folio into =
a
> +        * simple group of pages.  After this the destructor does not
> +        * apply.
> +        *
> +        */
> +       if (hstate_is_gigantic(h))
> +               folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
> +       else
> +               folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
> +}
> +
>  /*
> - * Remove hugetlb folio from lists, and update dtor so that the folio ap=
pears
> - * as just a compound page.
> + * Remove hugetlb folio from lists.
> + * If vmemmap exists for the folio, update dtor so that the folio appear=
s
> + * as just a compound page.  Otherwise, wait until after allocating vmem=
map
> + * to update dtor.
>   *
>   * A reference is held on the folio, except in the case of demote.
>   *
> @@ -1612,31 +1640,19 @@ static void __remove_hugetlb_folio(struct hstate =
*h, struct folio *folio,
>         }
>
>         /*
> -        * Very subtle
> -        *
> -        * For non-gigantic pages set the destructor to the normal compou=
nd
> -        * page dtor.  This is needed in case someone takes an additional
> -        * temporary ref to the page, and freeing is delayed until they d=
rop
> -        * their reference.
> -        *
> -        * For gigantic pages set the destructor to the null dtor.  This
> -        * destructor will never be called.  Before freeing the gigantic
> -        * page destroy_compound_gigantic_folio will turn the folio into =
a
> -        * simple group of pages.  After this the destructor does not
> -        * apply.
> -        *
> -        * This handles the case where more than one ref is held when and
> -        * after update_and_free_hugetlb_folio is called.
> -        *
> -        * In the case of demote we do not ref count the page as it will =
soon
> -        * be turned into a page of smaller size.
> +        * We can only clear the hugetlb destructor after allocating vmem=
map
> +        * pages.  Otherwise, someone (memory error handling) may try to =
write
> +        * to tail struct pages.
> +        */
> +       if (!folio_test_hugetlb_vmemmap_optimized(folio))
> +               __clear_hugetlb_destructor(h, folio);
> +
> +        /*
> +         * In the case of demote we do not ref count the page as it will=
 soon
> +         * be turned into a page of smaller size.
>          */
>         if (!demote)
>                 folio_ref_unfreeze(folio, 1);
> -       if (hstate_is_gigantic(h))
> -               folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
> -       else
> -               folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
>
>         h->nr_huge_pages--;
>         h->nr_huge_pages_node[nid]--;
> @@ -1705,6 +1721,7 @@ static void __update_and_free_hugetlb_folio(struct =
hstate *h,
>  {
>         int i;
>         struct page *subpage;
> +       bool clear_dtor =3D folio_test_hugetlb_vmemmap_optimized(folio);

Can this test on vmemmap_optimized still tell us if we should
__clear_hugetlb_destructor? From my reading:
1. If a hugetlb folio is still vmemmap optimized in
__remove_hugetlb_folio, __remove_hugetlb_folio won't
__clear_hugetlb_destructor.
2. Then hugetlb_vmemmap_restore in dissolve_free_huge_page will clear
HPG_vmemmap_optimized if it succeeds.
3. Now when dissolve_free_huge_page gets into
__update_and_free_hugetlb_folio, we will see clear_dtor to be false
and __clear_hugetlb_destructor won't be called.

Or maybe I misunderstood, and what you really want to do is never
__clear_hugetlb_destructor so that folio_test_hugetlb is always true?

>
>         if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>                 return;
> @@ -1735,6 +1752,16 @@ static void __update_and_free_hugetlb_folio(struct=
 hstate *h,
>         if (unlikely(folio_test_hwpoison(folio)))
>                 folio_clear_hugetlb_hwpoison(folio);
>
> +       /*
> +        * If vmemmap pages were allocated above, then we need to clear t=
he
> +        * hugetlb destructor under the hugetlb lock.
> +        */
> +       if (clear_dtor) {
> +               spin_lock_irq(&hugetlb_lock);
> +               __clear_hugetlb_destructor(h, folio);
> +               spin_unlock_irq(&hugetlb_lock);
> +       }
> +
>         for (i =3D 0; i < pages_per_huge_page(h); i++) {
>                 subpage =3D folio_page(folio, i);
>                 subpage->flags &=3D ~(1 << PG_locked | 1 << PG_error |
> --
> 2.41.0
>
