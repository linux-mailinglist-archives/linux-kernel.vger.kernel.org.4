Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2126C7825
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjCXGse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjCXGsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:48:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC28155AD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:48:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g7so652467pfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679640485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLh/6bh1sWVRV0c9lkEoQn073YR5WcQ+jisZ97EGFYM=;
        b=k3y0tN7YwhbK5mwZ3KlLFkVXxZz16CbDEwGswSrKHw5cB31yREIfBzrp5AMB6FOGOY
         uQh6CiEvk31FY4Yhnu8YYeaVJGZYhloFgm3dlWI2uJFbz30mgEMCjI/IXb6C/ugRKpRW
         u7FpdW7RCpWJvQ2LrvVSCPZh93kmft8lB2lsxr5kQXE1EVwzUMgmCX0wQGTvh566kR5r
         6CF2HNu/TCK0z22B2VrOc7PwBv52nh6KcYX8/Rl9ImSWu648B02sudG2qrhPRksAh4bR
         CN6OgaTzLpFCfh5ymkrDj+2LObcwpZcidSymwMKRdOuEucZrve8JHpYn+WtUsEqbRn/0
         HXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679640485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bLh/6bh1sWVRV0c9lkEoQn073YR5WcQ+jisZ97EGFYM=;
        b=Rbsc/JrgHr7fapeVXAD/S3MSF9F+vkVMDUTwQk7xEL9iTeDpD4w8jFlUPtjFcKK3lq
         YxM2Me6N2inESYTx/Rk2BnGsbmctGdV9TM7rle0/p6kx1DL9sG3ZDDQZqLP0+3YQWD7O
         +hw14t1zaRgjBuHGZrW+v/69K54XCuv+zMEwDCZDuak+BydqGPc7PwfoCPFK8Aq8CLTi
         X73nF/IZdsY9TeRCCFqD/Rl1v7xHw6kd7HPss0KnsxX0f7bnVeqzqZbd/bCL8g3LfHyy
         9kjxhK2yc9TbQbPxH/OSIO6kByfENOvBVNBW6r8l1MAqhWOqMC15+qn/a3hWqLWZ9bTI
         A4/A==
X-Gm-Message-State: AAQBX9cvqIKGYt1uz4oJJ8wxSiYt5pRt6hCPclbzxALtnvUVxXcHFcWl
        L5J+Pf+OADS5NPKPKrf/QPVKXQ==
X-Google-Smtp-Source: AKy350bxyjI17JtyAiITrzyTA2KXTFWHAxZc40AlxGs7gE//n7kkAf+JJvTCWNd+LeWSvEe0uXLXXA==
X-Received: by 2002:a62:8496:0:b0:627:f659:a771 with SMTP id k144-20020a628496000000b00627f659a771mr2221129pfd.12.1679640485059;
        Thu, 23 Mar 2023 23:48:05 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id w5-20020aa78585000000b005a8dd86018dsm7864440pfn.64.2023.03.23.23.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 23:48:04 -0700 (PDT)
Message-ID: <b5553f7c-7e72-ff44-7d2d-8ff41dd8a7f5@bytedance.com>
Date:   Fri, 24 Mar 2023 14:47:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [External] Re: [PATCH] sched/core: Minor optimize
 pick_next_task() when core-sched enable
To:     Vineeth Pillai <vineethrp@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, mingo@redhat.com,
        peterz@infradead.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>
References: <20230308100414.37114-1-jiahao.os@bytedance.com>
 <4972a8be-d300-a66e-7fac-a83f11b56fbf@bytedance.com>
 <CAEXW_YRG0Bw4U1+zOPpjRPQEeKNDMrs7x-ZE-W00aifn7heG4g@mail.gmail.com>
 <CA+HDTgT0sjt38E4-2uQs_2t1GSsYFDqz3porOx-WQbt8x9hhXw@mail.gmail.com>
 <0e569d64-ce35-2176-5d41-faa6997480ef@bytedance.com>
 <CA+HDTgSg+LTCTGu2_TeJwahNk3fO50Zj1DMuJmBTxPGe1RRQgA@mail.gmail.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <CA+HDTgSg+LTCTGu2_TeJwahNk3fO50Zj1DMuJmBTxPGe1RRQgA@mail.gmail.com>
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



On 2023/3/24 Vineeth Pillai wrote:
> On Thu, Mar 23, 2023 at 3:03 AM Hao Jia <jiahao.os@bytedance.com> wrote:
> 
>>> The other issue was - we don't update core rbtree when vruntime changes and
>>> this can cause starvation of cookied task if there are more than one task with
>>> the same cookie on an rq.
>>>
>>
>> If I understand correctly, when a cookied task is enqueued, the
>> difference delta1 between its vruntime and min_vruntime is very large.
>>
>> Another task with the same cookie is very actively dequeuing and
>> enqueuing, and the difference delta2 between its vruntime and
>> min_vruntime is always smaller than delta1?
>> I'm not sure if this is the case?
> 
> This case I was mentioning is about tasks that are continuously running
> and hence always in the runqueue. sched_core_enqueue/dequeue is
> not called and hence their position in the core rbtree is static while cfs
> rbtree positions change as vruntime progresses.
> 

Thanks for the detailed explanation.

> BTW, this is a separate issue than the one you are targeting with this
> fix. I just thought of mentioning it here as well..
> 
>>>> Yeah, this is an absolute no-no, it makes the overhead of the second rb
>>>> tree unconditional.
>>>
>>> I agree. Could we keep it conditional by enqueuing 0-cookied tasks only when
>>> coresched is enabled, just like what we do for cookied tasks? This is still an
>>> overhead where we have two trees storing all the runnable tasks but in
>>> different order. We would also need to populate core rbtree from cfs rbtree
>>> on coresched enable and empty the tree on coresched disable.
>>>
>>
>> I'm not sure if the other way is reasonable, I'm trying to provide a
>> function for each scheduling class to find a highest priority non-cookie
>> task.
>>
>> For example fair_sched_class, we can use rq->cfs_tasks to traverse the
>> search. But this search may take a long time, maybe we need to limit the
>> number of searches.
> 
> Yes, it can be time consuming based on the number of cgroups and tasks
> that are runnable. You could probably take some performance numbers to
> see how worse it is.

I agree, this can be very bad if there are a lot of tasks on rq. But 
using cfs rbtree to find the highest priority non-cookie task will 
become very complicated when CONFIG_FAIR_GROUP_SCHED is enabled.

Thanks,
Hao

> 
> We could also have some optimization like marking a runqueue having
> non-cookied tasks and then do the search only if it is marked. I haven't
> thought much about it, but search could be optimized hopefully.
> 

