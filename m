Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA1167F5CB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjA1HwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjA1HwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:52:07 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E33577DE3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:52:04 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j17so4938492wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AwT09QFvbeIdYBJsfcmVCJn9nySi46ioy4UiTZXOQBU=;
        b=O9xMHDeSECxW7o24q/6NUFHzLv5SOU7LuUFzeYGUCKEUfx5ZJ3tE4pipR2JhWAP+jg
         hPoesVW7rhnn9xzLRSskElx6CmZTetOAxdvriYZEZTJ3pb68iL6YW2YkYWFg4wHIA6W9
         5xBJLfpPHq4CK6+Z536WA3f+hDRxMti0zb848BvE1aXs/kGND7eqyknPpj4d9vnu3vLK
         OL3D+AkI/gJ0VG58PsxRDY1/OamUADlhthBOy+c2/99cAyHEiW1M+ZlMgAs4eYJusHOG
         qhdU+mBXeUO9K12bPXjy8LTm0Wk86BNUNKc3vG8qiBAy+AmBL0E3kLLkVznbDvrsY/sc
         OV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwT09QFvbeIdYBJsfcmVCJn9nySi46ioy4UiTZXOQBU=;
        b=N2CQut8jlEqtRmU2BzAKuzRwSsBuYRFaqOmwmGhK/7SED79WIt4b8KtWR54y0iy26n
         16T8UALo1T3GnzgYqdx52ca6rJldp8OU+uXqbiNMypdk/txFPQ1QpuSQ6nektcuWJtsH
         8QZHDL9ReXlUrl/8GY1E1djPZrb9kYc3WA1DtafxN7XiYffAyHF3h7PLqcRuE18C0S1z
         ZHol+Qjr85LxZ7GHh7kDLJYdtTw6QnL4YRuIitq/OLOz5QEI5OLjPw6Is5T/XTPorN6U
         lo+x8iuikY685SXJVqylKP0ZUZ1nSLG61Ypdbao5zLa81Lk697Lu3zvWbP2qSNHxWBL3
         HUtQ==
X-Gm-Message-State: AFqh2koAJ/EU0Rj/h0AnzS5TrEfigntT3JyyAnCICNF0mJ5A6O9dtvIX
        rYxhFMa6tUerh6aqwkotbR4dNw==
X-Google-Smtp-Source: AMrXdXvSNekIIQS28DBo7WV5qCK0p341YhGJ92/g23fsqCqTUyMImv07j8DGXqwVqRJdkFHAGIuVOA==
X-Received: by 2002:a05:600c:3ba9:b0:3da:b40f:7a55 with SMTP id n41-20020a05600c3ba900b003dab40f7a55mr48469547wms.6.1674892323044;
        Fri, 27 Jan 2023 23:52:03 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v1-20020a5d6781000000b002b9b9445149sm6701742wru.54.2023.01.27.23.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 23:52:02 -0800 (PST)
Message-ID: <64b7e7f1-44ff-09fe-c292-40eaa30a76a1@linaro.org>
Date:   Sat, 28 Jan 2023 08:52:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 2/5] thermal: mediatek: control buffer enablement
 tweaks
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Michael Kao <michael.kao@mediatek.com>
References: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
 <20221018-up-i350-thermal-bringup-v9-2-55a1ae14af74@baylibre.com>
 <eb3b9439-172b-daea-8f0f-53c8fe7648f9@linaro.org>
 <df39cc8c-29db-f401-e1a2-1a3b7e962a7e@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <df39cc8c-29db-f401-e1a2-1a3b7e962a7e@baylibre.com>
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

On 27/01/2023 23:21, Amjad Ouled-Ameur wrote:
> 
> On 1/27/23 22:48, Daniel Lezcano wrote:
>> On 27/01/2023 16:44, Amjad Ouled-Ameur wrote:
>>> From: Markus Schneider-Pargmann <msp@baylibre.com>
>>>
>>> Add logic in order to be able to turn on the control buffer on MT8365.
>>> This change now allows to have control buffer support for 
>>> MTK_THERMAL_V1,
>>> and it allows to define the register offset, and mask used to enable it.
>>>
>>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>>> Reviewed-by: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   drivers/thermal/mtk_thermal.c | 25 ++++++++++++++++++-------
>>>   1 file changed, 18 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/thermal/mtk_thermal.c 
>>> b/drivers/thermal/mtk_thermal.c
>>> index 8440692e3890..d8ddceb75372 100644
>>> --- a/drivers/thermal/mtk_thermal.c
>>> +++ b/drivers/thermal/mtk_thermal.c
>>> @@ -271,6 +271,9 @@ struct mtk_thermal_data {
>>>       bool need_switch_bank;
>>>       struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
>>>       enum mtk_thermal_version version;
>>> +    u32 apmixed_buffer_ctl_reg;
>>> +    u32 apmixed_buffer_ctl_mask;
>>> +    u32 apmixed_buffer_ctl_set;
>>>   };
>>>     struct mtk_thermal {
>>> @@ -514,6 +517,9 @@ static const struct mtk_thermal_data 
>>> mt7622_thermal_data = {
>>>       .adcpnp = mt7622_adcpnp,
>>>       .sensor_mux_values = mt7622_mux_values,
>>>       .version = MTK_THERMAL_V2,
>>> +    .apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
>>> +    .apmixed_buffer_ctl_mask = GENMASK(31, 6) | BIT(3),
>>> +    .apmixed_buffer_ctl_set = BIT(0),
>>>   };
>>>     /*
>>> @@ -963,14 +969,18 @@ static const struct of_device_id 
>>> mtk_thermal_of_match[] = {
>>>   };
>>>   MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
>>>   -static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
>>> +static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
>>> +                       void __iomem *apmixed_base)
>>>   {
>>> -    int tmp;
>>> +    u32 tmp;
>>> +
>>> +    if (!mt->conf->apmixed_buffer_ctl_reg)
>>> +        return;
>>>   -    tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
>>> -    tmp &= ~(0x37);
>>> -    tmp |= 0x1;
>>> -    writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
>>> +    tmp = readl(apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
>>> +    tmp &= mt->conf->apmixed_buffer_ctl_mask;
>>> +    tmp |= mt->conf->apmixed_buffer_ctl_set;
>>> +    writel(tmp, apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
>>>       udelay(200);
>>>   }
>>>   @@ -1070,8 +1080,9 @@ static int mtk_thermal_probe(struct 
>>> platform_device *pdev)
>>>           goto err_disable_clk_auxadc;
>>>       }
>>>   +    mtk_thermal_turn_on_buffer(mt, apmixed_base);
>>> +
>>>       if (mt->conf->version == MTK_THERMAL_V2) {
>>> -        mtk_thermal_turn_on_buffer(apmixed_base);
>>>           mtk_thermal_release_periodic_ts(mt, auxadc_base);
>>>       }
>>
>> This change conflicts with commit 4f2ee0aa2e706
>>
>> I fixed it with:
>>
>> -       if (mt->conf->version != MTK_THERMAL_V1) {
>> -               mtk_thermal_turn_on_buffer(apmixed_base);
>> +       mtk_thermal_turn_on_buffer(apmixed_base);
>> +
>> +       if (mt->conf->version != MTK_THERMAL_V1)
>>                 mtk_thermal_release_periodic_ts(mt, auxadc_base);
>> -       }
>>
> I think it's rather MTK_THERMAL_V2 and not MTK_THERMAL_V1. Other than 
> that, it looks

It was before if (version == MTK_THERMAL_V2). Now there is a V3, so it 
is replaced by if (version != MTK_THERMAL_V1) in order to include the V3


>> Let me know if there is something wrong.
>>
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

