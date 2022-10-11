Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFF15FA8E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 02:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJKAH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 20:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJKAHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 20:07:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13B4FAD3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:07:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso6650088pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YJzDCKISDCAnVfUQwTOKWNYS8T0Kx5hBG1dZOarrXHg=;
        b=RkbOILEzYx1KZj2vUIJpjcR0oS1BUJaBu5agoNhyU4NpBgsT4RCBtouiBveS3OnCc0
         lpy9UUZ8EIWYQA7JTadDJPyAPjULglZRaHUqm4Sbs0iVYAop0eRjlLUQn8CtyowtBWVc
         /l0JyntrZTOTVfeiP+fshdBkBw/Cvvziz+i88wjnzBG7M4IHnYuHQ/lgri2rFEhMm/86
         uKfjAhAZVK5+Z2BehdHUaXpr0nV/qm1vfGCPU8/Z8UwxMnVt5gHhP/DRFyH2Mv38oG7A
         9ulWkOQObsAQauZ0HWW4FkNgL8k/D1DgMfQDNfbPAhyUIZ0nrlYH72PiV5aNg+ssHjz+
         v91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJzDCKISDCAnVfUQwTOKWNYS8T0Kx5hBG1dZOarrXHg=;
        b=AHLdmVf1bnlJ0Be3sMB8XC3Rf4uuLDRQCylaeez0UeQAJHgRLKKhGqT9/lURMvefqm
         l2bMqtk7/fmq3jd5N2bsUIiszfP6IF4TxRo/usM6JkKPI2TV+ULW+GGUje6yDptLegGi
         VklypEGL1QfR8+Pbqydgh3Vbr2mUhPgZTFQJDpT7G6hsXeEdkfNvsK2X30EHVPlGwRTI
         dsqgEGjlcSLET5XM7sb4ejn6/EyczT1IuSCS08YUHsiiyQX5XfFtDUKBBLW2sdqlFz+7
         rmRuPi+PWH3MwRxWYvO8hF2cvxKOiJBxOk2HIGQcxlqDI6GMtnsivLQxBk/pxhsKqCPT
         SEFg==
X-Gm-Message-State: ACrzQf0/8+3E/V/IPSC5yG/Bq50yEL9SwKOji7E9rjHa6hpN3eQ9up+A
        UGRPf+wkXuoqrONPRoEf40Dneg==
X-Google-Smtp-Source: AMsMyM5Mcuy9+AZ5OTIA6Ctgm18eI41HkdyuFkMQijMF8UTXoTYm3FZB2bqYNt7ti0SplXsHfschVQ==
X-Received: by 2002:a17:902:bd8b:b0:179:d10e:97f with SMTP id q11-20020a170902bd8b00b00179d10e097fmr21397930pls.18.1665446842276;
        Mon, 10 Oct 2022 17:07:22 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e60:6a90:e854:82d2:2d26:db57? ([2409:8a28:e60:6a90:e854:82d2:2d26:db57])
        by smtp.gmail.com with ESMTPSA id k9-20020a654649000000b00434e1d3b2ecsm6769872pgr.79.2022.10.10.17.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 17:07:21 -0700 (PDT)
Message-ID: <a73f58a3-9f96-2ce5-38a0-8abab27a2260@bytedance.com>
Date:   Tue, 11 Oct 2022 08:07:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     hannes@cmpxchg.org, quic_pkondeti@quicinc.com,
        peterz@infradead.org, quic_charante@quicinc.com,
        linux-kernel@vger.kernel.org
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20221010104206.12184-1-zhouchengming@bytedance.com>
 <CAJuCfpF7Z+CYhk-f_aaDTE232+m9z_n-QfjGfdLje7QrX9bFtw@mail.gmail.com>
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJuCfpF7Z+CYhk-f_aaDTE232+m9z_n-QfjGfdLje7QrX9bFtw@mail.gmail.com>
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

Hello,

On 2022/10/11 05:21, Suren Baghdasaryan wrote:
> On Mon, Oct 10, 2022 at 3:42 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> Pavan reported a problem that PSI avgs_work idle shutoff is not
>> working at all. Because PSI_NONIDLE condition would be observed in
>> psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
>> only the kworker running avgs_work on the CPU.
>>
>> Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
>> avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
>> still will always re-arm the avgs_work, so shutoff is not working.
>>
>> This patch changes to consider current CPU groupc as IDLE if the
>> kworker running avgs_work is the only task running and no IOWAIT
>> or MEMSTALL sleep tasks, in which case we will shut off the avgs_work
>> if other CPUs' groupc are also IDLE.
>>
>> One potential problem is that the brief period of non-idle time
>> incurred between the aggregation run and the kworker's dequeue will
>> be stranded in the per-cpu buckets until avgs_work run next time.
>> The buckets can hold 4s worth of time, and future activity will wake
>> the avgs_work with a 2s delay, giving us 2s worth of data we can leave
>> behind when shut off the avgs_work. If the kworker run other works after
>> avgs_work shut off and doesn't have any scheduler activities for 2s,
>> this maybe a problem.
>>
>> Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Copying my comments from
> https://lore.kernel.org/all/CAJuCfpHyYMak-mfVmtEN9Z-hGYQ6Wko57TLjukz9HaN26EDAuA@mail.gmail.com/
> in case you want to continue the discussion here...
> 
>> ---
>>  kernel/sched/psi.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> index ee2ecc081422..f4cdf6f184ba 100644
>> --- a/kernel/sched/psi.c
>> +++ b/kernel/sched/psi.c
>> @@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>                              u32 *pchanged_states)
>>  {
>>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
>> +       int current_cpu = raw_smp_processor_id();
>> +       bool only_avgs_work = false;
>>         u64 now, state_start;
>>         enum psi_states s;
>>         unsigned int seq;
>> @@ -256,6 +258,15 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>                 memcpy(times, groupc->times, sizeof(groupc->times));
>>                 state_mask = groupc->state_mask;
>>                 state_start = groupc->state_start;
>> +               /*
>> +                * This CPU has only avgs_work kworker running, snapshot the
>> +                * newest times then don't need to re-arm for this groupc.
>> +                * Normally this kworker will sleep soon and won't wake
>> +                * avgs_work back up in psi_group_change().
>> +                */
>> +               if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
>> +                   !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
>> +                       only_avgs_work = true;
> 
> Why do you determine only_avgs_work while taking a snapshot? The
> read_seqcount_retry() might fail and the loop gets retried, which
> might lead to a wrong only_avgs_work value if the state changes
> between retries. I think it's safer to do this after the snapshot was
> taken and to use tasks[NR_RUNNING] instead of  roupc->tasks.

Ah, you are right, coping groupc->tasks[NR_RUNNING] and tasks[NR_IOWAIT], tasks[NR_MEMSTALL]
is ok for me. (Maybe we only need to copy groupc->tasks[NR_RUNNING]?)

Another way is to add an else branch:

		if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
		    !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
			only_avgs_work = true;
		else
			only_avgs_work = false;

Both are ok for me.

> 
>>         } while (read_seqcount_retry(&groupc->seq, seq));
>>
>>         /* Calculate state time deltas against the previous snapshot */
>> @@ -280,6 +291,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>                 if (delta)
>>                         *pchanged_states |= (1 << s);
>>         }
>> +
>> +       /* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
>> +       if (only_avgs_work)
>> +               *pchanged_states &= ~(1 << PSI_NONIDLE);
> 
> This seems to be safe because changed_states&(1<< PSI_NONIDLE) is used
> only for re-arming psi_avgs_work, however semantically this is
> incorrect. The CPU was not idle when it was executing psi_avgs_work.
> IMO a separate flag would avoid this confusion.

Yes, it's safe, but has this confusion. Use a separate flag looks better, like PSI_ONLY_AVGS_WORK.
But then in collect_percpu_times() we still have to clear PSI_NONIDLE of this CPU if PSI_ONLY_AVGS_WORK
has been set.

	for_each_possible_cpu(cpu) {
		u32 times[NR_PSI_STATES];
		u32 nonidle;
		u32 cpu_changed_states;

		get_recent_times(group, cpu, aggregator, times,
				&cpu_changed_states);
		changed_states |= cpu_changed_states;

cpu_changed_states should clear PSI_NONIDLE if PSI_ONLY_AVGS_WORK already set.

I'm not sure if it's better to clear here, maybe we can add a comment in get_recent_times()
when do PSI_NONIDLE clear?

Thanks!

