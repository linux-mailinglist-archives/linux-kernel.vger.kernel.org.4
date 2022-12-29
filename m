Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1556658E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiL2PtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiL2PtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:49:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5269D13DD2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:49:17 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g25-20020a7bc4d9000000b003d97c8d4941so7940531wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OcHD+68JKivFTNKn8cO/CBcZZAARu6aqYEBF3jaYXXY=;
        b=wov4t/Dp6UbuGwqLvgc4vMkRfInBScyFz5VfMRxkFh9qxszC85YMpmSHny1gXPrVsS
         g32f4reKOVtWQMJ8tXOoxbkRbjZCZ1m5SUTFsEeNVyo3qe4fzbUv7mzyONTfBVWN/ygF
         VCv0lEJwgaS8OQpQtH1AmoCHEbO8WSsmtXkJwQMKbTVyQhOUnzPNh5aURydy23AIStHq
         7IW6dSqOnW/cLTthbtNHuMUuvGcSnsN4MUGA1Z6MgEXnnWMIIXtkOr33tpHLHB4icRu/
         EKo8oFJTgXBFfNfzRgvO95/Kqn05D0Qao4eQAzZ4kyo7nkuPJ1BIRmhp7+wC87dbet08
         SVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcHD+68JKivFTNKn8cO/CBcZZAARu6aqYEBF3jaYXXY=;
        b=V+5fJa0ltiqbq20VDBnyYlH7zU5ytN9AvK/QKG4AHzykwIbBkEN7mtq7+dKcNlEmyJ
         h4RkmTTqqo8/QaPpRwCXHFInF7XfRJgG8u5GvZEKA5T21zCx0vwFV0lO8/KYHq9ioRuu
         cXb565NOoRYUsrX2CCdZEdksQNeYUNPq5GzRa3mqnA7HUiDhrCM/hR3UIju+W2mPi8FS
         L/B2AfiLPMi3oTW3vHPp/E8d/TqjxCVWWnXX9EaCtBnK02g1y9ECotQe+dRBorzVe+Qh
         b+89O74sJFHLWlBhtseS9t6u30RzCoXDECSSEgpDIuMNEl7pVljLCT+uhxvCPlywISMa
         qsCA==
X-Gm-Message-State: AFqh2kraoPJjeQLKtj1kKN49QZnzzemH7WgWamC353zhcOv9D54PaXE8
        wcgjo+szyHj9F5IT63omdzuPMg==
X-Google-Smtp-Source: AMrXdXtGRRh5vsIthQvg5P5kw1KkeD+SE+4wsU583Cr1cJtcHYeGo9tuCyPGsdjApkph9RNzbdVSaQ==
X-Received: by 2002:a05:600c:3b02:b0:3c7:18:b339 with SMTP id m2-20020a05600c3b0200b003c70018b339mr25804533wms.37.1672328955770;
        Thu, 29 Dec 2022 07:49:15 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id d10-20020a05600c3aca00b003d34faca949sm24381530wms.39.2022.12.29.07.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 07:49:15 -0800 (PST)
Message-ID: <0644aede-c281-3919-50e0-4466f6587d81@linaro.org>
Date:   Thu, 29 Dec 2022 16:49:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <COUMF3IZ9Y63.LA3KFHJSUZIC@amjad-ThinkPad-T490>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2022 10:18, Amjad Ouled-Ameur wrote:
> Hi Daniel,
> On Mon Dec 5, 2022 at 8:39 PM CET, Daniel Lezcano wrote:
>>
>> Hi Amjad,
>>
>>
>> On 05/12/2022 11:41, Amjad Ouled-Ameur wrote:
>>
>> [ ... ]
>>
>>>>> @@ -1161,11 +1197,24 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>>>>     
>>>>>     	platform_set_drvdata(pdev, mt);
>>>>>     
>>>>> -	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
>>>>> -					      &mtk_thermal_ops);
>>>>> -	if (IS_ERR(tzdev)) {
>>>>> -		ret = PTR_ERR(tzdev);
>>>>> -		goto err_disable_clk_peri_therm;
>>>>> +	for (i = 0; i < mt->conf->num_sensors + 1; i++) {
>>>>> +		tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
>>>>> +		if (!tz)
>>>>> +			return -ENOMEM;
>>>>> +
>>>>> +		tz->mt = mt;
>>>>> +		tz->id = i;
>>>>> +
>>>>> +		tzdev = devm_thermal_of_zone_register(&pdev->dev, i, tz, (i == 0) ?
>>>>> +							     &mtk_thermal_ops :
>>>>> +							     &mtk_thermal_sensor_ops);
>>>>
>>>> Here you use again the aggregation
>>> I addressed this concern in V6, could you please take a look and let me
>>> know what you think [0].
>>>
>>> [0]: https://lore.kernel.org/all/5eb0cdc2-e9f9-dd42-bf80-b7dcd8bcc196@baylibre.com/
>>
>> May I misunderstanding but AFAICS, this patch is setting the
>> mtk_thermal_ops if the sensor id is zero. The get_temp is computing the
>> max temperature in this ops which is what we don't want to do.
> 
> Correct, but I think that is out of scope of this patchset, as the current
> driver already uses mtk_thermal_ops for sensor 0. The focus of this patchset
> is to add support for the other sensors.
> 
> Besides, what do you suggest as a clean implementation if the current one
> no longer meets thermal core requirements ?

IIUC, there is a sensor per couple of cores. 1 x 2Bigs, 1 x 2Bigs, 1 x 4 
Little, right ?

If it is the case, then a thermal zone per sensor with the trip points 
and a cooling device for each of them.

The two thermal zones for the big will share the same cooling device. 
The little thermal zone will have its own cooling device.

If there is the GPU, then its own cooling device also with devfreq.


>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

