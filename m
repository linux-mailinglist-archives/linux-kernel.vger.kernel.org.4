Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE52C6BC69D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCPHLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCPHLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:11:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BE8ACBB5;
        Thu, 16 Mar 2023 00:10:17 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id z5so615556ljc.8;
        Thu, 16 Mar 2023 00:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678950605;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWA/mj/f3eHS8QGRBYX7bjkJXRntxd/NN8cEK0DJXRw=;
        b=qJN7kP7/b8cDTotWyXdm2lp3jxcpv519yY/yuCuOCfA64T/zUjALxGDtDHHGH23ZLG
         jiw632iKNcRKRGu0IYeg5PBYaLc/fynmyDLAHmzdbCcYavkrhS96fdJQ4hM5NS1LocMn
         PKHqZFYO6ZZr56Gt22SOksTe/TqBmMpJY/dvLB5VXpkf9mNOBRJqae/Kx+Bp+Kooci7r
         Ddecy8CjY0RXtwj8E5Ig2lkFrXVXpOi9XYEhiIF5Hf6kVYEUrLHdBG0A51ehpPJC8T4D
         mIKbrETgy8ZbCYl9gzEf9gUPADeHf3gZ51zoGoqLJBDJQjLShyIoQ/BWMEJwU3pYXUZk
         VCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678950605;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWA/mj/f3eHS8QGRBYX7bjkJXRntxd/NN8cEK0DJXRw=;
        b=N5glW0mlxe/J2CN2ga/OCeLrf3kvG+bDVE0WiBHeacB3uqEBYqHp7X1gIWQdkT7Nd2
         rmdV+SUxlcr5JkQwr/PniKoE3bxpFiPWwFMIqQvETjRFB9aQm6kMXjFgRmjwb223xUxD
         fUKI+Y6W+OLgxmpl2KzPeBYSgUaJ6SwLvRhISJZsv1jMuoYWGw9eHYLWJ2c07cxsdCAF
         qpLVnPDxsow0VAfNGEEaU/3POKh1TKSwbXqxnE4PICRGh5a1eJWeSrZEKzcKt3Chy9uP
         6qGlAc/BuFEhbVviQkNnOjHOZbJDAKpfNbrcmb5cUDFqZLcy5GOirzxjJoM4repBI28B
         N76g==
X-Gm-Message-State: AO0yUKXgiessSu/WwZDnKHAakpeifMH3lRs2agkHnBTIb4LagUVr+CKL
        cJBdrfxQbaYDxGfHuylugHZnHb1VPGE=
X-Google-Smtp-Source: AK7set+PdO3ZA619yvNodhIF0VgC0x2BSazCc2i1PDcfTXtXKccQP8l9EkN3MOmNWnbQEXOGPJKEeg==
X-Received: by 2002:a2e:a989:0:b0:295:a391:7b48 with SMTP id x9-20020a2ea989000000b00295a3917b48mr2152641ljq.26.1678950605351;
        Thu, 16 Mar 2023 00:10:05 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id b25-20020a2e9899000000b00299aa6d1820sm63994ljj.84.2023.03.16.00.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:10:05 -0700 (PDT)
Message-ID: <de0848f7-7f33-b170-54b7-f0fbf4e5d7d6@gmail.com>
Date:   Thu, 16 Mar 2023 09:10:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230314225535.1321736-1-sre@kernel.org>
 <20230314225535.1321736-3-sre@kernel.org>
 <baffa307-173c-6ba1-0289-e7287049c0f5@gmail.com>
 <20230316004121.rwieru4aj7d6mwgb@mercury.elektranox.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCHv2 02/12] power: supply: core: auto-exposure of
 simple-battery data
In-Reply-To: <20230316004121.rwieru4aj7d6mwgb@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 02:41, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Mar 15, 2023 at 09:01:50AM +0200, Matti Vaittinen wrote:
>> On 3/15/23 00:55, Sebastian Reichel wrote:
>> [...]
>>>    #ifdef CONFIG_THERMAL
>>>    static int power_supply_read_temp(struct thermal_zone_device *tzd,
>>>    		int *temp)
>>> @@ -1255,6 +1387,11 @@ __power_supply_register(struct device *parent,
>>>    		goto check_supplies_failed;
>>>    	}
>>> +	/* psy->battery_info is optional */
> 
> I forgot to add a POWER_SUPPLY_TYPE_BATTERY limitation when removing
> the opt-in method. Will be added in the next revision.
> 
>>> +	rc = power_supply_get_battery_info(psy, &psy->battery_info);
>>> +	if (rc && rc != -ENODEV)
>>> +		goto check_supplies_failed;
>>> +
>>
>> This is what rubs me in a slightly wrong way - but again, you probably know
>> better than I what's the direction things are heading so please ignore me if
>> I am talking nonsense :)
>>
>> Anyways, I think the battery information may be relevant to the driver which
>> is registering the power-supply. It may be there is a fuel-gauge which needs
>> to know the capacity and OCV tables etc. Or some other thingy. And - I may
>> be wrong - but I have a feeling it might be something that should be known
>> prior registering the power-supply.
> 
> You can still do that, just like before.

This is out of scope of your series, but as far as I remember the 
"battery info getter" power_supply_get_battery_info() provided by the 
core required the struct power_supply - which, I believe, should not be 
used prior supply registration.

(I think I did drop this requirement and added a getter which allowed 
just passing the device (or fwnode) in a simple-gauge RFC series I sent 
couple of years ago - but as I said, this is out of the scope)

> It's a bit inefficient,
> since the battery data is allocated twice, but the driver probe
> routine is not a hot path.

This is true. OTOH, people are constantly struggling to push down the 
start-up times so maybe we should avoid feeling too comfortable with 
probes being slow. Still, I am not opposed to this series!

>> So, in my head it should be the driver which is getting the information
>> about the battery (whether it is in the DT node or coded in some tables and
>> fetched by battery type) - using helpers provided by core.
>>
>> I further think it should be the driver who can pass the battery information
>> to core at registration - core may 'fall-back' finding information itself if
>> driver did not provide it.
> 
> This implements the fallback route.
> 
>> So, I think the core should not unconditionally populate the battery-info
>> here but it should first check if the driver had it already filled.
> 
> Not until there is a user (i.e. a driver using that feature). FWIW
> it's quite easy to implement once it is needed. Just adding a field
> in power_supply_config and taking it over here is enough, no other
> code changes are required.

Fair enough. You are probably right in that things should not be 
complicated if there is no need.

> The alternative is adding some kind of probe/remove callback for the
> power_supply device itself to properly initialize the device. That
> would also be useful to have a sensible place for e.g. shutting of
> chargers when the device is removed. Anyways it's a bit out of scope
> for this patchset :)
> 
>> Well, as I said, I recognize I may not (do not) know all the dirty details
>> and I do trust you to evaluate if what I wrote here makes any sense :) All
>> in all, I think this auto-exposure is great.
>>
>> Please, bear with me if what I wrote above does not make sense to you and
>> just assume I don't see the big picture :)
> 
> Right now the following battery drivers use power_supply_get_battery_info():
> 
>   * cw2015_battery
>   * bq27xxx_battery
>   * axp20x_battery
>   * ug3105_battery
>   * ingenic-battery
>   * sc27xx_fuel_gauge
>   * (generic-adc-battery)
> 
> All of them call it after the power-supply device has been
> registered. Thus the way to go for them is removing the second call
> to power_supply_get_battery_info() and instead use the battery-info
> acquired by the core. I think that work deserves its own series.

I agree.

> For chargers the situation is different (they usually want the data
> before registration), but they should not expose the battery data
> anyways.

I probably should go back studying how the power-supply class works 
before continuing this discussion :)

So, is it so that when a single IC contains both the charger logic and 
battery monitoring - then the driver is expected to create two 
power_supply devices. One for the battery and the other for the charger? 
I assume both of these pover_supply devices will then find the same 
battery_info - which means that one of the devices (probably the 
charger) should not auto-expose properties(?)

Well, as I said I should go study things better before continuing - but 
as I have limited time for studying this now I'll just ask if there is a 
danger we auto-expose battery details from existing drivers via two 
devices? And as I did no study I will just accept what ever answer you 
give and trust you to know this better ^_^;

> Also ideally chargers get the information from the battery
> power-supply device, which might supply the data from fuel-gauge
> registers (or fallback to battery-info after this series).
> 
>>>    	spin_lock_init(&psy->changed_lock);
>>>    	rc = device_add(dev);
>>>    	if (rc)
>>> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
>>> index c228205e0953..5842dfe5dfb7 100644
>>> --- a/drivers/power/supply/power_supply_sysfs.c
>>> +++ b/drivers/power/supply/power_supply_sysfs.c
>>> @@ -380,6 +380,9 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
>>>    		}
>>>    	}
>>> +	if (power_supply_battery_info_has_prop(psy->battery_info, attrno))
>>> +		return mode;
>>> +
>>>    	return 0;
>>>    }
>>> @@ -461,6 +464,8 @@ static int add_prop_uevent(const struct device *dev, struct kobj_uevent_env *env
>>>    int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
>>>    {
>>>    	const struct power_supply *psy = dev_get_drvdata(dev);
>>> +	const enum power_supply_property *battery_props =
>>> +		power_supply_battery_info_properties;
>>>    	int ret = 0, j;
>>>    	char *prop_buf;
>>> @@ -488,6 +493,16 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
>>>    			goto out;
>>>    	}
>>> +	for (j = 0; j < power_supply_battery_info_properties_size; j++) {
>>> +		if (!power_supply_battery_info_has_prop(psy->battery_info,
>>> +				battery_props[j]))
>>> +			continue;
>>
>> Hmm. I just noticed that there can probably be same properties in the
>> psy->desc->properties and in the battery-info.
> 
> That's intended, so that battery drivers can implement their own
> behaviour for the properties.

Yes, I thought so. But this is why I asked if doubling the uevents below 
was a problem.

>> I didn't cascade deep into the code so I can't say if it is a
>> problem to add duplicates?
> 
> It does not break anything (we used to have this for the TYPE
> property in a driver), but confuses userspace. I will fix the
> duplication in uevents and send a new version.
> 
>> So, if this is safe, and if what I wrote above is not something
>> you want to consider:
>>
>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Due to the changes I will not take this over in v3. Just to make
> sure - is it correct, that you do not want your R-b tag for the
> following two patches?
> 
> [05/12] power: supply: generic-adc-battery: drop jitter delay support

I didn't feel technically capable of reviewing the above delay patch as 
I don't know what kind of delays are typically needed - or if they need 
to be configurable - or what is the purpose of this delay (some 
stabilization period after charging?)

So, it's not that your patch had something I didn't agree with - I was 
just not feeling I understand the consequences of the changes. Purely 
from coding perspective it looked good to me :)

> [08/12] power: supply: generic-adc-battery: use simple-battery API

This one did look good to me but as it was pretty trivial one I didn't 
think my review made much of a difference :) I can reply with my tag on 
that one though as I did review what there was to review.

> 
>> [...]
> 
> Thanks for your reviews,

Thanks to you! You are the one making things better here, I am just 
treating this as an opportunity to learn ;)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

