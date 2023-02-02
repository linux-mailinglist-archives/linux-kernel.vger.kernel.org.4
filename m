Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B863C688AEB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjBBXjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjBBXjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:39:00 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C195CFD0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:38:58 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so10770844ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 15:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vn4PQtcHeiNXiYDIa1iNQ6Auk9PT6RoWaXhg2pdbr5A=;
        b=L396GH6MkAGCgAqw8JbfIVAxC58XO9h1DjYHO0bnAcvYww1P1+Hcv7pq9D3i4GPe4F
         90XKu3hvQ9//QbvEb5PvzxwsmwCk91U+yxoZL8totIlYDZaVG1OiCgjXGDoNqInH4d+q
         zLJvvrZsesXxKYnIRloPhnanv8PyYsJdA7hMNdusZcx8kT57YKDedbBQHYJvFkQy4/Nr
         nHj3TLBSOiS4jO4vtyw+2KrXc/sXjjivd6luMl0J2J9epPMpsw6xsCN0Xc7gY3ho1gIU
         GMChvQnL3PP9jRGcTLN332DQZDAzXEqZStWJg+R8SVhTpIjHJlHpjkbn9DM1ZXH3HTmp
         rjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn4PQtcHeiNXiYDIa1iNQ6Auk9PT6RoWaXhg2pdbr5A=;
        b=KtiVeYCLd0wl1wjj5sGXsSStUQlDHF4vhkOX+dFZzEdTbFWIp3Yu5YgvQID/qmWMvd
         xDeXvoDMYNF5ZlpDTD1aztcDFRt7IE93aGF7XbKLnODP0welxm6fTBiMf1c3sbIitylL
         7UdrFnE2LOspQLcBhdHHpHFmU4Gkybd8OzMgRhi02ivLtm8/h1I9iCjl4EGUMMnNF1Ui
         G45RqSMw69R04+49PyT57pCVWR/g39zMSLs9v5z2qM6wEpIT7U+exioeez7IQadXAfJJ
         4jIKCAqvB1zfcrA6+XjBg2P8vu7C1y4kSEOKvXgbPuvW/Kh47xJM1Ik8L698MtoKgx1Y
         4U6w==
X-Gm-Message-State: AO0yUKVq45cUqnXfQWusK3H71GvuPbuWChRBqd9Q5HueTCXDzh8YKnqw
        vQ5/YUJBOEST3cTNV0p8eVEjuA==
X-Google-Smtp-Source: AK7set8LnSv/lCQamnPesVGE2x8Z7Qk617GP4KCKtgP+mXB1g/Ij9HnphFIl78XYCc6xXvAlw7F4Kg==
X-Received: by 2002:a17:907:8d15:b0:88f:5676:52c8 with SMTP id tc21-20020a1709078d1500b0088f567652c8mr4026181ejc.74.1675381136875;
        Thu, 02 Feb 2023 15:38:56 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id bk21-20020a170906b0d500b0087873afb1b4sm481047ejb.41.2023.02.02.15.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 15:38:56 -0800 (PST)
Message-ID: <64493723-d8a8-fc87-ae14-c2f9c8d38ef7@linaro.org>
Date:   Fri, 3 Feb 2023 00:38:54 +0100
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
I read it again, this time properly.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

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
