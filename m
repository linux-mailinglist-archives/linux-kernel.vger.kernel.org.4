Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D680360C229
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJYDQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJYDQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:16:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8CF29807
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:16:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m2so5653849pjr.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt6csZKjyFbh3Av74KUaYS0trbNlNlUkWTp5o72OjTg=;
        b=fDGCHneHUqElVQPodFdPJtrvhFmLUBq0JUMOcfxyXjoV747t1v+9IDwLIA2L3kB50G
         Lf/LFJJjucoayWTbObOguSKZs1aU+KUPdvTlrGpy1rOxGBdS70xHTniN9j/0M3Yf3zHO
         7v6liLN68PxvDtyeX35Pd5YO3VkDKWv1+FzWZ5XLo1xqtsK+y5yHZJ5Jq1Y5U6hiNeAg
         aozUcIiVO5d8tVlxXX8UtpNDNWK6Eu5nlxr2relBGWV8agl11Fn71alKk+Z6+/BASxG0
         w56LXiCsY/Hv4nGvQWnAyH5lvyeHcUv/l8t2hKBWarSH6dqpdjVjXaTjm7FQIaxYsd8m
         fRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yt6csZKjyFbh3Av74KUaYS0trbNlNlUkWTp5o72OjTg=;
        b=CgFuYekqTvwYxj+TMwzx3Qqr9nMxEqlBzNain6vMr1MiWw1PPxhv7/gXPYKV6GJ4+n
         6rhgQQ2WKmMSMfy/N+6fUtTNiKMpFiU7Kv4sW1Q2CWIbM/XwaLuujjXnIXNQFCfmj8hE
         yeil0Q59HxDg3dtRMH+vcLL0CxQhys9P4a/NpkTTHgcLkkzaIwUx9/L5fMDb1/RSQ330
         e06FrtrWGnFdavJPsvELeiMSk7BLfGkd+JZ7RSr5/vhwHqNEZO60gUNBCOV9z8WGMNEO
         Yev2wFyrjWrqDoSKYmS61ctgf1+CJCePf3rOrUYEL2Jm+lLtJo327cjSW4iUVf09fFCM
         yEcg==
X-Gm-Message-State: ACrzQf1YXuDTbSrYEeA+CH5GZ8jJ9D7thdEqdFHlafRYXsriHhKobk7C
        D2tyVKERA9CtIxzNKf8SEQMoenft1ZQkadwb
X-Google-Smtp-Source: AMsMyM50JW+u5z1CIhPwUgy1Vv7ZiEcV8QEpbd12R6DcKaL24S6fQLLoWhXRfAt5d/oRQBKc0xIACQ==
X-Received: by 2002:a17:90b:1bcb:b0:20d:75b8:ee64 with SMTP id oa11-20020a17090b1bcb00b0020d75b8ee64mr41969744pjb.162.1666667797632;
        Mon, 24 Oct 2022 20:16:37 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id p25-20020a635b19000000b0044a4025cea1sm391718pgb.90.2022.10.24.20.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 20:16:37 -0700 (PDT)
Message-ID: <ced7c05a-121b-a77d-0c57-3e60abaecacd@bytedance.com>
Date:   Tue, 25 Oct 2022 11:16:29 +0800
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
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20221024133435.e2kajx5k7jzznp25@suse.de>
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



On 2022/10/24 Mel Gorman wrote:
> On Fri, Oct 21, 2022 at 02:15:57PM +0800, Hao Jia wrote:
>> In update_numa_stats() we try to find an idle cpu on the NUMA node,
>> preferably an idle core. When we find an idle core,
>> we can stop searching.
>>
>> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
>> ---
>>   kernel/sched/fair.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e4a0b8bd941c..b7cbec539c77 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1792,7 +1792,7 @@ static void update_numa_stats(struct task_numa_env *env,
>>   		ns->nr_running += rq->cfs.h_nr_running;
>>   		ns->compute_capacity += capacity_of(cpu);
>>   
>> -		if (find_idle && !rq->nr_running && idle_cpu(cpu)) {
>> +		if (find_idle && idle_core < 0 && !rq->nr_running && idle_cpu(cpu)) {
>>   			if (READ_ONCE(rq->numa_migrate_on) ||
>>   			    !cpumask_test_cpu(cpu, env->p->cpus_ptr))
>>   				continue;
>> @@ -1801,6 +1801,9 @@ static void update_numa_stats(struct task_numa_env *env,
>>   				ns->idle_cpu = cpu;
>>   
>>   			idle_core = numa_idle_core(idle_core, cpu);
>> +			/* If we find an idle core, stop searching. */
>> +			if (idle_core >= 0)
>> +				ns->idle_cpu = idle_core;
>>   		}
>>   	}
>>   	rcu_read_unlock();
>> @@ -1808,9 +1811,6 @@ static void update_numa_stats(struct task_numa_env *env,
>>   	ns->weight = cpumask_weight(cpumask_of_node(nid));
>>   
>>   	ns->node_type = numa_classify(env->imbalance_pct, ns);
>> -
>> -	if (idle_core >= 0)
>> -		ns->idle_cpu = idle_core;
>>   }
>>   
> 
> Remove the change in the first hunk and call break in the second hunk
> after updating ns->idle_cpu.
> 

Yes, thanks for your review.
If I understand correctly, some things might look like this.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..dfcb620bfe50 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1792,7 +1792,7 @@ static void update_numa_stats(struct task_numa_env 
*env,
                 ns->nr_running += rq->cfs.h_nr_running;
                 ns->compute_capacity += capacity_of(cpu);

-               if (find_idle && !rq->nr_running && idle_cpu(cpu)) {
+               if (find_idle && idle_core < 0 && !rq->nr_running && 
idle_cpu(cpu)) {
                         if (READ_ONCE(rq->numa_migrate_on) ||
                             !cpumask_test_cpu(cpu, env->p->cpus_ptr))
                                 continue;

Thanks,
Hao
