Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40926620E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiKHLSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiKHLSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:18:08 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FBE186C6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:18:06 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h14so13482124pjv.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPoeoFT2lwYFF2LMv6ruJ2n9LtLpT4pVzt3HFjnipag=;
        b=CJnCdtLnpQgs4bYhpXANiROL7dShzVvqQ80r6NXYlRQ1Eb8S0EVPRMSzpQ+BsrDBff
         OePYi3eNzpDwhjiatqsUipRCQWSl9l8l+H9elxKFWVrDCdCwDThZjrDQTLDvbNopeC1h
         BuYVsH8iXHgE/4h+Xu0bk7HmMZifYqObefLsOnHPcvqSFtqCk67WY/0vnDkqoEG5bLqQ
         MiNxYitwV2nMLj11yttMzs3YA24JukGh+fwl7UZMm0ybMCJzAQMkwUDxARXZqRo8m6iX
         xe4kp1pABxcyuE5OzYW1vUa2/ZkrkISv612qRlHdE51Q19uIl+RSNoylXm+A/CBsIDvh
         uT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPoeoFT2lwYFF2LMv6ruJ2n9LtLpT4pVzt3HFjnipag=;
        b=dswHhYuqq00FO6UjP/UoyBVeMk46tgpy4bS45xuzgPdxsuG5jH8n7CM/wqJbQU2bvg
         xxMEaFDwQBkXKo5yAy50wJHb3F632Dw7GCqY1FegG3YgUynLY5/BB8c5ruFgVboN1pM3
         DGrkyGnyTE2vd5+sSvmeFJRwO7rQyLxkgj0cW4w+NqtKcS2BK1KJ7MnlTVeep2tt4an8
         ohvAGNHaZ/QhLuNUVCKIOTWl/jDSs+Ecq8dU1xu7Hn5kSko1hFqihoFBXgB+Sts5zvOX
         kat/K4CsBZnZmB35wL3dL1ayxWY5dhRFZy14Kb+vYeNu2DTYDpQ1nOmogGaIHjGulN6B
         lhwQ==
X-Gm-Message-State: ACrzQf0CkgNSC8qiLLqgabpZQyYFYimm8e8v8lYbm0tJALpmyAHjlAam
        lgRTurHP4ZO9II1mOM8kSHWXQg==
X-Google-Smtp-Source: AMsMyM54c/p5fqJ2aF2Nm6wYMKNhRq1z+FC+5jUGKhPsYCkaiX8BAMZDlQWEZUmVBu5DmsC5ogKsDg==
X-Received: by 2002:a17:90a:2cc7:b0:212:f074:cf4d with SMTP id n65-20020a17090a2cc700b00212f074cf4dmr57519846pjd.70.1667906286059;
        Tue, 08 Nov 2022 03:18:06 -0800 (PST)
Received: from [10.4.173.156] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id lb4-20020a17090b4a4400b0020aaa678098sm5882595pjb.49.2022.11.08.03.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 03:18:05 -0800 (PST)
Message-ID: <8ad4a5d5-e24b-19ba-290d-0ec964d92fd9@bytedance.com>
Date:   Tue, 8 Nov 2022 19:17:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] sched/core: Minor optimize ttwu_runnable()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
References: <20221102102343.57845-1-zhouchengming@bytedance.com>
 <xhsmhr0yivazl.mognet@vschneid.remote.csb>
 <7b8bd69a-39cb-a1f0-6ccd-7b0810ef0db7@bytedance.com>
 <xhsmhwn86ncrs.mognet@vschneid.remote.csb>
 <346228d3-8b80-4e9b-0157-662429b11a05@bytedance.com>
 <xhsmhtu3an4jl.mognet@vschneid.remote.csb>
 <Y2odVSwrCSI2LW2m@hirez.programming.kicks-ass.net>
 <Y2oqo0u2/TPN3ozU@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Y2oqo0u2/TPN3ozU@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/8 18:08, Peter Zijlstra wrote:
> On Tue, Nov 08, 2022 at 10:11:49AM +0100, Peter Zijlstra wrote:
>> On Mon, Nov 07, 2022 at 03:54:38PM +0000, Valentin Schneider wrote:
>>
>>> So that's the part for the p->sched_class->task_woken() callback, which
>>> only affects RT and DL (and only does something when !p->on_cpu). I *think*
>>> it's fine to remove it from ttwu_runnable() as any push/pull should have
>>> happened when other tasks were enqueued on the same CPU - with that said,
>>> it wouldn't hurt to double check this :-)
>>>
>>>
>>> As for the check_preempt_curr(), since per the above p can be preempted,
>>> you could have scenarios right now with CFS tasks where
>>> ttwu_runnable()->check_preempt_curr() causes NEED_RESCHED to be set.
>>>
>>> e.g. p0 does
>>>
>>>   set_current_state(TASK_UNINTERRUPTIBLE)
>>>
>>> but then gets interrupted by the tick, a p1 gets selected to run instead
>>> because of check_preempt_tick(), and then runs long enough to have
>>> check_preempt_curr() decide to let p0 preempt p1.
>>>
>>> That does require specific timing (lower tick frequency should make this
>>> more likely) and probably task niceness distribution too, but isn't
>>> impossible.
>>>
>>> Maybe try reading p->on_cpu, and only do the quick task state update if
>>> it's still the current task, otherwise do the preemption checks?
>>
>> I'm confused...
> 
> I am and Valentin has a point. It could indeed be preempted and in that
> case check_preempt_curr() could indeed make it get back on.
> 
> In that case his suggestion might make sense; something along the lines
> of so I suppose...
> 
> (And I think we can still do the reorg I proposed elsewhere, but I've not
> yet tried.)

Ok, thanks for these suggestions.

I will try to do this, do some tests and send v2.

Thanks.

> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index cb2aa2b54c7a..6944d9473295 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3698,9 +3698,16 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  
>  	rq = __task_rq_lock(p, &rf);
>  	if (task_on_rq_queued(p)) {
> -		/* check_preempt_curr() may use rq clock */
> -		update_rq_clock(rq);
> -		ttwu_do_wakeup(rq, p, wake_flags, &rf);
> +		if (!p->on_cpu) {
> +			/*
> +			 * When on_rq && !on_cpu the task is preempted, see if
> +			 * it should preempt whatever is current there now.
> +			 */
> +			update_rq_clock(rq);
> +			check_preempt_curr(rq, p, wake_flags);
> +		}
> +		WRITE_ONCE(p->__state, TASK_RUNNING);
> +		trace_sched_wakeup(p);
>  		ret = 1;
>  	}
>  	__task_rq_unlock(rq, &rf);
