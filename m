Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52E26BAAFB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjCOIm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjCOImx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:42:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755306BDD2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:42:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id n16so5089422pfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678869772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rxdqas8Nr9L5YkfzOYoQ2j/9mu+KDwKwr4mH5A75l6U=;
        b=r64eBKni3xagkH38F4bIQPd6mlaQynB7F+X9mSpQSAqLQgl4310kwUuvvVJXHi5tPT
         Krgs/kIwpMlmNozMzM5qW/7zHW+plCjP3Fye5F1FEeoAbNt7O2CJawXKdMliWqIRThbO
         xL6uXReqsuA3ajOh2RN5DvTLUz2EOkYTrKvl2wQDSzyfEkGB+f6pSnWMuwo1Mw8cP9gV
         4jkSM3G9yme88Q58SRoTKEfUJk4MSXAtznY1unMw1ZpM5P3FFODPxJPIna428zKblG+a
         nMz++mpKk0p9mRwfFaR0VDRhrXMAUVwFv2NOtnG+9OmFJF8mukM7jQOjuZt4M/hvEinq
         vjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678869772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxdqas8Nr9L5YkfzOYoQ2j/9mu+KDwKwr4mH5A75l6U=;
        b=aAAU+76BjCooN7Jnhz4dlSvy0DdA9E5PS0p4uKRJk4/j8fr83l5BFONGFRSq8VO3wp
         b13YPVz02YISS1hvU4bZTp0SjWlSLuH0gB8FWycptH8Ct5Vi76Np2a2zLUdvUAd0YaUF
         ceFeGlJXxe/WxKelRuXD7F3Tvbnob67VlYeJ8WRGvr5FqkB9+zWXuQ4kKDZP0L1o/00A
         IDjkLpmcC99DmScn4kTaF2k3FflreAKODqVq2goT8Pva3+D2SQF1bE7bxKduVKeF2A0j
         myeYFJV1eMjnc613y1cXRoUi2Zp7P93X8K00H1mG9492RYHOKMpE9nNYgV5/3yUcHt5J
         hKYg==
X-Gm-Message-State: AO0yUKVPVZTVg9/cTXefWz+GfeuCPWmfaFzTPzj9s0Rv/zV/A/5HTE2s
        XncXR5EJCeGxk4HqbKFaJx6jUU0NkXcjAnJwRd+Qxg==
X-Google-Smtp-Source: AK7set+c3QdXera5W7xXucGYHJq1lGtS4ChcaPWl4W733U0QeCAXeLjGr3MCtk/cRFd4a8LCevGjFAHBdqL8yACJrjM=
X-Received: by 2002:a63:381e:0:b0:50a:c1d2:f9a8 with SMTP id
 f30-20020a63381e000000b0050ac1d2f9a8mr3568301pga.11.1678869771865; Wed, 15
 Mar 2023 01:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net> <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book> <02a08042-e7c4-464d-bc20-9ec4ccdab1ff@arm.com>
 <8c093661-7431-00d8-d703-b8f7a7c8e747@arm.com> <CAKfTPtBw9SJxVBcN1qff7jRzE81kXSjbc-rXD6goEBFiXEwbyg@mail.gmail.com>
 <20230314120726.GG1845660@hirez.programming.kicks-ass.net>
 <CAKfTPtBHocw4N-YMHeqfMj78Ro=aF8sJPanxVCN=tM70hr6r8g@mail.gmail.com>
 <20230314171607.GN2017917@hirez.programming.kicks-ass.net> <CAKfTPtBurhAxcykDWQHoSZ0aiokgK4jhamdh-F29643cL1jVsw@mail.gmail.com>
In-Reply-To: <CAKfTPtBurhAxcykDWQHoSZ0aiokgK4jhamdh-F29643cL1jVsw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 15 Mar 2023 09:42:39 +0100
Message-ID: <CAKfTPtCra1QV32w1MZQY2SHVDv58m2MT2QwpHu0huJJ3B1wcCA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 at 08:18, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 14 Mar 2023 at 18:16, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Mar 14, 2023 at 02:24:37PM +0100, Vincent Guittot wrote:
> >
> > > > @@ -7632,11 +7646,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> > > >          * min_vruntime -- the latter is done by enqueue_entity() when placing
> > > >          * the task on the new runqueue.
> > > >          */
> > > > -       if (READ_ONCE(p->__state) == TASK_WAKING) {
> > > > -               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> > > > -
> > > > +       if (READ_ONCE(p->__state) == TASK_WAKING || reset_vruntime(cfs_rq, se))
> > >
> > > That's somehow what was proposed in one of the previous proposals but
> > > we can't call rq_clock_task(rq_of(cfs_rq)) because rq lock might not
> > > be hold and rq task clock has not been updated before being used
> >
> > Argh indeed. I spend a lot of time ensuring we didn't take the old rq
> > lock on wakeup -- and then a lot of time cursing about how we don't :-)
> >
> > Now, if we could rely on the rq-clock being no more than 1 tick behind
> > current, this would still be entirely sufficient to catch the long sleep
> > case.
>
> We should also take care when loading rq_clock_task that we are not
> racing with an update especially for a 32bits system like pelt
> last_update_time

We still have this possibility:
https://lore.kernel.org/lkml/ZAiFxWLSb9HDazSI@vingu-book/

which uses pelt last_update_time when migrating and keep using
rq_clock_task in place_entity

>
> >
> > Except I suppose that NOHZ can bite us here. If the old CPU is idle, the
> > timestamps can be arbitrarily old. Mooo :/
>
> That should not be a real problem because if the cpu is idle and the
> rq clock is not updated, the min_vruntime will not move forward so we
> are "safe" in regard to the overflow.
>
> That's what was done in the v2 and v3 of this patch
>
>
> >
> >
