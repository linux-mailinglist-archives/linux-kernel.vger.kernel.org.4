Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9402643B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 03:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiLFC0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLFC02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:26:28 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FEE1B9D8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:26:26 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id k185so12943994vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 18:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hdjfrrxtP9xiGB9sAYuCv9FJ5prKvsWKlbLWo8hywZk=;
        b=rFudDs4ghfzBxbrDDIPjfBamw4oCPgAV9f2T2ysykHhbtl7xlYErKn042CJj3e/C7Y
         RkzF7fWHAa0JoZKvQbb3pJJjxSwibbfnAhyj5zCC1ghH0eKdN4c9IKI/tp0GEl6bDL+z
         cWCXVcBX4LNgkVK21EZVmlMW+kpSHkIUwS7ZfqehQQC5MHSPlYSDHiEIGFJN0WoH0uJt
         y/y4/fYAhwnzRnAeN/Ri2Wu0WEm/em6nn8s3J0NmpboI+f3SyAY+T2WtyReflppAQT2d
         ZJEa+LOQGxlwafQ8f9V9LUqOJV3Hv+2IzAoMCHJRSzEvJEOJ4i66tGScEmyWnZq9QfXf
         BZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdjfrrxtP9xiGB9sAYuCv9FJ5prKvsWKlbLWo8hywZk=;
        b=GhV7wNzqW1TYrmOwe3rtkx2TUrt5orj79HvR+mGTdSjnOGmzBwz2M1rgY1KUCxXRmu
         LcGSIRFveijPmo3ADbsoHYw+ouuy+YqMUNozCnUkFaIKvkwK4hRzTakXCtzDi6URNHKI
         r7W895tmRmePjnY/czwDq9o706A7beFeHsxQHRJ+Yl6IvfkfJ2+Ez0EFhDAJfO5S1EKc
         yxmlBxYHsZ18KJjupdBzarHIzqmRMlkaQC0ZwZa1usuyBVKRuKYtG7efmxkpsez7Q9AO
         5lh2MWY9RifOq9QQ714FzhKso+vxIr/HeT1wmLSvsmoyt6SG7X7XiBYA0dZhvXNq/iSA
         SvXw==
X-Gm-Message-State: ANoB5plEbFTjjzXt2BAiKWS4KYk6W605AEBhPtGxzO0Jx7t1zxZkm3q6
        vnq4Rg2IT5Qr3rGM2OrhskkslGd0LfhB4l8ElZCn1Q==
X-Google-Smtp-Source: AA0mqf4dMxjD2xVUW+vJG45m0GKek5Tavy/kzCRTDt4WgkzUSop7V8KvOixu0hG8WB3T39+NySDNeippx4ybT44fRZg=
X-Received: by 2002:a67:c98e:0:b0:3ad:3d65:22b with SMTP id
 y14-20020a67c98e000000b003ad3d65022bmr38798394vsk.65.1670293585855; Mon, 05
 Dec 2022 18:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20221205175140.1543229-1-nphamcs@gmail.com> <20221205175140.1543229-3-nphamcs@gmail.com>
 <CAOUHufZKTqoD2rFwrX9-eCknBmeWqP88rZ7X7A_5KHHbGBUP=A@mail.gmail.com>
 <CAKEwX=N+mHBqey+E2d=4NpMrTTi8YYkVvJ-bEAnrG1Uqmjq_Yg@mail.gmail.com>
 <CAOUHufZZX9TyTbZCbmOt9FeyNYxoDwVPOkM0=t3Nyz2ZtP-s7A@mail.gmail.com> <CAKEwX=P=ypLfqmJYKP1BWYzjpMUMWGg4v=DfjnO5hR_qhQUmUQ@mail.gmail.com>
In-Reply-To: <CAKEwX=P=ypLfqmJYKP1BWYzjpMUMWGg4v=DfjnO5hR_qhQUmUQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 5 Dec 2022 19:25:49 -0700
Message-ID: <CAOUHufZ6vehkF5CN-SvgKGmsTCVUgXHmZe4=sOojdQ5Qd9jb+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] workingset: refactor LRU refault to expose refault
 recency check
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
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

On Mon, Dec 5, 2022 at 7:22 PM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Mon, Dec 5, 2022 at 5:29 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Mon, Dec 5, 2022 at 6:19 PM Nhat Pham <nphamcs@gmail.com> wrote:
> > >
> > > On Mon, Dec 5, 2022 at 3:49 PM Yu Zhao <yuzhao@google.com> wrote:
> > > >
> > > > On Mon, Dec 5, 2022 at 10:51 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > > > >
> > > > > In preparation for computing recently evicted pages in cachestat,
> > > > > refactor workingset_refault and lru_gen_refault to expose a helper
> > > > > function that would test if an evicted page is recently evicted.
> > > > >
> > > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > > ---
> > > > >  include/linux/swap.h |   1 +
> > > > >  mm/workingset.c      | 143 +++++++++++++++++++++++++++++--------------
> > > > >  2 files changed, 99 insertions(+), 45 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > > > index a18cf4b7c724..dae6f6f955eb 100644
> > > > > --- a/include/linux/swap.h
> > > > > +++ b/include/linux/swap.h
> > > > > @@ -361,6 +361,7 @@ static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
> > > > >  }
> > > > >
> > > > >  /* linux/mm/workingset.c */
> > > > > +bool workingset_test_recent(void *shadow, bool file, bool *workingset);
> > > > >  void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
> > > > >  void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
> > > > >  void workingset_refault(struct folio *folio, void *shadow);
> > > > > diff --git a/mm/workingset.c b/mm/workingset.c
> > > > > index 79585d55c45d..44b331ce3040 100644
> > > > > --- a/mm/workingset.c
> > > > > +++ b/mm/workingset.c
> > > > > @@ -244,6 +244,30 @@ static void *lru_gen_eviction(struct folio *folio)
> > > > >         return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * Test if the folio is recently evicted.
> > > > > + *
> > > > > + * As a side effect, also populates the references with
> > > > > + * values unpacked from the shadow of the evicted folio.
> > > > > + */
> > > > > +static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> > > > > +       struct pglist_data **pgdat, unsigned long *token, bool *workingset)
> > > > > +{
> > > > > +       struct mem_cgroup *eviction_memcg;
> > > > > +       struct lruvec *lruvec;
> > > > > +       struct lru_gen_struct *lrugen;
> > > > > +       unsigned long min_seq;
> > > > > +
> > > > > +       unpack_shadow(shadow, memcgid, pgdat, token, workingset);
> > > > > +       eviction_memcg = mem_cgroup_from_id(*memcgid);
> > > > > +
> > > > > +       lruvec = mem_cgroup_lruvec(eviction_memcg, *pgdat);
> > > > > +       lrugen = &lruvec->lrugen;
> > > > > +
> > > > > +       min_seq = READ_ONCE(lrugen->min_seq[file]);
> > > > > +       return !((*token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)));
> > > > > +}
> > > >
> > > > Nit: not refactoring actually looks cleaner to me -- there are only a
> > > > few lines of duplicated code and you can get rid of 4 parameters
> > > > including the unused workingset in the next patch.
> > >
> > > (resending this because I forgot to forward to the rest of the
> > > group!)
> > >
> > > Thanks for the comment, Yu!
> > >
> > > Personally, I prefer refactoring this piece of logic - I do think that
> > > it is cleaner than copying the logic into the syscall implementation.
> >
> > Let me clarify.
> >
> > You can add
> >   lru_gen_test_recent(void *shadow, bool file)
> > without refactoring the existing
> >   lru_gen_refault().
> >
> > Set the boilerplate aside, you only repeat one line of code, which is
> > the last line in the new function.
> >
> > (The boilerplate code is repeated in many places, and that's why it's
> > called boilerplate.)
>
> Oh maybe I've misunderstood your original comment. Your
> suggestion is to repeat the eviction recency check in workingset.c
> (i.e keep the *_gen_refault unchanged - just copy that logic to
> *_test_recent)?

Correct.
