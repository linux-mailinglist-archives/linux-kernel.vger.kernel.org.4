Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3DF643AB3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiLFBTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 20:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiLFBTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:19:45 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673536332
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 17:19:44 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q7so21429627wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 17:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4mAE9Cy7oNxJnxpSaA1J9vUhDcN8zWhn+hWYAUaRDNs=;
        b=i0QYamkrJKMytE9MfY7AowXpxy7wFOWk68qiIIBRxQe2+jyEObDajwbmE51yh6dqYv
         iCKt8eG0AdakMaE11jJdJLS7flSlAW0kcB3CUYfSqsWFJierlNoaJkbdSqNij7mavfVu
         eA/sqDWXGGEtWG02EvBvAeDoTtj7PTkH9VpVe4+FqdKDuupUdOwwPwuH3m0+ZIkWTLoz
         XbsWDYFw3TqW3x0sByhT98iqftC1TGp4FEME394vPz6EiNonNMJ750Ziullr9E1Q1APh
         rjZeBFqL7bmW6H2nEcA1YnmgtnypFsK+nS1LYfxPQ6/xaQ6wUTyRWPyzGRFaVGhs8SCw
         jD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mAE9Cy7oNxJnxpSaA1J9vUhDcN8zWhn+hWYAUaRDNs=;
        b=fsZ3aZ5MiRmEQK9i21njrhUiOWTOiv7QwRD+XAi87bNNKX9IjLOpBLsgGd554lz5K+
         otsBH4T5DCeyOc0noUYlaC6WbwvvDFNmmfrEKiGkR9MEGtOs7YHOUkUz62fjDzoqIRTP
         5e5pmWBqV68KbOhJPmj3UEg5kD4ZFxxTdzR3/wy3zYV3Paasp62wg8kt1z7WVVXeJ3S0
         ihW9GxF5qHIaH59p5zfQp0EMSkigEL9HMsb/Bb647UUewwaz5Yed9XDRnXwACW8oDyC/
         PnSGoIatAXjxTSGHdaRgpoaNsaz4Yg/VWxMgIOn5/TPHDLbotxY90YLkrPF+i6Xg/n7h
         1/BQ==
X-Gm-Message-State: ANoB5plZZeETe/tybC4DHvBVRtuOfdrZutESZgqSkmFOyuFQzrXcjbuK
        /HKko9m43vkW0pHizQ3f7v+L3ykxHjyKsvgpYS4=
X-Google-Smtp-Source: AA0mqf4P54W5Fg7yuTZ5ndhW4xSyVPLEEPH1LjBD5etFjsIG9bpuJvwleyrzE2ZBb2JTpfCc8UYz9+/ZbBROy7lnN0g=
X-Received: by 2002:a05:6000:1d8b:b0:242:750a:5b56 with SMTP id
 bk11-20020a0560001d8b00b00242750a5b56mr681537wrb.271.1670289582818; Mon, 05
 Dec 2022 17:19:42 -0800 (PST)
MIME-Version: 1.0
References: <20221205175140.1543229-1-nphamcs@gmail.com> <20221205175140.1543229-3-nphamcs@gmail.com>
 <CAOUHufZKTqoD2rFwrX9-eCknBmeWqP88rZ7X7A_5KHHbGBUP=A@mail.gmail.com>
In-Reply-To: <CAOUHufZKTqoD2rFwrX9-eCknBmeWqP88rZ7X7A_5KHHbGBUP=A@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 5 Dec 2022 17:19:31 -0800
Message-ID: <CAKEwX=N+mHBqey+E2d=4NpMrTTi8YYkVvJ-bEAnrG1Uqmjq_Yg@mail.gmail.com>
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

On Mon, Dec 5, 2022 at 3:49 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Dec 5, 2022 at 10:51 AM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > In preparation for computing recently evicted pages in cachestat,
> > refactor workingset_refault and lru_gen_refault to expose a helper
> > function that would test if an evicted page is recently evicted.
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  include/linux/swap.h |   1 +
> >  mm/workingset.c      | 143 +++++++++++++++++++++++++++++--------------
> >  2 files changed, 99 insertions(+), 45 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index a18cf4b7c724..dae6f6f955eb 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -361,6 +361,7 @@ static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
> >  }
> >
> >  /* linux/mm/workingset.c */
> > +bool workingset_test_recent(void *shadow, bool file, bool *workingset);
> >  void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
> >  void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
> >  void workingset_refault(struct folio *folio, void *shadow);
> > diff --git a/mm/workingset.c b/mm/workingset.c
> > index 79585d55c45d..44b331ce3040 100644
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -244,6 +244,30 @@ static void *lru_gen_eviction(struct folio *folio)
> >         return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
> >  }
> >
> > +/*
> > + * Test if the folio is recently evicted.
> > + *
> > + * As a side effect, also populates the references with
> > + * values unpacked from the shadow of the evicted folio.
> > + */
> > +static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> > +       struct pglist_data **pgdat, unsigned long *token, bool *workingset)
> > +{
> > +       struct mem_cgroup *eviction_memcg;
> > +       struct lruvec *lruvec;
> > +       struct lru_gen_struct *lrugen;
> > +       unsigned long min_seq;
> > +
> > +       unpack_shadow(shadow, memcgid, pgdat, token, workingset);
> > +       eviction_memcg = mem_cgroup_from_id(*memcgid);
> > +
> > +       lruvec = mem_cgroup_lruvec(eviction_memcg, *pgdat);
> > +       lrugen = &lruvec->lrugen;
> > +
> > +       min_seq = READ_ONCE(lrugen->min_seq[file]);
> > +       return !((*token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)));
> > +}
>
> Nit: not refactoring actually looks cleaner to me -- there are only a
> few lines of duplicated code and you can get rid of 4 parameters
> including the unused workingset in the next patch.

(resending this because I forgot to forward to the rest of the
group!)

Thanks for the comment, Yu!

Personally, I prefer refactoring this piece of logic - I do think that
it is cleaner than copying the logic into the syscall implementation.
I believe that if I don't do the refactoring, I'll have to repeat the
unused parameters in the syscall, and make unpack_shadow
a non-static function (along with all the locally defined macros like
WORKINGSET_SHIFT). I think it would get quite messy there too.

But more importantly, I'm a bit concerned that the logic for
determining the recency of the eviction might change in the
future, which would break the cachestat syscall unknowingly...

Let me know what you think about this, Yu!
