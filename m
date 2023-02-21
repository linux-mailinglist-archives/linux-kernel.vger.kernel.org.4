Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8942469E419
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjBUQAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjBUQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:00:35 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AEE1DB98
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:00:34 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id e5so5596018vsl.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEGsGmTzHdzT9knfoHKHRGvhNUMsGTlXEeNMDOHsjGc=;
        b=ZyCVXGpI7+v5rkLMYZIW9t2A0sb5StXS66ZGe3cubmw41jnMmgqMg5nK+9qNgVZnKl
         g9hcY039uN6jzrvDD3h2cbUjzryCjNsf6ZFjEtJ09Q3q3NcCYk2XGB7GJBmsasszuleF
         3LZSHl6OlnOZTrThG6VVIYsiO6NAfHzyuDYq1VdjvoQUeDMicr/kIph7+bqAfZ5yZOVT
         KKUj1SrL5QbW9/GGRhEeTRWX608JPKslol+S7IpoZ9YW98Z/FrHO7C8g5PsRBUcKfuQz
         lcAVpgHzYKzk/+EuFxLuL5cgEg/Lg+4SBv5zCC7XiSaoE+ne4YM+O8wltoxS+xCWYHCR
         5oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEGsGmTzHdzT9knfoHKHRGvhNUMsGTlXEeNMDOHsjGc=;
        b=HquCWFWvLMeJqET6NO7eL1Cs/Bo/V9+P56sbESTsiUt2g4HS4bbajvL/a3ZPXEp96/
         zZbtCelo4fVpEE1Fma2u//UtfO3vKGqN2f0Tx6nad89CL/DdiMxm1EHiYec3f1R4gJBz
         ZLesTooYYAWzeJpNEGDTO+jQ5iBkwA1aQt9XFNCoZbjmB6D1GkPS5/Xfn51+IGdxQcNi
         hc+t3UpMfMiYXnUxWaEdYm9rS5noqRbRAgk0b05bd+2ywBu9BLhN7QiK2Min8L/efUsO
         jZFaYOEVEf2MeaO5NaFHAceN2N82z6DUKdYdHC1q2+dgKKyLHb4RYA7MK+CMhx8y1Gd2
         LGCg==
X-Gm-Message-State: AO0yUKW0LI20x9Ak26S1NYmS138hyYZ4isM7iu15yhkuCfCiXO8FT5EW
        3cGvE0iojY3jU5oQranANHHBLz0wmg1qZ7SBBDueqg==
X-Google-Smtp-Source: AK7set96mNcnHjcj9pZjuGPPdOQ+l30zoQUNRCrKVvvkxSlowK5hHK5inugxItL4+VkeVb740A1gSax4vCrdZPv0fRo=
X-Received: by 2002:a67:dc81:0:b0:41b:ed91:4d51 with SMTP id
 g1-20020a67dc81000000b0041bed914d51mr1364819vsk.84.1676995233019; Tue, 21 Feb
 2023 08:00:33 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-2-jthoughton@google.com> <CAHS8izM5Es+DMiOyPt93o6Xw+SeuOR45r+MMoeagiYN594NiyQ@mail.gmail.com>
In-Reply-To: <CAHS8izM5Es+DMiOyPt93o6Xw+SeuOR45r+MMoeagiYN594NiyQ@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 21 Feb 2023 07:59:56 -0800
Message-ID: <CADrL8HWTe1b2UK4Ha6e=F_i+YSK_M4wXCQ-sxvYMkgR1EgaHpA@mail.gmail.com>
Subject: Re: [PATCH v2 01/46] hugetlb: don't set PageUptodate for UFFDIO_CONTINUE
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Feb 17, 2023 at 4:42 PM Mina Almasry <almasrymina@google.com> wrote=
:
>
> On Fri, Feb 17, 2023 at 4:28=E2=80=AFPM James Houghton <jthoughton@google=
.com> wrote:
> >
> > If would be bad if we actually set PageUptodate with UFFDIO_CONTINUE;
> > PageUptodate indicates that the page has been zeroed, and we don't want
> > to give a non-zeroed page to the user.
> >
> > The reason this change is being made now is because UFFDIO_CONTINUEs on
> > subpages definitely shouldn't set this page flag on the head page.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 07abcb6eb203..792cb2e67ce5 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6256,7 +6256,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *d=
st_mm,
> >          * preceding stores to the page contents become visible before
> >          * the set_pte_at() write.
> >          */
> > -       __folio_mark_uptodate(folio);
> > +       if (!is_continue)
> > +               __folio_mark_uptodate(folio);
> > +       else if (!folio_test_uptodate(folio)) {
> > +               /*
> > +                * This should never happen; HugeTLB pages are always U=
ptodate
> > +                * as soon as they are allocated.
> > +                */
>
> if (is_continue) then we grab a page from the page cache, no? Are
> pages in page caches always uptodate? Why? I guess that means they're
> mapped hence uptodate?
>
> Also this comment should explain why pages in the page cache are
> always uptodate, no? Because this error branch is hit if (is_continue
> && !folio_test_uptodate()), not when pages are freshly allocated.

There was some discussion about it here[1].

Without even thinking about how the pages become uptodate, I think
this patch is justified like this: UFFDIO_CONTINUE =3D> we aren't
actually changing the contents of the page, so we shouldn't be
changing the uptodate-ness of the page.

HugeTLB pages in the page cache are always uptodate:
1. fallocate -- the page is allocated, zeroed, marked as uptodate, and
then placed in the page cache.
2. hugetlb_no_page -- same as above.

So uptodate <=3D> "the page has been zeroed", so it would be very bad if
we gave a !uptodate page to userspace via UFFDIO_CONTINUE.

I'll update the comment to something like:

"HugeTLB pages are always Uptodate as soon as they are added to the
page cache. Given that we aren't changing the contents of the page, we
shouldn't be updating the Uptodate-ness of the page."

[1]: https://lore.kernel.org/linux-mm/Y5JrS4o5Detzid9V@monkey/

Thanks, Mina. :)

- James
