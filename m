Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1330647556
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiLHSIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHSIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:08:05 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8140836C4F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:08:02 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u12so2567666wrr.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 10:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TT+Voc8metN7pfdLgSuHhsI+ICrLJs1/K9Jt2tVGNSc=;
        b=fKAHAf0TzQnaeEWXQZb82rftHD1haj/5raCbmX4mH3M4z4i9I2mEXWBdoMOthflr2O
         Qu1/5LaUH1PdJbT0soPGXjZq0gvC+JCkv2e8U4JB3+9M5XHssvK+7gUMuOd672CsppRL
         8atXZy8SJTvwUAEJPSz1KOQhzk//HP65ATDPxrHLqv/hGzQ9cXhYsfUISV1+rTpW40Gy
         pyRNuZwQp2qr/e17yW1/byAZfOn4DsOfxT2N2CALp4V1aEVZYEYy8uONsqbv5XrziKMe
         hRqLlpdkv/YZozg1xudnU+rlDhUGfbwqb8RAkJ9kg3C40bZ31kgFjGtvKFzGKBfrociU
         fg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TT+Voc8metN7pfdLgSuHhsI+ICrLJs1/K9Jt2tVGNSc=;
        b=aPKG8NpxEUhO/Al3RYKaQJnAeBCo1k2WwsTq/UDgi7cDJ2HXftYB2CZK1alwFcvWQz
         FM0cszKTUSE7K8dNYOwZXzxUj4ndcIqMbdxtJ094/+55od6xc+xVTYCU5TLCk8L6sY9c
         q4blWso9XA1O/zRx+0IPkUQlNYyskBqZzfnQKtWSXAmjFcYgjHNzRWqBx0uitmNKWp/s
         6po4hHujYw1LQtB8kk1aWxHbKLpwT2F/NSyFiR3fSWheLhE/skZrbf0zPnGr9G5U8VkV
         FeKG8OL36gG+qaIXbOGw0jZdUwvMzEaHEtI0vxbSUG76TVCcIYuwuMQKHiC0jQyAo4zJ
         v68w==
X-Gm-Message-State: ANoB5pmlA9vn05ZeF5wVivpBUkjs+VZX3ifJ14QFFBhGiilaAfsf/1aC
        AM4h7bXH7o2Vi4TkAtJRapcGvaHv5ziYK8QktHo=
X-Google-Smtp-Source: AA0mqf7MQtXUXyDy/9IOtmVh7ixnBHksG/E6FoGBme+KKN2Jmd9b62NpV4CZw+oBME1SnbH3f1UqxpnAJysSQDntSuk=
X-Received: by 2002:a05:6000:1084:b0:241:f866:6bc8 with SMTP id
 y4-20020a056000108400b00241f8666bc8mr38140489wrw.501.1670522881019; Thu, 08
 Dec 2022 10:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20221205175140.1543229-1-nphamcs@gmail.com> <20221205175140.1543229-3-nphamcs@gmail.com>
 <CAOUHufZKTqoD2rFwrX9-eCknBmeWqP88rZ7X7A_5KHHbGBUP=A@mail.gmail.com>
 <CAKEwX=N+mHBqey+E2d=4NpMrTTi8YYkVvJ-bEAnrG1Uqmjq_Yg@mail.gmail.com>
 <CAOUHufZZX9TyTbZCbmOt9FeyNYxoDwVPOkM0=t3Nyz2ZtP-s7A@mail.gmail.com>
 <CAKEwX=P=ypLfqmJYKP1BWYzjpMUMWGg4v=DfjnO5hR_qhQUmUQ@mail.gmail.com> <CAOUHufZ6vehkF5CN-SvgKGmsTCVUgXHmZe4=sOojdQ5Qd9jb+g@mail.gmail.com>
In-Reply-To: <CAOUHufZ6vehkF5CN-SvgKGmsTCVUgXHmZe4=sOojdQ5Qd9jb+g@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 8 Dec 2022 10:07:49 -0800
Message-ID: <CAKEwX=NwbtFeVyL+J+d8hLeRhoBgfhof+w9_heN++J09XToxCg@mail.gmail.com>
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

On Mon, Dec 5, 2022 at 6:26 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Dec 5, 2022 at 7:22 PM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > On Mon, Dec 5, 2022 at 5:29 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > On Mon, Dec 5, 2022 at 6:19 PM Nhat Pham <nphamcs@gmail.com> wrote:
> > > >
> > > > On Mon, Dec 5, 2022 at 3:49 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > >
> > > > > On Mon, Dec 5, 2022 at 10:51 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > > > > >
> > > > > > In preparation for computing recently evicted pages in cachestat,
> > > > > > refactor workingset_refault and lru_gen_refault to expose a helper
> > > > > > function that would test if an evicted page is recently evicted.
> > > > > >
> > > > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > > > ---
> > > > > >  include/linux/swap.h |   1 +
> > > > > >  mm/workingset.c      | 143 +++++++++++++++++++++++++++++--------------
> > > > > >  2 files changed, 99 insertions(+), 45 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > > > > index a18cf4b7c724..dae6f6f955eb 100644
> > > > > > --- a/include/linux/swap.h
> > > > > > +++ b/include/linux/swap.h
> > > > > > @@ -361,6 +361,7 @@ static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
> > > > > >  }
> > > > > >
> > > > > >  /* linux/mm/workingset.c */
> > > > > > +bool workingset_test_recent(void *shadow, bool file, bool *workingset);
> > > > > >  void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
> > > > > >  void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
> > > > > >  void workingset_refault(struct folio *folio, void *shadow);
> > > > > > diff --git a/mm/workingset.c b/mm/workingset.c
> > > > > > index 79585d55c45d..44b331ce3040 100644
> > > > > > --- a/mm/workingset.c
> > > > > > +++ b/mm/workingset.c
> > > > > > @@ -244,6 +244,30 @@ static void *lru_gen_eviction(struct folio *folio)
> > > > > >         return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
> > > > > >  }
> > > > > >
> > > > > > +/*
> > > > > > + * Test if the folio is recently evicted.
> > > > > > + *
> > > > > > + * As a side effect, also populates the references with
> > > > > > + * values unpacked from the shadow of the evicted folio.
> > > > > > + */
> > > > > > +static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> > > > > > +       struct pglist_data **pgdat, unsigned long *token, bool *workingset)
> > > > > > +{
> > > > > > +       struct mem_cgroup *eviction_memcg;
> > > > > > +       struct lruvec *lruvec;
> > > > > > +       struct lru_gen_struct *lrugen;
> > > > > > +       unsigned long min_seq;
> > > > > > +
> > > > > > +       unpack_shadow(shadow, memcgid, pgdat, token, workingset);
> > > > > > +       eviction_memcg = mem_cgroup_from_id(*memcgid);
> > > > > > +
> > > > > > +       lruvec = mem_cgroup_lruvec(eviction_memcg, *pgdat);
> > > > > > +       lrugen = &lruvec->lrugen;
> > > > > > +
> > > > > > +       min_seq = READ_ONCE(lrugen->min_seq[file]);
> > > > > > +       return !((*token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)));
> > > > > > +}
> > > > >
> > > > > Nit: not refactoring actually looks cleaner to me -- there are only a
> > > > > few lines of duplicated code and you can get rid of 4 parameters
> > > > > including the unused workingset in the next patch.
> > > >
> > > > (resending this because I forgot to forward to the rest of the
> > > > group!)
> > > >
> > > > Thanks for the comment, Yu!
> > > >
> > > > Personally, I prefer refactoring this piece of logic - I do think that
> > > > it is cleaner than copying the logic into the syscall implementation.
> > >
> > > Let me clarify.
> > >
> > > You can add
> > >   lru_gen_test_recent(void *shadow, bool file)
> > > without refactoring the existing
> > >   lru_gen_refault().
> > >
> > > Set the boilerplate aside, you only repeat one line of code, which is
> > > the last line in the new function.
> > >
> > > (The boilerplate code is repeated in many places, and that's why it's
> > > called boilerplate.)
> >
> > Oh maybe I've misunderstood your original comment. Your
> > suggestion is to repeat the eviction recency check in workingset.c
> > (i.e keep the *_gen_refault unchanged - just copy that logic to
> > *_test_recent)?
>
> Correct.

Thanks for the suggestion, Yu! I'll update if there are complications with
this, but otherwise the change will be in v3 of this patch series.
