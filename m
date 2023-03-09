Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0016B2BD5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCIRRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCIRRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:17:04 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15502E4861
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 09:14:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f11so2597215wrv.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 09:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678382090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=etdPu7ZHR6s1G27l0n5keJNFGD1mGQTrUvf9WBbghdA=;
        b=152ZJWbdFi/reWXLpFL+Z8iItaLRegYplrUviJaFIf7l5BMGjNKLSeeT5EJSKlj8A0
         UVObjPqAuN7Cua5DmlSUXOfDbd/DwHGM4O39sXrRdtSmOiCDQ0Vk7gj2Nh7n7w30eP/H
         +RrEL/rN3oBZZ8xyPr5MVc6OneB5WFm616Hbv3neFg9QuiNDkeZouZXSdRv3HzJfRMzp
         y1XWntgyhLqHy2uLr6LoCWOhAsO7pCSH2Lwju9NICszo2/Q595DFAYVnpH2UifFx+pyt
         n46zuxiun/UtOVkj3yjlQPrzbJBZ821Q9uyRIzTidtQ2BgqWDWwiknChqH1CBFYTcVdI
         aUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678382090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etdPu7ZHR6s1G27l0n5keJNFGD1mGQTrUvf9WBbghdA=;
        b=4J6xCTVspyGMHfV4KmGrdr1tLOn8g0sbWnrNYt3Z4o6kTbh5d3MnTg5KCcNlslkQjo
         XXQTDthjf86nx4IgUoL6EuL6fcteWZuqI3bsBEBaFM3d76zVGwLQ8ukznhDxIsVM5Y21
         g7PTXfXW2lhE6jJgXNf3U+riuNP5/Q3JVrCB7/mYUJn68tx/sC37MrMrVUdj+A0yB3K7
         LTwyB5p7NSLTq3Z96n5FcOFFOBvVP91ASLvj84hL7Ak3Ba2IOx0LvmgRvgtYSgzUf2gw
         i/Q4IZgYtdjraxvl4y92VhbH7yhSOH8TWZ763lwxonIdfy4OSTW4NheQT6ZMiXj5ti2c
         o87A==
X-Gm-Message-State: AO0yUKXGQDkvzDyN+f0ZBmLgxtj7hPfRHunh4Xop4K1yDtDEUBcmi2+9
        45ie9oHD7k94PIYA1IPGWINNAA==
X-Google-Smtp-Source: AK7set/wQdg094HolkqpN/B63LJ58ZKbcq1wqCEBpKsbTQRpdSfArJikyYC7VtJsbK2OJ7Q5qIGfXQ==
X-Received: by 2002:adf:fe47:0:b0:2c7:1a96:efcd with SMTP id m7-20020adffe47000000b002c71a96efcdmr14438370wrs.1.1678382089656;
        Thu, 09 Mar 2023 09:14:49 -0800 (PST)
Received: from [192.168.0.20] (ip-87.net-80-236-117.rev.numericable.fr. [80.236.117.87])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d408e000000b002bfd524255esm18257200wrp.43.2023.03.09.09.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 09:14:48 -0800 (PST)
Message-ID: <1e4ff264-523e-7d40-f487-5ed535a520ea@baylibre.com>
Date:   Thu, 9 Mar 2023 18:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 2/5] thermal: mediatek: control buffer enablement
 tweaks
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
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
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <eb3b9439-172b-daea-8f0f-53c8fe7648f9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 1/27/23 22:48, Daniel Lezcano wrote:
> On 27/01/2023 16:44, Amjad Ouled-Ameur wrote:
>> From: Markus Schneider-Pargmann <msp@baylibre.com>
>>
>> Add logic in order to be able to turn on the control buffer on MT8365.
>> This change now allows to have control buffer support for MTK_THERMAL_V1,
>> and it allows to define the register offset, and mask used to enable it.
>>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/thermal/mtk_thermal.c | 25 ++++++++++++++++++-------
>>   1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
>> index 8440692e3890..d8ddceb75372 100644
>> --- a/drivers/thermal/mtk_thermal.c
>> +++ b/drivers/thermal/mtk_thermal.c
>> @@ -271,6 +271,9 @@ struct mtk_thermal_data {
>>       bool need_switch_bank;
>>       struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
>>       enum mtk_thermal_version version;
>> +    u32 apmixed_buffer_ctl_reg;
>> +    u32 apmixed_buffer_ctl_mask;
>> +    u32 apmixed_buffer_ctl_set;
>>   };
>>     struct mtk_thermal {
>> @@ -514,6 +517,9 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
>>       .adcpnp = mt7622_adcpnp,
>>       .sensor_mux_values = mt7622_mux_values,
>>       .version = MTK_THERMAL_V2,
>> +    .apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
>> +    .apmixed_buffer_ctl_mask = GENMASK(31, 6) | BIT(3),
>> +    .apmixed_buffer_ctl_set = BIT(0),
>>   };
>>     /*
>> @@ -963,14 +969,18 @@ static const struct of_device_id mtk_thermal_of_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
>>   -static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
>> +static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
>> +                       void __iomem *apmixed_base)
>>   {
>> -    int tmp;
>> +    u32 tmp;
>> +
>> +    if (!mt->conf->apmixed_buffer_ctl_reg)
>> +        return;
>>   -    tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
>> -    tmp &= ~(0x37);
>> -    tmp |= 0x1;
>> -    writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
>> +    tmp = readl(apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
>> +    tmp &= mt->conf->apmixed_buffer_ctl_mask;
>> +    tmp |= mt->conf->apmixed_buffer_ctl_set;
>> +    writel(tmp, apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
>>       udelay(200);
>>   }
>>   @@ -1070,8 +1080,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>           goto err_disable_clk_auxadc;
>>       }
>>   +    mtk_thermal_turn_on_buffer(mt, apmixed_base);
>> +
>>       if (mt->conf->version == MTK_THERMAL_V2) {
>> -        mtk_thermal_turn_on_buffer(apmixed_base);
>>           mtk_thermal_release_periodic_ts(mt, auxadc_base);
>>       }
>
> This change conflicts with commit 4f2ee0aa2e706
>
> I fixed it with:
>
> -       if (mt->conf->version != MTK_THERMAL_V1) {
> -               mtk_thermal_turn_on_buffer(apmixed_base);
> +       mtk_thermal_turn_on_buffer(apmixed_base);

This should rather be "mtk_thermal_turn_on_buffer(mt, apmixed_base);" as this patch

also adds mtk_thermal arg to the function.


Regards,

Amjad

> +
> +       if (mt->conf->version != MTK_THERMAL_V1)
>                 mtk_thermal_release_periodic_ts(mt, auxadc_base);
> -       }
>
> Let me know if there is something wrong.
>
>
