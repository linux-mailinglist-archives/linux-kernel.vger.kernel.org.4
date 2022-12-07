Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE656458CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiLGLUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiLGLTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:19:53 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055FC24F0D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:19:52 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 62so16048760pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 03:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7qk2r5wJcdPclWaxrIRg8UGcV+XYLc5KAUDNpleXyTg=;
        b=FCd8939RYueVU5lBTboGOJ7tvthsvdCppzLvWbY44CxsIN0TyakEqHHjByE615urAQ
         OWs+rtiYkZMC7TQMYNROBpglEc4OmuTBNpzwvyyjuDb9jaxvVT0iZ2bsB0nfpgvhaH+9
         Oii9ZxX5r4WcZYeWmrcOuBS89gAhNROeGcgYK81ayo4EsSjxQ5hLrV14VwdMNYhIaghn
         Ix6pKDT0XDySPYCP2PWbcQYuDhjqTl65p1HIiVc+fhIL2YD+bI/X7W+xZPnny0Q0xDDB
         n6ysD1R1G27bLWfBD5seExz1JtZcILcQViduvbSOZxdSiPP4GffuOSz9QBIR9OOK7vlb
         7+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qk2r5wJcdPclWaxrIRg8UGcV+XYLc5KAUDNpleXyTg=;
        b=f+AcPZ/vJvVweLp7qXPZUa7IHSwp2bl2mGhHJN33Ovg2fau0VxUE5t6bN/7mBLHwBt
         YDmq2lry2sy6DRkwXNKySExXv/hSDo+WqLZJCWvWvhBBt0E0lX6QdaFp/T1CRuJW3xSB
         zGKdDpRZJF90stVGQ7QDAtqd/HE4SKvNgF9gRvP3Y8z0HAZZSbOEUKyMzWoP/QMTDGie
         ACLPamVf+iQ2EpPxC50QOcZM+WnyYFCNsjWErRafMBYBFiInLbuvesaoRttTUJpst7LQ
         kY/tq9A+piGsO8NVi2PcPnP3s+zPdh3ZnfkPOTSCv8DIGl0/So0xK7uadf1gQLysloKz
         QlnQ==
X-Gm-Message-State: ANoB5pmTyQ9XzPGxW477p4qcVuejCEy5G7cjSHm7fPVODcViOQcWVcRH
        t7weUng35VbR9F1TYvIuLY2YAg==
X-Google-Smtp-Source: AA0mqf4IvDcUNSzqWPeZK8Duhky5bm92nHiu0HiFA5DoL86AOL1CpGEp2YObd2v/9RQfV9Y3u6hcWg==
X-Received: by 2002:a63:5b5b:0:b0:478:b6ba:8de6 with SMTP id l27-20020a635b5b000000b00478b6ba8de6mr13531979pgm.212.1670411991476;
        Wed, 07 Dec 2022 03:19:51 -0800 (PST)
Received: from [10.255.88.45] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id je10-20020a170903264a00b00186abb95bfdsm14379182plb.25.2022.12.07.03.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 03:19:51 -0800 (PST)
Message-ID: <5646805c-972d-d1b2-eb81-54cd015735ad@bytedance.com>
Date:   Wed, 7 Dec 2022 19:19:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] perf/core: Fix cgroup events tracking
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
References: <20221206025034.75125-1-zhouchengming@bytedance.com>
 <98312d02-9582-7a4b-21dd-a92f0094f401@amd.com>
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <98312d02-9582-7a4b-21dd-a92f0094f401@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/7 18:41, Ravi Bangoria wrote:
> On 06-Dec-22 8:20 AM, Chengming Zhou wrote:
>> We encounter perf warnings when using cgroup events like:
>> ```
>> cd /sys/fs/cgroup
>> mkdir test
>> perf stat -e cycles -a -G test
>> ```
>>
>> WARNING: CPU: 0 PID: 690 at kernel/events/core.c:849 perf_cgroup_switch+0xb2/0xc0
>> [   91.393417] Call Trace:
>> [   91.393772]  <TASK>
>> [   91.394080]  __schedule+0x4ae/0x9f0
>> [   91.394535]  ? _raw_spin_unlock_irqrestore+0x23/0x40
>> [   91.395145]  ? __cond_resched+0x18/0x20
>> [   91.395622]  preempt_schedule_common+0x2d/0x70
>> [   91.396163]  __cond_resched+0x18/0x20
>> [   91.396621]  wait_for_completion+0x2f/0x160
>> [   91.397137]  ? cpu_stop_queue_work+0x9e/0x130
>> [   91.397665]  affine_move_task+0x18a/0x4f0
> 
> nit: These timestamps can be removed in commit log.

Ok, will remove.

> 
>>
>> WARNING: CPU: 0 PID: 690 at kernel/events/core.c:829 ctx_sched_in+0x1cf/0x1e0
>> [   91.430151] Call Trace:
>> [   91.430490]  <TASK>
>> [   91.430793]  ? ctx_sched_out+0xb7/0x1b0
>> [   91.431274]  perf_cgroup_switch+0x88/0xc0
>> [   91.431778]  __schedule+0x4ae/0x9f0
>> [   91.432215]  ? _raw_spin_unlock_irqrestore+0x23/0x40
>> [   91.432825]  ? __cond_resched+0x18/0x20
>> [   91.433299]  preempt_schedule_common+0x2d/0x70
>> [   91.433839]  __cond_resched+0x18/0x20
>> [   91.434298]  wait_for_completion+0x2f/0x160
>> [   91.434808]  ? cpu_stop_queue_work+0x9e/0x130
>> [   91.435334]  affine_move_task+0x18a/0x4f0
>>
>> The above two warnings are not complete here since I remove other
>> unimportant information. The problem is caused by the perf cgroup
>> events tracking:
>>
>> CPU0					CPU1
>> perf_event_open()
>>   perf_event_alloc()
>>     account_event()
>>       account_event_cpu()
>>         atomic_inc(perf_cgroup_events)
>> 					__perf_event_task_sched_out()
>> 					  if (atomic_read(perf_cgroup_events))
>> 					    perf_cgroup_switch()
>> 					      // kernel/events/core.c:849
>> 					      WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0)
>> 					      if (READ_ONCE(cpuctx->cgrp) == cgrp) // false
>> 					        return
>> 					      perf_ctx_lock()
>> 					      ctx_sched_out()
>> 					      cpuctx->cgrp = cgrp
>> 					      ctx_sched_in()
>> 					        perf_cgroup_set_timestamp()
>> 					          // kernel/events/core.c:829
>> 					          WARN_ON_ONCE(!ctx->nr_cgroups)
>> 					      perf_ctx_unlock()
>>   perf_install_in_context()
>>     add_event_to_ctx()
>>       list_add_event()
>>         perf_cgroup_event_enable()
>>           ctx->nr_cgroups++
>>           cpuctx->cgrp = X
> 
> IIUC, since it's a cgroup event, perf_install_in_context() will do:
> cpu_function_call(cpu, __perf_install_in_context, event). And thus,
> callchain starting with add_event_to_ctx() will be executed on CPU1,
> not on CPU0.

Right, will fix it next version.

> 
>> We can see from above that we wrongly use percpu atomic perf_cgroup_events
>> to check if we need to perf_cgroup_switch(), which should only be used
>> when we know this CPU has cgroup events enabled.
>>
>> The commit bd2756811766 ("perf: Rewrite core context handling") change
>> to have only one context per-CPU, so we can just use cpuctx->cgrp to
>> check if this CPU has cgroup events enabled.
>>
>> So percpu atomic perf_cgroup_events is not needed.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> 
> Otherwise looks good.
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>

Ok, will add Fixes tag next version.

Thanks!

> 
> Thanks,
> Ravi
