Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE205F8B48
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJIMlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJIMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:41:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF53FFB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 05:41:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so10967939pjs.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 05:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fm5QwGFLPSYRD8m+wxAUesW/XX6AqoALwHqwG2ic0ic=;
        b=vdQhEWgtwpaelH4TkK6kYr9+U/VijCcdWtGPLUX0/vx5/JE3Ybvg7G5KJORK26sf6H
         Zvjk8w26cuvgnvMYAqHAr4i+AHlAo5GKDFd/BRQ3hw2q0rrEkfAeIyMN/NnhALG0FotW
         Yo5BYFQp1yrCNHjFIYltbgPUtG87n5IyJUkErK8TwfYWwN3vp3thm10nmwdzvWdZXHFw
         MRmLuJICK3rr77hewt+px0WG+oQ6Yk5EScgNW87FiE3NNrTYE+glO8gHClZ3YFvXbs5q
         47ezzUz7gfQWpbF8iLfGVoMLCaL2ZPO2fxwrMQlp50nWZjPInt4ioT5SB5hTEgj4uZmJ
         NfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fm5QwGFLPSYRD8m+wxAUesW/XX6AqoALwHqwG2ic0ic=;
        b=PAtr9AltQZs//d6/fDe6OMtj1eQUSRRZdHQ5bA61snjS+gBAErp7pGYHF/OD00xbDS
         Ku86r+AbpBiGAvsS1gE8XOLVu17wzf15qrF3rNvg2JXNE6rPVKiAX63q60zAOjBN4Dhe
         9Yzq7OL/xUAUUI3Pig8T9dcKIFFd0CrzN3UVOx1a1XI7CWbyQP9S/7n15CHM1/tIvPm8
         byRDrw6szlM7DSEiAi5Mbji/BmURvLP9uuZ304NUJudoje08gl18eMQdxlmgm2lPqNLF
         cvb0SCkkqvC9YMn7GHv/SoSSpJwVyWjislUPNEbGRm0vx9OstZMvOyIsHmaFU/XU0SwH
         hhpg==
X-Gm-Message-State: ACrzQf03NZADycCMLyVgV+arobEe4siggTWjT5z988oDAarg9VyG9ISs
        szrg5xjFP10n3bLZB7pycZgqGw==
X-Google-Smtp-Source: AMsMyM7WFqsIkBZhpxFL13kTeFtzGerS4RWpteJzV1gnuRWG2mfFZQHtUlM4aK3S3Wk72GgVigJ0iw==
X-Received: by 2002:a17:90b:4f4a:b0:20c:64e2:2bee with SMTP id pj10-20020a17090b4f4a00b0020c64e22beemr9591950pjb.32.1665319306325;
        Sun, 09 Oct 2022 05:41:46 -0700 (PDT)
Received: from [10.70.253.98] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id c79-20020a621c52000000b0056238741ba0sm4894440pfc.79.2022.10.09.05.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 05:41:45 -0700 (PDT)
Message-ID: <43f4d1c3-52fe-5254-7d50-c420de6d11a6@bytedance.com>
Date:   Sun, 9 Oct 2022 20:41:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: PSI idle-shutoff
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20220915062027.GA14713@hu-pkondeti-hyd.qualcomm.com>
 <CAJuCfpE_nM2uqixnds0d6wbsz4=OQ3KPoJ5HOqDhQXaxFGxwXQ@mail.gmail.com>
 <CAJuCfpEeNzDQ-CvMN3fP5LejOzpnfgUgvkzpPj1CLF-8NqNoww@mail.gmail.com>
 <CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com>
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

Hello,

I just saw these emails, sorry for late.

On 2022/10/6 00:32, Suren Baghdasaryan wrote:
> On Sun, Oct 2, 2022 at 11:11 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Fri, Sep 16, 2022 at 10:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>>
>>> On Wed, Sep 14, 2022 at 11:20 PM Pavan Kondeti
>>> <quic_pkondeti@quicinc.com> wrote:
>>>>
>>>> On Tue, Sep 13, 2022 at 07:38:17PM +0530, Pavan Kondeti wrote:
>>>>> Hi
>>>>>
>>>>> The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
>>>>> run from a kworker thread, PSI_NONIDLE condition would be observed as
>>>>> there is a RUNNING task. So we would always end up re-arming the work.
>>>>>
>>>>> If the work is re-armed from the psi_avgs_work() it self, the backing off
>>>>> logic in psi_task_change() (will be moved to psi_task_switch soon) can't
>>>>> help. The work is already scheduled. so we don't do anything there.
>>>
>>> Hi Pavan,
>>> Thanks for reporting the issue. IIRC [1] was meant to fix exactly this
>>> issue. At the time it was written I tested it and it seemed to work.
>>> Maybe I missed something or some other change introduced afterwards
>>> affected the shutoff logic. I'll take a closer look next week when I'm
>>> back at my computer and will consult with Johannes.
>>
>> Sorry for the delay. I had some time to look into this and test psi
>> shutoff on my device and I think you are right. The patch I mentioned
>> prevents new psi_avgs_work from being scheduled when the only non-idle
>> task is psi_avgs_work itself, however the regular 2sec averaging work
>> will still go on. I think we could record the fact that the only
>> active task is psi_avgs_work in record_times() using a new
>> psi_group_cpu.state_mask flag and then prevent psi_avgs_work() from
>> rescheduling itself if that flag is set for all non-idle cpus. I'll
>> test this approach and will post a patch for review if that works.
> 
> Hi Pavan,
> Testing PSI shutoff on Android proved more difficult than I expected.
> Lots of tasks to silence and I keep encountering new ones.
> The approach I was thinking about is something like this:
> 
> ---
>  include/linux/psi_types.h |  3 +++
>  kernel/sched/psi.c        | 12 +++++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index c7fe7c089718..8d936f22cb5b 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -68,6 +68,9 @@ enum psi_states {
>          NR_PSI_STATES = 7,
>  };
> 
> +/* state_mask flag to keep re-arming averaging work */
> +#define PSI_STATE_WAKE_CLOCK        (1 << NR_PSI_STATES)
> +
>  enum psi_aggregators {
>          PSI_AVGS = 0,
>          PSI_POLL,
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index ecb4b4ff4ce0..dd62ad28bacd 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -278,6 +278,7 @@ static void get_recent_times(struct psi_group
> *group, int cpu,
>                  if (delta)
>                          *pchanged_states |= (1 << s);
>          }
> +        *pchanged_states |= (state_mask & PSI_STATE_WAKE_CLOCK);

If the avgs_work kworker is running on this CPU, it will still see
PSI_STATE_WAKE_CLOCK set in state_mask? So the work will be re-armed?

Maybe I missed something... but I have another different idea which
I want to implement later only for discussion.

Thanks.

>  }
> 
>  static void calc_avgs(unsigned long avg[3], int missed_periods,
> @@ -413,7 +414,7 @@ static void psi_avgs_work(struct work_struct *work)
>          struct delayed_work *dwork;
>          struct psi_group *group;
>          u32 changed_states;
> -        bool nonidle;
> +        bool wake_clock;
>          u64 now;
> 
>          dwork = to_delayed_work(work);
> @@ -424,7 +425,7 @@ static void psi_avgs_work(struct work_struct *work)
>          now = sched_clock();
> 
>          collect_percpu_times(group, PSI_AVGS, &changed_states);
> -        nonidle = changed_states & (1 << PSI_NONIDLE);
> +        wake_clock = changed_states & PSI_STATE_WAKE_CLOCK;
>          /*
>           * If there is task activity, periodically fold the per-cpu
>           * times and feed samples into the running averages. If things
> @@ -435,7 +436,7 @@ static void psi_avgs_work(struct work_struct *work)
>          if (now >= group->avg_next_update)
>                  group->avg_next_update = update_averages(group, now);
> 
> -        if (nonidle) {
> +        if (wake_clock) {
>                  schedule_delayed_work(dwork, nsecs_to_jiffies(
>                                  group->avg_next_update - now) + 1);
>          }
> @@ -742,6 +743,11 @@ static void psi_group_change(struct psi_group
> *group, int cpu,
>          if (unlikely(groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall))
>                  state_mask |= (1 << PSI_MEM_FULL);
> 
> +        if (wake_clock || test_state(groupc->tasks, PSI_NONIDLE)) {
> +                /* psi_avgs_work was not the only task on the CPU */
> +                state_mask |= PSI_STATE_WAKE_CLOCK;
> +        }
> +
>          groupc->state_mask = state_mask;
> 
>          write_seqcount_end(&groupc->seq);
