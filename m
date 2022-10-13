Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE785FD336
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 04:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJMCXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 22:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJMCXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 22:23:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993CD132681
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:23:11 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i3so677317pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCM7HSmKO2CzvhIKX4uMzVt0rPdW6wOGaO8XisQo+bs=;
        b=3K2rUO5Bck0iiyfnRcM8QBkxVagOGvRO3bzhTrdJRjOqLTOmFbMAayr7a5VAudKDPv
         F1gtsRVehCoSOCRvF6AsCrl+TJssOJt2onIerRB5W3GdTIKoSKXgihkDQ7ZSpHovQtXJ
         q6j8xjPXqlAFW9QRVwGAV436pY6tnm1YTW/hb++tVity9la8rLhbJV9EwddGr5qBl5AF
         FQzZKhyj/Cq5ygWG3PDgEyEfX2RvzwBRTERIFrRuOGQWosbXOuyFAyGTs2/loP075KuV
         H5Qh+IU3Ns3u0oLIoRXt1gJNAjwXUGn9jB5nsprlhKaTvTlDixboKirip5Wdcblbifbv
         Oi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCM7HSmKO2CzvhIKX4uMzVt0rPdW6wOGaO8XisQo+bs=;
        b=C7OuG4lLIiD2KCriqqACVkYaPNqKqMS5txw/URokCDGBxt2A/kXBsuTO8satfDah1k
         qMKL6pOsF3cnRb4Uky19HTl3E57VhrjkXZQdNwG9SFTPzVY6oJz+PaqreSYWNimgF8SX
         3mYtMT2gXo7owoEoFIf4xH26GbAZ0rEpg0JSz6BnKQfk2mDkDKlaasiZgQMd8IHBAMlY
         w2B+Pxj8LyyPyzUC2bVaKOEjpmD5TrsqYFk8YLp5JEKOOnyD8IuLsaVhqbJ9kFRyRvpn
         uNiXeMpTIYzz2ZNdAMz7DFxqgq196XpZXMEnH2VDJBUGjU6gcMn68egIs+XNGoQzgC7g
         R2Zg==
X-Gm-Message-State: ACrzQf2EJtIaTcRk6wVFhWGgUx+AJIrabqA/HtuN1dABJGWLTSHLhgcy
        TS/nkVyeiqlL6qpArS2kFR32gQ==
X-Google-Smtp-Source: AMsMyM6YrtQSp9rSJuQZul9oRmuDvrqknbzSmYKq4Gjy0x60NsSwSjkN41BdpXP2C7wAH4xxGwFduQ==
X-Received: by 2002:a65:5886:0:b0:439:8dd3:18d4 with SMTP id d6-20020a655886000000b004398dd318d4mr27931547pgu.430.1665627790970;
        Wed, 12 Oct 2022 19:23:10 -0700 (PDT)
Received: from [10.4.165.47] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n128-20020a622786000000b00528a097aeffsm551650pfn.118.2022.10.12.19.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 19:23:10 -0700 (PDT)
Message-ID: <d4918ecc-e1a9-7c16-fdf1-10cac60cf490@bytedance.com>
Date:   Thu, 13 Oct 2022 10:23:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     hannes@cmpxchg.org, quic_pkondeti@quicinc.com,
        peterz@infradead.org, quic_charante@quicinc.com,
        linux-kernel@vger.kernel.org
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20221010104206.12184-1-zhouchengming@bytedance.com>
 <CAJuCfpF7Z+CYhk-f_aaDTE232+m9z_n-QfjGfdLje7QrX9bFtw@mail.gmail.com>
 <a73f58a3-9f96-2ce5-38a0-8abab27a2260@bytedance.com>
 <CAJuCfpET+B3X-uX2vDp-2yH-+OVxOu3YXL7JWZrPuoh22P+5SQ@mail.gmail.com>
 <dea56c22-ab5b-25e2-9819-cc598f9aad80@bytedance.com>
 <CAJuCfpFTDyR1V+JYOY_uN6Xg1Nip5b=9dzkwm-CNd8vMWaQQFQ@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJuCfpFTDyR1V+JYOY_uN6Xg1Nip5b=9dzkwm-CNd8vMWaQQFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/13 02:24, Suren Baghdasaryan wrote:
> On Tue, Oct 11, 2022 at 7:11 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2022/10/12 01:00, Suren Baghdasaryan wrote:
>>> On Mon, Oct 10, 2022 at 5:07 PM Chengming Zhou
>>> <zhouchengming@bytedance.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> On 2022/10/11 05:21, Suren Baghdasaryan wrote:
>>>>> On Mon, Oct 10, 2022 at 3:42 AM Chengming Zhou
>>>>> <zhouchengming@bytedance.com> wrote:
>>>>>>
>>>>>> Pavan reported a problem that PSI avgs_work idle shutoff is not
>>>>>> working at all. Because PSI_NONIDLE condition would be observed in
>>>>>> psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
>>>>>> only the kworker running avgs_work on the CPU.
>>>>>>
>>>>>> Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
>>>>>> avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
>>>>>> still will always re-arm the avgs_work, so shutoff is not working.
>>>>>>
>>>>>> This patch changes to consider current CPU groupc as IDLE if the
>>>>>> kworker running avgs_work is the only task running and no IOWAIT
>>>>>> or MEMSTALL sleep tasks, in which case we will shut off the avgs_work
>>>>>> if other CPUs' groupc are also IDLE.
>>>>>>
>>>>>> One potential problem is that the brief period of non-idle time
>>>>>> incurred between the aggregation run and the kworker's dequeue will
>>>>>> be stranded in the per-cpu buckets until avgs_work run next time.
>>>>>> The buckets can hold 4s worth of time, and future activity will wake
>>>>>> the avgs_work with a 2s delay, giving us 2s worth of data we can leave
>>>>>> behind when shut off the avgs_work. If the kworker run other works after
>>>>>> avgs_work shut off and doesn't have any scheduler activities for 2s,
>>>>>> this maybe a problem.
>>>>>>
>>>>>> Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
>>>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>>>
>>>>> Copying my comments from
>>>>> https://lore.kernel.org/all/CAJuCfpHyYMak-mfVmtEN9Z-hGYQ6Wko57TLjukz9HaN26EDAuA@mail.gmail.com/
>>>>> in case you want to continue the discussion here...
>>>>>
>>>>>> ---
>>>>>>  kernel/sched/psi.c | 15 +++++++++++++++
>>>>>>  1 file changed, 15 insertions(+)
>>>>>>
>>>>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>>>>> index ee2ecc081422..f4cdf6f184ba 100644
>>>>>> --- a/kernel/sched/psi.c
>>>>>> +++ b/kernel/sched/psi.c
>>>>>> @@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>>>                              u32 *pchanged_states)
>>>>>>  {
>>>>>>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
>>>>>> +       int current_cpu = raw_smp_processor_id();
>>>>>> +       bool only_avgs_work = false;
>>>>>>         u64 now, state_start;
>>>>>>         enum psi_states s;
>>>>>>         unsigned int seq;
>>>>>> @@ -256,6 +258,15 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>>>                 memcpy(times, groupc->times, sizeof(groupc->times));
>>>>>>                 state_mask = groupc->state_mask;
>>>>>>                 state_start = groupc->state_start;
>>>>>> +               /*
>>>>>> +                * This CPU has only avgs_work kworker running, snapshot the
>>>>>> +                * newest times then don't need to re-arm for this groupc.
>>>>>> +                * Normally this kworker will sleep soon and won't wake
>>>>>> +                * avgs_work back up in psi_group_change().
>>>>>> +                */
>>>>>> +               if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
>>>>>> +                   !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
>>>>>> +                       only_avgs_work = true;
>>>>>
>>>>> Why do you determine only_avgs_work while taking a snapshot? The
>>>>> read_seqcount_retry() might fail and the loop gets retried, which
>>>>> might lead to a wrong only_avgs_work value if the state changes
>>>>> between retries. I think it's safer to do this after the snapshot was
>>>>> taken and to use tasks[NR_RUNNING] instead of  roupc->tasks.
>>>>
>>>> Ah, you are right, coping groupc->tasks[NR_RUNNING] and tasks[NR_IOWAIT], tasks[NR_MEMSTALL]
>>>> is ok for me. (Maybe we only need to copy groupc->tasks[NR_RUNNING]?)
>>>>
>>>> Another way is to add an else branch:
>>>>
>>>>                 if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
>>>>                     !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
>>>>                         only_avgs_work = true;
>>>>                 else
>>>>                         only_avgs_work = false;
>>>>
>>>> Both are ok for me.
>>>
>>> Let's use the simple way and use the tasks[] after the snapshot is taken.
>>
>> Ok, I changed like this:
>>
>>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
>> +       int current_cpu = raw_smp_processor_id();
>> +       unsigned int tasks[NR_PSI_TASK_COUNTS];
>>         u64 now, state_start;
>>         enum psi_states s;
>>         unsigned int seq;
>> @@ -256,6 +258,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>                 memcpy(times, groupc->times, sizeof(groupc->times));
>>                 state_mask = groupc->state_mask;
>>                 state_start = groupc->state_start;
>> +               if (cpu == current_cpu)
>> +                       memcpy(tasks, groupc->tasks, sizeof(groupc->tasks));
>>         } while (read_seqcount_retry(&groupc->seq, seq));
>>
>>>
>>>>
>>>>>
>>>>>>         } while (read_seqcount_retry(&groupc->seq, seq));
>>>>>>
>>>>>>         /* Calculate state time deltas against the previous snapshot */
>>>>>> @@ -280,6 +291,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>>>                 if (delta)
>>>>>>                         *pchanged_states |= (1 << s);
>>>>>>         }
>>>>>> +
>>>>>> +       /* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
>>>>>> +       if (only_avgs_work)
>>>>>> +               *pchanged_states &= ~(1 << PSI_NONIDLE);
>>>>>
>>>>> This seems to be safe because changed_states&(1<< PSI_NONIDLE) is used
>>>>> only for re-arming psi_avgs_work, however semantically this is
>>>>> incorrect. The CPU was not idle when it was executing psi_avgs_work.
>>>>> IMO a separate flag would avoid this confusion.
>>>>
>>>> Yes, it's safe, but has this confusion. Use a separate flag looks better, like PSI_ONLY_AVGS_WORK.
>>>> But then in collect_percpu_times() we still have to clear PSI_NONIDLE of this CPU if PSI_ONLY_AVGS_WORK
>>>> has been set.
>>>>
>>>>         for_each_possible_cpu(cpu) {
>>>>                 u32 times[NR_PSI_STATES];
>>>>                 u32 nonidle;
>>>>                 u32 cpu_changed_states;
>>>>
>>>>                 get_recent_times(group, cpu, aggregator, times,
>>>>                                 &cpu_changed_states);
>>>>                 changed_states |= cpu_changed_states;
>>>>
>>>> cpu_changed_states should clear PSI_NONIDLE if PSI_ONLY_AVGS_WORK already set.
>>>
>>> No, PSI_NONIDLE should not be affected by PSI_ONLY_AVGS_WORK. These
>>> flags should be independent and aggregated into changed_states without
>>> affecting each other. Something similar to how I suggested with
>>> PSI_STATE_WAKE_CLOCK in
>>> https://lore.kernel.org/all/CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com/#t.
>>
>> If we don't clear PSI_NONIDLE of this CPU, changed_states |= cpu_changed_states;
>> so changed_states has PSI_NONIDLE, and we won't know if other CPUs are IDLE or not
>> in psi_avgs_work().
> 
> I was thinking something like this:
> 
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -244,6 +244,7 @@ static void get_recent_times(struct psi_group
> *group, int cpu,
>         enum psi_states s;
>         unsigned int seq;
>         u32 state_mask;
> +       bool reschedule;
> 
>         *pchanged_states = 0;
> 
> @@ -254,6 +255,14 @@ static void get_recent_times(struct psi_group
> *group, int cpu,
>                memcpy(times, groupc->times, sizeof(groupc->times));
>                state_mask = groupc->state_mask;
>                state_start = groupc->state_start;
> +              if (current_cpu == cpu)
> +                     reschedule = groupc->tasks[NR_RUNNING] +
> +                            groupc->tasks[NR_IOWAIT] +
> +                            groupc->tasks[NR_MEMSTALL] > 1;
> +              else
> +                     reschedule = times[PSI_NONIDLE] >
> +                            groupc->times_prev[aggregator][PSI_NONIDLE];
> +
>         } while (read_seqcount_retry(&groupc->seq, seq));

Ok, I get what you mean: for other CPUs, reschedule == PSI_NONIDLE,
for this current CPU, reschedule is calculated from groupc->tasks[].

Then we use PSI_STATE_RESCHEDULE in psi_avgs_work(), don't use PSI_NONIDLE,
so PSI_NONIDLE become useless in changed_states. Right?

Well, I'm not sure this is easier than just using PSI_NONIDLE. But anyway,
I will try this way in the next revision.

Thanks.

> 
>         /* Calculate state time deltas against the previous snapshot */
> @@ -278,6 +287,8 @@ static void get_recent_times(struct psi_group
> *group, int cpu,
>                if (delta)
>                       *pchanged_states |= (1 << s);
>         }
> +       if (reschedule)
> +              *pchanged_states |= PSI_STATE_RESCHEDULE;
>  }
> 
>  static void calc_avgs(unsigned long avg[3], int missed_periods,
> @@ -413,7 +424,7 @@ static void psi_avgs_work(struct work_struct *work)
>         struct delayed_work *dwork;
>         struct psi_group *group;
>         u32 changed_states;
> -       bool nonidle;
> +       bool reschedule;
>         u64 now;
> 
>         dwork = to_delayed_work(work);
> @@ -424,7 +435,7 @@ static void psi_avgs_work(struct work_struct *work)
>         now = sched_clock();
> 
>         collect_percpu_times(group, PSI_AVGS, &changed_states);
> -       nonidle = changed_states & (1 << PSI_NONIDLE);
> +       reschedule = changed_states & (1 << PSI_STATE_RESCHEDULE);
>         /*
>          * If there is task activity, periodically fold the per-cpu
>          * times and feed samples into the running averages. If things
> @@ -435,7 +446,7 @@ static void psi_avgs_work(struct work_struct *work)
>         if (now >= group->avg_next_update)
>                group->avg_next_update = update_averages(group, now);
> 
> -       if (nonidle) {
> +       if (reschedule) {
>                schedule_delayed_work(dwork, nsecs_to_jiffies(
>                              group->avg_next_update - now) + 1);
>         }
> 
> Does that address your concern?
> 
>>
>> Thanks.
