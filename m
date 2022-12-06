Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61125643B49
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 03:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiLFCW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiLFCWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:22:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB6425295
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:22:24 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d1so21514990wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 18:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KeehAapm7ZXRZtRJIFZHdeIO9R9klFHDW166tK18b2A=;
        b=dbIpZ/GO5LIsCEE5CILRjO56Zfii5s9R4pXrRGRZFoiV88SQ11KOM4GkYhLbWalPS7
         48vGdxyoMLUbwQe58AvBpuV7U/cbYY8lNwJ6/Dntibzv24BBM/3TiC3sJwB1NRIwYr9I
         kcE2x9Az35xvFv7zaXvA3z+E2W/FMiyOQ9t0C/a2BEEHgCBhc63hBlVfNct6gtx7aFaB
         9WeN/4FKISvaZqrwB/4yKK7dKByBHPFf04oI9eFsuHeZ3PIIK5J3tI0sPUntFM7JnBKV
         IoDmrN2CYsvxYS9ro/G1oqMAhAPbd/OE65WQNVWUT6li3GnL+wjmnQfwA+eT2O9inOZW
         k/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeehAapm7ZXRZtRJIFZHdeIO9R9klFHDW166tK18b2A=;
        b=srhL2ak16t095rab+yX8mBmf2IIYM/GSpSLmgAWXx1ie5bfjbdfB7X0wLtaulZEaQu
         ikUsU2Inxk2pe7aMb7wz6ucxVLqnOqGRgsJBbWOeRDhtkz+O3IIVs73odSXGwPUl+x6F
         amBHin7RaRg4YYU+nJZtq+FpfP85nZtJ3P6GaxT0gnDl8kLy2YqlRHUepgOSNlX4HLPz
         O5sj/n5EwMmWa7qRQ4sDSPFCL7REbS6DuxKwVhXU+QN9xsJ7sdTXMMooiIrd9RW5tNDG
         g4/raxd52mstVmDYQkmetGe/0Z1VY7Tn0z6reaRMkWLaWlrEnZ15n4oGOvVVsvKIcCew
         cfaQ==
X-Gm-Message-State: ANoB5pnm23dp652CpKaiMt75wHxdXsxAjpRA+ihlx45LJIY1wDborfA5
        i3in167NsXgPE/8z/yeZ/MEycICMFxj9+1Ii7fU=
X-Google-Smtp-Source: AA0mqf7vpcGqDj6nmQ8qCTCoSPvin2kOTea5QbVRb0OgJKW/g8n2r3V3e6cD2O5brfqrJFcvQilU23ygJBvMbnFET8E=
X-Received: by 2002:a5d:4b45:0:b0:242:1ade:1145 with SMTP id
 w5-20020a5d4b45000000b002421ade1145mr22524441wrs.483.1670293342943; Mon, 05
 Dec 2022 18:22:22 -0800 (PST)
MIME-Version: 1.0
References: <20221205175140.1543229-1-nphamcs@gmail.com> <20221205175140.1543229-3-nphamcs@gmail.com>
 <CAOUHufZKTqoD2rFwrX9-eCknBmeWqP88rZ7X7A_5KHHbGBUP=A@mail.gmail.com>
 <CAKEwX=N+mHBqey+E2d=4NpMrTTi8YYkVvJ-bEAnrG1Uqmjq_Yg@mail.gmail.com> <CAOUHufZZX9TyTbZCbmOt9FeyNYxoDwVPOkM0=t3Nyz2ZtP-s7A@mail.gmail.com>
In-Reply-To: <CAOUHufZZX9TyTbZCbmOt9FeyNYxoDwVPOkM0=t3Nyz2ZtP-s7A@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 5 Dec 2022 18:22:11 -0800
Message-ID: <CAKEwX=P=ypLfqmJYKP1BWYzjpMUMWGg4v=DfjnO5hR_qhQUmUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] workingset: refactor LRU refault to expose refault
 recency check
To:     Yu Zhao <yuzhao@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 5:29 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Dec 5, 2022 at 6:19 PM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > On Mon, Dec 5, 2022 at 3:49 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > On Mon, Dec 5, 2022 at 10:51 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > > >
> > > > In preparation for computing recently evicted pages in cachestat,
> > > > refactor workingset_refault and lru_gen_refault to expose a helper
> > > > function that would test if an evicted page is recently evicted.
> > > >
> > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > ---
> > > >  include/linux/swap.h |   1 +
> > > >  mm/workingset.c      | 143 +++++++++++++++++++++++++++++--------------
> > > >  2 files changed, 99 insertions(+), 45 deletions(-)
> > > >
> > > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > > index a18cf4b7c724..dae6f6f955eb 100644
> > > > --- a/include/linux/swap.h
> > > > +++ b/include/linux/swap.h
> > > > @@ -361,6 +361,7 @@ static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
> > > >  }
> > > >
> > > >  /* linux/mm/workingset.c */
> > > > +bool workingset_test_recent(void *shadow, bool file, bool *workingset);
> > > >  void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
> > > >  void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
> > > >  void workingset_refault(struct folio *folio, void *shadow);
> > > > diff --git a/mm/workingset.c b/mm/workingset.c
> > > > index 79585d55c45d..44b331ce3040 100644
> > > > --- a/mm/workingset.c
> > > > +++ b/mm/workingset.c
> > > > @@ -244,6 +244,30 @@ static void *lru_gen_eviction(struct folio *folio)
> > > >         return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
> > > >  }
> > > >
> > > > +/*
> > > > + * Test if the folio is recently evicted.
> > > > + *
> > > > + * As a side effect, also populates the references with
> > > > + * values unpacked from the shadow of the evicted folio.
> > > > + */
> > > > +static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> > > > +       struct pglist_data **pgdat, unsigned long *token, bool *workingset)
> > > > +{
> > > > +       struct mem_cgroup *eviction_memcg;
> > > > +       struct lruvec *lruvec;
> > > > +       struct lru_gen_struct *lrugen;
> > > > +       unsigned long min_seq;
> > > > +
> > > > +       unpack_shadow(shadow, memcgid, pgdat, token, workingset);
> > > > +       eviction_memcg = mem_cgroup_from_id(*memcgid);
> > > > +
> > > > +       lruvec = mem_cgroup_lruvec(eviction_memcg, *pgdat);
> > > > +       lrugen = &lruvec->lrugen;
> > > > +
> > > > +       min_seq = READ_ONCE(lrugen->min_seq[file]);
> > > > +       return !((*token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)));
> > > > +}
> > >
> > > Nit: not refactoring actually looks cleaner to me -- there are only a
> > > few lines of duplicated code and you can get rid of 4 parameters
> > > including the unused workingset in the next patch.
> >
> > (resending this because I forgot to forward to the rest of the
> > group!)
> >
> > Thanks for the comment, Yu!
> >
> > Personally, I prefer refactoring this piece of logic - I do think that
> > it is cleaner than copying the logic into the syscall implementation.
>
> Let me clarify.
>
> You can add
>   lru_gen_test_recent(void *shadow, bool file)
> without refactoring the existing
>   lru_gen_refault().
>
> Set the boilerplate aside, you only repeat one line of code, which is
> the last line in the new function.
>
> (The boilerplate code is repeated in many places, and that's why it's
> called boilerplate.)

Oh maybe I've misunderstood your original comment. Your
suggestion is to repeat the eviction recency check in workingset.c
(i.e keep the *_gen_refault unchanged - just copy that logic to
*_test_recent)?
