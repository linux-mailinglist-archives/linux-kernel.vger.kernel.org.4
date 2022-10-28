Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E274E61091A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiJ1D6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbiJ1D5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:57:50 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D25D57E8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 20:57:49 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f9so3767650pgj.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 20:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJnDODp9nrsY8O14H4fiETvFtrmNa+NjbJOgCCnAd7I=;
        b=EjRvC08krxthWC/7+Wi58igQece9yaX+Z2Yo1tD36GPKckmk8zqECNyWxR+65rrCDn
         6kL07F5C8ny8Fb4L1+qwnPFFI1kMf5C0sYFcjAmqDtjp8hlkrPJ4DPG+THAK7I58RTIz
         2Hef/Wm/x/0VE2/A0K/JYGnetgloc6Y+7nW6jmj3vs7dKeb159zWqhXcVhTfLl7RtvLN
         bByV2Z/iER2E5LKXMwFpRnY8erlx/ZoHS5l6cxfPKyaeOA8EBRlnTnJfzaSu4AOiLnqm
         y7QrfQlADlzs0VBE0k54fve3WIhgJpbSnJTtVp8aOlymURMK53uxruqoZqEt8PyFxGGf
         GK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RJnDODp9nrsY8O14H4fiETvFtrmNa+NjbJOgCCnAd7I=;
        b=YVBBJAtLgD0eniAHM19RBel6SJ6KE3hNJr+1QTVGuv4F10UeF0gJGslj6Ska2dAXiM
         t3TyNcsF3f5zhYldOspJiQ41lMz4ifmhSj82l1BJyHbSKVvSTNJ8HNZxF4sMeYJBhaV0
         kASHwKbp9ZpM+uq4k5khPPJo2h7nfAmD3yIa95SYuZCAGv5s/Q85A+XMR2BGuZgxH9/d
         Rq5jn6xpHOT6CFVKGlekyrIzx/+EjQIT8MFkhtzle5RjyDPZ9nO2IoiSBrKd7WMgmpU3
         2kJ+LrBp5sh0puU9HiGTEfyFLTsLS27pGzuR4lS15oG+JzX9coDFM+QMbVWmlb/SSJeE
         d4sQ==
X-Gm-Message-State: ACrzQf2/DGP+trOoJ73fO3o0j0VAxDo2PkTCAkBsVq+tsGv2K77SDjrH
        eyYhObGIM7L8G0Z4k/Zst2S9EnxAMDpYRw==
X-Google-Smtp-Source: AMsMyM7F3+OkMIjCFDS6cDYBnKUeG/TWqinO2Z2F3UqBiZx5NVLwWKPFI+AGB1c0Tc0AeXJt+eJQcw==
X-Received: by 2002:a65:6ccd:0:b0:439:2033:6ee with SMTP id g13-20020a656ccd000000b00439203306eemr45836543pgw.271.1666929469341;
        Thu, 27 Oct 2022 20:57:49 -0700 (PDT)
Received: from [10.85.117.81] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id x7-20020aa79567000000b00528a097aeffsm1882966pfq.118.2022.10.27.20.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 20:57:49 -0700 (PDT)
Message-ID: <64d963b6-2d9c-3f93-d427-a1ff705fb65a@bytedance.com>
Date:   Fri, 28 Oct 2022 11:57:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [PATCH] sched/fair: favor non-idle group in tick preemption
To:     Josh Don <joshdon@google.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
References: <20221027081630.34081-1-zhouchuyi@bytedance.com>
 <CABk29NtDny9qKZbZZ_i8Brwjtqs5GA0G4_SffzK4HzG3RrXVhQ@mail.gmail.com>
In-Reply-To: <CABk29NtDny9qKZbZZ_i8Brwjtqs5GA0G4_SffzK4HzG3RrXVhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/28 07:34, Josh Don 写道:
> Hi Chuyi,
> 
> On Thu, Oct 27, 2022 at 1:16 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> The non-idle se dominates competition vs the idle se when they
>> are belong to the same group. We ensure that idle groups would not
>> preempt non-idle group in wakeup preemption(see check_preempt_wakeup()).
>> However, this can happen in tick preemption, since check_preempt_tick()
>> dose not check current/se is idle or not. This patch adds this check.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   kernel/sched/fair.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e4a0b8bd941c..f3324b8753b3 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4750,6 +4750,7 @@ static void
>>   check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>   {
>>          unsigned long ideal_runtime, delta_exec;
>> +       int cse_is_idle, pse_is_idle;
>>          struct sched_entity *se;
>>          s64 delta;
>>
>> @@ -4779,8 +4780,17 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>          if (delta < 0)
>>                  return;
>>
>> -       if (delta > ideal_runtime)
>> +       if (delta > ideal_runtime) {
>> +               /*
>> +                * Favor non-idle group even in tick preemption
>> +                */
>> +               cse_is_idle = se_is_idle(curr);
>> +               pse_is_idle = se_is_idle(se);
>> +               if (unlikely(!cse_is_idle && pse_is_idle))
>> +                       return;
> 
Hi Josh, thanks for your reply,
> This would make it so that we never have tick based preemption of a
> non-idle entity by an idle entity. That's a recipe for starvation of
> the idle entity, if the non-idle entity is cpu bound.
> 
> Beyond that though, I'm not quite sure the issue being solved here.
> The large difference in weight between the idle and non-idle entity
> means that the non-idle entity will not be preempted for quite a while
> due to its ideal_runtime being quite high. The idle entity will
> quickly be preempted on the next tick it takes due to the smaller
> value of sysctl_sched_idle_min_granularity.
> 
Actually, I did some tests and traced this issue. the result shows that 
this can happen with small probability. I also do some benchmarks. The 
result seems it has no performance harm, and we can reduce 2%～3% 
context switch when idle group & non-idle group are present at the same 
time. In addition, for throughput concern, I think we better let 
non-idle entity consume it's ideal_runtime. However, as you said, it may 
cause starvation of the idle entity.....

There is another question I would like to take this opportunity to 
consult you. In our production environment, in some cases, we want to 
adjust the weight/shares of the idle-cgroup which means we need to 
change the logic of sched_group_set_shares(), and it can increase the 
probability of the above issue. So, for what reasons did you prohibit 
users from changing weights of idle cgroup.

Thanks again for your review.

Best,
Chuyi
> The wakeup check is useful for latency sensitive non-idle tasks.
> However, in steady state competition between idle and non-idle, we
> must allow some amount of round-robin.
> 
>> +
>>                  resched_curr(rq_of(cfs_rq));
>> +       }
>>   }
>>
>>   static void
>> --
>> 2.20.1
>>
> 
> Best,
> Josh
