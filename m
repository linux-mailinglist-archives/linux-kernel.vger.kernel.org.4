Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0A68C093
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjBFO4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBFO4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:56:15 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1591166D1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:56:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso10959441wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 06:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLXohrLP2hqmIHa8JxNah729Hs2/+AYh5T6dr8eUBo8=;
        b=CKoxPXKB1qlb2deEofHpnltY/BW5FIvtFHIHVUEERB+OWPQBKrrWDdaRiurBijgwW1
         IL4vnGOCc3TbuSDYFfCaYTEeaSo02LzhJDoXtNYvm4LpRv1cuhSq+7bo4I1kjD40z+0y
         NffxUX5Xwu/AdMvdBxEewsXIhmNtVGqhrA9kNX8ONQRP4pFVdrIsCXwSL80NuHHzBOu1
         jRs0ZVKWflGcLmt8QSxBWW7S2NCevcEtgQowJIFsgjCrBfqWE91YHqnjI2s/l9QmFaYQ
         OKH0s5k18a0pE+IMFC1CCuV+EXpbvxteCc+H4fkte3L9r1irvEuHcEpo6pVH06RIEN9L
         7SKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLXohrLP2hqmIHa8JxNah729Hs2/+AYh5T6dr8eUBo8=;
        b=Chdax7L6uWis6zH1SbZ3gmfmZ4lmKgXvl9pYp8pahAKmKDh6tgZ+JnilvE01Sziwiq
         NqU+lVZc2m0dnWytCvcSpppy00Bp7EM8PzNZqTtMtgF7pFPsrhj6EzXo9aCXI+p/8Mql
         GeWxm3zTqLbGY0N/mx4oNsEN5LqTFMD+sHc7jKQh5IbV63fLznSPGlyRvoxMnviKVAd3
         A7WKwt8y6zO1e8rqzkZaJD/kP8oSSwofRvfJc00pW/Keq1z1TKGcq94ntZfqUaVKmKVn
         bLSZhWmK2yJNyHP0GxZS33S/s2zFkUsGK7yD6ejzvFrHYG5gX/1pdLKIlqMMJmBMAatX
         /HUg==
X-Gm-Message-State: AO0yUKVR5XER/6X/1xvW54lAXuhNwODaec7IdJ+ni+pzdSBK/P/TdkLk
        1aRqqQBK85fbYQA7/0Pqm6VL7Q==
X-Google-Smtp-Source: AK7set/8WRvocO4wfoqX2j9zF/YdHaQLBXhKJE8IdbkJk6s3aAe+JnRBkLYPJgyIb+nkVs7MwisT/w==
X-Received: by 2002:a05:600c:43c5:b0:3dc:5674:66e6 with SMTP id f5-20020a05600c43c500b003dc567466e6mr19737108wmn.25.1675695372525;
        Mon, 06 Feb 2023 06:56:12 -0800 (PST)
Received: from [172.17.59.64] (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.googlemail.com with ESMTPSA id he7-20020a05600c540700b003df5be8987esm14331149wmb.20.2023.02.06.06.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:56:12 -0800 (PST)
Message-ID: <0150eab3-8446-aa95-ddf1-e80004d2d262@linaro.org>
Date:   Mon, 6 Feb 2023 15:56:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: Hunt zero trip points thermal zones usage
Content-Language: en-US
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Chuansheng Liu <chuansheng.liu@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
References: <20230203175832.3406504-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230203175832.3406504-1-daniel.lezcano@linaro.org>
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

On 03/02/2023 18:58, Daniel Lezcano wrote:
> Some drivers are declaring a thermal zone without any thermal trip
> points.
> 
> On the other side, we are introducing the function
> thermal_zone_device_register_with_trips() which provides an array of
> generic thermal trip points. When all the drivers will be converted to
> the generic trip points, keeping two functions will be useless.
> 
> Most of the drivers are now using
> thermal_zone_device_register_with_trips() with the generic trip
> points. As soon as the remaining drivers are merged, the
> thermal_zone_device_register_with_trips() will be renamed to
> thermal_zone_device_register().
> 
> Obviously this renaming can only happen if there are no more user of
> the thermal_zone_device_register() function.
> 
> This change uses thermal_zone_device_register_with_trips() with a NULL
> parameter for the trip point array instead of
> thermal_zone_device_register().
> 
> No functional change intended.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/power/supply/power_supply_core.c                | 2 +-

Sebastian,

are ok with this change and if it goes through the thermal tree ?


>   drivers/thermal/armada_thermal.c                        | 4 ++--
>   drivers/thermal/dove_thermal.c                          | 4 ++--
>   drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 6 +++---
>   drivers/thermal/kirkwood_thermal.c                      | 4 ++--
>   drivers/thermal/spear_thermal.c                         | 5 +++--
>   6 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 7c790c41e2fe..208a849a71d9 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1166,7 +1166,7 @@ static int psy_register_thermal(struct power_supply *psy)
>   
>   	/* Register battery zone device psy reports temperature */
>   	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> -		psy->tzd = thermal_zone_device_register(psy->desc->name,
> +		psy->tzd = thermal_zone_device_register_with_trips(psy->desc->name, NULL,
>   				0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
>   		if (IS_ERR(psy->tzd))
>   			return PTR_ERR(psy->tzd);
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 99e86484a55c..83a4080bffc7 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -856,8 +856,8 @@ static int armada_thermal_probe(struct platform_device *pdev)
>   		/* Wait the sensors to be valid */
>   		armada_wait_sensor_validity(priv);
>   
> -		tz = thermal_zone_device_register(priv->zone_name, 0, 0, priv,
> -						  &legacy_ops, NULL, 0, 0);
> +		tz = thermal_zone_device_register_with_trips(priv->zone_name, NULL, 0, 0, priv,
> +							     &legacy_ops, NULL, 0, 0);
>   		if (IS_ERR(tz)) {
>   			dev_err(&pdev->dev,
>   				"Failed to register thermal zone device\n");
> diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
> index 056622a58d00..fce15af5a7f6 100644
> --- a/drivers/thermal/dove_thermal.c
> +++ b/drivers/thermal/dove_thermal.c
> @@ -142,8 +142,8 @@ static int dove_thermal_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	thermal = thermal_zone_device_register("dove_thermal", 0, 0,
> -					       priv, &ops, NULL, 0, 0);
> +	thermal = thermal_zone_device_register_with_trips("dove_thermal", NULL, 0, 0,
> +							  priv, &ops, NULL, 0, 0);
>   	if (IS_ERR(thermal)) {
>   		dev_err(&pdev->dev,
>   			"Failed to register thermal zone device\n");
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index d0295123cc3e..dac60b6a281c 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -609,9 +609,9 @@ static int int3400_thermal_probe(struct platform_device *pdev)
>   
>   	evaluate_odvp(priv);
>   
> -	priv->thermal = thermal_zone_device_register("INT3400 Thermal", 0, 0,
> -						priv, &int3400_thermal_ops,
> -						&int3400_thermal_params, 0, 0);
> +	priv->thermal = thermal_zone_device_register_with_trips("INT3400 Thermal", NULL, 0, 0,
> +								priv, &int3400_thermal_ops,
> +								&int3400_thermal_params, 0, 0);
>   	if (IS_ERR(priv->thermal)) {
>   		result = PTR_ERR(priv->thermal);
>   		goto free_art_trt;
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
> index bec7ec20e79d..4506b7dfb474 100644
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -74,8 +74,8 @@ static int kirkwood_thermal_probe(struct platform_device *pdev)
>   	if (IS_ERR(priv->sensor))
>   		return PTR_ERR(priv->sensor);
>   
> -	thermal = thermal_zone_device_register("kirkwood_thermal", 0, 0,
> -					       priv, &ops, NULL, 0, 0);
> +	thermal = thermal_zone_device_register_with_trips("kirkwood_thermal", NULL, 0, 0,
> +							  priv, &ops, NULL, 0, 0);
>   	if (IS_ERR(thermal)) {
>   		dev_err(&pdev->dev,
>   			"Failed to register thermal zone device\n");
> diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
> index 6a722b10d738..0d20bc9c5c0b 100644
> --- a/drivers/thermal/spear_thermal.c
> +++ b/drivers/thermal/spear_thermal.c
> @@ -122,8 +122,9 @@ static int spear_thermal_probe(struct platform_device *pdev)
>   	stdev->flags = val;
>   	writel_relaxed(stdev->flags, stdev->thermal_base);
>   
> -	spear_thermal = thermal_zone_device_register("spear_thermal", 0, 0,
> -				stdev, &ops, NULL, 0, 0);
> +	spear_thermal = thermal_zone_device_register_with_trips("spear_thermal",
> +								NULL, 0, 0,
> +								stdev, &ops, NULL, 0, 0);
>   	if (IS_ERR(spear_thermal)) {
>   		dev_err(&pdev->dev, "thermal zone device is NULL\n");
>   		ret = PTR_ERR(spear_thermal);

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

