Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BC76A6E85
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCAOfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjCAOfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:35:18 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF932532
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:35:16 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h14so13440285wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677681315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X7YL+IlTIRFVcO6j14L/qtU4zbF5djcwZrDP1aWOGKQ=;
        b=hCtnAjwL/3kM8XeG8ZfyYxkmzL03+1Fkmq8F5nm7qTo1s4Lus+dhevnLQxl0NLCXCk
         IRU85/AjPJyqjRa8+rQTKAKbmp/yGQ1Ma1X8fEduMe8KIzIWyDNL5N1Qx2q8Cy2joy+L
         3TiB0sSFTYjYURWIw55px73tjmtCJ352h5BfRDwDlptX+0XXm0PJKeTjtNngTtQDhTAh
         jUSQkRLiOUkEfuFTKSyA6OZLGZu1cn7Qt3lXD2CP4Iq4jgrv9UF0XrNGAFNKYPAb/xM/
         Ama2L2sT1nHMdXtsxbzshFu+046jh0nbKVb9trMe6NSvhQbH0kEV4liOW85T1kk2tGbs
         iVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677681315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7YL+IlTIRFVcO6j14L/qtU4zbF5djcwZrDP1aWOGKQ=;
        b=K9MnRzbnelS55grlBMhGiKuw7S9UvAigbCgltt0QF6c7bd/pmqOxv1IhhLU3ZFp+iw
         HHcU1IIpsIERige9YN5nR07wDXYTtpmOtyR/ndAUKGOFiVDn1TxVnhQ9Jc04POdjpK/B
         zuwo/q3RejQbOWYofe1mLUz8PwE/10TPR61WZHKcSBKzq/hmmH8qbLv9EAnbVpeT57Jw
         VN45ghtq4YmeeokGmJMqK4jEYctwuDh/6Fb2OJlLX1ZEfvLgq8WxPW2mbph2HtVFPKdC
         7/sNISZqMsLHhMnxKbOXDcgdfpR+EufJY6P/8U9X4U/2nDSQK/Zaog2EJ09LAmW/gWwW
         sffw==
X-Gm-Message-State: AO0yUKVUQ+/ROCYw+yAW8NNmibvpeDQE+XyEf8IBw6+6yZWDBo+JEib3
        vaYM8JrUGmaL0bFyimr5HLK/2w==
X-Google-Smtp-Source: AK7set9HHJ3araOQqPxSnQJ/J7Dou8y3EKiqNYmM6u4au3JQOoSxkNHov0K9uJGX44ZccpW6C4gYjg==
X-Received: by 2002:a05:6000:a0f:b0:2c5:540b:886c with SMTP id co15-20020a0560000a0f00b002c5540b886cmr11450102wrb.31.1677681314998;
        Wed, 01 Mar 2023 06:35:14 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d? ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.googlemail.com with ESMTPSA id h10-20020a05600c350a00b003daffc2ecdesm21207845wmq.13.2023.03.01.06.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 06:35:14 -0800 (PST)
Message-ID: <e5a4aaf1-af0a-aac4-6f77-94c3c9bfcc67@linaro.org>
Date:   Wed, 1 Mar 2023 15:35:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 16/19] thermal/drivers/tegra: Remove unneeded lock when
 setting a trip point
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
 <20230228112238.2312273-17-daniel.lezcano@linaro.org>
 <Y/9eohV9h26hPuFn@orome>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y/9eohV9h26hPuFn@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 15:18, Thierry Reding wrote:
> On Tue, Feb 28, 2023 at 12:22:35PM +0100, Daniel Lezcano wrote:
>> The function tegra_tsensor_enable_hw_channel() takes the thermal zone
>> lock to prevent "a potential" race with a call to set_trips()
>> callback.
>>
>> The driver must not play with the thermal framework core code
>> internals.
>>
>> The tegra_tsensor_enable_hw_channel() is called by:
>>
>>   - the suspend / resume callbacks
>>   - the probe function after the thermal zones are registered
>>
>> The thermal zone lock taken in this function is supposed to protect
>> from a call to the set_trips() callback which writes in the same
>> register.
>>
>> The potential race is when suspend / resume are called at the same
>> time as set_trips. This one is called only in
>> thermal_zone_device_update().
>>
>>   - At suspend time, the 'in_suspend' is set, thus the
>>     thermal_zone_device_update() bails out immediately and set_trips is
>>     not called during this moment.
>>
>>   - At resume time, the thermal zone is updated at PM_POST_SUSPEND,
>>     thus the driver has already set the TH2 temperature.
>>
>>   - At probe time, we register the thermal zone and then we set the
>>     TH2. The only scenario I can see so far is the interrupt fires, the
>>     thermal_zone_update() is called exactly at the moment
>>     tegra_tsensor_enable_hw_channel() a few lines after registering it.
>>
>> Disable the interrupt before setting up the hw channels and then
>> enable it. We close the potential race window without using the
>> thermal zone's lock.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/tegra/tegra30-tsensor.c | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
>> index 4b2ea17910cd..3506c3f3c474 100644
>> --- a/drivers/thermal/tegra/tegra30-tsensor.c
>> +++ b/drivers/thermal/tegra/tegra30-tsensor.c
>> @@ -359,9 +359,6 @@ static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
>>   
>>   	tegra_tsensor_get_hw_channel_trips(tzd, &hot_trip, &crit_trip);
>>   
>> -	/* prevent potential racing with tegra_tsensor_set_trips() */
>> -	mutex_lock(&tzd->lock);
>> -
>>   	dev_info_once(ts->dev, "ch%u: PMC emergency shutdown trip set to %dC\n",
>>   		      id, DIV_ROUND_CLOSEST(crit_trip, 1000));
>>   
>> @@ -404,8 +401,6 @@ static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
>>   	val |= FIELD_PREP(TSENSOR_SENSOR0_CONFIG0_INTR_THERMAL_RST_EN, 1);
>>   	writel_relaxed(val, tsc->regs + TSENSOR_SENSOR0_CONFIG0);
>>   
>> -	mutex_unlock(&tzd->lock);
>> -
>>   	err = thermal_zone_device_enable(tzd);
>>   	if (err) {
>>   		dev_err(ts->dev, "ch%u: failed to enable zone: %d\n", id, err);
>> @@ -592,12 +587,24 @@ static int tegra_tsensor_probe(struct platform_device *pdev)
>>   		return dev_err_probe(&pdev->dev, err,
>>   				     "failed to request interrupt\n");
>>   
>> +	/*
>> +	 * Disable the interrupt so set_trips() can not be called
>> +	 * while we are setting up the register
>> +	 * TSENSOR_SENSOR0_CONFIG1. With this we close a potential
>> +	 * race window where we are setting up the TH2 and the
>> +	 * temperature hits TH1 resulting to an update of the
>> +	 * TSENSOR_SENSOR0_CONFIG1 register in the ISR.
>> +	 */
>> +	disable_irq(irq);
>> +
>>   	for (i = 0; i < ARRAY_SIZE(ts->ch); i++) {
>>   		err = tegra_tsensor_enable_hw_channel(ts, i);
>>   		if (err)
>>   			return err;
>>   	}
>>   
>> +	enable_irq(irq);
> 
> Instead of disabling and reenabling the interrupt, could we simply move
> the channel enabling code a couple of lines above, before the IRQ
> request call? If enabling the channels were to trigger an interrupt, it
> should get triggered right after requesting the IRQ.

Won't we have a spurious interrupt if that situation happen ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

