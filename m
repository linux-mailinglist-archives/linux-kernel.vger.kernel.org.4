Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F86F6E9A93
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjDTRVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjDTRU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:20:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD59A469C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:20:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a9253d4551so11984855ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682011243; x=1684603243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmsBZPipPsCFTIjFncw4FGgKuPbELkOPIxjDOZ4baEM=;
        b=epjxRyBs3ZM8UiYLqktY66R5TM4hmVMgguePqA04wp85tIsFBGcc/1HvKszDPKw2zz
         oGupJbQHMKXS0qSw7nCm1bEZNm/t5UFA2DIz9dNWAjGYaR42MLbD3wNqeAX8YOqbt/s9
         TOzrmipI5UzVV86n9Q3H7iS2t47ZPuutlwZJyL8+i1P581YWQrDyOjJbWnywcXk17gzU
         mQlU38+Ntv1QR6Z9/9I1LQKDVh142oEks485YTf1zCpgQQwL5KVhITLUTAu8JGtgGI36
         83phI9oKXnF2S/auzJ6+9CIbMqzUL+ykwAC7lJUs0rJBxd/qtDc+eOYHjAKBWY6AOj27
         fSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011243; x=1684603243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmsBZPipPsCFTIjFncw4FGgKuPbELkOPIxjDOZ4baEM=;
        b=beNYzaiY+fcTRMr2HiKfddkzy9h8ZNd8ZzbkkrrpaDDYVGKoH8Iyru5XBsPIdNgxR6
         hic+BRDetP2u4KrlZ3Yjd9/H7Rb46ySSQe9jis0p6UWdR+PAa2nEKSgWPHDQBn+B0+Jw
         Ota8sXl608+1l8nlrAGsjcvdy2FZrLukqaeQOC/4KNdHAMK7OlP2y13IQuEdaq/KvIW9
         J5py+jVDeE5v+HlThVOx/FWDqQ0AL5qFvDQ2PeeeIBrR2IZ6qdz1gv6ciVOMlsJJfIOl
         j0gw0aNAz5rgdvVZHP7p8rnxJeD4or4OKHhMyXHXspPQ1HR9bRXpvjf1xC+pUZ/8FZ9J
         z1hQ==
X-Gm-Message-State: AAQBX9e3gV8pd3t6DQqmh4+8Tm+T4NLBEcKuU9kQOK0BJhbG5KPFnPqu
        FsEeFdQgKdyLu/TzH86akkp8/IEcWj6u/OsY+Iv/QQ==
X-Google-Smtp-Source: AKy350bpxHhIDK1NyKOqKcg3Ionztg8q401gE4d6TA43lhRUyRnfu1S8EmtYa0Gvx7ZrjrT9TlD6qg==
X-Received: by 2002:a17:902:a989:b0:1a6:5575:9059 with SMTP id bh9-20020a170902a98900b001a655759059mr1984838plb.62.1682011243276;
        Thu, 20 Apr 2023 10:20:43 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id 3-20020a170902c10300b001a194df5a58sm1401831pli.167.2023.04.20.10.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 10:20:42 -0700 (PDT)
Message-ID: <40b72025-16a8-1af5-d69f-659d37cdeab9@9elements.com>
Date:   Thu, 20 Apr 2023 22:50:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5] leds: max597x: Add support for max597x
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20230417094035.998965-1-Naresh.Solanki@9elements.com>
 <20230420115035.GE970483@google.com>
 <079eca63-54f5-7a4b-3b1c-e2515ceae9cc@9elements.com>
 <20230420135428.GD996918@google.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20230420135428.GD996918@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 20-04-2023 07:24 pm, Lee Jones wrote:
> On Thu, 20 Apr 2023, Naresh Solanki wrote:
> 
>> Hi Lee,
>>
>> On 20-04-2023 05:20 pm, Lee Jones wrote:
>>> On Mon, 17 Apr 2023, Naresh Solanki wrote:
>>>
>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>
>>>> max597x is hot swap controller with indicator LED support.
>>>> This driver uses DT property to configure led during boot time &
>>>> also provide the LED control in sysfs.
>>>>
>>>> DTS example:
>>>>       i2c {
>>>>           #address-cells = <1>;
>>>>           #size-cells = <0>;
>>>>           regulator@3a {
>>>>               compatible = "maxim,max5978";
>>>>               reg = <0x3a>;
>>>>               vss1-supply = <&p3v3>;
>>>>
>>>>               regulators {
>>>>                   sw0_ref_0: sw0 {
>>>>                       shunt-resistor-micro-ohms = <12000>;
>>>>                   };
>>>>               };
>>>>
>>>>               leds {
>>>>                   #address-cells = <1>;
>>>>                   #size-cells = <0>;
>>>>                   led@0 {
>>>>                       reg = <0>;
>>>>                       label = "ssd0:green";
>>>>                       default-state = "on";
>>>>                   };
>>>>                   led@1 {
>>>>                       reg = <1>;
>>>>                       label = "ssd1:green";
>>>>                       default-state = "on";
>>>>                   };
>>>>               };
>>>>           };
>>>>       };
>>>
>>> Where is the DT binding document for this?
https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/tree/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml?h=for-mfd-next
> 
> 
> ? <---------------------------------------------------------------------------
> 
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> 
>>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>> ...
>>>> Changes in V5:
>>>> - Update commit message
>>>> - Fix comments
>>>> - Add necessary new line
>>>> Changes in V4:
>>>> - Remove unwanted preinitialise
>>>> - Remove unneeded line breaks
>>>> - Fix variable name to avoid confusion
>>>> - Update module description to mention LED driver.
>>>> Changes in V3:
>>>> - Remove of_node_put as its handled by for loop
>>>> - Print error if an LED fails to register.
>>>> - Update driver name in Kconfig description
>>>> - Remove unneeded variable assignment
>>>> - Use devm_led_classdev_register to reget led
>>>> Changes in V2:
>>>> - Fix regmap update
>>>> - Remove devm_kfree
>>>> - Remove default-state
>>>> - Add example dts in commit message
>>>> - Fix whitespace in Kconfig
>>>> - Fix comment
>>>> ---
>>>>    drivers/leds/Kconfig        |  11 ++++
>>>>    drivers/leds/Makefile       |   1 +
>>>>    drivers/leds/leds-max597x.c | 115 ++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 127 insertions(+)
>>>>    create mode 100644 drivers/leds/leds-max597x.c
>>>>
>>>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>>>> index 9dbce09eabac..60004cb8c257 100644
>>>> --- a/drivers/leds/Kconfig
>>>> +++ b/drivers/leds/Kconfig
>>>> @@ -590,6 +590,17 @@ config LEDS_ADP5520
>>>>    	  To compile this driver as a module, choose M here: the module will
>>>>    	  be called leds-adp5520.
>>>> +config LEDS_MAX597X
>>>> +	tristate "LED Support for Maxim 597x"
>>>> +	depends on LEDS_CLASS
>>>> +	depends on MFD_MAX597X
>>>> +	help
>>>> +	  This option enables support for the Maxim MAX5970 & MAX5978 smart
>>>> +	  switch indication LEDs via the I2C bus.
>>>> +
>>>> +	  To compile this driver as a module, choose M here: the module will
>>>> +	  be called leds-max597x.
>>>> +
>>>>    config LEDS_MC13783
>>>>    	tristate "LED Support for MC13XXX PMIC"
>>>>    	depends on LEDS_CLASS
>>>> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
>>>> index d30395d11fd8..da1192e40268 100644
>>>> --- a/drivers/leds/Makefile
>>>> +++ b/drivers/leds/Makefile
>>>> @@ -53,6 +53,7 @@ obj-$(CONFIG_LEDS_LP8501)		+= leds-lp8501.o
>>>>    obj-$(CONFIG_LEDS_LP8788)		+= leds-lp8788.o
>>>>    obj-$(CONFIG_LEDS_LP8860)		+= leds-lp8860.o
>>>>    obj-$(CONFIG_LEDS_LT3593)		+= leds-lt3593.o
>>>> +obj-$(CONFIG_LEDS_MAX597X)		+= leds-max597x.o
>>>>    obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
>>>>    obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
>>>>    obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
>>>> diff --git a/drivers/leds/leds-max597x.c b/drivers/leds/leds-max597x.c
>>>> new file mode 100644
>>>> index 000000000000..edbd43018822
>>>> --- /dev/null
>>>> +++ b/drivers/leds/leds-max597x.c
>>>> @@ -0,0 +1,115 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Device driver for leds in MAX5970 and MAX5978 IC
>>>
>>> "MAX5970 and MAX5978 IC LED support"
>>>
>>>> + * Copyright (c) 2022 9elements GmbH
>>>> + *
>>>> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>> + */
>>>> +
>>>> +#include <linux/leds.h>
>>>> +#include <linux/mfd/max597x.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/regmap.h>
>>>> +
>>>> +#define ldev_to_maxled(c)       container_of(c, struct max597x_led, cdev)
>>>> +
>>>> +struct max597x_led {
>>>> +	struct regmap *regmap;
>>>> +	struct led_classdev cdev;
>>>> +	unsigned int index;
>>>> +};
>>>> +
>>>> +static int max597x_led_set_brightness(struct led_classdev *cdev,
>>>> +				      enum led_brightness brightness)
>>>> +{
>>>> +	struct max597x_led *ddata = ldev_to_maxled(cdev);
>>>> +	int ret, val;
>>>> +
>>>> +	if (!ddata->regmap)
>>>> +		return -ENODEV;
>>>> +
>>>> +	/* Set/clear corresponding bit for given led index */
>>>> +	val = !brightness ? BIT(ddata->index) : 0;
>>>> +
>>>> +	ret = regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH, BIT(ddata->index), val);
>>>> +	if (ret < 0)
>>>> +		dev_err(cdev->dev, "failed to set brightness %d", ret);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int max597x_setup_led(struct device *dev, struct regmap *regmap, struct device_node *nc,
>>>> +			     u32 reg)
>>>> +{
>>>> +	struct max597x_led *ddata;
>>>> +	int ret;
>>>> +
>>>> +	ddata = devm_kzalloc(dev, sizeof(struct max597x_led), GFP_KERNEL);
>>>> +	if (!ddata)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	if (of_property_read_string(nc, "label", &ddata->cdev.name))
>>>> +		ddata->cdev.name = nc->name;
>>>> +
>>>> +	ddata->cdev.max_brightness = 1;
>>>> +	ddata->cdev.brightness_set_blocking = max597x_led_set_brightness;
>>>> +	ddata->cdev.default_trigger = "none";
>>>> +	ddata->index = reg;
>>>> +	ddata->regmap = regmap;
>>>> +
>>>> +	ret = devm_led_classdev_register(dev, &ddata->cdev);
>>>> +	if (ret)
>>>> +		dev_err(dev, "Error initializing LED %s", ddata->cdev.name);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int max597x_led_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct device_node *np = dev_of_node(pdev->dev.parent);
>>>
>>> My previous question about having its own compatible string was ignored.
>> As previously stated, the MFD driver for max597x already has a compatible
>> string that serves its purpose, so I opted not to include a separate
>> compatible string for the leaf driver.
>> Prior to implementing this approach, I reviewed other implementations within
>> the MFD driver, such as the sy7636 which uses the similar approach in leaf
>> driver.
> 
> I'm not saying it's never been done.  However, most of the time
> leaf/child devices have their own compatible string and node.
True.
> 
>>>> +	struct regmap *regmap;
>>>> +	struct device_node *led_node;
>>>> +	struct device_node *child;
>>>> +	int ret = 0;
>>>> +
>>>> +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
>>>> +	if (!regmap)
>>>> +		return -EPROBE_DEFER;
> 
> Will other child devices have be using the parent's regmap too?
Yes
> 
>>>> +	led_node = of_get_child_by_name(np, "leds");
>>>> +	if (!led_node)
>>>> +		return -ENODEV;
> 
> It's odd for a device to be referring to itself as the "child".
As this is leaf driver, LED specific info is present in "leds" node in DT.
> 
>>>> +	for_each_available_child_of_node(led_node, child) {
>>>> +		u32 reg;
>>>> +
>>>> +		if (of_property_read_u32(child, "reg", &reg))
>>>> +			continue;
>>>> +
>>>> +		if (reg >= MAX597X_NUM_LEDS) {
>>>> +			dev_err(&pdev->dev, "invalid LED (%u >= %d)\n", reg,
>>>> +				MAX597X_NUM_LEDS);
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		ret = max597x_setup_led(&pdev->dev, regmap, child, reg);
>>>> +		if (ret < 0)
>>>> +			dev_err(&pdev->dev, "Failed to initialize LED %u\n", reg);
>>>
>>> You've ignored my previous review.
>> I would like to clarify that I did not intend to overlook your previous
>> review comment. Rather, I have taken it into consideration and evaluated it
>> in the context of the current approach, which is derived from the code in
>> other LED drivers.
>> To eliminate any potential confusion, it may be best to adopt a consistent
>> approach that all LED drivers should adhere to in similar circumstances.
> 
> I agree.  That's start with this one.
> 
> You should not error and continue.  If you encounter an error, please
> unwind what you have done before and return the error.
Ack.

> 
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static struct platform_driver max597x_led_driver = {
>>>> +	.driver = {
>>>> +		.name = "max597x-led",
>>>> +	},
>>>> +	.probe = max597x_led_probe,
>>>> +};
>>>> +
>>>> +module_platform_driver(max597x_led_driver);
>>>> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
>>>> +MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
>>>> +MODULE_LICENSE("GPL");
>>>>
>>>> base-commit: 9d8d0d98885abba451d7ffc4885236d14ead3c9a
>>>> -- 
>>>> 2.39.1
>>>>
>>>
>> Regards,
>> Naresh
> 
Regards,
Naresh
