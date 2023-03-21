Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC66C2EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCUKZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjCUKYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:24:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B941554F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:24:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x3so57545407edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679394287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IojLlT21b+GTCHUtZS1AK6pqmw384n2x7uObuVhtqoc=;
        b=UKXfMgENBu09lAoUSD7nvesPp0S9T1AzoiAdAZHyKn0WHgV3DqQ4FU8TJ10FzPwKXm
         8D4JVetj2hzKVtpPDJK7+hkKLlUWAFNFXGfGSMAStSZABMIEUNHo/+TUqItMgDPM5uFl
         hYLBeuTdHDlesRIrQL3alAhd6tijHEAxfDlvR+Pxe1QeJWkO9ExTUFCwXmfiL3vctEp/
         qvj0W60irEm66vsi+17rc6DbP0XkD0f9x1pM3YLvPCoSx8SwELSOhJIqjHJG1UR/UOJ+
         rTqNl5BG/aMw8NiBkYU0dVnQ1GZQ3wxpB0xNyg9a8nvj0cHsuMUf0Wz4uKsmXHxisRBg
         S3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679394287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IojLlT21b+GTCHUtZS1AK6pqmw384n2x7uObuVhtqoc=;
        b=7SGQQzgEBbuWB+aQ5a3Sseti/t4jc5Gyf3lp9pWv1gS/RmMJM30ewH6LgoAHe+KelR
         SsZMarG/iYKTeeamRZ2BOiHY28vOE/aTmD6xiPN5ig+zMYn+mTE+++uHLVEyWm6QMYDT
         IdMfKason+8nZ7kPGexR+MQCASBEdm4qzQaOroRVvUzTWkDl0++6U5HvoKPdMMOzbFp2
         tl44WI9ANixTUWoewbZArqudpIjhJuqi1QCPD7SoaM4KDE9CVuEOsnFJmwuBgDM7zzIm
         3wZu8iIVfWytJexOpzNjMwT0mZ5Po+65IVICNsuyGxArEwBSBcKbtrSX4i0weC/3MzJW
         S6oQ==
X-Gm-Message-State: AO0yUKVC6IuymmIHFjsOdYT6bxrjy9eboSX9FpCZVpzstxEYzfYl1gL2
        ZCUwOTHyoKxgZica2bIDKf7Ac+mqedzqcMuc1x0=
X-Google-Smtp-Source: AK7set+Re3gHO4/eHWbeE7YoEV3C+eK0AvkdSnJPHMcJRgk8nhROk37jPOCG3x6x2FoLieODZrSWQw==
X-Received: by 2002:a17:906:30d2:b0:8ab:4c4:d0f6 with SMTP id b18-20020a17090630d200b008ab04c4d0f6mr2023868ejb.56.1679394287704;
        Tue, 21 Mar 2023 03:24:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id ia9-20020a170907a06900b00932b3e2c015sm4696908ejc.51.2023.03.21.03.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 03:24:47 -0700 (PDT)
Message-ID: <ba547675-59f2-84a9-82f3-93f6cb131799@linaro.org>
Date:   Tue, 21 Mar 2023 11:24:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] cpufreq: qcom-cpufreq-hw: allow work to be done on
 other CPU for PREEMPT_RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20230315164910.302265-1-krzysztof.kozlowski@linaro.org>
 <20230321100456.0_DhhkZJ@linutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230321100456.0_DhhkZJ@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 11:04, Sebastian Andrzej Siewior wrote:
> On 2023-03-15 17:49:10 [+0100], Krzysztof Kozlowski wrote:
>> Qualcomm cpufreq driver configures interrupts with affinity to each
>> cluster, e.g.  dcvsh-irq-0, dcvsh-irq-4 and dcvsh-irq-7 on SM8250.
>> Triggered interrupt will schedule delayed work, but, since workqueue
>> prefers local CPUs, it might get executed on a CPU dedicated to realtime
>> tasks causing unexpected latencies in realtime workload.
>>
>> Use unbound workqueue for such case.  This might come with performance
>> or energy penalty, e.g. because of cache miss or when other CPU is
>> sleeping.
> 
> I miss the point where it explains that only PREEMPT_RT is affected by
> this.

I assume "realtime tasks" implies this, but I can make it clearer.

> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/cpufreq/qcom-cpufreq-hw.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index 2f581d2d617d..c5ff8d25fabb 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -390,7 +390,16 @@ static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
>>  
>>  	/* Disable interrupt and enable polling */
>>  	disable_irq_nosync(c_data->throttle_irq);
>> -	schedule_delayed_work(&c_data->throttle_work, 0);
>> +
>> +	/*
>> +	 * Workqueue prefers local CPUs and since interrupts have set affinity,
>> +	 * the work might execute on a CPU dedicated to realtime tasks.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>> +		queue_delayed_work_on(WORK_CPU_UNBOUND, system_unbound_wq,
>> +				      &c_data->throttle_work, 0);
>> +	else
>> +		schedule_delayed_work(&c_data->throttle_work, 0);
> 
> You isolated CPUs and use this on PREEMPT_RT. And this special use-case
> is your reasoning to make this change and let it depend on PREEMPT_RT?
> 
> If you do PREEMPT_RT and you care about latency I would argue that you
> either disable cpufreq and set it to PERFORMANCE so that the highest
> available frequency is set once and not changed afterwards.

The cpufreq is set to performance. It will be changed anyway because
underlying FW notifies through such interrupts about thermal mitigation
happening.

The only other solution is to disable the cpufreq device, e.g. by not
compiling it.

Best regards,
Krzysztof

