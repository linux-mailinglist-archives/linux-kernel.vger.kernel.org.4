Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531F65FBF11
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 04:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJLCLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 22:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJLCLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 22:11:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B283A487A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 19:11:06 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pq16so14062916pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 19:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6H8HmxTiBOv0iejpe9/pqzUtE4bpokcuMbBHIP7t9ms=;
        b=A1l3KpKwl1hL0NQ1pFHmVvjF3dx+dHnjs+ECrKD7nHNryeoMPyJy/nW5mo4ayy0QNy
         uR6fb53mW5IXFp+YMPSDUrV1z6gna+MHYJ8l3q9cRKfRUqqEgk5MJ473yqifn5uZ1zyY
         PNPVpBcsM30IOBrdy00908jfgBR4qESX4Qz0i4C7PyUdMoD0XA2eiO+/jCXNtMe8RsHV
         UYehyIwaZQkncBXxV94eXU/cuoFgDuUlNYy6N531NfS4hlA5jDhCCTWMWy+u/MA4Jbo0
         9lO0ZHgoyH5FUbT7sQRRGZVvgp3InA7kUAB6Rj10yJSDUICex3DBQ2+snGrhZNoSFuAw
         UkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6H8HmxTiBOv0iejpe9/pqzUtE4bpokcuMbBHIP7t9ms=;
        b=w136CGJz3vU5GXfw9eUEcMZeN0a4V1M7i4yipnh1S+C7obJR1NDPVl1duU60XaqBpB
         q2j+xc+t3Bz8ms+kWgoimP8+wQNA5/fjwESmTqQ1GFQ91qOnLr5oniPAXMf5bzZKk8uX
         YvA69PWKZ+qCVo54pBPXBS39f5yESJQ0Hg9ZBcRsWK1DHjwUKRa7/oZW+nG7b6j7XZbK
         B8gvOj286wlZAh5RIUJqDsUJPzfvZrM0zEOR4YISiRAR9GdL1FdfFUXx51a5ekUn8GNh
         5+2Au66rxcXx7c4yrD6w0EqId1jDoPu2caH1JSafLXrqptdMDylytZyhzeMBVboeQ8mT
         J4bw==
X-Gm-Message-State: ACrzQf1If9MlS2OEycN7UteW32m/atbDuSlPtXpXNfIbnwP84T2vnr4L
        lo5emtKNJkxX+5CUyo4OZR4iBA==
X-Google-Smtp-Source: AMsMyM6114VvFRkwlk/H5WJW3dy7DKbgk7EaXStKQMyTbyWzGMf3hQttIey5/bM4YqVqWeGShcykLA==
X-Received: by 2002:a17:90b:2691:b0:20c:d655:c67d with SMTP id pl17-20020a17090b269100b0020cd655c67dmr2456260pjb.36.1665540665555;
        Tue, 11 Oct 2022 19:11:05 -0700 (PDT)
Received: from [10.4.165.47] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id y200-20020a6264d1000000b0055f1db26b3csm9535474pfb.37.2022.10.11.19.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 19:11:05 -0700 (PDT)
Message-ID: <dea56c22-ab5b-25e2-9819-cc598f9aad80@bytedance.com>
Date:   Wed, 12 Oct 2022 10:10:59 +0800
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
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJuCfpET+B3X-uX2vDp-2yH-+OVxOu3YXL7JWZrPuoh22P+5SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/12 01:00, Suren Baghdasaryan wrote:
> On Mon, Oct 10, 2022 at 5:07 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> Hello,
>>
>> On 2022/10/11 05:21, Suren Baghdasaryan wrote:
>>> On Mon, Oct 10, 2022 at 3:42 AM Chengming Zhou
>>> <zhouchengming@bytedance.com> wrote:
>>>>
>>>> Pavan reported a problem that PSI avgs_work idle shutoff is not
>>>> working at all. Because PSI_NONIDLE condition would be observed in
>>>> psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
>>>> only the kworker running avgs_work on the CPU.
>>>>
>>>> Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
>>>> avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
>>>> still will always re-arm the avgs_work, so shutoff is not working.
>>>>
>>>> This patch changes to consider current CPU groupc as IDLE if the
>>>> kworker running avgs_work is the only task running and no IOWAIT
>>>> or MEMSTALL sleep tasks, in which case we will shut off the avgs_work
>>>> if other CPUs' groupc are also IDLE.
>>>>
>>>> One potential problem is that the brief period of non-idle time
>>>> incurred between the aggregation run and the kworker's dequeue will
>>>> be stranded in the per-cpu buckets until avgs_work run next time.
>>>> The buckets can hold 4s worth of time, and future activity will wake
>>>> the avgs_work with a 2s delay, giving us 2s worth of data we can leave
>>>> behind when shut off the avgs_work. If the kworker run other works after
>>>> avgs_work shut off and doesn't have any scheduler activities for 2s,
>>>> this maybe a problem.
>>>>
>>>> Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>
>>> Copying my comments from
>>> https://lore.kernel.org/all/CAJuCfpHyYMak-mfVmtEN9Z-hGYQ6Wko57TLjukz9HaN26EDAuA@mail.gmail.com/
>>> in case you want to continue the discussion here...
>>>
>>>> ---
>>>>  kernel/sched/psi.c | 15 +++++++++++++++
>>>>  1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>>> index ee2ecc081422..f4cdf6f184ba 100644
>>>> --- a/kernel/sched/psi.c
>>>> +++ b/kernel/sched/psi.c
>>>> @@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>                              u32 *pchanged_states)
>>>>  {
>>>>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
>>>> +       int current_cpu = raw_smp_processor_id();
>>>> +       bool only_avgs_work = false;
>>>>         u64 now, state_start;
>>>>         enum psi_states s;
>>>>         unsigned int seq;
>>>> @@ -256,6 +258,15 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>                 memcpy(times, groupc->times, sizeof(groupc->times));
>>>>                 state_mask = groupc->state_mask;
>>>>                 state_start = groupc->state_start;
>>>> +               /*
>>>> +                * This CPU has only avgs_work kworker running, snapshot the
>>>> +                * newest times then don't need to re-arm for this groupc.
>>>> +                * Normally this kworker will sleep soon and won't wake
>>>> +                * avgs_work back up in psi_group_change().
>>>> +                */
>>>> +               if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
>>>> +                   !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
>>>> +                       only_avgs_work = true;
>>>
>>> Why do you determine only_avgs_work while taking a snapshot? The
>>> read_seqcount_retry() might fail and the loop gets retried, which
>>> might lead to a wrong only_avgs_work value if the state changes
>>> between retries. I think it's safer to do this after the snapshot was
>>> taken and to use tasks[NR_RUNNING] instead of  roupc->tasks.
>>
>> Ah, you are right, coping groupc->tasks[NR_RUNNING] and tasks[NR_IOWAIT], tasks[NR_MEMSTALL]
>> is ok for me. (Maybe we only need to copy groupc->tasks[NR_RUNNING]?)
>>
>> Another way is to add an else branch:
>>
>>                 if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
>>                     !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
>>                         only_avgs_work = true;
>>                 else
>>                         only_avgs_work = false;
>>
>> Both are ok for me.
> 
> Let's use the simple way and use the tasks[] after the snapshot is taken.

Ok, I changed like this:

        struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
+       int current_cpu = raw_smp_processor_id();
+       unsigned int tasks[NR_PSI_TASK_COUNTS];
        u64 now, state_start;
        enum psi_states s;
        unsigned int seq;
@@ -256,6 +258,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
                memcpy(times, groupc->times, sizeof(groupc->times));
                state_mask = groupc->state_mask;
                state_start = groupc->state_start;
+               if (cpu == current_cpu)
+                       memcpy(tasks, groupc->tasks, sizeof(groupc->tasks));
        } while (read_seqcount_retry(&groupc->seq, seq));

> 
>>
>>>
>>>>         } while (read_seqcount_retry(&groupc->seq, seq));
>>>>
>>>>         /* Calculate state time deltas against the previous snapshot */
>>>> @@ -280,6 +291,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>                 if (delta)
>>>>                         *pchanged_states |= (1 << s);
>>>>         }
>>>> +
>>>> +       /* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
>>>> +       if (only_avgs_work)
>>>> +               *pchanged_states &= ~(1 << PSI_NONIDLE);
>>>
>>> This seems to be safe because changed_states&(1<< PSI_NONIDLE) is used
>>> only for re-arming psi_avgs_work, however semantically this is
>>> incorrect. The CPU was not idle when it was executing psi_avgs_work.
>>> IMO a separate flag would avoid this confusion.
>>
>> Yes, it's safe, but has this confusion. Use a separate flag looks better, like PSI_ONLY_AVGS_WORK.
>> But then in collect_percpu_times() we still have to clear PSI_NONIDLE of this CPU if PSI_ONLY_AVGS_WORK
>> has been set.
>>
>>         for_each_possible_cpu(cpu) {
>>                 u32 times[NR_PSI_STATES];
>>                 u32 nonidle;
>>                 u32 cpu_changed_states;
>>
>>                 get_recent_times(group, cpu, aggregator, times,
>>                                 &cpu_changed_states);
>>                 changed_states |= cpu_changed_states;
>>
>> cpu_changed_states should clear PSI_NONIDLE if PSI_ONLY_AVGS_WORK already set.
> 
> No, PSI_NONIDLE should not be affected by PSI_ONLY_AVGS_WORK. These
> flags should be independent and aggregated into changed_states without
> affecting each other. Something similar to how I suggested with
> PSI_STATE_WAKE_CLOCK in
> https://lore.kernel.org/all/CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com/#t.

If we don't clear PSI_NONIDLE of this CPU, changed_states |= cpu_changed_states;
so changed_states has PSI_NONIDLE, and we won't know if other CPUs are IDLE or not
in psi_avgs_work().

Thanks.
