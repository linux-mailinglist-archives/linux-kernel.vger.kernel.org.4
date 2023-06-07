Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0901D726883
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjFGSXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjFGSXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:23:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB34268C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:23:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso64310345e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686162190; x=1688754190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/WwZsL8Wk0zor7bgL9dxnC1U3BE7RE1tVJNNSTXoZ8=;
        b=IKS+x77+W8yohyWpqLtH2CJIh0hMEMuRJ8brnwg9TC5aNtkSJz/edDzaiPlI7j1l6E
         3WyD5T+QqrHl+kDE10yNHnLUh/+5UnDsomDBrVRWn8sBnWgifJSYi2NhsjsEV7qsc+Vf
         t1G1O/PWaCRGQeNXuAB9uUktRiQAaqkl/wL4hGMPyMj4q0oBeecltWKGghe63owYBpPs
         ZD/CwwmODdJmSt6oKsbu3wjOpY6h2qb2csTg2dyTkwZgH8AP13KnINyNQWEKDXlSnSWD
         BoSkakjWvo3lceieDL/md72GJ4zEvucrncdGdVSpfLBkOvvLVGuK4koul/y8IRbKYLPT
         R1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686162190; x=1688754190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/WwZsL8Wk0zor7bgL9dxnC1U3BE7RE1tVJNNSTXoZ8=;
        b=JzZnImwks85l62q/q73CDYiH2HIQq6+s34oZxpt6b3X3aiaCMhsCFvU7n5F78a8j4N
         kmv+ppg/+0BKMC/JEE5SxOrIzN+jYdfstTfPk0qQFsDjOgy9HUgL3UwZro6Iza/FkKeH
         orU9U3Xk3/pYCylzw8gWZ7XIE+rjZ7bZSUqzNDrazCBO99ieektuwPdXp2xKu4nM97q+
         OZaa1OUzNt+qdnp04hNgqWtwxoWvCmMzGPQDMSeoZEMm7QKFnyAa8bNsI4+Ko2EocqXW
         o5ylq0seM87Mcr75OJ2Gz1rBnW2jTo4tUkgc8JgbGXkogSRy/I46n2gviUVJnU9evfXU
         gsuQ==
X-Gm-Message-State: AC+VfDy+RBCRoPEZEVlLq/nyPAXyI70HPjt6+C8kct6j2oDOGJR8dgP6
        70ZY/FvW6jZjnd4KKAMd8APmww==
X-Google-Smtp-Source: ACHHUZ75qjz+sk0uLKGgjVqEVzvXzEpItO/09gLKZP7kMwhrRUJgHlfhxIKvMEJAQwQGBcmTF9io/A==
X-Received: by 2002:adf:e50e:0:b0:309:419b:925d with SMTP id j14-20020adfe50e000000b00309419b925dmr4535366wrm.70.1686162189685;
        Wed, 07 Jun 2023 11:23:09 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3a59:921c:4758:7db5? ([2a05:6e02:1041:c10:3a59:921c:4758:7db5])
        by smtp.googlemail.com with ESMTPSA id b3-20020a5d4d83000000b0030c4d8930b1sm16108874wru.91.2023.06.07.11.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 11:23:09 -0700 (PDT)
Message-ID: <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
Date:   Wed, 7 Jun 2023 20:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Content-Language: en-US
To:     Eduardo Valentin <evalenti@kernel.org>
Cc:     eduval@amazon.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20230607003721.834038-1-evalenti@kernel.org>
 <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
 <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 18:38, Eduardo Valentin wrote:
> Hey Daniel,
> 
> Thanks for taking the time to read the patch.
> 
> On Wed, Jun 07, 2023 at 11:24:21AM +0200, Daniel Lezcano wrote:
>>
>>
>>
>> Hi Eduardo,
>>
>> On 07/06/2023 02:37, Eduardo Valentin wrote:
>>> From: Eduardo Valentin <eduval@amazon.com>
>>>
>>> As the thermal zone caches the current and last temperature
>>> value, the sysfs interface can use that instead of
>>> forcing an actual update or read from the device.
>>
>> If the read fails, userspace can handle that by using the previous
>> value. Do we really want to hide driver dysfunctions?
> 
> Good point.
> 
> In fact I thought of this exact problem. I sent only this patch,
> but it has more changes to come.
> 
> The next changes will replicate the current design of
> storing last_temperature in the thermal zone to also store
> the last return value, success or error, on the thermal zone
> too so that we can use here at the front end to report back
> to userspace when the reads are failing.
 >
> But yes, you are right, we do not want to keep reporting
> a successful read when the thermal zone thread has been
> failing to update the value, that needs to be reported
> up back to userspace.

IIUC, you want the temperature to be updated only by the polling thread 
and when the userspace reads the temperature, it reads a cached value, 
is that correct ?

>>> This way, if multiple userspace requests are coming
>>> in, we avoid storming the device with multiple reads
>>> and potentially clogging the timing requirement
>>> for the governors.

Sorry, I'm not convinced :/

>> Can you elaborate 'the timing requirement for the governors' ? I'm
>> missing the point
> 
> 
> The point is to avoid contention on the device update path.
> Governor that use differential equations on temperature over time
> will be very time sensitive. Step wise, power allocator, or any
> PID will be very sensitive to time. So, If userspace is hitting
> this API too often we can see cases where the updates needed to
> service userspace may defer/delay the execution of the governor
> logic.

AFAIK, reading a temperature value is usually between less than 1us and 
10us (depending on the sampling configuration in the driver).

I've done some measurements to read a temperature through sysfs and 
netlink. It is between 2us and 7us on a platforms where reading a 900ns 
latency sensor, sysfs being faster.

The time sensitive governor is the power allocator and usually, the 
sampling period is between 100ms and 250ms.

The thermal zones with fast thermal transitions may need faster sampling 
period but the hardware offloads the mitigation in this case by sampling 
every 100*us*, IIRC.

Given that, I'm not sure we are facing a design issue with thermal 
framework.

Do you have a use case with some measurements to spot an issue or is it 
a potential issue you identified ?

> Despite that, there is really no point to have more updates than
> what was configured for the thermal zone to support. Say that
> we configure a thermal zone to update itself every 500ms, yet
> userspace keeps sending reads every 100ms, we do not need necessarily
> to do a trip to the device every single time to update the temperature,
> as per the design for the thermal zone.

Sorry, I do not agree. The thermal zone is configured with a monitoring 
sampling period to detect trip point crossing and it can be configured 
without sampling period at all, just basing on trip point crossing 
interrupt.

The userspace has the right to read the current temperature it is 
interested in. For instance, the 'thermometer' in 
tools/thermal/thermometer may want to read the temperature at a high 
rate in order to profile the thermal zones with/without the mitigation 
kicking in.

Caching the values just break the current behavior.

>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
>>> Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
>>> Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
>>> Cc: linux-pm@vger.kernel.org (open list:THERMAL)
>>> Cc: linux-kernel@vger.kernel.org (open list)
>>>
>>> Signed-off-by: Eduardo Valentin <eduval@amazon.com>
>>> ---
>>>    drivers/thermal/thermal_sysfs.c | 21 ++++++++++++++++-----
>>>    1 file changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
>>> index b6daea2398da..a240c58d9e08 100644
>>> --- a/drivers/thermal/thermal_sysfs.c
>>> +++ b/drivers/thermal/thermal_sysfs.c
>>> @@ -35,12 +35,23 @@ static ssize_t
>>>    temp_show(struct device *dev, struct device_attribute *attr, char *buf)
>>>    {
>>>        struct thermal_zone_device *tz = to_thermal_zone(dev);
>>> -     int temperature, ret;
>>> -
>>> -     ret = thermal_zone_get_temp(tz, &temperature);
>>> +     int temperature;
>>>
>>> -     if (ret)
>>> -             return ret;
>>> +     /*
>>> +      * don't force new update from external reads
>>> +      * This way we avoid messing up with time constraints.
>>> +      */
>>> +     if (tz->mode == THERMAL_DEVICE_DISABLED) {
>>> +             int r;
>>> +
>>> +             r = thermal_zone_get_temp(tz, &temperature); /* holds tz->lock*/
>>> +             if (r)
>>> +                     return r;
>>> +     } else {
>>> +             mutex_lock(&tz->lock);
>>> +             temperature = tz->temperature;
>>> +             mutex_unlock(&tz->lock);
>>> +     }
>>
>> No please, we are pushing since several weeks a lot of changes to
>> encapsulate the thermal zone device structure and prevent external core
>> components to use the internals directly. Even if we can consider the
>> thermal_sysfs as part of the core code, that changes is not sysfs related.
> 
> Can you clarify your concern, is it the direct access ? The lock ?
> what is the concern?
> 
> What is your suggestion here? Do you want me to write a helper
> function that gets tz->temperature without doing a ops->get_temp()?

The concern is the thermal framework code is not really in a good shape 
and the internals leaked around in the different drivers all around the 
subsystems, that led to drivers tampering with the thermal zone device 
structure data (including taking locks).

There are ongoing efforts to do some house cleaning around the thermal 
zone device structure encapsulation as well as getting ride of the 
different ops get_trip* by replacing that with a generic trip point 
structure to deal with in the thermal core code.

Those with the final objective to have the trip points ordered and 
handle the trip point crossing correctly detected (it is currently 
somehow broken).

Here the code does directly access tz->*.

Even not being convinced by the change proposal, I would have handle 
this value cache in the thermal_zone_get_temp() function directly in 
order to preserve the code self-encapsulation.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

