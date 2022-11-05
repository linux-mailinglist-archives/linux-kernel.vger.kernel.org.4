Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF261A6A9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 02:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiKEBea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKEBeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:34:23 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6543FB94
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 18:34:22 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v3so5795447pgh.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 18:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lm2cGB4yv4phB1my5jndlJYdQlCU46QGT34IUFRPFc8=;
        b=5aGMTb+4e/xA3PeMPp86AQ7MhIwo3gNLrie4GPh63jaLM7vVO8eu3Y42lajsb3QnC6
         FmhghOLEjtt5aKD1xS7VO6Lkku5y0bSTWohRKHp6ADf9bfVCvb8yvisEbBy7u5K1eVqE
         CDPCoJEbCmIF4+ek2t3qIKdoznOh2UfaGYRXOCTDL9CUrILxWfmrihTUoDq6ptUetxAi
         0eYMfkA+KIFr6h6yH73JPN5OJHuUoPwxzWTIMVUtPocfo6yakLtPxcopURgIhhGUzmGt
         +HXj/4EzOLcNZv0+aDrRTHHKtSOSThD39pGK2WVvqFbcFT4bThwckZdS+s6bg1gE042+
         mt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lm2cGB4yv4phB1my5jndlJYdQlCU46QGT34IUFRPFc8=;
        b=4PML2XOcYuOAwY+mrsa7pqdCVvxP5e1EwdWsRvaMU+gXlmf433rlyAcPuPSIPN4zZ9
         /MlVTEalWxImN4caOmHX1/Fem/yg53/HnNGjRYMhmnszs/B1+UZiYamuYveQimpeVxQ5
         yKHg8l90Y1Y6UP0zBvNd+Em5/I6P9BT7cThbXeu/oGZ5xLcj2CaitzT8GDJqC7T1xEW7
         wj3486f/OwAxsnUbDN4gPEO0zVDPZWHE/ZUOydfxtYCLrgHfaNQXu9Uoj5G4PQ0OSRb6
         eHaoQu8jnQ+65pt9A3iCbqQYM/PSXCt+btcgVHkmF9hi3FAwbrNX1+punsEmlWBeiknJ
         Y+hg==
X-Gm-Message-State: ACrzQf0gW1nhLzU5hUOhyHNu/WC9UEKVdbK3LUlDB67iZczJbbm4ZnmH
        AVg7fbtRFqB5lkUMCAkK9h1cnQ==
X-Google-Smtp-Source: AMsMyM7oAo95681gHIxKu25XBTm7u+cXKTt+V78ykyV1EEdWAdDKO+S3L8ezv6vwFWgQZSLfrhA9FA==
X-Received: by 2002:a63:6942:0:b0:41c:9261:54fd with SMTP id e63-20020a636942000000b0041c926154fdmr18756125pgc.34.1667612061792;
        Fri, 04 Nov 2022 18:34:21 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e67:5470:e94d:a48f:ab46:516b? ([2409:8a28:e67:5470:e94d:a48f:ab46:516b])
        by smtp.gmail.com with ESMTPSA id f14-20020a63100e000000b0041ae78c3493sm326073pgl.52.2022.11.04.18.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 18:34:21 -0700 (PDT)
Message-ID: <7b8bd69a-39cb-a1f0-6ccd-7b0810ef0db7@bytedance.com>
Date:   Sat, 5 Nov 2022 09:34:06 +0800
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
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <xhsmhr0yivazl.mognet@vschneid.remote.csb>
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

On 2022/11/5 02:19, Valentin Schneider wrote:
> On 02/11/22 18:23, Chengming Zhou wrote:
>> ttwu_runnable() is used as a fast wakeup path when the wakee task
>> is between set_current_state() and schedule(), in which case all
>> we need to do is change p->state back to TASK_RUNNING. So we don't
>> need to update_rq_clock() and check_preempt_curr() in this case.
>>
>> Some performance numbers using mmtests/perfpipe on Intel Xeon server:
>>
>>                            linux-next                patched
>> Min       Time        8.67 (   0.00%)        8.66 (   0.13%)
>> 1st-qrtle Time        8.83 (   0.00%)        8.72 (   1.19%)
>> 2nd-qrtle Time        8.90 (   0.00%)        8.76 (   1.57%)
>> 3rd-qrtle Time        8.98 (   0.00%)        8.82 (   1.82%)
>> Max-1     Time        8.67 (   0.00%)        8.66 (   0.13%)
>> Max-5     Time        8.67 (   0.00%)        8.66 (   0.13%)
>> Max-10    Time        8.79 (   0.00%)        8.69 (   1.09%)
>> Max-90    Time        9.01 (   0.00%)        8.84 (   1.94%)
>> Max-95    Time        9.02 (   0.00%)        8.85 (   1.86%)
>> Max-99    Time        9.02 (   0.00%)        8.88 (   1.56%)
>> Max       Time        9.59 (   0.00%)        8.89 (   7.29%)
>> Amean     Time        8.92 (   0.00%)        8.77 *   1.65%*
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  kernel/sched/core.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 87c9cdf37a26..3785418de127 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3718,9 +3718,8 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>>
>>       rq = __task_rq_lock(p, &rf);
>>       if (task_on_rq_queued(p)) {
>> -		/* check_preempt_curr() may use rq clock */
>> -		update_rq_clock(rq);
>> -		ttwu_do_wakeup(rq, p, wake_flags, &rf);
>> +		WRITE_ONCE(p->__state, TASK_RUNNING);
>> +		trace_sched_wakeup(p);
> 
> This also loses the class->task_woken() call, AFAICT we could have
> !p->on_cpu here (e.g. an IRQ hit before the task got to schedule()), but
> then again if there is a need to push we should have done that at the IRQ
> preempt via set_next_task_{rt, dl}()... So I'm starting to think this is
> OK, but that needs elaborating in the changelog.

Sorry, I don't get why we could have !p->on_cpu here?

I thought if we have task_on_rq_queued(p) here, it means p hasn't got to
__schedule() to deactivate_task(), so p should still be on_cpu?

Thanks.

> 
> 
>>               ret = 1;
>>       }
>>       __task_rq_unlock(rq, &rf);
>> --
>> 2.37.2
> 
