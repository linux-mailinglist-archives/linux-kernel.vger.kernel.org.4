Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FC1611711
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiJ1QIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiJ1QGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:06:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BE578200
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:05:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d24so5226308pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EQFKKJky+N1plXno9hbO2oEYT5lLXu/VFJ3x4Aul2Ws=;
        b=ZR0AZcoySFhkbkUQ1HWpORzpwtd9l/ET+o99cG5Ak9FxzufWBAJbOG887WJigUL5Ud
         dxBB4K+Um5UnHXVFPedZg10zdApGdCUOVh2KH1Lf9A2C9eL5ykTO1v1oGlKR0cdxe3gI
         UfF30seGb97ikUS6bG4PENYAd7Wv9PmFkLm05BIAiSLUwjw4h0eH/z1dfxg5t1AUQSFe
         dhgDhP0lisI0Qh681t4L9DvfG8KbpiLU04+Q6v2x6sGjdB8M9/9gxO6kSlXG6cVASUr1
         hvKf9bnOZ9eAfi2To491HCl9963eFkZukLG0buXQPRot+Mio/jMCiRsi35QKmz6Aqi2R
         k3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQFKKJky+N1plXno9hbO2oEYT5lLXu/VFJ3x4Aul2Ws=;
        b=gqB59NXLu69M5i5RqE4w9W4iLnoWQ6ZGUoSxSYgF4ktxT/3qpCVyO58CALawoAPyk7
         Ye77oVFZzLqvnMoSg4JPBr6AgxR59F7uPkU5+4Lhq9t38Mv/kq46kMuyPvIlht+QxCBG
         GsT4s7yVzD/qBw5eLh3j5Vq09edfWxLk6JOzWQ7uq/tiwoo+ao2q3s2BJdNCMROfhzps
         sNRSOC1vDdgK+ZvZH3nD5yvOaaAax4TBuwxCVeeGWydo2auqEprNiReO8SkoSMrbp79G
         c3IQ0m+MaBDOVC8kSeb9kK/tEiqdSu1fzdHA75p5W9DYE1TcJ6Wv0/g6VLToYqShPbgs
         oYGg==
X-Gm-Message-State: ACrzQf05O8k3tVk4n/hYJccW1PZ53B703sgBPSVA6KMUytU32sSfmFeu
        3jrYEQOf2YjAAzhLgZBG5yqLWQ==
X-Google-Smtp-Source: AMsMyM4Uhibi3i+OHMN1Av9XnFViCoSEqCe4P0RKfzsr3KCS0LXL/8nZ5Ha0NMzve/KVFn0SrNJM3A==
X-Received: by 2002:a17:902:ce0d:b0:178:bd1e:e8da with SMTP id k13-20020a170902ce0d00b00178bd1ee8damr32317plg.103.1666973157591;
        Fri, 28 Oct 2022 09:05:57 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e6f:c800:a0f0:67:1b61:938a? ([2409:8a28:e6f:c800:a0f0:67:1b61:938a])
        by smtp.gmail.com with ESMTPSA id u15-20020a170903124f00b00186b69157ecsm3255315plh.202.2022.10.28.09.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 09:05:57 -0700 (PDT)
Message-ID: <148c15f7-5f33-b9c1-dca5-73087f078ba5@bytedance.com>
Date:   Sat, 29 Oct 2022 00:05:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [tip: sched/core] sched/psi: Fix avgs_work re-arm in
 psi_avgs_work()
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
References: <20221010104206.12184-1-zhouchengming@bytedance.com>
 <166693932887.29415.17016910542871419770.tip-bot2@tip-bot2>
 <f990a324-e28e-6de1-acb0-ba764808a56a@bytedance.com>
 <CAJuCfpHOt1Vfc=ZtAYt_2QamOujfuFtNHAdJe7iBMmDgTLGtyw@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJuCfpHOt1Vfc=ZtAYt_2QamOujfuFtNHAdJe7iBMmDgTLGtyw@mail.gmail.com>
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

On 2022/10/28 23:58, Suren Baghdasaryan wrote:
> On Thu, Oct 27, 2022 at 11:50 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> Hello,
>>
>> Thanks for picking this up. There is a newer version which has been acked:
>> https://lore.kernel.org/all/20221014110551.22695-1-zhouchengming@bytedance.com/
> 
> Hmm. Indeed this seems to be an older version and not the one I asked
> Peter to pick up in
> https://lore.kernel.org/all/CAJuCfpHeJuZBbv-q+WXjgNHwt_caMomFPL3L9rxosXOrZz3fBw@mail.gmail.com/.
> Not sure what went wrong. Peter, could you please replace this one
> with https://lore.kernel.org/all/20221014110551.22695-1-zhouchengming@bytedance.com/?

Oh, I didn't notice that email.

> 
> Chengming, please do not top-post next time. Would be better if you
> posted your note under the "Link:" field in this email.

Got it, I will do next time.

Thanks!

> Thanks!
> 
>>
>> As well another PSI patch that has been acked by Johannes:
>> https://lore.kernel.org/all/20220926081931.45420-1-zhouchengming@bytedance.com/
>>
>> Thanks!
>>
>>
>> On 2022/10/28 14:42, tip-bot2 for Chengming Zhou wrote:
>>> The following commit has been merged into the sched/core branch of tip:
>>>
>>> Commit-ID:     7d89d7bb921c5ae5a428df282e64ee5692e26fe0
>>> Gitweb:        https://git.kernel.org/tip/7d89d7bb921c5ae5a428df282e64ee5692e26fe0
>>> Author:        Chengming Zhou <zhouchengming@bytedance.com>
>>> AuthorDate:    Mon, 10 Oct 2022 18:42:06 +08:00
>>> Committer:     Peter Zijlstra <peterz@infradead.org>
>>> CommitterDate: Thu, 27 Oct 2022 11:01:23 +02:00
>>>
>>> sched/psi: Fix avgs_work re-arm in psi_avgs_work()
>>>
>>> Pavan reported a problem that PSI avgs_work idle shutoff is not
>>> working at all. Because PSI_NONIDLE condition would be observed in
>>> psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
>>> only the kworker running avgs_work on the CPU.
>>>
>>> Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
>>> avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
>>> still will always re-arm the avgs_work, so shutoff is not working.
>>>
>>> This patch changes to consider current CPU groupc as IDLE if the
>>> kworker running avgs_work is the only task running and no IOWAIT
>>> or MEMSTALL sleep tasks, in which case we will shut off the avgs_work
>>> if other CPUs' groupc are also IDLE.
>>>
>>> One potential problem is that the brief period of non-idle time
>>> incurred between the aggregation run and the kworker's dequeue will
>>> be stranded in the per-cpu buckets until avgs_work run next time.
>>> The buckets can hold 4s worth of time, and future activity will wake
>>> the avgs_work with a 2s delay, giving us 2s worth of data we can leave
>>> behind when shut off the avgs_work. If the kworker run other works after
>>> avgs_work shut off and doesn't have any scheduler activities for 2s,
>>> this maybe a problem.
>>>
>>> Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Link: https://lore.kernel.org/r/20221010104206.12184-1-zhouchengming@bytedance.com
>>> ---
>>>  kernel/sched/psi.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>> index ee2ecc0..f4cdf6f 100644
>>> --- a/kernel/sched/psi.c
>>> +++ b/kernel/sched/psi.c
>>> @@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>                            u32 *pchanged_states)
>>>  {
>>>       struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
>>> +     int current_cpu = raw_smp_processor_id();
>>> +     bool only_avgs_work = false;
>>>       u64 now, state_start;
>>>       enum psi_states s;
>>>       unsigned int seq;
>>> @@ -256,6 +258,15 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>               memcpy(times, groupc->times, sizeof(groupc->times));
>>>               state_mask = groupc->state_mask;
>>>               state_start = groupc->state_start;
>>> +             /*
>>> +              * This CPU has only avgs_work kworker running, snapshot the
>>> +              * newest times then don't need to re-arm for this groupc.
>>> +              * Normally this kworker will sleep soon and won't wake
>>> +              * avgs_work back up in psi_group_change().
>>> +              */
>>> +             if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
>>> +                 !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
>>> +                     only_avgs_work = true;
>>>       } while (read_seqcount_retry(&groupc->seq, seq));
>>>
>>>       /* Calculate state time deltas against the previous snapshot */
>>> @@ -280,6 +291,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>               if (delta)
>>>                       *pchanged_states |= (1 << s);
>>>       }
>>> +
>>> +     /* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
>>> +     if (only_avgs_work)
>>> +             *pchanged_states &= ~(1 << PSI_NONIDLE);
>>>  }
>>>
>>>  static void calc_avgs(unsigned long avg[3], int missed_periods,
