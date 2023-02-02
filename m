Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F095A6889DC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjBBWfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjBBWfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:35:42 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D7569B0F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:35:41 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so10374459ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 14:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5KWg5y49R2vNdnwv3VPU/YYr23YbKuqRtcEwTW8lnU=;
        b=faXd1jvBVV8qaSefQLmDyUjuLWCiiCySIAhofQhhZwqCmH2I3/KUFXigCG3p2PwOGp
         OU+qvDEpVE0N8zjwb1o97mNvLaeWHLcwswrcQcVSaMw4td6IWgt8rPjx9x6DyGDKHsWC
         sHvwHxzMIqu6ITHklysS+xe1Q45B7XpfolZcP1M9++kFJaW5kBlDZh76EcAVTPDPCCsO
         nk43n0Y6rKyCJPa6EA7TyJcQ0FdffY989Gy2QhKugW+njQRGHVAQ9pcOx1zq+jsB/299
         1YFQZ6AJNfxPvNcTpX9yfcucEB1dHOHEqgQ46iw5hzPwD3eqr2S8x3e0+9M9ZipyrFz1
         vWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5KWg5y49R2vNdnwv3VPU/YYr23YbKuqRtcEwTW8lnU=;
        b=GqTckDv1e+upBohPwpVtQ7PPOFenPLnMppVgqE7nCvWd3J/47jrcnVLB2IEdNWQ35U
         RC6UjGIrR2MntoYOsgVl4wxPHO6//7sBC9ZtPOb7JRaDLmVUfiyjSpMdKQHggcgbFb6g
         yngXcLBDX2sV6a2lqkuR1uLyHqacZk3gKq1hErmjw57fYW3WPKewnSt14iogs29sHvWh
         cotA/ovPiEMeUYSJD1WEHE+cj3IGXgaDngRri3dBy2MPZ5I2LC6up3icopMd8M8+yjIl
         vNTftsTsaWbwqLM1wtaF3yMl5On50fByf6BwYp411bSwg2vr5Rl8FnVhibuu5IEcriCm
         ucGg==
X-Gm-Message-State: AO0yUKXwpzc5IljZ9fSAC3buzTKzM4GX8TsrOaS6xONV+ygL/2PhWwNZ
        moffANvIpNEgNMW32C/wgLuikQ==
X-Google-Smtp-Source: AK7set82YGgN8WEkYacPEvPUc5oB/aKlORz10ksuFOaSSDoBCOzsMGJK3ak/e39EFz2f3k9B2dI3xg==
X-Received: by 2002:a17:907:1607:b0:88a:8e57:f05b with SMTP id hb7-20020a170907160700b0088a8e57f05bmr10486582ejc.22.1675377339474;
        Thu, 02 Feb 2023 14:35:39 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id gz22-20020a170906f2d600b0088f88d1d36bsm395490ejb.166.2023.02.02.14.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 14:35:39 -0800 (PST)
Message-ID: <7968db3b-8545-0601-4302-301a4006f3bc@linaro.org>
Date:   Thu, 2 Feb 2023 23:35:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] cpufreq: qcom-hw: Fix cpufreq_driver->get() for non-LMH
 systems
Content-Language: en-US
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230202140005.1.I4b30aaa027c73372ec4068cc0f0dc665af8b938d@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.02.2023 23:00, Douglas Anderson wrote:
> On a sc7180-based Chromebook, when I go to
> /sys/devices/system/cpu/cpu0/cpufreq I can see:
> 
>   cpuinfo_cur_freq:2995200
>   cpuinfo_max_freq:1804800
>   scaling_available_frequencies:300000 576000 ... 1708800 1804800
>   scaling_cur_freq:1804800
>   scaling_max_freq:1804800
> 
> As you can see the `cpuinfo_cur_freq` is bogus. It turns out that this
> bogus info started showing up as of commit 205f5e984d30 ("cpufreq:
> qcom-hw: Fix the frequency returned by cpufreq_driver->get()"). That
> commit seems to assume that everyone is on the LMH bandwagon, but
> sc7180 isn't.
> 
> Let's go back to the old code in the case where LMH isn't used.
> 
> Fixes: 205f5e984d30 ("cpufreq: qcom-hw: Fix the frequency returned by cpufreq_driver->get()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
Actually I hit the exact same issue when working on CPRh-aware
cpufreq with manual OSM programming.. LMh gets enabled by the firmware
on most recent platforms, but it's not the case for some old-timers.

I figured that adding a bool broken_lmh_freq in driver data would be
a good middleground between reverting that patch and ignoring the
issue, because it *does* matter what this function reports on LMh-
enabled platforms (yes, the subsystems are bluepilled between each
other and OSM/EPSS does not know the *real* throttled frequency),
but obviously we don't want to report 2.99Ghz otherwise..

I think 7280 had an issue where a SoC-specific compatible was not
introduced when the DT part was first merged, same goes for 6115.
6115 does have firmware-enabled LMh, not sure about 7280. In case
you wanted to go that route, I think it would be suitable to add
a blacklist of retroactively-broken platforms (match-by-machine-
compatible; don't scream at me bindings folks, I guess that's the
least messy solution) in addition to either matching the SoC-specific
compatible to epss_broken_lmh_driver_data.

Or we can forget about old DTs and just bind qcom,sc7180-cpufreq-hw
(and 7280, maybe? please check.) to this new driver data without
checking the machine compatible.



Konrad
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 9505a812d6a1..957cf6bb8c05 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -143,40 +143,42 @@ static unsigned long qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
>  	return lval * xo_rate;
>  }
>  
> -/* Get the current frequency of the CPU (after throttling) */
> -static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> +/* Get the frequency requested by the cpufreq core for the CPU */
> +static unsigned int qcom_cpufreq_get_freq(unsigned int cpu)
>  {
>  	struct qcom_cpufreq_data *data;
> +	const struct qcom_cpufreq_soc_data *soc_data;
>  	struct cpufreq_policy *policy;
> +	unsigned int index;
>  
>  	policy = cpufreq_cpu_get_raw(cpu);
>  	if (!policy)
>  		return 0;
>  
>  	data = policy->driver_data;
> +	soc_data = qcom_cpufreq.soc_data;
>  
> -	return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
> +	index = readl_relaxed(data->base + soc_data->reg_perf_state);
> +	index = min(index, LUT_MAX_ENTRIES - 1);
> +
> +	return policy->freq_table[index].frequency;
>  }
>  
> -/* Get the frequency requested by the cpufreq core for the CPU */
> -static unsigned int qcom_cpufreq_get_freq(unsigned int cpu)
> +static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>  {
>  	struct qcom_cpufreq_data *data;
> -	const struct qcom_cpufreq_soc_data *soc_data;
>  	struct cpufreq_policy *policy;
> -	unsigned int index;
>  
>  	policy = cpufreq_cpu_get_raw(cpu);
>  	if (!policy)
>  		return 0;
>  
>  	data = policy->driver_data;
> -	soc_data = qcom_cpufreq.soc_data;
>  
> -	index = readl_relaxed(data->base + soc_data->reg_perf_state);
> -	index = min(index, LUT_MAX_ENTRIES - 1);
> +	if (data->throttle_irq >= 0)
> +		return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
>  
> -	return policy->freq_table[index].frequency;
> +	return qcom_cpufreq_get_freq(cpu);
>  }
>  
>  static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
