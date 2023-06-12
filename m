Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572F072B575
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 04:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjFLCko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 22:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjFLCkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 22:40:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004521A5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 19:40:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-256712d65ceso1776528a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 19:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686537640; x=1689129640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8z5Ly/0YR0/GcCZ2PUSenI3Id6r2m4fdl41tJIxHF4=;
        b=FEtExUC2SDXE/8mh2OJweTjSeE6FShQ7XxYfIrLq63pH1iQfl1cy5T4fmZ/QmxwZCQ
         d6gC8xthSLc70oB0VCArvRLbWUE5udsvsmIYVl1wVFtlRh/JNeUKvvDwpA7hEg7zZ84L
         jOUiE92KLzPAesjgiMsxoFRLAGtj0++uYppwBhE16gUXbIJVfHstXqhyvH+UsHjHyf6B
         ynLNNRLEQEm0yMjVduhU9vCq9fILXH8Luc0JkW5rJNTx4/kTKk0iMj/wwOM+vBnyZbfZ
         Ya4wc4frCmz3n6b0u7ffdcMgYspnR0/JL5eMnrd25NZJI0q0WJczbXFvIP9SsqkyaCfC
         UZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686537640; x=1689129640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q8z5Ly/0YR0/GcCZ2PUSenI3Id6r2m4fdl41tJIxHF4=;
        b=RCjjsF4M7aYVBom0prNSoolJczPDF/LH9dbDbKkO5U7ZA8pczWqztP8QPa2AcM7vAQ
         4akYY4FAjNTzEGEeYt0jCI3KYzelVQf1a9dF+6hhNUI29NXbJTijfDm1+gU3Fp7Id8Au
         QYHc+a+yN5WCJxdXPsy1A/7Lb6/eDQfI4k5/iEybbfkbsF/lAseXdC5xZLYVK3xGF4Sg
         qWC/vUL/pTrhB/VNTYyxg5HrLT5BDQabQW9FjTGTO8nc9rQp+WSAipOUfSdjCsAE63Mx
         I5KC9st+JDP2mKwxE3hgSn372fsQ0lNuJkcGh2IdUcf/uDYL+oyKRQ61t3MiZW2zUnvz
         BO/Q==
X-Gm-Message-State: AC+VfDzOhreWRhMHwFyXg60xPphLO4xvekkOL1jnvBN2MPzo+AYz+iE2
        u8i4QsqIp5hMGfFfj6NNhlmlIQ==
X-Google-Smtp-Source: ACHHUZ44JVinW67sKFl/NeXXXqYjCQDQGLDR7nLHF/wAe0e3JZZU8Hz7Y9j/5V9JAO2DdK/hNXxRXg==
X-Received: by 2002:a17:90b:390d:b0:250:7347:39d9 with SMTP id ob13-20020a17090b390d00b00250734739d9mr7419284pjb.37.1686537640281;
        Sun, 11 Jun 2023 19:40:40 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:11b7:189f:bf83:942e:7892? ([2408:8000:b001:1:1f:58ff:f102:103])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a031b00b00256bedb4bedsm8657820pje.52.2023.06.11.19.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 19:40:39 -0700 (PDT)
Message-ID: <3891d05b-3d0d-b41d-7454-0f5e0d749ded@bytedance.com>
Date:   Mon, 12 Jun 2023 10:40:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [External] Re: [PATCH v4 4/4] sched/core: Avoid multiple calling
 update_rq_clock() in unthrottle_offline_cfs_rqs()
To:     Benjamin Segall <bsegall@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
References: <20230608063312.79440-1-jiahao.os@bytedance.com>
 <20230608063312.79440-5-jiahao.os@bytedance.com>
 <xm26zg59acky.fsf@google.com>
 <504c702c-b31a-a9d4-22a0-8a09547d30e5@bytedance.com>
 <xm26jzwc9z0s.fsf@google.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <xm26jzwc9z0s.fsf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/10 Benjamin Segall wrote:
> Hao Jia <jiahao.os@bytedance.com> writes:
> 
>> On 2023/6/9 Benjamin Segall wrote:
>>> Hao Jia <jiahao.os@bytedance.com> writes:
>>>
>>>> This WARN_DOUBLE_CLOCK warning is triggered during cpu offline.
>>>> ------------[ cut here ]------------
>>>> rq->clock_update_flags & RQCF_UPDATED
>>>> WARNING: CPU: 0 PID: 3323 at kernel/sched/core.c:741
>>>> update_rq_clock+0xaf/0x180
>>>> Call Trace:
>>>>    <TASK>
>>>>    unthrottle_cfs_rq+0x4b/0x300
>>>>    rq_offline_fair+0x89/0x90
>>>>    set_rq_offline.part.118+0x28/0x60
>>>>    rq_attach_root+0xc4/0xd0
>>>>    cpu_attach_domain+0x3dc/0x7f0
>>>>    partition_sched_domains_locked+0x2a5/0x3c0
>>>>    rebuild_sched_domains_locked+0x477/0x830
>>>>    rebuild_sched_domains+0x1b/0x30
>>>>    cpuset_hotplug_workfn+0x2ca/0xc90
>>>>    ? balance_push+0x56/0xf0
>>>>    ? _raw_spin_unlock+0x15/0x30
>>>>    ? finish_task_switch+0x98/0x2f0
>>>>    ? __switch_to+0x291/0x410
>>>>    ? __schedule+0x65e/0x1310
>>>>    process_one_work+0x1bc/0x3d0
>>>>    worker_thread+0x4c/0x380
>>>>    ? preempt_count_add+0x92/0xa0
>>>>    ? rescuer_thread+0x310/0x310
>>>>    kthread+0xe6/0x110
>>>>    ? kthread_complete_and_exit+0x20/0x20
>>>>    ret_from_fork+0x1f/0x30
>>>>
>>>> The rq clock has been updated before the set_rq_offline()
>>>> function runs, so we don't need to call update_rq_clock() in
>>>> unthrottle_offline_cfs_rqs().
>>> I don't think we do in the path from rq_attach_root (though that's easy
>>> enough to fix, of course).
>>>
>>
>> Thanks for your review.
>>
>> Now our fix method is that after applying patch1, we update the rq clock before
>> set_rq_offline(). Then use rq_clock_{start, stop}_loop_update to avoid updating
>> the rq clock multiple times in unthrottle_cfs_rq().
>>
>> Do you have any better suggestions?
>>
>> Thanks,
>> Hao
> 
> Yeah, the obvious fixes are to either add an update_rq_clock in
> rq_attach_root as you suggest, or put it in set_rq_offline instead of
> the callers.

Thanks for your suggestion. I will do it in the next version.

Thanks,
Hao
