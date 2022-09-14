Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CC05B8227
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiINHnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiINHn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:43:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815DF72B5D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:43:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id go6so9512718pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kb9NCtuiiU9JgtTr2R45rZbehKEFDNELHmoF3PvfRXs=;
        b=kyyVhOBG4AGUNJ+iIMiG4CdJNk2V+QRh/XuRX2DA+F0/MQRnYCH3LnAypamgH3te0m
         sMeTQAvKg1Oqqn/HaY8Gs4hRbiRUf11M/2Bfz9rf1k+LtXFhy3gxF4KQkN5ioQB17Dhn
         qX5V9yar3KOyTb7Eb2XkmYZcIkTQGLXMQQp8MALkdFjUy20auyLQE6cOG4WDExFtRxHp
         hHTjUGbBHDFNw5Qtr1fyz128yiicLNiU+7hAKPj4t37aq59nSFFG1cypckbTo0leg/a3
         0VrWlHY/b0BL9Xr5xONGGuTB8TyDJ9vP6cNHzjIUF3xHyHk1rOzMpH/DtNkKd++f4h1w
         RRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kb9NCtuiiU9JgtTr2R45rZbehKEFDNELHmoF3PvfRXs=;
        b=qO6Cvbcjrwn7qiQO7Y2ykcOyx5VjIIwpals35p9X99aTpGMacSmCODheZhH2mk4xzM
         Jl+PxVwzWIqIPLuRGSGV2KjjYddHHTCpGFV6jRT+SfRn/3Vu2I43p48qg64iYLugCGXZ
         KxrGx9gSQpcSQgJgjayaw2erc8oxAj4QFxNfKINh1Kv1mYITKmqoke8EWSXaT8k2P1Uh
         MFbb+qodqaOq0maDsVnfrDlKnZUwAL6YyLiJdcNXuvX6P2lu3+LIm+YD7Zx+DK+xAT6n
         Af6vYezYxYIdfzY5CSjQhRdAD09zn+b1hDOj3UZGO5CdRim/liA6hlxyy+XlE/cwZCnk
         SSuQ==
X-Gm-Message-State: ACgBeo3HlscIFC7ZtzrXyh00eaXM99TcKFu/CTr1PZc74ygLChEBac/c
        PO9JOA9szethTXQVCDBaO/SfQA==
X-Google-Smtp-Source: AA6agR7+re/0M7goNCjmPk/yIFXElQVT3A7DMQes/MzLlj3lWwMhY6n4/4ddNkWUUDZQOJBBSyl8Kg==
X-Received: by 2002:a17:90b:17c7:b0:202:95a2:e30f with SMTP id me7-20020a17090b17c700b0020295a2e30fmr3300343pjb.28.1663141405636;
        Wed, 14 Sep 2022 00:43:25 -0700 (PDT)
Received: from [10.255.31.50] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902aa9700b00174849e6914sm9868273plr.191.2022.09.14.00.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 00:43:25 -0700 (PDT)
Message-ID: <44c33c53-2720-7bdf-2b64-77774e2b4fd9@bytedance.com>
Date:   Wed, 14 Sep 2022 15:43:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v5 4/5] sched/fair: Skip SIS domain scan if fully busy
To:     Yicong Yang <yangyicong@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     yangyicong@hisilicon.com, Josh Don <joshdon@google.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
 <20220909055304.25171-5-wuyun.abel@bytedance.com>
 <1603a7f0-7587-ad29-b7a4-dfce290449fd@huawei.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <1603a7f0-7587-ad29-b7a4-dfce290449fd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/22 2:21 PM, Yicong Yang wrote:
> On 2022/9/9 13:53, Abel Wu wrote:
>> If a full domain scan failed, then no unoccupied cpus available
>> and the LLC is fully busy.  In this case we'd better use cpus
>> more wisely, rather than wasting it trying to find an idle cpu
>> that probably not exist. The fully busy status will be cleared
>> when any cpu of that LLC goes idle and everything goes back to
>> normal again.
>>
>> Make the has_idle_cores boolean hint more rich by turning it
>> into a state machine.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   include/linux/sched/topology.h | 35 +++++++++++++++++-
>>   kernel/sched/fair.c            | 67 ++++++++++++++++++++++++++++------
>>   2 files changed, 89 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>> index 816df6cc444e..cc6089765b64 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -77,10 +77,43 @@ extern int sched_domain_level_max;
>>   
>>   struct sched_group;
>>   
>> +/*
>> + * States of the sched-domain
>> + *
>> + * - sd_has_icores
>> + *	This state is only used in LLC domains to indicate worthy
>> + *	of a full scan in SIS due to idle cores available.
>> + *
>> + * - sd_has_icpus
>> + *	This state indicates that unoccupied (sched-idle/idle) cpus
>> + *	might exist in this domain. For the LLC domains it is the
>> + *	default state since these cpus are the main targets of SIS
>> + *	search, and is also used as a fallback state of the other
>> + *	states.
>> + *
>> + * - sd_is_busy
>> + *	This state indicates there are no unoccupied cpus in this
>> + *	domain. So for LLC domains, it gives the hint on whether
>> + *	we should put efforts on the SIS search or not.
>> + *
>> + * For LLC domains, sd_has_icores is set when the last non-idle cpu of
>> + * a core becomes idle. After a full SIS scan and if no idle cores found,
>> + * sd_has_icores must be cleared and the state will be set to sd_has_icpus
>> + * or sd_is_busy depending on whether there is any idle cpu. And during
>> + * load balancing on each SMT domain inside the LLC, the state will be
>> + * re-evaluated and switch from sd_is_busy to sd_has_icpus if idle cpus
>> + * exist.
>> + */
>> +enum sd_state {
>> +	sd_has_icores,
>> +	sd_has_icpus,
>> +	sd_is_busy
>> +};
>> +
>>   struct sched_domain_shared {
>>   	atomic_t	ref;
>>   	atomic_t	nr_busy_cpus;
>> -	int		has_idle_cores;
>> +	enum sd_state	state;
>>   	int		nr_idle_scan;
>>   };
>>   
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index fad289530e07..25df73c7e73c 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6262,26 +6262,47 @@ static inline int __select_idle_cpu(int cpu, struct task_struct *p)
>>   DEFINE_STATIC_KEY_FALSE(sched_smt_present);
>>   EXPORT_SYMBOL_GPL(sched_smt_present);
>>   
>> -static inline void set_idle_cores(int cpu, int val)
>> +static inline void set_llc_state(int cpu, enum sd_state state)
>>   {
>>   	struct sched_domain_shared *sds;
>>   
>>   	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>>   	if (sds)
>> -		WRITE_ONCE(sds->has_idle_cores, val);
>> +		WRITE_ONCE(sds->state, state);
>>   }
>>   
>> -static inline bool test_idle_cores(int cpu, bool def)
>> +static inline enum sd_state get_llc_state(int cpu, enum sd_state def)
>>   {
>>   	struct sched_domain_shared *sds;
>>   
>>   	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>>   	if (sds)
>> -		return READ_ONCE(sds->has_idle_cores);
>> +		return READ_ONCE(sds->state);
>>   
>>   	return def;
>>   }
>>   
>> +static inline void clear_idle_cpus(int cpu)
>> +{
>> +	set_llc_state(cpu, sd_is_busy);
>> +}
>> +
>> +static inline bool test_idle_cpus(int cpu)
>> +{
>> +	return get_llc_state(cpu, sd_has_icpus) != sd_is_busy;
>> +}
>> +
>> +static inline void set_idle_cores(int cpu, int core_idle)
>> +{
>> +	set_llc_state(cpu, core_idle ? sd_has_icores : sd_has_icpus);
>> +}
>> +
>> +static inline bool test_idle_cores(int cpu, bool def)
>> +{
>> +	return sd_has_icores ==
>> +	       get_llc_state(cpu, def ? sd_has_icores : sd_has_icpus);
>> +}
>> +
>>   /*
>>    * Scans the local SMT mask to see if the entire core is idle, and records this
>>    * information in sd_llc_shared->has_idle_cores.
>> @@ -6291,25 +6312,29 @@ static inline bool test_idle_cores(int cpu, bool def)
>>    */
>>   void __update_idle_core(struct rq *rq)
>>   {
>> -	int core = cpu_of(rq);
>> -	int cpu;
>> +	enum sd_state old, new = sd_has_icores;
>> +	int core = cpu_of(rq), cpu;
>>   
>>   	if (rq->ttwu_pending)
>>   		return;
>>   
>>   	rcu_read_lock();
>> -	if (test_idle_cores(core, true))
>> +	old = get_llc_state(core, sd_has_icores);
>> +	if (old == sd_has_icores)
>>   		goto unlock;
>>   
>>   	for_each_cpu(cpu, cpu_smt_mask(core)) {
>>   		if (cpu == core)
>>   			continue;
>>   
>> -		if (!available_idle_cpu(cpu))
>> -			goto unlock;
>> +		if (!available_idle_cpu(cpu)) {
>> +			new = sd_has_icpus;
>> +			break;
>> +		}
>>   	}
>>   
>> -	set_idle_cores(core, 1);
>> +	if (old != new)
>> +		set_llc_state(core, new);
>>   unlock:
>>   	rcu_read_unlock();
>>   }
> 
> We'll reach this function only when SMT is active (sched_smt_present == True)...
> 
>> @@ -6370,6 +6395,15 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>>   
>>   #else /* CONFIG_SCHED_SMT */
>>   
>> +static inline void clear_idle_cpus(int cpu)
>> +{
>> +}
>> +
>> +static inline bool test_idle_cpus(int cpu)
>> +{
>> +	return true;
>> +}
>> +
>>   static inline void set_idle_cores(int cpu, int val)
>>   {
>>   }
>> @@ -6406,6 +6440,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>   	struct sched_domain *this_sd;
>>   	u64 time = 0;
>>   
>> +	if (!test_idle_cpus(target))
>> +		return -1;
>> +
> 
> ...and on a non-SMT machine, we'll always fail here after the first time we clear_idle_cpus() below.
> since we have no place to make sds->state to sd_has_icpus again. You may need to make sds->state
> update in set_next_task_idle() also when smt is inactive.

Nice catch! The last 2 patches are now under reworking.

With filter enabled, this can lead to undesired result even in SMT case.
It's OK to mark the LLC busy if a full scan fails to find any idle cpus,
but with filter applied, the semantic of 'full scan' changed that not
all cpus of the LLC will be scanned, but just the cpus presented in the
filter are scanned.

As filter updated at core granule (a newly idle cpu could skip being set
to the filter if its SMT sibling has already been set), there might be
idle cpus that don't show up in the filter. So even a full scan on the
filter fails, it doesn't mean the LLC is fully busy, and idle cpus may
indeed exist. Since the busy state is cleared when cpus go idle, this
can hurt performance especially when LLC is under light pressure.

Thanks & BR,
Abel

> 
>>   	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>>   	if (!this_sd)
>>   		return -1;
>> @@ -6482,8 +6519,14 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>   		}
>>   	}
>>   
>> -	if (has_idle_core)
>> -		set_idle_cores(target, false);
>> +	/*
>> +	 * If no idle cpu can be found, set LLC state to busy to prevent
>> +	 * us from SIS domain scan to save a few cycles.
>> +	 */
>> +	if (idle_cpu == -1)
>> +		clear_idle_cpus(target);
>> +	else if (has_idle_core)
>> +		set_idle_cores(target, 0);
>>   
>>   	if (sched_feat(SIS_PROP) && !has_idle_core) {
>>   		time = cpu_clock(this) - time;
>>
