Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B159A60CAA7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiJYLKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiJYLKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:10:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A80A3AB4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:10:31 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 128so11172602pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brFxIrUt3rqtZoZebgDD18nm8Td9h/NDyRx/zJI8lq0=;
        b=07QcBTXaXAampEGpP1+BCMWkmTsUQncWlc9s5PxUnjjzDNpiF1j5Q7r1w9K8BdIUfm
         zrLBTUIsGp+zXA9fg77LdRzaIFTV36Y3SlbVy7zTN0Kkv85aNSmV4L04Td36ylm+wdAe
         TBn2TwUonhDxZ7hIwNLnAXfE54EYc9dxP9Le6QVMWildx/xfZqDIVtrSNcSBcVJ41BMC
         3CobdJKEGUVthpN8ZLH8CH4NK/WJ0bIYwdfx2zqLlUhAPDmwNjUyn1nNFFkDPnw4JNk0
         RmqowGjDEEWnciiGfwKIlOmwM+kRnUXVCgSwSeU3T6utQcGS4n5F7KeIvd4CNAuLilUO
         Wy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=brFxIrUt3rqtZoZebgDD18nm8Td9h/NDyRx/zJI8lq0=;
        b=RubAa3BYf83/OTU0Ti38EqmNJlxpRm728Jvwpk4JjSNCCIno0DmO3sPg8PS3OCQTZn
         8q/EqKuhKKO2SgUP/v5XMMwcWahtmAsDR0aZbtXZdwNhfZ9Qfkw2D/ALlWYqiNldgs1H
         rNItLhOAuoqP+ZVOwutetFCACsyNTUVf+CfmDmDm6AIssmgFLSE2yTD50BHw8pWeRHhA
         BaMymHCL5NCowOzPp3pZA5p3foVErEn7v+k3rZGNGUY2HZ5AvIxm9O+rKNrpg45N9A1g
         uC2qnl5++ljlImqRN1ziSt8VlHLjADZBiheo1RwOXHdJD7jfW3lwwDC7RlACr/xibiMb
         qdvQ==
X-Gm-Message-State: ACrzQf0U3Q1tVkQbvfD48pSIlKJHRkTF9TGvD38PawhLe6cqQtE3I/26
        7PbBkpixGfSK/WMQWHFqYd5Yug==
X-Google-Smtp-Source: AMsMyM7u6EJ5NyFfwbktBsN4ERnwK8FXRUi8gq4pvNv9Y2wrZjdjtbYKi6WWK0zhABug1bRx33HMpA==
X-Received: by 2002:a65:49c9:0:b0:462:9ce1:3f58 with SMTP id t9-20020a6549c9000000b004629ce13f58mr32212807pgs.200.1666696230877;
        Tue, 25 Oct 2022 04:10:30 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id n66-20020a622745000000b0053b723a74f7sm1223756pfn.90.2022.10.25.04.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 04:10:30 -0700 (PDT)
Message-ID: <71589225-a4fd-b3eb-14d5-81c9a19419a7@bytedance.com>
Date:   Tue, 25 Oct 2022 19:10:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [External] Re: [PATCH 1/2] sched/numa: Stop an exhastive search
 if an idle core is found
To:     Mel Gorman <mgorman@suse.de>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
References: <20221021061558.34767-1-jiahao.os@bytedance.com>
 <20221021061558.34767-2-jiahao.os@bytedance.com>
 <20221024133435.e2kajx5k7jzznp25@suse.de>
 <ced7c05a-121b-a77d-0c57-3e60abaecacd@bytedance.com>
 <20221025093226.dm4sjvdq2tofkwvc@suse.de>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20221025093226.dm4sjvdq2tofkwvc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/25 Mel Gorman wrote:
> On Tue, Oct 25, 2022 at 11:16:29AM +0800, Hao Jia wrote:
>>> Remove the change in the first hunk and call break in the second hunk
>>> after updating ns->idle_cpu.
>>>
>>
>> Yes, thanks for your review.
>> If I understand correctly, some things might look like this.
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e4a0b8bd941c..dfcb620bfe50 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1792,7 +1792,7 @@ static void update_numa_stats(struct task_numa_env
>> *env,
>>                  ns->nr_running += rq->cfs.h_nr_running;
>>                  ns->compute_capacity += capacity_of(cpu);
>>
>> -               if (find_idle && !rq->nr_running && idle_cpu(cpu)) {
>> +               if (find_idle && idle_core < 0 && !rq->nr_running &&
>> idle_cpu(cpu)) {
>>                          if (READ_ONCE(rq->numa_migrate_on) ||
>>                              !cpumask_test_cpu(cpu, env->p->cpus_ptr))
>>                                  continue;
>>
> 
> I meant more like the below but today I wondered why did I not do this in
> the first place? The answer is because it's wrong and broken in concept.
> 
> The full loop is needed to calculate approximate NUMA stats at a
> point in time. For example, the src and dst nr_running is needed by
> task_numa_find_cpu. The search for an idle CPU or core in update_numa_stats
> is simply taking advantage of the fact we are scanning anyway to keep
> track of an idle CPU or core to avoid a second search as per ff7db0bf24db
> ("sched/numa: Prefer using an idle CPU as a migration target instead of
> comparing tasks")
> 
> The patch I had in mind is below but that said, for both your version and
> my initial suggestion
> 
> Naked-by: Mel Gorman <mgorman@suse.de>
> 
> For the record, this is what I was suggesting initially because it's more
> efficient but it's wrong, don't do it.
> 

Thanks for the detailed explanation, maybe my commit message misled you.

Yes, we can't stop the whole loop of scanning the CPU because we have a 
lot of NUMA information to count.

But we can stop looking for the next idle core or idle cpu after finding 
an idle core.

So, please review the previous code.


Thanks,
Hao

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e4a0b8bd941c..7f1f6a1736a5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1800,7 +1800,12 @@ static void update_numa_stats(struct task_numa_env *env,
>   			if (ns->idle_cpu == -1)
>   				ns->idle_cpu = cpu;
>   
> +			/* If we find an idle core, stop searching. */
>   			idle_core = numa_idle_core(idle_core, cpu);
> +			if (idle_core >= 0) {
> +				ns->idle_cpu = idle_core;
> +				break;
> +			}
>   		}
>   	}
>   	rcu_read_unlock();
> @@ -1808,9 +1813,6 @@ static void update_numa_stats(struct task_numa_env *env,
>   	ns->weight = cpumask_weight(cpumask_of_node(nid));
>   
>   	ns->node_type = numa_classify(env->imbalance_pct, ns);
> -
> -	if (idle_core >= 0)
> -		ns->idle_cpu = idle_core;
>   }
>   
>   static void task_numa_assign(struct task_numa_env *env,
> 
