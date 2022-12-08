Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4048F6469D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 08:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLHHqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 02:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLHHqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 02:46:13 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912C710B5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 23:46:12 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k7so766777pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 23:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4iyFOc6mqeP0ouoUVHWQ24fiUJSM8xa0yloWBaFJIWU=;
        b=hSXLMlS7cq0ZWNmDcq+AQdcH1tqKoCl5GXc5v1woHa9r91Dn311rsGUOCaI8gZkQ2c
         uiXDlUFpWJKEMpO2Jee7vYEWQe4FlDQfwj9LoNSnwOBTYJdBExc+QI3ilnYzuE1hmTfc
         HtS+vbRzZnpPujhe/o+eb+bXlLXQW/tKZZ4gGbzgVrwjJ8SSoL21HUviVnSUNeYw+xYK
         myjcmxfvQUe2zMMgIcbmrr+ibOCW8LpID9yl7WN0YHCiUWVFJ/3ynIUH8n7DV5pJ0xML
         IW/rkN+J404oI3iLaGKgK8eWF0HpVjKril4ilYAN2CKFHmB4xRzFrei2zlydUkiLub2v
         Y3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iyFOc6mqeP0ouoUVHWQ24fiUJSM8xa0yloWBaFJIWU=;
        b=F0UNfRktzFDwu0WiVTUFHC32/X11C6qkDeKPIbLaxOE468kWZcyTvOshaWiy6QKe1F
         1MDUmpBBYzvn6S5/Me5LOjs9JAWkR+p84ZwHxw9GE31njAutkgKR2qazEB16tYg2+TxR
         vnzdvp3fKAkgnG+ozoqGmmOt88LlcVKQ5lSkOw440pVT3no35gMIlWsc0CnrbUvFNlr7
         e/GyZRTyCLyBbVP0MsSA07XB5dooBSTGhgUghr6uPI/NtoUOthjtfF1O72AxgDvwUzut
         48nUIMtD9XdVIRxkcjuIoTE6nB7im26hthjKikf5zizZRnVpBE3ogg/bSxJhjXs6kiF3
         jG0g==
X-Gm-Message-State: ANoB5pk7ihVdK5gPjB5yeMuFNRu6Hx3gtQGRKYMYwxtRJJlY4QinZThs
        OLVRhkoOH5Bmn7/xT+4cqvc44NBPPrqs4f5JljIFhoWis/U=
X-Google-Smtp-Source: AA0mqf7Uc1XJZhtQcKixumA3f4EcFMFZruB0XBpYcddutroGDMHk1NONgcRSlrpBbxqNCNM1I0li/sHtEM5VdJPCzvI=
X-Received: by 2002:a17:902:d510:b0:186:b137:4b42 with SMTP id
 b16-20020a170902d51000b00186b1374b42mr4087976plg.98.1670485572053; Wed, 07
 Dec 2022 23:46:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJNi4rOgYmmtOaXVqYB9sAxDmRhGhS_vVXmZbCbMjvFCQsdjCw@mail.gmail.com>
 <CAJhGHyD+oR8SeYeObJ2DSKfudqBtBOiL14jCsST3L5OG8WjT_g@mail.gmail.com>
 <CAJNi4rOs-=xx5qV-hQQYgSLQCz_q3JuFxJEd+wpPaao8Ej26yQ@mail.gmail.com>
 <CAJhGHyAVbCm6i7pTRDDXgdwS25d5O3uMCvKzyOcafRAdN-S7JQ@mail.gmail.com>
 <CAJNi4rNU0-GVnLMqdGFvHOsTb26eDEgjZJSE6Doo8QU6MYx+JQ@mail.gmail.com>
 <CAJhGHyC=-bD8L5KSYLp3_tN0WdoCYgtpwNaM_=oLb2c=Gsu+6A@mail.gmail.com> <CAJNi4rMDOSq6-ba4CV88E7e-f8Wzq0e6M5bYV8LBS=LzLb7--Q@mail.gmail.com>
In-Reply-To: <CAJNi4rMDOSq6-ba4CV88E7e-f8Wzq0e6M5bYV8LBS=LzLb7--Q@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 8 Dec 2022 15:46:00 +0800
Message-ID: <CAJhGHyAEF8Hi-f1xtWA6jRNbr+hkKv4K_LJytMGF06BD86cZyg@mail.gmail.com>
Subject: Re: work item still be scheduled to execute after destroy_workqueue?
To:     richard clark <richard.xnu.clark@gmail.com>
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

On Thu, Dec 8, 2022 at 10:44 AM richard clark
<richard.xnu.clark@gmail.com> wrote:
>
> On Wed, Dec 7, 2022 at 10:38 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> >
> > On Tue, Dec 6, 2022 at 5:20 PM richard clark
> > <richard.xnu.clark@gmail.com> wrote:
> > >
> > > On Tue, Dec 6, 2022 at 2:23 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> > > >
> > > > On Tue, Dec 6, 2022 at 12:35 PM richard clark
> > > > <richard.xnu.clark@gmail.com> wrote:
> > > >
> > > > > >
> > > > > A WARN is definitely reasonable and has its benefits. Can I try to
> > > > > submit the patch and you're nice to review as maintainer?
> > > > >
> > > > > Thanks,
> > > > > Richard
> > > > > >
> > > >
> > > > Sure, go ahead.
> > > >
> > > > What's in my mind is that the following code is wrapped in a new function:
> > > >
> > > >         mutex_lock(&wq->mutex);
> > > >         if (!wq->nr_drainers++)
> > > >                 wq->flags |= __WQ_DRAINING;
> > > >         mutex_unlock(&wq->mutex);
> > > >
> > > >
> > > > and the new function replaces the open code drain_workqueue() and
> > > > is also called in destroy_workqueue() (before calling drain_workqueue()).
> > > >
> > > Except that, do we need to defer the __WQ_DRAINING clean to the
> > > rcu_call, thus we still have a close-loop of the drainer's count, like
> > > this?
> >
> > No, I don't think we need it. The wq is totally freed in rcu_free_wq.
> >
> > Or we can just introduce __WQ_DESTROYING.
> >
> > It seems using __WQ_DESTROYING is better.
>
> The wq->flags will be unreliable after kfree(wq), for example, in my
> machine, the wq->flags can be 0x7ec1e1a3, 0x37cff1a3 or 0x7fa23da3 ...
> after wq be kfreed, consequently the result of queueing a new work
> item to a kfreed wq is undetermined, sometimes it's ok because the
> queue_work will return directly(e.g, the wq->flags = 0x7ec1e1a3, a
> fake __WQ_DRAINING state), sometimes it will trigger a kernel NULL
> pointer dereference BUG when the wq->flags = 0x7fa23da3(fake
> !__WQ_DRAINING state).

The whole wq is unreliable after destroy_workqueue().

All we need is just adding something to help identify any
wrong usage while the wq is in RCU grace period.

>
> IMO, given the above condition,  we can handle this in 2 phases:
> before the rcu_call and after.
> a. before rcu_call. Using __WQ_DESTROYING to allow the chained work
> queued in or not in destroy_workqueue(...) level, __WQ_DRAINING is
> used to make the drain_workqueue(...) still can be standalone. The
> code snippet like this:
> destroy_workqueue(...)
> {
>         mutex_lock(&wq->mutex);
>         wq->flags |= __WQ_DESTROYING;
>         mutex_lock(&wq->mutex);

Ok, put it before calling drain_workqueue()

>         ...
> }
>
> __queue_work(...)
> {
>           if (unlikely((wq->flags & __WQ_DESTROYING) || (wq->flags &
> __WQ_DRAINING)) &&
>                    WARN_ON_ONCE(!is_chained_work(wq)))

Ok, combine __WQ_DESTROYING and __WQ_DRAINING together as:
           if (unlikely((wq->flags & (__WQ_DESTROYING | __WQ_DRAINING)) &&


>          return;
> }
>
> b. after rcu_call. What in my mind is:
> rcu_free_wq(struct rcu_head *rcu)
> {
>           ...
>           kfree(wq);
>           wq = NULL;

It is useless code.

> }
>
> __queue_work(...)
> {
>         if (!wq)
>                 return;

It is useless code.

>         ...
> }
>
> Any comments?
>
> >
> > >
> > > --- a/kernel/workqueue.c
> > > +++ b/kernel/workqueue.c
> > >
> > > @@ -3528,6 +3526,9 @@ static void rcu_free_wq(struct rcu_head *rcu)
> > >
> > >         else
> > >                 free_workqueue_attrs(wq->unbound_attrs);
> > >
> > > +       if (!--wq->nr_drainers)
> > > +               wq->flags &= ~__WQ_DRAINING;
> > > +
> > >         kfree(wq);
> > >
> > > >
> > > > __WQ_DRAINING will cause the needed WARN on illegally queuing items on
> > > > destroyed workqueue.
> > >
> > > I will re-test it if there are no concerns about the above fix...
> > >
> > > >
> > > > Thanks
> > > > Lai
