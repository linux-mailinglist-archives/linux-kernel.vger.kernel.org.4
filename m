Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969FD6994F8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBPM4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBPM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:56:05 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A274D3B844
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:55:39 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s8so1186073pgg.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rYhd4ZfP1S40PhYz8t8JhDH0MTGpS0y4nlSDuuKq1Ds=;
        b=ZbMPYagPuzukQSuSKuvjeSPOnBbzBVD6rPI0POYijl0FuGCFszpkkYwrKCZgcbMMAk
         01TYxWM0xH6APYrGNJMjRINcura7wknp5daJbfExWaxtqBMdUnyA3LGetUIExOsEctyu
         rc/Gd2flKEbPDsnCJScTf3bIu+QCJ5kBqlJOs17Fsv1G9siqtLwW/gb4gl7xlq73+cIt
         OZzpShooFWTuthb3eizpgASo6hkEAXdV4PFwFlS3tCBxeoD3n/BZKhG0JWhqW/AYk4mA
         DUuob8fQgowkpl6SVgcBS0v/ulTzM22CgCq7vZobp71NTJQo0Sy2V4FVVPgHfmMWNBk0
         0YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYhd4ZfP1S40PhYz8t8JhDH0MTGpS0y4nlSDuuKq1Ds=;
        b=JH+qYkXfxnbiexHPrGeuOEQAahb7aScN0tQZNF+dVg8ACcu4f80O58sbR0FPwKVdJH
         VOg4OID9lAk1IkZ0Aq8UGR7+Y3F/nG29Ifu+gTSS8sBvUEqQlhIcOJWnzv1WMfluqlzo
         l3JpoTMxhoj9W/xBK7No+Nf9uepgqmql4DRkdHwnoQCBW1miGgOH7Cl7UNl+opm107KQ
         Rja8vvE90E9iD4lJ9+b8HlsivG3GUOJ2gYHuMJskLka7bGv5CQOaZoZYVkadmyJnA3DP
         JTZ3dYgzrGMgilZRfIJvZ9NGeoSIBTDVIu1YjZRmG421XGTWqYJOx1S59uoe6yYBSJ0F
         Sa2w==
X-Gm-Message-State: AO0yUKUqswC69NNWjTGf3P76QuUHa/FfsXn0uVA/VhaAmjbDWjLxP1QL
        FHmw22sN6Jtpy5341nqm4EQ+MQ==
X-Google-Smtp-Source: AK7set9+we6Ydi0EMZDl5ZWuDf88/A9zfcoDDKTMAqWx+GFSOu1YQ4SJH1N4cjA0iu67pYuo497rtQ==
X-Received: by 2002:a62:6386:0:b0:5a8:4c55:db6f with SMTP id x128-20020a626386000000b005a84c55db6fmr4668293pfb.19.1676552139021;
        Thu, 16 Feb 2023 04:55:39 -0800 (PST)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b005941ff79428sm1281486pfn.90.2023.02.16.04.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 04:55:38 -0800 (PST)
Message-ID: <36ba3b68-5b73-9db0-2247-061627b0d95a@bytedance.com>
Date:   Thu, 16 Feb 2023 20:55:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v5 2/2] sched/fair: Introduce SIS_SHORT to wake up short
 task on current CPU
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Hillf Danton <hdanton@sina.com>,
        linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
References: <cover.1675361144.git.yu.c.chen@intel.com>
 <1b8af8d99da99a20449288ab4fbba64dc05057ce.1675361144.git.yu.c.chen@intel.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <1b8af8d99da99a20449288ab4fbba64dc05057ce.1675361144.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

I've tested this patchset (with modification) on our Redis proxy
servers, and the results seems promising.

On 2/3/23 1:18 PM, Chen Yu wrote:
> ...
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index aa16611c7263..d50097e5fcc1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6489,6 +6489,20 @@ static int wake_wide(struct task_struct *p)
>   	return 1;
>   }
>   
> +/*
> + * If a task switches in and then voluntarily relinquishes the
> + * CPU quickly, it is regarded as a short duration task.
> + *
> + * SIS_SHORT tries to wake up the short wakee on current CPU. This
> + * aims to avoid race condition among CPUs due to frequent context
> + * switch.
> + */
> +static inline int is_short_task(struct task_struct *p)
> +{
> +	return sched_feat(SIS_SHORT) && p->se.dur_avg &&
> +	       ((p->se.dur_avg * 8) < sysctl_sched_min_granularity);
> +}

I changed the factor to fit into the shape of tasks in question.

	static inline int is_short_task(struct task_struct *p)
	{
		u64 dur = sysctl_sched_min_granularity / 8;

		if (!sched_feat(SIS_SHORT) || !p->se.dur_avg)
			return false;

		/*
		 * Bare tracepoint to allow dynamically changing
		 * the threshold.
		 */
		trace_sched_short_task_tp(p, &dur);

		return p->se.dur_avg < dur;
	}

I'm not sure it is the right way to provide such flexibility, but
definition of 'short' can be workload specific.

> +
>   /*
>    * The purpose of wake_affine() is to quickly determine on which CPU we can run
>    * soonest. For the purpose of speed we only consider the waking and previous
> @@ -6525,6 +6539,11 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>   	if (available_idle_cpu(prev_cpu))
>   		return prev_cpu;
>   
> +	/* The only running task is a short duration one. */
> +	if (cpu_rq(this_cpu)->nr_running == 1 &&
> +	    is_short_task(rcu_dereference(cpu_curr(this_cpu))))
> +		return this_cpu;

Since proxy server handles simple data delivery, the tasks are
generally short running ones and hate task stacking which may
introduce scheduling latency (even there are only 2 short tasks
competing each other). So this part brings slight regression on
the proxy case. But I still think this is good for most cases.

Speaking of task stacking, I found wake_affine_weight() can be
much more dangerous. It chooses the less loaded one between the
prev & this cpu as a candidate, so 'small' tasks can be easily
stacked on this cpu when wake up several tasks at one time if
this cpu is unloaded. This really hurts if the 'small' tasks are
latency-sensitive, although wake_affine_weight() does the right
thing from the point of view of 'load'.

The following change greatly reduced the p99lat of Redis service
from 150ms to 0.9ms, at exactly the same throughput (QPS).

@@ -5763,6 +5787,9 @@ wake_affine_weight(struct sched_domain *sd, struct 
task_struct *p,
	s64 this_eff_load, prev_eff_load;
	unsigned long task_load;

+	if (is_short_task(p))
+		return nr_cpumask_bits;
+
	this_eff_load = cpu_load(cpu_rq(this_cpu));

	if (sync) {

I know that 'short' tasks are not necessarily 'small' tasks, e.g.
sleeping duration is small or have large weights, but this works
really well for this case. This is partly because delivering data
is memory bandwidth intensive hence prefer cache hot cpus. And I
think this is also applicable to the general purposes: do NOT let
the short running tasks suffering from cache misses caused by
migration.

Best regards,
	Abel
