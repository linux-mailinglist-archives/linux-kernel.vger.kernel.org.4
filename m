Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF915FDBE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJMODW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiJMODR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1982CDD9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665669648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yd3l2bnfGfGAQYuBqUe+XLP04k/HpJaNnbZjwhMo5Rs=;
        b=CzaJP3HGgrpyLxqXXy5I7+ybwpIDVGfxjTwQQcNIDWIE4+Bo4tG4tmmmQlGTjjVPv02RJp
        kGxYmp+3081fH5T4chGaXWpax78AQqsXxNQQunWH1v8ehpTq9F/VbR+UMBXMZFwOha88xz
        UN0lDUJQ4ROj2w/sjMO6tQ1s29TwlHM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-N76OwQQ7P5agdJtaHV6J0w-1; Thu, 13 Oct 2022 10:00:45 -0400
X-MC-Unique: N76OwQQ7P5agdJtaHV6J0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 824A7857D15;
        Thu, 13 Oct 2022 14:00:39 +0000 (UTC)
Received: from [10.22.17.27] (unknown [10.22.17.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A01501400C3B;
        Thu, 13 Oct 2022 14:00:23 +0000 (UTC)
Message-ID: <dfbf0fcb-4e08-9276-22b6-3630e36408f9@redhat.com>
Date:   Thu, 13 Oct 2022 10:00:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [peterz-queue:sched/core 14/15] kernel/sched/core.c:9815:43:
 error: passing argument 1 of 'zalloc_cpumask_var_node' from incompatible
 pointer type
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <202210132143.3ua042iu-lkp@intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <202210132143.3ua042iu-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/13/22 09:49, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
> head:   e7c69e86e29590d8bacd63595f3a687d97288ccc
> commit: ecf44ad8a0325439035003643fd11725147fae18 [14/15] sched: Enforce user requested affinity
> config: x86_64-randconfig-a013
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>          # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=ecf44ad8a0325439035003643fd11725147fae18
>          git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>          git fetch --no-tags peterz-queue sched/core
>          git checkout ecf44ad8a0325439035003643fd11725147fae18
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     kernel/sched/core.c: In function 'sched_init':
>>> kernel/sched/core.c:9815:43: error: passing argument 1 of 'zalloc_cpumask_var_node' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      9815 |                 zalloc_cpumask_var_node(rq->scratch_mask, GFP_KERNEL, cpu_to_node(i));

Sorry, it should have a '&' in front of rq->scratch_mask.

Cheers,
Longman

>           |                                         ~~^~~~~~~~~~~~~~
>           |                                           |
>           |                                           struct cpumask *
>     In file included from arch/x86/include/asm/cpumask.h:5,
>                      from arch/x86/include/asm/msr.h:11,
>                      from arch/x86/include/asm/processor.h:22,
>                      from arch/x86/include/asm/cpufeature.h:5,
>                      from arch/x86/include/asm/thread_info.h:53,
>                      from include/linux/thread_info.h:60,
>                      from arch/x86/include/asm/preempt.h:7,
>                      from include/linux/preempt.h:78,
>                      from include/linux/spinlock.h:56,
>                      from include/linux/wait.h:9,
>                      from include/linux/wait_bit.h:8,
>                      from include/linux/fs.h:6,
>                      from include/linux/highmem.h:5,
>                      from kernel/sched/core.c:9:
>     include/linux/cpumask.h:880:59: note: expected 'struct cpumask (*)[1]' but argument is of type 'struct cpumask *'
>       880 | static inline bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags,
>           |                                            ~~~~~~~~~~~~~~~^~~~
>     cc1: some warnings being treated as errors
>
>
> vim +/zalloc_cpumask_var_node +9815 kernel/sched/core.c
>
>    9767	
>    9768			rq->rt.rt_runtime = def_rt_bandwidth.rt_runtime;
>    9769	#ifdef CONFIG_RT_GROUP_SCHED
>    9770			init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
>    9771	#endif
>    9772	#ifdef CONFIG_SMP
>    9773			rq->sd = NULL;
>    9774			rq->rd = NULL;
>    9775			rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
>    9776			rq->balance_callback = &balance_push_callback;
>    9777			rq->active_balance = 0;
>    9778			rq->next_balance = jiffies;
>    9779			rq->push_cpu = 0;
>    9780			rq->cpu = i;
>    9781			rq->online = 0;
>    9782			rq->idle_stamp = 0;
>    9783			rq->avg_idle = 2*sysctl_sched_migration_cost;
>    9784			rq->wake_stamp = jiffies;
>    9785			rq->wake_avg_idle = rq->avg_idle;
>    9786			rq->max_idle_balance_cost = sysctl_sched_migration_cost;
>    9787	
>    9788			INIT_LIST_HEAD(&rq->cfs_tasks);
>    9789	
>    9790			rq_attach_root(rq, &def_root_domain);
>    9791	#ifdef CONFIG_NO_HZ_COMMON
>    9792			rq->last_blocked_load_update_tick = jiffies;
>    9793			atomic_set(&rq->nohz_flags, 0);
>    9794	
>    9795			INIT_CSD(&rq->nohz_csd, nohz_csd_func, rq);
>    9796	#endif
>    9797	#ifdef CONFIG_HOTPLUG_CPU
>    9798			rcuwait_init(&rq->hotplug_wait);
>    9799	#endif
>    9800	#endif /* CONFIG_SMP */
>    9801			hrtick_rq_init(rq);
>    9802			atomic_set(&rq->nr_iowait, 0);
>    9803	
>    9804	#ifdef CONFIG_SCHED_CORE
>    9805			rq->core = rq;
>    9806			rq->core_pick = NULL;
>    9807			rq->core_enabled = 0;
>    9808			rq->core_tree = RB_ROOT;
>    9809			rq->core_forceidle_count = 0;
>    9810			rq->core_forceidle_occupation = 0;
>    9811			rq->core_forceidle_start = 0;
>    9812	
>    9813			rq->core_cookie = 0UL;
>    9814	#endif
>> 9815			zalloc_cpumask_var_node(rq->scratch_mask, GFP_KERNEL, cpu_to_node(i));
>    9816		}
>    9817	
>    9818		set_load_weight(&init_task, false);
>    9819	
>    9820		/*
>    9821		 * The boot idle thread does lazy MMU switching as well:
>    9822		 */
>    9823		mmgrab(&init_mm);
>    9824		enter_lazy_tlb(&init_mm, current);
>    9825	
>    9826		/*
>    9827		 * The idle task doesn't need the kthread struct to function, but it
>    9828		 * is dressed up as a per-CPU kthread and thus needs to play the part
>    9829		 * if we want to avoid special-casing it in code that deals with per-CPU
>    9830		 * kthreads.
>    9831		 */
>    9832		WARN_ON(!set_kthread_struct(current));
>    9833	
>    9834		/*
>    9835		 * Make us the idle thread. Technically, schedule() should not be
>    9836		 * called from this thread, however somewhere below it might be,
>    9837		 * but because we are the idle thread, we just pick up running again
>    9838		 * when this runqueue becomes "idle".
>    9839		 */
>    9840		init_idle(current, smp_processor_id());
>    9841	
>    9842		calc_load_update = jiffies + LOAD_FREQ;
>    9843	
>

