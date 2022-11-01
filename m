Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D9161427D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 02:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiKABBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 21:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKABBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:01:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C92F1570A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:01:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d6so21701933lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lxu/7fH4qnqZaMZrs8KHKBvUGF8oky4q+GIQntFw9/A=;
        b=QA6GV/CuWstIBhWhwRbt6ufAHldWFtyTey2Ww2+WXlE00lq1rDankUIEr7+UoKgUBM
         gHBiFRtfHWEDUnYKcQTYTfKvceEYrSstfqQNhyE5RGjlICXQpiCR95192f1Q5yTkKxJ0
         shesLqNR4DmVaNKYDneBkJIC98ZkBLd94BqGrxR+8u5F2FNV0jOElITi1/vj2VrF+iqs
         tn3FYAQoio6zY2qpTAP/wRpJyskSLr1f4Cr/is8MEQWEJnqQC2HGNGC2xSsBmqxrVP7z
         AsE+MGNeH8xQNcs7ISQ4u6rYp+xjy4qFfjfxwNPKH9Yl+KUhhYJACBp8spqkMrAtkmWz
         Q8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lxu/7fH4qnqZaMZrs8KHKBvUGF8oky4q+GIQntFw9/A=;
        b=7Q62tMFf58cOhk8bhkHDhSwIvBrXqx4bEzyifbAPbYBYVaam4/L5I2FuDvtNQRC5/v
         c4xmUMxi+N3CraNO4bg63UTmBc8VuDc184D5TBpFFGgzoLzqpI2RgDKAy5qzL97Lx/ly
         9RYOtL0DC8hgrl3GrE7pDACSDkCEWSoiNEIyuqj6/kcr9A2RB+TxWcJn0OTy/sbV9ccA
         uUhh+Q/b4+idopsoqgUAIkp35BbC66RymKSUDGaVY+ue6R825Z074xfZpJk6GAbVGZDd
         Zj8cJNx1k5qyVXbYGFA2Qtk6NIdFjaJuD6CmGDqV1elNBNhbsJZtOHDLWeIFOIEIswLu
         DW6A==
X-Gm-Message-State: ACrzQf2dUIICMZF9kswv2DQCuRZ9b+LYxleheTDFDLCF1gJ8rU4XQ/W5
        s3SvtY6DiUYzuiFv85dgcPzdLzIL4wGDuD4nKemsFQ==
X-Google-Smtp-Source: AMsMyM7AJdZ26rkAd1iO+cxkJFGHxDkRjZKbPrhTzE9e47XgprAb2gLZp6wVo0jXCpLrhaPZFg4pbSfrQn47bIePjFs=
X-Received: by 2002:a05:6512:2356:b0:4a2:693b:2bc3 with SMTP id
 p22-20020a056512235600b004a2693b2bc3mr6329022lfu.545.1667264492450; Mon, 31
 Oct 2022 18:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221026224449.214839-1-joshdon@google.com> <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
 <CABk29Nu=XcjwRxnGBtKHfknxnDPpspghou06+W0fufnkGF6NkA@mail.gmail.com>
 <Y2BDFNpkSawKnE9S@slm.duckdns.org> <CABk29Nta-RJpTcybgOk9u4DH=1mwQFZsOxFuQ-UpCcTwzjzAuA@mail.gmail.com>
 <Y2Bf+CeQ8x2jKQ3S@slm.duckdns.org>
In-Reply-To: <Y2Bf+CeQ8x2jKQ3S@slm.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 31 Oct 2022 18:01:19 -0700
Message-ID: <CABk29Nvqv-T1JuAq2cf9=AwRu=y1+YOR4xS2qnVo6+XpWd2UNQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
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

On Mon, Oct 31, 2022 at 4:53 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Oct 31, 2022 at 04:15:54PM -0700, Josh Don wrote:
> > On Mon, Oct 31, 2022 at 2:50 PM Tejun Heo <tj@kernel.org> wrote:
> > Yes, but schemes such as shares and idle can still end up creating
> > some severe inversions. For example, a SCHED_IDLE thread on a cpu with
> > many other threads. Eventually the SCHED_IDLE thread will get run, but
> > the round robin times can easily get pushes out to several hundred ms
> > (or even into the seconds range), due to min granularity. cpusets
> > combined with the load balancer's struggle to find low weight tasks
> > exacerbates such situations.
>
> Yeah, especially with narrow cpuset (or task cpu affinity) configurations,
> it can get pretty bad. Outside that tho, at least I haven't seen a lot of
> problematic cases as long as the low priority one isn't tightly entangled
> with high priority tasks, mostly because 1. if the resource the low pri one
> is holding affects large part of the system, the problem is self-solving as
> the system quickly runs out of other things to do 2. if the resource isn't
> affecting large part of the system, their blast radius is usually reasonably
> confined to things tightly coupled with it. I'm sure there are exceptions
> and we definitely wanna improve the situation where it makes sense.

cgroup_mutex and kernfs rwsem beg to differ :) These are shared with
control plane threads, so it is pretty easy to starve those out even
while the system has plenty of work to do.

> > > > chatted with the folks working on the proxy execution patch series,
> > > > and it seems like that could be a better generic solution to these
> > > > types of issues.
> > >
> > > Care to elaborate?
> >
> > https://lwn.net/Articles/793502/ gives some historical context, see
> > also https://lwn.net/Articles/910302/.
>
> Ah, full blown priority inheritance. They're great to pursue but I think we
> wanna fix cpu bw control regardless. It's such an obvious and basic issue
> and given how much problem we have with actually understanding resource and
> control dependencies with all the custom synchronization contstructs in the
> kernel, fixing it will be useful even in the future where we have a better
> priority inheritance mechanism.

Sure, even something like not throttling when there exist threads in
kernel mode (while not a complete solution), helps get some of the way
towards improving that case.

> > > I don't follow. If you only throttle at predefined safe spots, the easiest
> > > place being the kernel-user boundary, you cannot get system-wide stalls from
> > > BW restrictions, which is something the kernel shouldn't allow userspace to
> > > cause. In your example, a thread holding a kernel mutex waking back up into
> > > a hierarchy that is currently throttled should keep running in the kernel
> > > until it encounters such safe throttling point where it would have released
> > > the kernel mutex and then throttle.
> >
> > Agree except that for the task waking back up, it isn't on cpu, so
> > there is no "wait to throttle it until it returns to user", since
> > throttling happens in the context of the entire cfs_rq. We'd have to
>
> Oh yeah, we'd have to be able to allow threads running in kernel regardless
> of cfq_rq throttled state and then force charge the cpu cycles to be paid
> later. It would definitely require quite a bit of work.
>
> > treat threads in a bandwidth hierarchy that are also in kernel mode
> > specially. Mechanically, it is more straightforward to implement the
> > mechanism to wait to throttle until the cfs_rq has no more threads in
> > kernel mode, than it is to exclude a woken task from the currently
> > throttled period of its cfs_rq, though this is incomplete.
>
> My hunch is that bunching them together is likely gonna create too many
> escape scenarios and control artifacts and it'd be better to always push
> throttling decisions to the leaves (tasks) so that each task can be
> controlled separately. That'd involve architectural changes but the eventual
> behavior would be a lot better.

Also a tradeoff, since it is extra overhead to handle individually at
the leaf level vs dequeuing a single cfs_rq.

> > What you're suggesting would also require that we find a way to
> > preempt the current thread to start running the thread that woke up in
> > kernel (and this becomes more complex when the current thread is also
> > in kernel, or if there are n other waiting threads that are also in
> > kernel).
>
> I don't think it needs that. What allows userspace to easily trigger
> pathological scenarios is the ability to force the machine idle when there's
> something which is ready to run in the kernel. If you take that away, most
> of the problems disappear. It's not perfect but reasonable enough and not
> worse than a system without cpu bw control.
>
> Thanks.
>
> --
> tejun
