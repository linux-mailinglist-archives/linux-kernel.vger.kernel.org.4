Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E23608EBF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 19:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJVRD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 13:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJVRDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 13:03:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F371BF21B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:03:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u21so16769804edi.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMEJOs8rsFhAhsZPWWaHcq3vp7VFtPBUd+l2pbsoxiA=;
        b=dvYlFOdRg/4NTlEfV63r1JuX+xJP6eNfzEbgTQK9tLjyXuJAf/t8SDzr3z5jP96MJq
         qOrHGM4J4kUHeYA4PRuEyT1+IC09dKcItl7r36iivs1bz0vlpxc6H+z9gCwQjS7Yz9Dg
         rjRutVP4IqRzxp8ZTWK7BbnOAXm02oMvUoJrP5mjBmrpd8CpLJpdTSHik059DVqCLuyf
         iCPzUlb5QRGUGWl8Lp4LKe1VvASDnm7OMiD2zze15ryHt96x4fG+3WKUARPC+NQ/ma2W
         iYLszJ4XBgPefFhNQEB1HxxADZGYrJM6nL+zlzOnex6RDZZ0ZJ/Gjm0IPj4Nwm0XkxBQ
         CoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMEJOs8rsFhAhsZPWWaHcq3vp7VFtPBUd+l2pbsoxiA=;
        b=7w9avmVU78G1EDnAjWZ6Ongus7HKgVFTqpPdVZ3JqyKjwHdxMaKCuTK2CYchyM3FQJ
         rKexAVKHkLW/qsXPx+x1VPNMMubao8nyG42h2xhu88GpZlIdFVusQtdgQr2pcb1i6eXz
         /i3Lad8hDvGzVi6xdSynF898Wnlr7lsnMMucq/+NjgHnobrZ72R/eA1xl5eafkU7SCvd
         CWh/Z3nazWN3F3hrdpS58wF3K06gGpJyn2MIcsQ9HJsFlv0/bz1FjCuKNRKBGE45byM3
         NRgDJTpgNYGVdHUkuxJgDfK5ZMpygXRFP/o9U7rpDVy3qfJ6KSXmPmga8iMdzL3r02QY
         ym5g==
X-Gm-Message-State: ACrzQf2MrpY1UAJS9hCXD3xX6BhVv0nkE3i7AhGbUaF5CvZX7c3fg53g
        Cvcb8xfA3APJpwqk2nZIXn7x7g==
X-Google-Smtp-Source: AMsMyM4DmmgF16YuIV2sQhfY7/ByyCdcFHvL3XCoNKIWCxdQZ5rojnPTvFMcvIzvbB2CSVdBIBdvYA==
X-Received: by 2002:a05:6402:3215:b0:45c:97de:b438 with SMTP id g21-20020a056402321500b0045c97deb438mr22748644eda.7.1666458200377;
        Sat, 22 Oct 2022 10:03:20 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7b1d:c5f2:c85:8976? ([2a05:6e02:1041:c10:7b1d:c5f2:c85:8976])
        by smtp.googlemail.com with ESMTPSA id i18-20020a170906699200b007812ba2a360sm13306136ejr.149.2022.10.22.10.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 10:03:19 -0700 (PDT)
Message-ID: <904faa39-9435-b8a8-fa6f-1ade8d5b61f4@linaro.org>
Date:   Sat, 22 Oct 2022 19:03:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221018-up-i350-thermal-bringup-v6-4-c87b9f75550b@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 16:17, Amjad Ouled-Ameur wrote:
> Provide thermal zone to read thermal sensor in the SoC. We can read all the
> thermal sensors value in the SoC by the node /sys/class/thermal/
> 
> In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
> on the first read of sensor that often are bogus values.
> This can avoid following warning on boot:
> 
>    thermal thermal_zone6: failed to read out thermal zone (-13)
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Overall the series looks good to me, however there is a couple of things 
to fix. See below

> ---
>   drivers/thermal/mtk_thermal.c | 104 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 79 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 3a5df1440822..311ad611fdab 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -259,6 +259,11 @@ enum mtk_thermal_version {
>   
>   struct mtk_thermal;
>   
> +struct mtk_thermal_zone {
> +	struct mtk_thermal *mt;
> +	int id;
> +};

Do you really need to create a new structure for that ?

>   struct thermal_bank_cfg {
>   	unsigned int num_sensors;
>   	const int *sensors;
> @@ -307,6 +312,8 @@ struct mtk_thermal {
>   
>   	const struct mtk_thermal_data *conf;
>   	struct mtk_thermal_bank banks[MAX_NUM_ZONES];
> +
> +	int (*raw_to_mcelsius)(struct mtk_thermal *mt, int sensno, s32 raw);
>   };
>   
>   /* MT8183 thermal sensor data */
> @@ -709,6 +716,29 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
>   		mutex_unlock(&mt->lock);
>   }
>   
> +static int _get_sensor_temp(struct mtk_thermal *mt, int id)
> +{
> +	u32 raw;
> +	int temp;
> +
> +	const struct mtk_thermal_data *conf = mt->conf;
> +
> +	raw = readl(mt->thermal_base + conf->msr[id]);
> +
> +	temp = mt->raw_to_mcelsius(mt, id, raw);
> +
> +	/*
> +	 * The first read of a sensor often contains very high bogus
> +	 * temperature value. Filter these out so that the system does
> +	 * not immediately shut down.
> +	 */
> +
> +	if (temp > 200000)
> +		return -EAGAIN;
> +	else
> +		return temp;
> +}
> +
>   /**
>    * mtk_thermal_bank_temperature - get the temperature of a bank
>    * @bank:	The bank
> @@ -721,26 +751,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   	struct mtk_thermal *mt = bank->mt;
>   	const struct mtk_thermal_data *conf = mt->conf;
>   	int i, temp = INT_MIN, max = INT_MIN;
> -	u32 raw;
>   
>   	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
> -		raw = readl(mt->thermal_base + conf->msr[i]);
> -
> -		if (mt->conf->version == MTK_THERMAL_V1) {
> -			temp = raw_to_mcelsius_v1(
> -				mt, conf->bank_data[bank->id].sensors[i], raw);
> -		} else {
> -			temp = raw_to_mcelsius_v2(
> -				mt, conf->bank_data[bank->id].sensors[i], raw);
> -		}
> -
> -		/*
> -		 * The first read of a sensor often contains very high bogus
> -		 * temperature value. Filter these out so that the system does
> -		 * not immediately shut down.
> -		 */
> -		if (temp > 200000)
> -			temp = 0;
> +		temp = _get_sensor_temp(mt, i);
>   
>   		if (temp > max)
>   			max = temp;
> @@ -749,9 +762,10 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   	return max;
>   }
>   
> -static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
> +static int mtk_read_temp(struct thermal_zone_device *tzdev, int *temperature)
>   {
> -	struct mtk_thermal *mt = tz->devdata;
> +	struct mtk_thermal_zone *tz = tzdev->devdata;
> +	struct mtk_thermal *mt = tz->mt;
>   	int i;
>   	int tempmax = INT_MIN;
>   
> @@ -770,10 +784,28 @@ static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
>   	return 0;
>   }
>   
> +static int mtk_read_sensor_temp(struct thermal_zone_device *tzdev, int *temperature)
> +{
> +	struct mtk_thermal_zone *tz = tzdev->devdata;
> +	struct mtk_thermal *mt = tz->mt;
> +	int id = tz->id - 1;
> +
> +	if (id < 0)
> +		return -EACCES;
> +
> +	*temperature = _get_sensor_temp(mt, id);
> +
> +	return 0;
> +}
> +
>   static const struct thermal_zone_device_ops mtk_thermal_ops = {
>   	.get_temp = mtk_read_temp,
>   };
>   
> +static const struct thermal_zone_device_ops mtk_thermal_sensor_ops = {
> +	.get_temp = mtk_read_sensor_temp,
> +};
> +
>   static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>   				  u32 apmixed_phys_base, u32 auxadc_phys_base,
>   				  int ctrl_id)
> @@ -1072,6 +1104,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   	u64 auxadc_phys_base, apmixed_phys_base;
>   	struct thermal_zone_device *tzdev;
>   	void __iomem *apmixed_base, *auxadc_base;
> +	struct mtk_thermal_zone *tz;
>   
>   	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>   	if (!mt)
> @@ -1150,6 +1183,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   
>   	mtk_thermal_turn_on_buffer(mt, apmixed_base);
>   
> +	mt->raw_to_mcelsius = (mt->conf->version == MTK_THERMAL_V1) ?
> +				raw_to_mcelsius_v1 : raw_to_mcelsius_v2;
> +
>   	if (mt->conf->version == MTK_THERMAL_V2) {
>   		mtk_thermal_release_periodic_ts(mt, auxadc_base);
>   	}
> @@ -1161,11 +1197,29 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, mt);
>   
> -	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
> -					      &mtk_thermal_ops);
> -	if (IS_ERR(tzdev)) {
> -		ret = PTR_ERR(tzdev);
> -		goto err_disable_clk_peri_therm;
> +	for (i = 0; i < mt->conf->num_sensors + 1; i++) {
> +		tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
> +		if (!tz)
> +			return -ENOMEM;
> +
> +		tz->mt = mt;
> +		tz->id = i;
> +
> +		tzdev = devm_thermal_of_zone_register(&pdev->dev, i, tz, (i == 0) ?
> +							     &mtk_thermal_ops :
> +							     &mtk_thermal_sensor_ops);

We want to prevent the aggregation from the different sensors within a 
driver. I know there is already a function doing that for the previous 
sensor version but that is something we don't want to continue.

Using mtk_thermal_ops tries to overcome this.

Also, the userspace needs to know to which device a thermal zone is 
related to. Here all the thermal zones have the same name so the 
userspace does not know if it is the GPU, the CPU, the chassis, the NPU, ...


> +
> +		if (IS_ERR(tzdev)) {
> +			if (PTR_ERR(tzdev) == -ENODEV) {
> +				dev_warn(&pdev->dev,
> +					 "sensor %d not registered in thermal zone in dt\n", i);

ENODEV is not considered an error, so the warning can be removed

> +				continue;
> +			}
> +			if (PTR_ERR(tzdev) == -EACCES) {

When devm_thermal_of_zone_register() returns -EACCES ?

> +				ret = PTR_ERR(tzdev);
> +				goto err_disable_clk_peri_therm;
> +			}
> +		}
>   	}
>   
>   	ret = devm_thermal_add_hwmon_sysfs(tzdev);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
