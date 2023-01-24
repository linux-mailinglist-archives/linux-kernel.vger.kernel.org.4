Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4C867A5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjAXW1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbjAXW1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:27:47 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D9644A1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:27:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso57175wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmjm3Z829U3eQ0HD7RpgQ6QYQN7YmYNmxztlfIbUa3s=;
        b=qKkFDQZcyvsrKMBBuR0L3F2Ue12BBua/+IGpL5PYXj42IfmbIk7GCNpjsGTlNboBY+
         hrNhUkQ0Y1o9KCcyi9g1jHGP/fqYc+/C/78N7UBBxLy1EOZvLLnu7nSQDTu0dwQQkJci
         kWp57evylzpB6O50bYTtbZJ0+RCzKQjSVciZVsUi76gk11ghiNlp2Ui6o81SnI1RlLOy
         L2H2kt8CXzswNirTU7/a24Cg76KG+SXjXZoh7KaCZig7wS8WuMrSAjqFqpSy9EbSO1V7
         SqF39G7nuhjAPXZETrPN8FNyTi+CMhanYURNGqvyt9mu5XWOjgdYzXHSCWyUQHTOuTD/
         y3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmjm3Z829U3eQ0HD7RpgQ6QYQN7YmYNmxztlfIbUa3s=;
        b=5r5BIdT1JNz5tDcBHrII9m6A4TBS6R3n9UHz6Sy5wvnvKS2R8RwbSlisk1h9ldlDGR
         6VUUDrM8chWUPo2IfIiA9CcQHoxmewx1xSIjn3nj8dMXwiiyO/XUZ5bKz5KhFBtVfjkM
         mR9v/oCxHtEXoZrOMuRYHQ12xPZj1Z6KUXuwoFry2jv/v3OXt0GtxXncRoFbKZQrrHNf
         /1cRg1dI+DARaPn7RKxTl4qhItvNOrzuT/H91y63tcY9Yz+b7p19wPm2gX7EPFzoFlSI
         XfWHkalU7HZVc25u12qk+2cgNGnQwIQpf06C5VFMuLQqUUnMnz0zAHz9dL6XELoUavLG
         HrLA==
X-Gm-Message-State: AFqh2krl9uNkoHS0FvWW934bPUdIrsxhR5MACPPjRxk/wqLxzZtoY3Lx
        JmlYVaKNisBPi5PuzlPO7Gc8vw==
X-Google-Smtp-Source: AMrXdXtUIhIbk+FfYfm8bkmmKEpk9WmMbkLiISQPuqi+mTwK8Cf7fynMGVuZBW+nCEzqHn41DSs8cA==
X-Received: by 2002:a05:600c:3512:b0:3db:1665:2a98 with SMTP id h18-20020a05600c351200b003db16652a98mr24655553wmq.16.1674599262543;
        Tue, 24 Jan 2023 14:27:42 -0800 (PST)
Received: from [192.168.0.20] (62.213.132.195.rev.sfr.net. [195.132.213.62])
        by smtp.gmail.com with ESMTPSA id bd25-20020a05600c1f1900b003dafa04ecc4sm105977wmb.6.2023.01.24.14.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 14:27:41 -0800 (PST)
Message-ID: <0b5e3a14-fd23-4646-d4cb-df255eb8fa20@baylibre.com>
Date:   Tue, 24 Jan 2023 23:27:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v7 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
Content-Language: en-US
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
 <187b0fe1-1f14-d8b8-c827-1e824da0b1d3@baylibre.com>
 <d3daece0-ed23-fae7-9bc8-c6e53b84e8e7@baylibre.com>
 <9f9547a2-69dd-f91d-c587-289156bf9d55@linaro.org>
 <2950b824-ad2f-2579-a956-a03d157453eb@baylibre.com>
 <c1fad818-1858-2e81-84fd-03cfb54d8938@linaro.org>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <c1fad818-1858-2e81-84fd-03cfb54d8938@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/24/23 18:55, Daniel Lezcano wrote:
> On 24/01/2023 18:46, Amjad Ouled-Ameur wrote:
>>
>> On 1/24/23 17:54, Daniel Lezcano wrote:
>>>
>>> Hi Amjad,
>>>
>>> On 24/01/2023 11:08, Amjad Ouled-Ameur wrote:
>>>
>>> [ ... ]
>>>
>>>>>>
>>>>>> IIUC, there is a sensor per couple of cores. 1 x 2Bigs, 1 x 2Bigs, 1 x 4 Little, right ?
>>>>>
>>>>> MT8365 SoC has 4 x A53 CPUs. The SoC has 4 thermal zones per sensor. Thermal zone 0 corresponds
>>>>>
>>>>> to all 4 x A53 CPUs, the other thermal zones (1, 2 and 3) has nothing to do with CPUs. The cooling device type
>>>>>
>>>>> used for CPUs is passive. FYI, thermal zones 1, 2 and 3 are present in the SoC for debug-purpose only, they are not supposed
>>>>>
>>>>> to be used for production.
>>>>>
>>>> After reconsidering the fact that zones 1, 2 and 3 are only used for dev/debug, it might be best to avo >
>>>> aggregation as you suggested, and keep only support for zone 0 in this driver. Thus I suggest I send a V8
>>>>
>>>> where I keep only below fixes for this patch if that's okay with you:
>>>>
>>>> - Define "raw_to_mcelsius" function pointer for "struct thermal_bank_cfg".
>>>>
>>>> - Fix "mtk_thermal" variable in mtk_read_temp().
>>>>
>>>> - Set "mt->raw_to_mcelsius" in probe().
>>>>
>>>>
>>>> For zones 1, 2 and 3 we can later add a different driver specific for dev/debug to probe them to
>>>>
>>>> avoid confusion.
>>>
>>> You can add them in the driver and in the device tree, but just add the cooling device for the thermal zone 0.
>>
>> Thermal zone 0 uses CPU{0..3} for passive cooling, in this case we should register cooling device with
>>
>> cpufreq_cooling_register() for each CPU right ?
>
> No, the OF code device tree does already that. You just have to register the different thermal zones.
>
> Do you have a pointer to a device tree for this board and the thermal setup ?

Sure, here is a dtsi for MT8365 SoC which contains thermal nodes [0].

[0]: https://lore.kernel.org/linux-arm-kernel/20220531135026.238475-17-fparent@baylibre.com/#Z31arch:arm64:boot:dts:mediatek:mt8365.dtsi

>
>
