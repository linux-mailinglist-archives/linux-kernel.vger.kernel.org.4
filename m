Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474145F9B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 10:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiJJIar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 04:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiJJIao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:30:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB845C37D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 01:30:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l1so9716860pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+FHjzbSyAB/O3TX/UmihcssnILn+TtAJxaGsQsOaPE=;
        b=FXyHSkJGJfiz1jyWuXKzkK1bDyisctz/xwFMC2gQCoaxOpH4U/ux1Eh5vr8eK2Elpx
         UhgDpz6SMP9svV/yhcnCr60hDrkwY1ILoh0WBPakcRDgzzO181uvyK6np1us1rMqnQyv
         vKmWbjT1YDFtDrjEvpw5gHh4+yVW3F127T7NUgz7wCo6AXM8JHCKXJbdNEkw+8BwaxEU
         ylSX+RAlrnpIY1iA3YKMBxlj0kZno9c58iyHRax2oyxDz0vSJE9AQjAI4H5X5JF69QTI
         UECzhhgt/SFq81Nwjt3W+uJHFnv3ZXkrKDHr8AfXkojUKF9jzA1CnKK2y71OGHVS/lw+
         reOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+FHjzbSyAB/O3TX/UmihcssnILn+TtAJxaGsQsOaPE=;
        b=VSCUOn+liFOtv8OXxPP76Msd4uomWmyP4v1sFXL7aaSet3y7DrsrpKBNPOr9nP4zgQ
         Lu/upfWO9uEIubKHrwSXqBeZasAueEMbgxTMe7kKcY3eXm6/sYiRRyxqe47ITvDA6zcJ
         kPZc3XRCg5e6PfVw7QunvGxoBp4ZMoXNXVGDrEF8YDmJ9CRQCPMeEP9X0B4HysH9I/Sw
         a8ua845MNuY/7BQyzqvCGp5mXHnmN3Jk+v7Ngu3BOP3ehY2+kX492qm6rbxDHxXQcJTO
         nST94P1KryxaiIh6tITcDhjehASKufLFHPdnbW/KwkoNMCpscqwIOfVDHHCbXKlmsmdR
         xV0A==
X-Gm-Message-State: ACrzQf1NeBEXWVMVpDtZ6/s0NHExoXh94hyVbXSff2d3fDns3naSYD98
        Lq473rqjl/zlrGqWCbNkfZ6zU6rwJrSbUg==
X-Google-Smtp-Source: AMsMyM5wqW1e8e9Xb7Stm5fkws3EBoERKthkrkhlhyPbGMT3vaRDzg/BkAxo4xeoh9fmNkV9qXb18Q==
X-Received: by 2002:a17:90b:2741:b0:20a:ebc3:6513 with SMTP id qi1-20020a17090b274100b0020aebc36513mr19854935pjb.29.1665390641944;
        Mon, 10 Oct 2022 01:30:41 -0700 (PDT)
Received: from [10.4.165.47] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id ik7-20020a170902ab0700b0016f8e8032c4sm6000298plb.129.2022.10.10.01.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 01:30:41 -0700 (PDT)
Message-ID: <259b1a8e-224b-200c-f07b-c4bf87e91dc5@bytedance.com>
Date:   Mon, 10 Oct 2022 16:30:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: PSI idle-shutoff
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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
 <23360cd5-fe17-3c7e-af21-57dc058fcee0@bytedance.com>
In-Reply-To: <23360cd5-fe17-3c7e-af21-57dc058fcee0@bytedance.com>
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

On 2022/10/10 14:57, Chengming Zhou wrote:
> On 2022/10/10 14:43, Pavan Kondeti wrote:
>> On Mon, Oct 10, 2022 at 11:48:49AM +0530, Pavan Kondeti wrote:
>>> On Sun, Oct 09, 2022 at 09:17:34PM +0800, Chengming Zhou wrote:
>>>> On 2022/10/9 20:41, Chengming Zhou wrote:
>>>>> Hello,
>>>>>
>>>>> I just saw these emails, sorry for late.
>>>>>
>>>>> On 2022/10/6 00:32, Suren Baghdasaryan wrote:
>>>>>> On Sun, Oct 2, 2022 at 11:11 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>>>>>>
>>>>>>> On Fri, Sep 16, 2022 at 10:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>>>>>>>
>>>>>>>> On Wed, Sep 14, 2022 at 11:20 PM Pavan Kondeti
>>>>>>>> <quic_pkondeti@quicinc.com> wrote:
>>>>>>>>>
>>>>>>>>> On Tue, Sep 13, 2022 at 07:38:17PM +0530, Pavan Kondeti wrote:
>>>>>>>>>> Hi
>>>>>>>>>>
>>>>>>>>>> The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
>>>>>>>>>> run from a kworker thread, PSI_NONIDLE condition would be observed as
>>>>>>>>>> there is a RUNNING task. So we would always end up re-arming the work.
>>>>>>>>>>
>>>>>>>>>> If the work is re-armed from the psi_avgs_work() it self, the backing off
>>>>>>>>>> logic in psi_task_change() (will be moved to psi_task_switch soon) can't
>>>>>>>>>> help. The work is already scheduled. so we don't do anything there.
>>>>>>>>
>>>>>>>> Hi Pavan,
>>>>>>>> Thanks for reporting the issue. IIRC [1] was meant to fix exactly this
>>>>>>>> issue. At the time it was written I tested it and it seemed to work.
>>>>>>>> Maybe I missed something or some other change introduced afterwards
>>>>>>>> affected the shutoff logic. I'll take a closer look next week when I'm
>>>>>>>> back at my computer and will consult with Johannes.
>>>>>>>
>>>>>>> Sorry for the delay. I had some time to look into this and test psi
>>>>>>> shutoff on my device and I think you are right. The patch I mentioned
>>>>>>> prevents new psi_avgs_work from being scheduled when the only non-idle
>>>>>>> task is psi_avgs_work itself, however the regular 2sec averaging work
>>>>>>> will still go on. I think we could record the fact that the only
>>>>>>> active task is psi_avgs_work in record_times() using a new
>>>>>>> psi_group_cpu.state_mask flag and then prevent psi_avgs_work() from
>>>>>>> rescheduling itself if that flag is set for all non-idle cpus. I'll
>>>>>>> test this approach and will post a patch for review if that works.
>>>>>>
>>>>>> Hi Pavan,
>>>>>> Testing PSI shutoff on Android proved more difficult than I expected.
>>>>>> Lots of tasks to silence and I keep encountering new ones.
>>>>>> The approach I was thinking about is something like this:
>>>>>>
>>>>>> ---
>>>>>>  include/linux/psi_types.h |  3 +++
>>>>>>  kernel/sched/psi.c        | 12 +++++++++---
>>>>>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
>>>>>> index c7fe7c089718..8d936f22cb5b 100644
>>>>>> --- a/include/linux/psi_types.h
>>>>>> +++ b/include/linux/psi_types.h
>>>>>> @@ -68,6 +68,9 @@ enum psi_states {
>>>>>>          NR_PSI_STATES = 7,
>>>>>>  };
>>>>>>
>>>>>> +/* state_mask flag to keep re-arming averaging work */
>>>>>> +#define PSI_STATE_WAKE_CLOCK        (1 << NR_PSI_STATES)
>>>>>> +
>>>>>>  enum psi_aggregators {
>>>>>>          PSI_AVGS = 0,
>>>>>>          PSI_POLL,
>>>>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>>>>> index ecb4b4ff4ce0..dd62ad28bacd 100644
>>>>>> --- a/kernel/sched/psi.c
>>>>>> +++ b/kernel/sched/psi.c
>>>>>> @@ -278,6 +278,7 @@ static void get_recent_times(struct psi_group
>>>>>> *group, int cpu,
>>>>>>                  if (delta)
>>>>>>                          *pchanged_states |= (1 << s);
>>>>>>          }
>>>>>> +        *pchanged_states |= (state_mask & PSI_STATE_WAKE_CLOCK);
>>>>>
>>>>> If the avgs_work kworker is running on this CPU, it will still see
>>>>> PSI_STATE_WAKE_CLOCK set in state_mask? So the work will be re-armed?
>>>>>
>>>>> Maybe I missed something... but I have another different idea which
>>>>> I want to implement later only for discussion.
>>>>
>>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>>> index ee2ecc081422..f322e8fd8d41 100644
>>>> --- a/kernel/sched/psi.c
>>>> +++ b/kernel/sched/psi.c
>>>> @@ -241,11 +241,13 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>                              enum psi_aggregators aggregator, u32 *times,
>>>>                              u32 *pchanged_states)
>>>>  {
>>>> +       int current_cpu = raw_smp_processor_id();
>>>>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
>>>>         u64 now, state_start;
>>>>         enum psi_states s;
>>>>         unsigned int seq;
>>>>         u32 state_mask;
>>>> +       bool only_avgs_work = false;
>>>>
>>>>         *pchanged_states = 0;
>>>>
>>>> @@ -256,6 +258,14 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>                 memcpy(times, groupc->times, sizeof(groupc->times));
>>>>                 state_mask = groupc->state_mask;
>>>>                 state_start = groupc->state_start;
>>>> +               /*
>>>> +                * This CPU has only avgs_work kworker running, snapshot the
>>>> +                * newest times then don't need to re-arm work for this groupc.
>>>> +                * Normally this kworker will sleep soon and won't
>>>> +                * wake_clock in psi_group_change().
>>>> +                */
>>>> +               if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1)
>>>> +                       only_avgs_work = true;
>>>>         } while (read_seqcount_retry(&groupc->seq, seq));
>>>>
>>>>         /* Calculate state time deltas against the previous snapshot */
>>>> @@ -280,6 +290,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>                 if (delta)
>>>>                         *pchanged_states |= (1 << s);
>>>>         }
>>>> +
>>>> +       /* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
>>>> +       if (only_avgs_work)
>>>> +               *pchanged_states &= ~(1 << PSI_NONIDLE);
>>>>  }
>>>>
>>> Thanks Chengming for the patch. I will test this patch and report my
>>> observations. It makes sense to consider this CPU as non-idle if the PSI kworker
>>> is the only task running. It could run other works but that decision is now
>>> deferred to schedule out path. Ideally if this is the only (or last) work
>>> running, we should not see PSI work not re-arming it self.
>>>
>>
>> is condition groupc->tasks[NR_RUNNING] == 1 alone sufficient to clear NONIDLE?
>> or should we also make sure that !NR_IOWAIT && !NR_MEMSTALL condition on this CPU?
> 
> Yes, I think you're correct, we should check !NR_IOWAIT && !NR_MEMSTALL too.
> 

Hello,

Looks like this patch plus the !NR_IOWAIT && !NR_MEMSTALL condition can solve the
avgs_work re-arm problem.

Real machine is hard to reproduce, so I set up a QEMU VM with only one CPU and hack
PSI_FREQ=100ms, with "cgroup_disable=pressure" cmdline to disable cgroup levels PSI.

After launching the VM, I ssh into it and enable some tracepoints, then exit to
let it idle.

          <idle>-0       [000] d..1.    77.102839: cpu_idle: state=1 cpu_id=0
          <idle>-0       [000] d.s2.    77.142840: workqueue_queue_work: work struct=00000000cd023738 function=psi_avgs_work workqueue=events req_cpu=512 cpu=0
          <idle>-0       [000] d.s2.    77.142841: workqueue_activate_work: work struct 00000000cd023738
          <idle>-0       [000] dNs5.    77.142849: sched_wakeup: comm=kworker/0:5 pid=164 prio=120 target_cpu=000
          <idle>-0       [000] dNs2.    77.142852: timer_start: timer=00000000f41058a8 function=tcp_orphan_update expires=4294744860 [timeout=100] cpu=0 idx=100 flags=D
          <idle>-0       [000] .N.1.    77.142854: cpu_idle: state=4294967295 cpu_id=0
          <idle>-0       [000] d..2.    77.142860: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/0:5 next_pid=164 next_prio=120
     kworker/0:5-164     [000] .....    77.142864: workqueue_execute_start: work struct 00000000cd023738: function psi_avgs_work
     kworker/0:5-164     [000] .....    77.142866: workqueue_execute_end: work struct 00000000cd023738: function psi_avgs_work

[avgs_work won't be re-armed again]

     kworker/0:5-164     [000] d..2.    77.142872: sched_switch: prev_comm=kworker/0:5 prev_pid=164 prev_prio=120 prev_state=I ==> next_comm=swapper/0 next_pid=0 next_prio=120
          <idle>-0       [000] d..1.    77.142878: cpu_idle: state=1 cpu_id=0

[avgs_work kworker sleep, won't wake_clock]

          <idle>-0       [000] dNs4.    77.470857: sched_wakeup: comm=jbd2/vda3-8 pid=73 prio=120 target_cpu=000

[new activity again, avgs_work scheduled delay PSI_FREQ=100ms ...]

          <idle>-0       [000] d.s2.    77.574816: workqueue_queue_work: work struct=00000000cd023738 function=psi_avgs_work workqueue=events req_cpu=512 cpu=0
          <idle>-0       [000] d.s2.    77.574817: workqueue_activate_work: work struct 00000000cd023738
          <idle>-0       [000] dNs5.    77.574824: sched_wakeup: comm=kworker/0:5 pid=164 prio=120 target_cpu=000
          <idle>-0       [000] dNs2.    77.574826: timer_start: timer=00000000f41058a8 function=tcp_orphan_update expires=4294745292 [timeout=100] cpu=0 idx=90 flags=D
          <idle>-0       [000] .N.1.    77.574827: cpu_idle: state=4294967295 cpu_id=0
          <idle>-0       [000] d..2.    77.574833: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/0:5 next_pid=164 next_prio=120
     kworker/0:5-164     [000] .....    77.574837: workqueue_execute_start: work struct 00000000cd023738: function psi_avgs_work
     kworker/0:5-164     [000] .....    77.574839: workqueue_execute_end: work struct 00000000cd023738: function psi_avgs_work

[avgs_work run as expected at 77.470857+100ms, then idle again, won't be re-armed]

     kworker/0:5-164     [000] d..2.    77.574844: sched_switch: prev_comm=kworker/0:5 prev_pid=164 prev_prio=120 prev_state=I ==> next_comm=swapper/0 next_pid=0 next_prio=120
          <idle>-0       [000] d..1.    77.574850: cpu_idle: state=1 cpu_id=0
          <idle>-0       [000] d.s5.    77.606824: timer_start: timer=000000005f4b8bb9 function=delayed_work_timer_fn expires=4294745324 [timeout=100] cpu=0 idx=94 flags=I
[...]

