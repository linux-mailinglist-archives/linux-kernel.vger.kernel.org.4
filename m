Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD4A6BC41C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCPDCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCPDCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:02:44 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD46CC328;
        Wed, 15 Mar 2023 20:02:38 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id bp11so290616ilb.3;
        Wed, 15 Mar 2023 20:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678935758;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drZQHjCyOOafpC70c5NP8gNzTfwHKInPcyK0qutY9dc=;
        b=picqHkZbro0IEpcr5gQ/IqAF8ANsUFe+R+q/qCTcmo+ACBbq7Jd6KS1Y5RmmwH/rjp
         XVTeGz6klrGj4dqILUmZL77HGpYqJpYKwzSAvAnHx/HAgVPmWy+QA7tualptQNLctvpl
         A2ZWOvPrJCaK4IbnVs2nFlhKTm03qsBkaolxBBMfULNNbqVWpd9m8WZxXEEFwTn1IiXO
         ZUk+NTKg8BIaCYr41+PrsnQOKLb9zzDm/3/r/Q96S0WVlJd8RRampdagtQf3VSDgGPof
         uBUeUhq8pV5bOg99kPUY/0UpqiVkroUFfVmDsAz4PCDP7bO6IiLdGlNO/YKdyExkGzYm
         Pi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678935758;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drZQHjCyOOafpC70c5NP8gNzTfwHKInPcyK0qutY9dc=;
        b=zU7DsRWwXrGAnsl+X6YeTtcSe0MSwL7B3GfuVbmp1iXG9X3P7IZropKAkJf+1ozVMA
         gQjVNEuv6npGwFn0zn7Xu5+kxscS0SFFLg6ZVHN/0bg5VFWweJG9QJi3O+KhxgiriRc3
         m0iV1PYTB1Sw8RKwpDWO9ZClwetBmLl8OQSDgrQWHHOZA5rD0K+9+2vRYQjPF7Maes9B
         08iAAD+fMPi9ppB1E9mPV4w8h21PiGtZ4iD6j/8V0uKcOplWBsY+2K+dX38tE15tqWMb
         Y4q7nL2np6B0EB6d73WN4Vb0O07iuo9bcKiZJGb1Ey4L+zmxYUHnPsgjjsZo53PudTCl
         zpog==
X-Gm-Message-State: AO0yUKVVDhKROljXVhFZz96wagAwBOBOTRJLWWDbVi7n12D7ySuEvxEc
        /oYwHQsRw2w9LEKoci5BaU0=
X-Google-Smtp-Source: AK7set/R92HqBcKZenUQiJAyeUFRslxvFWtnjraQLr1VMtqswM8wNnPX1u+slku/h4WPU1h82ds51A==
X-Received: by 2002:a92:ab04:0:b0:323:aa7:befb with SMTP id v4-20020a92ab04000000b003230aa7befbmr5655735ilh.6.1678935758285;
        Wed, 15 Mar 2023 20:02:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s17-20020a92c5d1000000b00313f1b861b7sm2086606ilt.51.2023.03.15.20.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 20:02:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aaf0553c-48de-580f-70d5-aafeecb19e16@roeck-us.net>
Date:   Wed, 15 Mar 2023 20:02:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Phinex Hung <phinex@realtek.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230315121606.GA71707@threadripper>
 <8dbed631-62b6-1802-8f4e-7141b1a91a56@roeck-us.net>
 <D23B9D06-0DEA-4E3B-A64C-C928CAF2FEF8@realtek.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
In-Reply-To: <D23B9D06-0DEA-4E3B-A64C-C928CAF2FEF8@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 19:21, Phinex Hung wrote:
> 
> On 3/15/23 11:36, Guenter Roeck" <groeck7@gmail.com <mailto:groeck7@gmail.com> wrote:
> ﻿
>> This is conceptually wrong. It returns the maximum temperature from all drives,
>> not the temperature from a single drive.
> 
>> This is not much different from collecting all temperatures from all sensors
>> in the system and declaring the maximum of those as single thermal zone.
> 
>> If anything, each drive would have to reflect a thermal zone. The big question
>> is how to determine the associated devicetree property.
> 
> My basic idea is to use a single thermal zone for multiple disks.
> 
> In most of the systems, there might be only a single fan that used for cooling.
> 
> If each disk has its own thermal zone, we need to add almost the same dts entries for each thermal zone,
> 
> and do almost the same cooling operations.
> 
> That is why I am trying to using a single thermal zone for multiple disks.
> 
> In any case, if temperature of any disk goes high, cooling should take effect.
> 

Sure. But your argument is inappropriate: You could as well argue that
this system with a single fan should bundle all its thermal sensors into
a single thermal zone, and that it should do so in the driver(s)
providing the thermal zone sensors to the thermal subsystem. This does
not take into account that there might be systems with dozens (or hundreds,
for that matter) of drives, in a system with multiple disk trays and fans
for each of those.

I don't know if and how the thermal subsystem deals with the situation
of having N thermal zone sensors and M << N cooling devices. This is
a general problem, not limited to disk drives. Just as we won't bundle
multiple thermal sensors on a multi-channel thermal sensor chip into a
single thermal zone, we won't bundle multiple disk drives into a single
thermal zone.

>> Also, essentially your patch claims that arch/arm/boot/dts/kirkwood-nsa310s.dts
>> doesn't work and no one ever noticed. I would like to see that confirmed.
> 
> To be honest, my first attempt to get your drivetemp.c works in our SoC was referring to a similar patch,
> 
> https://lore.kernel.org/linux-arm-kernel/CAJN1KkzR7NR8TguS7uDs6peDOpkFn0duVBqvKKzm3xnMs9iJ7A@mail.gmail.com/T/
> 
> By adding the similar entries in our dts but failed.
> 
> Two hwmon devices actually populated, a thermal zone described by my dts also was created.
> 
> But there is no link between the thermal zone described in dts and hwmons from drivetemp driver.
> 
> So that I traced the source and finding that the thermal zone registration failed due to the lack of a device node of a platform device.
> 
> That is why I am trying to use a platform device for registration again.
> 
> The original call to hwmon_device_register_with_info should call hwmon_thermal_register_sensors,
> 
> But int the last call to thermal_zone_of_sensor_register, dev->of_node would be checked.
> 
> This would cause the sensor registration to fail while hwmon still worked.
> 
> hwmon_device_register_with_info => __hwmon_device_register => hwmon_thermal_register_sensors =>
> 
> hwmon_thermal_add_sensor => devm_thermal_zone_of_sensor_register => thermal_zone_of_sensor_register =>
> 
> struct thermal_zone_device *
> thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
>                                  const struct thermal_zone_of_device_ops *ops)
> {
>          struct device_node *np, *child, *sensor_np;
>          struct thermal_zone_device *tzd = ERR_PTR(-ENODEV);
> 
>          np = of_find_node_by_name(NULL, "thermal-zones");
>          if (!np)
>                  return ERR_PTR(-ENODEV);
> 
>          if (!dev || !dev->of_node) {
>                  of_node_put(np);
>                  return ERR_PTR(-ENODEV);
>          }
> 
> I am also curious why Kirkwood SoC works without specific patch.
> 
> In any case, if device tree binding is used, how could we associate drivetemp sensors with a specific thermal zone
> 
In theory it should work just like described in the kirkwood devicetree
files. If that doesn't work, the question is how to find the sata port
nodes from the drivetemp driver. I don't have a system with such nodes,
so I have no means to find or know the answer.

I also don't know how to attach more than one thermal sensor to a
single thermal zone, or if that is even possible. If it isn't, it
is a limitation of the thermal subsystem, and trying to hack around
it in a driver providing thermal sensors would be inappropriate.

Guenter

