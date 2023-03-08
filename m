Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7836B10D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCHSOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjCHSOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:14:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC49670417
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:13:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so1698439wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 10:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678299204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqnDgNByCxKJMz7E61gZ4/wBvcfPmg0KpSzK4NDBPz4=;
        b=NMEnQHT+tczCVbLhYEtQpkzzaIJbbfRVYCrkHLIqR8xKE3iRP7AQIuNlEwHun8qWxI
         GAHgHWszxUdGaOoiPHnRbIwiU6yVkSN8Ruk1TKA0hbf+XUKfeyOXaHkspoK5O6+1n8wq
         6qIoAdJ/C+E+5CuxpW065fQ+ObYvM9RGJ4xwqF4ED8cdyzL/B0a46cSbNYuYuoH+Cu/8
         CbHKvgRQ1IbFpCpSWUUHgEfx1dR1er8IrAMRMtwvsvAy0RfVJSlJTuvBKHZ2mnQNzJ3W
         +Y9zIn9afNaVAK4M8Quc62pRt3TJXFXu2tBEK2rTKWT7o+8O1ZlRFkVvPJs1FWIr4eo+
         GsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678299204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqnDgNByCxKJMz7E61gZ4/wBvcfPmg0KpSzK4NDBPz4=;
        b=dFQFScy/LBdmAGDOUi41I23vyNAjSYG6qHoHndFHkrgLDXb7OU1GbqGcDmOXL3Q3DV
         sGkq02giCoBY7tyzIkGfWirjJ2FeTonNNEOq5hNZYvn2PxrMFbgft9iRQ6/K4f45H1TP
         MMPvd/n11zMxBt9DgyeVO0egP5MQu/lgwKQV2nu46rNI2pW3/LzavqQmslfwF/vDk3MP
         SSxNMfQX1wl1hF37oCmkAc9c+9zmwI+KeU5Mc46UdhFIetJkkRzBkjkarcCnt1XEObDJ
         zdMwxY10lN8rUa6BsGCdXYIzMUCAJm2VhGr7QsuSYk+G/GyXvIhivnfLNxNNPh7r3Lem
         hd3A==
X-Gm-Message-State: AO0yUKXqueyKHQ4tGfl5+YRIHhOeB/0EoICl9lRfTboxPLX5JcXRwuCc
        ABYLgDc91b+UkRCkIAFqFewz+A==
X-Google-Smtp-Source: AK7set/eGnfdLqSXO5k6gFPSjXsc2URwOw444gIhoTtUY4ojZeX2D/CyDqsIDbiTRIe+Ndr8X6+uRg==
X-Received: by 2002:a05:600c:198e:b0:3eb:2e27:2d0c with SMTP id t14-20020a05600c198e00b003eb2e272d0cmr13899448wmq.1.1678299203675;
        Wed, 08 Mar 2023 10:13:23 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:4213:ad42:5630:43c4? ([2a05:6e02:1041:c10:4213:ad42:5630:43c4])
        by smtp.googlemail.com with ESMTPSA id r11-20020a05600c458b00b003e20970175dsm162809wmo.32.2023.03.08.10.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 10:13:23 -0800 (PST)
Message-ID: <6c13708d-d51a-73b8-bf01-d6893eae2af4@linaro.org>
Date:   Wed, 8 Mar 2023 19:13:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RESEND] [PATCHv3 4/7] thermal: rockchip: Simplify channel id
 logic
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230308112253.15659-1-sebastian.reichel@collabora.com>
 <20230308112253.15659-5-sebastian.reichel@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230308112253.15659-5-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 12:22, Sebastian Reichel wrote:
> Replace the channel ID lookup table by a simple offset, since
> the channel IDs are consecutive.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

As all the other patches are reviewed by Heiko, is the tag missing here?


> ---
>   drivers/thermal/rockchip_thermal.c | 48 +++++++++++++-----------------
>   1 file changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 9ed45b318344..bcbdd618daae 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -39,15 +39,6 @@ enum tshut_polarity {
>   	TSHUT_HIGH_ACTIVE,
>   };
>   
> -/*
> - * The system has two Temperature Sensors.
> - * sensor0 is for CPU, and sensor1 is for GPU.
> - */
> -enum sensor_id {
> -	SENSOR_CPU = 0,
> -	SENSOR_GPU,
> -};
> -
>   /*
>    * The conversion table has the adc value and temperature.
>    * ADC_DECREMENT: the adc value is of diminishing.(e.g. rk3288_code_table)
> @@ -82,7 +73,7 @@ struct chip_tsadc_table {
>   
>   /**
>    * struct rockchip_tsadc_chip - hold the private data of tsadc chip
> - * @chn_id: array of sensor ids of chip corresponding to the channel
> + * @chn_offset: the channel offset of the first channel
>    * @chn_num: the channel number of tsadc chip
>    * @tshut_temp: the hardware-controlled shutdown temperature value
>    * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
> @@ -98,7 +89,7 @@ struct chip_tsadc_table {
>    */
>   struct rockchip_tsadc_chip {
>   	/* The sensor id of chip correspond to the ADC channel */
> -	int chn_id[SOC_MAX_SENSORS];
> +	int chn_offset;
>   	int chn_num;
>   
>   	/* The hardware-controlled tshut property */
> @@ -925,8 +916,8 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>   }
>   
>   static const struct rockchip_tsadc_chip px30_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> +	/* cpu, gpu */
> +	.chn_offset = 0,
>   	.chn_num = 2, /* 2 channels for tsadc */
>   
>   	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
> @@ -949,7 +940,8 @@ static const struct rockchip_tsadc_chip px30_tsadc_data = {
>   };
>   
>   static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> +	/* cpu */
> +	.chn_offset = 0,
>   	.chn_num = 1, /* one channel for tsadc */
>   
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> @@ -973,7 +965,8 @@ static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
>   };
>   
>   static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> +	/* cpu */
> +	.chn_offset = 0,
>   	.chn_num = 1, /* one channel for tsadc */
>   
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> @@ -997,8 +990,8 @@ static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
>   };
>   
>   static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 1, /* cpu sensor is channel 1 */
> -	.chn_id[SENSOR_GPU] = 2, /* gpu sensor is channel 2 */
> +	/* cpu, gpu */
> +	.chn_offset = 1,
>   	.chn_num = 2, /* two channels for tsadc */
>   
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> @@ -1022,7 +1015,8 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
>   };
>   
>   static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> +	/* cpu */
> +	.chn_offset = 0,
>   	.chn_num = 1, /* one channels for tsadc */
>   
>   	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
> @@ -1045,8 +1039,8 @@ static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
>   };
>   
>   static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> +	/* cpu, gpu */
> +	.chn_offset = 0,
>   	.chn_num = 2, /* two channels for tsadc */
>   
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> @@ -1070,8 +1064,8 @@ static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
>   };
>   
>   static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> +	/* cpu, gpu */
> +	.chn_offset = 0,
>   	.chn_num = 2, /* two channels for tsadc */
>   
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> @@ -1095,8 +1089,8 @@ static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
>   };
>   
>   static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> +	/* cpu, gpu */
> +	.chn_offset = 0,
>   	.chn_num = 2, /* two channels for tsadc */
>   
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> @@ -1120,8 +1114,8 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
>   };
>   
>   static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> +	/* cpu, gpu */
> +	.chn_offset = 0,
>   	.chn_num = 2, /* two channels for tsadc */
>   
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> @@ -1404,7 +1398,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>   	for (i = 0; i < thermal->chip->chn_num; i++) {
>   		error = rockchip_thermal_register_sensor(pdev, thermal,
>   						&thermal->sensors[i],
> -						thermal->chip->chn_id[i]);
> +						thermal->chip->chn_offset + i);
>   		if (error)
>   			return dev_err_probe(&pdev->dev, error,
>   				"failed to register sensor[%d].\n", i);

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

