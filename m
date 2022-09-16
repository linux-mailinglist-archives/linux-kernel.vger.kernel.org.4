Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699845BB169
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIPRC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIPRC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:02:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9E340BEC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:02:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so164889wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QYsB+8ZBh5lPceks2B9b9m9Azf8iMnQ2SX2Ay/jTkis=;
        b=fL3jdb6zAkkcvyjoOri5S+Vg1FoWrboT7QKwLfO1/p6cy9nSRL8ceJxMFYHciitmi7
         ZE4UeFewoyoLLsPdYuWF8Bv1vUnJJw3slB8Dc6Dy0raFOi5PFbkO1OYl4Gvm6tMsYWoG
         4/9P5TInGCzatEAfd2a369eKhUSAiGM+ap4kglNpE9cHq23NXis39eeVUHiFgN/m45ra
         iHF+NiyNU06WjBUG0HOHaLq2txh1rAo3TVmZipORHg+g0S7avSaqZvEy0ACusgHQ3lro
         CCPFUnqEl6/6yutKzeuiqUEQLuVi0CNib4Ek7iosWMfdcpQLrFdi+SkOFq24lrXBRtf7
         Gy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QYsB+8ZBh5lPceks2B9b9m9Azf8iMnQ2SX2Ay/jTkis=;
        b=xl2LZD3us2D+Hoob6JufNLt3IZno6zZQUmQ2zGTIfHnLaGhOsyIhEoZMY2u/glnVHd
         GxEnE+3LUwUlnC5tMTEEjgmzv82G86EfeRgX8/C4/Mu7iJ+oDAuOpgpQih8xTdS5Rms7
         A/L9bnlZIdtNvYrSA8XDt/ja5sU6D+u99FTqzUHKWcGl0VlLKLuh61Xi1i1u/JA5Pn+9
         Y8J2ybi0wvl6z1PHdFQ9dSCSLM2WBvtKTTrKI/iSM2jVT6XwatPZnNCpdnDUnYXsEA4e
         qbZaWiCG23c6MIWMLOm3rsGnPlBid2N4Gnvn8QmAP6ViZMjzz0D7l2+llsdU5fh+XDY/
         MKMg==
X-Gm-Message-State: ACgBeo1gCvhnk768oTTUY/JRm2kRZ4hmMUN9pDIIpir3YHVxcH7Gji2v
        B2cCiOXGjof+CLB8hrxT8Fh4Ng==
X-Google-Smtp-Source: AA6agR5BYrHMmtLqKtDeyLwZmLPyYPjpk5xMJ7H1dPplWOTY7wiOrKN/ivoGKaVycZstsZK4KtOS8Q==
X-Received: by 2002:a05:600c:1caa:b0:3a8:4066:981d with SMTP id k42-20020a05600c1caa00b003a84066981dmr10994501wms.54.1663347772906;
        Fri, 16 Sep 2022 10:02:52 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id d1-20020a5d4f81000000b00228a6ce17b4sm5390047wru.37.2022.09.16.10.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 10:02:52 -0700 (PDT)
Message-ID: <e8cf3273-0a2d-4749-a427-95111363d2c3@linaro.org>
Date:   Fri, 16 Sep 2022 19:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 22/30] thermal/drivers/imx: Use generic
 thermal_zone_get_trip() function
Content-Language: en-US
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
 <20220906164720.330701-23-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220906164720.330701-23-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 06/09/2022 18:47, Daniel Lezcano wrote:
> The thermal framework gives the possibility to register the trip
> points with the thermal zone. When that is done, no get_trip_* ops are
> needed and they can be removed.
> 
> Convert ops content logic into generic trip points and register them with the
> thermal zone.

Any comment on this patch?

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/imx_thermal.c | 72 +++++++++++++----------------------
>   1 file changed, 27 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 16663373b682..fb0d5cab70af 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -76,7 +76,6 @@
>   enum imx_thermal_trip {
>   	IMX_TRIP_PASSIVE,
>   	IMX_TRIP_CRITICAL,
> -	IMX_TRIP_NUM,
>   };
>   
>   #define IMX_POLLING_DELAY		2000 /* millisecond */
> @@ -115,6 +114,11 @@ struct thermal_soc_data {
>   	u32 low_alarm_shift;
>   };
>   
> +static struct thermal_trip trips[] = {
> +	[IMX_TRIP_PASSIVE]  = { .type = THERMAL_TRIP_PASSIVE  },
> +	[IMX_TRIP_CRITICAL] = { .type = THERMAL_TRIP_CRITICAL },
> +};
> +
>   static struct thermal_soc_data thermal_imx6q_data = {
>   	.version = TEMPMON_IMX6Q,
>   
> @@ -201,8 +205,6 @@ struct imx_thermal_data {
>   	struct thermal_cooling_device *cdev;
>   	struct regmap *tempmon;
>   	u32 c1, c2; /* See formula in imx_init_calib() */
> -	int temp_passive;
> -	int temp_critical;
>   	int temp_max;
>   	int alarm_temp;
>   	int last_temp;
> @@ -279,12 +281,12 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
>   
>   	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
>   	if (data->socdata->version == TEMPMON_IMX6Q) {
> -		if (data->alarm_temp == data->temp_passive &&
> -			*temp >= data->temp_passive)
> -			imx_set_alarm_temp(data, data->temp_critical);
> -		if (data->alarm_temp == data->temp_critical &&
> -			*temp < data->temp_passive) {
> -			imx_set_alarm_temp(data, data->temp_passive);
> +		if (data->alarm_temp == trips[IMX_TRIP_PASSIVE].temperature &&
> +			*temp >= trips[IMX_TRIP_PASSIVE].temperature)
> +			imx_set_alarm_temp(data, trips[IMX_TRIP_CRITICAL].temperature);
> +		if (data->alarm_temp == trips[IMX_TRIP_CRITICAL].temperature &&
> +			*temp < trips[IMX_TRIP_PASSIVE].temperature) {
> +			imx_set_alarm_temp(data, trips[IMX_TRIP_PASSIVE].temperature);
>   			dev_dbg(&tz->device, "thermal alarm off: T < %d\n",
>   				data->alarm_temp / 1000);
>   		}
> @@ -330,29 +332,10 @@ static int imx_change_mode(struct thermal_zone_device *tz,
>   	return 0;
>   }
>   
> -static int imx_get_trip_type(struct thermal_zone_device *tz, int trip,
> -			     enum thermal_trip_type *type)
> -{
> -	*type = (trip == IMX_TRIP_PASSIVE) ? THERMAL_TRIP_PASSIVE :
> -					     THERMAL_TRIP_CRITICAL;
> -	return 0;
> -}
> -
>   static int imx_get_crit_temp(struct thermal_zone_device *tz, int *temp)
>   {
> -	struct imx_thermal_data *data = tz->devdata;
> -
> -	*temp = data->temp_critical;
> -	return 0;
> -}
> -
> -static int imx_get_trip_temp(struct thermal_zone_device *tz, int trip,
> -			     int *temp)
> -{
> -	struct imx_thermal_data *data = tz->devdata;
> +	*temp = trips[IMX_TRIP_CRITICAL].temperature;
>   
> -	*temp = (trip == IMX_TRIP_PASSIVE) ? data->temp_passive :
> -					     data->temp_critical;
>   	return 0;
>   }
>   
> @@ -371,10 +354,10 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
>   		return -EPERM;
>   
>   	/* do not allow passive to be set higher than critical */
> -	if (temp < 0 || temp > data->temp_critical)
> +	if (temp < 0 || temp > trips[IMX_TRIP_CRITICAL].temperature)
>   		return -EINVAL;
>   
> -	data->temp_passive = temp;
> +	trips[IMX_TRIP_PASSIVE].temperature = temp;
>   
>   	imx_set_alarm_temp(data, temp);
>   
> @@ -423,8 +406,6 @@ static struct thermal_zone_device_ops imx_tz_ops = {
>   	.unbind = imx_unbind,
>   	.get_temp = imx_get_temp,
>   	.change_mode = imx_change_mode,
> -	.get_trip_type = imx_get_trip_type,
> -	.get_trip_temp = imx_get_trip_temp,
>   	.get_crit_temp = imx_get_crit_temp,
>   	.set_trip_temp = imx_set_trip_temp,
>   };
> @@ -507,8 +488,8 @@ static void imx_init_temp_grade(struct platform_device *pdev, u32 ocotp_mem0)
>   	 * Set the critical trip point at 5 °C under max
>   	 * Set the passive trip point at 10 °C under max (changeable via sysfs)
>   	 */
> -	data->temp_critical = data->temp_max - (1000 * 5);
> -	data->temp_passive = data->temp_max - (1000 * 10);
> +	trips[IMX_TRIP_PASSIVE].temperature = data->temp_max - (1000 * 10);
> +	trips[IMX_TRIP_CRITICAL].temperature = data->temp_max - (1000 * 5);
>   }
>   
>   static int imx_init_from_tempmon_data(struct platform_device *pdev)
> @@ -743,12 +724,13 @@ static int imx_thermal_probe(struct platform_device *pdev)
>   		goto legacy_cleanup;
>   	}
>   
> -	data->tz = thermal_zone_device_register("imx_thermal_zone",
> -						IMX_TRIP_NUM,
> -						BIT(IMX_TRIP_PASSIVE), data,
> -						&imx_tz_ops, NULL,
> -						IMX_PASSIVE_DELAY,
> -						IMX_POLLING_DELAY);
> +	data->tz = thermal_zone_device_register_with_trips("imx_thermal_zone",
> +							   trips,
> +							   ARRAY_SIZE(trips),
> +							   BIT(IMX_TRIP_PASSIVE), data,
> +							   &imx_tz_ops, NULL,
> +							   IMX_PASSIVE_DELAY,
> +							   IMX_POLLING_DELAY);
>   	if (IS_ERR(data->tz)) {
>   		ret = PTR_ERR(data->tz);
>   		dev_err(&pdev->dev,
> @@ -758,8 +740,8 @@ static int imx_thermal_probe(struct platform_device *pdev)
>   
>   	dev_info(&pdev->dev, "%s CPU temperature grade - max:%dC"
>   		 " critical:%dC passive:%dC\n", data->temp_grade,
> -		 data->temp_max / 1000, data->temp_critical / 1000,
> -		 data->temp_passive / 1000);
> +		 data->temp_max / 1000, trips[IMX_TRIP_CRITICAL].temperature / 1000,
> +		 trips[IMX_TRIP_PASSIVE].temperature / 1000);
>   
>   	/* Enable measurements at ~ 10 Hz */
>   	regmap_write(map, data->socdata->measure_freq_ctrl + REG_CLR,
> @@ -767,10 +749,10 @@ static int imx_thermal_probe(struct platform_device *pdev)
>   	measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
>   	regmap_write(map, data->socdata->measure_freq_ctrl + REG_SET,
>   		     measure_freq << data->socdata->measure_freq_shift);
> -	imx_set_alarm_temp(data, data->temp_passive);
> +	imx_set_alarm_temp(data, trips[IMX_TRIP_PASSIVE].temperature);
>   
>   	if (data->socdata->version == TEMPMON_IMX6SX)
> -		imx_set_panic_temp(data, data->temp_critical);
> +		imx_set_panic_temp(data, trips[IMX_TRIP_CRITICAL].temperature);
>   
>   	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
>   		     data->socdata->power_down_mask);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
