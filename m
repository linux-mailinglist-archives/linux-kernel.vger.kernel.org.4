Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5796400FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiLBHTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLBHTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:19:44 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E921EB71F6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 23:19:42 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 21so4147443pfw.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 23:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CHle2lwwiPNFeAAHApe4ssSL1bu5obCe6/yxwzacIyc=;
        b=pVMUrmnI0xpMqBqtvyR+Am7/0vNWz8ddRpmP8NKmLiC05fmcAqPSAUdQVCtG6bVNjn
         nb8grmdAi3/ih/lgqURIeLstBxRI2wPeQPPlQ7g8HuuO/MUlxdh4GPqx0caHb/5XMvOV
         9RumZZ6Mi0FRHEwVIfg/3a6CN3ewZ1o/9DuYG7a59mut0PoyWKeEh1Cp74kd8Mbg3g4U
         LoFdTnktmV+yZ4KhIPUlBmes/32I0pA+04fqly8RoFm3PmzQkTqNdUkkbe5JJ+qubdUr
         hn6X4VWk1mrGidQ1MFTivrwITBavDu7uXj1xdahkbQgVyfIKJbTJMRcID7vmLYZNM1yf
         rwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHle2lwwiPNFeAAHApe4ssSL1bu5obCe6/yxwzacIyc=;
        b=YvMJa7XUzIXEoui9dLVypO3gWde7wIf6C4Unxc/731fq6mwKoswp37vQYLuY/PNh5Q
         CnQUAH1F0d+yo1gnB6bafGMpLV/1g1EqpqiAHeG465rSoWmRMPu3wIzYl9N/c/ic86Gk
         5+Cyj9vRIgAbPz+WueC0nBAAOtoKWfmsgIh/FUoMnEFZOeeqeAN0JDnH3McQI+6q3Vy7
         7zjmfm6e+00yEq33kRFB9paj4lrEP3ZVZbaRMy8z/kK6TNBgGeEXl7LncVor7ygGm4CV
         f5ukJYZd/iJfr6M/Dd+XugQQBGs0blkbpP5xx/LEkfAoc4+CUuD3KoWVF1KIY/wDDp4+
         bXSQ==
X-Gm-Message-State: ANoB5pnY0ZSUewbZJ42x2X1NjlGELnKrexD7f30hYBv8vbe+NUOOmWS0
        roeA6HdFyU9C6BJzY/SHC9tDLOx2/cU6Blle
X-Google-Smtp-Source: AA0mqf46dGUAh/aUOTnYmsFAeJ+ax3Yz6BDWvvNrvsUWSgIYUvXnbLsp1Ot2mL4m5kwBGIp34rOWzA==
X-Received: by 2002:a62:1b0b:0:b0:56d:384:e13a with SMTP id b11-20020a621b0b000000b0056d0384e13amr50844264pfb.75.1669965582443;
        Thu, 01 Dec 2022 23:19:42 -0800 (PST)
Received: from [10.4.98.208] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id d13-20020aa797ad000000b00574a82bb877sm4367267pfq.203.2022.12.01.23.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 23:19:41 -0800 (PST)
Message-ID: <1241dbfb-9d67-9723-646f-b1301b16cd22@bytedance.com>
Date:   Fri, 2 Dec 2022 15:19:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3] sched/core: Minor optimize ttwu_runnable()
Content-Language: en-US
To:     peterz@infradead.org, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
References: <20221112033910.73273-1-zhouchengming@bytedance.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20221112033910.73273-1-zhouchengming@bytedance.com>
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

On 2022/11/12 11:39, Chengming Zhou wrote:
> ttwu_runnable() is used as a fast wakeup path when the wakee task
> is running on CPU or runnable on RQ, in both cases we can just
> set its state to TASK_RUNNING to prevent a sleep.
> 
> If the wakee task is on_cpu running, we don't need to update_rq_clock()
> or check_preempt_curr().
> 
> But if the wakee task is on_rq && !on_cpu (e.g. an IRQ hit before
> the task got to schedule() and the task been preempted), we should
> check_preempt_curr() to see if it can preempt the current running.
> 
> This patch reorg ttwu_do_wakeup() and ttwu_do_activate() to make
> ttwu_do_wakeup() only mark the task runnable, so it can be used
> in ttwu_runnable() and try_to_wake_up() fast paths.
> 
> This also removes the class->task_woken() callback from ttwu_runnable(),
> which wasn't required per the RT/DL implementations: any required push
> operation would have been queued during class->set_next_task() when p
> got preempted.
> 
> ttwu_runnable() also loses the update to rq->idle_stamp, as by definition
> the rq cannot be idle in this scenario.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Suggested-by: Valentin Schneider <vschneid@redhat.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Hello, ping...

Thanks.

> ---
> v3:
>  - Improve the changelog per Valentin Schneider. Thanks!
> 
> v2:
>  - keep check_preempt_curr() for on_rq && !on_cpu case in ttwu_runnable(),
>    per Valentin Schneider.
>  - reorg ttwu_do_wakeup() and ttwu_do_activate() code, so ttwu_do_wakeup()
>    can be reused in ttwu_runnable(), per Peter Zijlstra.
>  - reuse ttwu_do_wakeup() in try_to_wake_up() (p == current) fast path too,
>    so ttwu_do_wakeup() become the only place we mark task runnable.
> ---
>  kernel/sched/core.c | 73 ++++++++++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 34 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 15e167a1c5bd..78b5075191b4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3623,14 +3623,39 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
>  }
>  
>  /*
> - * Mark the task runnable and perform wakeup-preemption.
> + * Mark the task runnable.
>   */
> -static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
> -			   struct rq_flags *rf)
> +static inline void ttwu_do_wakeup(struct task_struct *p)
>  {
> -	check_preempt_curr(rq, p, wake_flags);
>  	WRITE_ONCE(p->__state, TASK_RUNNING);
>  	trace_sched_wakeup(p);
> +}
> +
> +static void
> +ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
> +		 struct rq_flags *rf)
> +{
> +	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (p->sched_contributes_to_load)
> +		rq->nr_uninterruptible--;
> +
> +#ifdef CONFIG_SMP
> +	if (wake_flags & WF_MIGRATED)
> +		en_flags |= ENQUEUE_MIGRATED;
> +	else
> +#endif
> +	if (p->in_iowait) {
> +		delayacct_blkio_end(p);
> +		atomic_dec(&task_rq(p)->nr_iowait);
> +	}
> +
> +	activate_task(rq, p, en_flags);
> +	check_preempt_curr(rq, p, wake_flags);
> +
> +	ttwu_do_wakeup(p);
>  
>  #ifdef CONFIG_SMP
>  	if (p->sched_class->task_woken) {
> @@ -3660,31 +3685,6 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
>  #endif
>  }
>  
> -static void
> -ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
> -		 struct rq_flags *rf)
> -{
> -	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
> -
> -	lockdep_assert_rq_held(rq);
> -
> -	if (p->sched_contributes_to_load)
> -		rq->nr_uninterruptible--;
> -
> -#ifdef CONFIG_SMP
> -	if (wake_flags & WF_MIGRATED)
> -		en_flags |= ENQUEUE_MIGRATED;
> -	else
> -#endif
> -	if (p->in_iowait) {
> -		delayacct_blkio_end(p);
> -		atomic_dec(&task_rq(p)->nr_iowait);
> -	}
> -
> -	activate_task(rq, p, en_flags);
> -	ttwu_do_wakeup(rq, p, wake_flags, rf);
> -}
> -
>  /*
>   * Consider @p being inside a wait loop:
>   *
> @@ -3718,9 +3718,15 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  
>  	rq = __task_rq_lock(p, &rf);
>  	if (task_on_rq_queued(p)) {
> -		/* check_preempt_curr() may use rq clock */
> -		update_rq_clock(rq);
> -		ttwu_do_wakeup(rq, p, wake_flags, &rf);
> +		if (!task_on_cpu(rq, p)) {
> +			/*
> +			 * When on_rq && !on_cpu the task is preempted, see if
> +			 * it should preempt whatever is current there now.
> +			 */
> +			update_rq_clock(rq);
> +			check_preempt_curr(rq, p, wake_flags);
> +		}
> +		ttwu_do_wakeup(p);
>  		ret = 1;
>  	}
>  	__task_rq_unlock(rq, &rf);
> @@ -4082,8 +4088,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  			goto out;
>  
>  		trace_sched_waking(p);
> -		WRITE_ONCE(p->__state, TASK_RUNNING);
> -		trace_sched_wakeup(p);
> +		ttwu_do_wakeup(p);
>  		goto out;
>  	}
>  
