Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EA5617F73
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiKCO0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKCO02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:26:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C19EDF67
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:26:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso3929229wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOw2yYZIUmeMvyTMDW5pPgN8uhLMpX4QdcL3N3+n7tk=;
        b=XzHpUKCjxmhU4sAP6NZFb5YohU2VXZeJS/BB5aqo9r8McemMnFLwGyCv0gPi+n8Ykc
         xwLmx86spwNbOLBLY0+XRw18D5mi1OT03dRWr9OicaZf+59z0t60T3fjyVyeO7TQXk+i
         eoCRGrxzjjvGV+zRXNRSlSt7yy2lLHVvWFonIIl1QY7/GlaDbq2mSA5Es3K3I/XPky2M
         XQMnn2ii1Aq01lJB6PSjFhFVcTQjkjazWmKfa770YiuxNwybPRAQ0rYqF3EI7NWdW+g+
         sw1yyy2uHIeMvLSZPAu9saHbt4wemyBc2A7VfleIBtl0x/53OGKL9ouvbywC+xjPtS/h
         /yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOw2yYZIUmeMvyTMDW5pPgN8uhLMpX4QdcL3N3+n7tk=;
        b=iKxV5hn52fizIi1321QdFAF234GjHuWhcnuwBOODgR7WSey3byKScrPCHSEYRVrs2Q
         EZouAvQ5wfTsFAI7e/ceChuYIb0KhCUEMNNlcaWvgQwVeWSCyxPPkkuSzK17OOL3uxqd
         kB1baZl5n/NSBWVHQRuqbVADzDweA+oYwFJ0Fqa1SwWZpjIEbZLBoeSXzRMLV7RU3o2h
         Yw142aqNxfZ0ZS+x/Wd7MWwPrWfaqoz8AeUM3Rv7ALRD8Q8KSIkTl2dOVCT8Tnmth/kC
         R+xySJWpKMmJCzCZDs1q1rLhal+4oBedRJbMvE00F07P3Lb1uMSCOIg+vwj11xtwzfxv
         OGrQ==
X-Gm-Message-State: ACrzQf3yekJ3eqpGveNrtzIhT95k00VgGq5KSpqLe0Bwr2/t6wD0m1HT
        9if/14dPTHFSkvYp95hDoDAgVA==
X-Google-Smtp-Source: AMsMyM5Kph4XeWfCOPPsaqtVaCMay3OuCBIbWh9FwN7TQsWfUQCxfg5LIpnNkUPTPB1IyLo0lz9bmQ==
X-Received: by 2002:a05:600c:4fd2:b0:3c6:db8a:4d2a with SMTP id o18-20020a05600c4fd200b003c6db8a4d2amr19445068wmq.178.1667485584383;
        Thu, 03 Nov 2022 07:26:24 -0700 (PDT)
Received: from [192.168.0.20] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.gmail.com with ESMTPSA id d19-20020adfa353000000b002366553eca7sm959539wrb.83.2022.11.03.07.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 07:26:23 -0700 (PDT)
Message-ID: <5eb0cdc2-e9f9-dd42-bf80-b7dcd8bcc196@baylibre.com>
Date:   Thu, 3 Nov 2022 15:26:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v6 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org, Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Kao <michael.kao@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20221018-up-i350-thermal-bringup-v6-0-c87b9f75550b@baylibre.com>
 <20221018-up-i350-thermal-bringup-v6-4-c87b9f75550b@baylibre.com>
 <904faa39-9435-b8a8-fa6f-1ade8d5b61f4@linaro.org>
Content-Language: en-US
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <904faa39-9435-b8a8-fa6f-1ade8d5b61f4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thank you for the review.

On 10/22/22 19:03, Daniel Lezcano wrote:
> On 19/10/2022 16:17, Amjad Ouled-Ameur wrote:
>> Provide thermal zone to read thermal sensor in the SoC. We can read all the
>> thermal sensors value in the SoC by the node /sys/class/thermal/
>>
>> In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
>> on the first read of sensor that often are bogus values.
>> This can avoid following warning on boot:
>>
>>    thermal thermal_zone6: failed to read out thermal zone (-13)
>>
>> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
> Overall the series looks good to me, however there is a couple of things to fix. See below
>
>> ---
>>   drivers/thermal/mtk_thermal.c | 104 ++++++++++++++++++++++++++++++++----------
>>   1 file changed, 79 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
>> index 3a5df1440822..311ad611fdab 100644
>> --- a/drivers/thermal/mtk_thermal.c
>> +++ b/drivers/thermal/mtk_thermal.c
>> @@ -259,6 +259,11 @@ enum mtk_thermal_version {
>>     struct mtk_thermal;
>>   +struct mtk_thermal_zone {
>> +    struct mtk_thermal *mt;
>> +    int id;
>> +};
>
> Do you really need to create a new structure for that ?

We need to store the sensor index in the private data, along with mtk_thermal.

Aside from having this new structure, I don't see how .get_temp() can tell which

sensor index to read.

>
>>   struct thermal_bank_cfg {
>>       unsigned int num_sensors;
>>       const int *sensors;
>> @@ -307,6 +312,8 @@ struct mtk_thermal {
>>         const struct mtk_thermal_data *conf;
>>       struct mtk_thermal_bank banks[MAX_NUM_ZONES];
>> +
>> +    int (*raw_to_mcelsius)(struct mtk_thermal *mt, int sensno, s32 raw);
>>   };
>>     /* MT8183 thermal sensor data */
>> @@ -709,6 +716,29 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
>>           mutex_unlock(&mt->lock);
>>   }
>>   +static int _get_sensor_temp(struct mtk_thermal *mt, int id)
>> +{
>> +    u32 raw;
>> +    int temp;
>> +
>> +    const struct mtk_thermal_data *conf = mt->conf;
>> +
>> +    raw = readl(mt->thermal_base + conf->msr[id]);
>> +
>> +    temp = mt->raw_to_mcelsius(mt, id, raw);
>> +
>> +    /*
>> +     * The first read of a sensor often contains very high bogus
>> +     * temperature value. Filter these out so that the system does
>> +     * not immediately shut down.
>> +     */
>> +
>> +    if (temp > 200000)
>> +        return -EAGAIN;
>> +    else
>> +        return temp;
>> +}
>> +
>>   /**
>>    * mtk_thermal_bank_temperature - get the temperature of a bank
>>    * @bank:    The bank
>> @@ -721,26 +751,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>>       struct mtk_thermal *mt = bank->mt;
>>       const struct mtk_thermal_data *conf = mt->conf;
>>       int i, temp = INT_MIN, max = INT_MIN;
>> -    u32 raw;
>>         for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
>> -        raw = readl(mt->thermal_base + conf->msr[i]);
>> -
>> -        if (mt->conf->version == MTK_THERMAL_V1) {
>> -            temp = raw_to_mcelsius_v1(
>> -                mt, conf->bank_data[bank->id].sensors[i], raw);
>> -        } else {
>> -            temp = raw_to_mcelsius_v2(
>> -                mt, conf->bank_data[bank->id].sensors[i], raw);
>> -        }
>> -
>> -        /*
>> -         * The first read of a sensor often contains very high bogus
>> -         * temperature value. Filter these out so that the system does
>> -         * not immediately shut down.
>> -         */
>> -        if (temp > 200000)
>> -            temp = 0;
>> +        temp = _get_sensor_temp(mt, i);
>>             if (temp > max)
>>               max = temp;
>> @@ -749,9 +762,10 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>>       return max;
>>   }
>>   -static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
>> +static int mtk_read_temp(struct thermal_zone_device *tzdev, int *temperature)
>>   {
>> -    struct mtk_thermal *mt = tz->devdata;
>> +    struct mtk_thermal_zone *tz = tzdev->devdata;
>> +    struct mtk_thermal *mt = tz->mt;
>>       int i;
>>       int tempmax = INT_MIN;
>>   @@ -770,10 +784,28 @@ static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
>>       return 0;
>>   }
>>   +static int mtk_read_sensor_temp(struct thermal_zone_device *tzdev, int *temperature)
>> +{
>> +    struct mtk_thermal_zone *tz = tzdev->devdata;
>> +    struct mtk_thermal *mt = tz->mt;
>> +    int id = tz->id - 1;
>> +
>> +    if (id < 0)
>> +        return -EACCES;
>> +
>> +    *temperature = _get_sensor_temp(mt, id);
>> +
>> +    return 0;
>> +}
>> +
>>   static const struct thermal_zone_device_ops mtk_thermal_ops = {
>>       .get_temp = mtk_read_temp,
>>   };
>>   +static const struct thermal_zone_device_ops mtk_thermal_sensor_ops = {
>> +    .get_temp = mtk_read_sensor_temp,
>> +};
>> +
>>   static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>>                     u32 apmixed_phys_base, u32 auxadc_phys_base,
>>                     int ctrl_id)
>> @@ -1072,6 +1104,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>       u64 auxadc_phys_base, apmixed_phys_base;
>>       struct thermal_zone_device *tzdev;
>>       void __iomem *apmixed_base, *auxadc_base;
>> +    struct mtk_thermal_zone *tz;
>>         mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>>       if (!mt)
>> @@ -1150,6 +1183,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>         mtk_thermal_turn_on_buffer(mt, apmixed_base);
>>   +    mt->raw_to_mcelsius = (mt->conf->version == MTK_THERMAL_V1) ?
>> +                raw_to_mcelsius_v1 : raw_to_mcelsius_v2;
>> +
>>       if (mt->conf->version == MTK_THERMAL_V2) {
>>           mtk_thermal_release_periodic_ts(mt, auxadc_base);
>>       }
>> @@ -1161,11 +1197,29 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>         platform_set_drvdata(pdev, mt);
>>   -    tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
>> -                          &mtk_thermal_ops);
>> -    if (IS_ERR(tzdev)) {
>> -        ret = PTR_ERR(tzdev);
>> -        goto err_disable_clk_peri_therm;
>> +    for (i = 0; i < mt->conf->num_sensors + 1; i++) {
>> +        tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
>> +        if (!tz)
>> +            return -ENOMEM;
>> +
>> +        tz->mt = mt;
>> +        tz->id = i;
>> +
>> +        tzdev = devm_thermal_of_zone_register(&pdev->dev, i, tz, (i == 0) ?
>> +                                 &mtk_thermal_ops :
>> +                                 &mtk_thermal_sensor_ops);
>
> We want to prevent the aggregation from the different sensors within a driver. I know there is already a function doing that for the previous sensor version but that is something we don't want to continue.
>
> Using mtk_thermal_ops tries to overcome this.
>
So would it be more proper to have to distinct thermal drivers for each sensor ? Or relatively to the above implementation,

I think it might be better to have only one thermal_zone_device_ops, with storing the right get_temp callback in mtk_thermal_zone structure.


> Also, the userspace needs to know to which device a thermal zone is related to. Here all the thermal zones have the same name so the userspace does not know if it is the GPU, the CPU, the chassis, the NPU, ...

Which names are you referring to ? In case it is "sys/class/thermal/*/type", it is based on DT thermal nodes, the first sensor is marked as CPU-related,

The others are used for debugging purposes only.

>
>
>> +
>> +        if (IS_ERR(tzdev)) {
>> +            if (PTR_ERR(tzdev) == -ENODEV) {
>> +                dev_warn(&pdev->dev,
>> +                     "sensor %d not registered in thermal zone in dt\n", i);
>
> ENODEV is not considered an error, so the warning can be removed
Agreed, will drop this.
>
>> +                continue;
>> +            }
>> +            if (PTR_ERR(tzdev) == -EACCES) {
>
> When devm_thermal_of_zone_register() returns -EACCES ?

Right, I verified the code, -EACCES is never returned by devm_thermal_of_zone_register().


Regards,

Amjad

>
>> +                ret = PTR_ERR(tzdev);
>> +                goto err_disable_clk_peri_therm;
>> +            }
>> +        }
>>       }
>>         ret = devm_thermal_add_hwmon_sysfs(tzdev);
>>
>
