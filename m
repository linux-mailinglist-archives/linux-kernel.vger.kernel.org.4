Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC91750514
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjGLKrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjGLKrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:47:37 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A614E7E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:47:36 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a1ebb85f99so5851530b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689158856; x=1691750856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PDOosu2ne0gm5Jt5V8hGgTRloGEManBLAQFgQAQz/F0=;
        b=XBaV1AABPEVlRdJHWwYLz15Suv8K6vkgUluCcUawbbCayfvAwjuAvUjXVF9WCEWyBT
         gavvu4TW+CyaUavZTMqRydYN3R/cimPtkYroCjtEwKRDWKHzHvhEE5A1v0ioKHHtC98I
         Xg0iwDk/aOFgqRRsbCFuoU5iw0VMK9oWizHorSCvUhD4MaTpypwR0jxn+I/A7UGJ0APE
         UOOUJGQLevMeSlv37NWtONloHXZKw7Vtzmi6I/Qzbo4xmsCv3+mvhz3qdjWFEUfd7zAj
         2qd/Z24dxxdAhR4HvetfDn2XXdaB5VQ9sy2oaE+tlH6qD0T71d2sIpEsb7c2azq5IVRY
         f99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158856; x=1691750856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDOosu2ne0gm5Jt5V8hGgTRloGEManBLAQFgQAQz/F0=;
        b=jp54DS5/Wq8chyL6lxvSwSmoXcH/Ryq28OU5Rf6JUKbz4bdkx2q1ZNAw5KaIDV6wBC
         Gi0unIxh+kMufv02d5+UL6qzzaDCkcQPqkeI/gnGHxl9JtMgyJ7LjvXkFK3tawfDnc2C
         tolA8o7fKVWCn6QzkRUr6AU7TfoK4zMjY3Rd7g9snwOeOhHxkZUnePl7HdMQyU69lclR
         M+YmMZdCPdAX5BYp7E7PWHyYVnO10neHKJ6SP7tKc/+b7s72YLpZTfC06BPRI/zAOTjS
         xeXb+vB4SC+Tc1yMshnsJeou5fqXZ9cTLzQGPBBgtxS2Lc+u04JkqVIFI8FGT3j4StQz
         T5/A==
X-Gm-Message-State: ABy/qLbN3TZ52xhT/bKUBVlsP0BuvKCpvaqEFp/DTf6rEFghmoxKHTEJ
        HHWA8zKwA30JefUsZuxHNJ+dIg==
X-Google-Smtp-Source: APBJJlGd1TowVZiLr1Jwlx0jZOsnFdBC2nan+ytLOPr/Bss+5xHQveY0vH1xpxxfKRc+eXgpUevo6A==
X-Received: by 2002:a05:6808:1411:b0:3a4:58:8e87 with SMTP id w17-20020a056808141100b003a400588e87mr11893506oiv.52.1689158855699;
        Wed, 12 Jul 2023 03:47:35 -0700 (PDT)
Received: from [10.94.58.170] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7828e000000b0063d24fcc2b7sm3360801pfm.1.2023.07.12.03.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 03:47:35 -0700 (PDT)
Message-ID: <93260dd9-818a-7f98-e030-635e0dc8cad8@bytedance.com>
Date:   Wed, 12 Jul 2023 18:47:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/7] sched: Implement shared runqueue in CFS
Content-Language: en-US
To:     David Vernet <void@manifault.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com, clm@meta.com,
        tj@kernel.org, roman.gushchin@linux.dev, kernel-team@meta.com,
        linux-kernel@vger.kernel.org
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-6-void@manifault.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230710200342.358255-6-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, interesting patch!

On 7/11/23 4:03 AM, David Vernet wrote:
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1292d38d66cc..5c05a3da3d50 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -770,6 +770,8 @@ struct task_struct {
>   	unsigned long			wakee_flip_decay_ts;
>   	struct task_struct		*last_wakee;
>   
> +	struct list_head		shared_runq_node;
> +
>   	/*
>   	 * recent_used_cpu is initially set as the last CPU used by a task
>   	 * that wakes affine another task. Waker/wakee relationships can
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1451f5aa82ac..3ad437d4ea3d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4503,6 +4503,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>   #ifdef CONFIG_SMP
>   	p->wake_entry.u_flags = CSD_TYPE_TTWU;
>   	p->migration_pending = NULL;
> +	INIT_LIST_HEAD(&p->shared_runq_node);
>   #endif
>   	init_sched_mm_cid(p);
>   }
> @@ -9842,6 +9843,7 @@ void __init sched_init_smp(void)
>   
>   	init_sched_rt_class();
>   	init_sched_dl_class();
> +	init_sched_fair_class_late();
>   
>   	sched_smp_initialized = true;
>   }
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f7967be7646c..ff2491387201 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -139,18 +139,163 @@ static int __init setup_sched_thermal_decay_shift(char *str)
>   }
>   __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
>   
> +/**
> + * struct shared_runq - Per-LLC queue structure for enqueuing and pulling
> + * waking tasks.
> + *
> + * WHAT
> + * ====
> + *
> + * This structure enables the scheduler to be more aggressively work
> + * conserving, by placing waking tasks on a per-LLC FIFO queue that can then be
> + * pulled from when another core in the LLC is going to go idle.
> + *
> + * struct rq stores a pointer to its LLC's shared_runq via struct cfs_rq.
> + * Waking tasks are enqueued in a shared_runq at the end of
> + * enqueue_task_fair(), and are opportunistically pulled from the shared_runq
> + * in newidle_balance(). Tasks enqueued in a shared_runq may be scheduled prior
> + * to being pulled from the shared_runq, in which case they're simply dequeued
> + * from the shared_runq. A waking task is only enqueued to a shared_runq when
> + * it was _not_ manually migrated to the current runqueue by
> + * select_task_rq_fair().
> + *
> + * There is currently no task-stealing between shared_runqs in different LLCs,
> + * which means that shared_runq is not fully work conserving. This could be
> + * added at a later time, with tasks likely only being stolen across
> + * shared_runqs on the same NUMA node to avoid violating NUMA affinities.
> + *
> + * HOW
> + * ===
> + *
> + * An shared_runq is comprised of a list, and a spinlock for synchronization.
> + * Given that the critical section for a shared_runq is typically a fast list
> + * operation, and that the shared_runq is localized to a single LLC, the
> + * spinlock will typically only be contended on workloads that do little else
> + * other than hammer the runqueue.

Would there be scalability issues on large LLCs?

> + *
> + * WHY
> + * ===
> + *
> + * As mentioned above, the main benefit of shared_runq is that it enables more
> + * aggressive work conservation in the scheduler. This can benefit workloads
> + * that benefit more from CPU utilization than from L1/L2 cache locality.
> + *
> + * shared_runqs are segmented across LLCs both to avoid contention on the
> + * shared_runq spinlock by minimizing the number of CPUs that could contend on
> + * it, as well as to strike a balance between work conservation, and L3 cache
> + * locality.
> + */
> +struct shared_runq {
> +	struct list_head list;
> +	spinlock_t lock;
> +} ____cacheline_aligned;
> +
>   #ifdef CONFIG_SMP
> +static struct shared_runq *rq_shared_runq(struct rq *rq)
> +{
> +	return rq->cfs.shared_runq;
> +}
> +
> +static struct task_struct *shared_runq_pop_task(struct rq *rq)
> +{
> +	unsigned long flags;
> +	struct task_struct *p;
> +	struct shared_runq *shared_runq;
> +
> +	shared_runq = rq_shared_runq(rq);
> +	if (list_empty(&shared_runq->list))
> +		return NULL;
> +
> +	spin_lock_irqsave(&shared_runq->lock, flags);
> +	p = list_first_entry_or_null(&shared_runq->list, struct task_struct,
> +				     shared_runq_node);
> +	if (p && is_cpu_allowed(p, cpu_of(rq)))
> +		list_del_init(&p->shared_runq_node);
> +	else
> +		p = NULL;
> +	spin_unlock_irqrestore(&shared_runq->lock, flags);
> +
> +	return p;
> +}
> +
> +static void shared_runq_push_task(struct rq *rq, struct task_struct *p)
> +{
> +	unsigned long flags;
> +	struct shared_runq *shared_runq;
> +
> +	shared_runq = rq_shared_runq(rq);
> +	spin_lock_irqsave(&shared_runq->lock, flags);
> +	list_add_tail(&p->shared_runq_node, &shared_runq->list);
> +	spin_unlock_irqrestore(&shared_runq->lock, flags);
> +}
> +
>   static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p,
>   				     int enq_flags)
> -{}
> +{
> +	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> +	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
> +
> +	/*
> +	 * Only enqueue the task in the shared runqueue if:
> +	 *
> +	 * - SWQUEUE is enabled
> +	 * - The task is on the wakeup path
> +	 * - The task wasn't purposefully migrated to the current rq by
> +	 *   select_task_rq()
> +	 * - The task isn't pinned to a specific CPU
> +	 */
> +	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> +		return;
> +
> +	shared_runq_push_task(rq, p);
> +}
>   
>   static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
>   {
> -	return 0;
> +	struct task_struct *p = NULL;
> +	struct rq *src_rq;
> +	struct rq_flags src_rf;
> +	int ret;
> +
> +	p = shared_runq_pop_task(rq);
> +	if (!p)
> +		return 0;
> +
> +	rq_unpin_lock(rq, rf);
> +	raw_spin_rq_unlock(rq);

It would be better use the rq_unlock(rq, rf) for simplicity.
But it's absolutely OK if you want to keep as it is to be
correspond with the below lock&repin part :)

> +
> +	src_rq = task_rq_lock(p, &src_rf);
> +
> +	if (task_on_rq_queued(p) && !task_on_cpu(rq, p)) {

IMHO it should be:

	if (task_on_rq_queued(p) && !task_on_cpu(src_rq, p)) {

> +		update_rq_clock(src_rq);
> +		src_rq = move_queued_task(src_rq, &src_rf, p, cpu_of(rq));
> +	}
> +
> +	if (src_rq->cpu != rq->cpu)

Why not just 'if (src_rq != rq)'?

> +		ret = 1;
> +	else
> +		ret = -1;

What about making @ret default to -1 and changing to 1 right
after move_queued_task()? Both for better readability and align
with the behavior of newidle_balance().

> +
> +	task_rq_unlock(src_rq, p, &src_rf);
> +
> +	raw_spin_rq_lock(rq);
> +	rq_repin_lock(rq, rf);

By making it looks more ugly, we can save some cycles..

	if (src_rq != rq) {
		task_rq_unlock(src_rq, p, &src_rf);
	} else {
		rq_unpin_lock(src_rq, src_rf);
		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
		rq_repin_lock(rq, rf);
	}

> +
> +	return ret;
>   }
>   
>   static void shared_runq_dequeue_task(struct task_struct *p)
> -{}
> +{
> +	unsigned long flags;
> +	struct shared_runq *shared_runq;
> +
> +	if (!list_empty(&p->shared_runq_node)) {
> +		shared_runq = rq_shared_runq(task_rq(p));
> +		spin_lock_irqsave(&shared_runq->lock, flags);
> +		list_del_init(&p->shared_runq_node);
> +		spin_unlock_irqrestore(&shared_runq->lock, flags);
> +	}
> +}
>   
>   /*
>    * For asym packing, by default the lower numbered CPU has higher priority.
> @@ -12854,3 +12999,34 @@ __init void init_sched_fair_class(void)
>   #endif /* SMP */
>   
>   }
> +
> +__init void init_sched_fair_class_late(void)
> +{
> +#ifdef CONFIG_SMP
> +	int i;
> +	struct shared_runq *shared_runq;
> +	struct rq *rq;
> +	struct rq *llc_rq;
> +
> +	for_each_possible_cpu(i) {
> +		if (per_cpu(sd_llc_id, i) == i) {
> +			llc_rq = cpu_rq(i);
> +
> +			shared_runq = kzalloc_node(sizeof(struct shared_runq),
> +					       GFP_KERNEL, cpu_to_node(i));
> +			INIT_LIST_HEAD(&shared_runq->list);
> +			spin_lock_init(&shared_runq->lock);
> +			llc_rq->cfs.shared_runq = shared_runq;
> +		}
> +	}
> +
> +	for_each_possible_cpu(i) {
> +		rq = cpu_rq(i);
> +		llc_rq = cpu_rq(per_cpu(sd_llc_id, i));
> +
> +		if (rq == llc_rq)
> +			continue;
> +		rq->cfs.shared_runq = llc_rq->cfs.shared_runq;
> +	}
> +#endif /* SMP */
> +}
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 187ad5da5ef6..8b573dfaba33 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -576,6 +576,7 @@ struct cfs_rq {
>   #endif
>   
>   #ifdef CONFIG_SMP
> +	struct shared_runq	*shared_runq;

I would suggest moving shared_runq into shared LLC sched domain,
which is pointed by sd_llc_shared, as you might finally put the
retrieval of shared_runq under RCU critical sections to handle
domain re-building cases.

Best Regards,
	Abel

>   	/*
>   	 * CFS load tracking
>   	 */
> @@ -2440,6 +2441,7 @@ extern void update_max_interval(void);
>   extern void init_sched_dl_class(void);
>   extern void init_sched_rt_class(void);
>   extern void init_sched_fair_class(void);
> +extern void init_sched_fair_class_late(void);
>   
>   extern void reweight_task(struct task_struct *p, int prio);
>   
