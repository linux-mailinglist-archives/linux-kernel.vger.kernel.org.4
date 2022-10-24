Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56784609EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiJXKLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiJXKLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:11:23 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0603335A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:11:13 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f193so8338101pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhMHi9pt2LIGgo+2ImrZgJS1xHR9XGh+YrBqzttlPNU=;
        b=MSSXA/dlzGLVzksZRAZ+A8xEnGns3ZtVKS0A+Vj/jiEd7GVbsWfa9JWcFaIEi50g7n
         e0lkJXkfn8Zxo4Hq8tU76/E0R5XFBpKuqBUEzecR8K0HCObCTrMPaibZlhnFalYtctV4
         ipTqsZ6RUUQIE1tI3g8SMarnj/JUYB8PTrVOktM4ESPye6c3vG4KSeuJTGS/EwOTcNzl
         JrYzgolrx8Y0LtHTH0Xew3X6qCR5HCIFa2ZqgudMNlumPUw7Tef7qC7UBwoS3KuC0JWF
         HmzPIV8c/ccFYIBNw00VtiP79j1rgvKYkZGQ67FI73oB0niEMRJn3Af01RlcPvcq3kOd
         S2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhMHi9pt2LIGgo+2ImrZgJS1xHR9XGh+YrBqzttlPNU=;
        b=AE+AfW8xf8eWSPUsQj4mv49fqE6gbuxvxo0KqN7IjFmZ/YhwWgxH8bRbz3J4f/k31I
         /p4TKKpOl/mguuWBMGwy9HWTsM0Tz1hZZDTJCp4jimDp8WOOpPZDLdCZx0xZYWzBk1RL
         E4f5kfwijiqTMTW1zrOuQdfr4KmSyCcISOICWGNhdsmu7MdX/70YCuIYSZzDrLUAgYjr
         h5TZ7zsEc36dEuMWvmOJGH0EEpJDMUTGiZwdfaqdbuWVYr7Uf3rfYy0vCy4fYDejRQ5g
         j0gzwgkymWhaPonfDSnUWY8tUdRdPb6xAEpui9DmJwLwt1khALZ74n6XniMtnkX6CRLr
         nI9Q==
X-Gm-Message-State: ACrzQf0JBPL7DcD8yj3KPy0bJEdxCGhYH70LeLnZkP+pdmj3oAtGzOcg
        YueOdCF5EIG5FrR7kXOBWp6oZg==
X-Google-Smtp-Source: AMsMyM40/gBhYxt9NKpAltFCRmeVRLvLMoOwfkWSIWqEe/biyiSY2ifQJ+tAdj3/lcwVkZ2Z8dhrfQ==
X-Received: by 2002:a05:6a00:218d:b0:569:84e0:19e5 with SMTP id h13-20020a056a00218d00b0056984e019e5mr20889661pfi.11.1666606231616;
        Mon, 24 Oct 2022 03:10:31 -0700 (PDT)
Received: from [10.255.12.190] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902b70800b001806445887asm19063179pls.223.2022.10.24.03.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 03:10:31 -0700 (PDT)
Message-ID: <20506673-cd33-c89c-75d9-89d2999432dc@bytedance.com>
Date:   Mon, 24 Oct 2022 18:10:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [RFC PATCH v2 1/2] sched/fair: Introduce short duration task
 check
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org
References: <cover.1666531576.git.yu.c.chen@intel.com>
 <6b81eea9a8cafb7634f36586f1744b8d4ac49da5.1666531576.git.yu.c.chen@intel.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <6b81eea9a8cafb7634f36586f1744b8d4ac49da5.1666531576.git.yu.c.chen@intel.com>
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

LGTM, and please check inline comments.

On 10/23/22 11:32 PM, Chen Yu wrote:
> Introduce short-duration task checks, as there is a
> requirement to leverage this attribute for better task placement.
> 
> There are several choices of metrics that could be used to
> indicate if a task is a short-duration task.
> 
> At first thought the (p->se.sum_exec_runtime / p->nvcsw)
> could be used to measure the task duration. However, the
> history long past was factored too heavily in such a formula.
> Ideally, the old activity should decay and not affect
> the current status too much.
> 
> PELT could decay the runtime time, so maybe something like
> se.util_avg could be used. But after a second thought, PELT
> might not be appropriate to measure the duration:
> 1. Task p1 and task p2 are doing frequent ping-pong scheduling on
>     one CPU, both p1 and p2 have a short duration, but the util_avg
>     can be up to 50%.
> 2. Suppose a task lasting less than 4ms is regarded as a short task.
>     If task p3 runs for 6ms and sleeps for 32ms, it should not be a
>     short-duration task. However, PELT would decay p3's accumulated
>     running time from 6ms to 3ms, because 32ms is the half-life in PELT.
>     As a result, p3 would be incorrectly treated as a short task.
> 
> It was found that there was once a similar feature to track the
> duration of a task, which is in Commit ad4b78bbcbab ("sched: Add
> new wakeup preemption mode: WAKEUP_RUNNING"). Unfortunately, it
> was reverted because it was an experiment. So pick the patch up
> again, by recording the average duration when a task voluntarily
> switches out. The calculation of average duration is borrowed
> from the idea of Exponential Weighted Moving Average (EWMA) in
> util_est_update(). The effect is that the average task duration
> is calculated by:
> new_avg_duration = old_avg_duration * 0.875 + lastest_duration * 0.125;
> which is what update_avg() does now.
> 
> Introduce SIS_SHORT to control this strategy.
> 
> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>   include/linux/sched.h   |  8 +++++
>   kernel/sched/core.c     |  2 ++
>   kernel/sched/fair.c     | 77 +++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/features.h |  1 +
>   4 files changed, 88 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index ffb6eb55cd13..ff74301b1548 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -557,6 +557,14 @@ struct sched_entity {
>   	u64				prev_sum_exec_runtime;
>   
>   	u64				nr_migrations;
> +	/*
> +	 * The 'snapshot' of sum_exec_runtime when task
> +	 * voluntarily switches out. This is used to
> +	 * calculate the average duration below.
> +	 */
> +	u64				prev_sum_runtime_vol;
> +	/* average duration of a task */
> +	u64				dur_avg;
>   
>   #ifdef CONFIG_FAIR_GROUP_SCHED
>   	int				depth;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5800b0623ff3..f5281fe7f8f0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4330,6 +4330,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>   	p->se.prev_sum_exec_runtime	= 0;
>   	p->se.nr_migrations		= 0;
>   	p->se.vruntime			= 0;
> +	p->se.dur_avg			= 0;
> +	p->se.prev_sum_runtime_vol	= 0;
>   	INIT_LIST_HEAD(&p->se.group_node);
>   
>   #ifdef CONFIG_FAIR_GROUP_SCHED
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e4a0b8bd941c..8820d0d14519 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6200,6 +6200,19 @@ static int wake_wide(struct task_struct *p)
>   	return 1;
>   }
>   
> +/*
> + * If a task switches in and then voluntarily relinquishes the
> + * CPU quickly, it is regarded as a short duration task.
> + * sysctl_sched_min_granularity is chosen as the threshold,
> + * as this value is the minimal slice if there are too many
> + * runnable tasks, see __sched_period().
> + */
> +static inline int is_short_task(struct task_struct *p)
> +{
> +	return sched_feat(SIS_SHORT) &&
> +		(p->se.dur_avg <= sysctl_sched_min_granularity);

The min_granularity is default to 750us, and can be tuned higher on
machines running batch workloads. So I'm not sure it is appropriate
to define 'short' by min_granularity.

> +}
> +
>   /*
>    * The purpose of wake_affine() is to quickly determine on which CPU we can run
>    * soonest. For the purpose of speed we only consider the waking and previous
> @@ -7679,6 +7692,70 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
>   {
>   	struct sched_entity *se = &prev->se;
>   	struct cfs_rq *cfs_rq;
> +	u64 this_dur_avg, last_dur_avg;
> +	long delta;
> +
> +	/*
> +	 * Calculate the task's average duration.
> +	 *
> +	 * Only consider that task voluntarily relinquishes the CPU.
> +	 * For example, suppose on CPU1, task p1 and p2 runs
> +	 * alternatively:
> +	 *
> +	 * --------------------> time
> +	 *
> +	 * | p1 runs 1ms | p2 preempt p1 | p1 runs 0.5ms and sleeps |
> +	 * ^             ^               ^                          ^
> +	 * |_____________|               |__________________________|
> +	 *        |____________________________________|
> +	 *                   p1's duration
> +	 *
> +	 *
> +	 * The duration of p1 is 1.5ms rather than 0.5ms or 1ms
> +	 * in above case. That is to say, the duration period starts
> +	 * when task p1 switches in, ends when task p1 voluntarily
> +	 * relinquishes the CPU. This duration descibes the "nature"
> +	 * of a task: If a task is not preempted, how long it will
> +	 * run.
> +	 *
> +	 * The Exponential Weighted Moving Average (EWMA)
> +	 * is used to calculate the average duration.
> +	 * Borrowed from util_est_update():
> +	 *
> +	 *  ewma(t) = w * this_dur_avg + (1-w) * ewma(t-1)
> +	 *
> +	 * When 'w' is 0.125, it becomes update_avg().
> +	 * This indicates that we care about approximately
> +	 * the recent 1 / 0.125 = 8 history duration.
> +	 */
> +	if (sched_feat(SIS_SHORT) && !prev->on_rq) {
> +		/*
> +		 * sum_exec_runtime has been updated in update_curr()
> +		 * because we reach here via dequeue.
> +		 */
> +		this_dur_avg = se->sum_exec_runtime - se->prev_sum_runtime_vol;
> +		/*
> +		 * Record the accumulated runtime when task voluntarily
> +		 * switches out. End of old duration period, a new period
> +		 * starts.
> +		 */
> +		se->prev_sum_runtime_vol = se->sum_exec_runtime;
> +
> +		last_dur_avg = se->dur_avg;
> +		delta = this_dur_avg - last_dur_avg;
> +		/* consider large change to avoid frequent update */
> +		if (abs(delta) >= sysctl_sched_min_granularity) {
> +			/*
> +			 * If it is the first time the task starts to
> +			 * record dur_avg, discard the initial value 0.
> +			 * Otherwise, calculate the EWMA.
> +			 */
> +			if (unlikely(!this_dur_avg))
> +				se->dur_avg = this_dur_avg;

Would it better initialize to 'short' (min_granularity in this case)?
So we can get rid of this check.

> +			else
> +				update_avg(&se->dur_avg, this_dur_avg);
> +		}
> +	}
>   
>   	for_each_sched_entity(se) {
>   		cfs_rq = cfs_rq_of(se);
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index ee7f23c76bd3..efdc29c42161 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>    */
>   SCHED_FEAT(SIS_PROP, false)
>   SCHED_FEAT(SIS_UTIL, true)
> +SCHED_FEAT(SIS_SHORT, true)
>   
>   /*
>    * Issue a WARN when we do multiple update_rq_clock() calls
