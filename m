Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9674DE43
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGJTdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjGJTdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:33:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4EA1B0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:33:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31438512cafso5290088f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689017590; x=1691609590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgGL7ZuT1ZQ4MSvEQ1fRRFlDAGema59SYcvE20z9zTQ=;
        b=ls5ByyPYLHS3gMfhUyOfBk+tv4gW96N75Cl0jAwZCJiVJFFseCk7SPXUUPk33vMvr3
         UCaKzFrGjrDoCw3ghhTzycczoapoqimPGVr1NYIT+o8sB4NvvRLSCAs2n36btIsPit49
         3cSM0zYfMwUelJ/EuSS/9VzRKKT4//ivHugwqI96TUqpuHU8T8tFETZXAZ/1T6g+BJqa
         756ExgEP6fa+rF88eUMYuTXSLeFAy8Fpumx7QIEMUV4Tu//Kpq+EcntdZyMOCzgUAGp7
         re2c/MDGo1GZ/UNPh42d+4Bph5zSBxH9cX4+Q2vbGRdocVNeUdsd/IRhGZ3uoPFj6jLd
         U78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689017590; x=1691609590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgGL7ZuT1ZQ4MSvEQ1fRRFlDAGema59SYcvE20z9zTQ=;
        b=GhmYJmuqGu1/UUcfF+Pui6VE2q1iI4Kb3Xygmtx0t4Zsy55T8U3uTPxymVuUOmK9xQ
         YxTZQPWgkzZS/Z3NMDVpex4Sh3TXzq87qAY/G7QJY0+KlAFKwdYX2Ij9DTgojpYvgBnr
         e8frLG2gxPFMnhQ5E2UnLhdi1EbdjsWA6DathgGHq02dv3eH10hPmR4cAvowm7iPziKl
         wdez4Za+B/JFO2mqlg8T8yvOGBFGZ8HO07XrJ8OIMDO8ILH+eARd0SdxUAyC/WUYg63x
         KDtyc8bWOVk8POrQ8UNSUT2sA+QJGtAvnENyMD7iQVsxsffn8L28vn8qTy/aZXUMRB/Y
         cXhA==
X-Gm-Message-State: ABy/qLah+8wbWxvBBlwzX84ubxzuyE6YzoXtXeMy0+Za3OxOeZojzCOn
        /jtM2rN3MjfXBcqDSpM0HOPvOw==
X-Google-Smtp-Source: APBJJlF+6gXaD93j7ieuuFpwYDNRQl6W6FclGdGlnlo+D5iQOal/dQ8eF9w5nc2PUcspGWLbB4pztA==
X-Received: by 2002:adf:cd0d:0:b0:30f:c1c3:8173 with SMTP id w13-20020adfcd0d000000b0030fc1c38173mr12966919wrm.26.1689017590103;
        Mon, 10 Jul 2023 12:33:10 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f4-20020a5d4dc4000000b0031424f4ef1dsm237668wru.19.2023.07.10.12.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 12:33:09 -0700 (PDT)
Message-ID: <f7cf2153-aa22-d376-f776-54ea940a5e35@linaro.org>
Date:   Mon, 10 Jul 2023 21:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V5] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
Content-Language: en-US
To:     Di Shen <cindygm567@gmail.com>
Cc:     Di Shen <di.shen@unisoc.com>, lukasz.luba@arm.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, jeson.gao@unisoc.com, orsonzhai@gmail.com,
        zhanglyra@gmail.com
References: <20230710033234.28641-1-di.shen@unisoc.com>
 <6d3f24a4-ae70-49eb-6e41-86baa1db6bed@linaro.org>
 <CAHYJL4og14kQ4ev6QtDQeknJELME7URTN_HmR01P5+2RhpthzQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAHYJL4og14kQ4ev6QtDQeknJELME7URTN_HmR01P5+2RhpthzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Di,


On 10/07/2023 15:36, Di Shen wrote:
> Hi Daniel,
> Thank you for your reply.
> On Mon, Jul 10, 2023 at 4:59 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 10/07/2023 05:32, Di Shen wrote:
>>> When the thermal trip point is changed, the governor should
>>> be reset so that the policy algorithm can be updated to adapt
>>> to the new trip point.
>>>
>>> 1.Thermal governor is working for the passive trip point or active
>>> trip point. Therefore, when the trip point is changed it should
>>> reset the governor only for passic/active trip points.
>>>
>>> 2.For "power_allocator" governor reset, the parameters of pid
>>> controller and the states of power cooling devices should be reset.
>>>
>>> 2.1
>>> The IPA controls temperature using PID mechanism. It is a closed-
>>> loop feedback monitoring system. It uses the gap between target
>>> temperature and current temperature which says "error" as the
>>> input of the PID controller:
>>>
>>> err = desired_temperature - current_temperature
>>> P_max =
>>> k_p * err + k_i * err_integral + k_d * diff_err + sustainable_power
>>>
>>> That algorithm can 'learn' from the 'observed' in the past reaction
>>> for it's control decisions and accumulates that information in the
>>> I(Integral) part so that it can conpensate for those 'learned'
>>> mistakes.
>>>
>>> Based on the above, the most important is the desired temperature
>>> comes from the trip point. When the trip point is changed, all the
>>> previous learned errors won't help for the IPA. So the pid parameters
>>> should be reset for IPA governor reset.
>>>
>>> 2.2
>>> Other wise, the cooling devices should also be reset when the trip
>>> point is changed.
>>>
>>> This patch adds an ops for the thermal_governor structure to reset
>>> the governor and give the 'reset' function definition for power
>>> allocator. The ops is called when the trip points are changed via
>>> sysfs interface.
>>>
>>> Signed-off-by: Di Shen <di.shen@unisoc.com>
>>> ---
>>>    drivers/thermal/gov_power_allocator.c | 9 +++++++++
>>>    drivers/thermal/thermal_trip.c        | 5 +++++
>>>    include/linux/thermal.h               | 3 +++
>>>    3 files changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>>> index 8642f1096b91..8d17a10671e4 100644
>>> --- a/drivers/thermal/gov_power_allocator.c
>>> +++ b/drivers/thermal/gov_power_allocator.c
>>> @@ -729,10 +729,19 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
>>>        return allocate_power(tz, trip.temperature);
>>>    }
>>>
>>> +static void power_allocator_reset(struct thermal_zone_device *tz)
>>> +{
>>> +     struct power_allocator_params *params = tz->governor_data;
>>> +
>>> +     reset_pid_controller(params);
>>> +     allow_maximum_power(tz, true);
>>
>> Do you really want to allow the maximum power? What about if the trip
>> temperature is decreased ?
>>
> If the trip temperature is decreased, allow_maximum_power will only
> be executed once, and then the ipa governor will adapt to the lower trip
> temperature and calculate the allocated power for cooling actors again.
> Right?

Sorry for jumping in this fifth version but I'm not sure about resetting 
the change is the right way (and probably, changing a trip point with 
the power allocator is not a good idea)

The platforms where the IPA is planned to be used are creating a dummy 
trip point where the IPA begins the acquisition without cooling devices 
in order to have the math building the PID schema (eg. hi3660.dtsi).

What about the sustainable power vs the trip point temperature? I mean 
we can change the trip temperature but not the sustainable power which 
is directly related to the target temperature. So the resulting power 
computation will be wrong.

The more I think about that, the more I do believe writable trip point 
and IPA are incompatible.

What about forbid that?

For instance, add a set_trip callback instead of resetting in the 
governor and return -EPERM from the IPA?

Lukasz ?

> But if the trip temperature is increased, it must allow the maximum power,

I would not say allow the maximum temperature but the new power head 
room. But that needs an update of the sustainable power information 
related to the new temperature :/

> otherwise, the Line 723 update flag might be false(see the false example
> in patch-v3), the power of cooling devices would be not allowed maximum
> for a while unless the current temperature is higher than the new
> switch_on_temp. In this situation, for cpufreq cooling devices, it means the
> cpu max_freq is limited, which is bad for device performance. The same for
> other cooling devices, if not reset the cooling state, it may introduce
> unexpected issues.
> 
> 705 static int power_allocator_throttle(struct thermal_zone_device
> *tz, int trip_id)
> 706 {
> 707         struct power_allocator_params *params = tz->governor_data;
> 708         struct thermal_trip trip;
> 709         int ret;
> 710         bool update;
> 711
> 712        //......
> 721         ret = __thermal_zone_get_trip(tz, params->trip_switch_on,
> &trip);
> 722         if (!ret && (tz->temperature < trip.temperature)) {
> 723                 update = (tz->last_temperature >=
> trip.temperature);
> 724                 tz->passive = 0;
> 725                 reset_pid_controller(params);
> 726                 allow_maximum_power(tz, update);
> 727                 return 0;
> 728         }
> 729
> 730         tz->passive = 1;
> 731          //.......
> 740 }
> 
>> You want maximum power only if the mitigation ends.
>>
> Yes, you're right, I agree. It's better to do like that, actually,
> patch-v3 is in line
> with this point I think, but it is not in the thermal core.
> 
> Oh, I see!
> How about modified like that:
> static void power_allocator_reset(struct thermal_zone_device *tz)
> {
>       struct power_allocator_params *params = tz->governor_data;
> +   struct thermal_trip trip;
> +   int ret;
> 
>       reset_pid_controller(params);
> +   ret = __thermal_zone_get_trip(tz, params->trip_switch_on, &trip);
> +   if (!ret && (tz->temperature < trip.temperature))
>               allow_maximum_power(tz, true);

No, that would be wrong. It should be
	(tz->temperature - hysteresis) < trip.temperature

But if we are in the hysteresis area, we should allow a bit more power 
which depends on the sustainable power which was not updated with the 
trip temperature change :/

> }
> It seems clearer.
> 
>>> +}
>>> +
>>>    static struct thermal_governor thermal_gov_power_allocator = {
>>>        .name           = "power_allocator",
>>>        .bind_to_tz     = power_allocator_bind,
>>>        .unbind_from_tz = power_allocator_unbind,
>>>        .throttle       = power_allocator_throttle,
>>> +     .reset          = power_allocator_reset,
>>>    };
>>>    THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
>>> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
>>> index 907f3a4d7bc8..13bbe029c6ab 100644
>>> --- a/drivers/thermal/thermal_trip.c
>>> +++ b/drivers/thermal/thermal_trip.c
>>> @@ -173,6 +173,11 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
>>>        if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
>>>                tz->trips[trip_id] = *trip;
>>>
>>> +     /* Reset the governor only when the trip type is active or passive. */
>>> +     ret = (trip->type == THERMAL_TRIP_PASSIVE || trip->type == THERMAL_TRIP_ACTIVE);
>>
>> Actually we have the trip points:
>>
>> ACTIVE, PASSIVE, HOT and CRITICAL
>>
> Correct.
> 
>> The last two ones should not be writable.
>>
>> Instead of this test, it would be cleaner to only make the ACTIVE and
>> PASSIVE trip point writable when the CONFIG_THERMAL_WRITABLE_TRIPS
>> option is set. Consequently, other trip points won't be writable and
>> this test can go away as set_trip will be protected by a RO sysfs file
>> property.
>>
>>> +     if (ret && t.temperature != trip->temperature && tz->governor && tz->governor->reset)
>>
>> The temperature test is duplicated because it is already done in the
>> block before.
>>
> So here you mean two points:
> 1. Make the HOT and CRITICAL point RO so that it can no trip type test
> when gov->reset
> 2. not do the temperature test twice
> Right?

HOT and CRITICAL can not be changed because RO. The core code can use 
this assumption by not checking they are changed.

> For the first point, it's OK for me. But what if someone wants to
> power off the device earlier
> or later? I think it should have the access to update the critical
> temperature. 
 >
> I'm not really
> know about the hot trip temperature. So I'm not sure the real reason
> to make them RO
> when the trip points are writable. I can't make it RO just because of
> the code simplification.

That is critical firmware information and it must not be touched by the 
user (even root). Imagine I can set 250°C for the critical trip point 
while the silicon supports 120°C only?

So basically, we should protect these trip points by making them RO.

By fixing this, only PASSIVE and ACTIVE trip points can be changed, thus 
checking CRITICAL and HOT above is pointless.


> For the second point, that's OK. I will simplify in the next patch
> version. Thank you, Daniel.

Before sending a new version, IMO we should think a bit about writable 
trip points in general because the feature does not look mature.


>>> +             tz->governor->reset(tz);
>>> +
>>>        thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
>>>                                      trip->temperature, trip->hysteresis);
>>>
>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>> index 87837094d549..d27d053319bf 100644
>>> --- a/include/linux/thermal.h
>>> +++ b/include/linux/thermal.h
>>> @@ -197,6 +197,8 @@ struct thermal_zone_device {
>>>     *                  thermal zone.
>>>     * @throttle:       callback called for every trip point even if temperature is
>>>     *          below the trip point temperature
>>> + * @reset:   callback called for governor reset
>>> + *
>>>     * @governor_list:  node in thermal_governor_list (in thermal_core.c)
>>>     */
>>>    struct thermal_governor {
>>> @@ -204,6 +206,7 @@ struct thermal_governor {
>>>        int (*bind_to_tz)(struct thermal_zone_device *tz);
>>>        void (*unbind_from_tz)(struct thermal_zone_device *tz);
>>>        int (*throttle)(struct thermal_zone_device *tz, int trip);
>>> +     void (*reset)(struct thermal_zone_device *tz);
>>>        struct list_head        governor_list;
>>>    };
>>>
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>
> 
> Best regards,
> Di

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

