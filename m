Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0F673F73
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjASRDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjASRDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:03:17 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D7AA5CB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:03:15 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso1741744wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xoDg7X6k/SjUQcyWVxb++knJQou/HfRjq27D3pK1OL0=;
        b=1hrdE6EhVZapN/amnndIOVoCyNf2PV5AUtAzDtKRv2WE7dv+4JYyd12hJtZZmEQfNg
         3unnzAFt3Ei2XSXRQ/382g6ej48VXzNYBSocOMr2bvg3dUc9WGRZhEkCDD8OjAxdeFDS
         j/hEXC0lom9dHs+G9YMstoUY1PzRiX4Gq9UniA38h1YFkA4N6cDzUHMgV/ta21+W7iqA
         sYtJ5hc5jHIH69AI267vdjXQH8ttU24qNCX6UVpI5JojnLTa9HdfJoK1VbvfIHs4aHVA
         1LUXsoBE/oGphFk0PGffJ/ThRyFprXILexDcb91ZNqkjorykOr6X1SKXSKRMuSuEvh8A
         5AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xoDg7X6k/SjUQcyWVxb++knJQou/HfRjq27D3pK1OL0=;
        b=13Qh9JJpsZEg8uKtHgP7NP2oLHxW+8Epp2OHtp7WPFp/LB5KeCVlOcnawQ1ex3sBEd
         7Bj1B+hrgbTiWDkfcdqRvK95HY+PcgJy9mRjM2QgnD6BxhIcdpT+mbk04F+6Ww641dr8
         UTu0/sYOF+IpMILQ5ARcTMGt8HYUOFM85+6FutEHdsKJBzbHXRZWUYMesMrLmngb5bUE
         V25QwzIH5KcB+gNYJUzN5sy/WpXiqqHZHbxyfcm28DKL3C3uOOypPVCdaswSYvPHT/RV
         CYgQiYgSv4C/otsMpUYQEc0wTVgviXxgBEN9lUhvnM7VKGU+OOkgjHb7IyBrvQVpgzzY
         HhSw==
X-Gm-Message-State: AFqh2kqEXcWf8q7UiyDXOVVfKzNWZ25Va20mDYTcsZVtCEh12ogXaOuE
        yX3FMDGC+8Q/T/qz6py/5zNxsw==
X-Google-Smtp-Source: AMrXdXvVqir7OAh4deRHUpeRJymXdvbDE5Wl8w9DSxpLlPsa1In7nF1ob0+NOI0SLMtg6L6CnI5eQg==
X-Received: by 2002:a05:600c:1d8e:b0:3d9:f9ef:3d23 with SMTP id p14-20020a05600c1d8e00b003d9f9ef3d23mr11316499wms.23.1674147793846;
        Thu, 19 Jan 2023 09:03:13 -0800 (PST)
Received: from [10.8.2.10] ([195.200.221.42])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b003a3442f1229sm6193662wmq.29.2023.01.19.09.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 09:03:10 -0800 (PST)
Message-ID: <187b0fe1-1f14-d8b8-c827-1e824da0b1d3@baylibre.com>
Date:   Thu, 19 Jan 2023 18:03:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v7 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Michael Kao <michael.kao@mediatek.com>,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20221018-up-i350-thermal-bringup-v7-0-ebf08ff2eddb@baylibre.com>
 <20221018-up-i350-thermal-bringup-v7-4-ebf08ff2eddb@baylibre.com>
 <4121bb6b-30db-7a23-f4c8-40afdda7a0b5@linaro.org>
 <COTTJX635TNF.1WL2TEZN7VW9O@amjad-ThinkPad-T490>
 <adfe41f7-00e5-876b-7803-3127919fba13@linaro.org>
 <COUMF3IZ9Y63.LA3KFHJSUZIC@amjad-ThinkPad-T490>
 <0644aede-c281-3919-50e0-4466f6587d81@linaro.org>
Content-Language: en-US
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <0644aede-c281-3919-50e0-4466f6587d81@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 12/29/22 16:49, Daniel Lezcano wrote:
> On 06/12/2022 10:18, Amjad Ouled-Ameur wrote:
>> Hi Daniel,
>> On Mon Dec 5, 2022 at 8:39 PM CET, Daniel Lezcano wrote:
>>>
>>> Hi Amjad,
>>>
>>>
>>> On 05/12/2022 11:41, Amjad Ouled-Ameur wrote:
>>>
>>> [ ... ]
>>>
>>>>>> @@ -1161,11 +1197,24 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>>>>>             platform_set_drvdata(pdev, mt);
>>>>>>     -    tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
>>>>>> -                          &mtk_thermal_ops);
>>>>>> -    if (IS_ERR(tzdev)) {
>>>>>> -        ret = PTR_ERR(tzdev);
>>>>>> -        goto err_disable_clk_peri_therm;
>>>>>> +    for (i = 0; i < mt->conf->num_sensors + 1; i++) {
>>>>>> +        tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
>>>>>> +        if (!tz)
>>>>>> +            return -ENOMEM;
>>>>>> +
>>>>>> +        tz->mt = mt;
>>>>>> +        tz->id = i;
>>>>>> +
>>>>>> +        tzdev = devm_thermal_of_zone_register(&pdev->dev, i, tz, (i == 0) ?
>>>>>> +                                 &mtk_thermal_ops :
>>>>>> + &mtk_thermal_sensor_ops);
>>>>>
>>>>> Here you use again the aggregation
>>>> I addressed this concern in V6, could you please take a look and let me
>>>> know what you think [0].
>>>>
>>>> [0]: https://lore.kernel.org/all/5eb0cdc2-e9f9-dd42-bf80-b7dcd8bcc196@baylibre.com/
>>>
>>> May I misunderstanding but AFAICS, this patch is setting the
>>> mtk_thermal_ops if the sensor id is zero. The get_temp is computing the
>>> max temperature in this ops which is what we don't want to do.
>>
>> Correct, but I think that is out of scope of this patchset, as the current
>> driver already uses mtk_thermal_ops for sensor 0. The focus of this patchset
>> is to add support for the other sensors.
>>
>> Besides, what do you suggest as a clean implementation if the current one
>> no longer meets thermal core requirements ?
>
> IIUC, there is a sensor per couple of cores. 1 x 2Bigs, 1 x 2Bigs, 1 x 4 Little, right ?

MT8365 SoC has 4 x A53 CPUs. The SoC has 4 thermal zones per sensor. Thermal zone 0 corresponds

to all 4 x A53 CPUs, the other thermal zones (1, 2 and 3) has nothing to do with CPUs. The cooling device type

used for CPUs is passive. FYI, thermal zones 1, 2 and 3 are present in the SoC for debug-purpose only, they are not supposed

to be used for production.


Regards,

Amjad

>
> If it is the case, then a thermal zone per sensor with the trip points and a cooling device for each of them.
>
> The two thermal zones for the big will share the same cooling device. The little thermal zone will have its own cooling device.
>
> If there is the GPU, then its own cooling device also with devfreq.
>
>
>>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>>
>>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>>> <http://twitter.com/#!/linaroorg> Twitter |
>>> <http://www.linaro.org/linaro-blog/> Blog
>>
>
