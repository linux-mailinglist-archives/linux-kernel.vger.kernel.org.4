Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8716889FA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjBBWpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjBBWpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:45:42 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071F16A315
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:45:36 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id lu11so10470477ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 14:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yv+EBHuwHRJqAJbrlM2T5g6XZ+NYEb35c1jHq1XFpd8=;
        b=DdKMwjtuuSPaZBdeG3xXuH/Vf6SecI9XZEr5bt0Spw83Pcj1Owzs7iX7s7BxsTmGMI
         UZPTM/26GVxWvF202KSMVKHVxikMtw76xWAz+EcqEY648xsII+uwn0fWLtPJsYwF469t
         BEYQsYcVHAKo57ThA27P8arJkjC8r9XxBZcDQ66TXgNBVS0AEI3K8psL6XBcPV2pIFT+
         Ym2Z7iWu2jCunXWVN2qNBHMIunlon+8zbPUaSmKgUQOEKpmZR0L3f7U8Ctzc9esEDb/R
         y5N114iwBcXGscpRLDTwcRH41E7dCdLk/SVfljai0oEw8iBnbOk+FNY0Xx/yLIT/oqSI
         DHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv+EBHuwHRJqAJbrlM2T5g6XZ+NYEb35c1jHq1XFpd8=;
        b=f4waT3BOD27S6R7mgd7SbY6Ixco3ZKrmm6lKM5hQtG1CqNquklV0WGAZroMDm+fmcY
         oaWqBu40gJe1d0VOCgmzYsBl7f+4cAu+KMb99qn6ZXQpLoIlVh9+A2Av7TVBI3g8r1CM
         wdcc6UJvUJBfZztYDo9Y5GlqYCW7Xf7EZ85RquiGk8tp0u5WNCxzaKGzA5F2HFOVzJhB
         5eLanfYM9R+3ntI4QViV/2fyEnu1hHVQHnHWGnVl2QLqsK/Vv4oZ9ozXQhRj3Z+6d5tW
         Mg/cGiVrXREwEiLncfUrhROEi5ig81wm/WOylBNfaDhPlN9wZ1zK7YYrlqI0qadFofz9
         FRPA==
X-Gm-Message-State: AO0yUKXyZU93NN6oAsCE9qeuE4QTRWfOc3pUvoD7mjAddDqPoM7LKsVc
        mTPa/6mErXn/vj9ePbJLr5Pmcg==
X-Google-Smtp-Source: AK7set/R40EN2B7UrrceJs69WdSfiP2XjBzXCmGzAwIbF5ySDgMVbLqAPHFDkcmqb/TXIIugK9+DOg==
X-Received: by 2002:a17:906:6a24:b0:86d:7c2d:f65b with SMTP id qw36-20020a1709066a2400b0086d7c2df65bmr10810332ejc.27.1675377935184;
        Thu, 02 Feb 2023 14:45:35 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id k7-20020a170906158700b0088385cd6166sm401506ejd.195.2023.02.02.14.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 14:45:34 -0800 (PST)
Message-ID: <df4da23b-d589-7353-65b0-bedbd6c31412@linaro.org>
Date:   Thu, 2 Feb 2023 23:45:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] cpufreq: qcom-hw: Fix cpufreq_driver->get() for non-LMH
 systems
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     swboyd@chromium.org, mka@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230202140005.1.I4b30aaa027c73372ec4068cc0f0dc665af8b938d@changeid>
 <7968db3b-8545-0601-4302-301a4006f3bc@linaro.org>
In-Reply-To: <7968db3b-8545-0601-4302-301a4006f3bc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.02.2023 23:35, Konrad Dybcio wrote:
> 
> 
> On 2.02.2023 23:00, Douglas Anderson wrote:
>> On a sc7180-based Chromebook, when I go to
>> /sys/devices/system/cpu/cpu0/cpufreq I can see:
>>
>>   cpuinfo_cur_freq:2995200
>>   cpuinfo_max_freq:1804800
>>   scaling_available_frequencies:300000 576000 ... 1708800 1804800
>>   scaling_cur_freq:1804800
>>   scaling_max_freq:1804800
>>
>> As you can see the `cpuinfo_cur_freq` is bogus. It turns out that this
>> bogus info started showing up as of commit 205f5e984d30 ("cpufreq:
>> qcom-hw: Fix the frequency returned by cpufreq_driver->get()"). That
>> commit seems to assume that everyone is on the LMH bandwagon, but
>> sc7180 isn't.
>>
>> Let's go back to the old code in the case where LMH isn't used.
>>
>> Fixes: 205f5e984d30 ("cpufreq: qcom-hw: Fix the frequency returned by cpufreq_driver->get()")
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
> Actually I hit the exact same issue when working on CPRh-aware
> cpufreq with manual OSM programming.. LMh gets enabled by the firmware
> on most recent platforms, but it's not the case for some old-timers.
> 
Ignore this email, I can't read.

Konrad
> I figured that adding a bool broken_lmh_freq in driver data would be
> a good middleground between reverting that patch and ignoring the
> issue, because it *does* matter what this function reports on LMh-
> enabled platforms (yes, the subsystems are bluepilled between each
> other and OSM/EPSS does not know the *real* throttled frequency),
> but obviously we don't want to report 2.99Ghz otherwise..
> 
> I think 7280 had an issue where a SoC-specific compatible was not
> introduced when the DT part was first merged, same goes for 6115.
> 6115 does have firmware-enabled LMh, not sure about 7280. In case
> you wanted to go that route, I think it would be suitable to add
> a blacklist of retroactively-broken platforms (match-by-machine-
> compatible; don't scream at me bindings folks, I guess that's the
> least messy solution) in addition to either matching the SoC-specific
> compatible to epss_broken_lmh_driver_data.
> 
> Or we can forget about old DTs and just bind qcom,sc7180-cpufreq-hw
> (and 7280, maybe? please check.) to this new driver data without
> checking the machine compatible.
> 
> 
> 
> Konrad
>>
>>  drivers/cpufreq/qcom-cpufreq-hw.c | 24 +++++++++++++-----------
>>  1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index 9505a812d6a1..957cf6bb8c05 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -143,40 +143,42 @@ static unsigned long qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
>>  	return lval * xo_rate;
>>  }
>>  
>> -/* Get the current frequency of the CPU (after throttling) */
>> -static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>> +/* Get the frequency requested by the cpufreq core for the CPU */
>> +static unsigned int qcom_cpufreq_get_freq(unsigned int cpu)
>>  {
>>  	struct qcom_cpufreq_data *data;
>> +	const struct qcom_cpufreq_soc_data *soc_data;
>>  	struct cpufreq_policy *policy;
>> +	unsigned int index;
>>  
>>  	policy = cpufreq_cpu_get_raw(cpu);
>>  	if (!policy)
>>  		return 0;
>>  
>>  	data = policy->driver_data;
>> +	soc_data = qcom_cpufreq.soc_data;
>>  
>> -	return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
>> +	index = readl_relaxed(data->base + soc_data->reg_perf_state);
>> +	index = min(index, LUT_MAX_ENTRIES - 1);
>> +
>> +	return policy->freq_table[index].frequency;
>>  }
>>  
>> -/* Get the frequency requested by the cpufreq core for the CPU */
>> -static unsigned int qcom_cpufreq_get_freq(unsigned int cpu)
>> +static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>>  {
>>  	struct qcom_cpufreq_data *data;
>> -	const struct qcom_cpufreq_soc_data *soc_data;
>>  	struct cpufreq_policy *policy;
>> -	unsigned int index;
>>  
>>  	policy = cpufreq_cpu_get_raw(cpu);
>>  	if (!policy)
>>  		return 0;
>>  
>>  	data = policy->driver_data;
>> -	soc_data = qcom_cpufreq.soc_data;
>>  
>> -	index = readl_relaxed(data->base + soc_data->reg_perf_state);
>> -	index = min(index, LUT_MAX_ENTRIES - 1);
>> +	if (data->throttle_irq >= 0)
>> +		return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
>>  
>> -	return policy->freq_table[index].frequency;
>> +	return qcom_cpufreq_get_freq(cpu);
>>  }
>>  
>>  static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
