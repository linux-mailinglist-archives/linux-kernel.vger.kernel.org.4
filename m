Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418A86920E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjBJOhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjBJOhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:37:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291DF6D63C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:37:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso6423216wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgDnnay/7/hZu69iuCwtmAHN8teouEyN6y/9rDAhOc4=;
        b=gV5GjV5Ji6seMM71UMvNBv9Tu67tp99sAn0VEx55h0YBtK+Xmky+fj4N3kTzAxWHWH
         OOzfSENv3dClm4WBzZ27PFVtWOfGspmhnn8EnWIllyI+ZrgN1rkBmVOAX9gBxefWOr5E
         3CHpZeHFLEOJFMh62qKWOJyVi9oC5a06yfMojug7eESwXAvpq9nKSbmyp+Y0MCtBj6LN
         Jhlm4ab+agFwm0Un+sUV11W3BEdQHEougEBQlix+kY7F0HV1J7yuueS0nisvv379xSCJ
         5SDXtcDI7Xpm2zCURgIuX646Zr4X8tCeVcHeKDQsROlK19Zlp2LtalTeJsiL9nedcRcK
         iI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgDnnay/7/hZu69iuCwtmAHN8teouEyN6y/9rDAhOc4=;
        b=6glWQXq8IAR+WVoDa1AjSIKOrZvU2BmY8+SQ/xBzkrjcfhupHIc8XH5kDdwL20dNLB
         sI4wlhMBsN97sKz6R874r0IBoXxCpvUWJ6g+l35K+AqOoGv+186B8/kIdELOr74RiRXX
         5bebgnRvP4w3m580drWjGwmVwmSlzJTtDTS55Y0o8slq60JK7puMbBDvjbQ2pZGF1I/q
         3QUQdyOkl/8Wg0oOaNpoIY5LDQ8DCk+pzbfNcikRk+EDmlFgDoUYgRhbpylpu97KWSG1
         RCG8cOSy2TndmSSVuhB150G8q12v/BZNPTnZm/9JUV4mqqycsglHLHp5ro5SGggXKb+F
         FPPg==
X-Gm-Message-State: AO0yUKU4pm49e/cfInTpIKkn7UgEIvNtKncGjbxRgqvnAAdU/gm6BHz0
        tZ2wdxv0g8MzcZhfE9btw8L+Fw==
X-Google-Smtp-Source: AK7set/KD2hbi+kZvfMCDyvqNEElWuMR7WnvCp8IBXEybr5gi7HRgPd+DpwizQ67bXcuLJXS84VhfA==
X-Received: by 2002:a05:600c:4a9a:b0:3dc:f24:f2de with SMTP id b26-20020a05600c4a9a00b003dc0f24f2demr13099897wmp.12.1676039821561;
        Fri, 10 Feb 2023 06:37:01 -0800 (PST)
Received: from [172.17.49.168] (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.googlemail.com with ESMTPSA id a1-20020adff7c1000000b002c54a2037d1sm1615338wrq.75.2023.02.10.06.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 06:37:00 -0800 (PST)
Message-ID: <365c469b-22f6-fb26-1872-5e9a5079af5d@linaro.org>
Date:   Fri, 10 Feb 2023 15:36:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
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
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Yes, and perhaps separate it from the sensor driver.

There is a similar hardware limiter for the qcom platform [1]. The 
description in the device tree is separated from the sensor and the 
binding has temperatures to begin the mitigation [2].

There is no trip point associated as those are related to the in-kernel 
mitigation.

If this mitigation is a heavy mitigation, above what the kernel is able 
to do with a passive cooling device. It would make sense to just have 
configured outside of the thermal zone.

So the configuration would be something like:

myperformance_limite {
	@ = <0x...>
	temperature_limit = 95000;
};

thermal_zone {

	cpu : {
		trips {
			alert {
			temperature = 90000;
			hysteresis = 2000;
			type = passive;
			};

			hot {
			temperature = 97000;
			type = hot;
			};

			critical {
			temperature = 100000;
			hysteresis = 2000;
			type = critical;
			};

			cooling-maps = <&cpu NO_LIMIT NO_LIMIT>;
		};
	}
};

The behavior will be a passive mitigation, if it fails the hardware 
limiter will take over, if that fails then hot sends a notification to 
the userspace (giving the opportunity to hotplug a cpu or kill a task or 
suspend), if that fails then shutdown.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/thermal/qcom/lmh.c?h=thermal/bleeding-edge

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/arch/arm64/boot/dts/qcom/sdm845.dtsi?h=thermal/bleeding-edge#n3922

[ ... ]

> On the DT side, I think most of the cooling maps can be cleaned up. We
> can remove the entries for "critical" and "hot" trip points if the
> driver unconditionally programs the automated throttling. 

You may want to keep the critical trip points at least. Even if the 
hardware limiter is certainly very effective, having the critical point 
is another fail safe allowing to gracefully shutdown the system before a 
wild hardware reset.

> For EMC we
> want to reverse the "passive" and "active" trip points and possibly drop
> the dram-passive cooling map as well, since you mentioned the core would
> take care of disabling the cooling device automatically.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

