Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3432F6DEC03
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjDLGoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLGoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:44:17 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DC9E4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:44:16 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54f21cdfadbso150897487b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681281855;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=kahlnJIARqP+B9iL8vl9A0voFNIx2I82qFL0OpT+a18=;
        b=BL0vktON4J328Wb/ctapGdEoic8GSXQbFA1jA2aMhEM+Ooq1IG4Xk0aErifCT6Lpoj
         ndXuUPqCj8fnjRkR0AWKmW5tYMxEChQH6JuSQgp5Uw0rDl7/K4umdTYR3uTt6bQuYfiN
         de0/fl+WIxmeqCXbAoFy5S7da+BqTVKqRd6HjcbWtR/BoVC1MfMOKs1G4M3rr9jcIdB/
         +noPQ9nhI1FqtXiXOT3FqO6O/47OSjzZY764/TwC1p8UDilEYTYyKIWkv1psdSAXaBQY
         fdaJU2l3Ja1/bTWXiXp1ifdvJKDQY7yYoAW3LNA6DrEDhGSaJ1efN/4GMq7tK9qEEad0
         IQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681281855;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kahlnJIARqP+B9iL8vl9A0voFNIx2I82qFL0OpT+a18=;
        b=NAgscsL9PIJApK8vaWJSNHePomJ7ad/QUPpxH61DHvxJjaXbj8LpoZ0+AIvHWzsD9e
         9A3AdFXnf8pp/rEnwdAizKteyYO6qc2ef+GoNg7HiqSANHE03qZdQI8f5odwIftmIRjg
         GIaE/CwErPiiKslwQic6TgphlWaLX5FXLHPHR941YLpVpCaWC/sKcHUCYoUMpzqNlz0N
         DUoJqZbuRe9QUIxes/uNxFH8uR+pbjzxrrw0Tums6y6xK7m8lQoycEMKmIuVERkfsAuP
         wvgdDybfY2fb+HvBtpjCIE7qRBUNhuvk5WWIXvq2U2oRyAHSPzZiH3HbIOnXKAJO7QQm
         SP+A==
X-Gm-Message-State: AAQBX9e2szro0f0gsbtNkrIwwm54XmI05HaxT2Z3VP/TCYwnWIguqUSJ
        YMGbPHal7riUDJfHwTl0gKhWWNWitWQ=
X-Google-Smtp-Source: AKy350ZB9oSKBtfzBwHSeVgmEtMh8c8qfNX9Py/mzWVlFtw9PaHx8n86jSodny1V8zQwLGedwrAxeQ==
X-Received: by 2002:a81:a186:0:b0:54f:29d:1bc7 with SMTP id y128-20020a81a186000000b0054f029d1bc7mr1012598ywg.3.1681281855134;
        Tue, 11 Apr 2023 23:44:15 -0700 (PDT)
Received: from SchspadeMacBook-Pro.local (ec2-18-117-95-84.us-east-2.compute.amazonaws.com. [18.117.95.84])
        by smtp.gmail.com with ESMTPSA id 184-20020a8105c1000000b00545a08184e9sm2715526ywf.121.2023.04.11.23.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 23:44:14 -0700 (PDT)
References: <20220828170303.171400-1-schspa@gmail.com>
 <20220828170303.171400-2-schspa@gmail.com>
 <xhsmhh6tt9qde.mognet@vschneid.remote.csb>
User-agent: mu4e 1.10.1; emacs 29.0.60
From:   Schspa Shi <schspa@gmail.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] sched/rt: Trying to push current task when
 target disable migrating
Date:   Wed, 12 Apr 2023 11:44:40 +0800
In-reply-to: <xhsmhh6tt9qde.mognet@vschneid.remote.csb>
Message-ID: <m2r0spior1.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Valentin Schneider <vschneid@redhat.com> writes:

> On 29/08/22 01:03, Schspa Shi wrote:
>> When the task to push disable migration, retry to push the current
>> running task on this CPU away, instead doing nothing for this migrate
>> disabled task.
>>
>> CC: Valentin Schneider <vschneid@redhat.com>
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> ---
>>  kernel/sched/core.c     | 13 ++++++++++++-
>>  kernel/sched/deadline.c |  9 +++++++++
>>  kernel/sched/rt.c       |  8 ++++++++
>>  3 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index ee28253c9ac0c..056b336c29e70 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2503,8 +2503,19 @@ int push_cpu_stop(void *arg)
>>       if (p->sched_class->find_lock_rq)
>>               lowest_rq = p->sched_class->find_lock_rq(p, rq);
>>
>> -	if (!lowest_rq)
>> +	if (!lowest_rq) {
>> +		/*
>> +		 * The find_lock_rq function above could have released the rq
>> +		 * lock and allow p to schedule and be preempted again, and
>> +		 * that lowest_rq could be NULL because p now has the
>> +		 * migrate_disable flag set and not because it could not find
>> +		 * the lowest rq. So we must check task migration flag again.
>> +		 */
>> +		if (unlikely(is_migration_disabled(p)))
>> +			p->migration_flags |= MDF_PUSH;
>> +
>
> Given p has to be on this rq initially, this implies p being migrated away
> to become migration_disabled() (it *can't* be scheduled while the stopper
> is running), in which case it's not on this rq anymore, so do we care?
>

Yes, you are right, we have already have a correct handle for this.

>>               goto out_unlock;
>> +	}
>>
>>       // XXX validate p is still the highest prio task
>>       if (task_rq(p) == rq) {
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index e7eea6cde5cb9..c8055b978dbc3 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2340,6 +2340,15 @@ static int push_dl_task(struct rq *rq)
>>                */
>>               task = pick_next_pushable_dl_task(rq);
>>               if (task == next_task) {
>> +			/*
>> +			 * If next task has now disabled migrating, see if we
>> +			 * can do resched_curr().
>> +			 */
>> +			if (unlikely(is_migration_disabled(task))) {
>> +				put_task_struct(next_task);
>> +				goto retry;
>> +			}
>> +
>>                       /*
>>                        * The task is still there. We don't try
>>                        * again, some other CPU will pull it when ready.
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 57e8cd5c9c267..381ec05eb2701 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -2139,6 +2139,14 @@ static int push_rt_task(struct rq *rq, bool pull)
>>                */
>>               task = pick_next_pushable_task(rq);
>>               if (task == next_task) {
>> +			/*
>> +			 * If next task has now disabled migrating, see if we
>> +			 * can push the current task.
>> +			 */
>> +			if (unlikely(is_migration_disabled(task))) {
>> +				put_task_struct(next_task);
>> +				goto retry;
>> +			}
>
> Similarly here, if the task has been through a switch-in / switch-out
> cycle, then at least for RT we'd have
>
>   set_next_task_rt()
>   `\
>     rt_queue_push_tasks()
>
> which will take care of it.
>

Yes, it will take care of this.

> If the task is preempted by e.g. a DL task, then the retry would fail on
>
>   (next_task->prio < rq->curr->prio)
>

It may fail most of the time, but push_rt_task can run on a different
CPU (the rq != this_rq()), and the rq->curr can be changed. the retry
won't fail in this case. It is the same with the deadline.c.

> and I'm thinking the same logic applies to the deadline.c. IOW, it looks
> like we're already doing the right thing here when the task gets scheduled
> out, so I don't think we need any of this.
>
>>                       /*
>>                        * The task hasn't migrated, and is still the next
>>                        * eligible task, but we failed to find a run-queue
>> --
>> 2.37.2

-- 
BRs
Schspa Shi
