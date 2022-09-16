Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE525BB163
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIPQ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 12:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIPQ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 12:56:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FF3ABD5B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 09:56:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bq9so36962319wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=g6sKXgXASIMeZBB6NZfyCrVte8i/wWc80VJT69vF6Ec=;
        b=WUbA0k+hNEc6Qzgn8oKwFKvWU5X9F4jjgyWtixwC/bt2NwEItkcUEihSUz7wFQjCOB
         jEEKdX0tQMARtWpSW0oQSW+VACq58GYUGxa+YixsJYjM2w/cmJ5ZcM2FzNoxTvcBnNsx
         7Z1gW2lgFoVWVTrPq52c6xJ3NYmoO32Y6omD4j5Aj8eNHY6+Z+Hv57tWwBx1vquYPPjy
         XZGl4jeBL8uNgkgW4INO4eiwmfjUorxXTNLL9D9CuMxsTRKo36YQZmilrrXXYwoW9qRA
         XVl6LqAY+L6vekvkGVizCeEx8IQho4CtXZehzabQ60w7TYDDKXsj747SZ1JExaAQyFWz
         UD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=g6sKXgXASIMeZBB6NZfyCrVte8i/wWc80VJT69vF6Ec=;
        b=PcEjTodgJOgasFQKRW2PbYjfvJnC/7hotF94gFx+AZ0QmjMqmTW82kY7Z/a/ndj0wi
         RYv9TU8LAXZOKzADZxWKqTrXfw/d+k54bs59RWN5y5xH+h+kVkRLnFmoYRM7EchQFXAs
         hdox1+ph8Kw7tcX+Jfsh6bC7M/8EbfZTfnRJVY1s/nxb9WMdaOWT2Oc2SdOzWhpUm2sK
         lj9nsP18Cqri1w6DIWcfxdTV/ryjjmfVSu3mxfZBdAtl9rV42woes+lrVCzaNj1rlrtr
         Y7rMMS37Mr//dtLjFl5YaBwhwv3BNCYlFYjQjWcogydCgvv/EfBfXwVE1HByOdZ6WuOY
         HImw==
X-Gm-Message-State: ACrzQf06nuVJLqB20xVsiF7WFIya2A+3qBMde/MfXN7iGDOvvrgp92h5
        wTg1876g4TqHGng03TX+Xu1pnA==
X-Google-Smtp-Source: AMsMyM7krkoaqZCh//OQ4HJFErJusbQsRpilmEL0LL2rlGfn3yMfDz3NNImCsilq3MecAU6x3XejGw==
X-Received: by 2002:a5d:6daa:0:b0:22a:da94:abe4 with SMTP id u10-20020a5d6daa000000b0022ada94abe4mr3296528wrs.543.1663347400456;
        Fri, 16 Sep 2022 09:56:40 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id t5-20020a5d6a45000000b00229e0def760sm5144544wrw.88.2022.09.16.09.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 09:56:39 -0700 (PDT)
Message-ID: <2b9651b0-94c6-dfd4-9c2d-d530c2cb3e86@linaro.org>
Date:   Fri, 16 Sep 2022 18:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 11/30] thermal/drivers/tegra: Use generic
 thermal_zone_get_trip() function
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
 <20220906164720.330701-12-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220906164720.330701-12-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 18:47, Daniel Lezcano wrote:
> Replace a single call to thermal_zone_get_trip() to get a trip point
> instead of calling the different ops->get_trip*
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Any comment on this patch ?

> ---
>   drivers/thermal/tegra/soctherm.c        | 33 +++++++++++--------------
>   drivers/thermal/tegra/tegra30-tsensor.c | 17 ++++++-------
>   2 files changed, 22 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index 1efe470f31e9..96b541458ccd 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -582,23 +582,23 @@ static int tsensor_group_thermtrip_get(struct tegra_soctherm *ts, int id)
>   	return temp;
>   }
>   
> -static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
> +static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip_id, int temp)
>   {
>   	struct tegra_thermctl_zone *zone = tz->devdata;
>   	struct tegra_soctherm *ts = zone->ts;
> +	struct thermal_trip trip;
>   	const struct tegra_tsensor_group *sg = zone->sg;
>   	struct device *dev = zone->dev;
> -	enum thermal_trip_type type;
>   	int ret;
>   
>   	if (!tz)
>   		return -EINVAL;
>   
> -	ret = tz->ops->get_trip_type(tz, trip, &type);
> +	ret = thermal_zone_get_trip(tz, trip_id, &trip);
>   	if (ret)
>   		return ret;
>   
> -	if (type == THERMAL_TRIP_CRITICAL) {
> +	if (trip.type == THERMAL_TRIP_CRITICAL) {
>   		/*
>   		 * If thermtrips property is set in DT,
>   		 * doesn't need to program critical type trip to HW,
> @@ -609,7 +609,7 @@ static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip
>   		else
>   			return 0;
>   
> -	} else if (type == THERMAL_TRIP_HOT) {
> +	} else if (trip.type == THERMAL_TRIP_HOT) {
>   		int i;
>   
>   		for (i = 0; i < THROTTLE_SIZE; i++) {
> @@ -620,7 +620,7 @@ static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip
>   				continue;
>   
>   			cdev = ts->throt_cfgs[i].cdev;
> -			if (get_thermal_instance(tz, cdev, trip))
> +			if (get_thermal_instance(tz, cdev, trip_id))
>   				stc = find_throttle_cfg_by_name(ts, cdev->type);
>   			else
>   				continue;
> @@ -687,25 +687,20 @@ static const struct thermal_zone_device_ops tegra_of_thermal_ops = {
>   	.set_trips = tegra_thermctl_set_trips,
>   };
>   
> -static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
> +static int get_hot_temp(struct thermal_zone_device *tz, int *trip_id, int *temp)
>   {
> -	int ntrips, i, ret;
> -	enum thermal_trip_type type;
> +	int i, ret;
> +	struct thermal_trip trip;
>   
> -	ntrips = of_thermal_get_ntrips(tz);
> -	if (ntrips <= 0)
> -		return -EINVAL;
> +	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
>   
> -	for (i = 0; i < ntrips; i++) {
> -		ret = tz->ops->get_trip_type(tz, i, &type);
> +		ret = thermal_zone_get_trip(tz, i, &trip);
>   		if (ret)
>   			return -EINVAL;
> -		if (type == THERMAL_TRIP_HOT) {
> -			ret = tz->ops->get_trip_temp(tz, i, temp);
> -			if (!ret)
> -				*trip = i;
>   
> -			return ret;
> +		if (trip.type == THERMAL_TRIP_HOT) {
> +			*trip_id = i;
> +			return 0;	
>   		}
>   	}
>   
> diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
> index c34501287e96..cbaad2245f1d 100644
> --- a/drivers/thermal/tegra/tegra30-tsensor.c
> +++ b/drivers/thermal/tegra/tegra30-tsensor.c
> @@ -316,18 +316,17 @@ static void tegra_tsensor_get_hw_channel_trips(struct thermal_zone_device *tzd,
>   	*hot_trip  = 85000;
>   	*crit_trip = 90000;
>   
> -	for (i = 0; i < tzd->num_trips; i++) {
> -		enum thermal_trip_type type;
> -		int trip_temp;
> +	for (i = 0; i < thermal_zone_get_num_trips(tzd); i++) {
>   
> -		tzd->ops->get_trip_temp(tzd, i, &trip_temp);
> -		tzd->ops->get_trip_type(tzd, i, &type);
> +		struct thermal_trip trip;
>   
> -		if (type == THERMAL_TRIP_HOT)
> -			*hot_trip = trip_temp;
> +		thermal_zone_get_trip(tzd, i, &trip);
> +		
> +		if (trip.type == THERMAL_TRIP_HOT)
> +			*hot_trip = trip.temperature;
>   
> -		if (type == THERMAL_TRIP_CRITICAL)
> -			*crit_trip = trip_temp;
> +		if (trip.type == THERMAL_TRIP_CRITICAL)
> +			*crit_trip = trip.temperature;
>   	}
>   
>   	/* clamp hardware trips to the calibration limits */


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
