Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E64F63DD54
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiK3S03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiK3S00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:26:26 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325EAF593
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:26:24 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id z131so2289648iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sC8R1Y9mBKJ+sMKAdraa2B/xyNoHob+GAk8cNDVN2DQ=;
        b=FglytdjJtS+ckXnr291Bivorj0tAtiwmE0n/o1uVaPsluYB4mebgBuCAF/H7CghLLi
         miQyX+2Fi/BtOpQHv+593dIpeUbuVS6orOvFkHTtIqkqal4d7uqCzlgy36abMR7bp7CB
         XsbUytEy0sH+Le7Ii3Z5U02+/jw32dsndnm+ns2ZiKsZ4E726xl036CTbGbTfGLEtWN3
         ozwFqixuiBFQ16rZ8vaJyl+eCco0rlfUJOpPuDcOzwV4IvHSwq/xbvKLRKjZd9vSQ66H
         f+D6Ke+TsQNevgdM3l9ai6lhumPXg3ye2hZp9oTJdBJjZmNMspQMlFdNXGuxLw9QOgyQ
         Dd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sC8R1Y9mBKJ+sMKAdraa2B/xyNoHob+GAk8cNDVN2DQ=;
        b=eNlgw92a9p+cIizLTZivoVb7c4ekfo36eZmqXvr7QVg5w0OpG3p7ZbZsXJUC4ssWVI
         ia76VQOejdjTi90HJqDGZtBqkv6RlXyAg72Sm7haQtyuoljfM/vMM+O7sQ1H845si8tX
         HvDoWx31yPqO113TMNPrzfwn7mukqZqtBwgye3gaDP4P5UT0S/vYjFsilg4vdO9fIHYu
         5SQycoiGRs6V1G1ewOtvo6KVuVj7LA2MctO5v3ICMmR6ZXht58y3KTz1ut7u3bVs+WXs
         urxDfjqR5/pOgnocwXQDr8ID4CQv8nBPIfSMaMwKa77KA7yJcnNbKFKrTscfaAx1u97b
         JSxw==
X-Gm-Message-State: ANoB5pkxYdjXyM8CMLlGJ0mrxHTZo+TNWnzdTH1rppCG96S+TkYtGAtW
        d8kbQ8La70CXCVlnI2mjS6WDF1GG6dqvvGhogNHNPQ==
X-Google-Smtp-Source: AA0mqf7XlxXtau17W+8+HwXEFxta7c4YtY5lg4v+iHU3yqkgS62M58ZyVuvznyfnsqEOOFxe13EYkY0aQnxO802687E=
X-Received: by 2002:a05:6638:4716:b0:389:e336:e928 with SMTP id
 cs22-20020a056638471600b00389e336e928mr7405125jab.51.1669832784172; Wed, 30
 Nov 2022 10:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20221123092132.2521764-1-yosryahmed@google.com>
 <20221123092132.2521764-3-yosryahmed@google.com> <Y37C68kUYakRQ2ZC@P9FQF9L96D.corp.robot.car>
 <CAJD7tkZUcbkzG=g1wgkoWgBgZM2eHQLNY0dmHnWghzHRmeDjkQ@mail.gmail.com>
 <CAJD7tkYC9Ba0p2GDnXTMOqqLWyCpKoX0qUgviGcmWa4abNVV-Q@mail.gmail.com> <Y4eQupgWwX0/ItIX@P9FQF9L96D.corp.robot.car>
In-Reply-To: <Y4eQupgWwX0/ItIX@P9FQF9L96D.corp.robot.car>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 30 Nov 2022 10:25:48 -0800
Message-ID: <CAJD7tkaqS1x4UrN7Amq2tzhrtxifG8wzbtw8=ROVpoM0TE4LBw@mail.gmail.com>
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

On Wed, Nov 30, 2022 at 9:20 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Tue, Nov 29, 2022 at 11:42:31AM -0800, Yosry Ahmed wrote:
> > On Wed, Nov 23, 2022 at 7:16 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > On Wed, Nov 23, 2022 at 5:03 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > >
> > > > On Wed, Nov 23, 2022 at 09:21:31AM +0000, Yosry Ahmed wrote:
> > > > > Refactor the code that drives writing to memory.reclaim (retrying, error
> > > > > handling, etc) from test_memcg_reclaim() to a helper called
> > > > > reclaim_until(), which proactively reclaims from a memcg until its
> > > > > usage reaches a certain value.
> > > > >
> > > > > This will be used in a following patch in another test.
> > > > >
> > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > > ---
> > > > >  .../selftests/cgroup/test_memcontrol.c        | 85 +++++++++++--------
> > > > >  1 file changed, 49 insertions(+), 36 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > > index 8833359556f3..d4182e94945e 100644
> > > > > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > > @@ -645,6 +645,53 @@ static int test_memcg_max(const char *root)
> > > > >       return ret;
> > > >
> > > >
> > > > The code below looks correct, but can be simplified a bit.
> > > > And btw thank you for adding a test!
> > > >
> > > > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > > (idk if you want invest your time in further simplication of this code,
> > > > it was this way before this patch, so up to you).
> > >
> > > I don't "want" to, but the voices in my head won't shut up until I do so..
> > >
> > > Here's a patch that simplifies the code, I inlined it here to avoid
> > > sending a new version. If it looks good to you, it can be squashed
> > > into this patch or merged separately (whatever you and Andrew prefer).
> > > I can also send it in a separate thread if preferred.
> >
> > Roman, any thoughts on this?
> >
> > >
> > >
> > > From 18c40d61dac05b33cfc9233b17979b54422ed7c5 Mon Sep 17 00:00:00 2001
> > > From: Yosry Ahmed <yosryahmed@google.com>
> > > Date: Thu, 24 Nov 2022 02:21:12 +0000
> > > Subject: [PATCH] selftests: cgroup: simplify memcg reclaim code
> > >
> > > Simplify the code for the reclaim_until() helper used for memcg reclaim
> > > through memory.reclaim.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> > >  .../selftests/cgroup/test_memcontrol.c        | 65 ++++++++++---------
> > >  1 file changed, 33 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > index bac3b91f1579..2e2bde44a6f7 100644
> > > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > @@ -17,6 +17,7 @@
> > >  #include <netdb.h>
> > >  #include <errno.h>
> > >  #include <sys/mman.h>
> > > +#include <limits.h>
> > >
> > >  #include "../kselftest.h"
> > >  #include "cgroup_util.h"
> > > @@ -656,51 +657,51 @@ static int test_memcg_max(const char *root)
> > >         return ret;
> > >  }
> > >
> > > -/* Reclaim from @memcg until usage reaches @goal_usage */
> > > +/*
> > > + * Reclaim from @memcg until usage reaches @goal_usage by writing to
> > > + * memory.reclaim.
> > > + *
> > > + * This function will return false if the usage is already below the
> > > + * goal.
> > > + *
> > > + * This function assumes that writing to memory.reclaim is the only
> > > + * source of change in memory.current (no concurrent allocations or
> > > + * reclaim).
> > > + *
> > > + * This function makes sure memory.reclaim is sane. It will return
> > > + * false if memory.reclaim's error codes do not make sense, even if
> > > + * the usage goal was satisfied.
> > > + */
> > >  static bool reclaim_until(const char *memcg, long goal_usage)
> > >  {
> > >         char buf[64];
> > >         int retries = 5;
> > > -       int err;
> > > +       int err = INT_MAX;
> > >         long current, to_reclaim;
> > >
> > > -       /* Nothing to do here */
> > > -       if (cg_read_long(memcg, "memory.current") <= goal_usage)
> > > -               return true;
> > > -
>
> Hi Yosry!
>
> Thank you for working on this!
> I feel like it's still way more complex than it can be.
> How about something like this? (completely untested, treat is
> as a pseudo-code).

Thanks Roman!

This looks much simpler, and it nicely and subtly catches the false
negative case (where we return -EAGAIN but have actually reclaimed the
requested amount), but I think it doesn't catch the false positive
case (where memory.reclaim returns 0 but hasn't reclaimed enough
memory). In this case I think we will just keep retrying and ignore
the false positive?

Maybe with the following added check?

>
>
> {
>         ...
>         bool ret = false;
>
>         for (retries = 5; retries > 0; retries--) {
>                 current = cg_read_long(memcg, "memory.current");
>
>                 if (current <= goal) // replace with values_close?
>                         break;
                   else if (ret) { // false positive?
                            ret = false;
                            break;
                    }
>
>                 to_reclaim = current - goal_usage;
>                 snprintf(buf, sizeof(buf), "%ld", to_reclaim);
>                 err = cg_write(memcg, "memory.reclaim", buf);
>                 if (!err)
>                         ret = true;
>                 else if (err != -AGAIN)
>                         break;
>         }
>
>         return ret;
> }

Also, please let me know if you prefer that I send this cleanup in the
same thread like the above, in a completely separate patch that
depends on this series, or have it squashed into this patch in a v3.

Thanks again!
