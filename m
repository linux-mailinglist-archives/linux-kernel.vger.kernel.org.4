Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C0F6C40CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCVDMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCVDMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:12:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375945BA4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:12:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d13so17371943pjh.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679454745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyiUxEXhqToYQpcOyQRq/rEmtYTX+FCke9ym2HPLdjE=;
        b=VHECvIEXymQlrorCMzJSZStbRVT9JtUh78LhEVutDpOwTe91fq84spBFvCd5OZG8f7
         LkX+ft24fJ9XIjtBt9oNkZdsKSUUaK0wq0TE2523FhPVbt8QG0+1k2BWpV6Dg33fvVIy
         1ISZWjX0pRmP2BeEcA8Mvnl1hqE9QFl5R2V8JoKtkb+c26cB2Wy193eW4/q5EniZOW2u
         gNSj8FuZjcTTbSmm6KP5nY1CV0CZlpJ5hBg5cJznbdZeDccAOJBwuZIhzwlojipT+NPj
         dmWM1yzeRiDxFEav0Jl+J63lDIxOG8uIINdGxTL3RZ3d9YC+TC3BuCcRiDV8R55py3TL
         bWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679454745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zyiUxEXhqToYQpcOyQRq/rEmtYTX+FCke9ym2HPLdjE=;
        b=DN2bCVs4RVVQ6WaNQG+2F+8bNWR6F1YdnAUWsC2NKrM3sYEngZ2ey57DXRf2B4o5Bk
         LNVjPAShBWRkUL4+M6fqUWxg0a6tqs2vpXwTK92Aeyhw4zrz9Jp9jP8C/mltmTg8EH+p
         UtlD5xab/MYgin410RICF/IFoJEr/OAsvKl0o1TeyJtDi6uUoHZqvsTQ3PS2ZBBZRWb1
         s9jIo5vPSrAQjZJotSwFszhWs8Dt22XxM/9LopqT+d1rU/P7GCWGRIdYE+Lv3Z79TIlN
         mVdaj/ujgWTeIKdgWCEc1pzoMLbc4/iP1Vc4kwjfKrve3N7AbjGlX27K9B62baO2ugyA
         BiIA==
X-Gm-Message-State: AO0yUKVLesTymbxUrc+qWoOGg7t/Kg5s26zMWIyugp4HHD4bJoK75iA1
        LT8vWAlfVeR42EHzjFr4liyvrw==
X-Google-Smtp-Source: AK7set8pfwx8LsFyrKgkuIuqzIO0pBHpgcEiGi8EIfTAwfBqz0RepHJRq6waIZClVdJ7ZbomluAEzw==
X-Received: by 2002:a05:6a20:2114:b0:db:1309:8fdb with SMTP id y20-20020a056a20211400b000db13098fdbmr568440pzy.23.1679454745670;
        Tue, 21 Mar 2023 20:12:25 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id f12-20020aa782cc000000b006255a16be2fsm8930393pfn.132.2023.03.21.20.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 20:12:25 -0700 (PDT)
Message-ID: <af55979a-a19e-d6b8-314d-b573d0dcf513@bytedance.com>
Date:   Wed, 22 Mar 2023 11:12:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [External] Re: [PATCH] sched/core: Minor optimize
 pick_next_task() when core-sched enable
To:     Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Vineeth Pillai <vineethrp@google.com>
References: <20230308100414.37114-1-jiahao.os@bytedance.com>
 <4972a8be-d300-a66e-7fac-a83f11b56fbf@bytedance.com>
 <CAEXW_YRG0Bw4U1+zOPpjRPQEeKNDMrs7x-ZE-W00aifn7heG4g@mail.gmail.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <CAEXW_YRG0Bw4U1+zOPpjRPQEeKNDMrs7x-ZE-W00aifn7heG4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/22 Joel Fernandes wrote:
> On Mon, Mar 20, 2023 at 4:55 AM Hao Jia <jiahao.os@bytedance.com> wrote:
>>
>> kindly ping...
>>
>> On 2023/3/8 Hao Jia wrote:
>>> If core-sched is enabled, sometimes we will traverse each CPU on the core
>>> to find the highest priority task 'max' on the entire core, and then try
>>> and find a runnable task that matches @max.
>>> But in the following case, we choose the runnable task is not the best.
>>>
>>> core max: task2 (cookie 0)
>>>
>>>        rq0                             rq1
>>> task0(cookie non-zero)                task2(cookie 0)
>>> task1(cookie 0)
>>> task3(cookie 0)
>>> ...
>>>
>>> pick-task: idle                       pick-task: task2
>>>
>>> CPU0 and CPU1 are two CPUs on the same core, task0 and task2 are the
>>> highest priority tasks on rq0 and rq1 respectively, task2 is @max
>>> on the entire core.
>>>
>>> In the case that 'max' has a zero cookie, instead of continuing to
>>> search for a runnable task on rq0 that matches @max's cookie, we
>>> choose idle for rq0 directly.
>>> At this time, it is obviously better to choose task1 to run for rq0,
>>> which will increase the CPU utilization.
>>> Therefore, we queue tasks with zero cookies in core_tree, and record
>>> the number of non-zero cookie tasks of each rq to detect the status
>>> of the sched-core.
> 
> I do remember this as a known issue (more of a known but unimplemented
> optimization) which happens when you have a high priority non-cookie
> task which is in front of several low priority ones on the same
> thread/rq. Adding +Vineeth Pillai to see if he remembers the issue.

Thank you for sharing the information, I will check the previous emails.


> 
> I can try to take a look at it this week to make sense of your patch.
> The code in upstream has changed quite a bit since we did this work on
> the older kernels, so allow some time to page it all in.

My patch tries to make non-cookie tasks also queue the core_tree if 
CONFIG_SCHED_CORE is defined.
This allows us to quaickly find the highest priority non-cookie task on 
this rq through sched_core_find(). But as Peter said it makes the 
overhead of the second rb tree unconditional.

Finding the highest priority non-cookie task is complex and 
time-consuming, especially in CONFIG_FAIR_GROUP_SCHED.

I am now trying to let the fore_idle CPU look for a highest priority 
non-cookie task through a mechanism similar to queue_balance_callback.
I'm not sure if this is possible, do you have a better suggestion?

> 
> Meanwhile, could you please provide some more details of your
> usecase/workload and how this patch improves it? Also out of
> curiosity, is bytedance using core scheduling for security or
> something else?
> 

At ByteDance, we try to use core-sched to deploy high-priority services 
(online) and low-priority services (offline) on the same physical machine.

core-sched can ensure that offline(cookie non-zero) will not affect 
onlie's L1 and L2 cache when onlie is running. In our scenario, 
core-sched is very useful for online services.

Thanks,
Hao


> Thanks,
> 
>   - Joel
> 
> 
>>>
>>> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
>>> ---
>>>    kernel/sched/core.c       | 29 +++++++++++++++--------------
>>>    kernel/sched/core_sched.c |  9 ++++-----
>>>    kernel/sched/sched.h      |  1 +
>>>    3 files changed, 20 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index af017e038b48..765cd14c52e1 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -236,8 +236,8 @@ void sched_core_enqueue(struct rq *rq, struct task_struct *p)
>>>    {
>>>        rq->core->core_task_seq++;
>>>
>>> -     if (!p->core_cookie)
>>> -             return;
>>> +     if (p->core_cookie)
>>> +             rq->cookied_count++;
>>>
>>>        rb_add(&p->core_node, &rq->core_tree, rb_sched_core_less);
>>>    }
>>> @@ -246,11 +246,16 @@ void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
>>>    {
>>>        rq->core->core_task_seq++;
>>>
>>> +     if (p->core_cookie)
>>> +             rq->cookied_count--;
>>> +
>>>        if (sched_core_enqueued(p)) {
>>>                rb_erase(&p->core_node, &rq->core_tree);
>>>                RB_CLEAR_NODE(&p->core_node);
>>>        }
>>>
>>> +     if (!sched_core_enabled(rq))
>>> +             return;
>>>        /*
>>>         * Migrating the last task off the cpu, with the cpu in forced idle
>>>         * state. Reschedule to create an accounting edge for forced idle,
>>> @@ -370,7 +375,7 @@ static void sched_core_assert_empty(void)
>>>        int cpu;
>>>
>>>        for_each_possible_cpu(cpu)
>>> -             WARN_ON_ONCE(!RB_EMPTY_ROOT(&cpu_rq(cpu)->core_tree));
>>> +             WARN_ON_ONCE(cpu_rq(cpu)->cookied_count);
>>>    }
>>>
>>>    static void __sched_core_enable(void)

