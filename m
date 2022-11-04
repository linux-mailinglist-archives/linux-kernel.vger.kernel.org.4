Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F0961A585
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiKDXP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiKDXPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:15:54 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490532664
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:15:53 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j130so7453165ybj.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 16:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gfQYYmCbfCdmjxGtiSGnXE7+iSfuVxiEGd6gtYgqdUg=;
        b=W7QfOvf2wl5F1GgempFO5HuRpFHpBoZFuLire4tTDUmcIFG0V0llXW6eY60TN4eKwj
         mgqQY4kV0HG1PwRq4ETPLqO2Ir6Ngk2DRQ0nbQK3MnjpiijFSmgbwsBKaDlPDYxRmDue
         l+lSlmAT+regGBQ1XuTGfERpdMReMZtE5VEMTcnASO9eKaV1LzeZvhPnPhCfsi5BtQMb
         k86hY1TpDd51WohK4ComlXZnZduj0C4dJzYLSckz7B1HD9FCjGnk1tKnvay2eldhq5d9
         YK7JFTIt5KZYTxbDvRBJxHQ4rLRG/enxlZD8C2uaFRkV2V6pgmBbOPOsb7r3AHJQKJ+s
         vj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfQYYmCbfCdmjxGtiSGnXE7+iSfuVxiEGd6gtYgqdUg=;
        b=PGP8sc4FB1KdPnxUbNezpSU+xT0HGX9B6ZuO+ZJ1r/ftKoqBcxY1B5OCsESKNx8UVj
         9+Z2FOxKze5+N3co6yBak0JQ0cTQuuGluJsBTihhG4lY1szlROa44zf3Q6ZJDv9wkFp2
         fyCstpQywvBkxepUNcPIVyAHf8lVDwFwREr+FgBop8/QOPSi5YGCcgajkIApDSqCBxv1
         pHNzW0kXvf435fmsPyIxiNOGVMVorT4ayLWnoxI2JW8XAlX9eBCwAp7syAYuzzTy/QcY
         ifLsxQWhan9tXc1X/d4OjzpgxUhn/bMaagnWVJ2+wnTTfHILnCwlb2xfU51FZQHaJYgJ
         JBEw==
X-Gm-Message-State: ACrzQf1VxxisCp+tQKAUJ3RUbSwq7X8FRjpEF5XjS/rS52zKo2zZzZos
        jAS0uAGNnvV++wltUSSucyJnp1arcL4yR1iq9lmlSqbnDOY=
X-Google-Smtp-Source: AMsMyM6Y9C9l1opVH7d9hQqg25kh4n4jR2xkbBg4vrbQWw1H6AOqjy6XSalLTDDqueYCQwiSumzX7y/MS6laK3Q5rhI=
X-Received: by 2002:a25:c00a:0:b0:6cf:dda2:552e with SMTP id
 c10-20020a25c00a000000b006cfdda2552emr221195ybf.363.1667603752365; Fri, 04
 Nov 2022 16:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221024052841.3291983-1-shakeelb@google.com> <CGME20221102210957eucas1p2915f88d8b923ccf79f0e8770d208a1bd@eucas1p2.samsung.com>
 <fb370ccf-d22a-7885-1773-da85c9d7ea8c@samsung.com> <20221103171407.ydubp43x7tzahriq@google.com>
 <20221104160552.c249397512c5c7f8b293869f@linux-foundation.org>
In-Reply-To: <20221104160552.c249397512c5c7f8b293869f@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 4 Nov 2022 16:15:41 -0700
Message-ID: <CALvZod5H5DTRacLiyW8pjRAxk=MsQMcJrit2HXLOSsof7yq34g@mail.gmail.com>
Subject: Re: [PATCH] mm: convert mm's rss stats into percpu_counter
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, linux-mm@kvack.org,
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

On Fri, Nov 4, 2022 at 4:05 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 3 Nov 2022 17:14:07 +0000 Shakeel Butt <shakeelb@google.com> wrote:
>
> >
> > ...
> >
> > Thanks for the report. It seems like there is a race between
> > for_each_online_cpu() in __percpu_counter_sum() and
> > percpu_counter_cpu_dead()/cpu-offlining. Normally this race is fine for
> > percpu_counter users but for check_mm() is not happy with this race. Can
> > you please try the following patch:
>
> percpu-counters supposedly avoid such races via the hotplup notifier.
> So can you please fully describe the race and let's see if it can be
> fixed at the percpu_counter level?
>

Yes, I am writing a more detailed commit message explaining the race
and why it is not really an issue for current users.

> >
> > From: Shakeel Butt <shakeelb@google.com>
> > Date: Thu, 3 Nov 2022 06:05:13 +0000
> > Subject: [PATCH] mm: percpu_counter: use race free percpu_counter sum
> >  interface
> >
> > percpu_counter_sum can race with cpu offlining. Add a new interface
> > which does not race with it and use that for check_mm().
>
> I'll grab this version for now, as others might be seeing this issue.
>

Thanks.

>
> > ---
> >  include/linux/percpu_counter.h | 11 +++++++++++
> >  kernel/fork.c                  |  2 +-
> >  lib/percpu_counter.c           | 24 ++++++++++++++++++------
> >  3 files changed, 30 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
> > index bde6c4c1f405..3070c1043acf 100644
> > --- a/include/linux/percpu_counter.h
> > +++ b/include/linux/percpu_counter.h
> > @@ -45,6 +45,7 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
> >  void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
> >                             s32 batch);
> >  s64 __percpu_counter_sum(struct percpu_counter *fbc);
> > +s64 __percpu_counter_sum_all(struct percpu_counter *fbc);
> >  int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
> >  void percpu_counter_sync(struct percpu_counter *fbc);
> >
> > @@ -85,6 +86,11 @@ static inline s64 percpu_counter_sum(struct percpu_counter *fbc)
> >       return __percpu_counter_sum(fbc);
> >  }
> >
> > +static inline s64 percpu_counter_sum_all(struct percpu_counter *fbc)
> > +{
> > +     return __percpu_counter_sum_all(fbc);
> > +}
>
> We haven't been good about documenting these interfaces.  Can we please
> start now? ;)
>

Yup will do.

> >
> > ...
> >
> > +
> > +/*
> > + * Add up all the per-cpu counts, return the result.  This is a more accurate
> > + * but much slower version of percpu_counter_read_positive()
> > + */
> > +s64 __percpu_counter_sum(struct percpu_counter *fbc)
> > +{
> > +     return __percpu_counter_sum_mask(fbc, cpu_online_mask);
> > +}
> >  EXPORT_SYMBOL(__percpu_counter_sum);
> >
> > +s64 __percpu_counter_sum_all(struct percpu_counter *fbc)
> > +{
> > +     return __percpu_counter_sum_mask(fbc, cpu_possible_mask);
> > +}
> > +EXPORT_SYMBOL(__percpu_counter_sum_all);
>
> Probably here is a good place to document it.
>
> Is there any point in having the
> percpu_counter_sum_all()->__percpu_counter_sum_all() inlined wrapper?
> Why not name this percpu_counter_sum_all() directly?
>

Ack.

thanks,
Shakeel
