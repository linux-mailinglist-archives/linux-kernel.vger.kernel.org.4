Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E156F66CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjEDIGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjEDIGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:06:16 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B589A19A8
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:05:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51b33c72686so59349a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683187471; x=1685779471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnjyP0u4eZAtxx4/JfG21mUyFYVaZ1jQ6if2pnG6nyo=;
        b=hFDfFV/u3RQMZqhz8rwdbV6mtxgAcGoUTWbKlzKTZ4zyCAKYs2erKMC02lUBIb2k7w
         2/hJncin2f0m1V/TdxO0Use9j2ceWyCjNZAhKXffjphB8IUZA6rDb/4oNUf3skZZBnL+
         xnGloHFbf884tQwP81xoBycd76F2KBhaAi2i5pGpkXTZikx09nejeTlxT0AyD6kxZx/E
         Yra2P5z5ommOolcRb7/BSazXqmylogQXS6/2JWemBDj5w8KQ03LrAUhvcmFZ17DtTjUj
         z59qsL4oyVrPLWpXzVB0WuH6cHkodT5XkInMeqSP1lsRLkdvOXaBEWBD+SpnD2VXar/z
         WjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187471; x=1685779471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cnjyP0u4eZAtxx4/JfG21mUyFYVaZ1jQ6if2pnG6nyo=;
        b=DNWCHzNkxqoF9hbb62JSOnwRaoW9PL6y01TR3tuiNpUHfOfEvyIuy3TEOVfv/Mgbdt
         oOZ8JFTuraZoangwX8smgcFqy9OJucF34ahtDXTZYcpnFPoYLIUByouRPpCZp13yKJtG
         AsKUpzufawaNK/1lXwCHEaJQChgCLAkqv9diSbwXDzS4Z3E74FteXyb02UaKSnWuk7ZQ
         ItXQCaqCGK9nitotTCufyRaqmEtp5OhRcGlPli+DsRTSWPkgELfS1x7/pnRX0LLiyY2F
         lmx15H43LsBD7lOqAin0LXoEdUbHA47Z8DjrovEvUdBBUf6IdUpwD7HnvcWLEakVeZsd
         Z4xA==
X-Gm-Message-State: AC+VfDxu5vz/7rbAYki4pqQzdWUwm6WZm0xo86NMJF/uixGVfC9fOF1Q
        QxsicyiEkDYJSKNLrCY3uF9Neg==
X-Google-Smtp-Source: ACHHUZ5iNbD4w69lMXUmqESdTQz/yYNJWEiqo8VwS4QpyJmjrPdxCAE4L/T9bOieTFLZ0Ftjzqc+FQ==
X-Received: by 2002:a05:6a21:1519:b0:ee:4c57:197 with SMTP id nq25-20020a056a21151900b000ee4c570197mr1465589pzb.18.1683187471007;
        Thu, 04 May 2023 01:04:31 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id f20-20020a056a00229400b0063799398eb9sm24838436pfe.58.2023.05.04.01.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 01:04:30 -0700 (PDT)
Message-ID: <5b20ac43-43b4-cabd-fa40-67f8be5fcef0@bytedance.com>
Date:   Thu, 4 May 2023 16:04:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [External] Re: [PATCH v4] sched/core: Adapt WARN_DOUBLE_CLOCK
 machinery for core-sched
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        Phil Auld <pauld@redhat.com>
References: <20230406064415.17110-1-jiahao.os@bytedance.com>
 <20230504072336.GG1734100@hirez.programming.kicks-ass.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230504072336.GG1734100@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/4 Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 02:44:15PM +0800, Hao Jia wrote:
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 0d18c3969f90..c6e2c79152ef 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -429,11 +429,32 @@ void sched_core_put(void)
>>   		schedule_work(&_work);
>>   }
>>   
>> +/*
>> + * Now, we have obtained a core-wide rq->lock, then we need to clear
>> + * RQCF_UPDATED of rq->clock_update_flags of the sibiling CPU
>> + * on this core to avoid the WARN_DOUBLE_CLOCK warning.
>> + */
>> +static inline void sched_core_clear_rqcf_updated(struct rq *rq)
>> +{
>> +#ifdef CONFIG_SCHED_DEBUG
>> +	const struct cpumask *smt_mask;
>> +	int i;
>> +
>> +	if (rq->core_enabled) {
>> +		smt_mask = cpu_smt_mask(rq->cpu);
>> +		for_each_cpu(i, smt_mask) {
>> +			if (rq->cpu != i)
>> +				cpu_rq(i)->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
>> +		}
>> +	}
>> +#endif
>> +}
>>   #else /* !CONFIG_SCHED_CORE */
>>   
>>   static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
>>   static inline void
>>   sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
>> +static inline void sched_core_clear_rqcf_updated(struct rq *rq) { }
>>   
>>   #endif /* CONFIG_SCHED_CORE */
>>   
>> @@ -548,6 +569,7 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
>>   		if (likely(lock == __rq_lockp(rq))) {
>>   			/* preempt_count *MUST* be > 1 */
>>   			preempt_enable_no_resched();
>> +			sched_core_clear_rqcf_updated(rq);
>>   			return;
>>   		}
>>   		raw_spin_unlock(lock);
> 
> This still looks absolutely wrong. The whole RQCF thing is a pin action.

Do you think it is better for us to extend rq_pin_lock() to clean RQCF 
updated than to do it in raw_spin_rq_lock_nested()?

Before doing this, we need to solve the situation where rq_pin_lock() 
and raw_spin_rq_lock() are used separately.

Any suggestion will be very helpful for me.

Thanks,
Hao
