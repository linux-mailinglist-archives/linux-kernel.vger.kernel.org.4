Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67395F98BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiJJG5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJJG5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:57:42 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA73D581
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:57:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so12312343pjs.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 23:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NvsXkvdXaDyGdIaihJIr8i9wS8kaxQ0TptglH+tGUQw=;
        b=Shkz0U/oBT1JTK77uxmxw10RIS6jiqdSBcNBxLtLg78BCNpGt39+jaRErikx7I9ZbZ
         B8sIpdVngkVcVycGUNZMcT5hgvHkd9VCEuuIp1ZsPDt0bPp2vr3mlGcLZBkJEcsNsuJi
         CM93ahlTBNQt2iPEKsdu0jNZE2oiwc+L5zzlQitDtFvp2joi26IuL5ugTM7e5SNp0BsL
         r68HPO8rfgj9kCmSJcnRfao9Ffvm+iNlR3enWnsSWjvd7MpKm4oEHMYMixvRtYw5eiLI
         vbNrqjwoKugXnf7SN8td2qjV17Wb3Tr/Uwxy7D0fLa22tTBz9sQb09GwgR+8YxCPoDnx
         248Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvsXkvdXaDyGdIaihJIr8i9wS8kaxQ0TptglH+tGUQw=;
        b=mz7leZxw85exPHhXZ0djp6D5gXerHad+yR8t1I+efkbO8grfji6JKOxLB8lKROukVG
         xVlGaPQyYGIhJpRLIXdJz2lMlR+52BF6wqHUUZ9AC5LxPe0eQG1zRrXoryAIV9uFCbcg
         I/yWZE4+4EFCXBTtt3YMps3ZfCP3VLspLmvUh1L9L3mjlzCC3lLQS3R+lv6lePU6UEmY
         uebana8rjJ2zQyB5wnn3klIbTsxuPZQOXRan9EXgmMNsLedR3Oj6TuoWWaH17klYt+/F
         8oMq8SVJRwMwDSSPG4G0IsgQsEeA8kR2992kcB/kGE0UhKgR+qJfNP6j9tNKEiasIT3N
         PuSw==
X-Gm-Message-State: ACrzQf0AYJwxidfh5g3IcWxqgSS+NgjdGrtqhhdb19vekI2+bykazi43
        WZRlJI7ceb80BY+Irf9cgQPYew==
X-Google-Smtp-Source: AMsMyM4Uof5CiIbNjauGC9JPdoydNnISQL4t2NFGmJjWRnUXMU9T7PlZRgK1K+6yLS7KFzXAF7PLwA==
X-Received: by 2002:a17:902:6a86:b0:176:a6bc:54c0 with SMTP id n6-20020a1709026a8600b00176a6bc54c0mr17857376plk.87.1665385060463;
        Sun, 09 Oct 2022 23:57:40 -0700 (PDT)
Received: from [10.4.165.47] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090ab10f00b0020936894e76sm5352558pjq.10.2022.10.09.23.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 23:57:40 -0700 (PDT)
Message-ID: <23360cd5-fe17-3c7e-af21-57dc058fcee0@bytedance.com>
Date:   Mon, 10 Oct 2022 14:57:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: [External] Re: PSI idle-shutoff
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20220915062027.GA14713@hu-pkondeti-hyd.qualcomm.com>
 <CAJuCfpE_nM2uqixnds0d6wbsz4=OQ3KPoJ5HOqDhQXaxFGxwXQ@mail.gmail.com>
 <CAJuCfpEeNzDQ-CvMN3fP5LejOzpnfgUgvkzpPj1CLF-8NqNoww@mail.gmail.com>
 <CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com>
 <43f4d1c3-52fe-5254-7d50-c420de6d11a6@bytedance.com>
 <ff2addac-5a6c-1aa5-5f1c-d62b0444ae4c@bytedance.com>
 <20221010061849.GB1474@hu-pkondeti-hyd.qualcomm.com>
 <20221010064309.GD1474@hu-pkondeti-hyd.qualcomm.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20221010064309.GD1474@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/10 14:43, Pavan Kondeti wrote:
> On Mon, Oct 10, 2022 at 11:48:49AM +0530, Pavan Kondeti wrote:
>> On Sun, Oct 09, 2022 at 09:17:34PM +0800, Chengming Zhou wrote:
>>> On 2022/10/9 20:41, Chengming Zhou wrote:
>>>> Hello,
>>>>
>>>> I just saw these emails, sorry for late.
>>>>
>>>> On 2022/10/6 00:32, Suren Baghdasaryan wrote:
>>>>> On Sun, Oct 2, 2022 at 11:11 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>>>>>
>>>>>> On Fri, Sep 16, 2022 at 10:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>>>>>>
>>>>>>> On Wed, Sep 14, 2022 at 11:20 PM Pavan Kondeti
>>>>>>> <quic_pkondeti@quicinc.com> wrote:
>>>>>>>>
>>>>>>>> On Tue, Sep 13, 2022 at 07:38:17PM +0530, Pavan Kondeti wrote:
>>>>>>>>> Hi
>>>>>>>>>
>>>>>>>>> The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
>>>>>>>>> run from a kworker thread, PSI_NONIDLE condition would be observed as
>>>>>>>>> there is a RUNNING task. So we would always end up re-arming the work.
>>>>>>>>>
>>>>>>>>> If the work is re-armed from the psi_avgs_work() it self, the backing off
>>>>>>>>> logic in psi_task_change() (will be moved to psi_task_switch soon) can't
>>>>>>>>> help. The work is already scheduled. so we don't do anything there.
>>>>>>>
>>>>>>> Hi Pavan,
>>>>>>> Thanks for reporting the issue. IIRC [1] was meant to fix exactly this
>>>>>>> issue. At the time it was written I tested it and it seemed to work.
>>>>>>> Maybe I missed something or some other change introduced afterwards
>>>>>>> affected the shutoff logic. I'll take a closer look next week when I'm
>>>>>>> back at my computer and will consult with Johannes.
>>>>>>
>>>>>> Sorry for the delay. I had some time to look into this and test psi
>>>>>> shutoff on my device and I think you are right. The patch I mentioned
>>>>>> prevents new psi_avgs_work from being scheduled when the only non-idle
>>>>>> task is psi_avgs_work itself, however the regular 2sec averaging work
>>>>>> will still go on. I think we could record the fact that the only
>>>>>> active task is psi_avgs_work in record_times() using a new
>>>>>> psi_group_cpu.state_mask flag and then prevent psi_avgs_work() from
>>>>>> rescheduling itself if that flag is set for all non-idle cpus. I'll
>>>>>> test this approach and will post a patch for review if that works.
>>>>>
>>>>> Hi Pavan,
>>>>> Testing PSI shutoff on Android proved more difficult than I expected.
>>>>> Lots of tasks to silence and I keep encountering new ones.
>>>>> The approach I was thinking about is something like this:
>>>>>
>>>>> ---
>>>>>  include/linux/psi_types.h |  3 +++
>>>>>  kernel/sched/psi.c        | 12 +++++++++---
>>>>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
>>>>> index c7fe7c089718..8d936f22cb5b 100644
>>>>> --- a/include/linux/psi_types.h
>>>>> +++ b/include/linux/psi_types.h
>>>>> @@ -68,6 +68,9 @@ enum psi_states {
>>>>>          NR_PSI_STATES = 7,
>>>>>  };
>>>>>
>>>>> +/* state_mask flag to keep re-arming averaging work */
>>>>> +#define PSI_STATE_WAKE_CLOCK        (1 << NR_PSI_STATES)
>>>>> +
>>>>>  enum psi_aggregators {
>>>>>          PSI_AVGS = 0,
>>>>>          PSI_POLL,
>>>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>>>> index ecb4b4ff4ce0..dd62ad28bacd 100644
>>>>> --- a/kernel/sched/psi.c
>>>>> +++ b/kernel/sched/psi.c
>>>>> @@ -278,6 +278,7 @@ static void get_recent_times(struct psi_group
>>>>> *group, int cpu,
>>>>>                  if (delta)
>>>>>                          *pchanged_states |= (1 << s);
>>>>>          }
>>>>> +        *pchanged_states |= (state_mask & PSI_STATE_WAKE_CLOCK);
>>>>
>>>> If the avgs_work kworker is running on this CPU, it will still see
>>>> PSI_STATE_WAKE_CLOCK set in state_mask? So the work will be re-armed?
>>>>
>>>> Maybe I missed something... but I have another different idea which
>>>> I want to implement later only for discussion.
>>>
>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>> index ee2ecc081422..f322e8fd8d41 100644
>>> --- a/kernel/sched/psi.c
>>> +++ b/kernel/sched/psi.c
>>> @@ -241,11 +241,13 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>                              enum psi_aggregators aggregator, u32 *times,
>>>                              u32 *pchanged_states)
>>>  {
>>> +       int current_cpu = raw_smp_processor_id();
>>>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
>>>         u64 now, state_start;
>>>         enum psi_states s;
>>>         unsigned int seq;
>>>         u32 state_mask;
>>> +       bool only_avgs_work = false;
>>>
>>>         *pchanged_states = 0;
>>>
>>> @@ -256,6 +258,14 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>                 memcpy(times, groupc->times, sizeof(groupc->times));
>>>                 state_mask = groupc->state_mask;
>>>                 state_start = groupc->state_start;
>>> +               /*
>>> +                * This CPU has only avgs_work kworker running, snapshot the
>>> +                * newest times then don't need to re-arm work for this groupc.
>>> +                * Normally this kworker will sleep soon and won't
>>> +                * wake_clock in psi_group_change().
>>> +                */
>>> +               if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1)
>>> +                       only_avgs_work = true;
>>>         } while (read_seqcount_retry(&groupc->seq, seq));
>>>
>>>         /* Calculate state time deltas against the previous snapshot */
>>> @@ -280,6 +290,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>                 if (delta)
>>>                         *pchanged_states |= (1 << s);
>>>         }
>>> +
>>> +       /* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
>>> +       if (only_avgs_work)
>>> +               *pchanged_states &= ~(1 << PSI_NONIDLE);
>>>  }
>>>
>> Thanks Chengming for the patch. I will test this patch and report my
>> observations. It makes sense to consider this CPU as non-idle if the PSI kworker
>> is the only task running. It could run other works but that decision is now
>> deferred to schedule out path. Ideally if this is the only (or last) work
>> running, we should not see PSI work not re-arming it self.
>>
> 
> is condition groupc->tasks[NR_RUNNING] == 1 alone sufficient to clear NONIDLE?
> or should we also make sure that !NR_IOWAIT && !NR_MEMSTALL condition on this CPU?

Yes, I think you're correct, we should check !NR_IOWAIT && !NR_MEMSTALL too.

Thanks!


