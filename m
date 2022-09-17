Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E12A5BB888
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIQNfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIQNfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:35:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C8825581
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 06:35:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c11so40201409wrp.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pkEmitpPxttXVrpaoXcyyBb0DXbZJ4MfwB1UQBeB4Cs=;
        b=qbRXEL4zHM3yGua4NVlehiIP+BhPgK6DA5XjrXFMVDQDH/g92j3jQf3chqSXiALt7V
         3wJtFcqTL3R2XTOUxO+0/GyFYhuqY2OtEZm43Y4i3drArYiiRv0U7AEsJtmdmg0zmSwc
         gPqzfVyMKXkhhCnc9a6w+unr/TkIyESTmovLB2qcFXJ4Ux0PFWAhRuZL5+bneyltPOy6
         Cjvvs99IovHeWnQDFzhImtP2QRvNvXUQO3ndrvCHdLtg9tdmXFmHWl1mkdzhZ+1G72Xi
         qmjJVPh+Gg732G2DOc5VlSg12BQp8aa2ViTc00qhdQrBJaenBjWNvNb/PFkuvTiQa/CW
         tk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pkEmitpPxttXVrpaoXcyyBb0DXbZJ4MfwB1UQBeB4Cs=;
        b=rJWLdIZraQgRxXJIEjlLm+jOdObhw2nPmIMBR/ih/jcL2/clxV1hoHh0ZzLz1YoPTn
         sufDdOy4rdvchv5dne5jxd5h2rh7rPUTiK6ygzZojCvO7U3w+7HHaTo5zmVHeQuS8YsA
         roS8AsefXXyR8VVU4/Xueb6PUEH32DkwgiAsk9rnbKtX2mBDxQFIPWQBFQbCVuZXPEKR
         sd/xOb3wVU/g14v48mloYpZT19Nt4GYb1EG888ApgGaATcIX0TKr6JdYhznjPxW0gsw5
         2ow5n8IbNf4P2iTxiTG3ACdTTceyISfK7fO4+z4Etp0S6vBBHv3a+40423CGMbYSpFtf
         lZpw==
X-Gm-Message-State: ACrzQf0m4LrvVyCu5OmbNoUbJ1DbmFKEhhEHeygrTkwf5T2vncsqX4No
        PwZ8vKzIVoe/r9Nk6ZzXi28AVh2SMEhP8AZLhA==
X-Google-Smtp-Source: AMsMyM4gE5I3IlyBp0J79uc7L+wMEfIaoZ07VvSB9hb3Ma751C01ggmVhpzAE8qEQZegCZTZaHZq1lPKZ45O7RIjrJg=
X-Received: by 2002:a05:6000:70e:b0:22a:c7f5:c5f7 with SMTP id
 bs14-20020a056000070e00b0022ac7f5c5f7mr5751144wrb.333.1663421704553; Sat, 17
 Sep 2022 06:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <1663407558-21316-1-git-send-email-kaixuxia@tencent.com> <20220917111230.114618-1-sj@kernel.org>
In-Reply-To: <20220917111230.114618-1-sj@kernel.org>
From:   Kaixu Xia <xiakaixu1987@gmail.com>
Date:   Sat, 17 Sep 2022 21:34:52 +0800
Message-ID: <CAGjdHunWLqgkhCjsB6t3gV4fzVhBs6=Nj1va1sdCbrQ=Fyu53g@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: rename damon_pageout_score() to damon_cold_score()
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>
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

On Sat, Sep 17, 2022 at 7:12 PM SeongJae Park <sj@kernel.org> wrote:
>
> On Sat, 17 Sep 2022 17:39:18 +0800 xiakaixu1987@gmail.com wrote:
>
> > From: Kaixu Xia <kaixuxia@tencent.com>
> >
> > In the beginning there is only one damos_action 'DAMOS_PAGEOUT'
> > that need to get the coldness score of a region for a scheme,
> > which using damon_pageout_score() to do that. But now there are
> > also other damos_action actions need the coldness score, so
> > rename it to damon_cold_score() to make more sense.
>
> Good idea.
>
> >
> > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> > ---
> >  mm/damon/ops-common.c | 2 +-
> >  mm/damon/ops-common.h | 2 +-
> >  mm/damon/paddr.c      | 5 ++---
> >  mm/damon/vaddr.c      | 2 +-
> >  4 files changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 9310df72e1c5..75409601f934 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -130,7 +130,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> >       return hotness;
> >  }
> >
> > -int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
> > +int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
> >                       struct damos *s)
> >  {
> >       int hotness = damon_hot_score(c, r, s);
> > diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> > index 52329ff361cd..8d82d3722204 100644
> > --- a/mm/damon/ops-common.h
> > +++ b/mm/damon/ops-common.h
> > @@ -12,7 +12,7 @@ struct page *damon_get_page(unsigned long pfn);
> >  void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
> >  void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
> >
> > -int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
> > +int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
> >                       struct damos *s);
> >  int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> >                       struct damos *s);
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index dfeebffe82f4..e495146e49e9 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -287,11 +287,10 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
> >  {
> >       switch (scheme->action) {
> >       case DAMOS_PAGEOUT:
> > -             return damon_pageout_score(context, r, scheme);
> > +     case DAMOS_LRU_DEPRIO:
> > +             return damon_cold_score(context, r, scheme);
> >       case DAMOS_LRU_PRIO:
> >               return damon_hot_score(context, r, scheme);
> > -     case DAMOS_LRU_DEPRIO:
> > -             return damon_pageout_score(context, r, scheme);
>
> I'm not a big fan of switch-case fall-through, and want to keep the order of
> cases here more similar to that in damos_action definition.  Let's change only
> the function name.
>
Ok, I'll follow that in the next version.

Thanks,
Kaixu
> Other than that,
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
>
> Thanks,
> SJ
>
> >       default:
> >               break;
> >       }
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index f53c2ff2bcc8..ea94e0b2c311 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -673,7 +673,7 @@ static int damon_va_scheme_score(struct damon_ctx *context,
> >
> >       switch (scheme->action) {
> >       case DAMOS_PAGEOUT:
> > -             return damon_pageout_score(context, r, scheme);
> > +             return damon_cold_score(context, r, scheme);
> >       default:
> >               break;
> >       }
> > --
> > 2.27.0
> >
> >
