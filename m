Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2896DD842
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjDKKsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDKKsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:48:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4373358A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:48:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v6so7048027wrv.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681210107; x=1683802107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVDWJnAAwrepPupyFSVjoWUaB4nQWZPWtKMm3U8io/I=;
        b=j3zDcU+iAPsrfADKIV+Gr7vETui9jC7A8eVxsZZFfekHSCqKr5qKn2cka4OmyI1MR8
         bOjUAZp7lkvRFZYFUfUjp+T9sgjgpWNQCmynj/g05FUJjlT+YMGuni8BlbRvqW4loNJk
         5BePMbkBj5b6sQSh7FNtvOPAvbKDwQ5KB2BAikOvZtfjltOEman03qRZRB94AmuSh4pP
         OedN746i/TErka7/ygpzf0jURljow2rPwuMW4k0q/YFlWSf3vC++mDuckRaoySLkwe7K
         ncoKhMwvPEo28Fmm0m71PeA0DgrKS0cgaeZ6n+s77D/iebA8x1CvTHYZJPVCSTipDZfe
         qUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681210107; x=1683802107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVDWJnAAwrepPupyFSVjoWUaB4nQWZPWtKMm3U8io/I=;
        b=ADkmKGD2ctwa+bSF3boysHNVOSSvtFhjWtmYWmDY4IZzDfZOF9Ad6xvEoI/5tXSEvA
         d7w9H0EZi0r8dt/EauUYtwMLM8mH1S8ROZyNrCexel5mkcroxIytOmKozv5+RotGU/Wp
         TWWImZ6muDbnBsycZpVaMaBPXtAr1vrruV+af9ucQgl6jY2+Fj0JgHArrfv4A+H88ghX
         iD7p8ARDrA1vz0PvsiY6dNIoXPwZL+nZLMnTsg2mZryFOvXtcPayVkUQTrREajPAJ0xk
         i6FRvMGaNBSO15WmDk5jXkZyDoNv7A+nswtYppGmW6KmwSIbHEXmlO1RW/pXpls74Tgb
         lTOQ==
X-Gm-Message-State: AAQBX9dUfFwTOhmzJ5aBzr2zj1i3zvm+44M0OhE6eu0oEUjjT3iuCbGv
        Ck8MOmWNvDgWwZbuCE22/vJ1uw==
X-Google-Smtp-Source: AKy350YDrTuMpbPE+jkPqv88NXCrKsMGooMWeJZ4PZE9iPbtrilSMNP5EAs7CfJQWp29ynGqvBXXcw==
X-Received: by 2002:a5d:6a88:0:b0:2c5:4ca3:d56c with SMTP id s8-20020a5d6a88000000b002c54ca3d56cmr9487181wru.0.1681210106957;
        Tue, 11 Apr 2023 03:48:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2611:592:3b9e:d2ae? ([2a05:6e02:1041:c10:2611:592:3b9e:d2ae])
        by smtp.googlemail.com with ESMTPSA id m14-20020a5d6a0e000000b002f01cb41b0bsm6564780wru.60.2023.04.11.03.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 03:48:26 -0700 (PDT)
Message-ID: <c93d583d-e2b8-e8dd-cc94-cd77ecb2cab1@linaro.org>
Date:   Tue, 11 Apr 2023 12:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: thermal/drivers/tegra: Getting rid of the get_thermal_instance()
 usage
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Wei Ni <wni@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Johan Hovold <johan@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
References: <fa2bd92a-f2ae-a671-b537-87c0f3c03dbd@linaro.org>
 <Y9J4WAFyXyV/nqlG@orome> <20230210131703.GF175687@linaro.org>
 <Y+ZQC85TM+O8p8gQ@orome> <365c469b-22f6-fb26-1872-5e9a5079af5d@linaro.org>
 <Y+Ze4tAM6Jpszq/3@orome>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y+Ze4tAM6Jpszq/3@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thierry,

did you have time to look at this ?

This driver is the only one using get_thermal_instance() and I would 
like to remove this function along with the thermal_core.h inclusion in 
this driver

Thanks
   -- Daniel


On 10/02/2023 16:12, Thierry Reding wrote:
> On Fri, Feb 10, 2023 at 03:36:59PM +0100, Daniel Lezcano wrote:
>> On 10/02/2023 15:09, Thierry Reding wrote:
>>> On Fri, Feb 10, 2023 at 02:17:03PM +0100, Daniel Lezcano wrote:
>>>> Hi Thierry,
>>>>
>>>> On Thu, Jan 26, 2023 at 01:55:52PM +0100, Thierry Reding wrote:
>>>>> On Tue, Jan 24, 2023 at 08:57:23PM +0100, Daniel Lezcano wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> does anyone know what is the purpose of the get_thermal_instance() usage in
>>>>>> this code:
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/thermal/tegra/soctherm.c?h=thermal/linux-next#n623
>>>>>>
>>>>>> The driver is using a function which is reserved for the thermal core. It
>>>>>> should not.
>>>>>>
>>>>>> Is the following change ok ?
>>>>>>
>>>>>> diff --git a/drivers/thermal/tegra/soctherm.c
>>>>>> b/drivers/thermal/tegra/soctherm.c
>>>>>> index 220873298d77..5f552402d987 100644
>>>>>> --- a/drivers/thermal/tegra/soctherm.c
>>>>>> +++ b/drivers/thermal/tegra/soctherm.c
>>>>>> @@ -620,9 +620,8 @@ static int tegra_thermctl_set_trip_temp(struct
>>>>>> thermal_zone_device *tz, int trip
>>>>>>    				continue;
>>>>>>
>>>>>>    			cdev = ts->throt_cfgs[i].cdev;
>>>>>> -			if (get_thermal_instance(tz, cdev, trip_id))
>>>>>> -				stc = find_throttle_cfg_by_name(ts, cdev->type);
>>>>>> -			else
>>>>>> +			stc = find_throttle_cfg_by_name(ts, cdev->type);
>>>>>> +			if (!stc)
>>>>>>    				continue;
>>>>>>
>>>>>>    			return throttrip_program(dev, sg, stc, temp);
>>>>>> @@ -768,9 +767,9 @@ static int tegra_soctherm_set_hwtrips(struct device
>>>>>> *dev,
>>>>>>    			continue;
>>>>>>
>>>>>>    		cdev = ts->throt_cfgs[i].cdev;
>>>>>> -		if (get_thermal_instance(tz, cdev, trip))
>>>>>> -			stc = find_throttle_cfg_by_name(ts, cdev->type);
>>>>>> -		else
>>>>>> +
>>>>>> +		stc = find_throttle_cfg_by_name(ts, cdev->type);
>>>>>> +		if (!stc)
>>>>>>    			continue;
>>>>>>
>>>>>>    		ret = throttrip_program(dev, sg, stc, temperature);
>>>>>
>>>>> There's a small difference in behavior after applying this patch. Prior
>>>>> to this I get (on Tegra210):
>>>>>
>>>>> 	[   12.354091] tegra_soctherm 700e2000.thermal-sensor: missing thermtrips, will use critical trips as shut down temp
>>>>> 	[   12.379009] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when cpu reaches 102500 mC
>>>>> 	[   12.388882] tegra_soctherm 700e2000.thermal-sensor: programming throttle for cpu to 102500
>>>>> 	[   12.401007] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when cpu reaches 102500 mC
>>>>> 	[   12.471041] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when gpu reaches 103000 mC
>>>>> 	[   12.482852] tegra_soctherm 700e2000.thermal-sensor: programming throttle for gpu to 103000
>>>>> 	[   12.482860] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when gpu reaches 103000 mC
>>>>> 	[   12.485357] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when pll reaches 103000 mC
>>>>> 	[   12.501774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when mem reaches 103000 mC
>>>>>
>>>>> and after these changes, it turns into:
>>>>>
>>>>> 	[   12.447113] tegra_soctherm 700e2000.thermal-sensor: missing thermtrips, will use critical trips as shut down temp
>>>>> 	[   12.472300] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when cpu reaches 102500 mC
>>>>> 	[   12.481789] tegra_soctherm 700e2000.thermal-sensor: programming throttle for cpu to 102500
>>>>> 	[   12.495447] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when cpu reaches 102500 mC
>>>>> 	[   12.496514] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when gpu reaches 103000 mC
>>>>> 	[   12.510353] tegra_soctherm 700e2000.thermal-sensor: programming throttle for gpu to 103000
>>>>> 	[   12.526856] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when gpu reaches 103000 mC
>>>>> 	[   12.528774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when pll reaches 103000 mC
>>>>> 	[   12.569352] tegra_soctherm 700e2000.thermal-sensor: programming throttle for pll to 103000
>>>>> 	[   12.577635] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when pll reaches 103000 mC
>>>>> 	[   12.590952] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when mem reaches 103000 mC
>>>>> 	[   12.600783] tegra_soctherm 700e2000.thermal-sensor: programming throttle for mem to 103000
>>>>> 	[   12.609204] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when mem reaches 103000 mC
>>>>>
>>>>> The "programming throttle ..." messages are something I've added locally
>>>>> to trace what gets called. So it looks like for "pll" and "mem" thermal
>>>>> zones, we now program trip points whereas we previously didn't.
>>>>
>>>> The DT descriptioni (tegra210.dtsi) says one thing and the implementation says
>>>> something else.
>>>>
>>>> If we refer to the PLL description, there is one 'hot' trip point and
>>>> one 'critical' trip point. No polling delay at all, so we need the
>>>> interrupts.
>>>>
>>>> Logically, we should set the 'hot' trip point first, when the trip
>>>> point is crossed, we setup the next trip point, which is the critical.
>>>>
>>>> With these two trip points, the first one will send a notification to
>>>> the userspace and the second one will force a shutdown of the
>>>> system. For both, no cooling device is expected.
>>>
>>> I think the intention here is to use the soctherm's built-in throttling
>>> mechanism as a last resort measure to try and cool the system down. I
>>> suppose that could count as "passive" cooling, so specifying it as the
>>> cooling device for the "passive" trip point may be more appropriate.
>>>
>>> The throttling that happens here is quite severe, so we don't want it to
>>> happen too early. I would expect that our "passive" trip point shouldn't
>>> be a lot less than the "hot" temperature. I suspect that's the reason
>>> why the "hot" trip point was reused for this.
>>>
>>> I'm also beginning to think that we should just not expose the soctherm
>>> throttling as a cooling device and instead keep it internal to the
>>> soctherm driver entirely.
>>
>> Yes, and perhaps separate it from the sensor driver.
>>
>> There is a similar hardware limiter for the qcom platform [1]. The
>> description in the device tree is separated from the sensor and the binding
>> has temperatures to begin the mitigation [2].
> 
> The hardware throttling is controlled using registers that are part of
> the SOCTHERM block, so we can't separate it from the sensor driver. I
> don't think that's much of a problem, though. The code for this already
> exists in the current soctherm driver, so it's just a matter of removing
> the cooling device registration code.
> 
>>
>> There is no trip point associated as those are related to the in-kernel
>> mitigation.
>>
>> If this mitigation is a heavy mitigation, above what the kernel is able to
>> do with a passive cooling device. It would make sense to just have
>> configured outside of the thermal zone.
>>
>> So the configuration would be something like:
>>
>> myperformance_limite {
>> 	@ = <0x...>
>> 	temperature_limit = 95000;
>> };
>>
>> thermal_zone {
>>
>> 	cpu : {
>> 		trips {
>> 			alert {
>> 			temperature = 90000;
>> 			hysteresis = 2000;
>> 			type = passive;
>> 			};
>>
>> 			hot {
>> 			temperature = 97000;
>> 			type = hot;
>> 			};
>>
>> 			critical {
>> 			temperature = 100000;
>> 			hysteresis = 2000;
>> 			type = critical;
>> 			};
>>
>> 			cooling-maps = <&cpu NO_LIMIT NO_LIMIT>;
>> 		};
>> 	}
>> };
>>
>> The behavior will be a passive mitigation, if it fails the hardware limiter
>> will take over, if that fails then hot sends a notification to the userspace
>> (giving the opportunity to hotplug a cpu or kill a task or suspend), if that
>> fails then shutdown.
> 
> Yeah, that's exactly what I had in mind.
> 
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/thermal/qcom/lmh.c?h=thermal/bleeding-edge
>>
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/arch/arm64/boot/dts/qcom/sdm845.dtsi?h=thermal/bleeding-edge#n3922
>>
>> [ ... ]
>>
>>> On the DT side, I think most of the cooling maps can be cleaned up. We
>>> can remove the entries for "critical" and "hot" trip points if the
>>> driver unconditionally programs the automated throttling.
>>
>> You may want to keep the critical trip points at least. Even if the hardware
>> limiter is certainly very effective, having the critical point is another
>> fail safe allowing to gracefully shutdown the system before a wild hardware
>> reset.
> 
> Yeah. What I meant was to remove only the cooling map entries for
> critical and hot since they would be unused. We absolutely want to
> keep the trip points themselves around to make sure the system will
> forcefully shutdown as a last resort.
> 
> Thierry

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

