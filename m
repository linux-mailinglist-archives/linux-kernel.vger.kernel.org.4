Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827815BB17B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiIPRG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIPRGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:06:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6AEB6569
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:06:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso170802wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2Oxx5kqBRIZxO4Bn/qu1Qnb8DRx2/L4iHPQP7ATutEY=;
        b=PnxaGuLdwhNbWSTiciz+2EgSkkNZvQQLQ96T9em5ygKq2Jk6d2AE79uglmnmQ/BAA1
         C+WhQsYoWyPKit+09bh6nee4SWijKDWsX1AcheRqabCMHKOUinfZ0j6EDTozyJq3ODjC
         dkmjki1MZCMo13vKJARV6UfQD4g4Iy7B0zOBj209Y8hbui/K47xv09/ZyCYyh74JK3ZR
         QAz1KV7Qn7kQ3uWDgDKsLiLUzqzNBrwJqJW0dzvfHRIhYLK9GetfOMHJYjbDYvZsVEm7
         XVWYIP0cCnFnLe7qtcV0b2oifVnQBgZ4/ApXwmxx3g5L61s6uvLpHfnmxkyhukQ8coW4
         XqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2Oxx5kqBRIZxO4Bn/qu1Qnb8DRx2/L4iHPQP7ATutEY=;
        b=Pj/cnWvVTbWw8ieyuRmlyCTFNVLFWO5KBDk5S/ET6YhD7dNUvVC1Z5ddML3r66cOOL
         Rrgn/ILUt1qFM55l2gGsR97mrf1HosHpAAz2hKz2+2cdF7Zml+CeZ8Q0AQIY3eojBW0y
         yXZjj5HCiMTndfcX7nuos7ClQ2lXgb1uIJz8iDMhj9kUpytxkStlp+kko27cBL52Zfwg
         WF6hKIRvnwlxP/Rm/l1ItYHdfrmo6EBIh+2rB+1wQq4AKYq+1TroPt44E+FGAQTNuwM6
         W2R/Xz/psBQWj1paQ+0lRbS2twc2TDgV3SuUfUcgLGK/Kh5vFIRdOX32kUOyyTJIkCS9
         Nzmw==
X-Gm-Message-State: ACrzQf0bOE9I9q7m5WiRkdEvr+yefiitMwRKH3A+21nNewsz3So6kHdo
        3FDjuUPxLqkOczgY49+2dvMjRA==
X-Google-Smtp-Source: AMsMyM7wLDVryIH331dGHToKzlT6qh/8jaI0ey5RK6ItHQXW0JnozRbT0AwUx/xagRdj0RSTVACW1Q==
X-Received: by 2002:a1c:7c03:0:b0:3b4:7647:ccd8 with SMTP id x3-20020a1c7c03000000b003b47647ccd8mr4171256wmc.10.1663348004097;
        Fri, 16 Sep 2022 10:06:44 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id k24-20020adfd238000000b0022ad393ba3csm4927118wrh.107.2022.09.16.10.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 10:06:43 -0700 (PDT)
Message-ID: <0e986fbb-e76b-9663-26c2-b84d887b4c98@linaro.org>
Date:   Fri, 16 Sep 2022 19:06:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 30/30] thermal/drivers/intel: Use generic
 thermal_zone_get_trip() function
Content-Language: en-US
To:     rafael@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jiang Jian <jiangjian@cdjrlc.com>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
 <20220906164720.330701-31-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220906164720.330701-31-daniel.lezcano@linaro.org>
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


Hi Srinivas,

I've Cc'ed you on this patch in case you have any comment

Thanks

   -- D.

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
>   drivers/thermal/intel/x86_pkg_temp_thermal.c | 120 ++++++++++---------
>   1 file changed, 66 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> index a0e234fce71a..e7c3b78d959c 100644
> --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> @@ -53,6 +53,7 @@ struct zone_device {
>   	u32				msr_pkg_therm_high;
>   	struct delayed_work		work;
>   	struct thermal_zone_device	*tzone;
> +	struct thermal_trip		*trips;
>   	struct cpumask			cpumask;
>   };
>   
> @@ -138,40 +139,6 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
>   	return -EINVAL;
>   }
>   
> -static int sys_get_trip_temp(struct thermal_zone_device *tzd,
> -			     int trip, int *temp)
> -{
> -	struct zone_device *zonedev = tzd->devdata;
> -	unsigned long thres_reg_value;
> -	u32 mask, shift, eax, edx;
> -	int ret;
> -
> -	if (trip >= MAX_NUMBER_OF_TRIPS)
> -		return -EINVAL;
> -
> -	if (trip) {
> -		mask = THERM_MASK_THRESHOLD1;
> -		shift = THERM_SHIFT_THRESHOLD1;
> -	} else {
> -		mask = THERM_MASK_THRESHOLD0;
> -		shift = THERM_SHIFT_THRESHOLD0;
> -	}
> -
> -	ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
> -			   &eax, &edx);
> -	if (ret < 0)
> -		return ret;
> -
> -	thres_reg_value = (eax & mask) >> shift;
> -	if (thres_reg_value)
> -		*temp = zonedev->tj_max - thres_reg_value * 1000;
> -	else
> -		*temp = THERMAL_TEMP_INVALID;
> -	pr_debug("sys_get_trip_temp %d\n", *temp);
> -
> -	return 0;
> -}
> -
>   static int
>   sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
>   {
> @@ -212,18 +179,9 @@ sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
>   			l, h);
>   }
>   
> -static int sys_get_trip_type(struct thermal_zone_device *thermal, int trip,
> -			     enum thermal_trip_type *type)
> -{
> -	*type = THERMAL_TRIP_PASSIVE;
> -	return 0;
> -}
> -
>   /* Thermal zone callback registry */
>   static struct thermal_zone_device_ops tzone_ops = {
>   	.get_temp = sys_get_curr_temp,
> -	.get_trip_temp = sys_get_trip_temp,
> -	.get_trip_type = sys_get_trip_type,
>   	.set_trip_temp = sys_set_trip_temp,
>   };
>   
> @@ -328,6 +286,48 @@ static int pkg_thermal_notify(u64 msr_val)
>   	return 0;
>   }
>   
> +static struct thermal_trip *pkg_temp_thermal_trips_init(int cpu, int tj_max, int num_trips)
> +{
> +	struct thermal_trip *trips;
> +	unsigned long thres_reg_value;
> +	u32 mask, shift, eax, edx;
> +	int ret, i;
> +
> +	trips = kzalloc(sizeof(*trips) * num_trips, GFP_KERNEL);
> +	if (!trips)
> +		return ERR_PTR(-ENOMEM);
> +	
> +	for (i = 0; i < num_trips; i++) {
> +
> +		if (i) {
> +			mask = THERM_MASK_THRESHOLD1;
> +			shift = THERM_SHIFT_THRESHOLD1;
> +		} else {
> +			mask = THERM_MASK_THRESHOLD0;
> +			shift = THERM_SHIFT_THRESHOLD0;
> +		}
> +
> +		ret = rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
> +				   &eax, &edx);
> +		if (ret < 0) {
> +			kfree(trips);
> +			return ERR_PTR(ret);
> +		}
> +
> +		thres_reg_value = (eax & mask) >> shift;
> +
> +		trips[i].temperature = thres_reg_value ?
> +			tj_max - thres_reg_value * 1000 : THERMAL_TEMP_INVALID;
> +
> +		trips[i].type = THERMAL_TRIP_PASSIVE;
> +		
> +		pr_debug("%s: cpu=%d, trip=%d, temp=%d\n",
> +			 __func__, cpu, i, trips[i].temperature);
> +	}
> +
> +	return trips;
> +}
> +
>   static int pkg_temp_thermal_device_add(unsigned int cpu)
>   {
>   	int id = topology_logical_die_id(cpu);
> @@ -353,24 +353,27 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
>   	if (!zonedev)
>   		return -ENOMEM;
>   
> +	zonedev->trips = pkg_temp_thermal_trips_init(cpu, tj_max, thres_count);
> +	if (IS_ERR(zonedev->trips)) {
> +		err = PTR_ERR(zonedev->trips);
> +		goto out_kfree_zonedev;
> +	}
> +	
>   	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
>   	zonedev->cpu = cpu;
>   	zonedev->tj_max = tj_max;
> -	zonedev->tzone = thermal_zone_device_register("x86_pkg_temp",
> -			thres_count,
> +	zonedev->tzone = thermal_zone_device_register_with_trips("x86_pkg_temp",
> +			zonedev->trips, thres_count,
>   			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
>   			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
>   	if (IS_ERR(zonedev->tzone)) {
>   		err = PTR_ERR(zonedev->tzone);
> -		kfree(zonedev);
> -		return err;
> +		goto out_kfree_trips;
>   	}
>   	err = thermal_zone_device_enable(zonedev->tzone);
> -	if (err) {
> -		thermal_zone_device_unregister(zonedev->tzone);
> -		kfree(zonedev);
> -		return err;
> -	}
> +	if (err)
> +		goto out_unregister_tz;
> +
>   	/* Store MSR value for package thermal interrupt, to restore at exit */
>   	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, zonedev->msr_pkg_therm_low,
>   	      zonedev->msr_pkg_therm_high);
> @@ -379,7 +382,14 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
>   	raw_spin_lock_irq(&pkg_temp_lock);
>   	zones[id] = zonedev;
>   	raw_spin_unlock_irq(&pkg_temp_lock);
> -	return 0;
> +
> +out_unregister_tz:	
> +	thermal_zone_device_unregister(zonedev->tzone);
> +out_kfree_trips:
> +	kfree(zonedev->trips);
> +out_kfree_zonedev:
> +	kfree(zonedev);
> +	return err;
>   }
>   
>   static int pkg_thermal_cpu_offline(unsigned int cpu)
> @@ -463,8 +473,10 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
>   	raw_spin_unlock_irq(&pkg_temp_lock);
>   
>   	/* Final cleanup if this is the last cpu */
> -	if (lastcpu)
> +	if (lastcpu) {
> +		kfree(zonedev->trips);
>   		kfree(zonedev);
> +	}
>   	return 0;
>   }
>   


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
