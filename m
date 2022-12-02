Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFBE63FEB6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiLBDUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiLBDUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:20:03 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64667769CC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 19:20:02 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y131so1698797iof.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 19:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AQDzzFTey2VIGmW/220/e2ZM1PaWhE7HKtjmhjomFW0=;
        b=PBjCENkqqjop+mquSyQ0nD7UGdDUXFMJusOPayg4nfDUlK5skhdQqWBrYCBm6CbFfQ
         YJLZcT8Y1qpcHT2u1fa0LR9nCnBjLzVLqWMmlBvCkjSBd5iLCsMPZUdnaswKw2i8rib/
         4XKp4PK/ruJ/dnej/0CsGEw8SileKUnJyXCSwKtUmWjauUIKUaFYVAg5L3dOo7xDsMww
         TQ5ay+Z8cwHlZLtn8SD8mIXCFNek6U0U0xZJ2i0R96zxG81Y79ocFvYj2wk1/HI/H9/O
         6Z1gkyHFot/uxEGb6dJB81U7nzSc6mP33lm8THcrt0wfr2dlXoWYtvOHQ+5xvKzgeCy1
         YcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQDzzFTey2VIGmW/220/e2ZM1PaWhE7HKtjmhjomFW0=;
        b=uFXHxKo/m/TQFB34BFYn/yq/ON1neUryE3R9vRk84ETdSaeQ32p0y/39g2i1tTBE+P
         qroMlm3KTuqI07UOzU4iFpq/lFMZPHvpxbkkmZYYL1khQL4ryhe9XOGzWfI3zCrHQ+Dt
         OtevhVn/xFWnl7yqC7cbXY4KKKdaoJrHY5Zk19j6QxEPXhQE58GbzC3odoQQ9Xm3MqJr
         Qej4ycmW8Uh3MS/lPBYZ0IE8u7dfB6A6m3RTsEiQaE3/0bdrztmekttwI4acAJkhaAE9
         U3US9yk9lbOA26A5zazDHoMiRuXUlykLpf/lMd2QE/UwHOjzdgf8dNK/z65DtRwXY75S
         bqsA==
X-Gm-Message-State: ANoB5pnkvqasQlXC++R8CKisTAQuqlDpRAJw++9PJJz0Yxhlwv1pjYXz
        WAfEdpmoGkntoGypH5YoMWIhJAF9gXLk+eFq47dTFQ==
X-Google-Smtp-Source: AA0mqf477Cau7AFPlNqKnoeqWGMDtb3WZlp02LyiEpUK95rhWqW0JZl7MJEmy5lrwU1gpktz7Jy7hj7pilJYdDztb9s=
X-Received: by 2002:a6b:4409:0:b0:6de:bd7d:ee08 with SMTP id
 r9-20020a6b4409000000b006debd7dee08mr23598092ioa.0.1669951201609; Thu, 01 Dec
 2022 19:20:01 -0800 (PST)
MIME-Version: 1.0
References: <20221123092132.2521764-1-yosryahmed@google.com>
 <20221123092132.2521764-3-yosryahmed@google.com> <Y37C68kUYakRQ2ZC@P9FQF9L96D.corp.robot.car>
 <CAJD7tkZUcbkzG=g1wgkoWgBgZM2eHQLNY0dmHnWghzHRmeDjkQ@mail.gmail.com>
 <CAJD7tkYC9Ba0p2GDnXTMOqqLWyCpKoX0qUgviGcmWa4abNVV-Q@mail.gmail.com>
 <Y4eQupgWwX0/ItIX@P9FQF9L96D.corp.robot.car> <CAJD7tkaqS1x4UrN7Amq2tzhrtxifG8wzbtw8=ROVpoM0TE4LBw@mail.gmail.com>
In-Reply-To: <CAJD7tkaqS1x4UrN7Amq2tzhrtxifG8wzbtw8=ROVpoM0TE4LBw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 1 Dec 2022 19:19:25 -0800
Message-ID: <CAJD7tka55y3Q153srU4gV6Kq93PygU9=P8Rv3vmw0AY6+t_pvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selftests: cgroup: refactor proactive reclaim code
 to reclaim_until()
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Wed, Nov 30, 2022 at 10:25 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Wed, Nov 30, 2022 at 9:20 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Tue, Nov 29, 2022 at 11:42:31AM -0800, Yosry Ahmed wrote:
> > > On Wed, Nov 23, 2022 at 7:16 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > On Wed, Nov 23, 2022 at 5:03 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > > >
> > > > > On Wed, Nov 23, 2022 at 09:21:31AM +0000, Yosry Ahmed wrote:
> > > > > > Refactor the code that drives writing to memory.reclaim (retrying, error
> > > > > > handling, etc) from test_memcg_reclaim() to a helper called
> > > > > > reclaim_until(), which proactively reclaims from a memcg until its
> > > > > > usage reaches a certain value.
> > > > > >
> > > > > > This will be used in a following patch in another test.
> > > > > >
> > > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > > > ---
> > > > > >  .../selftests/cgroup/test_memcontrol.c        | 85 +++++++++++--------
> > > > > >  1 file changed, 49 insertions(+), 36 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > > > index 8833359556f3..d4182e94945e 100644
> > > > > > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > > > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > > > @@ -645,6 +645,53 @@ static int test_memcg_max(const char *root)
> > > > > >       return ret;
> > > > >
> > > > >
> > > > > The code below looks correct, but can be simplified a bit.
> > > > > And btw thank you for adding a test!
> > > > >
> > > > > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > > > (idk if you want invest your time in further simplication of this code,
> > > > > it was this way before this patch, so up to you).
> > > >
> > > > I don't "want" to, but the voices in my head won't shut up until I do so..
> > > >
> > > > Here's a patch that simplifies the code, I inlined it here to avoid
> > > > sending a new version. If it looks good to you, it can be squashed
> > > > into this patch or merged separately (whatever you and Andrew prefer).
> > > > I can also send it in a separate thread if preferred.
> > >
> > > Roman, any thoughts on this?
> > >
> > > >
> > > >
> > > > From 18c40d61dac05b33cfc9233b17979b54422ed7c5 Mon Sep 17 00:00:00 2001
> > > > From: Yosry Ahmed <yosryahmed@google.com>
> > > > Date: Thu, 24 Nov 2022 02:21:12 +0000
> > > > Subject: [PATCH] selftests: cgroup: simplify memcg reclaim code
> > > >
> > > > Simplify the code for the reclaim_until() helper used for memcg reclaim
> > > > through memory.reclaim.
> > > >
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > ---
> > > >  .../selftests/cgroup/test_memcontrol.c        | 65 ++++++++++---------
> > > >  1 file changed, 33 insertions(+), 32 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > index bac3b91f1579..2e2bde44a6f7 100644
> > > > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > @@ -17,6 +17,7 @@
> > > >  #include <netdb.h>
> > > >  #include <errno.h>
> > > >  #include <sys/mman.h>
> > > > +#include <limits.h>
> > > >
> > > >  #include "../kselftest.h"
> > > >  #include "cgroup_util.h"
> > > > @@ -656,51 +657,51 @@ static int test_memcg_max(const char *root)
> > > >         return ret;
> > > >  }
> > > >
> > > > -/* Reclaim from @memcg until usage reaches @goal_usage */
> > > > +/*
> > > > + * Reclaim from @memcg until usage reaches @goal_usage by writing to
> > > > + * memory.reclaim.
> > > > + *
> > > > + * This function will return false if the usage is already below the
> > > > + * goal.
> > > > + *
> > > > + * This function assumes that writing to memory.reclaim is the only
> > > > + * source of change in memory.current (no concurrent allocations or
> > > > + * reclaim).
> > > > + *
> > > > + * This function makes sure memory.reclaim is sane. It will return
> > > > + * false if memory.reclaim's error codes do not make sense, even if
> > > > + * the usage goal was satisfied.
> > > > + */
> > > >  static bool reclaim_until(const char *memcg, long goal_usage)
> > > >  {
> > > >         char buf[64];
> > > >         int retries = 5;
> > > > -       int err;
> > > > +       int err = INT_MAX;
> > > >         long current, to_reclaim;
> > > >
> > > > -       /* Nothing to do here */
> > > > -       if (cg_read_long(memcg, "memory.current") <= goal_usage)
> > > > -               return true;
> > > > -
> >
> > Hi Yosry!
> >
> > Thank you for working on this!
> > I feel like it's still way more complex than it can be.
> > How about something like this? (completely untested, treat is
> > as a pseudo-code).
>
> Thanks Roman!
>
> This looks much simpler, and it nicely and subtly catches the false
> negative case (where we return -EAGAIN but have actually reclaimed the
> requested amount), but I think it doesn't catch the false positive
> case (where memory.reclaim returns 0 but hasn't reclaimed enough
> memory). In this case I think we will just keep retrying and ignore
> the false positive?
>
> Maybe with the following added check?
>
> >
> >
> > {
> >         ...
> >         bool ret = false;
> >
> >         for (retries = 5; retries > 0; retries--) {
> >                 current = cg_read_long(memcg, "memory.current");
> >
> >                 if (current <= goal) // replace with values_close?
> >                         break;
>                    else if (ret) { // false positive?
>                             ret = false;
>                             break;
>                     }
> >
> >                 to_reclaim = current - goal_usage;
> >                 snprintf(buf, sizeof(buf), "%ld", to_reclaim);
> >                 err = cg_write(memcg, "memory.reclaim", buf);
> >                 if (!err)
> >                         ret = true;
> >                 else if (err != -AGAIN)
> >                         break;
> >         }
> >
> >         return ret;
> > }
>
> Also, please let me know if you prefer that I send this cleanup in the
> same thread like the above, in a completely separate patch that
> depends on this series, or have it squashed into this patch in a v3.
>
> Thanks again!

I realized I missed a few folks in the CC of this version anyway. Sent
v3 with the suggested refactoring (+ the missing check for false
positives) squashed into this patch. Also included your review tags on
patches 1 & 3 (patch 2 was almost rewritten according to your
suggestions, so I dropped the review tag and added a suggested tag):

https://lore.kernel.org/lkml/20221202031512.1365483-1-yosryahmed@google.com/

Thanks!
