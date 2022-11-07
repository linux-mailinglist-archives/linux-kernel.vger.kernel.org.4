Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2953F61F426
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiKGNT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiKGNTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:19:25 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650C81B789
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:19:24 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so9710296pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 05:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PR54rNc8ZGr3271Gmxzszw4Xt7u1CwAkybyLX7W7ERU=;
        b=B9ujHQCH3B6g6ju9R3wBlYMqGjpAfzgIQ3Nvx4MJS73dntU1UvVVi6v9EOkDaiBaLU
         R0SlOYF6/EVED0UbzHH4J1iNQmyqDCbEK44GbZg5DUsG/oILqrP3WT7AJ2Re33tE11g3
         XEweV2PxbRRETiIRa1qrDuAOSa0OZOxNaRl5AA7lcrNjtnlURpYl+PmupySghihw5RIk
         MP+mRMqxZ1pZr1nxS6gUq45QPmh11GzgYUKmJXXQBDuS3seU02wOgKnTIDM7hwcTg2EQ
         pbjPdWsXYwd8MJ7qdH8AJg8SLtdybcS8671d61pZcTmF0idpPx5Q/ZHHP9yqmmU9Vk4m
         F4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PR54rNc8ZGr3271Gmxzszw4Xt7u1CwAkybyLX7W7ERU=;
        b=RFRug3nSNqB/TZBvm61zFB6Lns13uLS14CGxZUAPX4t6OOxgeNoY2Zz3hG7RomBG0J
         WxguupY5z2QArBcetcTmZ/klrnTI23utSy9JqTzLe78/8Ugp4vRjznaAspC3+ggYq+p6
         MwR8aBMY0s2ZjZDdXRMdFskGhCOOUkn7+TiVRIet4NYrMWEEQZEB6p53REAgZjebC7Lz
         SO7gWNbaBlO1+tO82evaBtjcPDWwHSWT9GHjMYQrnzSGGVOujbxIV/YslEAZ0RwqCKo0
         hsp/QEhoKzSfxQlh6qgXBuObPz+1V1ikXdP5yFcTnJqaTqYEQS/Pyw+l6mGAnU9ULOKq
         MJRg==
X-Gm-Message-State: ACrzQf1N7n2IOopyJtCfaF2C/mC1qIPbW1EahX4pS2FNSpd8OIidEnZB
        MtABrTTPqEdeTh145e6vmXkAwg==
X-Google-Smtp-Source: AMsMyM740E7vkUVkL0thvi5ZHcsUk8LH18/zN7gRAjuNvRcU0zPtPQyGsYd17764Hl0cBhE7iqYmUg==
X-Received: by 2002:a17:90a:cb03:b0:214:219:b2b9 with SMTP id z3-20020a17090acb0300b002140219b2b9mr37802124pjt.191.1667827163882;
        Mon, 07 Nov 2022 05:19:23 -0800 (PST)
Received: from [10.254.17.120] ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b001865c298588sm4951281plh.258.2022.11.07.05.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 05:19:23 -0800 (PST)
Message-ID: <346228d3-8b80-4e9b-0157-662429b11a05@bytedance.com>
Date:   Mon, 7 Nov 2022 21:19:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] sched/core: Minor optimize ttwu_runnable()
Content-Language: en-US
To:     Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20221102102343.57845-1-zhouchengming@bytedance.com>
 <xhsmhr0yivazl.mognet@vschneid.remote.csb>
 <7b8bd69a-39cb-a1f0-6ccd-7b0810ef0db7@bytedance.com>
 <xhsmhwn86ncrs.mognet@vschneid.remote.csb>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <xhsmhwn86ncrs.mognet@vschneid.remote.csb>
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

On 2022/11/7 20:56, Valentin Schneider wrote:
> On 05/11/22 09:34, Chengming Zhou wrote:
>> On 2022/11/5 02:19, Valentin Schneider wrote:
>>> On 02/11/22 18:23, Chengming Zhou wrote:
>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>> index 87c9cdf37a26..3785418de127 100644
>>>> --- a/kernel/sched/core.c
>>>> +++ b/kernel/sched/core.c
>>>> @@ -3718,9 +3718,8 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>>>>
>>>>       rq = __task_rq_lock(p, &rf);
>>>>       if (task_on_rq_queued(p)) {
>>>> -		/* check_preempt_curr() may use rq clock */
>>>> -		update_rq_clock(rq);
>>>> -		ttwu_do_wakeup(rq, p, wake_flags, &rf);
>>>> +		WRITE_ONCE(p->__state, TASK_RUNNING);
>>>> +		trace_sched_wakeup(p);
>>>
>>> This also loses the class->task_woken() call, AFAICT we could have
>>> !p->on_cpu here (e.g. an IRQ hit before the task got to schedule()), but
>>> then again if there is a need to push we should have done that at the IRQ
>>> preempt via set_next_task_{rt, dl}()... So I'm starting to think this is
>>> OK, but that needs elaborating in the changelog.
>>
>> Sorry, I don't get why we could have !p->on_cpu here?
>>
>> I thought if we have task_on_rq_queued(p) here, it means p hasn't got to
>> __schedule() to deactivate_task(), so p should still be on_cpu?
>>
>> Thanks.
>>
> 
> So p is still on the rq for sure, but it may not be the currently running
> task. Consider, on a CONFIG_PREEMPT kernel, task p0 in a wait loop:
> 
> 0    for (;;) {
> 1       set_current_state(TASK_UNINTERRUPTIBLE);
> 2
> 3       if (CONDITION)
> 4          break;
> 5
> 6       schedule();
> 7    }
> 8    __set_current_state(TASK_RUNNING);
> 
> Now further consider p0 executes line 1, but then gets interrupted by an
> IRQ, at the end of which preempt_schedule_irq() happens. We enter
> __schedule(SM_PREEMPT), so p0 isn't dequeued due to its non-zero task
> state, but we *can* end up switching the CPU's current task.

Thank you very much for this detailed explanation, I get it. Yes, this
process can be seen on CONFIG_PREEMPT kernel.

> 
> ISTR that's why Peter renamed that function ttwu_*runnable*() and not
> ttwu_*running*().

So this task p didn't really sleep, it's preempted, later scheduled in,
get to execute line 6 schedule(), but its state has been set to TASK_RUNNING,
it won't deactivate_task(p).

Looks like this patch is still reasonable? Should I put this detailed
explanation in the changelog and send v2?

Thanks!

> 
>>>
>>>
>>>>               ret = 1;
>>>>       }
>>>>       __task_rq_unlock(rq, &rf);
>>>> --
>>>> 2.37.2
>>>
> 
