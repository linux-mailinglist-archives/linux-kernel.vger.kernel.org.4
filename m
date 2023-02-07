Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CE168CBA6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBGBDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBGBDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:03:41 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D5234323
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:03:34 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id c15so11186609oic.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QSj4kxFW4AgQmOuVcsVA7yLCKNqRzPt1gHsxIC0alFE=;
        b=L57lsC6qkeqMTuw6hr/sTfMoa5MUkXLdaizJFyr40dHUdl3mVF97SJV36EqzzxZs3o
         pkExpmDw8bY3kUlDPthP/aGRPXpXK5lptMD1jaJy114p+fhq68OVIkvxXF0jzNpAK8KV
         Y0hSYRmYo+B03JIiIrmSz0rJt6D9Cr2HTpHJr2I5c4fGs19YXl5Kobq7mMlw+vnNBcnI
         mTnZhfcdxwbeaYAr/ngC1R1aaucVGhglTc+lwjXkjo1MSVW3J9Ega6SWdGrdK9Yxb2j8
         oxR4o9BuFNyyc6sq5i5VIiJCi5o7/zJQXHNvExGIlwBq+73KxP8rzIhYspN1xGHZiRvZ
         Ab1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSj4kxFW4AgQmOuVcsVA7yLCKNqRzPt1gHsxIC0alFE=;
        b=GP1koIwixuQhds3gdTOuySCm+wVQvy4+PkryNrkLvV0ec0xY2LLrS+mpfPGlegT2m9
         u4k9aZom1vgYFEu6vxkmUl2ui0CAxKQy2rQm2o5s5mszGlq1O8MCQKy1o4rWAoqOnKLw
         zGVqz04fBfZLVR9Ccvjsky+r0JrU47O1ug2NSDSyIaCfjRRXj7XRDVJFDEZ47y6ckPmP
         Tvj56czIOf9UhcCirxpQTieJdn0+J2HISCBkJb1zsfQzIiSB9M5EeXSX9AjhAn9oFV38
         LkFD3pHRz7SrxYa5Rm5j2RDG6cPDs2dxiDNK6ZxaRowvzBcSbisDsFH59bRQWQFrnaUf
         87hg==
X-Gm-Message-State: AO0yUKVAMzWp0UW055FdBxNDQPeJ3IYcUtcl4CH2Fw8eQ3YWqEqhZ1Lq
        Pngm6lxCttXeWOAKEeSclseUH9zZgzfqGTAs9Ih07r81GcKyRUUlLn8=
X-Google-Smtp-Source: AK7set8oQ2fhqwdZaeCylXp1oQ6nmp4ffA2mFC+unSf2a292VCob5bsMWAYY2XfAY6I8HxWS+iyTqKWwJmfqdFX/Cvs=
X-Received: by 2002:a05:6808:2c6:b0:367:eed:a770 with SMTP id
 a6-20020a05680802c600b003670eeda770mr1247775oid.282.1675731812227; Mon, 06
 Feb 2023 17:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20230201012032.2874481-1-xii@google.com> <Y9zZDcIua63WOdG7@hirez.programming.kicks-ass.net>
 <CAOBoifgz0pRCBUqo7+X2BKgSuHmQLB6X0LZ9D2eYvboO5yzybg@mail.gmail.com> <CAKfTPtCpfrCbi+ZRtBFV0NfQfv9r1oe30BZM4D3_70PQGkxCdw@mail.gmail.com>
In-Reply-To: <CAKfTPtCpfrCbi+ZRtBFV0NfQfv9r1oe30BZM4D3_70PQGkxCdw@mail.gmail.com>
From:   Xi Wang <xii@google.com>
Date:   Mon, 6 Feb 2023 17:03:21 -0800
Message-ID: <CAOBoifh_=fJe6Qk7=Qi+R1fXyjmpVHpHsceUwKrX2e9oVAd5AQ@mail.gmail.com>
Subject: Re: [PATCH] sched: Consider capacity for certain load balancing decisions
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
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

On Mon, Feb 6, 2023 at 1:28 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 3 Feb 2023 at 19:47, Xi Wang <xii@google.com> wrote:
> >
> > On Fri, Feb 3, 2023 at 1:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Jan 31, 2023 at 05:20:32PM -0800, Xi Wang wrote:
> > > > After load balancing was split into different scenarios, CPU capacity
> > > > is ignored for the "migrate_task" case, which means a thread can stay
> > > > on a softirq heavy cpu for an extended amount of time.
> > > >
> > > > By comparing nr_running/capacity instead of just nr_running we can add
> > > > CPU capacity back into "migrate_task" decisions. This benefits
> > > > workloads running on machines with heavy network traffic. The change
> > > > is unlikely to cause serious problems for other workloads but maybe
> > > > some corner cases still need to be considered.
> > > >
> > > > Signed-off-by: Xi Wang <xii@google.com>
> > > > ---
> > > >  kernel/sched/fair.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 0f8736991427..aad14bc04544 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -10368,8 +10368,9 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> > > >                       break;
> > > >
> > > >               case migrate_task:
> > > > -                     if (busiest_nr < nr_running) {
> > > > +                     if (busiest_nr * capacity < nr_running * busiest_capacity) {
> > > >                               busiest_nr = nr_running;
> > > > +                             busiest_capacity = capacity;
> > > >                               busiest = rq;
> > > >                       }
> > > >                       break;
> > >
> > > I don't think this is correct. The migrate_task case is work-conserving,
> > > and your change can severely break that I think.
> > >
> >
> > I think you meant this kind of scenario:
> > cpu 0: idle
> > cpu 1: 2 tasks
> > cpu 2: 1 task but only has 30% of capacity
> > Pulling from cpu 2 is good for the task but lowers the overall cpu
> > throughput.
> >
> > The problem we have is:
> > cpu 0: idle
> > cpu 1: 1 task
> > cpu 2: 1 task but only has 60% of capacity due to net softirq
> > The task on cpu 2 stays there and runs slower. (This can also be
> > considered non work-conserving if we account softirq like a task.)
>
> When load_balance runs for this 2 cpus, cpu2 should be tagged as
> misfit_task because of reduce_capacity and should be selected in
> priority by cpu0 to pull the task. Do you have more details on your
> topology ?

The topology is 64 core AMD with 2 hyperthreads.

I am not familiar with the related code but I think there are cases
where a task fits cpu capacity but it can still run faster elsewhere,
e.g.: Bursty workloads. Thread pool threads with variable utilization
because it would process more or less requests based on cpu
availability (pick the next request from a shared queue when the
previous one is done). A thread having enough cpu cycles but runs
slower due to softirqs can also directly affect application
performance.

> >
> > Maybe the logic can be merged like this: Use capacity but pick from
> > nr_running > 1 cpus first, then nr_running == 1 cpus if not found.
