Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAB2605AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiJTJPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJTJO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:14:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD80D5418B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:14:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h12so19266354pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7bEdVoO6iKA82gh7oiXSW8DqEyQy0vmL2u3yanKLpw=;
        b=iuyQHA08E7qqElrjfrPUDifblqjBnS/svvbsgwxeM/8Rbm+KLcjKol0yqD8F402v+n
         d77OWIDNDO4nCkRD5x2CY+hRVbtN/b25smyJQilNXjJZNSRCIlPxI3szkjF2k7n/M0Kz
         fGf8DmojANrzaug1WRM+tMD717n0rEu830+L/6cLFJWiR8aKzm4XJ+a8nI8Dr8R7a3G3
         Q3ea1sN0n0Zsl4W5b0JX1p5LeJ8+CPCDwkUWwZnOFLs1t35Rokr3IFnri96HEdrzI1/0
         X5hEfj5u1IY/cqi2IWmjqvr1sO3QQwgO9IQ+pgtaIUkqmsECXVnWf+v4jeM8nItRors3
         eQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H7bEdVoO6iKA82gh7oiXSW8DqEyQy0vmL2u3yanKLpw=;
        b=4Us9gvpC9qnkBXN4OOcur4QYH14Y5BNbG9hmgoTkZua0JrY2byADpptwaLgBKlp/x1
         GRaOHRdp5kgp2fMaCQUTzNAIMybaqRNr2tF3zYcGJscqON1M224oTR7AcDsTZhe7Qbbq
         DNc0vs1qv+eciusVBYDqcXLP62g41kFXvzIQaNBlB6MdgoYo9AYY0wzJ9B2riy3Wm5tY
         FmnaUbxTmBC8+CpE1z2NJx2FlqJVVO/FBzVvJORr44c8LQWHEYppPzgVui1ie0xf7dbr
         iLE1R1u5jCR1GiwXBbHW9Lfjdib1fA8vDNt8tMRA1Yk4msRKbo4NXCY5NuzEk4vJBAeg
         z1hg==
X-Gm-Message-State: ACrzQf2AuphW5xKcjPxmxn3erdlqBZ4qQHsgn3pvNZUCsbc0yDQAl6/p
        C/TmZG06CQfBWvs9U1fDG9UJgIllqaG5RQ==
X-Google-Smtp-Source: AMsMyM5qME5Tmbt6ReTml+qRYKcEhkrknMJOS+E5qVwnv402hQIrNVmoYAA54eFkMgoDMpfhu7inkw==
X-Received: by 2002:a17:902:c40a:b0:185:51a2:233f with SMTP id k10-20020a170902c40a00b0018551a2233fmr12933490plk.25.1666257284326;
        Thu, 20 Oct 2022 02:14:44 -0700 (PDT)
Received: from [10.85.117.81] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b00177efb56475sm12142036plb.85.2022.10.20.02.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 02:14:43 -0700 (PDT)
Message-ID: <fedcc89c-6b61-343a-7b0b-f1924b3cf5fb@bytedance.com>
Date:   Thu, 20 Oct 2022 17:14:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [External] Re: [RESEND] sched/fair: Add min_ratio for cfs
 bandwidth_control
To:     Benjamin Segall <bsegall@google.com>
Cc:     linux-kernel@vger.kernel.org
References: <20221019031551.24312-1-zhouchuyi@bytedance.com>
 <xm26mt9rle93.fsf@google.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <xm26mt9rle93.fsf@google.com>
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



在 2022/10/20 05:01, Benjamin Segall 写道:
> Chuyi Zhou <zhouchuyi@bytedance.com> writes:
>
>> Tasks may be throttled when holding locks for a long time by current
>> cfs bandwidth control mechanism once users set a too small quota/period
>> ratio, which can result whole system get stuck[1].
>>
>> In order to prevent the above situation from happening, this patch adds
>> sysctl_sched_cfs_bandwidth_min_ratio in /proc/sys/kernel, which indicates
>> the minimum percentage of quota/period users can set. The default value is
>> zero and users can set quota and period without triggering this
>> constraint.
> 
> 
> There's so many other sorts of bad inputs that can get you stuck here
> that I'm not sure it's ever safe against lockups to provide direct write
> access to an untrusted user. I'm not totally opposed but it seems like
> an incomplete fix to a broken (non-default) configuration.
> 
> 
Thanks for your advice.
Chuyi Zhou
>>
>> Link[1]:https://lore.kernel.org/lkml/5987be34-b527-4ff5-a17d-5f6f0dc94d6d@huawei.com/T/
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   include/linux/sched/sysctl.h |  4 ++++
>>   kernel/sched/core.c          | 23 +++++++++++++++++++++++
>>   kernel/sysctl.c              | 10 ++++++++++
>>   3 files changed, 37 insertions(+)
>>
>> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
>> index 303ee7dd0c7e..dedb18648f0e 100644
>> --- a/include/linux/sched/sysctl.h
>> +++ b/include/linux/sched/sysctl.h
>> @@ -21,6 +21,10 @@ enum sched_tunable_scaling {
>>   	SCHED_TUNABLESCALING_END,
>>   };
>>   
>> +#ifdef CONFIG_CFS_BANDWIDTH
>> +extern unsigned int sysctl_sched_cfs_bandwidth_min_ratio;
>> +#endif
>> +
>>   #define NUMA_BALANCING_DISABLED		0x0
>>   #define NUMA_BALANCING_NORMAL		0x1
>>   #define NUMA_BALANCING_MEMORY_TIERING	0x2
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 5800b0623ff3..8f6cfd889e37 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -10504,6 +10504,12 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
>>   }
>>   
>>   #ifdef CONFIG_CFS_BANDWIDTH
>> +/*
>> + * The minimum of quota/period ratio users can set, default is zero and users can set
>> + * quota and period without triggering this constraint.
>> + */
>> +unsigned int sysctl_sched_cfs_bandwidth_min_ratio;
>> +
>>   static DEFINE_MUTEX(cfs_constraints_mutex);
>>   
>>   const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
>> @@ -10513,6 +10519,20 @@ static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
>>   
>>   static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
>>   
>> +static int check_cfs_bandwidth_min_ratio(u64 period, u64 quota)
>> +{
>> +	u64 ratio;
>> +
>> +	if (!sysctl_sched_cfs_bandwidth_min_ratio)
>> +		return 0;
>> +
>> +	ratio = div64_u64(quota * 100, period);
>> +	if (ratio < sysctl_sched_cfs_bandwidth_min_ratio)
>> +		return -1;
>> +
>> +	return 0;
>> +}
>> +
>>   static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>>   				u64 burst)
>>   {
>> @@ -10548,6 +10568,9 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>>   				     burst + quota > max_cfs_runtime))
>>   		return -EINVAL;
>>   
>> +	if (quota != RUNTIME_INF && check_cfs_bandwidth_min_ratio(period, quota))
>> +		return -EINVAL;
>> +
>>   	/*
>>   	 * Prevent race between setting of cfs_rq->runtime_enabled and
>>   	 * unthrottle_offline_cfs_rqs().
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 188c305aeb8b..7d9743e8e514 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -1652,6 +1652,16 @@ static struct ctl_table kern_table[] = {
>>   		.extra1		= SYSCTL_ZERO,
>>   	},
>>   #endif /* CONFIG_NUMA_BALANCING */
>> +#ifdef CONFIG_CFS_BANDWIDTH
>> +	{
>> +		.procname	= "sched_cfs_bandwidth_min_ratio",
>> +		.data		= &sysctl_sched_cfs_bandwidth_min_ratio,
>> +		.maxlen		= sizeof(unsigned int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +	},
>> +#endif /* CONFIG_CFS_BANDWIDTH */
>>   	{
>>   		.procname	= "panic",
>>   		.data		= &panic_timeout,
