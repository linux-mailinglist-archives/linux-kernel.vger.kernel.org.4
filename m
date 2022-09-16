Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0781B5BB167
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIPRA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIPRAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:00:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A2836DF1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:00:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n10so6364663wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Xd2uJbGHAG4KxDTbdiFsRgEoAtDupFBZUXylnQzUv3E=;
        b=Jv8NMCVobfWdWvCbJEH6Tv6/1I29MBt5TM4jbf86DjaufB5kNeyoJaIAzhftTiOY96
         d+slEUTACGHu/9x/QUNicfqcGKuyXTbuAUuVhHXu1EwMz+LRzIFCaby3jQaDC9dmT5Af
         Jgk1G8TaDA3+5szF5fsygP7eSZFfenRh/2u4x5eCnSyIFUi1ftq7WL/fPde06Do8X1Hm
         PZhMrT5magolSlwONTZWR7gZlvQZkDdUBw/Qdk6ev8xkompGmm54fmWZ6N10aq4Aa6VG
         YKwE+BGtiVoRJRu3296KBHnxXqRjbODbaaGqA7zIWwZVQ7+f27tJz/mGxBoQMhmpGpBe
         p+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Xd2uJbGHAG4KxDTbdiFsRgEoAtDupFBZUXylnQzUv3E=;
        b=U0ft0I98mmBdXFCgApg1glsz9I/sYkb0cNUTlVDvorGFFbsB5yXNYleXLVGnOYx2Oj
         9T9cBDdhYuiMMtrKbtioGdrM87GUKRUch5dXiWrkOqqPZqG/humyb77w7xeAbFsvHpxD
         gZFy/9wzljFg+rd0OgmlUeYkpy5KCRxazSnn16G6KQUDnbAQzBnX27VIQpNZDAZU6Rgu
         zbMWy9XyfYOv25Sx0Fbl0V3X8I77kahhs9CAy1O4HDPRCZgch4LRE1vss+f+YHArLNn7
         2Tn6DWcrUpCfCp8+haBWbOgOqfIKBNDU8iHWFOaftfUSa5bPvSpzb3mTHiSS5mmSUS8d
         UkJg==
X-Gm-Message-State: ACrzQf3Z0MWjzKCIjx+IuzfqzdpckT7KgNSVkudWKWRouRhAPRoNxTjE
        k7jlW2U7nL61elOkd02VDqwvUA==
X-Google-Smtp-Source: AMsMyM7CcWZCCo1yJCD46oPuW0FRRfr8eQEUC7V1cVayE7g7It+x6iw5BeMNrIDU6ihhiVMN/C9zLQ==
X-Received: by 2002:adf:fa52:0:b0:228:9675:e6f3 with SMTP id y18-20020adffa52000000b002289675e6f3mr3357936wrr.151.1663347621594;
        Fri, 16 Sep 2022 10:00:21 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f8-20020a05600c154800b003b477532e66sm8896630wmg.2.2022.09.16.10.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 10:00:21 -0700 (PDT)
Message-ID: <8b260b5d-3f97-846c-c96d-c9ada57ce33f@linaro.org>
Date:   Fri, 16 Sep 2022 19:00:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 15/30] thermal/drivers/armada: Use generic
 thermal_zone_get_trip() function
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>, rafael@kernel.org,
        Zhang Rui <rui.zhang@intel.com>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
 <20220906164720.330701-16-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220906164720.330701-16-daniel.lezcano@linaro.org>
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


Hi Miquel,

any comment on this patch?

On 06/09/2022 18:47, Daniel Lezcano wrote:
> The thermal framework gives the possibility to register the trip
> points with the thermal zone. When that is done, no get_trip_* ops are
> needed and they can be removed.
> 
> Convert ops content logic into generic trip points and register them with the
> thermal zone.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/armada_thermal.c | 39 ++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 52d63b3997fe..9444e5a22ca0 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -785,33 +785,34 @@ static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
>   					 int sensor_id)
>   {
>   	/* Retrieve the critical trip point to enable the overheat interrupt */
> -	const struct thermal_trip *trips = of_thermal_get_trip_points(tz);
> +	struct thermal_trip trip;
>   	int ret;
>   	int i;
>   
> -	if (!trips)
> -		return -EINVAL;
> -
> -	for (i = 0; i < of_thermal_get_ntrips(tz); i++)
> -		if (trips[i].type == THERMAL_TRIP_CRITICAL)
> -			break;
> +	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
>   
> -	if (i == of_thermal_get_ntrips(tz))
> -		return -EINVAL;
> +		ret = thermal_zone_get_trip(tz, i, &trip);
> +		if (ret)
> +			return ret;
> +		
> +		if (trip.type != THERMAL_TRIP_CRITICAL)
> +			continue;
>   
> -	ret = armada_select_channel(priv, sensor_id);
> -	if (ret)
> -		return ret;
> +		ret = armada_select_channel(priv, sensor_id);
> +		if (ret)
> +			return ret;
> +		
> +		armada_set_overheat_thresholds(priv, trip.temperature,
> +					       trip.hysteresis);
> +		priv->overheat_sensor = tz;
> +		priv->interrupt_source = sensor_id;
>   
> -	armada_set_overheat_thresholds(priv,
> -				       trips[i].temperature,
> -				       trips[i].hysteresis);
> -	priv->overheat_sensor = tz;
> -	priv->interrupt_source = sensor_id;
> +		armada_enable_overheat_interrupt(priv);
>   
> -	armada_enable_overheat_interrupt(priv);
> +		return 0;
> +	}
>   
> -	return 0;
> +	return -EINVAL;
>   }
>   
>   static int armada_thermal_probe(struct platform_device *pdev)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
