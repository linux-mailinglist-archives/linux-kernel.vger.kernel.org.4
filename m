Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0986C605F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjCWHEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjCWHDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:03:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E7B311E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:03:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a16so16340239pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679554993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAd8QT91xkaz2gTQS/8gMHDMDz9DQU6AGGs+hgVtPpQ=;
        b=Bj7JOZH6EpWfBIZ5zb/tQpQMxP++qmuLLdVhpSP3QNeFlSdV9ZMwVGo8003PCE/i5Y
         jWbjrLqXsBc5C1GlwImP7wk4vs87QaIu5pkhOjZYo60ClTuT3i2jp9kMfWawJ9Hp7NqB
         r7prMR0rYz+POGnoWXPORZAv1zTzy136yMjfq/V/xSnR2OPfPzx3Vq6BI2CI/vAhbNg3
         YUnhoKltoPfMCyEB6lUrdJbiYx94a1bB87OISBbU1BKUNJr9Dc4dS43nv40TVMz8gBBo
         9/GBqyAxmkhtaIGAQZXVYyGxxoAe172PuLhuMcrY6mElD+uH6PPX1Jq5V42bkyxXoT/M
         FsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679554993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FAd8QT91xkaz2gTQS/8gMHDMDz9DQU6AGGs+hgVtPpQ=;
        b=lK7xbJ8wVl9uanL94vJh3zL+5MvztVUuLS1VB3Wls3rd8gP9dbI8GT6m7UAx5dYQpT
         PKa5AflL9UrMXT4mcqu3nRE91cVF7htdKtUnG/nQpLJquwD3e+ssq9XewyI7i6e5EaCm
         oMmA0/mdjF/qNySw9ApOE6u+yNRgyxFZg8MkdDeeqsrWW9U4ExmOqEKjS9Z/b5scDi02
         fFmjR3rDfrOcK+nQbCP+aToPaKvw/a1RPQO94kFOaVyRh/XzeFofZqqjXepfYJPcFBW7
         Nbe/ABEqvE4uYsfJSA9UueT+Geg4b2lrxKE2k05G/63BvJK62AVogJ0TDE1/6zAnwREZ
         FQ1w==
X-Gm-Message-State: AO0yUKUyvXH+F90ncslsEvziDwTtVJPGt8kX77WkcIE//k2YfsEJpBQz
        RKbUlFBoa/pW4U0GXD+u+EswZZRUhPSAkmRkfhQ=
X-Google-Smtp-Source: AK7set+CLHLHt/LwA6YahhG3EC4Q/WbBgVegV7WEObIfCICRABrQH7+KnXX3mr2kyP3UUGEjgSSn7w==
X-Received: by 2002:a17:90a:181:b0:23f:58a2:7d6d with SMTP id 1-20020a17090a018100b0023f58a27d6dmr7006974pjc.6.1679554993556;
        Thu, 23 Mar 2023 00:03:13 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id mn13-20020a17090b188d00b002372106a5casm600255pjb.44.2023.03.23.00.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:03:13 -0700 (PDT)
Message-ID: <0e569d64-ce35-2176-5d41-faa6997480ef@bytedance.com>
Date:   Thu, 23 Mar 2023 15:01:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [External] Re: [PATCH] sched/core: Minor optimize
 pick_next_task() when core-sched enable
To:     Vineeth Pillai <vineethrp@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>
References: <20230308100414.37114-1-jiahao.os@bytedance.com>
 <4972a8be-d300-a66e-7fac-a83f11b56fbf@bytedance.com>
 <CAEXW_YRG0Bw4U1+zOPpjRPQEeKNDMrs7x-ZE-W00aifn7heG4g@mail.gmail.com>
 <CA+HDTgT0sjt38E4-2uQs_2t1GSsYFDqz3porOx-WQbt8x9hhXw@mail.gmail.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <CA+HDTgT0sjt38E4-2uQs_2t1GSsYFDqz3porOx-WQbt8x9hhXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/23 Vineeth Pillai wrote:
> Merging two threads.
> 
> On Tue, Mar 21, 2023 at 5:40 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>>
>>> CPU0 and CPU1 are two CPUs on the same core, task0 and task2 are the
>>> highest priority tasks on rq0 and rq1 respectively, task2 is @max
>>> on the entire core.
> 
>> I'm assuming this all starts by rq0 doing a pick and getting task0.
>> Because any other selection would go down the whole !need_sync route.
>>
> I think this could also happen when rq1 starts the pick due to task2 wakeup
> while task0 was running in rq0. In this case, core->core_cookie would be set
> and we take the need_sync path I guess.
> 
>>> In the case that 'max' has a zero cookie, instead of continuing to
>>> search for a runnable task on rq0 that matches @max's cookie, we
>>> choose idle for rq0 directly.
>>> At this time, it is obviously better to choose task1 to run for rq0,
>>> which will increase the CPU utilization.
>>> Therefore, we queue tasks with zero cookies in core_tree, and record
>>> the number of non-zero cookie tasks of each rq to detect the status
>>> of the sched-core.
>>
>> I do remember this as a known issue (more of a known but unimplemented
>> optimization) which happens when you have a high priority non-cookie
>> task which is in front of several low priority ones on the same
>> thread/rq. Adding +Vineeth Pillai to see if he remembers the issue.
>>
> Yes, I remember this as one of the 2 issues we noticed, but could not get to
> fixing it. Here we have non-cookied tasks considered special as a side effect
> of implementation(non-cookied tasks not in core rbtree) and hence we force idle
> if max is non-cookied and the highest prio task on the sibling is cookied.
> 
> The other issue was - we don't update core rbtree when vruntime changes and
> this can cause starvation of cookied task if there are more than one task with
> the same cookie on an rq.
> 

If I understand correctly, when a cookied task is enqueued, the 
difference delta1 between its vruntime and min_vruntime is very large.

Another task with the same cookie is very actively dequeuing and 
enqueuing, and the difference delta2 between its vruntime and 
min_vruntime is always smaller than delta1?
I'm not sure if this is the case?

>>>   static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>>>   {
>>> - if (sched_core_enabled(rq))
>>> - sched_core_dequeue(rq, p, flags);
>>> + sched_core_dequeue(rq, p, flags);
>>>
>>>   if (!(flags & DEQUEUE_NOCLOCK))
>>>   update_rq_clock(rq);
> 
>> Yeah, this is an absolute no-no, it makes the overhead of the second rb
>> tree unconditional.
> 
> I agree. Could we keep it conditional by enqueuing 0-cookied tasks only when
> coresched is enabled, just like what we do for cookied tasks? This is still an
> overhead where we have two trees storing all the runnable tasks but in
> different order. We would also need to populate core rbtree from cfs rbtree
> on coresched enable and empty the tree on coresched disable.
> 

I'm not sure if the other way is reasonable, I'm trying to provide a 
function for each scheduling class to find a highest priority non-cookie 
task.

For example fair_sched_class, we can use rq->cfs_tasks to traverse the 
search. But this search may take a long time, maybe we need to limit the 
number of searches.

Thanks,
Hao
