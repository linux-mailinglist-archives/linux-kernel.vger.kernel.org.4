Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF57654EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiLWKIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWKIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:08:39 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1A618E10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:08:12 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f3so3050124pgc.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vsiiQtY7KUhLsu7tHulvoDHQIbC/xIC+4feb9aIDeEg=;
        b=lkNSnYBRTlrsKbyNti3fXQiuHh+aWeW+aWea7bV3Ik4J/xm1DLM7xcepU8VlchQ5Ew
         adqdf2uLZGrlPzxfRPBGW64naKH2/yioLbtMcWygZtO5XLQmlkfzhYC9pY+drP0OxNt2
         4sQWVUrw3YDUB4KOJF3256YrnCw2NMIZdye0BTGk46paswGGdeZg2rA71DLPlAgjNxOq
         R9VuNuZ3pil/x+BkvYn6wlW4J6mRuKq5EFe13ZeGlskdeNC6Jb3lNcASjFWNn5Jzf3BC
         T8yon+XUQ99si4h8L/yk1BdXTe/X3lodEKRusTjdWLABUp8EKJNZOtMhEkCvQq6xDyex
         45Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsiiQtY7KUhLsu7tHulvoDHQIbC/xIC+4feb9aIDeEg=;
        b=mVJpoNHOUtJbe7keRjmIcHW5rpUk7zTGuMan1nBNV6sjCLBGkkvNUP5Gim8WaDLZcV
         W8bqySyc3XZsnbFo1SBdKpVtFQSmmwOFt0fX5y2alD6nGg+c1YtNY3h1vsjqQnoUV5Me
         vQDS+oSpPDEHDkDj5Hc8744WzXI8Dh+Z+S0d3EmhvzIsZeu+PV6qGw8KcI8WraeN66FV
         2HYxlIO4PRwAuPmzGoljQtJiK5BSOjMXfue9LKcrCMwsHMtaTHLbZ4UjU14ILBMha3Q6
         ASomptzGmWw8I+8MV+kUWAg5WTgKJ/7Gcp0i/QX4y4SpCmsUuWEbj93NO+urbhCCKtl1
         NT2Q==
X-Gm-Message-State: AFqh2kpV5xOGtB//vl1713U2Gqfpa9PbhDVHrxnLVFCgb+EKVh3edmAJ
        oMPVctqXfJSYLQPD+Xb43s9cxw==
X-Google-Smtp-Source: AMrXdXulf22YtlRSSFRXVHWoW+nmU+DzjCs4ejoTVtDRtZuWxHWxxV6sQmSO69BCOrWov5kX7LqXwQ==
X-Received: by 2002:a62:648b:0:b0:57a:a199:93e7 with SMTP id y133-20020a62648b000000b0057aa19993e7mr10327722pfb.28.1671790092144;
        Fri, 23 Dec 2022 02:08:12 -0800 (PST)
Received: from [10.5.203.163] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id d7-20020aa797a7000000b0056b9df2a15esm2184332pfq.62.2022.12.23.02.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 02:08:11 -0800 (PST)
Message-ID: <b4a3fc9d-bd15-0682-2c56-4e63e0fb30cd@bytedance.com>
Date:   Fri, 23 Dec 2022 18:08:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [syzbot] KASAN: use-after-free Read in put_pmu_ctx
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com>,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        bpf@vger.kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000a20a2e05f029c577@google.com>
 <Y6B3xEgkbmFUCeni@hirez.programming.kicks-ass.net>
 <3a5a4738-2868-8f2f-f8b2-a28c10fbe25b@linux.dev>
 <Y6TFKdVJ9BY56fkI@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Y6TFKdVJ9BY56fkI@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/23 04:59, Peter Zijlstra wrote:
> On Wed, Dec 21, 2022 at 10:42:39AM +0800, Chengming Zhou wrote:
> 
>>> Does this help?
>>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index e47914ac8732..bbff551783e1 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -12689,7 +12689,8 @@ SYSCALL_DEFINE5(perf_event_open,
>>>  	return event_fd;
>>>  
>>>  err_context:
>>> -	/* event->pmu_ctx freed by free_event() */
>>> +	put_pmu_ctx(event->pmu_ctx);
>>> +	event->pmu_ctx = NULL; /* _free_event() */
>>>  err_locked:
>>>  	mutex_unlock(&ctx->mutex);
>>>  	perf_unpin_context(ctx);
>>
>> Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> While reviewing the code, I found perf_event_create_kernel_counter()
>> has the similar problem in the "err_pmu_ctx" error handling path:
> 
> Right you are, updated the patch, thanks!
> 
>> CPU0					CPU1
>> perf_event_create_kernel_counter()
>>   // inc ctx refcnt
>>   find_get_context(task, event) (1)
>>
>>   // inc pmu_ctx refcnt
>>   pmu_ctx = find_get_pmu_context()
>>
>>   event->pmu_ctx = pmu_ctx
>>   ...
>>   goto err_pmu_ctx:
>>     // dec pmu_ctx refcnt
>>     put_pmu_ctx(pmu_ctx) (2)
>>
>>     mutex_unlock(&ctx->mutex)
>>     // dec ctx refcnt
>>     put_ctx(ctx)
>> 					perf_event_exit_task_context()
>> 					  mutex_lock()
>> 					  mutex_unlock()
>> 					  // last refcnt put
>> 					  put_ctx()
>>     free_event(event)
>>       if (event->pmu_ctx) // True
>>         put_pmu_ctx() (3)
>>           // will access freed pmu_ctx or ctx
>>
>>       if (event->ctx) // False
>>         put_ctx()
> 
> This doesn't look right; iirc you can hit this without concurrency,
> something like so:

Right, pmu_ctx UaF can hit without concurrency.

But ctx has been created with refcnt == 1, which referenced by the task,
so the last refcnt put must be in perf_event_exit_task_context().

Maybe we can improve this, don't let ctx referenced by the task? Then ctx
can be freed when all perf_events are removed, instead of having to wait
for the task to exit. Maybe I missed something...

> 
> 
> 	// note that when getting here, we've not passed
> 	// perf_install_in_context() and event->ctx == NULL.
> err_pmu_ctx:
> 	put_pmu_ctx();
> 	put_ctx(); // last, actually frees ctx

This put_ctx() dec refcnt from 2 to 1, perf_event_exit_task_context()
will put the last refcnt and free it.

> 	..
> err_alloc:
> 	free_event()
> 	  _free_event()
> 	    if (event->pmu_ctx) // true, because we forgot to clear
> 	      put_pmu_ctx() // hits 0 because double put
> 	        // goes and touch epc->ctx and UaF
> 
> 
