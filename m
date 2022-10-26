Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B92E60D952
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 04:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiJZCay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 22:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJZCaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 22:30:52 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0629DDA8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 19:30:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g129so11848860pgc.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 19:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7TUdF/ux7T09ZpTtqSVZf4pwCeVTDeWDDT2ZG4A2G0=;
        b=VxyiWCLqaQvj583kMHkKtxR+amNrKHjjy6y4aTPO1JvCQ0LbOS9Ih0G43vIcNPyYuM
         /jRm3dW4GC91/SjwtxjMeQVF8kP/TcBNEO5xbcnqSAnH8xsmrlAwghvvm5nL6M7ST4ix
         o50ybkvkTVxXD99sjql6rSrF+5OAzmKQ0DW4c8AXxeJ93tdBDF+3h61aWVWi24YmFpXK
         6dC1Nt8N+tvZuIn7toY2O9PUDYaMv0YmTAfLUAtAaxBdvZCCGUD9J1IluZ7fw033zHTO
         CEeQTt+JzfzahqVA17ZHDVtQKkd/J8d6pDHJzmg+HOq6Qg8DUFZXAwkIqT1i/VYwEz10
         ak6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P7TUdF/ux7T09ZpTtqSVZf4pwCeVTDeWDDT2ZG4A2G0=;
        b=1BxlHXMlbLeDEmsoXtqQDO0Te+JSpsSdiBAUn5dJgiIWq95ymAGUbGzN2PDd+oUJOO
         qU3jdKWG1CkXUYWVqGNTAonU9G4BoklRMOimwcAyQB1YPajZxMmjz9ZQfPF53F8ZNhFU
         OyEqBWRMNR0JjYe8F6Z63HrSetDNfJUv3aCj/UrAGDmti/7VXcqqSz20F5KrwBM0EJrL
         lrgGUAlATjn/z9fzafqg/ltJ8cx+s0Blc8YRLlojTwOwvqDViCsuHnqH34xzoEa6VDEk
         OXC0+9CfEQOPZXdr+rpf5m8n3R1fUdACoIIyRaKRjVHzQIurjlsnumd+QgRzeffCaTrV
         jAzg==
X-Gm-Message-State: ACrzQf3Sa/uxb574HiKxG4q5WtfeD8TjnIk65TWEHwMjmRULHoASEY8d
        b+1O35KCVEG07wshEY32Vx3tlw==
X-Google-Smtp-Source: AMsMyM7t3fJnIkALoac7Hle83hewfVyeqUi9+pV0jeMVseKV4RoO4sl7UwX2p6yxjd8rWek0xa1FfA==
X-Received: by 2002:a63:f709:0:b0:44f:6cba:3a4f with SMTP id x9-20020a63f709000000b0044f6cba3a4fmr34514287pgh.428.1666751450435;
        Tue, 25 Oct 2022 19:30:50 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id bw6-20020a17090af60600b0020ad26fa65dsm239327pjb.56.2022.10.25.19.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 19:30:49 -0700 (PDT)
Message-ID: <42bbc36f-c7cf-b81c-e1c7-68d304cb26b9@bytedance.com>
Date:   Wed, 26 Oct 2022 10:30:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [External] Re: [PATCH 1/2] sched/numa: Stop an exhastive search
 if an idle core is found
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Mel Gorman <mgorman@suse.de>, mingo@redhat.com,
        peterz@infradead.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20221021061558.34767-1-jiahao.os@bytedance.com>
 <20221021061558.34767-2-jiahao.os@bytedance.com>
 <20221024133435.e2kajx5k7jzznp25@suse.de>
 <ced7c05a-121b-a77d-0c57-3e60abaecacd@bytedance.com>
 <20221025093226.dm4sjvdq2tofkwvc@suse.de>
 <71589225-a4fd-b3eb-14d5-81c9a19419a7@bytedance.com>
 <20221025133226.ap6zeidoyea6jher@techsingularity.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20221025133226.ap6zeidoyea6jher@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/25 Mel Gorman wrote:
> On Tue, Oct 25, 2022 at 07:10:22PM +0800, Hao Jia wrote:
>> On 2022/10/25 Mel Gorman wrote:
>>> On Tue, Oct 25, 2022 at 11:16:29AM +0800, Hao Jia wrote:
>>>>> Remove the change in the first hunk and call break in the second hunk
>>>>> after updating ns->idle_cpu.
>>>>>
>>>>
>>>> Yes, thanks for your review.
>>>> If I understand correctly, some things might look like this.
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index e4a0b8bd941c..dfcb620bfe50 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -1792,7 +1792,7 @@ static void update_numa_stats(struct task_numa_env
>>>> *env,
>>>>                   ns->nr_running += rq->cfs.h_nr_running;
>>>>                   ns->compute_capacity += capacity_of(cpu);
>>>>
>>>> -               if (find_idle && !rq->nr_running && idle_cpu(cpu)) {
>>>> +               if (find_idle && idle_core < 0 && !rq->nr_running &&
>>>> idle_cpu(cpu)) {
>>>>                           if (READ_ONCE(rq->numa_migrate_on) ||
>>>>                               !cpumask_test_cpu(cpu, env->p->cpus_ptr))
>>>>                                   continue;
>>>>
>>>
>>> I meant more like the below but today I wondered why did I not do this in
>>> the first place? The answer is because it's wrong and broken in concept.
>>>
>>> The full loop is needed to calculate approximate NUMA stats at a
>>> point in time. For example, the src and dst nr_running is needed by
>>> task_numa_find_cpu. The search for an idle CPU or core in update_numa_stats
>>> is simply taking advantage of the fact we are scanning anyway to keep
>>> track of an idle CPU or core to avoid a second search as per ff7db0bf24db
>>> ("sched/numa: Prefer using an idle CPU as a migration target instead of
>>> comparing tasks")
>>>
>>> The patch I had in mind is below but that said, for both your version and
>>> my initial suggestion
>>>
>>> Naked-by: Mel Gorman <mgorman@suse.de>
>>>
>>> For the record, this is what I was suggesting initially because it's more
>>> efficient but it's wrong, don't do it.
>>>
>>
>> Thanks for the detailed explanation, maybe my commit message misled you.
>>
> 
> Yes, I did end up confusing myself. The title and changelog referred to
> stopping a search which made me think of terms of "this whole loop can
> terminate early" which it can't but it *can* stop checking for a new idle
> core. If an idle core has been found, it follows that an idle CPU has also
> been found. While numa_idle_core checks this explicitly, your patch avoids
> an unnecessary cpumask_test_cpu so it has value.
> 

Thank you for your review, I will change the commit message and send 
patch v2.


>> Yes, we can't stop the whole loop of scanning the CPU because we have a lot
>> of NUMA information to count.
>>
>> But we can stop looking for the next idle core or idle cpu after finding an
>> idle core.
>>
>> So, please review the previous code.
>>
> 
> You're right and sorry for the noise.
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks!

> 
Thanks,
Hao
