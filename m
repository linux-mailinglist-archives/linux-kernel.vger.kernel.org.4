Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13B74D0AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjGJIzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjGJIzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:55:37 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C063EC3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:55:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b701e1c80fso61581071fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688979334; x=1691571334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yn9ioLNwEgAe0GJRu4yxWz0XbMvGtpC919vku2LmRu4=;
        b=FlzVImcE4J5Y7YSTzYuyGCbRicW0KB3qKsGvjoU8PQ0R4leQk/PcmX8CTdF6m+2s4H
         vCVuFkamxEX2swHPAINA66ayYIKUC7MC0IPOGd874mgKnuey/7lkYXAI1KCtSJocLmpl
         m+de3Bx80f6tout5/MvTvg2JSwXrAKNHlXzutUNUtYUmCDEIrREd8MYwbbGEeDUAlONi
         jOUE48BKU4CtjaSjZXGsq0ADM7spH7d/s1rOq5OWD9Ti64TfQud+kAVVFkNwZHlRSPJz
         lzZknudmSWRe+YPoIYGAJ+9z8j2O2FwWH4T2KnQv40RQvnmWX754+zsll9n1HkFyXjjy
         zPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688979334; x=1691571334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yn9ioLNwEgAe0GJRu4yxWz0XbMvGtpC919vku2LmRu4=;
        b=Kxww/A0QnChp/QIBUwtuF5NalbpXzYOaC9bQJTldco4PvPc86SA1QMy7BA3lOiTn60
         qYE9LpasfzIOqMDUAU9twct4yGnzChAgvDztZi16WRo3qk6bRWleRDI2rMIHQSFSiStM
         PjhOmjTHq6S+fB3IiVRFjttzfQ8UQmzFB4vOo5lmF3fW5h+bF8h9ZGJyVNS1so/EwNKj
         Upwgq7mbl3sm+zQLVIgdzQqjq7LrskCCIyNjoS6wA0RaGq0dfPDMtT0bvfPZ9Cw4tDoU
         QhxCytfQjwZ2lu/yl53xBbZQANoODxksc+gnmWggwWi6CecdqMF8CVaVC+x6vYdWclvk
         VG5g==
X-Gm-Message-State: ABy/qLYNhydguZQhp0PvtzZKUEBznIYck7vv1tAlqGCjIaqoh2IE7ZXy
        Pjb3HMD3cB0FoHpcx3lqtkvi2A==
X-Google-Smtp-Source: APBJJlHf6M7nrwzpmLVNv3eHxsbeIXrb/TI4xh1WONMNAfVQ84+jVpvqnsf2XyHfPXAhMcBR2Mg56g==
X-Received: by 2002:a2e:9206:0:b0:2b6:ba00:f733 with SMTP id k6-20020a2e9206000000b002b6ba00f733mr8666371ljg.18.1688979333800;
        Mon, 10 Jul 2023 01:55:33 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id k12-20020a7bc30c000000b003fba92fad35sm9677016wmj.26.2023.07.10.01.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 01:55:33 -0700 (PDT)
Message-ID: <6d3f24a4-ae70-49eb-6e41-86baa1db6bed@linaro.org>
Date:   Mon, 10 Jul 2023 10:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V5] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
Content-Language: en-US
To:     Di Shen <di.shen@unisoc.com>, lukasz.luba@arm.com,
        rafael@kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, orsonzhai@gmail.com, zhanglyra@gmail.com
References: <20230710033234.28641-1-di.shen@unisoc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230710033234.28641-1-di.shen@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 05:32, Di Shen wrote:
> When the thermal trip point is changed, the governor should
> be reset so that the policy algorithm can be updated to adapt
> to the new trip point.
> 
> 1.Thermal governor is working for the passive trip point or active
> trip point. Therefore, when the trip point is changed it should
> reset the governor only for passic/active trip points.
> 
> 2.For "power_allocator" governor reset, the parameters of pid
> controller and the states of power cooling devices should be reset.
> 
> 2.1
> The IPA controls temperature using PID mechanism. It is a closed-
> loop feedback monitoring system. It uses the gap between target
> temperature and current temperature which says "error" as the
> input of the PID controller:
> 
> err = desired_temperature - current_temperature
> P_max =
> k_p * err + k_i * err_integral + k_d * diff_err + sustainable_power
> 
> That algorithm can 'learn' from the 'observed' in the past reaction
> for it's control decisions and accumulates that information in the
> I(Integral) part so that it can conpensate for those 'learned'
> mistakes.
> 
> Based on the above, the most important is the desired temperature
> comes from the trip point. When the trip point is changed, all the
> previous learned errors won't help for the IPA. So the pid parameters
> should be reset for IPA governor reset.
> 
> 2.2
> Other wise, the cooling devices should also be reset when the trip
> point is changed.
> 
> This patch adds an ops for the thermal_governor structure to reset
> the governor and give the 'reset' function definition for power
> allocator. The ops is called when the trip points are changed via
> sysfs interface.
> 
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
>   drivers/thermal/gov_power_allocator.c | 9 +++++++++
>   drivers/thermal/thermal_trip.c        | 5 +++++
>   include/linux/thermal.h               | 3 +++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 8642f1096b91..8d17a10671e4 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -729,10 +729,19 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
>   	return allocate_power(tz, trip.temperature);
>   }
>   
> +static void power_allocator_reset(struct thermal_zone_device *tz)
> +{
> +	struct power_allocator_params *params = tz->governor_data;
> +
> +	reset_pid_controller(params);
> +	allow_maximum_power(tz, true);

Do you really want to allow the maximum power? What about if the trip 
temperature is decreased ?

You want maximum power only if the mitigation ends.

> +}
> +
>   static struct thermal_governor thermal_gov_power_allocator = {
>   	.name		= "power_allocator",
>   	.bind_to_tz	= power_allocator_bind,
>   	.unbind_from_tz	= power_allocator_unbind,
>   	.throttle	= power_allocator_throttle,
> +	.reset		= power_allocator_reset,
>   };
>   THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
> index 907f3a4d7bc8..13bbe029c6ab 100644
> --- a/drivers/thermal/thermal_trip.c
> +++ b/drivers/thermal/thermal_trip.c
> @@ -173,6 +173,11 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
>   	if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
>   		tz->trips[trip_id] = *trip;
>   
> +	/* Reset the governor only when the trip type is active or passive. */
> +	ret = (trip->type == THERMAL_TRIP_PASSIVE || trip->type == THERMAL_TRIP_ACTIVE);

Actually we have the trip points:

ACTIVE, PASSIVE, HOT and CRITICAL

The last two ones should not be writable.

Instead of this test, it would be cleaner to only make the ACTIVE and 
PASSIVE trip point writable when the CONFIG_THERMAL_WRITABLE_TRIPS 
option is set. Consequently, other trip points won't be writable and 
this test can go away as set_trip will be protected by a RO sysfs file 
property.

> +	if (ret && t.temperature != trip->temperature && tz->governor && tz->governor->reset)

The temperature test is duplicated because it is already done in the 
block before.

> +		tz->governor->reset(tz);
> +
>   	thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
>   				      trip->temperature, trip->hysteresis);
>   
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 87837094d549..d27d053319bf 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -197,6 +197,8 @@ struct thermal_zone_device {
>    *			thermal zone.
>    * @throttle:	callback called for every trip point even if temperature is
>    *		below the trip point temperature
> + * @reset:	callback called for governor reset
> + *
>    * @governor_list:	node in thermal_governor_list (in thermal_core.c)
>    */
>   struct thermal_governor {
> @@ -204,6 +206,7 @@ struct thermal_governor {
>   	int (*bind_to_tz)(struct thermal_zone_device *tz);
>   	void (*unbind_from_tz)(struct thermal_zone_device *tz);
>   	int (*throttle)(struct thermal_zone_device *tz, int trip);
> +	void (*reset)(struct thermal_zone_device *tz);
>   	struct list_head	governor_list;
>   };
>   

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

