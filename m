Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7520B611F66
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 04:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJ2Csj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 22:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2Csi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 22:48:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910F66E895
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 19:48:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id io19so6360892plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 19:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0odl8YHxeK2Ds0bBl3lmp/+yb2peVVZ6sZ8Zeow/OBE=;
        b=txgCmoQzWopjfvJ1YeQzKdmkqMHD9mP8aZYsFyY7EjS3UNytkyTJ1GScyT4BbCMp5I
         yILpHB7Be35AMyDfPzosp1dHWkOoYuEDRmkqnWjWMynHkB/ebWJ0dHio0V0CgpvKQl8y
         xD0+OSnB4RUF3UEizc1TQIpBMfN0fPYOpb7X6x3PmQTdWf+UnLarjYAZXqi88MhsaeLu
         g5LYM1VtONqjXczMk6JpiduaSjBDckzLH19INnhhL8VK+ErmXx7A8ze1kIdwhUMUl8I6
         PIPlGqPA1UAGXV6ho6NuuZLxJqiGT3wQe42/usXpR+OY94KQ3uEGRkyo6M7jt/7iFMKf
         33gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0odl8YHxeK2Ds0bBl3lmp/+yb2peVVZ6sZ8Zeow/OBE=;
        b=bn+g5uoSv2ZIT7pzIPW7bE10lC0i2zW7ifKfRHsPQTFHZi4bj2pHuw7IwlZcLgg6tk
         ygP7O0smEmBWq/yUZai8L+dqvpqMbE4sjb0GA57uEhTDDP7tIHodVmzj4neENvaKmNzT
         CN5RqqqS7+7tfZ2GkfVEH83t3Vcz8fb8NL+jHLRHOZtbdokyHGD4bH7A2LceBQIyLedv
         EACm5D57ZCBEIlcX+jg1/d6tD6Uzk0dq7fWRFs4j508BMMWxR6fM3KeOnJMoUw3SPLGN
         j6YyaVyCsvrjwms7UUEZfLs593M1yIMPSTm0TUefWxI9j596KaKMTcTzBB/JujRgVCEt
         RaiA==
X-Gm-Message-State: ACrzQf3hAr9EmQs2VWwTofMKFjLt1RRprAbhDXs2beg46wHWrAByoEzm
        HRKdHHqzLHVhonA0oCT9tk4LZg==
X-Google-Smtp-Source: AMsMyM4u1FZB1QktcLeWnYW3iuVLmDDq+OkgznAW6rIpk4afy6YE+R+zCkuvJEO/UkIkjk2iXpDU4A==
X-Received: by 2002:a17:902:690a:b0:17a:32d:7acc with SMTP id j10-20020a170902690a00b0017a032d7accmr2300478plk.18.1667011716043;
        Fri, 28 Oct 2022 19:48:36 -0700 (PDT)
Received: from [10.4.223.2] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902e74100b0017a032d7ae4sm163776plf.104.2022.10.28.19.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 19:48:35 -0700 (PDT)
Message-ID: <4733f304-0b4d-4d6b-75d8-14a50af52203@bytedance.com>
Date:   Sat, 29 Oct 2022 10:47:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v5 1/1] psi: stop relying on timer_pending for poll_work
 rescheduling
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     peterz@infradead.org, hannes@cmpxchg.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, matthias.bgg@gmail.com,
        minchan@google.com, yt.chang@mediatek.com, wenju.xu@mediatek.com,
        jonathan.jmchen@mediatek.com, show-hong.chen@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-team@android.com
References: <20221026233839.1934419-1-surenb@google.com>
 <2aa48d3a-bb37-bf4b-9842-41b3c740efcd@linux.dev>
 <CAJuCfpGnXKBVJRsVYXtEA=O72viV-qSXjjVhjFnCQZm7G2vxoQ@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJuCfpGnXKBVJRsVYXtEA=O72viV-qSXjjVhjFnCQZm7G2vxoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/29 00:44, Suren Baghdasaryan wrote:
> On Fri, Oct 28, 2022 at 2:59 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> Hello,
>>
>> On 2022/10/27 07:38, Suren Baghdasaryan wrote:
>>> Psi polling mechanism is trying to minimize the number of wakeups to
>>> run psi_poll_work and is currently relying on timer_pending() to detect
>>> when this work is already scheduled. This provides a window of opportunity
>>> for psi_group_change to schedule an immediate psi_poll_work after
>>> poll_timer_fn got called but before psi_poll_work could reschedule itself.
>>> Below is the depiction of this entire window:
>>>
>>> poll_timer_fn
>>>   wake_up_interruptible(&group->poll_wait);
>>>
>>> psi_poll_worker
>>>   wait_event_interruptible(group->poll_wait, ...)
>>>   psi_poll_work
>>>     psi_schedule_poll_work
>>>       if (timer_pending(&group->poll_timer)) return;
>>>       ...
>>>       mod_timer(&group->poll_timer, jiffies + delay);
>>>
>>> Prior to 461daba06bdc we used to rely on poll_scheduled atomic which was
>>> reset and set back inside psi_poll_work and therefore this race window
>>> was much smaller.
>>> The larger window causes increased number of wakeups and our partners
>>> report visible power regression of ~10mA after applying 461daba06bdc.
>>> Bring back the poll_scheduled atomic and make this race window even
>>> narrower by resetting poll_scheduled only when we reach polling expiration
>>> time. This does not completely eliminate the possibility of extra wakeups
>>> caused by a race with psi_group_change however it will limit it to the
>>> worst case scenario of one extra wakeup per every tracking window (0.5s
>>> in the worst case).
>>> This patch also ensures correct ordering between clearing poll_scheduled
>>> flag and obtaining changed_states using memory barrier. Correct ordering
>>> between updating changed_states and setting poll_scheduled is ensured by
>>> atomic_xchg operation.
>>> By tracing the number of immediate rescheduling attempts performed by
>>> psi_group_change and the number of these attempts being blocked due to
>>> psi monitor being already active, we can assess the effects of this change:
>>>
>>> Before the patch:
>>>                                            Run#1    Run#2      Run#3
>>> Immediate reschedules attempted:           684365   1385156    1261240
>>> Immediate reschedules blocked:             682846   1381654    1258682
>>> Immediate reschedules (delta):             1519     3502       2558
>>> Immediate reschedules (% of attempted):    0.22%    0.25%      0.20%
>>>
>>> After the patch:
>>>                                            Run#1    Run#2      Run#3
>>> Immediate reschedules attempted:           882244   770298    426218
>>> Immediate reschedules blocked:             881996   769796    426074
>>> Immediate reschedules (delta):             248      502       144
>>> Immediate reschedules (% of attempted):    0.03%    0.07%     0.03%
>>>
>>> The number of non-blocked immediate reschedules dropped from 0.22-0.25%
>>> to 0.03-0.07%. The drop is attributed to the decrease in the race window
>>> size and the fact that we allow this race only when psi monitors reach
>>> polling window expiration time.
>>>
>>> Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger scheduling mechanism")
>>> Reported-by: Kathleen Chang <yt.chang@mediatek.com>
>>> Reported-by: Wenju Xu <wenju.xu@mediatek.com>
>>> Reported-by: Jonathan Chen <jonathan.jmchen@mediatek.com>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> Tested-by: SH Chen <show-hong.chen@mediatek.com>
>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>> ---
>>> Changes since v4 posted at
>>> https://lore.kernel.org/all/20221010225744.101629-1-surenb@google.com/
>>> - Added missing parameter in psi_schedule_poll_work() call used only when
>>> CONFIG_IRQ_TIME_ACCOUNTING is enabled, reported by kernel test robot.
>>>
>>>  include/linux/psi_types.h |  1 +
>>>  kernel/sched/psi.c        | 62 ++++++++++++++++++++++++++++++++-------
>>>  2 files changed, 53 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
>>> index 6e4372735068..14a1ebb74e11 100644
>>> --- a/include/linux/psi_types.h
>>> +++ b/include/linux/psi_types.h
>>> @@ -177,6 +177,7 @@ struct psi_group {
>>>       struct timer_list poll_timer;
>>>       wait_queue_head_t poll_wait;
>>>       atomic_t poll_wakeup;
>>> +     atomic_t poll_scheduled;
>>>
>>>       /* Protects data used by the monitor */
>>>       struct mutex trigger_lock;
>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>> index dbaeac915895..19d05b5c8a55 100644
>>> --- a/kernel/sched/psi.c
>>> +++ b/kernel/sched/psi.c
>>> @@ -189,6 +189,7 @@ static void group_init(struct psi_group *group)
>>>       INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
>>>       mutex_init(&group->avgs_lock);
>>>       /* Init trigger-related members */
>>> +     atomic_set(&group->poll_scheduled, 0);
>>>       mutex_init(&group->trigger_lock);
>>>       INIT_LIST_HEAD(&group->triggers);
>>>       group->poll_min_period = U32_MAX;
>>> @@ -580,18 +581,17 @@ static u64 update_triggers(struct psi_group *group, u64 now)
>>>       return now + group->poll_min_period;
>>>  }
>>>
>>> -/* Schedule polling if it's not already scheduled. */
>>> -static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
>>> +/* Schedule polling if it's not already scheduled or forced. */
>>> +static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
>>> +                                bool force)
>>>  {
>>>       struct task_struct *task;
>>>
>>>       /*
>>> -      * Do not reschedule if already scheduled.
>>> -      * Possible race with a timer scheduled after this check but before
>>> -      * mod_timer below can be tolerated because group->polling_next_update
>>> -      * will keep updates on schedule.
>>> +      * atomic_xchg should be called even when !force to provide a
>>> +      * full memory barrier (see the comment inside psi_poll_work).
>>>        */
>>> -     if (timer_pending(&group->poll_timer))
>>> +     if (atomic_xchg(&group->poll_scheduled, 1) && !force)
>>>               return;
>>>
>>>       rcu_read_lock();
>>> @@ -603,12 +603,15 @@ static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
>>>        */
>>>       if (likely(task))
>>>               mod_timer(&group->poll_timer, jiffies + delay);
>>> +     else
>>> +             atomic_set(&group->poll_scheduled, 0);
>>>
>>>       rcu_read_unlock();
>>>  }
>>>
>>>  static void psi_poll_work(struct psi_group *group)
>>>  {
>>> +     bool force_reschedule = false;
>>>       u32 changed_states;
>>>       u64 now;
>>>
>>> @@ -616,6 +619,43 @@ static void psi_poll_work(struct psi_group *group)
>>>
>>>       now = sched_clock();
>>>
>>> +     if (now > group->polling_until) {
>>> +             /*
>>> +              * We are either about to start or might stop polling if no
>>> +              * state change was recorded. Resetting poll_scheduled leaves
>>> +              * a small window for psi_group_change to sneak in and schedule
>>> +              * an immegiate poll_work before we get to rescheduling. One
>>
>> "immegiate" should be "immediate"?
> 
> Ack. I'll post a new version with this fix.
> 
>>
>>
>>> +              * potential extra wakeup at the end of the polling window
>>> +              * should be negligible and polling_next_update still keeps
>>> +              * updates correctly on schedule.
>>> +              */
>>> +             atomic_set(&group->poll_scheduled, 0);
>>> +             /*
>>> +              * A task change can race with the poll worker that is supposed to
>>> +              * report on it. To avoid missing events, ensure ordering between
>>> +              * poll_scheduled and the task state accesses, such that if the poll
>>> +              * worker misses the state update, the task change is guaranteed to
>>> +              * reschedule the poll worker:
>>> +              *
>>> +              * poll worker:
>>> +              *   atomic_set(poll_scheduled, 0)
>>> +              *   smp_mb()
>>> +              *   LOAD states
>>> +              *
>>> +              * task change:
>>> +              *   STORE states
>>> +              *   if atomic_xchg(poll_scheduled, 1) == 0:
>>> +              *     schedule poll worker
>>> +              *
>>> +              * The atomic_xchg() implies a full barrier.
>>> +              */
>>> +             smp_mb();
>>> +     } else {
>>> +             /* Polling window is not over, keep rescheduling */
>>> +             force_reschedule = true;
>>> +     }
>>
>> Maybe we don't need force_reschedule special case? If this poller
>> need to reschedule and see force_reschedule set by task change,
>> then it doesn't re-arm poll_timer.
> 
> IIRC (it has been a year since we discussed this patch),

Sorry, I just saw this when search patches on https://lore.kernel.org,
I should see your previous versions before asking question here.

> force_reschedule is used to skip extra operations (resetting
> poll_scheduled atomic + the memory barrier) when we know beforehand
> that we need to reschedule the work regardless of the `changed_states`
> result. We need to reschedule unconditionally because we are still
> within the polling window.

Correct, get it, I was thinking wrong.
Thanks for your explanation!

