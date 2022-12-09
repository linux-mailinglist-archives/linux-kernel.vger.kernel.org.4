Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91BF647C3D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLICZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLICZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:25:28 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C21A4307
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:25:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q7so3822275wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 18:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1K/3GUYMBBM0JWTkpD5AOt6IFxw20f5QEF2hH5GOc2U=;
        b=givek1J38a1InAvDzqJ2IJpDTNNkY/0qnKpwXJ0YWKO1lRTOvqkv2jZmvFu4JDsTl7
         qpHxNx0IwT4Q8LLjxOpVyjcYbR7kkDpuZ4l1wxDyP94vsMGGsZO61IvUMyLbiyABPB71
         gCzPklAqagS+oYxqhUivsCoCNLKDcDIJfypznV/ZTyVBGcLeQRBfcOz0y/aV/I+bp6Qw
         fzK/VhjtGOoBlnj+hlHktP/j3mjhLznjPr1GcNyJ33hYSN3twXzl/JVR0d60H18ojDvz
         Z1feJkTUGvzXEbojAqWFur4SO2msfJx1Lj0/X+xF/fCPQMTS0wmu9tNqBzmNHXVxKhL1
         XM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1K/3GUYMBBM0JWTkpD5AOt6IFxw20f5QEF2hH5GOc2U=;
        b=SpXwkHITaxQzYUTDUV/0sigPbRsc7dUQ0hud5/Any4tmghxkzcpmVUrazXhXsAmDL7
         kNVlb1MkET+ml9DnlS6pbq8CMgFyprCA3QflGVlK9zm3dMo+nUDyPFAwRcNfrE6AJFOZ
         MO6hpDQq8dRUEY+5la2N5FYbpE7tRQ6ecdbONVX+KcTit+6YllKzdQzL53uZld7pERnY
         zog8XepWH/BsX4m2PMfBjI8s0f8EaH1a6QV0ve9HuyGUfkQRNhPeVaJ774i6pSpRZsxO
         aAWULR1dw7IGzZNWNy1lW3edpsbVeZtFlXoC305ScTtVv+4zsWVAZmdYPVtPDAeoRY+p
         q55Q==
X-Gm-Message-State: ANoB5plYi8nSEKz2Cu7Xaz9vgDb0QdzszoDnIr4+KJXV9N5baGtsNkZv
        AhCKtismqIcCLSE0Rwuf3Gp2vXmH63uiaSbfshs+sBmu
X-Google-Smtp-Source: AA0mqf6PKBRdFHik+PWcuanXuP00guianJCZf+aYyJ7ohHmBCQtsxeTovNouCphfjnJjSSTzXT/nGuaDFFnLQvOuOq8=
X-Received: by 2002:a5d:58e6:0:b0:242:5562:6d6 with SMTP id
 f6-20020a5d58e6000000b00242556206d6mr12030563wrd.541.1670552725763; Thu, 08
 Dec 2022 18:25:25 -0800 (PST)
MIME-Version: 1.0
References: <CAJNi4rOgYmmtOaXVqYB9sAxDmRhGhS_vVXmZbCbMjvFCQsdjCw@mail.gmail.com>
 <CAJhGHyD+oR8SeYeObJ2DSKfudqBtBOiL14jCsST3L5OG8WjT_g@mail.gmail.com>
 <CAJNi4rOs-=xx5qV-hQQYgSLQCz_q3JuFxJEd+wpPaao8Ej26yQ@mail.gmail.com>
 <CAJhGHyAVbCm6i7pTRDDXgdwS25d5O3uMCvKzyOcafRAdN-S7JQ@mail.gmail.com>
 <CAJNi4rNU0-GVnLMqdGFvHOsTb26eDEgjZJSE6Doo8QU6MYx+JQ@mail.gmail.com>
 <CAJhGHyC=-bD8L5KSYLp3_tN0WdoCYgtpwNaM_=oLb2c=Gsu+6A@mail.gmail.com>
 <CAJNi4rMDOSq6-ba4CV88E7e-f8Wzq0e6M5bYV8LBS=LzLb7--Q@mail.gmail.com> <CAJhGHyAEF8Hi-f1xtWA6jRNbr+hkKv4K_LJytMGF06BD86cZyg@mail.gmail.com>
In-Reply-To: <CAJhGHyAEF8Hi-f1xtWA6jRNbr+hkKv4K_LJytMGF06BD86cZyg@mail.gmail.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Fri, 9 Dec 2022 10:25:14 +0800
Message-ID: <CAJNi4rNjQdQG4MLUBQ+qEr1rHWtzzRAFTk9cvAbkdEpWz8OOhg@mail.gmail.com>
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

On Thu, Dec 8, 2022 at 3:46 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> On Thu, Dec 8, 2022 at 10:44 AM richard clark
> <richard.xnu.clark@gmail.com> wrote:
> >
> > On Wed, Dec 7, 2022 at 10:38 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> > >
> > > On Tue, Dec 6, 2022 at 5:20 PM richard clark
> > > <richard.xnu.clark@gmail.com> wrote:
> > > >
> > > > On Tue, Dec 6, 2022 at 2:23 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> > > > >
> > > > > On Tue, Dec 6, 2022 at 12:35 PM richard clark
> > > > > <richard.xnu.clark@gmail.com> wrote:
> > > > >
> > > > > > >
> > > > > > A WARN is definitely reasonable and has its benefits. Can I try to
> > > > > > submit the patch and you're nice to review as maintainer?
> > > > > >
> > > > > > Thanks,
> > > > > > Richard
> > > > > > >
> > > > >
> > > > > Sure, go ahead.
> > > > >
> > > > > What's in my mind is that the following code is wrapped in a new function:
> > > > >
> > > > >         mutex_lock(&wq->mutex);
> > > > >         if (!wq->nr_drainers++)
> > > > >                 wq->flags |= __WQ_DRAINING;
> > > > >         mutex_unlock(&wq->mutex);
> > > > >
> > > > >
> > > > > and the new function replaces the open code drain_workqueue() and
> > > > > is also called in destroy_workqueue() (before calling drain_workqueue()).
> > > > >
> > > > Except that, do we need to defer the __WQ_DRAINING clean to the
> > > > rcu_call, thus we still have a close-loop of the drainer's count, like
> > > > this?
> > >
> > > No, I don't think we need it. The wq is totally freed in rcu_free_wq.
> > >
> > > Or we can just introduce __WQ_DESTROYING.
> > >
> > > It seems using __WQ_DESTROYING is better.
> >
> > The wq->flags will be unreliable after kfree(wq), for example, in my
> > machine, the wq->flags can be 0x7ec1e1a3, 0x37cff1a3 or 0x7fa23da3 ...
> > after wq be kfreed, consequently the result of queueing a new work
> > item to a kfreed wq is undetermined, sometimes it's ok because the
> > queue_work will return directly(e.g, the wq->flags = 0x7ec1e1a3, a
> > fake __WQ_DRAINING state), sometimes it will trigger a kernel NULL
> > pointer dereference BUG when the wq->flags = 0x7fa23da3(fake
> > !__WQ_DRAINING state).
>
> The whole wq is unreliable after destroy_workqueue().
>
> All we need is just adding something to help identify any
> wrong usage while the wq is in RCU grace period.
>
OK, understood!
> >
> > IMO, given the above condition,  we can handle this in 2 phases:
> > before the rcu_call and after.
> > a. before rcu_call. Using __WQ_DESTROYING to allow the chained work
> > queued in or not in destroy_workqueue(...) level, __WQ_DRAINING is
> > used to make the drain_workqueue(...) still can be standalone. The
> > code snippet like this:
> > destroy_workqueue(...)
> > {
> >         mutex_lock(&wq->mutex);
> >         wq->flags |= __WQ_DESTROYING;
> >         mutex_lock(&wq->mutex);
>
> Ok, put it before calling drain_workqueue()
>
> >         ...
> > }
> >
> > __queue_work(...)
> > {
> >           if (unlikely((wq->flags & __WQ_DESTROYING) || (wq->flags &
> > __WQ_DRAINING)) &&
> >                    WARN_ON_ONCE(!is_chained_work(wq)))
>
> Ok, combine __WQ_DESTROYING and __WQ_DRAINING together as:
>            if (unlikely((wq->flags & (__WQ_DESTROYING | __WQ_DRAINING)) &&
>
>
> >          return;
> > }
> >
> > b. after rcu_call. What in my mind is:
> > rcu_free_wq(struct rcu_head *rcu)
> > {
> >           ...
> >           kfree(wq);
> >           wq = NULL;
>
> It is useless code.
>
> > }
> >
> > __queue_work(...)
> > {
> >         if (!wq)
> >                 return;
>
> It is useless code.

OK, will remove the above codes in the patch...

>
> >         ...
> > }
> >
> > Any comments?
> >
> > >
> > > >
> > > > --- a/kernel/workqueue.c
> > > > +++ b/kernel/workqueue.c
> > > >
> > > > @@ -3528,6 +3526,9 @@ static void rcu_free_wq(struct rcu_head *rcu)
> > > >
> > > >         else
> > > >                 free_workqueue_attrs(wq->unbound_attrs);
> > > >
> > > > +       if (!--wq->nr_drainers)
> > > > +               wq->flags &= ~__WQ_DRAINING;
> > > > +
> > > >         kfree(wq);
> > > >
> > > > >
> > > > > __WQ_DRAINING will cause the needed WARN on illegally queuing items on
> > > > > destroyed workqueue.
> > > >
> > > > I will re-test it if there are no concerns about the above fix...
> > > >
> > > > >
> > > > > Thanks
> > > > > Lai
