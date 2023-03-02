Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A79C6A7F82
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCBKCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjCBKBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:01:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210714A1C9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:01:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bw19so15889800wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677751249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WHN80/8HsITubRT+JVKcTKtEZGOdb+Y3/SpDwENmg8=;
        b=pkiMi8lgb0Hl9Sz0AcRGTaWTyuI9mgRGBGF+JKP/8bE+RR1/9glIJDemDjcf+vRCcd
         x2LN01/2c8j+UAj/xC5NYDhnqYU5wJc7c57JjQqTFS6PDHRuY+2Fr8HYpLaiksDUKHpM
         z2Z5CEjxiaQFfootaO/eNBKq93locUjuimD8s3dSA3hRnzHVe5zT3xzyQdJxmOvCCLdT
         khsQkdegIS2UMWFO3AmEp2InLJLYx9jZPk1icY/cXO/Q1f2N0MhXUQ93IFRfgBevP7el
         8hXPwLSpznzGXDeBqNz8piK9cB/vPgX+agcB7Lp/uXjbf0ua2+U0b0avPXJpZhBAoqg3
         GS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677751249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WHN80/8HsITubRT+JVKcTKtEZGOdb+Y3/SpDwENmg8=;
        b=aB+JSaGHeJthB0naTu7mUxjfIhCv5S3NsYzh+1yiA1Jr1XbbQF7fum3omCY1SFJi18
         hex9jEkCH++xpVVHTdpOKB+7StZvTGodjM44BE1a3IzYpPKrWcAk3BWHalDhacDAvHLK
         pZ7X+cDd8n18peI84TedU+prDPySeX06E82GC0wf6JEkaZXtuIA0FBrOVhcROmYtveeP
         Cx9biIsRNiEEtRjMcMs3ahC4vStlNm8JSqg7hLVnnyfjJopDosfugEW2ybF9LYulk8XL
         HlPgymkKoYVy8E5LdyybD6M/b6jiOXLg4pSsd6uiX1SKPNatsErS5n901Uzoa3xK+GOg
         Hg5w==
X-Gm-Message-State: AO0yUKWjG4LwgYd7HV9PI/9F6GpNiRVwC1I28lCHZPNE1SgC5A2fLKnn
        FXyu6yQ9lpHK2x/JewcaNOOIYQ==
X-Google-Smtp-Source: AK7set99atQ5w3RWnhKn9Xp6beOhPsaFZs79eN67zUIFFDlFMu6emn4CGBz+mwB4lvVD9mZLvvTDMA==
X-Received: by 2002:adf:f9c5:0:b0:2cb:eef2:daff with SMTP id w5-20020adff9c5000000b002cbeef2daffmr7331319wrr.22.1677751249408;
        Thu, 02 Mar 2023 02:00:49 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:9a21:3c01:c6c8:757f? ([2a05:6e02:1041:c10:9a21:3c01:c6c8:757f])
        by smtp.googlemail.com with ESMTPSA id a4-20020adff7c4000000b002c4084d3472sm14640607wrq.58.2023.03.02.02.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 02:00:49 -0800 (PST)
Message-ID: <7b3adc62-2bb5-97c7-c4ee-0df61968db29@linaro.org>
Date:   Thu, 2 Mar 2023 11:00:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 16/18] thermal/drivers/tegra: Remove unneeded lock when
 setting a trip point
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
 <20230301201446.3713334-17-daniel.lezcano@linaro.org>
 <ZABwllXuTHbUhnue@orome>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZABwllXuTHbUhnue@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 10:47, Thierry Reding wrote:
> On Wed, Mar 01, 2023 at 09:14:44PM +0100, Daniel Lezcano wrote:
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
>> Enable the channels before setting up the interrupt. We close the
>> potential race window without using the thermal zone's lock.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
>> ---
>>   drivers/thermal/tegra/tegra30-tsensor.c | 25 ++++++++++++++-----------
>>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

Thanks for your review

May I ask you to have a look at patch 2 and 8 ?

Thanks

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

