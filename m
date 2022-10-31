Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40FB6131CF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJaIkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJaIjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:39:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506BA64CF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:39:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso9689011pjc.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWtXktngxSJB/QmxVvTY8rxmzbN+5y6DJV+qS769RJc=;
        b=7esHwKsYR7S/kTDG3yYQm+ocM/NjcIGk2jHgqQ7YUpCZUDHwh/huPaj5AP8jRKArK2
         VHxF0Sxc+fTl46UjGJJFuFshgfRR6V4LvN06gB8+0AD0gRoCfV/aJnKW5HOBmQ/1cijW
         nCVmIK9J+PyBBzt4y4HxGBQGbEZshqlhD9DLJ4S6y8UcDhMTrknm6Qc3oEhBOIHp4Kzr
         2zqlJOcp2IH8/aCNk/hdGdNjeJHWCbVwxe//BhZnSQBibNLQ8QhPWUgnBb5EMmV7bYlq
         HdUJcc9BMvAAcEyKi/WRwrGksru/g9ewDLRJ38J3dlw+j+UHEJb5QNakO71WMHOlElOE
         YT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UWtXktngxSJB/QmxVvTY8rxmzbN+5y6DJV+qS769RJc=;
        b=oe3zeBeLjQR9DxfxT5ZUSTKHDEPWBXkpugXS1Jqz7SQAOMA7JVqp8sY2oiLS/POD5q
         1q1kSEno703bAu+hpOe/bkFyIvwfOkJIkXQdtUkQrdlcEMR6JfkXBhQ5vge9TIlJJJXg
         xfkyOforwvABHBVP+qWdm/ajdP9x5DGLX6fl0A7QxL0p+Fc5SbIG4bFRTxG/05LJG/ez
         ET7tkoLp0zOcw8ONjUdhuj3TmrBoq9dbbqm6f2T0xA3Yu2A+LlefH+a358wiV9wUeqVX
         EFnP78wFpaoPxNu/scGKSPT0zlYRU4rfd3UvU03KqOjmU33MUSjHXAVriHUYMezJ1U1a
         YJow==
X-Gm-Message-State: ACrzQf03YEMxuFS1WKaF4uFP5u9hW+lhHcqkMbeoLe9EdHBsCuUhDd9+
        W9yP85WIPL85c81MmLcHS+RBJg==
X-Google-Smtp-Source: AMsMyM6tTYWr7yZH9NDZKJ5mdzgo+g9uGd7K9NMnCtJy3aGjVPHaOqdeo9rOZjQE9c3v1VeFkQi9cA==
X-Received: by 2002:a17:903:2c7:b0:186:9862:d16c with SMTP id s7-20020a17090302c700b001869862d16cmr13123580plk.133.1667205589795;
        Mon, 31 Oct 2022 01:39:49 -0700 (PDT)
Received: from [10.85.117.81] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902ecc300b001868ed86a95sm3922362plh.174.2022.10.31.01.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 01:39:49 -0700 (PDT)
Message-ID: <5af26ac9-3bdb-32d2-77a7-6cd8feca97aa@bytedance.com>
Date:   Mon, 31 Oct 2022 16:39:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH] sched/fair: favor non-idle group in tick preemption
To:     Josh Don <joshdon@google.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
References: <20221027081630.34081-1-zhouchuyi@bytedance.com>
 <CABk29NtDny9qKZbZZ_i8Brwjtqs5GA0G4_SffzK4HzG3RrXVhQ@mail.gmail.com>
 <64d963b6-2d9c-3f93-d427-a1ff705fb65a@bytedance.com>
 <CABk29NsbGuMPcA8NJagMfPyHij3864F3DVQ6wpCj3UAo8tbFNQ@mail.gmail.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CABk29NsbGuMPcA8NJagMfPyHij3864F3DVQ6wpCj3UAo8tbFNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/29 06:40, Josh Don 写道:
> On Thu, Oct 27, 2022 at 8:57 PM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>>
>>
>> 在 2022/10/28 07:34, Josh Don 写道:
>>> Hi Chuyi,
>>>
>>> On Thu, Oct 27, 2022 at 1:16 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>>>
>>>> The non-idle se dominates competition vs the idle se when they
>>>> are belong to the same group. We ensure that idle groups would not
>>>> preempt non-idle group in wakeup preemption(see check_preempt_wakeup()).
>>>> However, this can happen in tick preemption, since check_preempt_tick()
>>>> dose not check current/se is idle or not. This patch adds this check.
>>>>
>>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>>> ---
>>>>    kernel/sched/fair.c | 12 +++++++++++-
>>>>    1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index e4a0b8bd941c..f3324b8753b3 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -4750,6 +4750,7 @@ static void
>>>>    check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>>>    {
>>>>           unsigned long ideal_runtime, delta_exec;
>>>> +       int cse_is_idle, pse_is_idle;
>>>>           struct sched_entity *se;
>>>>           s64 delta;
>>>>
>>>> @@ -4779,8 +4780,17 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>>>           if (delta < 0)
>>>>                   return;
>>>>
>>>> -       if (delta > ideal_runtime)
>>>> +       if (delta > ideal_runtime) {
>>>> +               /*
>>>> +                * Favor non-idle group even in tick preemption
>>>> +                */
>>>> +               cse_is_idle = se_is_idle(curr);
>>>> +               pse_is_idle = se_is_idle(se);
>>>> +               if (unlikely(!cse_is_idle && pse_is_idle))
>>>> +                       return;
>>>
>> Hi Josh, thanks for your reply,
>>> This would make it so that we never have tick based preemption of a
>>> non-idle entity by an idle entity. That's a recipe for starvation of
>>> the idle entity, if the non-idle entity is cpu bound.
>>>
>>> Beyond that though, I'm not quite sure the issue being solved here.
>>> The large difference in weight between the idle and non-idle entity
>>> means that the non-idle entity will not be preempted for quite a while
>>> due to its ideal_runtime being quite high. The idle entity will
>>> quickly be preempted on the next tick it takes due to the smaller
>>> value of sysctl_sched_idle_min_granularity.
>>>
>> Actually, I did some tests and traced this issue. the result shows that
>> this can happen with small probability. I also do some benchmarks. The
>> result seems it has no performance harm, and we can reduce 2%～3%
>> context switch when idle group & non-idle group are present at the same
>> time. In addition, for throughput concern, I think we better let
>> non-idle entity consume it's ideal_runtime. However, as you said, it may
>> cause starvation of the idle entity.....
> 
> I don't doubt it improves the performance of the non-idle entity, but
> it is never advisable to indefinitely starve threads. That's a recipe
> for hard lockups, priority inversion, etc.
> 
> Does your non-idle entity have a reasonable number of cpu.shares? You
> can push out the round-robin interval by tuning CFS parameters without
> completely starving the idle entity.
> 
>> There is another question I would like to take this opportunity to
>> consult you. In our production environment, in some cases, we want to
>> adjust the weight/shares of the idle-cgroup which means we need to
>> change the logic of sched_group_set_shares(), and it can increase the
>> probability of the above issue. So, for what reasons did you prohibit
>> users from changing weights of idle cgroup.
> 
> The reason for limiting the control of weight for idle cgroups is to
> match the semantics of the per-task SCHED_IDLE api, which gives
> SCHED_IDLE threads minimum weight. The idea behind SCHED_IDLE is that
> these entities are intended to soak "unused" cpu cycles, and should
> give minimal interference to any non-idle thread. However, we don't
> have strict priority between idle and non-idle, due to the potential
> for starvation issues.
> 
> Perhaps you could clarify your use case a bit further. Why do you want
> to change the weight? Is it to adjust the competition between two idle
> groups, or something else?
> 
Suppose we have two cgroups（idle & non-idle）in /sys/fs/cgroup/cpu.
Idle cgroup contains some offline service, such as beg data processing; 
non-idle cgroup contains some online service which have
higher priority to users and are sensitive to latency. We set
quota/period for idle cgroup which indicates it's *cpu limit*.
In general, we consider that the idle cgroup's cpu usage
closer to the limit, the better. However, when the system is busy,
the idle cgroups can only get little cpu resources with minimum weight. 
To cope with the above situation, we changed the default weight.

One more question is, why you think this patch can strave idle entity?
	
	/*
	 * Ensure that a task that missed wakeup preemption by a
	 * narrow margin doesn't have to wait for a full slice.
	 * This also mitigates buddy induced latencies under load.
	 */
	se = __pick_first_entity(cfs_rq);
	delta = curr->vruntime - se->vruntime;

	if (delta < 0)
		return;

	if (delta > ideal_runtime)
		resched_curr(rq_of(cfs_rq));

se can preempt curr only when
	curr->vruntime > se->vruntime &&
		curr->vruntime - se->vruntime > ideal_runtime
is true. I think the original purpose is that se doesn't have to wait 
for a full slice, reduce response time if se is latency sensitive.
This patch just let curr exhaust it's idleal_runtime when se is idle and 
curr is non-idle. Normally se will be choosed by pick_next_entity().

Maybe I missed something ?
Thanks


	

>>
>> Thanks again for your review.
>>
>> Best,
>> Chuyi
>>> The wakeup check is useful for latency sensitive non-idle tasks.
>>> However, in steady state competition between idle and non-idle, we
>>> must allow some amount of round-robin.
>>>
>>>> +
>>>>                   resched_curr(rq_of(cfs_rq));
>>>> +       }
>>>>    }
>>>>
>>>>    static void
>>>> --
>>>> 2.20.1
>>>>
>>>
>>> Best,
>>> Josh
