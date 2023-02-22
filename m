Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B987969F3B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjBVLxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjBVLxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:53:12 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FBF36FFB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:53:05 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id q5so8461371plh.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ5oSs7vVmiBBAuCnSpwQ2lJ5wi6NXTB3wmKRM+ff0E=;
        b=fCvoHdcUcGqna9ekgy8uVRp1UPAr1yVZmXwGInLUgjunhE2jx2+z2Ku/eF30b/uFwZ
         TLRcpFdQI1RActvYfs9dKwoYH+XFZL+Vx9PUAydm9EUm9J+AntFXuOnahkGjmGxQj+XT
         o9Y+m9bSrY6knYK+vhRFAywdTA+jb5lxQAwhl0VT+83XXqakFMmwkFyH4JBYI4PMJR4E
         o8sejJnXIMfCekaChkEucr6QHN1tK83lYGi3Brr/1prm9gZ2n2dSstUA5jCVPqlUmbSt
         mSXtifjA8WbTObQ2pNaFboDb5jWPjBjlc18jCkIKp0lY26cWFx+lev+8xm8YnAoEYkY6
         rK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EQ5oSs7vVmiBBAuCnSpwQ2lJ5wi6NXTB3wmKRM+ff0E=;
        b=J8eKXCBxxNyGHHGBIgbTgBpXE99pN9eg/MBg4dyOjLd29LdxuuhsNxZE5zbqAsM1NA
         1B9qIuwoa+Y9u1d1BXxrCSuX1DCvgmbehQHhuOR8n4dR4/TBvP8UfUsRqjfmyjJS1mAx
         bCY1bbAwTIcokCHs3wm86n2EJfkgLBSQcD3Jd3dtsNWrq2TLTPQSyjy7gEt1fK46fne1
         i3tDzaPuivtQ+mh4ZDDVEvhDw/m2WHkhCape+d+EeyBjfaPRovrrgyrcI6BOLiBvTEzb
         Vn5s01CzlJDuEVApBk/QKrSODVYhC8AlqTdgyW3zukcgFv3Oc6q1oTkMqz15GdRczDco
         OBvw==
X-Gm-Message-State: AO0yUKVKkZO4VgORu+yKprjtNxkyG5Xpkfe1lz994Ull5xmn5431WWTe
        /wOSdxFRXD/da5jr//k60ep5Vw==
X-Google-Smtp-Source: AK7set+Q93xY1RGP+c4GTB3LgY170ITind++yli2c+CBov4nntqbzdibOukImO6k88B8557sOlQ7Wg==
X-Received: by 2002:a17:90b:4c4a:b0:234:797a:7c5f with SMTP id np10-20020a17090b4c4a00b00234797a7c5fmr7935974pjb.33.1677066784858;
        Wed, 22 Feb 2023 03:53:04 -0800 (PST)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id g15-20020a17090a3c8f00b002347475e71fsm4843090pjc.14.2023.02.22.03.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 03:53:04 -0800 (PST)
Message-ID: <0239e6b0-4988-fad6-335b-c5331eb485d2@bytedance.com>
Date:   Wed, 22 Feb 2023 19:52:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [External] Re: [PATCH v2] sched/core: Adapt WARN_DOUBLE_CLOCK
 machinery for core-sched
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
References: <20230215073927.97802-1-jiahao.os@bytedance.com>
 <Y/Nrj4zdEPDxcc3+@hirez.programming.kicks-ass.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <Y/Nrj4zdEPDxcc3+@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/20 Peter Zijlstra wrote:
> On Wed, Feb 15, 2023 at 03:39:27PM +0800, Hao Jia wrote:
>> When sched_core_enabled(), we sometimes need to call update_rq_clock()
>> to update the rq clock of sibling CPUs on the same core, before that we
>> need to clear RQCF_UPDATED of rq->clock_update_flags to avoid the
>> WARN_DOUBLE_CLOCK warning. Because at this time the rq->clock_update_flags
>> of sibling CPUs may be RQCF_UPDATED. If sched_core_enabled(), we will get
>> a core wide rq->lock, so at this point we can safely clear RQCF_UPDATED of
>> rq->clock_update_flags of all CPUs on this core to avoid the
>> WARN_DOUBLE_CLOCK warning.
>>
>> We cannot clear rq->clock_update_flags of other cpus on the same core in
>> rq_pin_lock(). Because in some functions, we will temporarily give up
>> core wide rq->lock, and then use raw_spin_rq_lock() to obtain core wide
>> rq->lock, such as newidle_balance() and _double_lock_balance().
>>
>> Steps to reproduce:
>> 1. Enable CONFIG_SCHED_DEBUG and CONFIG_SCHED_CORE when compiling
>>     the kernel
>> 2. echo 1 > /sys/kernel/debug/clear_warn_once
>>     echo "WARN_DOUBLE_CLOCK" > /sys/kernel/debug/sched/features
>> 3. Run the linux/tools/testing/selftests/sched/cs_prctl_test test
>>
>> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
>> ---
>>   - Adapt WARN_DOUBLE_CLOCK machinery for core-sched instead of clearing
>>     WARN_DOUBLE_CLOCK warning one by one.
>>   - Modify commit information
>>   [v1] https://lore.kernel.org/all/20221206070550.31763-1-jiahao.os@bytedance.com
>>
>>   kernel/sched/core.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index e838feb6adc5..16a33e5adb77 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -427,11 +427,27 @@ void sched_core_put(void)
>>   		schedule_work(&_work);
>>   }
>>   
>> +static inline void sched_core_rq_clock_clear_update(struct rq *rq)
>> +{
>> +#ifdef CONFIG_SCHED_DEBUG
>> +	const struct cpumask *smt_mask;
>> +	int i;
>> +
>> +	if (rq->core_enabled) {
>> +		smt_mask = cpu_smt_mask(rq->cpu);
>> +		for_each_cpu(i, smt_mask) {
>> +			if (rq->cpu != i)
>> +				cpu_rq(i)->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
>> +		}
>> +	}
>> +#endif
> 
> So sort of ok, but that function name.... so long :/

What about clear_core_clock_updated()?
Indeed, a good function name is difficult.

Thanks,
Hao
> 
>> +}
>>   #else /* !CONFIG_SCHED_CORE */
>>   
>>   static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
>>   static inline void
>>   sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
>> +static inline void sched_core_rq_clock_clear_update(struct rq *rq) { }
>>   
>>   #endif /* CONFIG_SCHED_CORE */
>>   
>> @@ -546,6 +562,7 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
>>   		if (likely(lock == __rq_lockp(rq))) {
>>   			/* preempt_count *MUST* be > 1 */
>>   			preempt_enable_no_resched();
>> +			sched_core_rq_clock_clear_update(rq);
>>   			return;
>>   		}
>>   		raw_spin_unlock(lock);
> 
> This otoh don't make much sense. Why put it here and not extend
> rq_pin_lock()?
> 
> That is, what's wrong with something like so?

We sometimes use rq_pin_lock() and raw_spin_rq_lock() separately.
in some functions（）, we will temporarily give up
core wide rq->lock, and then use raw_spin_rq_lock() to obtain core wide
rq->lock, at this time the rq->clock_update_flags may be RQCF_UPDATED.
such as newidle_balance() and _double_lock_balance().


Perhaps it is more flexible to use rq_pin_lock() and raw_spin_rq_lock() 
separately? such as:

newidle_balance()
     rq_unpin_lock()
     raw_spin_rq_unlock()

     update_blocked_averages()
         update_rq_clock(rq)    <-- RQCF_UPDATED

     raw_spin_rq_lock(); （1）
     rq_repin_lock()           <-- we need *restore* to RQCF_UPDATED


We cannot replace raw_spin_rq_lock() in (1) with rq_lock(), because this 
will set rf->clock_update_flags to 0,
This may cause assert_clock_updated() to be triggered later.

Thinks,
Hao
> 
> ---
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 771f8ddb7053..c1a92eced930 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1571,11 +1571,18 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
>   	rf->cookie = lockdep_pin_lock(__rq_lockp(rq));
>   
>   #ifdef CONFIG_SCHED_DEBUG
> -	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
> -	rf->clock_update_flags = 0;
>   #ifdef CONFIG_SMP
>   	SCHED_WARN_ON(rq->balance_callback && rq->balance_callback != &balance_push_callback);
>   #endif
> +	rf->clock_update_flags = 0;
> +	if (sched_core_enabled()) {
> +		int i;
> +
> +		for_each_cpu(i, cpu_smt_mask(rq->cpu))
> +			cpu_rq(i)->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
> +	} else {
> +		rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
> +	}
>   #endif
>   }
>   
