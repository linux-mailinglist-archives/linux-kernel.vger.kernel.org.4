Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F14646730
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLHCoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLHCoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:44:32 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690DB54354
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 18:44:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay40so131113wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 18:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FJeqMhbpThjn5u6UNjaSeLf61sxGhhH5L0UukFXhRwc=;
        b=ibYLrXP7rgcb5yQ4YU02Oc3JxArLXoxeF+nolgc4H0bOy9+ByD/QeMeLOSikUDyJD4
         MuzeS4f3Ny2vzJ5Dqz3GVyjn2Ww4BAJ5GXubENUnl8UZ6As+Q3kHoL4yN6+SfYaE+iOL
         ix8XVK9jJlsWAf1zPCcsEWTjhjvPuC9JfFIWqYF77k4FIpq+bTkLWOYPjXIX38c4Pvek
         yxLo/l9NA32/GXFXSnSk/YZFRD6LBYnzgsn3y3dxPxxw4zLL4DkWSZqaQxyhr/WFjDif
         SxgvxCymGzXA8u9ktSNqnTFPtjNc+IKApd06HMDoKfGI2y0C9MPF0Lg50PBasfy7B3B7
         UWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJeqMhbpThjn5u6UNjaSeLf61sxGhhH5L0UukFXhRwc=;
        b=rxtneRmd9ZhbrVYGgC+pncjVl91sFALnXfjfP909ys5CoVfHEvZNms7tCRcI0ZQvVa
         K9Q5EupHPWMgJl7zvSrdqoQdYdrGBpsXB9uwENKWbgJ4KdAOCko1TQZ1iwnfgqHO69PG
         oA+KGddAXzzlW2oo2flvDRIZ0/R/lIfMDhA1kjism86fA8qHIUW7gZm2Pi8j7FuRjxpN
         Whj9v1Z4+91TbeFyYHu4GTztnKTQx0YKNumTafsyjrQNgUDgvKB3Poer26UEfVEqlKE1
         t/oKJozauBGZOuW92/fiL+FpnlrtkFiu9Ga6sFc3N9+PcdeXnV2xfD6jUpmbRCGuxeEQ
         iqyg==
X-Gm-Message-State: ANoB5pl41aI3bOQNkudjB5mEYu5ECYDnsYANx0PXZMxBvQGVt4M+ISMT
        LT0MaM97pRCsMIq65eyB0HqZFXdlOqHtHHdWQ/0=
X-Google-Smtp-Source: AA0mqf7hM02xt2mA/zFHLZoqCu9Q2m+jnJKoHZryR5HgGLmlVejS9VGJwsShRmMS0W9Bw71Vgaq7xOjt8i4wjlurscY=
X-Received: by 2002:a05:600c:22c4:b0:3cf:71b7:7a41 with SMTP id
 4-20020a05600c22c400b003cf71b77a41mr69831839wmg.31.1670467467831; Wed, 07 Dec
 2022 18:44:27 -0800 (PST)
MIME-Version: 1.0
References: <CAJNi4rOgYmmtOaXVqYB9sAxDmRhGhS_vVXmZbCbMjvFCQsdjCw@mail.gmail.com>
 <CAJhGHyD+oR8SeYeObJ2DSKfudqBtBOiL14jCsST3L5OG8WjT_g@mail.gmail.com>
 <CAJNi4rOs-=xx5qV-hQQYgSLQCz_q3JuFxJEd+wpPaao8Ej26yQ@mail.gmail.com>
 <CAJhGHyAVbCm6i7pTRDDXgdwS25d5O3uMCvKzyOcafRAdN-S7JQ@mail.gmail.com>
 <CAJNi4rNU0-GVnLMqdGFvHOsTb26eDEgjZJSE6Doo8QU6MYx+JQ@mail.gmail.com> <CAJhGHyC=-bD8L5KSYLp3_tN0WdoCYgtpwNaM_=oLb2c=Gsu+6A@mail.gmail.com>
In-Reply-To: <CAJhGHyC=-bD8L5KSYLp3_tN0WdoCYgtpwNaM_=oLb2c=Gsu+6A@mail.gmail.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Thu, 8 Dec 2022 10:44:16 +0800
Message-ID: <CAJNi4rMDOSq6-ba4CV88E7e-f8Wzq0e6M5bYV8LBS=LzLb7--Q@mail.gmail.com>
Subject: Re: work item still be scheduled to execute after destroy_workqueue?
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Dec 7, 2022 at 10:38 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> On Tue, Dec 6, 2022 at 5:20 PM richard clark
> <richard.xnu.clark@gmail.com> wrote:
> >
> > On Tue, Dec 6, 2022 at 2:23 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> > >
> > > On Tue, Dec 6, 2022 at 12:35 PM richard clark
> > > <richard.xnu.clark@gmail.com> wrote:
> > >
> > > > >
> > > > A WARN is definitely reasonable and has its benefits. Can I try to
> > > > submit the patch and you're nice to review as maintainer?
> > > >
> > > > Thanks,
> > > > Richard
> > > > >
> > >
> > > Sure, go ahead.
> > >
> > > What's in my mind is that the following code is wrapped in a new function:
> > >
> > >         mutex_lock(&wq->mutex);
> > >         if (!wq->nr_drainers++)
> > >                 wq->flags |= __WQ_DRAINING;
> > >         mutex_unlock(&wq->mutex);
> > >
> > >
> > > and the new function replaces the open code drain_workqueue() and
> > > is also called in destroy_workqueue() (before calling drain_workqueue()).
> > >
> > Except that, do we need to defer the __WQ_DRAINING clean to the
> > rcu_call, thus we still have a close-loop of the drainer's count, like
> > this?
>
> No, I don't think we need it. The wq is totally freed in rcu_free_wq.
>
> Or we can just introduce __WQ_DESTROYING.
>
> It seems using __WQ_DESTROYING is better.

The wq->flags will be unreliable after kfree(wq), for example, in my
machine, the wq->flags can be 0x7ec1e1a3, 0x37cff1a3 or 0x7fa23da3 ...
after wq be kfreed, consequently the result of queueing a new work
item to a kfreed wq is undetermined, sometimes it's ok because the
queue_work will return directly(e.g, the wq->flags = 0x7ec1e1a3, a
fake __WQ_DRAINING state), sometimes it will trigger a kernel NULL
pointer dereference BUG when the wq->flags = 0x7fa23da3(fake
!__WQ_DRAINING state).

IMO, given the above condition,  we can handle this in 2 phases:
before the rcu_call and after.
a. before rcu_call. Using __WQ_DESTROYING to allow the chained work
queued in or not in destroy_workqueue(...) level, __WQ_DRAINING is
used to make the drain_workqueue(...) still can be standalone. The
code snippet like this:
destroy_workqueue(...)
{
        mutex_lock(&wq->mutex);
        wq->flags |= __WQ_DESTROYING;
        mutex_lock(&wq->mutex);
        ...
}

__queue_work(...)
{
          if (unlikely((wq->flags & __WQ_DESTROYING) || (wq->flags &
__WQ_DRAINING)) &&
                   WARN_ON_ONCE(!is_chained_work(wq)))
         return;
}

b. after rcu_call. What in my mind is:
rcu_free_wq(struct rcu_head *rcu)
{
          ...
          kfree(wq);
          wq = NULL;
}

__queue_work(...)
{
        if (!wq)
                return;
        ...
}

Any comments?

>
> >
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> >
> > @@ -3528,6 +3526,9 @@ static void rcu_free_wq(struct rcu_head *rcu)
> >
> >         else
> >                 free_workqueue_attrs(wq->unbound_attrs);
> >
> > +       if (!--wq->nr_drainers)
> > +               wq->flags &= ~__WQ_DRAINING;
> > +
> >         kfree(wq);
> >
> > >
> > > __WQ_DRAINING will cause the needed WARN on illegally queuing items on
> > > destroyed workqueue.
> >
> > I will re-test it if there are no concerns about the above fix...
> >
> > >
> > > Thanks
> > > Lai
