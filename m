Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0683A73295A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbjFPH5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjFPH5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:57:18 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC9D2733
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:56:51 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b426eb7e81so437680a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686902210; x=1689494210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7akWJfKU7KySEaAy2Be+qsghvShSh0LwGIoacaHng2E=;
        b=Jq4b520gd1ciax7vITpPQfEwnbciLU2pm7HpcD9DReUj0khZjz5cCCYpF5+FHE6qXo
         g/XZUbfT9QBfaB5KFGNxsa8GgG7+mL67FTiMxeoT3/flA4UaPTFw544HHJkciE/7Pguk
         Iir9TcdpX758EjuPjTrZU3jjEm58aQS8ic7gbMz64vdEG78uNP3AGpJD3DwXM2Vu5zIr
         vETFv9fBz9OcPXZ13nRlPkcKYYkeXvjwps8yZlJ9P7STmDsdKuE9oIpEmRf0ghXbwmmQ
         KjyWqkW8n4uCwNJMqYRY993jDa7P8euMuK5HvL1Qw9CwghZAgv9PaxjU4pD4ywiBTAbE
         IGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686902210; x=1689494210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7akWJfKU7KySEaAy2Be+qsghvShSh0LwGIoacaHng2E=;
        b=ErOxnzoldNrY34nz4+iRMyRBu1T+iwA53nwziHY0VUH/1OS9YV3r9RfacR5H+mMr8Z
         10pJ836vmBymfiz9qK5NaOY36v/n1gVKuky/hhm2MEOAEcvsR7n2RmPq1Xjp28Dl3tUz
         HbTh4NeVkcw1irIDyyqJcgMJJ54sPN+kHObyzxU6USN44lK16U1P65edFnFMyRv5+dE8
         28ThddYka6qcoUxUrR0M+5bXDJ16907flLZCkHIj9CTWac93y3wZxoTYTD0vh0k9JNhI
         FckkW8Ytf9Mbotht5DeXObvx1AfMUsNlGraDaaI0UwciDuapN1bCqUNyYR3VI8b2hp4/
         GIMw==
X-Gm-Message-State: AC+VfDwmMUjjclBasj4pFZQOh5cwUbRPRSfIur5SDBMMWVe6XT2hRI3u
        lmFxnOFlA283XEvj0+0xEIHAVQ==
X-Google-Smtp-Source: ACHHUZ5G3nD6xClYa3QpJaDyRFs2bk6/3sZnAbfDwrk9tBjIYVOyspubda3QgR80DZZpEv69QApchw==
X-Received: by 2002:a54:4884:0:b0:39a:bdc8:d4d2 with SMTP id r4-20020a544884000000b0039abdc8d4d2mr1611893oic.5.1686902210563;
        Fri, 16 Jun 2023 00:56:50 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:11b7:189f:bf83:942e:7892? ([240e:694:e21:b::2])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090a6b4600b0025bda194e5esm767598pjl.31.2023.06.16.00.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:56:50 -0700 (PDT)
Message-ID: <b4fcf354-f6ee-be68-1608-8b874511785a@bytedance.com>
Date:   Fri, 16 Jun 2023 15:56:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [External] Re: [PATCH v5 2/4] sched/core: Avoid double calling
 update_rq_clock() in __balance_push_cpu_stop()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
References: <20230613082012.49615-1-jiahao.os@bytedance.com>
 <20230613082012.49615-3-jiahao.os@bytedance.com>
 <20230615123950.GF1683497@hirez.programming.kicks-ass.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230615123950.GF1683497@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/15 Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 04:20:10PM +0800, Hao Jia wrote:
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index a8be5415daba..1eca36299d8b 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2398,7 +2398,6 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
>>   	if (!is_cpu_allowed(p, dest_cpu))
>>   		return rq;
>>   
>> -	update_rq_clock(rq);
>>   	rq = move_queued_task(rq, rf, p, dest_cpu);
>>   
>>   	return rq;
>> @@ -2456,10 +2455,12 @@ static int migration_cpu_stop(void *data)
>>   				goto out;
>>   		}
>>   
>> -		if (task_on_rq_queued(p))
>> +		if (task_on_rq_queued(p)) {
>> +			update_rq_clock(rq);
>>   			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
>> -		else
>> +		} else {
>>   			p->wake_cpu = arg->dest_cpu;
>> +		}
>>   
>>   		/*
>>   		 * XXX __migrate_task() can fail, at which point we might end
> 
> So now you've got update_rq_clock() in both callers, why not remove it
> from __balance_push_cpu_stop() ?
> 
> Afaict nothing actually needs it before __migrate_task().
> 

Thanks for your review.
I'm afraid not, the rq clock also needs to be updated before
select_fallback_rq() is called.


> ---
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9435,8 +9435,6 @@ static int __balance_push_cpu_stop(void
>   	raw_spin_lock_irq(&p->pi_lock);
>   	rq_lock(rq, &rf);
>   
> -	update_rq_clock(rq);
> -
>   	if (task_rq(p) == rq && task_on_rq_queued(p)) {
>   		cpu = select_fallback_rq(rq->cpu, p);
>   		rq = __migrate_task(rq, &rf, p, cpu);

If we just remove update_rq_clock() from __balance_push_cpu_stop(), we 
will get this warning.


[ 1260.960166] rq->clock_update_flags < RQCF_ACT_SKIP
[ 1260.960170] WARNING: CPU: 25 PID: 196 at kernel/sched/sched.h:1496 
update_curr+0xf6/0x1f0

[ 1260.960318] Call Trace:
[ 1260.960320]  <TASK>
[ 1260.960323]  ? show_regs+0x5b/0x60
[ 1260.960327]  ? __warn+0x89/0x140
[ 1260.960331]  ? update_curr+0xf6/0x1f0
[ 1260.960334]  ? report_bug+0x1b7/0x1e0
[ 1260.960338]  ? __wake_up_klogd.part.25+0x5a/0x80
[ 1260.960342]  ? handle_bug+0x45/0x80
[ 1260.960346]  ? exc_invalid_op+0x18/0x70
[ 1260.960348]  ? asm_exc_invalid_op+0x1b/0x20
[ 1260.960354]  ? update_curr+0xf6/0x1f0
[ 1260.960356]  ? update_curr+0xf6/0x1f0
[ 1260.960359]  dequeue_entity+0x3b/0x410
[ 1260.960361]  dequeue_task_fair+0xc7/0x3c0
[ 1260.960363]  dequeue_task+0x30/0xf0
[ 1260.960365]  __do_set_cpus_allowed+0x94/0x130
[ 1260.960366]  do_set_cpus_allowed+0x38/0x60
[ 1260.960368]  cpuset_cpus_allowed_fallback+0x70/0x80
[ 1260.960372]  select_fallback_rq+0x20f/0x250            <----
[ 1260.960374]  __balance_push_cpu_stop+0x13f/0x1a0
[ 1260.960377]  ? migration_cpu_stop+0x2b0/0x2b0
[ 1260.960379]  cpu_stopper_thread+0xaf/0x140
[ 1260.960382]  smpboot_thread_fn+0x158/0x220
[ 1260.960387]  ? sort_range+0x30/0x30
[ 1260.960390]  kthread+0xfe/0x130
[ 1260.960392]  ? kthread_complete_and_exit+0x20/0x20
[ 1260.960394]  ret_from_fork+0x1f/0x30
[ 1260.960399]  </TASK>

Thanks,
Hao
