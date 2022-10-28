Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBE9610ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJ1Gvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJ1Gv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:51:26 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6999D50BA1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:50:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q71so4050836pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgH/phpYbE84Z31EwtYw+gNYZq/SDuJAWaCdxWL+Xmw=;
        b=r/zAD2DEhYd+s/ZWlXm/42+TSMDwZSg3vJkrGRLR4rpN+T0aWLvs/FoRKcdTm3jsAi
         UoFiYjtp/oSGan2UH0wr5wyML5FX/O4PdiaCNtn+E7vUsN0jtk5Cny5bdH3WxOVEtfcz
         WwJkJ9ufQ2NudD1uv2Ms0gN68W0TBZ/Q2LUfv+kVlTLHHJgFQhSp/W4vYCxRDrPiPIA9
         f38ZCpYdTrILH9xQRa+BWo0l8dNk4cwU17T/tAsFsevn7jupzP4YcR3N8uz5kIQJ2Crz
         igkiq9JSoRuf/XU7laROxCrFubEwcKwtbRfirRSJ1zZI2oG/T64grGo9OWqZFKH9ze35
         E9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgH/phpYbE84Z31EwtYw+gNYZq/SDuJAWaCdxWL+Xmw=;
        b=p/vMAtlkHTVhNGduAc97a5TMDMtx3Ze3hf+KvtE1x0fpe1BV9INrxF+H/OOTn0mQ4v
         oRoa7jFACrfP1Vq2GUsUEYHMi5pqp+pLKojIQJuesT7pWtMAbK9EMqN+v3a1u5gFhnDQ
         8kIiQsbHtfRecgQ2ofX21wq0R/1jLJs+qV/Z3iRLagtLQTr/KtYY9/dAyQHJrxe7c1Td
         OzHNnvutWS9gG8YI70QwvSY5nvtRQHY7i3ehNa940De9KLhShKTRmaH6Kkhx1nFfUI9P
         eNFe/xJfydi4UYMh3ApUN6UWztx674ttca21REljmdldAh2bmvmHNcNA4XaMflAT3JfZ
         P81w==
X-Gm-Message-State: ACrzQf3Im9eLincPVbmsuDFAylQq0KSwnVOtWijj75WeY6Y5o4Z9aGeq
        GGeZS7WUe/YS+I/qOMDM3kuBFw==
X-Google-Smtp-Source: AMsMyM7RDKIaig7rU8rqo+RBaVgYeSZrcn/SGodM3rheo4DCvMQswWRTyVB4zvss9b5sJA/9rjheJg==
X-Received: by 2002:a63:4042:0:b0:43b:ddc8:235 with SMTP id n63-20020a634042000000b0043bddc80235mr45898425pga.498.1666939814863;
        Thu, 27 Oct 2022 23:50:14 -0700 (PDT)
Received: from [10.255.236.92] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709027c0700b00172fad607b3sm2232443pll.207.2022.10.27.23.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 23:50:14 -0700 (PDT)
Message-ID: <f990a324-e28e-6de1-acb0-ba764808a56a@bytedance.com>
Date:   Fri, 28 Oct 2022 14:50:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [External] [tip: sched/core] sched/psi: Fix avgs_work re-arm in
 psi_avgs_work()
Content-Language: en-US
To:     linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        "surenb@google.com" <surenb@google.com>
References: <20221010104206.12184-1-zhouchengming@bytedance.com>
 <166693932887.29415.17016910542871419770.tip-bot2@tip-bot2>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <166693932887.29415.17016910542871419770.tip-bot2@tip-bot2>
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

Hello,

Thanks for picking this up. There is a newer version which has been acked:
https://lore.kernel.org/all/20221014110551.22695-1-zhouchengming@bytedance.com/

As well another PSI patch that has been acked by Johannes:
https://lore.kernel.org/all/20220926081931.45420-1-zhouchengming@bytedance.com/

Thanks!


On 2022/10/28 14:42, tip-bot2 for Chengming Zhou wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     7d89d7bb921c5ae5a428df282e64ee5692e26fe0
> Gitweb:        https://git.kernel.org/tip/7d89d7bb921c5ae5a428df282e64ee5692e26fe0
> Author:        Chengming Zhou <zhouchengming@bytedance.com>
> AuthorDate:    Mon, 10 Oct 2022 18:42:06 +08:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 27 Oct 2022 11:01:23 +02:00
> 
> sched/psi: Fix avgs_work re-arm in psi_avgs_work()
> 
> Pavan reported a problem that PSI avgs_work idle shutoff is not
> working at all. Because PSI_NONIDLE condition would be observed in
> psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
> only the kworker running avgs_work on the CPU.
> 
> Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
> avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
> still will always re-arm the avgs_work, so shutoff is not working.
> 
> This patch changes to consider current CPU groupc as IDLE if the
> kworker running avgs_work is the only task running and no IOWAIT
> or MEMSTALL sleep tasks, in which case we will shut off the avgs_work
> if other CPUs' groupc are also IDLE.
> 
> One potential problem is that the brief period of non-idle time
> incurred between the aggregation run and the kworker's dequeue will
> be stranded in the per-cpu buckets until avgs_work run next time.
> The buckets can hold 4s worth of time, and future activity will wake
> the avgs_work with a 2s delay, giving us 2s worth of data we can leave
> behind when shut off the avgs_work. If the kworker run other works after
> avgs_work shut off and doesn't have any scheduler activities for 2s,
> this maybe a problem.
> 
> Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20221010104206.12184-1-zhouchengming@bytedance.com
> ---
>  kernel/sched/psi.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index ee2ecc0..f4cdf6f 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
>  			     u32 *pchanged_states)
>  {
>  	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
> +	int current_cpu = raw_smp_processor_id();
> +	bool only_avgs_work = false;
>  	u64 now, state_start;
>  	enum psi_states s;
>  	unsigned int seq;
> @@ -256,6 +258,15 @@ static void get_recent_times(struct psi_group *group, int cpu,
>  		memcpy(times, groupc->times, sizeof(groupc->times));
>  		state_mask = groupc->state_mask;
>  		state_start = groupc->state_start;
> +		/*
> +		 * This CPU has only avgs_work kworker running, snapshot the
> +		 * newest times then don't need to re-arm for this groupc.
> +		 * Normally this kworker will sleep soon and won't wake
> +		 * avgs_work back up in psi_group_change().
> +		 */
> +		if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
> +		    !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
> +			only_avgs_work = true;
>  	} while (read_seqcount_retry(&groupc->seq, seq));
>  
>  	/* Calculate state time deltas against the previous snapshot */
> @@ -280,6 +291,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
>  		if (delta)
>  			*pchanged_states |= (1 << s);
>  	}
> +
> +	/* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
> +	if (only_avgs_work)
> +		*pchanged_states &= ~(1 << PSI_NONIDLE);
>  }
>  
>  static void calc_avgs(unsigned long avg[3], int missed_periods,
