Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A1F6887CF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBBTxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjBBTxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:53:47 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2A81E2A1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:53:45 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qw12so9248639ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 11:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HaDFfxxzuLwN75YKvylnJiXNpCrcwXxrygiD4ELDOQ8=;
        b=XnDYP7IO5pP3GcYGNn52WSskJ+9C8pMoab6FbCgKr170kOCMuDWUXBcbX7btW0HnQo
         EZKOEMsrplHxOm1VnWwjwTKunmvW/usk/seSp+huso6WA7eavXC1OKPn/G0Zh+NpOjrf
         FRkxZSeMg3fOYkM0evBQOQQOw57ODLZi1FqsKgr0eNd1aQbrijkKnPz6Zd041HztH24H
         8hf/GWL8cyM/R3GUmzJ0JHfUWy+bijeqr+whbQgljM4fZ2iW1UXdVWK8Ou0qravrvRGC
         tSQ8dw0kFG90dyvw4RlZ2epCBXKnCJpQ1iSqVMR3GhhhAVeFVfgnj8wFfC1U851sD9Dj
         UZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaDFfxxzuLwN75YKvylnJiXNpCrcwXxrygiD4ELDOQ8=;
        b=H+XQ0L6iv35y8MSR07gz6m4/F3zYZWw7FLYCcFMXBh3i3tn3ACjrvX/Vf96ZKjdg5k
         VhbR6dJmVZbCcw+E63uU8Ex66wXvMG1m9qHlxfrynTOvMaj1OV54Y8+RIPGNkXqGeRui
         L7KrvYzL4fc8nuQAy9PM3g22Ghnea7QUDrcp39BBCrDEgL7owkS+ePJ+h1XU4HbF6h+g
         iRYqkkUB4VO+TexF0nsRzM9LneW5rPEdRsgwifp2q02OQHShVb4VKDq0Ec5idHKfKaDW
         +0BBnfLMGL8XAVXw+RnjcUgjU+c4sNkwvDMoJfBKMybJLq5q7A+sHDA9uvRpwfcYn9OM
         PJtg==
X-Gm-Message-State: AO0yUKUXRbMQZOIvJuSncOoyONrJJ6LLbKT6D1p2MP3mKX83Js2TTSS4
        4Csax6HZwWdjrqjMdFJUJpoXPw==
X-Google-Smtp-Source: AK7set8hm8gggwv/GPzDyAxsPPsvhLgacTc1mEed2aWQZaE/x/C55oTALWz/ayjBDYtn8nt5/jY/jA==
X-Received: by 2002:a17:906:60d2:b0:86f:3dfa:4016 with SMTP id f18-20020a17090660d200b0086f3dfa4016mr8447911ejk.7.1675367623820;
        Thu, 02 Feb 2023 11:53:43 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a15-20020a50ff0f000000b004a2067d6ba4sm146536edu.52.2023.02.02.11.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 11:53:43 -0800 (PST)
Message-ID: <3826e0e6-bb2b-409d-d1c3-ed361305bce3@linaro.org>
Date:   Thu, 2 Feb 2023 21:53:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
Content-Language: en-GB
To:     Matthias Kaehlcke <mka@chromium.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
 <Y9v/z8CYik3faHh7@google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y9v/z8CYik3faHh7@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 20:24, Matthias Kaehlcke wrote:
> Hi Abel,
> 
> On Fri, Jan 27, 2023 at 12:40:53PM +0200, Abel Vesa wrote:
>> Currently, there are cases when a domain needs to remain enabled until
>> the consumer driver probes. Sometimes such consumer drivers may be built
>> as modules. Since the genpd_power_off_unused is called too early for
>> such consumer driver modules to get a chance to probe, the domain, since
>> it is unused, will get disabled. On the other hand, the best time for
>> an unused domain to be disabled is on the provider's sync_state
>> callback. So, if the provider has registered a sync_state callback,
>> assume the unused domains for that provider will be disabled on its
>> sync_state callback. Also provide a generic sync_state callback which
>> disables all the domains unused for the provider that registers it.
>>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>>
>> This approach has been applied for unused clocks as well.
>> With this patch merged in, all the providers that have sync_state
>> callback registered will leave the domains enabled unless the provider's
>> sync_state callback explicitly disables them. So those providers will
>> need to add the disabling part to their sync_state callback. On the
>> other hand, the platforms that have cases where domains need to remain
>> enabled (even if unused) until the consumer driver probes, will be able,
>> with this patch in, to run without the pd_ignore_unused kernel argument,
>> which seems to be the case for most Qualcomm platforms, at this moment.
> 
> I recently encountered a related issue on a Qualcomm platform with a
> v6.2-rc kernel, which includes 3a39049f88e4 ("soc: qcom: rpmhpd: Use
> highest corner until sync_state"). The issue involves a DT node with a
> rpmhpd, the DT node is enabled, however the corresponding device driver
> is not enabled in the kernel. In such a scenario the sync_state callback
> is never called, because the genpd consumer never probes. As a result
> the Always-on subsystem (AOSS) of the SoC doesn't enter sleep mode during
> system suspend, which results in a substantially higher power consumption
> in S3.
> 
> I wonder if genpd (and some other frameworks) needs something like
> regulator_init_complete(), which turns off unused regulators 30s after
> system boot. That's conceptually similar to the current
> genpd_power_off_unused(), but would provide time for modules being loaded.

I think the overall goal is to move away from ad-hoc implementations 
like clk_disable_unused/genpd_power_off_unused/regulator_init_complete 
towards the sync_state.

So inherently one either has to provide drivers for all devices in 
question or disable unused devices in DT.

> 
>> The v1 is here:
>> https://lore.kernel.org/all/20230126234013.3638425-1-abel.vesa@linaro.org/
>>
>> Changes since v1:
>>   * added a generic sync state callback to be registered by providers in
>>     order to disable the unused domains on their sync state. Also
>>     mentioned this in the commit message.
>>
>>   drivers/base/power/domain.c | 17 ++++++++++++++++-
>>   include/linux/pm_domain.h   |  3 +++
>>   2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 84662d338188..c2a5f77c01f3 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1099,7 +1099,8 @@ static int __init genpd_power_off_unused(void)
>>   	mutex_lock(&gpd_list_lock);
>>   
>>   	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
>> -		genpd_queue_power_off_work(genpd);
>> +		if (!dev_has_sync_state(genpd->provider->dev))
>> +			genpd_queue_power_off_work(genpd);
>>   
>>   	mutex_unlock(&gpd_list_lock);
>>   
>> @@ -1107,6 +1108,20 @@ static int __init genpd_power_off_unused(void)
>>   }
>>   late_initcall(genpd_power_off_unused);
>>   
>> +void genpd_power_off_unused_sync_state(struct device *dev)
>> +{
>> +	struct generic_pm_domain *genpd;
>> +
>> +	mutex_lock(&gpd_list_lock);
>> +
>> +	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
>> +		if (genpd->provider->dev == dev)
>> +			genpd_queue_power_off_work(genpd);
>> +
>> +	mutex_unlock(&gpd_list_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(genpd_power_off_unused_sync_state);
>> +
>>   #ifdef CONFIG_PM_SLEEP
>>   
>>   /**
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index f776fb93eaa0..1fd5aa500c81 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -351,6 +351,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>>   					 unsigned int index);
>>   struct device *genpd_dev_pm_attach_by_name(struct device *dev,
>>   					   const char *name);
>> +void genpd_power_off_unused_sync_state(struct device *dev);
>>   #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>>   static inline int of_genpd_add_provider_simple(struct device_node *np,
>>   					struct generic_pm_domain *genpd)
>> @@ -419,6 +420,8 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>>   {
>>   	return ERR_PTR(-EOPNOTSUPP);
>>   }
>> +
>> +static inline genpd_power_off_unused_sync_state(struct device *dev) {}
>>   #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>>   
>>   #ifdef CONFIG_PM
>> -- 
>> 2.34.1
>>

-- 
With best wishes
Dmitry

