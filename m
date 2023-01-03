Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D9465BB59
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbjACHpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjACHpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:45:15 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AD1C77D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 23:44:52 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n4so31811138plp.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 23:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhS59s2xVmfyWDuL4sjmZtVxjE4zWOLc4hNUVVYN3G0=;
        b=URVxXuoi3wdk9I4+Q9hYRGl9nS57doHPApyHsrz+aIHn3zCO9zuSy0YT7PeUB5zp3u
         qUtkXrnFQx1Uv6ncPTLEDdOmcdZo18t+F4V8qfStWaYeAZSiuz50j1U+0J4rl9YgeHgE
         5KnwZuNay6V/gkGtxzRNDWF+nxXlx6hamKE0w+KKC1kfwgPvWfgi5lL49k1jbbqE0acS
         XTG2XGZDpmDUBovhNGVOJp3J+cx5l37Ki9umy2Fcn8omvjxBhWkgKNl6isMo/4R4E0qp
         vivP/C5OmsozVAQ93Wn9S7vVDAyLH8/1pFMz8lL+f0QNo2Rlo64XMXxg2AY8PSHGsvbx
         2Jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZhS59s2xVmfyWDuL4sjmZtVxjE4zWOLc4hNUVVYN3G0=;
        b=NyfKyrdPGtnHLCTrt4K6nADIH53DAGQKaX4ag48S0lf05VLm+Heb3BOESj1FNEXwaJ
         sPrR1NWlD58hpTB3cPerDk2eJT5NydtI0LK0SsITEDdIPF7iAmNogjsxIr2vh5e/NQgd
         Nj2Ml5yucct1PXNQdMvMSBtqJ0Dbq5TO6Zl3/5fRG1pggbhYERje3X+9hfjej1+n7QHo
         3Sh2h5c72b/qDI8VUPKzA+0tGeYm6HibNXuGpAa2YS0Dc1qQu6Px5B0+wNj6+b1LRRmT
         /7SDcKOhh96NNxORFC1pl/x3qnBKPzhzsCX0kWiM/kBUs21sHBaop58Kla8nXbNJBV6O
         GGjg==
X-Gm-Message-State: AFqh2kpXxdwIDeXtTtGiRaiwQciFC/c0E+W+5cjUgD5+2D3AMxHjUEgu
        5jMTmBaxNq9ilcG1yXl5NfCiQQ==
X-Google-Smtp-Source: AMrXdXswKtWvKfNXCsgQVR4+A3uXuB36y1qN+wJlaUJhwpHfaBj2xZnDKdfNnnp8zbox6vBzzz0Eyg==
X-Received: by 2002:a05:6a20:d398:b0:ac:1265:d5bb with SMTP id iq24-20020a056a20d39800b000ac1265d5bbmr55751366pzb.49.1672731891897;
        Mon, 02 Jan 2023 23:44:51 -0800 (PST)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id g11-20020aa79dcb000000b00581f76c1da1sm7261837pfq.191.2023.01.02.23.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 23:44:51 -0800 (PST)
Message-ID: <5a378862-874b-a210-8092-e4b45aabea2f@bytedance.com>
Date:   Tue, 3 Jan 2023 15:44:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] sched/core: Avoid WARN_DOUBLE_CLOCK warning when
 CONFIG_SCHED_CORE
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org
References: <20221206070550.31763-1-jiahao.os@bytedance.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20221206070550.31763-1-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping...

On 2022/12/6 Hao Jia wrote:
> When we need to call update_rq_clock() to update the rq clock of
> other CPUs on the same core, before that we need to clear RQCF_UPDATED
> of rq->clock_update_flags to avoid the WARN_DOUBLE_CLOCK warning.
> Because at this time the rq->clock_update_flags of other CPUs
> may be RQCF_UPDATED.
> 
> Some call trace reports:
> Call Trace 1:
> <TASK>
> __schedule+0x61c/0x11d0
> schedule+0x5d/0xd0
> worker_thread+0xb5/0x380
> ? preempt_count_add+0x56/0xa0
> ? rescuer_thread+0x310/0x310
> kthread+0xe6/0x110
> ? kthread_complete_and_exit+0x20/0x20
> ret_from_fork+0x1f/0x30
> </TASK>
> 
> Call Trace 2:
> <TASK>
> __schedule+0x91d/0x11d0
> schedule+0x5d/0xd0
> exit_to_user_mode_prepare+0xe5/0x1e0
> syscall_exit_to_user_mode+0x17/0x30
> do_syscall_64+0x40/0x90
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Call Trace 3:
> <IRQ>
> __sched_core_tick+0x27/0x40
> scheduler_tick+0x1be/0x270
> ? tick_sched_handle.isra.18+0x60/0x60
> update_process_times+0x6a/0x90
> tick_sched_handle.isra.18+0x1f/0x60
> tick_sched_timer+0x47/0x80
> __hrtimer_run_queues+0x10a/0x280
> hrtimer_interrupt+0x10b/0x240
> __sysvec_apic_timer_interrupt+0x70/0x160
> sysvec_apic_timer_interrupt+0x9a/0xd0
> </IRQ>
> <TASK>
> asm_sysvec_apic_timer_interrupt+0x16/0x20
> 
> Steps to reproduce:
> 1. Enable CONFIG_SCHED_DEBUG and CONFIG_SCHED_CORE when compiling
>     the kernel
> 2. echo 1 > /sys/kernel/debug/clear_warn_once
>     echo "WARN_DOUBLE_CLOCK" > /sys/kernel/debug/sched/features
> 3. Run the linux/tools/testing/selftests/sched/cs_prctl_test test
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> ---
>   kernel/sched/core.c       |  5 ++++-
>   kernel/sched/core_sched.c |  4 +++-
>   kernel/sched/sched.h      | 10 +++++++++-
>   3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index daff72f00385..fcf5e4faec34 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5951,6 +5951,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   	rq->core->core_cookie = 0UL;
>   	if (rq->core->core_forceidle_count) {
>   		if (!core_clock_updated) {
> +			rq_clock_clear_update(rq->core);
>   			update_rq_clock(rq->core);
>   			core_clock_updated = true;
>   		}
> @@ -6007,8 +6008,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   		 * pick_next_task(). If the current cpu is not the core,
>   		 * the core may also have been updated above.
>   		 */
> -		if (i != cpu && (rq_i != rq->core || !core_clock_updated))
> +		if (i != cpu && (rq_i != rq->core || !core_clock_updated)) {
> +			rq_clock_clear_update(rq_i);
>   			update_rq_clock(rq_i);
> +		}
>   
>   		p = rq_i->core_pick = pick_task(rq_i);
>   		if (!max || prio_less(max, p, fi_before))
> diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
> index a57fd8f27498..70a6f36fd830 100644
> --- a/kernel/sched/core_sched.c
> +++ b/kernel/sched/core_sched.c
> @@ -291,8 +291,10 @@ void __sched_core_tick(struct rq *rq)
>   	if (!rq->core->core_forceidle_count)
>   		return;
>   
> -	if (rq != rq->core)
> +	if (rq != rq->core) {
> +		rq_clock_clear_update(rq->core);
>   		update_rq_clock(rq->core);
> +	}
>   
>   	__sched_core_account_forceidle(rq);
>   }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a4a20046e586..1a2c40c413c2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2544,8 +2544,16 @@ static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2)
>   	rq2->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
>   #endif
>   }
> -#else
> +
> +#ifdef CONFIG_SCHED_CORE
> +static inline void rq_clock_clear_update(struct rq *rq)
> +{
> +	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
> +}
> +#endif
> +#else /* CONFIG_SCHED_DEBUG */
>   static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2) {}
> +static inline void rq_clock_clear_update(struct rq *rq) {}
>   #endif
>   
>   #ifdef CONFIG_SMP
