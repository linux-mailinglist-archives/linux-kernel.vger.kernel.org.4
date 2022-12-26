Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08406561DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 11:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiLZK1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 05:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiLZK1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 05:27:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75CD25C4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 02:27:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg10so7348029wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 02:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KALJq/V5r25unN7gpBUsW9CyIRW7TsaG7eOK1RtrxG4=;
        b=XzoOX9nL0mKaY5BM2p/ifqJKZH4E/8KMeSnguCGzpxWpEBvgYTmiK+K1kVTtCCt5ux
         OyeIMNGwB/MHMmzj4+0bTPPRaXqZJYUtFh8+g3Int9c4AnhoS6LOwB4zNkd40tvX2IFm
         D07fTPm/juu0sQOmHMoKo96EpBDk9YKJJTvnEa6MUGtyvlTJMFtHsV2ezn3fhkfhVAEv
         uQwMrri1uBw4vqyHiz5Mn38wOqmP/b8UtUC0vynz3Y5gGeG9nVIScx+Zy+rAMPzDeu3e
         /FQ4P4KDt9S1O2HqkspgszzZSn5be/Vush6RLNcG+RoOwUGv9MPa0k9fB79P+aPZSb6W
         aZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KALJq/V5r25unN7gpBUsW9CyIRW7TsaG7eOK1RtrxG4=;
        b=1B8TZGBs+W4zZL+yqQeo5/QIplGoOyD3QXBKw18Vf1FZ75aA8L3+6Ot1ycTLUdVtFW
         bl/lJJARNoh3sW+BdYPJY2RjjevvyB4d1aS8Ol6ZNtnwz3kHb4iyTOtenzqgJdztPX+i
         Y7Oh1aBWicHI59R6gzNPbuD8JC4BreSHJ/Q7QPK8ah4sdTcJCdFezi+jmvOBf3UwlaUN
         G4P6ZP8ot4LQAnCV96cfdzcTyPhAaVJjVMsMoksS7BxGV6hI5/8GlBEQ2K1kLWvRpGtP
         EkqlIqgHiloY+dp9sBXEqAcy/heQHmRswE1VtkhSKFsCxdFLqqQGN5OviXn4HjxW5pa1
         oXtA==
X-Gm-Message-State: AFqh2kpiJgf+fJgrVYRiuxycA19rH5Teh/35BkYnVQYhrUEHipmh2YJP
        xDG+YSo7rbCQSr2sKaf5Ml0d8A==
X-Google-Smtp-Source: AMrXdXvPOLaWe2a9phpQit63w0mHUGY18F/dL/xLYS/XbGC0BC2+uZqL8drVpMoEOVKN6hV2HSTLSQ==
X-Received: by 2002:a05:600c:3209:b0:3cf:5fd2:87a0 with SMTP id r9-20020a05600c320900b003cf5fd287a0mr12566712wmp.40.1672050455288;
        Mon, 26 Dec 2022 02:27:35 -0800 (PST)
Received: from [192.168.0.20] (117.215.132.195.rev.sfr.net. [195.132.215.117])
        by smtp.gmail.com with ESMTPSA id l17-20020adfe9d1000000b0024165454262sm9841286wrn.11.2022.12.26.02.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 02:27:34 -0800 (PST)
Message-ID: <fa6ec5ae-3c09-6a8d-b6bd-46fbdfcb4f26@baylibre.com>
Date:   Mon, 26 Dec 2022 11:27:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
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
Content-Language: en-US
In-Reply-To: <COUMF3IZ9Y63.LA3KFHJSUZIC@amjad-ThinkPad-T490>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 12/6/22 10:18, Amjad Ouled-Ameur wrote:
> Hi Daniel,
> On Mon Dec 5, 2022 at 8:39 PM CET, Daniel Lezcano wrote:
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
>>>> Here you use again the aggregation
>>> I addressed this concern in V6, could you please take a look and let me
>>> know what you think [0].
>>>
>>> [0]: https://lore.kernel.org/all/5eb0cdc2-e9f9-dd42-bf80-b7dcd8bcc196@baylibre.com/
>> May I misunderstanding but AFAICS, this patch is setting the
>> mtk_thermal_ops if the sensor id is zero. The get_temp is computing the
>> max temperature in this ops which is what we don't want to do.
> Correct, but I think that is out of scope of this patchset, as the current
> driver already uses mtk_thermal_ops for sensor 0. The focus of this patchset
> is to add support for the other sensors.
>
> Besides, what do you suggest as a clean implementation if the current one
> no longer meets thermal core requirements ?

Could you please address this ?


Kindly,

Amjad

> Regards,
> Amjad
>>
>> -- 
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
