Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A037620A66
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiKHHkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiKHHkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:40:01 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E4D32074
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:39:03 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o13so3388095pgu.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 23:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FP00tYsmqV4MRmTZiGftq4VOBOi/plWQvPjlynhcuTY=;
        b=6JJjym9ISGzOJ+6/BC5su87grJy4L4bTuKh/gYL8tR3M7BgY0GofOuCXgfMzxoqBGJ
         i7S4JdKlwpBzkw0aPSy+y1ASxykMRjttKIwjy1FJwwMOKTx9iIiG5+BiXC9HaqGnsXwl
         /MMGwlwuHA107hZpBNr7Gt4ruzNiqmELzonnD6cIHXZptGvhcTHEmdAjMiP+NhGiqydo
         0nEmTjWWencbkoVOKLb3FmSHErFK/MCW/HzD6Focp299lUWv+qohUsJ8NHeb5kKz6FOA
         4Y3tHrDrpupZHM6jj8sVUHhV3JfSvcT4oVTP9TuQiZAHDT+0xuXbwUkYiOAVhEZOo7Rd
         COlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FP00tYsmqV4MRmTZiGftq4VOBOi/plWQvPjlynhcuTY=;
        b=Qz1ZHdzTz6rcGXb/1wif1nojLzY7U+NclnEHwh2tT2nrFDxgu7qxKgO1yZbf9X5nrd
         RLaViXVAER7azhFjCDIacIDiQHJ/Ykxe6qNbNd+gHSMqU8ib9Lp8+9tJEXsV4Fxk66Zt
         ZLZ/H8LCimvX7J60n/QKUPSlvdrHHw834msVHAM5QlmhpKijIk0Y2JP2LBAQ9hMe+JuF
         JwpBzsI6PWPwAd13vAHBxi6iK7j03a1j+PkTWHkjl9I/UVzk+dN4iNhoIbN2WEZdliOW
         LZl8LvKhN5oy+FuffZ2vx4pXUi0EdLejPU9p3F/Au2xhy6faszblEEbK/X2CTE00HAbV
         u/SA==
X-Gm-Message-State: ACrzQf0D4UKmbV6WMmLDSUduhf+TDpACUKChN6raVi3m7PPcIIYcQkE3
        1LBJqg3OR8pHHZ7162j5BERjCw==
X-Google-Smtp-Source: AMsMyM57YEebjCEDINvDkR3iHrW+66NYS1SXgDZ6g/jmcSBUi/hHa3sLl+I738oXurt2HxnOtNPJDA==
X-Received: by 2002:a65:5a8b:0:b0:470:2ecd:ea02 with SMTP id c11-20020a655a8b000000b004702ecdea02mr21390399pgt.83.1667893143462;
        Mon, 07 Nov 2022 23:39:03 -0800 (PST)
Received: from [10.4.173.156] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709026b4700b00177c488fea5sm6199417plt.12.2022.11.07.23.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 23:39:03 -0800 (PST)
Message-ID: <265cad31-5c53-66dc-07e7-82bbbdb2a144@bytedance.com>
Date:   Tue, 8 Nov 2022 15:38:54 +0800
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
 <346228d3-8b80-4e9b-0157-662429b11a05@bytedance.com>
 <xhsmhtu3an4jl.mognet@vschneid.remote.csb>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <xhsmhtu3an4jl.mognet@vschneid.remote.csb>
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

On 2022/11/7 23:54, Valentin Schneider wrote:
> On 07/11/22 21:19, Chengming Zhou wrote:
>> On 2022/11/7 20:56, Valentin Schneider wrote:
>>>
>>> So p is still on the rq for sure, but it may not be the currently running
>>> task. Consider, on a CONFIG_PREEMPT kernel, task p0 in a wait loop:
>>>
>>> 0    for (;;) {
>>> 1       set_current_state(TASK_UNINTERRUPTIBLE);
>>> 2
>>> 3       if (CONDITION)
>>> 4          break;
>>> 5
>>> 6       schedule();
>>> 7    }
>>> 8    __set_current_state(TASK_RUNNING);
>>>
>>> Now further consider p0 executes line 1, but then gets interrupted by an
>>> IRQ, at the end of which preempt_schedule_irq() happens. We enter
>>> __schedule(SM_PREEMPT), so p0 isn't dequeued due to its non-zero task
>>> state, but we *can* end up switching the CPU's current task.
>>
>> Thank you very much for this detailed explanation, I get it. Yes, this
>> process can be seen on CONFIG_PREEMPT kernel.
>>
>>>
>>> ISTR that's why Peter renamed that function ttwu_*runnable*() and not
>>> ttwu_*running*().
>>
>> So this task p didn't really sleep, it's preempted, later scheduled in,
>> get to execute line 6 schedule(), but its state has been set to TASK_RUNNING,
>> it won't deactivate_task(p).
>>
> 
> Right!
> 
>> Looks like this patch is still reasonable? Should I put this detailed
>> explanation in the changelog and send v2?
>>
> 
> So that's the part for the p->sched_class->task_woken() callback, which
> only affects RT and DL (and only does something when !p->on_cpu). I *think*
> it's fine to remove it from ttwu_runnable() as any push/pull should have
> happened when other tasks were enqueued on the same CPU - with that said,
> it wouldn't hurt to double check this :-)

Yes, ttwu_runnable() should be fine to remove p->sched_class->task_woken().

> 
> 
> As for the check_preempt_curr(), since per the above p can be preempted,
> you could have scenarios right now with CFS tasks where
> ttwu_runnable()->check_preempt_curr() causes NEED_RESCHED to be set.
> 
> e.g. p0 does
> 
>   set_current_state(TASK_UNINTERRUPTIBLE)
> 
> but then gets interrupted by the tick, a p1 gets selected to run instead
> because of check_preempt_tick(), and then runs long enough to have
> check_preempt_curr() decide to let p0 preempt p1.
> 
> That does require specific timing (lower tick frequency should make this
> more likely) and probably task niceness distribution too, but isn't
> impossible.
> 
> Maybe try reading p->on_cpu, and only do the quick task state update if
> it's still the current task, otherwise do the preemption checks?

I think it's a good suggestion, so we still have the preemption check when
p0 is preempted by p1, letting p0 to be scheduled in more timely.

I will update and send v2 later.

> 
>> Thanks!
>>
> 
