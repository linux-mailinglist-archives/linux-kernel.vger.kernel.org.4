Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4AB68D6EB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjBGMiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjBGMiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:38:21 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4299838650
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:38:12 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso11336485wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 04:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bjX43tPjyQgYMIRsVphYkIRYTqv2MGWOxukjyWTB4L8=;
        b=wpvxuIA72wU5YS0siGtDxNL1lJp9lNrW8KPE3vGxzO3S0dHhFT92GO/6SaI3o9PGUa
         uvomvti6QjRle4rVnMOSDoLbov8500sL7woPD250Es9WrSIeMc3GFWYc8lxjSmUilnVS
         6//5UNqvwr1OGB+J2pOqiuMwHhH2WLJI2wFjNjJyfNX9aRQbMli2MjRMDEZUFuZJi6ZX
         G8aWfZVyWAWyoyZe7tODmJJImH4atT+UtyRfBZbDddYuhTJaspcQnSnT4xJ7EdewWtOJ
         bjYxLMf7VRjrhf5EfT7qg3feIwKJmK6uy7ZZw0+4vdN//pgrYugv/h2kT7IVhKtQP9ub
         y5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjX43tPjyQgYMIRsVphYkIRYTqv2MGWOxukjyWTB4L8=;
        b=LKnX1EUvO5wBukHAO9pE+RdHrSP/O1gXcO1VJCoBFAPqnWiE9oEm7h3TGjb5+u34uH
         pEYeNqaAcGZYst1+eggQFm+2C2wLQsExvaqTkPN9bNoBEDAUr2lQPbGpxBIGKhrGVR1v
         +Qy1Y1MXsxX4ewdPXj7w8iBmIE5vJarkvkr3RKrqgWl0ZQPLhPNlu+jReHk/O89+v1pa
         KVLpzOngHs0Z3bi5mUoIWKh4rkvzrkebAVOkCxobAbbKBJBJhUyCdF0rT0uSsbLpEeiH
         0VhDQnblbAt1+sCsVyGgSpM7SJYOr7NQVBdIFxw7fq6yz1O4krBEVxoKEkuEo1MDiliN
         8G1Q==
X-Gm-Message-State: AO0yUKWLBWB/6pi3zNruLY1KCB4M1vEqnPnWOjy0xrRSXUf5Zc9INKMk
        V+wLMynFKOfm+gG/OqZVQbud7g==
X-Google-Smtp-Source: AK7set91MeFt34cNHdf9bwLSKaNBRcpXcERwWPWBekKD/X2PJ4CC+RRoFHQ4aMVVG374EGFMb1jvPA==
X-Received: by 2002:a05:600c:1613:b0:3df:b5ae:5289 with SMTP id m19-20020a05600c161300b003dfb5ae5289mr2925734wmn.8.1675773490627;
        Tue, 07 Feb 2023 04:38:10 -0800 (PST)
Received: from [172.17.59.64] (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.googlemail.com with ESMTPSA id s15-20020a05600c45cf00b003e00c453447sm3512080wmo.48.2023.02.07.04.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 04:38:10 -0800 (PST)
Message-ID: <e6b4c6a9-0e35-e3b2-c8e8-01e5326bdba1@linaro.org>
Date:   Tue, 7 Feb 2023 13:38:08 +0100
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
 <Y9J4WAFyXyV/nqlG@orome> <f626967e-d6e6-817f-abeb-4aed89856c66@linaro.org>
 <Y+JBk5g65WkOkke7@orome>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y+JBk5g65WkOkke7@orome>
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

On 07/02/2023 13:18, Thierry Reding wrote:
> On Mon, Feb 06, 2023 at 03:50:22PM +0100, Daniel Lezcano wrote:
>>
>> Hi Thierry,
>>
>> did you have the time to look at the get_thermal_instance() removal ?
>>
>>
>> On 26/01/2023 13:55, Thierry Reding wrote:
>>
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
> 
> My diagnosis above wasn't entirely correct. We're not actually skipping
> trip point programming for PLL and MEM thermal zones in the current
> code. Instead, we skip throttle programming. As far as I can tell this
> is a mechanism built into ACTMON to allow it to automatically throttle
> when a zone reaches a certain temperature.
> 
> This is modelled as a cooling device, but internally it's actually done
> automatically, which is why we have this code that programs the throttle
> at driver probe time, rather than the on-demand programming that typical
> cooling device would do (such as a fan).
> 
> The reason why we have get_thermal_instance() here is to check if this
> built-in cooling device has been configured for the "hot" trip point. If
> not, we don't want the throttle programming to happen. This adds the
> added flexibility of explicitly disabling the automatic throttling by
> ACTMON and using another cooling device (or none at all) if that's what
> is needed.
> 
> Dropping just the call to get_thermal_instance() and relying on the
> find_throttle_cfg_by_name() function will always return a valid throttle
> configuration. This is slightly obfuscated because of this:
> 
> 	cdev = ts->throt_cfgs[i].cdev;
> 	if (get_thermal_instance(tz, cdev, trip_id))
> 		stc = find_throttle_cfg_by_name(ts, cdev->type);
> 
> As far as I can tell this will always return &ts->throt_cfgs[i], so the
> find_throttle_cfg_by_name() call is a bit redundant here. I'll look into
> fixing that.
> 
> In any case, the important thing is that it would always find a valid
> throttle configuration and therefore program the throttle, even if we
> may not want to.

Why not rely on the thermal framework mechanism to set the hwtrpis ?

thermal_zone_device_register() calls thermal_zone_device_update(). This 
one calls thermal_zone_set_trips() which programs the hardware trip point.

When we suspend/resume, the PM notifiers are calling 
thermal_zone_device_update() which in turn sets the hw trip points.

May be I'm missing something but isn't enough for the sensor ?


> Possibly we could work around that by removing this fiddly special case
> and instead add a new callback for the cooling devices that can be run
> when they are bound to a thermal zone. This would allow the throttle
> programming to be initiated from within the thermal core rather than
> "bolted on" like it is now and should allow us to achieve the same
> effect but without calling into get_thermal_instance().
> 
> I'll try and prototype this, but feel free to suggest anything better if
> you can think of something.
> 
> Thierry

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

