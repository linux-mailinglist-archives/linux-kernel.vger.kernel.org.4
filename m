Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446C9629AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKONqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiKONqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:46:47 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C42520BFA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:46:45 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so10301904wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKSVED77pBiwPpJ2Rxir+nKGuTDM1BFyofF1Zlc2DKM=;
        b=ajV3q/DBWIST9XnzaLUBlOUEBSdLAQqK1xUrmmix8OMOMNlF/Sky2+pKt3h41v2pMv
         2Q8zfjga/05QO/Wxrbr1kdI9Ma6O/pKaRDIldQDP44LRSMEViXjU9XDgH0/gT8sOvzAE
         EUjTyy+ZdQnV3JCE39/AJKutOV29A49uSWi7iKVNl/UYVnw0lpNLb8AEXub5gqIslSbM
         he8yGZs62o0EBrjHVoOtJn/kylV44U5prleVZz35sA5yx2RbfGgl7aafIyusiNN4vSBL
         wYX6b3mO/Nb787I28cQvLlaCLPRQrAdAxbII3jScpr67IxabycomE/+wHPF4ced7/QSA
         uhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKSVED77pBiwPpJ2Rxir+nKGuTDM1BFyofF1Zlc2DKM=;
        b=fcZHy0xNnzJ8WocSfy3EJctqDT9iBMFwBmWsgXkPwybP6hZ5BzRiCVHqhFsza52rXQ
         hZ6XPm1Qe/7F8JmwGXEAqxswdZra8PC5eUguTFz7GSSFUzWCnv3q2k7I+kWd80veYBgx
         efbITsVaj7JioqIwUcwixZhFPjuqK/hNZBsGm7jnDTBdQh+M/exFAaLEHauNEXUiuwim
         A5HjjI3v3cN2GwXKeO1MOKlXj4fqnzM3VcWeeGv/CbjOqniM5Oj2dz1n0AOHzlS4ofta
         xy2lLmhf4dG4EWiDHmdJLqjg9I1tUKyRkIkCyhADuICbz7sy7epQ6xLil2ijfTQjKmjx
         U1Eg==
X-Gm-Message-State: ANoB5pme7+3eaqcOanxIn1Dzl/dYg+iYa09p5Tk8ESMbekogy+0quQM9
        D4ttD2qthd6ismLOmQ6bPCTpAQ==
X-Google-Smtp-Source: AA0mqf5X5syFwbQSMWDFIqO7dVJyWje/diBdKJ0N7P3JuWEdDQfvhb0INF8arqz3z9IEe8X96oBSqA==
X-Received: by 2002:a05:600c:1c1d:b0:3cf:5d41:bea1 with SMTP id j29-20020a05600c1c1d00b003cf5d41bea1mr1630709wms.118.1668520003893;
        Tue, 15 Nov 2022 05:46:43 -0800 (PST)
Received: from [192.168.99.239] ([95.178.111.30])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05600c1e1300b003c6bbe910fdsm26460343wmb.9.2022.11.15.05.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 05:46:43 -0800 (PST)
Message-ID: <f2667872-c9e9-69aa-8196-12f58c2e9316@baylibre.com>
Date:   Tue, 15 Nov 2022 14:46:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
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
 <CAEXTbpd2zLdk-VmkGvpk2_Qz0TDyC9aOsQbCz=FpopnMqs9djg@mail.gmail.com>
Content-Language: en-US
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <CAEXTbpd2zLdk-VmkGvpk2_Qz0TDyC9aOsQbCz=FpopnMqs9djg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pin-yen,

On 11/15/22 11:49, Pin-yen Lin wrote:
> Hi Amjad,
>
> On Wed, Oct 19, 2022 at 10:17 PM Amjad Ouled-Ameur
> <aouledameur@baylibre.com> wrote:
>> Provide thermal zone to read thermal sensor in the SoC. We can read all the
>> thermal sensors value in the SoC by the node /sys/class/thermal/
>>
>> In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
>> on the first read of sensor that often are bogus values.
>> This can avoid following warning on boot:
>>
>>    thermal thermal_zone6: failed to read out thermal zone (-13)
>>
>> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/thermal/mtk_thermal.c | 104 ++++++++++++++++++++++++++++++++----------
>>   1 file changed, 79 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
>> index 3a5df1440822..311ad611fdab 100644
>> --- a/drivers/thermal/mtk_thermal.c
>> +++ b/drivers/thermal/mtk_thermal.c
>> @@ -259,6 +259,11 @@ enum mtk_thermal_version {
>>
>>   struct mtk_thermal;
>>
>> +struct mtk_thermal_zone {
>> +       struct mtk_thermal *mt;
>> +       int id;
>> +};
>> +
>>   struct thermal_bank_cfg {
>>          unsigned int num_sensors;
>>          const int *sensors;
>> @@ -307,6 +312,8 @@ struct mtk_thermal {
>>
>>          const struct mtk_thermal_data *conf;
>>          struct mtk_thermal_bank banks[MAX_NUM_ZONES];
>> +
>> +       int (*raw_to_mcelsius)(struct mtk_thermal *mt, int sensno, s32 raw);
>>   };
>>
>>   /* MT8183 thermal sensor data */
>> @@ -709,6 +716,29 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
>>                  mutex_unlock(&mt->lock);
>>   }
>>
>> +static int _get_sensor_temp(struct mtk_thermal *mt, int id)
>> +{
>> +       u32 raw;
>> +       int temp;
>> +
>> +       const struct mtk_thermal_data *conf = mt->conf;
>> +
>> +       raw = readl(mt->thermal_base + conf->msr[id]);
>> +
>> +       temp = mt->raw_to_mcelsius(mt, id, raw);
>> +
>> +       /*
>> +        * The first read of a sensor often contains very high bogus
>> +        * temperature value. Filter these out so that the system does
>> +        * not immediately shut down.
>> +        */
>> +
>> +       if (temp > 200000)
>> +               return -EAGAIN;
>> +       else
>> +               return temp;
>> +}
>> +
>>   /**
>>    * mtk_thermal_bank_temperature - get the temperature of a bank
>>    * @bank:      The bank
>> @@ -721,26 +751,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>>          struct mtk_thermal *mt = bank->mt;
>>          const struct mtk_thermal_data *conf = mt->conf;
>>          int i, temp = INT_MIN, max = INT_MIN;
>> -       u32 raw;
>>
>>          for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
>> -               raw = readl(mt->thermal_base + conf->msr[i]);
>> -
>> -               if (mt->conf->version == MTK_THERMAL_V1) {
>> -                       temp = raw_to_mcelsius_v1(
>> -                               mt, conf->bank_data[bank->id].sensors[i], raw);
>> -               } else {
>> -                       temp = raw_to_mcelsius_v2(
>> -                               mt, conf->bank_data[bank->id].sensors[i], raw);
>> -               }
>> -
>> -               /*
>> -                * The first read of a sensor often contains very high bogus
>> -                * temperature value. Filter these out so that the system does
>> -                * not immediately shut down.
>> -                */
>> -               if (temp > 200000)
>> -                       temp = 0;
>> +               temp = _get_sensor_temp(mt, i);
>>
>>                  if (temp > max)
>>                          max = temp;
>> @@ -749,9 +762,10 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>>          return max;
>>   }
>>
>> -static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
>> +static int mtk_read_temp(struct thermal_zone_device *tzdev, int *temperature)
>>   {
>> -       struct mtk_thermal *mt = tz->devdata;
>> +       struct mtk_thermal_zone *tz = tzdev->devdata;
>> +       struct mtk_thermal *mt = tz->mt;
>>          int i;
>>          int tempmax = INT_MIN;
>>
>> @@ -770,10 +784,28 @@ static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
>>          return 0;
>>   }
>>
>> +static int mtk_read_sensor_temp(struct thermal_zone_device *tzdev, int *temperature)
>> +{
>> +       struct mtk_thermal_zone *tz = tzdev->devdata;
>> +       struct mtk_thermal *mt = tz->mt;
>> +       int id = tz->id - 1;
>> +
>> +       if (id < 0)
>> +               return -EACCES;
>> +
>> +       *temperature = _get_sensor_temp(mt, id);
>> +
>> +       return 0;
>> +}
>> +
>>   static const struct thermal_zone_device_ops mtk_thermal_ops = {
>>          .get_temp = mtk_read_temp,
>>   };
>>
>> +static const struct thermal_zone_device_ops mtk_thermal_sensor_ops = {
>> +       .get_temp = mtk_read_sensor_temp,
>> +};
>> +
>>   static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>>                                    u32 apmixed_phys_base, u32 auxadc_phys_base,
>>                                    int ctrl_id)
>> @@ -1072,6 +1104,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>          u64 auxadc_phys_base, apmixed_phys_base;
>>          struct thermal_zone_device *tzdev;
>>          void __iomem *apmixed_base, *auxadc_base;
>> +       struct mtk_thermal_zone *tz;
>>
>>          mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>>          if (!mt)
>> @@ -1150,6 +1183,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>
>>          mtk_thermal_turn_on_buffer(mt, apmixed_base);
>>
>> +       mt->raw_to_mcelsius = (mt->conf->version == MTK_THERMAL_V1) ?
>> +                               raw_to_mcelsius_v1 : raw_to_mcelsius_v2;
>> +
>>          if (mt->conf->version == MTK_THERMAL_V2) {
>>                  mtk_thermal_release_periodic_ts(mt, auxadc_base);
>>          }
>> @@ -1161,11 +1197,29 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>
>>          platform_set_drvdata(pdev, mt);
>>
>> -       tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
>> -                                             &mtk_thermal_ops);
>> -       if (IS_ERR(tzdev)) {
>> -               ret = PTR_ERR(tzdev);
>> -               goto err_disable_clk_peri_therm;
>> +       for (i = 0; i < mt->conf->num_sensors + 1; i++) {
>> +               tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
>> +               if (!tz)
>> +                       return -ENOMEM;
>> +
>> +               tz->mt = mt;
>> +               tz->id = i;
>> +
>> +               tzdev = devm_thermal_of_zone_register(&pdev->dev, i, tz, (i == 0) ?
>> +                                                            &mtk_thermal_ops :
>> +                                                            &mtk_thermal_sensor_ops);
>> +
>> +               if (IS_ERR(tzdev)) {
>> +                       if (PTR_ERR(tzdev) == -ENODEV) {
>> +                               dev_warn(&pdev->dev,
>> +                                        "sensor %d not registered in thermal zone in dt\n", i);
>> +                               continue;
>> +                       }
>> +                       if (PTR_ERR(tzdev) == -EACCES) {
>> +                               ret = PTR_ERR(tzdev);
>> +                               goto err_disable_clk_peri_therm;
>> +                       }
>> +               }
>>          }
>>
>>          ret = devm_thermal_add_hwmon_sysfs(tzdev);
> tzdev can be an error pointer here. I think we should move the line
> into the loop above, so hwmon sysfs is not added when IS_ERR(tzdev) ==
> true.

Good catch, will fix this in next rev.

Regards,

Amjad

> Regards,
> Pin-yen
