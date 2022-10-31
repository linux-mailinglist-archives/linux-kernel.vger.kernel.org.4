Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5537F61416F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJaXQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaXQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:16:10 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECE011C23
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 16:16:08 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u11so18622557ljk.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 16:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VGl7/B1QaSwnqHMqEsDTdAwbkwJgFPjg/uYgARrp8+A=;
        b=fR7xGLQT9t7Z85W2Vn59Sr5HZuR9dy4JV61AaOE8ncBsTAQyvEd0suk57gfEa8gHns
         khYBwJDKuf1ZtLmdJYm5Bltc/PdtSYm+ydoPWpvchcIycd988Y8QYD+ck6ANNFouaYJx
         EHdI/zj2xAK/NMohYLDjvVbRkhakAcFebBsdi9MnjbhLSbf4S+yDczXFq/tYXZKBnEr8
         OgvEVtsmMQ+0l/hz2OeQJfD3AcM7rrbs2BGAf+3zbC1TZ2L28xNJjAOL2ohgs+jBK4Pg
         nfXA02Xx7IKXWdNmzWpCDYg8QxEQfprMhEXG8CtPZLCmBpDD63Iz0vGrrxddw0Dm7t69
         dfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGl7/B1QaSwnqHMqEsDTdAwbkwJgFPjg/uYgARrp8+A=;
        b=gbn/BPozaxHGGi80XADONYYtIqndUcPGMf2OiDOmaI1YgIpusZjK7OoBbUesebF6q6
         dGvEyZmxKXIJQUFrYMZsvdumJnPvrxyrrhAa99How/zpWEAcc/eco/t8HRzCPWc9Xgx4
         cGusi8YWdgNieI6ahWbSRVWUgaPey23l4Da/4QPyTzlW2LzME4aQxkeS2sv6zEkyNeUU
         WEZbZUcGgQBRUAkOGe8DQ37rBzrMZVUe2QaVQLJyJKXWO/bGhJcOW4kbYQUU/WYcHL2k
         Jq5Rjiuy5axmYVflsFsTklhXVW35+XGdFkBWWdntAEoiO8M4bPxrCyjlENOIIqKdwTfB
         +qzw==
X-Gm-Message-State: ACrzQf2uVCZhOXz36hxYfKgP64O/BJ45VYGDw0V8HTyF85InwBkJIj0M
        qJ9fos3RAUgfl7dDSH6KbhHcx3mgCVJCnU+dOkLCfA==
X-Google-Smtp-Source: AMsMyM698EDj4LZbWEce0afeUhXhVulSrUPnkpWUfLmV4yh3Vppwh/SDWx94F15FP71eDVY30AF9YnP3B4qLyTyVros=
X-Received: by 2002:a2e:3e14:0:b0:277:a3b:49dd with SMTP id
 l20-20020a2e3e14000000b002770a3b49ddmr5833032lja.342.1667258166981; Mon, 31
 Oct 2022 16:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221026224449.214839-1-joshdon@google.com> <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
 <CABk29Nu=XcjwRxnGBtKHfknxnDPpspghou06+W0fufnkGF6NkA@mail.gmail.com> <Y2BDFNpkSawKnE9S@slm.duckdns.org>
In-Reply-To: <Y2BDFNpkSawKnE9S@slm.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 31 Oct 2022 16:15:54 -0700
Message-ID: <CABk29Nta-RJpTcybgOk9u4DH=1mwQFZsOxFuQ-UpCcTwzjzAuA@mail.gmail.com>
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

On Mon, Oct 31, 2022 at 2:50 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Oct 31, 2022 at 02:22:42PM -0700, Josh Don wrote:
> > > So, TJ has been complaining about us throttling in kernel-space, causing
> > > grief when we also happen to hold a mutex or some other resource and has
> > > been prodding us to only throttle at the return-to-user boundary.
> >
> > Yea, we've been having similar priority inversion issues. It isn't
> > limited to CFS bandwidth though, such problems are also pretty easy to
> > hit with configurations of shares, cpumasks, and SCHED_IDLE. I've
>
> We need to distinguish between work-conserving and non-work-conserving
> control schemes. Work-conserving ones - such as shares and idle - shouldn't
> affect the aggregate amount of work the system can perform. There may be
> local and temporary priority inversions but they shouldn't affect the
> throughput of the system and the scheduler should be able to make the
> eventual resource distribution conform to the configured targtes.
>
> CPU affinity and bw control are not work conserving and thus cause a
> different class of problems. While it is possible to slow down a system with
> overly restrictive CPU affinities, it's a lot harder to do so severely
> compared to BW control because no matter what you do, there's still at least
> one CPU which can make full forward progress. BW control, it's really easy
> to stall the entire system almost completely because we're giving userspace
> the ability to stall tasks for an arbitrary amount of time at random places
> in the kernel. This is what cgroup1 freezer did which had exactly the same
> problems.

Yes, but schemes such as shares and idle can still end up creating
some severe inversions. For example, a SCHED_IDLE thread on a cpu with
many other threads. Eventually the SCHED_IDLE thread will get run, but
the round robin times can easily get pushes out to several hundred ms
(or even into the seconds range), due to min granularity. cpusets
combined with the load balancer's struggle to find low weight tasks
exacerbates such situations.

> > chatted with the folks working on the proxy execution patch series,
> > and it seems like that could be a better generic solution to these
> > types of issues.
>
> Care to elaborate?

https://lwn.net/Articles/793502/ gives some historical context, see
also https://lwn.net/Articles/910302/.

> > Throttle at return-to-user seems only mildly beneficial, and then only
> > really with preemptive kernels. Still pretty easy to get inversion
> > issues, e.g. a thread holding a kernel mutex wake back up into a
> > hierarchy that is currently throttled, or a thread holding a kernel
> > mutex exists in the hierarchy being throttled but is currently waiting
> > to run.
>
> I don't follow. If you only throttle at predefined safe spots, the easiest
> place being the kernel-user boundary, you cannot get system-wide stalls from
> BW restrictions, which is something the kernel shouldn't allow userspace to
> cause. In your example, a thread holding a kernel mutex waking back up into
> a hierarchy that is currently throttled should keep running in the kernel
> until it encounters such safe throttling point where it would have released
> the kernel mutex and then throttle.

Agree except that for the task waking back up, it isn't on cpu, so
there is no "wait to throttle it until it returns to user", since
throttling happens in the context of the entire cfs_rq. We'd have to
treat threads in a bandwidth hierarchy that are also in kernel mode
specially. Mechanically, it is more straightforward to implement the
mechanism to wait to throttle until the cfs_rq has no more threads in
kernel mode, than it is to exclude a woken task from the currently
throttled period of its cfs_rq, though this is incomplete.

What you're suggesting would also require that we find a way to
preempt the current thread to start running the thread that woke up in
kernel (and this becomes more complex when the current thread is also
in kernel, or if there are n other waiting threads that are also in
kernel).

>
> Thanks.
>
> --
> tejun

Best,
Josh
