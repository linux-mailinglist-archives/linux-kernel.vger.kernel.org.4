Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9D628A96
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiKNUgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiKNUgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:36:33 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764C3E0A8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:36:30 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso8781230wmp.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rXJf8DUe+GljbluhhaH+sIK0Dch+Q5AMeV6azEr5owk=;
        b=Godcagv2q6iSd1mebLm36/ERyS3Z/Q4wDP+EHBIH2nJwZbsRthPs3TE5bPjzklbpWE
         5TukgWzKbR6RaqgXfs5+nYxG6lmK4ksk8Zec//ZVNFoZcJVUYmyGdz1nNCz8sd8tTrMD
         buyI/idKHjoVtcxGX8bWM3e9/2PsgFTOPKge8hQgAToltV6lihkc3EmIqzqP+W5BKWMD
         H4JTya0H5JixRsHHFM1obguSc4C77RRykDAd8cAGxI+ARbOe31qlU3ecQAvq0tZgplMa
         aYYedPDaGQuxL9GhN6zjOMOqsuh1T/dkz13jqp0fLiGalcQI3rHldnGcD3hHA3PlmNxu
         YWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXJf8DUe+GljbluhhaH+sIK0Dch+Q5AMeV6azEr5owk=;
        b=t7qi8PanOKPd8s3RJpjJYKvDJP5gWNbrgQiZ+7//hNlUl2j2rsJti8claVQK6ptJLV
         c55to/oPuHuZnsDGgkvZ4gUmMwnAR+NZYKwMgoIqwS6PPmNs2Wr+tDcgVryhDshflzhT
         eWHMp2ylnam4sn0GqskKqLrZYREVpZAs8lzoc5tTokSslhrNJvzGHSyS1EUhN5EbS7QM
         n4sPgodFx8FBYSPN8Vox+SYuFU2FAz1qdhs+VMUpNRroCK6rFeOYhuia59FMv5l/5+/Z
         nmzjZLLihq83ziO6irEtiJBtS/5lf61oe4HTx+XUvexU2b3AVJeBkHSLko/Oi7Ivy5l4
         njEw==
X-Gm-Message-State: ANoB5pkklz1ByxsyVl3tqqAPsTlbzTbGjFz32qbIA5f0bIjbGhEo9h17
        6uG2aUUOZQKj6dJEV/cgSkG4sQ==
X-Google-Smtp-Source: AA0mqf5vBYllEHNCzsahQ14HUAgGaMg2bogCAsd2tQqfKBieqVKHI45YmTTKXeMlgblS7QZyf96kWQ==
X-Received: by 2002:a05:600c:2d05:b0:3cf:a3b0:df6a with SMTP id x5-20020a05600c2d0500b003cfa3b0df6amr9072126wmf.126.1668458188788;
        Mon, 14 Nov 2022 12:36:28 -0800 (PST)
Received: from [192.168.0.20] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.gmail.com with ESMTPSA id n128-20020a1ca486000000b003cfd4a50d5asm10481561wme.34.2022.11.14.12.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 12:36:28 -0800 (PST)
Message-ID: <6ef7a3e2-5cd4-808c-a165-01eb4d2edd1c@baylibre.com>
Date:   Mon, 14 Nov 2022 21:36:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
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
 <5eb0cdc2-e9f9-dd42-bf80-b7dcd8bcc196@baylibre.com>
Content-Language: en-US
In-Reply-To: <5eb0cdc2-e9f9-dd42-bf80-b7dcd8bcc196@baylibre.com>
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

Do you have any feedback about my comments on your review before I send V7 ?

Regards,

Amjad

On 11/3/22 15:26, Amjad Ouled-Ameur wrote:
> Hi Daniel,
>
> Thank you for the review.
>
> On 10/22/22 19:03, Daniel Lezcano wrote:
>> On 19/10/2022 16:17, Amjad Ouled-Ameur wrote:
>>> Provide thermal zone to read thermal sensor in the SoC. We can read all the
>>> thermal sensors value in the SoC by the node /sys/class/thermal/
>>>
>>> In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
>>> on the first read of sensor that often are bogus values.
>>> This can avoid following warning on boot:
>>>
>>>    thermal thermal_zone6: failed to read out thermal zone (-13)
>>>
>>> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> Overall the series looks good to me, however there is a couple of things to fix. See below
>>
>>> ---
>>>   drivers/thermal/mtk_thermal.c | 104 ++++++++++++++++++++++++++++++++----------
>>>   1 file changed, 79 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
>>> index 3a5df1440822..311ad611fdab 100644
>>> --- a/drivers/thermal/mtk_thermal.c
>>> +++ b/drivers/thermal/mtk_thermal.c
>>> @@ -259,6 +259,11 @@ enum mtk_thermal_version {
>>>     struct mtk_thermal;
>>>   +struct mtk_thermal_zone {
>>> +    struct mtk_thermal *mt;
>>> +    int id;
>>> +};
>>
>> Do you really need to create a new structure for that ?
>
> We need to store the sensor index in the private data, along with mtk_thermal.
>
> Aside from having this new structure, I don't see how .get_temp() can tell which
>
> sensor index to read.
>
>>
>>>   struct thermal_bank_cfg {
>>>       unsigned int num_sensors;
>>>       const int *sensors;
>>> @@ -307,6 +312,8 @@ struct mtk_thermal {
>>>         const struct mtk_thermal_data *conf;
>>>       struct mtk_thermal_bank banks[MAX_NUM_ZONES];
>>> +
>>> +    int (*raw_to_mcelsius)(struct mtk_thermal *mt, int sensno, s32 raw);
>>>   };
>>>     /* MT8183 thermal sensor data */
>>> @@ -709,6 +716,29 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
>>>           mutex_unlock(&mt->lock);
>>>   }
>>>   +static int _get_sensor_temp(struct mtk_thermal *mt, int id)
>>> +{
>>> +    u32 raw;
>>> +    int temp;
>>> +
>>> +    const struct mtk_thermal_data *conf = mt->conf;
>>> +
>>> +    raw = readl(mt->thermal_base + conf->msr[id]);
>>> +
>>> +    temp = mt->raw_to_mcelsius(mt, id, raw);
>>> +
>>> +    /*
>>> +     * The first read of a sensor often contains very high bogus
>>> +     * temperature value. Filter these out so that the system does
>>> +     * not immediately shut down.
>>> +     */
>>> +
>>> +    if (temp > 200000)
>>> +        return -EAGAIN;
>>> +    else
>>> +        return temp;
>>> +}
>>> +
>>>   /**
>>>    * mtk_thermal_bank_temperature - get the temperature of a bank
>>>    * @bank:    The bank
>>> @@ -721,26 +751,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>>>       struct mtk_thermal *mt = bank->mt;
>>>       const struct mtk_thermal_data *conf = mt->conf;
>>>       int i, temp = INT_MIN, max = INT_MIN;
>>> -    u32 raw;
>>>         for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
>>> -        raw = readl(mt->thermal_base + conf->msr[i]);
>>> -
>>> -        if (mt->conf->version == MTK_THERMAL_V1) {
>>> -            temp = raw_to_mcelsius_v1(
>>> -                mt, conf->bank_data[bank->id].sensors[i], raw);
>>> -        } else {
>>> -            temp = raw_to_mcelsius_v2(
>>> -                mt, conf->bank_data[bank->id].sensors[i], raw);
>>> -        }
>>> -
>>> -        /*
>>> -         * The first read of a sensor often contains very high bogus
>>> -         * temperature value. Filter these out so that the system does
>>> -         * not immediately shut down.
>>> -         */
>>> -        if (temp > 200000)
>>> -            temp = 0;
>>> +        temp = _get_sensor_temp(mt, i);
>>>             if (temp > max)
>>>               max = temp;
>>> @@ -749,9 +762,10 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>>>       return max;
>>>   }
>>>   -static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
>>> +static int mtk_read_temp(struct thermal_zone_device *tzdev, int *temperature)
>>>   {
>>> -    struct mtk_thermal *mt = tz->devdata;
>>> +    struct mtk_thermal_zone *tz = tzdev->devdata;
>>> +    struct mtk_thermal *mt = tz->mt;
>>>       int i;
>>>       int tempmax = INT_MIN;
>>>   @@ -770,10 +784,28 @@ static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
>>>       return 0;
>>>   }
>>>   +static int mtk_read_sensor_temp(struct thermal_zone_device *tzdev, int *temperature)
>>> +{
>>> +    struct mtk_thermal_zone *tz = tzdev->devdata;
>>> +    struct mtk_thermal *mt = tz->mt;
>>> +    int id = tz->id - 1;
>>> +
>>> +    if (id < 0)
>>> +        return -EACCES;
>>> +
>>> +    *temperature = _get_sensor_temp(mt, id);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static const struct thermal_zone_device_ops mtk_thermal_ops = {
>>>       .get_temp = mtk_read_temp,
>>>   };
>>>   +static const struct thermal_zone_device_ops mtk_thermal_sensor_ops = {
>>> +    .get_temp = mtk_read_sensor_temp,
>>> +};
>>> +
>>>   static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>>>                     u32 apmixed_phys_base, u32 auxadc_phys_base,
>>>                     int ctrl_id)
>>> @@ -1072,6 +1104,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>>       u64 auxadc_phys_base, apmixed_phys_base;
>>>       struct thermal_zone_device *tzdev;
>>>       void __iomem *apmixed_base, *auxadc_base;
>>> +    struct mtk_thermal_zone *tz;
>>>         mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>>>       if (!mt)
>>> @@ -1150,6 +1183,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>>         mtk_thermal_turn_on_buffer(mt, apmixed_base);
>>>   +    mt->raw_to_mcelsius = (mt->conf->version == MTK_THERMAL_V1) ?
>>> +                raw_to_mcelsius_v1 : raw_to_mcelsius_v2;
>>> +
>>>       if (mt->conf->version == MTK_THERMAL_V2) {
>>>           mtk_thermal_release_periodic_ts(mt, auxadc_base);
>>>       }
>>> @@ -1161,11 +1197,29 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>>         platform_set_drvdata(pdev, mt);
>>>   -    tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
>>> -                          &mtk_thermal_ops);
>>> -    if (IS_ERR(tzdev)) {
>>> -        ret = PTR_ERR(tzdev);
>>> -        goto err_disable_clk_peri_therm;
>>> +    for (i = 0; i < mt->conf->num_sensors + 1; i++) {
>>> +        tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
>>> +        if (!tz)
>>> +            return -ENOMEM;
>>> +
>>> +        tz->mt = mt;
>>> +        tz->id = i;
>>> +
>>> +        tzdev = devm_thermal_of_zone_register(&pdev->dev, i, tz, (i == 0) ?
>>> +                                 &mtk_thermal_ops :
>>> + &mtk_thermal_sensor_ops);
>>
>> We want to prevent the aggregation from the different sensors within a driver. I know there is already a function doing that for the previous sensor version but that is something we don't want to continue.
>>
>> Using mtk_thermal_ops tries to overcome this.
>>
> So would it be more proper to have to distinct thermal drivers for each sensor ? Or relatively to the above implementation,
>
> I think it might be better to have only one thermal_zone_device_ops, with storing the right get_temp callback in mtk_thermal_zone structure.
>
>
>> Also, the userspace needs to know to which device a thermal zone is related to. Here all the thermal zones have the same name so the userspace does not know if it is the GPU, the CPU, the chassis, the NPU, ...
>
> Which names are you referring to ? In case it is "sys/class/thermal/*/type", it is based on DT thermal nodes, the first sensor is marked as CPU-related,
>
> The others are used for debugging purposes only.
>
>>
>>
>>> +
>>> +        if (IS_ERR(tzdev)) {
>>> +            if (PTR_ERR(tzdev) == -ENODEV) {
>>> +                dev_warn(&pdev->dev,
>>> +                     "sensor %d not registered in thermal zone in dt\n", i);
>>
>> ENODEV is not considered an error, so the warning can be removed
> Agreed, will drop this.
>>
>>> +                continue;
>>> +            }
>>> +            if (PTR_ERR(tzdev) == -EACCES) {
>>
>> When devm_thermal_of_zone_register() returns -EACCES ?
>
> Right, I verified the code, -EACCES is never returned by devm_thermal_of_zone_register().
>
>
> Regards,
>
> Amjad
>
>>
>>> +                ret = PTR_ERR(tzdev);
>>> +                goto err_disable_clk_peri_therm;
>>> +            }
>>> +        }
>>>       }
>>>         ret = devm_thermal_add_hwmon_sysfs(tzdev);
>>>
>>
