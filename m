Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72B767AF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbjAYKCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjAYKCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:02:09 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BCD53B2C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:02:07 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j17so13344981wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ez1jIiTv9nX1Skc1wM1E/PnmqK6jZZdjJqYTYBY0xHY=;
        b=HxmBkWhRZanAM19gbjD/LEt8+fEINkj3ywKLosQLQbJQNZsXfqnXpDbmIAv4vAZn+h
         Rp/oupBFgjLiKjSMJn0GJqR2OhyItaYDqy9fwTsHSNcLN4EsLbpzBTzwF7Eru0Dyz4MS
         YHXwLS9ae2cRkytyAYZtRsKZGPO+vvwpEVDhVGWnjZn8WvObuOjAIj7unsoEpdiX6wsG
         ig6NlHG+XmKN3XjOp67HzuQsrDjiAHGpq3gf5Dkone9+k/HByHdp2SKXjlBhOEtRsPlG
         brxwTlr9t101guYLnvtRfX0DOYLo0tR56e+9YXEZV8ZDADgbSaQ7KpV5J73e+I9NvoCe
         WuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ez1jIiTv9nX1Skc1wM1E/PnmqK6jZZdjJqYTYBY0xHY=;
        b=LsYAvCgSVwvA/wqy73zSh/4/xzEaJBM/2sT8FuIMi/PV8vJ8Ep1C1so5Z+386AaO0D
         6QI+xPEV7Txisyr5tiP0gRCY62So3IXHypblWqJMb9k+h/yY7XrMspPW1xhXgUqrieLT
         bJveV6B08QGeh53gzCYf/ToDBtpFinfIJ1eHPGeTQImNu4NR32dPTM/NqrlEGhgns3vg
         29OGFxAlDUdUJHg+U23xL2Fi8CLfFT5zukkZH7toDtSQXYPmUoFHDm7UzImL7L8WCrk8
         E0PXy3rUftDZPe0HDj8gNSLDuyAUcbXky2zgmSbw5mJtVbDrLFhO5fgfcx7e53iVjDGL
         p2+A==
X-Gm-Message-State: AFqh2kr+OC/ftcw+G+uCTMd3gxCikmbRXP59qRZAG6r1fPcmTjNzH71a
        WWOwNZG5BLz3t7lT1oIoB4b/hQ==
X-Google-Smtp-Source: AMrXdXsWI+Xn0CCZaPu7nEc4G6KvXleAVgMRzL7EE29YVtnKarz3Jdw/b+2Wh3ptAxw9WtwVxtljUg==
X-Received: by 2002:a1c:4b19:0:b0:3da:fb5c:8754 with SMTP id y25-20020a1c4b19000000b003dafb5c8754mr28049633wma.2.1674640925987;
        Wed, 25 Jan 2023 02:02:05 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id h20-20020a05600c351400b003dc1300eab0sm1460677wmq.33.2023.01.25.02.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 02:02:05 -0800 (PST)
Message-ID: <0df50d0f-de3a-a2be-9363-2b3c65599f96@linaro.org>
Date:   Wed, 25 Jan 2023 11:02:03 +0100
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
 <0644aede-c281-3919-50e0-4466f6587d81@linaro.org>
 <187b0fe1-1f14-d8b8-c827-1e824da0b1d3@baylibre.com>
 <d3daece0-ed23-fae7-9bc8-c6e53b84e8e7@baylibre.com>
 <9f9547a2-69dd-f91d-c587-289156bf9d55@linaro.org>
 <2950b824-ad2f-2579-a956-a03d157453eb@baylibre.com>
 <c1fad818-1858-2e81-84fd-03cfb54d8938@linaro.org>
 <0b5e3a14-fd23-4646-d4cb-df255eb8fa20@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <0b5e3a14-fd23-4646-d4cb-df255eb8fa20@baylibre.com>
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

On 24/01/2023 23:27, Amjad Ouled-Ameur wrote:
> 
> On 1/24/23 18:55, Daniel Lezcano wrote:
>> On 24/01/2023 18:46, Amjad Ouled-Ameur wrote:
>>>
>>> On 1/24/23 17:54, Daniel Lezcano wrote:
>>>>
>>>> Hi Amjad,
>>>>
>>>> On 24/01/2023 11:08, Amjad Ouled-Ameur wrote:
>>>>
>>>> [ ... ]
>>>>
>>>>>>>
>>>>>>> IIUC, there is a sensor per couple of cores. 1 x 2Bigs, 1 x 
>>>>>>> 2Bigs, 1 x 4 Little, right ?
>>>>>>
>>>>>> MT8365 SoC has 4 x A53 CPUs. The SoC has 4 thermal zones per 
>>>>>> sensor. Thermal zone 0 corresponds
>>>>>>
>>>>>> to all 4 x A53 CPUs, the other thermal zones (1, 2 and 3) has 
>>>>>> nothing to do with CPUs. The cooling device type
>>>>>>
>>>>>> used for CPUs is passive. FYI, thermal zones 1, 2 and 3 are 
>>>>>> present in the SoC for debug-purpose only, they are not supposed
>>>>>>
>>>>>> to be used for production.
>>>>>>
>>>>> After reconsidering the fact that zones 1, 2 and 3 are only used 
>>>>> for dev/debug, it might be best to avo >
>>>>> aggregation as you suggested, and keep only support for zone 0 in 
>>>>> this driver. Thus I suggest I send a V8
>>>>>
>>>>> where I keep only below fixes for this patch if that's okay with you:
>>>>>
>>>>> - Define "raw_to_mcelsius" function pointer for "struct 
>>>>> thermal_bank_cfg".
>>>>>
>>>>> - Fix "mtk_thermal" variable in mtk_read_temp().
>>>>>
>>>>> - Set "mt->raw_to_mcelsius" in probe().
>>>>>
>>>>>
>>>>> For zones 1, 2 and 3 we can later add a different driver specific 
>>>>> for dev/debug to probe them to
>>>>>
>>>>> avoid confusion.
>>>>
>>>> You can add them in the driver and in the device tree, but just add 
>>>> the cooling device for the thermal zone 0.
>>>
>>> Thermal zone 0 uses CPU{0..3} for passive cooling, in this case we 
>>> should register cooling device with
>>>
>>> cpufreq_cooling_register() for each CPU right ?
>>
>> No, the OF code device tree does already that. You just have to 
>> register the different thermal zones.
>>
>> Do you have a pointer to a device tree for this board and the thermal 
>> setup ?
> 
> Sure, here is a dtsi for MT8365 SoC which contains thermal nodes [0].

 From my POV, there are two different setup with the DT but only one 
implementation with the driver.

The driver should register all the thermal zones for each CPUs. For 
that, make things nice with the defines for the dt-bindings like [1].

Then the device tree:

setup1:

Describe all the thermal zones in the DT which will be similar to [2]. 
Each CPU has a thermal zone, trip points and the same cooling device.

The first thermal zone reaching the trip temperature threshold will 
start the mitigation. The thermal framework takes care of multiple 
thermal zones sharing the same cooling device.

The result will be the same as the max temperature aggregation you did 
previously.

setup2:

Describe all the thermal zones in the DT [3], but add the cooling device 
only on the sensor you are interested in mitigating.


And finally, if the sensors should be used to describe a kind of 
temperature gradient, a linear equation could be used but that is not 
implemented yet in the thermal framework.

Hope that helps

   -- Daniel

[1] 
https://lore.kernel.org/linux-arm-kernel/5dd5c795-5e67-146d-7132-30fc90171d4c@collabora.com/T/#Z2e.:..:20230124131717.128660-3-bchihi::40baylibre.com:1include:dt-bindings:thermal:mediatek-lvts.h

[2] 
https://lore.kernel.org/linux-arm-kernel/5dd5c795-5e67-146d-7132-30fc90171d4c@collabora.com/T/#m303240c4da71f6f37831e5d1b6f3da771ae8dd90

[3] 
https://lore.kernel.org/linux-arm-kernel/5dd5c795-5e67-146d-7132-30fc90171d4c@collabora.com/T/#Z2e.:..:20230124131717.128660-6-bchihi::40baylibre.com:1arch:arm64:boot:dts:mediatek:mt8195.dtsi


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

