Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E09366ADC2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 21:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjANUml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 15:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjANUmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 15:42:39 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD2A4C30
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 12:42:38 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x40so3631853lfu.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 12:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZgHwj85eFYM/emcDXAR9MgKYKwUi6SnINYZdhujPNvU=;
        b=Xh4WEvlixndZIokrw6upxP1LScp25MsWlIdp/AWNkz44hj/2l3jzFFBOEUayPUaqSl
         tqFbYwrV+JQgoB11DoqWPF6RiHVNSj7Gh7mc4ZLL3ouhqsA1hJD7Qr4ewAq5afQa3kNr
         JvpfXV5CfQgh2aw7qk6Ooc5Wycbk9tnepDG5FvdYWMeBCFbmHk76NGPkYVxFQjOJhT+O
         5e7LepM6+B+R0z/JGFPUFuzPjq0boV616V2dHtgwbjJG/9MrhDqIiZ89NlipgxJa58QJ
         l8GA1d2RRng9pRaqWcj8FXig2fhKErhDe/QGR+DumVD1BkQqdidzVqqJsd8YqdQhrj2v
         onMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgHwj85eFYM/emcDXAR9MgKYKwUi6SnINYZdhujPNvU=;
        b=R9szPDl7clx5B678WX2VBWQt8y3vo78RSobSEu+29Hv23g2Uu27AMWASOSwAVyKsL9
         Ghf71z4xf7nkWFtPq6/JoRqZkRWRDWGb4BertXH8gDPBJQGUXZlprEau8hic9f2RZ3aV
         jxvFHy2lYhCnnm2Cx99otCB2eWE9kM5Yp6y06NDOII1w7MQGE9BC9c6ARAH/WU9F7neh
         Zr/fLZqryD+1eNF5B9yDdVgBafO6VW5oWR6H5km03FEN54z2xxZOS1a+/tk+UCfOYnX+
         LadIL3FtTCX+mF1eTfttHHkG90DqsEIgZiNIQkw2g2/nJqPbz+O9ksIXd0tzcMtyiyND
         m8aQ==
X-Gm-Message-State: AFqh2koPlAmDNBbtwdQTIA/GDlGx/Z66Hj+rspQpdorrbBKfEVJtrPhk
        2tg/oY/hkisBMXGjobaBdEM9NQ==
X-Google-Smtp-Source: AMrXdXuXdTJIkfJc12QFUyrmVUWaa1q+jzMzd4UNhv5TF31ZY094XFq4st2S7GPzHkEHqSF5HfUbrQ==
X-Received: by 2002:a05:6512:3247:b0:4cd:f558:1f8a with SMTP id c7-20020a056512324700b004cdf5581f8amr3098694lfr.29.1673728956580;
        Sat, 14 Jan 2023 12:42:36 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id h15-20020a05651211cf00b00498fc3d4d15sm4421027lfr.190.2023.01.14.12.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 12:42:35 -0800 (PST)
Message-ID: <685937dd-6265-1f57-f7aa-e6dd0cf3a49f@linaro.org>
Date:   Sat, 14 Jan 2023 21:42:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] cpufreq: qcom-hw: Ensure only freq-domain regs are
 counted in num_domains
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230111205125.1860858-1-konrad.dybcio@linaro.org>
 <20230111205125.1860858-2-konrad.dybcio@linaro.org>
 <20230112153704.6d37dygm4yfexdq6@builder.lan>
 <7dec47af-0981-7d70-3926-69419f5d1c8e@linaro.org>
 <20230113194132.GA2806609-robh@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230113194132.GA2806609-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.01.2023 20:41, Rob Herring wrote:
> On Thu, Jan 12, 2023 at 04:41:50PM +0100, Konrad Dybcio wrote:
>>
>>
>> On 12.01.2023 16:37, Bjorn Andersson wrote:
>>> On Wed, Jan 11, 2023 at 09:51:25PM +0100, Konrad Dybcio wrote:
>>>> In preparation for CPRh-aware OSM programming, change the probe
>>>> function so that we determine the number of frequency domains by
>>>> counting the number of reg-names entries that begin with
>>>> "freq-domain", as the aforementioned changes require introduction
>>>> of non-freq-domain register spaces.
>>>>
>>>
>>> Requiring reg-names would break backwards compatibility with at least
>>> sc7280 and sm6115.
>> Ouch, you're correct..
>>
>> Does checking for reg-names and applying the code flow proposed in this
>> patch if found and the existing one if not sound good?
> 
> Why support 2 ways?
Targets that are supported by the current revision of this driver
(which only specify frequency-domain-N MMIO spaces as reg
entries) assume that ARRAY_SIZE(reg) == the number of frequency
domains. These usually range from 1 to 3.

We can either hardcode the number of frequency domains on targets
that require more, different register spaces (for manual hardware
programming, which also happens on currently supported hardware,
just that the secure firmware does it for us.. see [1])
or check with reg-names. Requiring reg-names would break backwards
compatibility with older DTs for at least two SoCs.


> 
> 
>> Konrad
>>>
>>> Regards,
>>> Bjorn
>>>
>>>> Fixes: 1a6a8b0080b0 ("cpufreq: qcom-hw: Fix reading "reg" with address/size-cells != 2")
>>>> Fixes: 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe")
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>  drivers/cpufreq/qcom-cpufreq-hw.c | 34 ++++++++++++++++++++++---------
>>>>  1 file changed, 24 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>>>> index 9505a812d6a1..89d5ed267399 100644
>>>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>>>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>>>> @@ -651,8 +651,9 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>>>>  	struct device *dev = &pdev->dev;
>>>>  	struct device_node *soc_node;
>>>>  	struct device *cpu_dev;
>>>> +	const char *reg_name;
>>>>  	struct clk *clk;
>>>> -	int ret, i, num_domains, reg_sz;
>>>> +	int ret, i, num_reg_names, num_domains = 0;
>>>>  
>>>>  	clk = clk_get(dev, "xo");
>>>>  	if (IS_ERR(clk))
>>>> @@ -684,19 +685,32 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>>>>  	if (!soc_node)
>>>>  		return -EINVAL;
>>>>  
>>>> -	ret = of_property_read_u32(soc_node, "#address-cells", &reg_sz);
>>>> -	if (ret)
>>>> +	num_reg_names = of_property_count_strings(dev->of_node, "reg-names");
>>>> +	if (num_reg_names <= 0) {
>>>> +		ret = num_reg_names ? num_reg_names : -ENODATA;
>>>>  		goto of_exit;
>>>> +	}
>>>>  
>>>> -	ret = of_property_read_u32(soc_node, "#size-cells", &i);
>>>> -	if (ret)
>>>> -		goto of_exit;
>>>> +	for (i = 0; i < num_reg_names; i++) {
>>>> +		ret = of_property_read_string_index(dev->of_node, "reg-names", i, &reg_name);
>>>> +		if (ret < 0)
>>>> +			goto of_exit;
>>>>  
>>>> -	reg_sz += i;
>>>> +		/*
>>>> +		 * Check if the i-th reg is a freq-domain base, no need to add 1
>>>> +		 * more byte for idx, as sizeof counts \0 whereas strlen does not.
>>>> +		 */
>>>> +		if (strlen(reg_name) == sizeof("freq-domain")) {
>>>> +			/* Check if this reg-name begins with "freq-domain" */
>>>> +			if (!strncmp(reg_name, "freq-domain", sizeof("freq-domain") - 1))
>>>> +				num_domains++;
>>>> +		}
>>>> +	}
>>>>  
>>>> -	num_domains = of_property_count_elems_of_size(dev->of_node, "reg", sizeof(u32) * reg_sz);
> 
> This code was not great to begin with. Any code parsing 'reg' on it's 
> own is suspect IMO. It's a standard property and all parsing of it 
> should be in drivers/of/address.c. (Yes, I know there are other cases.)
> 
> The reg entries are already available as platform_device resources? Why 
> don't you use that? There's also of_address_count(), but I prefer if 
> there's a platform device equivalent like we have for interrupts.
Hm.. I knew this was suspiciously bare-dt-operation, but never quite
connected the dots.. perhaps that's a good idea to pursue..

Konrad

[1] https://patchwork.kernel.org/project/linux-pm/patch/20210701105730.322718-7-angelogioacchino.delregno@somainline.org/
> 
> Rob
