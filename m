Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800D65BC279
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 07:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiISFRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 01:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiISFRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 01:17:05 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB141AD85
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 22:17:04 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id a67so40942852ybb.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 22:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zLZGlmh0D+Ev4K6M851+89biL3Of5U43KrXSge+e2TY=;
        b=B5fgbsoMjoFET87TUVeA44IIfbcMbkiag+jfQjNc2UAYVQRX+f0Hzo1CN8T9d7WL0z
         1NpHzi70MfjibJqnLR282mwXH+Y/pIwSB6pqLjzUwzh8CHNcsGiVFEv0/VLC2cvPq2oV
         +sfo10ReWel6Xxqew1NOahAJWoy864WiFZf5wh00Bfnr5zair9gDdA8Nf8lYC5dHz9nz
         T7NNcMKhrwaGrZmdODrPmv9sfmo6Oxv6Upjf2IIL/KU0kPaXRgYOQiUppIOtWIdOeWM7
         wEuE8My5XWFNPA0MBExAROyzg11sb7NLJ9bQBFWBLX61PExwUCAGEWM0T1R41UWzzP6d
         rZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zLZGlmh0D+Ev4K6M851+89biL3Of5U43KrXSge+e2TY=;
        b=ORIvSp23J+ObD5l9W5KqaMIXzU/1MnAXB9CQ5qbv0dZfjHY64mCGtnWqV7vMBJ0Z3+
         HmrP/Z6B0+GHHwc5UqFDSnQg+GBCI14ou9i8OaP6KyPHkCwEatFOOmrSGkGoDfVq4Akc
         ZqYmsecX31YUteYQlDxSufqspCc0Iv6GRcZi8vppY4vtE1Ubs64+Yranr3L2AAakJA/I
         lDN4caS/qKmuXOBlqEmyTa9dMgwmTdTArdUXdOGh4Ye1q8R1NVf3lFB1VqzLlnswCpw4
         cwkQvhuXW1WktxtuoSxUYwTBO8Rf1AWvGEaSvWyM8McPANg6NtxK4lQ+EEIileNzMe7E
         KNSg==
X-Gm-Message-State: ACrzQf0bbd3p+Oy0WIXLOdzBjHHo+JbFg+aox9x92Bh7RhbcPaJF2DJe
        ekYHwaI0qVDKqPt7oHpZtbB8sHMCuWzpLtvelL48704cLyZMaAFR
X-Google-Smtp-Source: AMsMyM7PNDVgYktPN93U1wYV3ZZ9pwl9Kk/NpnV6EZZU9OfbbTA1mXiq9a+LuZRz9brgGM5rYjSDef8z2XmfT3KKAXU=
X-Received: by 2002:a25:4045:0:b0:6ae:b15a:cd81 with SMTP id
 n66-20020a254045000000b006aeb15acd81mr12939722yba.340.1663564623477; Sun, 18
 Sep 2022 22:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220914092959.GA20640@haolee.io> <CAJuCfpFVK3ceHy+ipSbLb0jAgE6tJAsu5=kbJEB9X4OWPnsVxA@mail.gmail.com>
 <20220917073124.GA3483@haolee.io> <CAJuCfpH6QVuKd-Y1qr1Rzh+hCG-HVgmWfXk9r0tsFhDijZ_ABg@mail.gmail.com>
 <20220918105510.GA22671@haolee.io>
In-Reply-To: <20220918105510.GA22671@haolee.io>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 18 Sep 2022 22:16:53 -0700
Message-ID: <CAJuCfpEdT8Vdewyrp0hZ_1--29MbZfa=gX+0+6cOyb7b1TVZYA@mail.gmail.com>
Subject: Re: [PATCH] psi: fix possible missing or delayed pending event
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Sun, Sep 18, 2022 at 3:55 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
>
> On Sat, Sep 17, 2022 at 09:44:12PM -0700, Suren Baghdasaryan wrote:
> > On Sat, Sep 17, 2022 at 12:31 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
> > >
> > > On Fri, Sep 16, 2022 at 11:08:34PM -0700, Suren Baghdasaryan wrote:
> > > > On Wed, Sep 14, 2022 at 2:30 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
> > > > >
> > > > > When a pending event exists and growth is less than the threshold, the
> > > > > current logic is to skip this trigger without generating event. However,
> > > > > from e6df4ead85d9 ("psi: fix possible trigger missing in the window"),
> > > > > our purpose is to generate event as long as pending event exists and the
> > > > > rate meets the limit. This patch fixes the possible pending-event
> > > > > missing or delay.
> > > > >
> > > > > Fixes: e6df4ead85d9 ("psi: fix possible trigger missing in the window")
> > > > > Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> > > > > ---
> > > > >  kernel/sched/psi.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > > > index 9711827e3..0bae4ee2b 100644
> > > > > --- a/kernel/sched/psi.c
> > > > > +++ b/kernel/sched/psi.c
> > > > > @@ -539,7 +539,7 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > > > >
> > > > >                         /* Calculate growth since last update */
> > > > >                         growth = window_update(&t->win, now, total[t->state]);
> > > > > -                       if (growth < t->threshold)
> > > > > +                       if (growth < t->threshold && !t->pending_event)
> > > >
> > > > I'm not sure how this additional condition changes things. Current
> > > > logic is to set t->pending_event=true whenever growth exceeds the
> > > > t->threshold. This patch will change this logic into setting
> > > > t->pending_event=true also when t->pending_event=true.
> > >
> > > This is right.
> > >
> > > > But why would
> > > > you want to set t->pending_event=true if it's already true? What am I
> > > > missing?
> > >
> > > If I expand this if-else branch and the pending_event statement
> > > to a more detailed snippet, it will be like this:
> > >
> > > if (growth < t->threshold && !t->pending_event) // under threshold && no pending event. Skip.
> > >         continue;
> > > else if (growth >= t->threshold) // above threshold. Try to generate event.
> > >         t->pending_event = true;
> > > else // under threshold && have pending events. Try to generate event.
> > >         ; // pending_event is already true. do nothing
> > >
> > >
> > > The original code didn't handle the `else` condition properly.
> >
> > The `else` condition in your code does nothing, and that's why the
> > original code does not implement a handler for that case.
> >
> > > It will
> > > skip the trigger when its growth is under the threshold, even though it
> > > has a pending event. This patch handles this condition correctly.
> > >
> > > But I think assigning true to pending_event when it's already true doesn't
> > > have other side effects, so I eliminate the `else if` branch. Maybe we'd
> > > better make it explicit, like the above snippet? Thanks.
> >
> > The new code you posted is functionally the same as the original one
> > while being more verbose and IMO less readable. Unless you can explain
> > the problem with the original code, I don't see any reason to change
> > it.
>
> Hi, for the original code, let's assume t->pending_event is true:
>     * if new_stall is false, we will try to check event ratelimit and
>       generate an event for this psi_trigger. This case is right.
>     * but if new_stall is true, we will skip this psi_trigger if growth
>       growth < t->threshold. I think we shouldn't skip this psi_trigger
>       in this case because it has a pending event.

Ok, I see the issue now. I think the following fix would be the simplest:

                       /* Calculate growth since last update */
                        growth = window_update(&t->win, now, total[t->state]);
-                       if (growth < t->threshold)
-                                continue;
+                       if (!t->pending_event) {
+                              if (growth < t->threshold)
+                                        continue;

-                        t->pending_event = true;
+                               t->pending_event = true;
+                       }


>
> >
> > >
> > > >
> > > > >                                 continue;
> > > > >
> > > > >                         t->pending_event = true;
> > > > > --
> > > > > 2.21.0
> > > > >
