Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0FA5BC360
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiISHKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiISHKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:10:40 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B2E1D326
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:10:37 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1279948d93dso60557103fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=PyCIhxIxB6xdPJS86Umt+cZmdjWeyJkrCWWdU0BTFc0=;
        b=dJGqhxMivVqXBMzG1VTVnJAbcQMh8OeK9ELf67XsoiqHCep3fs4aBaHnnEtzw5vq4f
         098bSkUfBMWJnf0YkfzR3pFdbxDEexutJrrPTHYEr8SuBeqrnavcpi1+5XHpm/LvpQge
         yq9LCER/kuZBJbnQI+QScknTbSOLsaa3MGQAuwfqKG82Odukfr0EnrvpeCMaWjNe2nAl
         zKmGeqM/p1k9vPwbGReMvhjRNCvcXup+ds7f+y2mnexqwn3qpezuoVjiFT/XbzURA/L0
         q6uDsn1hbis2j1Cj2zx/UGlLYQqM/cQV+AvLCpsI3oVtTBcNsZ1+zqn7JBC1iLFw6DQ3
         k3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PyCIhxIxB6xdPJS86Umt+cZmdjWeyJkrCWWdU0BTFc0=;
        b=RuWClCl/8+BdXcFBE5nla2HTIUzG2hsccF85tEBUO5PkCaFcM4515sLsH9I40O116A
         ncsPMO1aAqa7OxgfJH5YGswFVmqIZxYeGlAAajOkJUa4dw1TpfBqhD+JUFHQN85ysrwp
         3/RJY+kL8/dIlPgMkgSrD+4iC+CmLfd0uTChiDc7VM/4KdrIpDvad30rumTnceBFSgfK
         6WTp9GCMqZL7rkmrr8TU+vW2tRK0ArHvyGdik1z26P4toyojgcz8+uKP8cYIQ7qvAeff
         RUiuCgjl18PIT9qS6GPHRnb/StsrfBC4qe/fcO5qLr/M6REpHNI13jVvST4dWpI75M0V
         3y+A==
X-Gm-Message-State: ACgBeo2u9G5a3/vyIrfxSS5xxwz1A2nZ4t88mDvRiGtY3/4o1HGD6nBM
        DFAxDv8Yoecc3vUQUEfV0pWAJOFMDPI=
X-Google-Smtp-Source: AA6agR4z43qXPxugZCRAYvg4LpkH98Fp2tU+XK7aoRL8gBhkoqDXiJQ967zZkQ7fAdR5BFBIh/gA+Q==
X-Received: by 2002:a05:6870:b68f:b0:10b:ba83:92d4 with SMTP id cy15-20020a056870b68f00b0010bba8392d4mr14285525oab.130.1663571436185;
        Mon, 19 Sep 2022 00:10:36 -0700 (PDT)
Received: from haolee.io ([2600:3c00::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id u21-20020a056870f29500b0010830c24aaasm7204781oap.56.2022.09.19.00.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 00:10:35 -0700 (PDT)
Date:   Mon, 19 Sep 2022 07:10:33 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] psi: fix possible missing or delayed pending event
Message-ID: <20220919071033.GA26869@haolee.io>
References: <20220914092959.GA20640@haolee.io>
 <CAJuCfpFVK3ceHy+ipSbLb0jAgE6tJAsu5=kbJEB9X4OWPnsVxA@mail.gmail.com>
 <20220917073124.GA3483@haolee.io>
 <CAJuCfpH6QVuKd-Y1qr1Rzh+hCG-HVgmWfXk9r0tsFhDijZ_ABg@mail.gmail.com>
 <20220918105510.GA22671@haolee.io>
 <CAJuCfpEdT8Vdewyrp0hZ_1--29MbZfa=gX+0+6cOyb7b1TVZYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEdT8Vdewyrp0hZ_1--29MbZfa=gX+0+6cOyb7b1TVZYA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 10:16:53PM -0700, Suren Baghdasaryan wrote:
> On Sun, Sep 18, 2022 at 3:55 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
> >
> > On Sat, Sep 17, 2022 at 09:44:12PM -0700, Suren Baghdasaryan wrote:
> > > On Sat, Sep 17, 2022 at 12:31 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
> > > >
> > > > On Fri, Sep 16, 2022 at 11:08:34PM -0700, Suren Baghdasaryan wrote:
> > > > > On Wed, Sep 14, 2022 at 2:30 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
> > > > > >
> > > > > > When a pending event exists and growth is less than the threshold, the
> > > > > > current logic is to skip this trigger without generating event. However,
> > > > > > from e6df4ead85d9 ("psi: fix possible trigger missing in the window"),
> > > > > > our purpose is to generate event as long as pending event exists and the
> > > > > > rate meets the limit. This patch fixes the possible pending-event
> > > > > > missing or delay.
> > > > > >
> > > > > > Fixes: e6df4ead85d9 ("psi: fix possible trigger missing in the window")
> > > > > > Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> > > > > > ---
> > > > > >  kernel/sched/psi.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > > > > index 9711827e3..0bae4ee2b 100644
> > > > > > --- a/kernel/sched/psi.c
> > > > > > +++ b/kernel/sched/psi.c
> > > > > > @@ -539,7 +539,7 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > > > > >
> > > > > >                         /* Calculate growth since last update */
> > > > > >                         growth = window_update(&t->win, now, total[t->state]);
> > > > > > -                       if (growth < t->threshold)
> > > > > > +                       if (growth < t->threshold && !t->pending_event)
> > > > >
> > > > > I'm not sure how this additional condition changes things. Current
> > > > > logic is to set t->pending_event=true whenever growth exceeds the
> > > > > t->threshold. This patch will change this logic into setting
> > > > > t->pending_event=true also when t->pending_event=true.
> > > >
> > > > This is right.
> > > >
> > > > > But why would
> > > > > you want to set t->pending_event=true if it's already true? What am I
> > > > > missing?
> > > >
> > > > If I expand this if-else branch and the pending_event statement
> > > > to a more detailed snippet, it will be like this:
> > > >
> > > > if (growth < t->threshold && !t->pending_event) // under threshold && no pending event. Skip.
> > > >         continue;
> > > > else if (growth >= t->threshold) // above threshold. Try to generate event.
> > > >         t->pending_event = true;
> > > > else // under threshold && have pending events. Try to generate event.
> > > >         ; // pending_event is already true. do nothing
> > > >
> > > >
> > > > The original code didn't handle the `else` condition properly.
> > >
> > > The `else` condition in your code does nothing, and that's why the
> > > original code does not implement a handler for that case.
> > >
> > > > It will
> > > > skip the trigger when its growth is under the threshold, even though it
> > > > has a pending event. This patch handles this condition correctly.
> > > >
> > > > But I think assigning true to pending_event when it's already true doesn't
> > > > have other side effects, so I eliminate the `else if` branch. Maybe we'd
> > > > better make it explicit, like the above snippet? Thanks.
> > >
> > > The new code you posted is functionally the same as the original one
> > > while being more verbose and IMO less readable. Unless you can explain
> > > the problem with the original code, I don't see any reason to change
> > > it.
> >
> > Hi, for the original code, let's assume t->pending_event is true:
> >     * if new_stall is false, we will try to check event ratelimit and
> >       generate an event for this psi_trigger. This case is right.
> >     * but if new_stall is true, we will skip this psi_trigger if growth
> >       growth < t->threshold. I think we shouldn't skip this psi_trigger
> >       in this case because it has a pending event.
> 
> Ok, I see the issue now. I think the following fix would be the simplest:
> 
>                        /* Calculate growth since last update */
>                         growth = window_update(&t->win, now, total[t->state]);
> -                       if (growth < t->threshold)
> -                                continue;
> +                       if (!t->pending_event) {
> +                              if (growth < t->threshold)
> +                                        continue;
> 
> -                        t->pending_event = true;
> +                               t->pending_event = true;
> +                       }

Great! I will update in v2.

> 
> 
> >
> > >
> > > >
> > > > >
> > > > > >                                 continue;
> > > > > >
> > > > > >                         t->pending_event = true;
> > > > > > --
> > > > > > 2.21.0
> > > > > >
