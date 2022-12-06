Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB4643ABD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiLFB3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 20:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiLFB3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:29:10 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769571EC6F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 17:29:08 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id v4so4510010ual.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 17:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pSDhDqOudVpfHmVoymf2tIcEElKGOfpGSM98qvPhOzI=;
        b=TdeU6qpgv5peqyVsBJhLUvZJvLuXvVK/AE9Ue6gk8DvQWSafztvlow4ohux0JQWHOm
         Dfjhq3nITLPlKvATxZbufa5m0JgRhj1w77D7ope4tYypzgJev4e6PiZbKeH2dKSJRPC1
         Cxy71OyarL2lcpSkUjjvStploQC8AZZqpsMsYBZ+HxofhT5UDe7AcXif+JdX+aEn4I9Z
         8fmr/uoSOWKAqILq2M2sYX8kSsz2pfMOPGueqxKopbl4cLqwlJ+whwxoTmBYBXySFzG5
         vYdvy8EOGfYgRlskfcmqMNzL/SwYaqrBJkUjDc6fhdNEz3iyE710lpjNEG9G+9ppR34A
         wUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSDhDqOudVpfHmVoymf2tIcEElKGOfpGSM98qvPhOzI=;
        b=acWp5LvD33lf88pN4cmNGBJAHKQ8vIAeFy2rtMbXnznfbEnZrf9SG3Zw6xxyc+7yVu
         LWT4kkNZS3sL5D86UveoDM+Lm6VlD1e99IVC0T/wQJ6EHG+YJNkI+AUGo0bO1EVIIZVO
         kth7DIQAaeNAqvVvHWvr8QZUDTA8Ld9YdcRlI7Pxcohck27qSCDbtZGRIrwj21PWLjrq
         JkoFewiMantPRq6oleIn0tu9gyS6DFOEjOsIfvMnFzPknzNJ7ht2Y5321eyRzQZsaF4j
         GEC7vo8VHMfoPcqbESQeVCDD4bccCixR7zxtpQvTAGtu1tiewfGk7n/veKyplwZXjjGB
         zsOg==
X-Gm-Message-State: ANoB5pmvQ5TxEcVpiJv2K1S6tyf2UPaJdrty9t9xJyjYyd7wXJr1G0mj
        OqZeMJDAzWRs7bFrBbfBbyFDGi0o1bbnYv1vzGZ/Dg==
X-Google-Smtp-Source: AA0mqf6zhsb8ptPE9bRgCtcTDeQeR35GW+Hd02TEKsTRcWZ4+gCd8Srr097Kknn287pti4r/o9sNTOnzTe6BQAvDRuA=
X-Received: by 2002:ab0:6f52:0:b0:419:1fa3:9618 with SMTP id
 r18-20020ab06f52000000b004191fa39618mr23490504uat.11.1670290147298; Mon, 05
 Dec 2022 17:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20221205175140.1543229-1-nphamcs@gmail.com> <20221205175140.1543229-3-nphamcs@gmail.com>
 <CAOUHufZKTqoD2rFwrX9-eCknBmeWqP88rZ7X7A_5KHHbGBUP=A@mail.gmail.com> <CAKEwX=N+mHBqey+E2d=4NpMrTTi8YYkVvJ-bEAnrG1Uqmjq_Yg@mail.gmail.com>
In-Reply-To: <CAKEwX=N+mHBqey+E2d=4NpMrTTi8YYkVvJ-bEAnrG1Uqmjq_Yg@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 5 Dec 2022 18:28:31 -0700
Message-ID: <CAOUHufZZX9TyTbZCbmOt9FeyNYxoDwVPOkM0=t3Nyz2ZtP-s7A@mail.gmail.com>
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

On Mon, Dec 5, 2022 at 6:19 PM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Mon, Dec 5, 2022 at 3:49 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Mon, Dec 5, 2022 at 10:51 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > >
> > > In preparation for computing recently evicted pages in cachestat,
> > > refactor workingset_refault and lru_gen_refault to expose a helper
> > > function that would test if an evicted page is recently evicted.
> > >
> > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > ---
> > >  include/linux/swap.h |   1 +
> > >  mm/workingset.c      | 143 +++++++++++++++++++++++++++++--------------
> > >  2 files changed, 99 insertions(+), 45 deletions(-)
> > >
> > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > index a18cf4b7c724..dae6f6f955eb 100644
> > > --- a/include/linux/swap.h
> > > +++ b/include/linux/swap.h
> > > @@ -361,6 +361,7 @@ static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
> > >  }
> > >
> > >  /* linux/mm/workingset.c */
> > > +bool workingset_test_recent(void *shadow, bool file, bool *workingset);
> > >  void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
> > >  void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
> > >  void workingset_refault(struct folio *folio, void *shadow);
> > > diff --git a/mm/workingset.c b/mm/workingset.c
> > > index 79585d55c45d..44b331ce3040 100644
> > > --- a/mm/workingset.c
> > > +++ b/mm/workingset.c
> > > @@ -244,6 +244,30 @@ static void *lru_gen_eviction(struct folio *folio)
> > >         return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
> > >  }
> > >
> > > +/*
> > > + * Test if the folio is recently evicted.
> > > + *
> > > + * As a side effect, also populates the references with
> > > + * values unpacked from the shadow of the evicted folio.
> > > + */
> > > +static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> > > +       struct pglist_data **pgdat, unsigned long *token, bool *workingset)
> > > +{
> > > +       struct mem_cgroup *eviction_memcg;
> > > +       struct lruvec *lruvec;
> > > +       struct lru_gen_struct *lrugen;
> > > +       unsigned long min_seq;
> > > +
> > > +       unpack_shadow(shadow, memcgid, pgdat, token, workingset);
> > > +       eviction_memcg = mem_cgroup_from_id(*memcgid);
> > > +
> > > +       lruvec = mem_cgroup_lruvec(eviction_memcg, *pgdat);
> > > +       lrugen = &lruvec->lrugen;
> > > +
> > > +       min_seq = READ_ONCE(lrugen->min_seq[file]);
> > > +       return !((*token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)));
> > > +}
> >
> > Nit: not refactoring actually looks cleaner to me -- there are only a
> > few lines of duplicated code and you can get rid of 4 parameters
> > including the unused workingset in the next patch.
>
> (resending this because I forgot to forward to the rest of the
> group!)
>
> Thanks for the comment, Yu!
>
> Personally, I prefer refactoring this piece of logic - I do think that
> it is cleaner than copying the logic into the syscall implementation.

Let me clarify.

You can add
  lru_gen_test_recent(void *shadow, bool file)
without refactoring the existing
  lru_gen_refault().

Set the boilerplate aside, you only repeat one line of code, which is
the last line in the new function.

(The boilerplate code is repeated in many places, and that's why it's
called boilerplate.)

> I believe that if I don't do the refactoring, I'll have to repeat the
> unused parameters in the syscall, and make unpack_shadow
> a non-static function (along with all the locally defined macros like
> WORKINGSET_SHIFT). I think it would get quite messy there too.
>
> But more importantly, I'm a bit concerned that the logic for
> determining the recency of the eviction might change in the
> future, which would break the cachestat syscall unknowingly...
>
> Let me know what you think about this, Yu!

Your call :)
