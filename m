Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F8D6421FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 04:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiLEDwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 22:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiLEDwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 22:52:09 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC8AFCFC
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 19:52:07 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 140so10152233pfz.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 19:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JI+2qXqVGqk/iFJ6nFg+/WAL+mznyegBuoKCOIo3lRY=;
        b=wfha/gD3Sg4PBn+AkDZnXBJQbSUAp9sl3y5IQG88PIqLdMwuDtnG9dy+nVRA+mHifC
         FJtV6bVsaIcJwHRzQj+wvUnKnST960Y7aHr6y9NpVymyUyKFPj/WNWjiHbX3tpYBlLI+
         tBg3TMYHF6lMb8crRi1cef9ww9lIp4839QUr7udiCWBWRXlicouKVR6qvmhY7Cyy/7Qq
         GRk+XS0VUztg/K6Wk9kbWDDL3N5oAVSsE1c0dRJ6Q4hwRbJA+kQdL0m30A7OleLAgQFN
         Wk84/PErg82/Ekcn/MlwHKSQfrETOwCdxx275XtBrHUWSIo+V8ZlRZ5nQPtGYRV+n8S+
         9gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JI+2qXqVGqk/iFJ6nFg+/WAL+mznyegBuoKCOIo3lRY=;
        b=MwfEP4QLOR3hTTCp1qzyIO5XFFinMzuMcw8IMhA4FdTAqYyIY5U+TXGmVzRW6jdXHm
         FyBdbb7z8kjRcSyZFia/MJuOWOHjb5Cpa0YQAjNf/lP1DdYg35xiTwdjW9i2RaPSfxLY
         5U7i7hFp6e1qwr3QIvRumRgYyo1s+4Iq1zhphdyudZDncAplNO6+9uUPY5S0bydXcNo8
         9Jnjwe5L027JNkvBnnqgmMvldvjg4BggQpFojsYa5/Iuci0X1hw0MDmCZS66WO1dqDNR
         Amqdo4qpRQtqLleNh6Px/nh3rAe0Oy7IYEbSTGXWTE15RXQ2yoE5vxTVWwBjEcmXkRxA
         nlmw==
X-Gm-Message-State: ANoB5plkSvYOom6NviyYq8DP4ZlkycPbn2JPxkBhSJ+2ZW64KhXMcgWu
        ov2UPHLxtU+yxY01t4sbHYW+Pw==
X-Google-Smtp-Source: AA0mqf4EqEkTiO38sSmgIu2incqQdvqSUG5WitspFRhOCCKh/cb89PjK4GjRJvWdgqcdiVkv9JSk+w==
X-Received: by 2002:a62:384e:0:b0:576:4dfb:1098 with SMTP id f75-20020a62384e000000b005764dfb1098mr14628353pfa.56.1670212327008;
        Sun, 04 Dec 2022 19:52:07 -0800 (PST)
Received: from [10.69.74.164] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id y187-20020a6264c4000000b0056ee49d6e95sm8714078pfb.86.2022.12.04.19.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 19:52:06 -0800 (PST)
Message-ID: <17c632a6-303e-2726-62ae-5c81577bc79a@bytedance.com>
Date:   Mon, 5 Dec 2022 11:52:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v4] sched/core: Minor optimize ttwu_runnable()
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vschneid@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com
References: <20221202080644.76999-1-zhouchengming@bytedance.com>
 <Y4sA5xDe+sBfQUnG@chenyu5-mobl1>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Y4sA5xDe+sBfQUnG@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/3 15:55, Chen Yu wrote:
> On 2022-12-02 at 16:06:44 +0800, Chengming Zhou wrote:
>> ttwu_runnable() is used as a fast wakeup path when the wakee task
>> is running on CPU or runnable on RQ, in both cases we can just
>> set its state to TASK_RUNNING to prevent a sleep.
>>
>> If the wakee task is on_cpu running, we don't need to update_rq_clock()
>> or check_preempt_curr().
>>
>> But if the wakee task is on_rq && !on_cpu (e.g. an IRQ hit before
>> the task got to schedule() and the task been preempted), we should
>> check_preempt_curr() to see if it can preempt the current running.
>>
>> Reorganize ttwu_do_wakeup() and ttwu_do_activate() to make
>> ttwu_do_wakeup() only mark the task runnable, so it can be used
>> in ttwu_runnable() and try_to_wake_up() fast paths.
>>
>> This also removes the class->task_woken() callback from ttwu_runnable(),
>> which wasn't required per the RT/DL implementations: any required push
>> operation would have been queued during class->set_next_task() when p
>> got preempted.
>>
>> ttwu_runnable() also loses the update to rq->idle_stamp, as by definition
>> the rq cannot be idle in this scenario.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> Suggested-by: Valentin Schneider <vschneid@redhat.com>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>> v4:
>>  - s/This patch reorg/Reorganize/ per Bagas Sanjaya. Thanks!
>>
>> v3:
>>  - Improve the changelog per Valentin Schneider. Thanks!
>>
>> v2:
>>  - keep check_preempt_curr() for on_rq && !on_cpu case in ttwu_runnable(),
>>    per Valentin Schneider.
>>  - reorg ttwu_do_wakeup() and ttwu_do_activate() code, so ttwu_do_wakeup()
>>    can be reused in ttwu_runnable(), per Peter Zijlstra.
>>  - reuse ttwu_do_wakeup() in try_to_wake_up() (p == current) fast path too,
>>    so ttwu_do_wakeup() become the only place we mark task runnable.
>> ---
>>  kernel/sched/core.c | 73 ++++++++++++++++++++++++---------------------
>>  1 file changed, 39 insertions(+), 34 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 314c2c0219d9..d8216485b0ad 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3623,14 +3623,39 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
>>  }
>>  
>>  /*
>> - * Mark the task runnable and perform wakeup-preemption.
>> + * Mark the task runnable.
>>   */
>> -static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
>> -			   struct rq_flags *rf)
>> +static inline void ttwu_do_wakeup(struct task_struct *p)
>>  {
>> -	check_preempt_curr(rq, p, wake_flags);
>>  	WRITE_ONCE(p->__state, TASK_RUNNING);
>>  	trace_sched_wakeup(p);
>> +}
>> +
>> +static void
>> +ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
>> +		 struct rq_flags *rf)
>> +{
>> +	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
>> +
>> +	lockdep_assert_rq_held(rq);
>> +
>> +	if (p->sched_contributes_to_load)
>> +		rq->nr_uninterruptible--;
>> +
>> +#ifdef CONFIG_SMP
>> +	if (wake_flags & WF_MIGRATED)
>> +		en_flags |= ENQUEUE_MIGRATED;
>> +	else
>> +#endif
>> +	if (p->in_iowait) {
>> +		delayacct_blkio_end(p);
>> +		atomic_dec(&task_rq(p)->nr_iowait);
>> +	}
>> +
>> +	activate_task(rq, p, en_flags);
>> +	check_preempt_curr(rq, p, wake_flags);
>> +
>> +	ttwu_do_wakeup(p);
>>  
>>  #ifdef CONFIG_SMP
>>  	if (p->sched_class->task_woken) {
>> @@ -3660,31 +3685,6 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
>>  #endif
>>  }
>>  
>> -static void
>> -ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
>> -		 struct rq_flags *rf)
>> -{
>> -	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
>> -
>> -	lockdep_assert_rq_held(rq);
>> -
>> -	if (p->sched_contributes_to_load)
>> -		rq->nr_uninterruptible--;
>> -
>> -#ifdef CONFIG_SMP
>> -	if (wake_flags & WF_MIGRATED)
>> -		en_flags |= ENQUEUE_MIGRATED;
>> -	else
>> -#endif
>> -	if (p->in_iowait) {
>> -		delayacct_blkio_end(p);
>> -		atomic_dec(&task_rq(p)->nr_iowait);
>> -	}
>> -
>> -	activate_task(rq, p, en_flags);
>> -	ttwu_do_wakeup(rq, p, wake_flags, rf);
>> -}
>> -
>>  /*
>>   * Consider @p being inside a wait loop:
>>   *
>> @@ -3718,9 +3718,15 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>>  
>>  	rq = __task_rq_lock(p, &rf);
>>  	if (task_on_rq_queued(p)) {
>> -		/* check_preempt_curr() may use rq clock */
>> -		update_rq_clock(rq);
>> -		ttwu_do_wakeup(rq, p, wake_flags, &rf);
>> +		if (!task_on_cpu(rq, p)) {
>> +			/*
>> +			 * When on_rq && !on_cpu the task is preempted, see if
>> +			 * it should preempt whatever is current there now.
>> +			 */
>> +			update_rq_clock(rq);
>> +			check_preempt_curr(rq, p, wake_flags);
>> +		}
>> +		ttwu_do_wakeup(p);
>>  		ret = 1;
>>  	}
>>  	__task_rq_unlock(rq, &rf);
>> @@ -4086,8 +4092,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>>  			goto out;
>>  
>>  		trace_sched_waking(p);
>> -		WRITE_ONCE(p->__state, TASK_RUNNING);
>> -		trace_sched_wakeup(p);
>> +		ttwu_do_wakeup(p);
>>  		goto out;
>>  	}
>>
> Just wonder if we could split the reorganization and optimization into two patches,
> so we can track the code change a little easier in the future?

Thanks for your suggestion.

I'll try to split into two patches later and resend.

Thanks.

> 
> thanks,
> Chenyu
