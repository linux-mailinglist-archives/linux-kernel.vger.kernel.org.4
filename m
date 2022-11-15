Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D69C629648
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbiKOKun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238351AbiKOKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:49:54 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2862025C62
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:49:53 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id a5so21254906edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MgfvtjWpUyCcngkAsp0WSy9MN/6jQcOcrSZ1puz0tzE=;
        b=c7Xb10ntWnmK5qhaPrZ0sSfc94vAt36h7qSx6WdiCXugC/sawwR079ngJ4fBpfSD3l
         6ZEoSqwQ1Dy7Bbd86I0ALHC97KBFEQ1XBPyiblMq7nyZVdqU98ika0SMk6ud40FaWaof
         LF446r+u17ZkC0amqvHTVddbbR/H9ofWs7q/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgfvtjWpUyCcngkAsp0WSy9MN/6jQcOcrSZ1puz0tzE=;
        b=H5zbMMssVyl4ae+DLMuDDDoLKzwNusxwA/5cdXDpI2T86CgOwEQH8uIbxweGU6WTGf
         d7SeMW44pgPzT68xWEiIA8xR8QfiUyQxH9Wc2H2BLwwzHwbWa7vmulqB2k86HTnEsET8
         MRP2Qk7GpnHqT3lBrsu+gNQ/kPl4Nxk7BPSY6IQfIhWR+TADBZaiWMLqhKYW6KRe8LxC
         1Pqx4e0wvhy2jmDJ/CUyW2IfnJLtkclbgtRd0cU0M/sUiVERgjP4eHgov8VV6Zub7EmN
         atSZw9PwqUGEyM/hIrr+pps5erHZT0TSClUh57SDH7++VCw3Vp4FXj4LI4W0jyvb5bBz
         exPg==
X-Gm-Message-State: ANoB5pnKxMo97zp4xcwcBeYd1H7eDKSoBDA6H28KRzcCqqwO5wg+n1pB
        larD1Us+48sq2Eg+P3kAl9oC52VWKuEutdDzgKuBcA==
X-Google-Smtp-Source: AA0mqf7Zyg6WawPT7Tna1gAq72a4ziGX+mFjPdYsJ7neaPLo97UI4HoB6yml4mdouC5vAq58QJOaHg+s1MYMpi1apEI=
X-Received: by 2002:aa7:d482:0:b0:467:78f2:d81f with SMTP id
 b2-20020aa7d482000000b0046778f2d81fmr11755071edr.88.1668509391652; Tue, 15
 Nov 2022 02:49:51 -0800 (PST)
MIME-Version: 1.0
References: <20221018-up-i350-thermal-bringup-v6-0-c87b9f75550b@baylibre.com> <20221018-up-i350-thermal-bringup-v6-4-c87b9f75550b@baylibre.com>
In-Reply-To: <20221018-up-i350-thermal-bringup-v6-4-c87b9f75550b@baylibre.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Tue, 15 Nov 2022 18:49:40 +0800
Message-ID: <CAEXTbpd2zLdk-VmkGvpk2_Qz0TDyC9aOsQbCz=FpopnMqs9djg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amjad,

On Wed, Oct 19, 2022 at 10:17 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
> Provide thermal zone to read thermal sensor in the SoC. We can read all the
> thermal sensors value in the SoC by the node /sys/class/thermal/
>
> In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
> on the first read of sensor that often are bogus values.
> This can avoid following warning on boot:
>
>   thermal thermal_zone6: failed to read out thermal zone (-13)
>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/thermal/mtk_thermal.c | 104 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 79 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 3a5df1440822..311ad611fdab 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -259,6 +259,11 @@ enum mtk_thermal_version {
>
>  struct mtk_thermal;
>
> +struct mtk_thermal_zone {
> +       struct mtk_thermal *mt;
> +       int id;
> +};
> +
>  struct thermal_bank_cfg {
>         unsigned int num_sensors;
>         const int *sensors;
> @@ -307,6 +312,8 @@ struct mtk_thermal {
>
>         const struct mtk_thermal_data *conf;
>         struct mtk_thermal_bank banks[MAX_NUM_ZONES];
> +
> +       int (*raw_to_mcelsius)(struct mtk_thermal *mt, int sensno, s32 raw);
>  };
>
>  /* MT8183 thermal sensor data */
> @@ -709,6 +716,29 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
>                 mutex_unlock(&mt->lock);
>  }
>
> +static int _get_sensor_temp(struct mtk_thermal *mt, int id)
> +{
> +       u32 raw;
> +       int temp;
> +
> +       const struct mtk_thermal_data *conf = mt->conf;
> +
> +       raw = readl(mt->thermal_base + conf->msr[id]);
> +
> +       temp = mt->raw_to_mcelsius(mt, id, raw);
> +
> +       /*
> +        * The first read of a sensor often contains very high bogus
> +        * temperature value. Filter these out so that the system does
> +        * not immediately shut down.
> +        */
> +
> +       if (temp > 200000)
> +               return -EAGAIN;
> +       else
> +               return temp;
> +}
> +
>  /**
>   * mtk_thermal_bank_temperature - get the temperature of a bank
>   * @bank:      The bank
> @@ -721,26 +751,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>         struct mtk_thermal *mt = bank->mt;
>         const struct mtk_thermal_data *conf = mt->conf;
>         int i, temp = INT_MIN, max = INT_MIN;
> -       u32 raw;
>
>         for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
> -               raw = readl(mt->thermal_base + conf->msr[i]);
> -
> -               if (mt->conf->version == MTK_THERMAL_V1) {
> -                       temp = raw_to_mcelsius_v1(
> -                               mt, conf->bank_data[bank->id].sensors[i], raw);
> -               } else {
> -                       temp = raw_to_mcelsius_v2(
> -                               mt, conf->bank_data[bank->id].sensors[i], raw);
> -               }
> -
> -               /*
> -                * The first read of a sensor often contains very high bogus
> -                * temperature value. Filter these out so that the system does
> -                * not immediately shut down.
> -                */
> -               if (temp > 200000)
> -                       temp = 0;
> +               temp = _get_sensor_temp(mt, i);
>
>                 if (temp > max)
>                         max = temp;
> @@ -749,9 +762,10 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>         return max;
>  }
>
> -static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
> +static int mtk_read_temp(struct thermal_zone_device *tzdev, int *temperature)
>  {
> -       struct mtk_thermal *mt = tz->devdata;
> +       struct mtk_thermal_zone *tz = tzdev->devdata;
> +       struct mtk_thermal *mt = tz->mt;
>         int i;
>         int tempmax = INT_MIN;
>
> @@ -770,10 +784,28 @@ static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
>         return 0;
>  }
>
> +static int mtk_read_sensor_temp(struct thermal_zone_device *tzdev, int *temperature)
> +{
> +       struct mtk_thermal_zone *tz = tzdev->devdata;
> +       struct mtk_thermal *mt = tz->mt;
> +       int id = tz->id - 1;
> +
> +       if (id < 0)
> +               return -EACCES;
> +
> +       *temperature = _get_sensor_temp(mt, id);
> +
> +       return 0;
> +}
> +
>  static const struct thermal_zone_device_ops mtk_thermal_ops = {
>         .get_temp = mtk_read_temp,
>  };
>
> +static const struct thermal_zone_device_ops mtk_thermal_sensor_ops = {
> +       .get_temp = mtk_read_sensor_temp,
> +};
> +
>  static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>                                   u32 apmixed_phys_base, u32 auxadc_phys_base,
>                                   int ctrl_id)
> @@ -1072,6 +1104,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>         u64 auxadc_phys_base, apmixed_phys_base;
>         struct thermal_zone_device *tzdev;
>         void __iomem *apmixed_base, *auxadc_base;
> +       struct mtk_thermal_zone *tz;
>
>         mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>         if (!mt)
> @@ -1150,6 +1183,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>
>         mtk_thermal_turn_on_buffer(mt, apmixed_base);
>
> +       mt->raw_to_mcelsius = (mt->conf->version == MTK_THERMAL_V1) ?
> +                               raw_to_mcelsius_v1 : raw_to_mcelsius_v2;
> +
>         if (mt->conf->version == MTK_THERMAL_V2) {
>                 mtk_thermal_release_periodic_ts(mt, auxadc_base);
>         }
> @@ -1161,11 +1197,29 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, mt);
>
> -       tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
> -                                             &mtk_thermal_ops);
> -       if (IS_ERR(tzdev)) {
> -               ret = PTR_ERR(tzdev);
> -               goto err_disable_clk_peri_therm;
> +       for (i = 0; i < mt->conf->num_sensors + 1; i++) {
> +               tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
> +               if (!tz)
> +                       return -ENOMEM;
> +
> +               tz->mt = mt;
> +               tz->id = i;
> +
> +               tzdev = devm_thermal_of_zone_register(&pdev->dev, i, tz, (i == 0) ?
> +                                                            &mtk_thermal_ops :
> +                                                            &mtk_thermal_sensor_ops);
> +
> +               if (IS_ERR(tzdev)) {
> +                       if (PTR_ERR(tzdev) == -ENODEV) {
> +                               dev_warn(&pdev->dev,
> +                                        "sensor %d not registered in thermal zone in dt\n", i);
> +                               continue;
> +                       }
> +                       if (PTR_ERR(tzdev) == -EACCES) {
> +                               ret = PTR_ERR(tzdev);
> +                               goto err_disable_clk_peri_therm;
> +                       }
> +               }
>         }
>
>         ret = devm_thermal_add_hwmon_sysfs(tzdev);
tzdev can be an error pointer here. I think we should move the line
into the loop above, so hwmon sysfs is not added when IS_ERR(tzdev) ==
true.

Regards,
Pin-yen
