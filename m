Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB826B101B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCHRXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCHRWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:22:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97A5567B5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:21:44 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso1834471wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 09:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678296103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMBPLwmXyTz7mlDCuN3O0V+WpRxXWFBmBWl2SNVqS1g=;
        b=s6gQM/VtwKirxxKzNvmm9JzhAhUqG0nHrWvqCtJpLxr7X2iIneE1MwHASiqW06Y7Wv
         3bOkvHM0D9pJTtAtcyjr6pmMfSpGTjwOE7Pe2qsqkeCTjWFYBBSPO2Ht0kGLGTPnok87
         K+YaML/H1aj0ZprsmgmmWVWjT9dtQn0GjvCJomUFhJe02uZ/R36Ge3b60N3PR59npD1F
         W2pf6cq5WfkC/YpvQJslv3r5zWR8tONshT0GrgyTfq2cQaJbI130K/4d8ewgKRH2Renw
         Drw6uwKQMOsYaQNzZ6i6GPOkSP9PA0Fu67m+dWnZEzciCBoZNLKmBilG8YYmHCIzJlsU
         4Eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678296103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMBPLwmXyTz7mlDCuN3O0V+WpRxXWFBmBWl2SNVqS1g=;
        b=2Dcer+isGuiPhih4jqAuXGPnXllx9HuVqVgAdCkPf7JBHpQ1bx84YL4b6OMolmdKgT
         btIdAgn9eNVScSKfbaFIZdvquNAOZSoRIBep939fY9CJRx0/ZL5ayA58OirUh/OEkiVU
         oU8X2+TZ2j6/MAda0Tbv/YIYT0VpLCzNGd/3iIjk6r1gV4iVBL94DjD0tqrOysIB8Mkw
         0zISPXArKLzhUOnPwPeKHOjI7kEAoTzPfazy4LFwK4Qz1FxflFmD4+H3y0EyjOXU+Uc5
         Mdc0WlmCvbZGC7FNDehNdcJi4hwbIGv5PwX3xs9OEUPFS7Lp39YAni8hPx1OU18U4Osd
         OeXg==
X-Gm-Message-State: AO0yUKVZla19WTRYdalyiP66f2GQ+b95XWfrQrX2qx0zrE/mY/ncEtiN
        JSdtwC+xuwgQCIMDtlERlfGFhA==
X-Google-Smtp-Source: AK7set9BTwgGUpksfyJLCnL6I7a6OQD9RsvOB32QRsaI6Dhl7wGNwA8Ph2+6mmWAkUaWlECqHz3GfA==
X-Received: by 2002:a05:600c:450f:b0:3e2:19b0:887d with SMTP id t15-20020a05600c450f00b003e219b0887dmr16873432wmo.25.1678296103096;
        Wed, 08 Mar 2023 09:21:43 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:4213:ad42:5630:43c4? ([2a05:6e02:1041:c10:4213:ad42:5630:43c4])
        by smtp.googlemail.com with ESMTPSA id l21-20020a05600c1d1500b003ebf73acf9asm3128401wms.3.2023.03.08.09.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 09:21:42 -0800 (PST)
Message-ID: <d7286d1f-2ef1-248d-58a2-10ce68de0bcf@linaro.org>
Date:   Wed, 8 Mar 2023 18:21:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
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
 <Y+ZQC85TM+O8p8gQ@orome>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y+ZQC85TM+O8p8gQ@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thierry,

did you have time to look to the changes ?

Or at least a way to remove the get_thermal_instance() usage ?




On 10/02/2023 15:09, Thierry Reding wrote:
> On Fri, Feb 10, 2023 at 02:17:03PM +0100, Daniel Lezcano wrote:
>> Hi Thierry,
>>
>> On Thu, Jan 26, 2023 at 01:55:52PM +0100, Thierry Reding wrote:
>>> On Tue, Jan 24, 2023 at 08:57:23PM +0100, Daniel Lezcano wrote:
>>>>
>>>> Hi,
>>>>
>>>> does anyone know what is the purpose of the get_thermal_instance() usage in
>>>> this code:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/thermal/tegra/soctherm.c?h=thermal/linux-next#n623
>>>>
>>>> The driver is using a function which is reserved for the thermal core. It
>>>> should not.
>>>>
>>>> Is the following change ok ?
>>>>
>>>> diff --git a/drivers/thermal/tegra/soctherm.c
>>>> b/drivers/thermal/tegra/soctherm.c
>>>> index 220873298d77..5f552402d987 100644
>>>> --- a/drivers/thermal/tegra/soctherm.c
>>>> +++ b/drivers/thermal/tegra/soctherm.c
>>>> @@ -620,9 +620,8 @@ static int tegra_thermctl_set_trip_temp(struct
>>>> thermal_zone_device *tz, int trip
>>>>   				continue;
>>>>
>>>>   			cdev = ts->throt_cfgs[i].cdev;
>>>> -			if (get_thermal_instance(tz, cdev, trip_id))
>>>> -				stc = find_throttle_cfg_by_name(ts, cdev->type);
>>>> -			else
>>>> +			stc = find_throttle_cfg_by_name(ts, cdev->type);
>>>> +			if (!stc)
>>>>   				continue;
>>>>
>>>>   			return throttrip_program(dev, sg, stc, temp);
>>>> @@ -768,9 +767,9 @@ static int tegra_soctherm_set_hwtrips(struct device
>>>> *dev,
>>>>   			continue;
>>>>
>>>>   		cdev = ts->throt_cfgs[i].cdev;
>>>> -		if (get_thermal_instance(tz, cdev, trip))
>>>> -			stc = find_throttle_cfg_by_name(ts, cdev->type);
>>>> -		else
>>>> +
>>>> +		stc = find_throttle_cfg_by_name(ts, cdev->type);
>>>> +		if (!stc)
>>>>   			continue;
>>>>
>>>>   		ret = throttrip_program(dev, sg, stc, temperature);
>>>
>>> There's a small difference in behavior after applying this patch. Prior
>>> to this I get (on Tegra210):
>>>
>>> 	[   12.354091] tegra_soctherm 700e2000.thermal-sensor: missing thermtrips, will use critical trips as shut down temp
>>> 	[   12.379009] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when cpu reaches 102500 mC
>>> 	[   12.388882] tegra_soctherm 700e2000.thermal-sensor: programming throttle for cpu to 102500
>>> 	[   12.401007] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when cpu reaches 102500 mC
>>> 	[   12.471041] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when gpu reaches 103000 mC
>>> 	[   12.482852] tegra_soctherm 700e2000.thermal-sensor: programming throttle for gpu to 103000
>>> 	[   12.482860] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when gpu reaches 103000 mC
>>> 	[   12.485357] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when pll reaches 103000 mC
>>> 	[   12.501774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when mem reaches 103000 mC
>>>
>>> and after these changes, it turns into:
>>>
>>> 	[   12.447113] tegra_soctherm 700e2000.thermal-sensor: missing thermtrips, will use critical trips as shut down temp
>>> 	[   12.472300] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when cpu reaches 102500 mC
>>> 	[   12.481789] tegra_soctherm 700e2000.thermal-sensor: programming throttle for cpu to 102500
>>> 	[   12.495447] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when cpu reaches 102500 mC
>>> 	[   12.496514] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when gpu reaches 103000 mC
>>> 	[   12.510353] tegra_soctherm 700e2000.thermal-sensor: programming throttle for gpu to 103000
>>> 	[   12.526856] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when gpu reaches 103000 mC
>>> 	[   12.528774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when pll reaches 103000 mC
>>> 	[   12.569352] tegra_soctherm 700e2000.thermal-sensor: programming throttle for pll to 103000
>>> 	[   12.577635] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when pll reaches 103000 mC
>>> 	[   12.590952] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when mem reaches 103000 mC
>>> 	[   12.600783] tegra_soctherm 700e2000.thermal-sensor: programming throttle for mem to 103000
>>> 	[   12.609204] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when mem reaches 103000 mC
>>>
>>> The "programming throttle ..." messages are something I've added locally
>>> to trace what gets called. So it looks like for "pll" and "mem" thermal
>>> zones, we now program trip points whereas we previously didn't.
>>
>> The DT descriptioni (tegra210.dtsi) says one thing and the implementation says
>> something else.
>>
>> If we refer to the PLL description, there is one 'hot' trip point and
>> one 'critical' trip point. No polling delay at all, so we need the
>> interrupts.
>>
>> Logically, we should set the 'hot' trip point first, when the trip
>> point is crossed, we setup the next trip point, which is the critical.
>>
>> With these two trip points, the first one will send a notification to
>> the userspace and the second one will force a shutdown of the
>> system. For both, no cooling device is expected.
> 
> I think the intention here is to use the soctherm's built-in throttling
> mechanism as a last resort measure to try and cool the system down. I
> suppose that could count as "passive" cooling, so specifying it as the
> cooling device for the "passive" trip point may be more appropriate.
> 
> The throttling that happens here is quite severe, so we don't want it to
> happen too early. I would expect that our "passive" trip point shouldn't
> be a lot less than the "hot" temperature. I suspect that's the reason
> why the "hot" trip point was reused for this.
> 
> I'm also beginning to think that we should just not expose the soctherm
> throttling as a cooling device and instead keep it internal to the
> soctherm driver entirely.
> 
>> Well, actually I don't get the logic of the soctherm driver. It should
>> just rely on the thermal framework to set the trip point regardless
>> the cooling devices.
> 
> Again, "throttrip" doesn't map well to the concept of trip points
> because its not a mechanism to notify when a certain temperature is
> reached. It's an additional mechanism to automatically start throttling
> once a given temperature threshold is crossed. So it's basically an
> auto-cooling-device. If we program it only in response to a trip point
> notification, there aren't any benefits to this throttle mechanism. So
> again, I think we're probably better off just removing the cooling
> device implementation for it and always program it with the "hot" or
> "passive" trip point temperatures.
> 
>> The device tree also is strange. For example, the dram sets
>> cooling-device = <&emc 0 0>; an inoperative action for a 'nominal'
>> trip point ... If the goal is to stop the mitigation, that is already
>> done by the governor when the trip point is crossed the way down. The
>> second trip point is an 'active' cooling device but it refers to a emc
>> which is, at the first glance, a passive cooling device.
> 
> I think this is because for the mem-thermal zone, "passive" is
> considered to be less "severe" than "active". My understanding is that
> the severity goes "active", "passive", "hot", "critical". "Active" trip
> points are those where we want to use active cooling devices (such as a
> fan, for example) to try and cool the device. The "passive" trip points
> should only be reached when active cooling devices aren't up to the job
> and passive mechanisms need to be deployed. Passive in this case meaning
> the hardware itself has to be throttled.
> 
> If you look at the temperatures defined for passive vs. active for the
> "mem" thermal zone, then clearly they are reversed. <&emc 0 0> should be
> used for active trip points, and <&emc 1 1> means throttling of the EMC
> frequency, i.e. for passive trip points.
> 
>> The gpu description only describes hot and critical trip points. The
>> cooling device maps to the 'hot' trip point ! The governor is not used
>> in this case, so the cooling device is inoperative. Same for the cpu
>> thermal zone.
>>
>> IOW, the driver is not correctly implemented and the device tree is
>> wrong. Thermal is not working correctly on these board AFAICT.
> 
> I'll try to rework this. As I mentioned above I think we can just remove
> that throttle_heavy cooling device and instead hard-code that in the
> driver to a given temperature. Given that this is probably all defunct
> anyway, the best would probably be to extend the soctherm's
> throttle-cfgs node with a temperature field so we can avoid the reliance
> on trip points (which would allow us to get rid of the calls to the
> get_thermal_instance() helper).
> 
> On the DT side, I think most of the cooling maps can be cleaned up. We
> can remove the entries for "critical" and "hot" trip points if the
> driver unconditionally programs the automated throttling. For EMC we
> want to reverse the "passive" and "active" trip points and possibly drop
> the dram-passive cooling map as well, since you mentioned the core would
> take care of disabling the cooling device automatically.
> 
> Thierry

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

