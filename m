Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03286682B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjAaLKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjAaLKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:10:42 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E405B199E2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:10:41 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so14137024pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHn2RlCWgEPMJaJl2KYNu0r6wVHCQyftzO1oaC9lWkk=;
        b=YaWUC0XeqpXbLPxD/IVoP1R53PbKGxE3i33oTruTx3AoCkAON1VP1S/TvAJesBsZMg
         e+um68Lg2lLCrTmIegSO2HXa6jgDOYSaglWk82X7UExwVUq+Lzr7x7nqO0484O9+6xBw
         UwIUN82YzX8rkWKhwaZdloCc2WqP8PYOc5bXjsGiKn8WCAH3G41U1/di5XNT1fajM0kq
         +OnpK/ChG/yQTC4td+VBXuf6xFd3qr9XwU/vFjeYQkjKN6nzm/5eMD7+WNpUXZEQVlFz
         mZun6xLs4O6Affv6RXPBZ90OMoL276EDcENLQKfw/ELj0CeyjPm4m+URb/ChfaCzHxac
         ScFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHn2RlCWgEPMJaJl2KYNu0r6wVHCQyftzO1oaC9lWkk=;
        b=YHU35rsy3Bx3c+CBOWMitpS563nfrqPjGkUtB6+Es83p2a/2ByvD2v2ipJ6e9KXa62
         99XvTV9L1cSVJ5VbNW97VHWRktx5pWqCm1+PmOtebbS26xFIDsJFxqBX2Nbwo2HZn5H5
         NZF393pgihDW5DXNyUMSc17rPe8xqBJYi6s2TjKMC63NYlC8ZOyClkJt8MTmN/oLu7la
         htPMn/BiYnkntJt91y/TGh0d4Joatn1uoCRF9qe7zh8mJJz+RWqVN4c2rniow0mQh70O
         stAwyIegicsqdGPUpVdbRPGldeVbjLaJg3rOq0bzyIsrG3ZHfGowZyIwrCEF3SW/Y5S1
         72pQ==
X-Gm-Message-State: AO0yUKU7d8Qf2bi/+Osd/YQASEMgupTioIhc0xzdBcQ8QoOYN4qnIU1S
        rf/kjLy4W6TCtBKNtdySJJ47c+Gt451F0CE3kHkS4RN5lHN3Xg==
X-Google-Smtp-Source: AK7set88XwN7yUzP2xy88RlHmBIuA625+GKIV1h6+Cop9i/RveIN7gi91Dcx0H6bUa7fK2Lju8WFFcDV1VZGvYXkfhA=
X-Received: by 2002:a17:90a:c281:b0:22e:601e:94cf with SMTP id
 f1-20020a17090ac28100b0022e601e94cfmr554052pjt.132.1675163441186; Tue, 31 Jan
 2023 03:10:41 -0800 (PST)
MIME-Version: 1.0
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
 <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net> <Y9GG3N5ivVvyETa2@u40bc5e070a0153.ant.amazon.com>
 <Y9J25xMrItpeHIxD@hirez.programming.kicks-ass.net> <Y9LG5vkf/4ufJb35@u40bc5e070a0153.ant.amazon.com>
 <Y9O5Fwfib2CVAMwl@hirez.programming.kicks-ass.net> <CAKfTPtBMSg2SDXq=sVt99TyM+tEXRFL74EQ57-t5uKYAXUUyLg@mail.gmail.com>
 <Y9iJLQxyXp9+x2aF@chenyu5-mobl1> <Y9jmm5c5vT8WXsl6@u40bc5e070a0153.ant.amazon.com>
In-Reply-To: <Y9jmm5c5vT8WXsl6@u40bc5e070a0153.ant.amazon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 31 Jan 2023 12:10:29 +0100
Message-ID: <CAKfTPtDUMph262w5OSiSQi-BVcNRf2gN=PdmxYCKEuk-8aYhgA@mail.gmail.com>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
To:     Roman Kagan <rkagan@amazon.de>, Chen Yu <yu.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 at 11:00, Roman Kagan <rkagan@amazon.de> wrote:
>
> On Tue, Jan 31, 2023 at 11:21:17AM +0800, Chen Yu wrote:
> > On 2023-01-27 at 17:18:56 +0100, Vincent Guittot wrote:
> > > On Fri, 27 Jan 2023 at 12:44, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Thu, Jan 26, 2023 at 07:31:02PM +0100, Roman Kagan wrote:
> > > >
> > > > > > All that only matters for small sleeps anyway.
> > > > > >
> > > > > > Something like:
> > > > > >
> > > > > >         sleep_time = U64_MAX;
> > > > > >         if (se->avg.last_update_time)
> > > > > >           sleep_time = cfs_rq_clock_pelt(cfs_rq) - se->avg.last_update_time;
> > > > >
> > > > > Interesting, why not rq_clock_task(rq_of(cfs_rq)) - se->exec_start, as
> > > > > others were suggesting?  It appears to better match the notion of sleep
> > > > > wall-time, no?
> > > >
> > > > Should also work I suppose. cfs_rq_clock takes throttling into account,
> > > > but that should hopefully also not be *that* long, so either should
> > > > work.
> > >
> > > yes rq_clock_task(rq_of(cfs_rq)) should be fine too
> > >
> > > Another thing to take into account is the sleeper credit that the
> > > waking task deserves so the detection should be done once it has been
> > > subtracted from vruntime.
> > >
> > > Last point, when a nice -20 task runs on a rq, it will take a bit more
> > > than 2 seconds for the vruntime to be increased by more than 24ms (the
> > > maximum credit that a waking task can get) so threshold must be
> > > significantly higher than 2 sec. On the opposite side, the lowest
> > > possible weight of a cfs rq is 2 which means that the problem appears
> > > for a sleep longer or equal to 2^54 = 2^63*2/1024. We should use this
> > > value instead of an arbitrary 200 days
> > Does it mean any threshold between 2 sec and 2^54 nsec should be fine? Because
> > 1. Any task sleeps longer than 2 sec will get at most 24 ms(sysctl_sched_latency)
> >    'vruntime bonus' when enqueued.

This means that if a task nice -20 runs on cfs rq while your task is
sleeping 2seconds, the min vruntime of the cfs rq will increase by
24ms. If there are 2 nice -20 tasks then the min vruntime will
increase by 24ms after 4 seconds and so on ...

On the other side, a task nice 19 that runs 1ms will increase its
vruntime by around 68ms.

So if there is 1 task nice 19 with 11 tasks nice -20 on the same cfs
rq, the nice -19 one should run 1ms every 65 seconds and this also
means that the vruntime of task nice -19 should still be above
min_vruntime after sleeping 60 seconds. Of course this is even worse
with a child cgroup with the lowest weight (weight of 2 instead of 15)

Just to say that 60 seconds is not so far away and 2^54 should be better IMHO


> > 2. Although a low weight cfs rq run for 2^54 nsec could trigger the overflow,
> >    we can choose threshold lower than 2^54 to avoid any overflow.
>
> This matches my understanding too, so I went ahead with the value
> proposed by Peter (1 min) which looked sufficiently far away from either
> side.
>
> Roman.
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>
