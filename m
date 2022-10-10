Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358995F9BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiJJJXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJJJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:23:01 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365D7422FA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:23:00 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id b5so9840423pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7e7eqdaSzpoqSu70Noq8os5Np2/zM2obX3UYGBu5Dc=;
        b=dbQhvOdiEk5/VeYxxWA0YrOoFR6W2F9iUOXGVdJwLRxOnc9P3J11BSHQOFIhhB7eB1
         TL/HkJY54mUbjKNQ4R1OiGuu2w+ZqjHF/53swprAZR1LoWh3MnE4dyLUJkzq1YZjdJh8
         6D+eDBiIVXLSl/uytYj6lo2ayucgrYz4p78jHYKWzEBtSF5u2nJKRqZWlgc7zJfu9zp3
         ivL0jzjnaG4SGzUw+TgrLUzIokVS7R9BY0V05zgRaGJHuu+RZuKNDUOhUcQi7vgaJo4c
         irt6c/Zg5h2PZuYPfhmxEfqF3VLfzPc+BcY9lWFoRwiTlevCUxwvSQCMUq5I75dv7R9q
         iA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7e7eqdaSzpoqSu70Noq8os5Np2/zM2obX3UYGBu5Dc=;
        b=CkokRhe5C8F3lKZSfKqU45AUTz8zOq1w8NgvxeWrxYrOqbnR/G2d6ED2WU/VgF9wlh
         uirY1n8hm/hCeBROtcX7FMhEt0mPWZp3Gw16RVIOTDCHPAd71VY3XTpPWq9QFzrALwdd
         Pre2GC0Khe8cy7kFFs4N6Ecvu7lai2yGGijYI6zm1nYnwGqYZbyaYUykqu5ZkiOkq8+t
         a4lHafvLEkosO+zNymAgDPHMHhUeUzSPujlShoAaWH9S0E3tUuakHW8LpAKKgft6fEoS
         FhUhx7tVKd/4B8iNMLnajIkWE5dpKthVz58HBOuDO3bzQFC4s5U5J0WGRGQ1jMehUJWI
         fBkg==
X-Gm-Message-State: ACrzQf12S5b3o/CHggh8wvbFUM1hWfIU5df1HY52WxRrI1le9x7C3eDT
        G/IZlYfaxYzt6iE8eoTGZ7rkCWK/G9H8Sg==
X-Google-Smtp-Source: AMsMyM64512KnmdKJmhkPKLidSKjfZnpdMVfS4SL1QlkmYD3R4Ctd7/tSUiSK9sPrzOrd5I1XF1IMA==
X-Received: by 2002:a62:ee0f:0:b0:55a:d344:a432 with SMTP id e15-20020a62ee0f000000b0055ad344a432mr18776520pfi.40.1665393779674;
        Mon, 10 Oct 2022 02:22:59 -0700 (PDT)
Received: from [10.4.165.47] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h12-20020a63df4c000000b00459a36795cbsm5864102pgj.42.2022.10.10.02.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 02:22:59 -0700 (PDT)
Message-ID: <13da54a6-9164-5482-7c4a-498c16c140a5@bytedance.com>
Date:   Mon, 10 Oct 2022 17:22:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: PSI idle-shutoff
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
References: <20220915062027.GA14713@hu-pkondeti-hyd.qualcomm.com>
 <CAJuCfpE_nM2uqixnds0d6wbsz4=OQ3KPoJ5HOqDhQXaxFGxwXQ@mail.gmail.com>
 <CAJuCfpEeNzDQ-CvMN3fP5LejOzpnfgUgvkzpPj1CLF-8NqNoww@mail.gmail.com>
 <CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com>
 <43f4d1c3-52fe-5254-7d50-c420de6d11a6@bytedance.com>
 <ff2addac-5a6c-1aa5-5f1c-d62b0444ae4c@bytedance.com>
 <20221010061849.GB1474@hu-pkondeti-hyd.qualcomm.com>
 <20221010064309.GD1474@hu-pkondeti-hyd.qualcomm.com>
 <23360cd5-fe17-3c7e-af21-57dc058fcee0@bytedance.com>
 <259b1a8e-224b-200c-f07b-c4bf87e91dc5@bytedance.com>
 <20221010090917.GF1474@hu-pkondeti-hyd.qualcomm.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20221010090917.GF1474@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/10 17:09, Pavan Kondeti wrote:
> On Mon, Oct 10, 2022 at 04:30:36PM +0800, Chengming Zhou wrote:
>> On 2022/10/10 14:57, Chengming Zhou wrote:
>>> On 2022/10/10 14:43, Pavan Kondeti wrote:
>>>> On Mon, Oct 10, 2022 at 11:48:49AM +0530, Pavan Kondeti wrote:
>>>>> On Sun, Oct 09, 2022 at 09:17:34PM +0800, Chengming Zhou wrote:
>>>>>> On 2022/10/9 20:41, Chengming Zhou wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> I just saw these emails, sorry for late.
>>>>>>>
>>>>>>> On 2022/10/6 00:32, Suren Baghdasaryan wrote:
>>>>>>>> On Sun, Oct 2, 2022 at 11:11 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>>>>>>>>
>>>>>>>>> On Fri, Sep 16, 2022 at 10:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Wed, Sep 14, 2022 at 11:20 PM Pavan Kondeti
>>>>>>>>>> <quic_pkondeti@quicinc.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Tue, Sep 13, 2022 at 07:38:17PM +0530, Pavan Kondeti wrote:
>>>>>>>>>>>> Hi
>>>>>>>>>>>>
>>>>>>>>>>>> The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
>>>>>>>>>>>> run from a kworker thread, PSI_NONIDLE condition would be observed as
>>>>>>>>>>>> there is a RUNNING task. So we would always end up re-arming the work.
>>>>>>>>>>>>
>>>>>>>>>>>> If the work is re-armed from the psi_avgs_work() it self, the backing off
>>>>>>>>>>>> logic in psi_task_change() (will be moved to psi_task_switch soon) can't
>>>>>>>>>>>> help. The work is already scheduled. so we don't do anything there.
>>>>>>>>>>
>>>>>>>>>> Hi Pavan,
>>>>>>>>>> Thanks for reporting the issue. IIRC [1] was meant to fix exactly this
>>>>>>>>>> issue. At the time it was written I tested it and it seemed to work.
>>>>>>>>>> Maybe I missed something or some other change introduced afterwards
>>>>>>>>>> affected the shutoff logic. I'll take a closer look next week when I'm
>>>>>>>>>> back at my computer and will consult with Johannes.
>>>>>>>>>
>>>>>>>>> Sorry for the delay. I had some time to look into this and test psi
>>>>>>>>> shutoff on my device and I think you are right. The patch I mentioned
>>>>>>>>> prevents new psi_avgs_work from being scheduled when the only non-idle
>>>>>>>>> task is psi_avgs_work itself, however the regular 2sec averaging work
>>>>>>>>> will still go on. I think we could record the fact that the only
>>>>>>>>> active task is psi_avgs_work in record_times() using a new
>>>>>>>>> psi_group_cpu.state_mask flag and then prevent psi_avgs_work() from
>>>>>>>>> rescheduling itself if that flag is set for all non-idle cpus. I'll
>>>>>>>>> test this approach and will post a patch for review if that works.
>>>>>>>>
>>>>>>>> Hi Pavan,
>>>>>>>> Testing PSI shutoff on Android proved more difficult than I expected.
>>>>>>>> Lots of tasks to silence and I keep encountering new ones.
>>>>>>>> The approach I was thinking about is something like this:
>>>>>>>>
>>>>>>>> ---
>>>>>>>>  include/linux/psi_types.h |  3 +++
>>>>>>>>  kernel/sched/psi.c        | 12 +++++++++---
>>>>>>>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
>>>>>>>> index c7fe7c089718..8d936f22cb5b 100644
>>>>>>>> --- a/include/linux/psi_types.h
>>>>>>>> +++ b/include/linux/psi_types.h
>>>>>>>> @@ -68,6 +68,9 @@ enum psi_states {
>>>>>>>>          NR_PSI_STATES = 7,
>>>>>>>>  };
>>>>>>>>
>>>>>>>> +/* state_mask flag to keep re-arming averaging work */
>>>>>>>> +#define PSI_STATE_WAKE_CLOCK        (1 << NR_PSI_STATES)
>>>>>>>> +
>>>>>>>>  enum psi_aggregators {
>>>>>>>>          PSI_AVGS = 0,
>>>>>>>>          PSI_POLL,
>>>>>>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>>>>>>> index ecb4b4ff4ce0..dd62ad28bacd 100644
>>>>>>>> --- a/kernel/sched/psi.c
>>>>>>>> +++ b/kernel/sched/psi.c
>>>>>>>> @@ -278,6 +278,7 @@ static void get_recent_times(struct psi_group
>>>>>>>> *group, int cpu,
>>>>>>>>                  if (delta)
>>>>>>>>                          *pchanged_states |= (1 << s);
>>>>>>>>          }
>>>>>>>> +        *pchanged_states |= (state_mask & PSI_STATE_WAKE_CLOCK);
>>>>>>>
>>>>>>> If the avgs_work kworker is running on this CPU, it will still see
>>>>>>> PSI_STATE_WAKE_CLOCK set in state_mask? So the work will be re-armed?
>>>>>>>
>>>>>>> Maybe I missed something... but I have another different idea which
>>>>>>> I want to implement later only for discussion.
>>>>>>
>>>>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>>>>> index ee2ecc081422..f322e8fd8d41 100644
>>>>>> --- a/kernel/sched/psi.c
>>>>>> +++ b/kernel/sched/psi.c
>>>>>> @@ -241,11 +241,13 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>>>                              enum psi_aggregators aggregator, u32 *times,
>>>>>>                              u32 *pchanged_states)
>>>>>>  {
>>>>>> +       int current_cpu = raw_smp_processor_id();
>>>>>>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
>>>>>>         u64 now, state_start;
>>>>>>         enum psi_states s;
>>>>>>         unsigned int seq;
>>>>>>         u32 state_mask;
>>>>>> +       bool only_avgs_work = false;
>>>>>>
>>>>>>         *pchanged_states = 0;
>>>>>>
>>>>>> @@ -256,6 +258,14 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>>>                 memcpy(times, groupc->times, sizeof(groupc->times));
>>>>>>                 state_mask = groupc->state_mask;
>>>>>>                 state_start = groupc->state_start;
>>>>>> +               /*
>>>>>> +                * This CPU has only avgs_work kworker running, snapshot the
>>>>>> +                * newest times then don't need to re-arm work for this groupc.
>>>>>> +                * Normally this kworker will sleep soon and won't
>>>>>> +                * wake_clock in psi_group_change().
>>>>>> +                */
>>>>>> +               if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1)
>>>>>> +                       only_avgs_work = true;
>>>>>>         } while (read_seqcount_retry(&groupc->seq, seq));
>>>>>>
>>>>>>         /* Calculate state time deltas against the previous snapshot */
>>>>>> @@ -280,6 +290,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>>>                 if (delta)
>>>>>>                         *pchanged_states |= (1 << s);
>>>>>>         }
>>>>>> +
>>>>>> +       /* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
>>>>>> +       if (only_avgs_work)
>>>>>> +               *pchanged_states &= ~(1 << PSI_NONIDLE);
>>>>>>  }
>>>>>>
>>>>> Thanks Chengming for the patch. I will test this patch and report my
>>>>> observations. It makes sense to consider this CPU as non-idle if the PSI kworker
>>>>> is the only task running. It could run other works but that decision is now
>>>>> deferred to schedule out path. Ideally if this is the only (or last) work
>>>>> running, we should not see PSI work not re-arming it self.
>>>>>
>>>>
>>>> is condition groupc->tasks[NR_RUNNING] == 1 alone sufficient to clear NONIDLE?
>>>> or should we also make sure that !NR_IOWAIT && !NR_MEMSTALL condition on this CPU?
>>>
>>> Yes, I think you're correct, we should check !NR_IOWAIT && !NR_MEMSTALL too.
>>>
>>
>> Hello,
>>
>> Looks like this patch plus the !NR_IOWAIT && !NR_MEMSTALL condition can solve the
>> avgs_work re-arm problem.
>>
> Yes. This is inline with my observations. Without this patch, I see the PSI
> work getting scheduled ~15 times in a 30 seconds trace. It is expected since
> PSI FREQ is 2 seconds by default. With your patch, I see less number of PSI
> work scheduled. More importantly, it is not scheduled from the work it self
> when there is no other activity.

Good, thanks for your testing!

> 
> Like I said in the other thread, there is lot of noise I had to suppress to
> reduce this problem. The moment, I removed all the suppression, things did
> not look bright. one or the other deferrable timer expires due to PSI waking
> up the CPU and then scheduling other tasks due to which PSI again queue the
> work. I guess that varies from platform to platform.

Yes, it's also hard for me to reproduce :/

> 
> This patch in principle makes sense to me. Atleast, we have a way of mechanism
> for idle shutoff from work it self.

Ok, I will send a patch later.

Thanks!

