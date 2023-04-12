Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B86DEFFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjDLJAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDLJAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:00:34 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77698A5D0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:00:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g3so12037780pja.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1681290006; x=1683882006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e9P9xEM7RdSRxDMBcqewO4fxgr78P61pTnErrKEjm/w=;
        b=PloNgPj+ZHBVnRStPb8cJR68BkFlr5B2WyJ5xQ/fOwMYYkrjxvcCxGqqBwkyXzbRbj
         +ansckk86HkrmiYWxlYxH6bGsNF8sOvGRRZtARTrV896KPZHMPLZFgfDmxb6+biAvJx/
         MjyH3eSrnW0/lH8IXVT+MnE1M9EgGj65rB8Lsm+9811hoLZtSt5sjsPan4uEGAmrAuUF
         mtq4E2E8cVhagremEGXRpXm8Hi7fGHQNUzYR0hZURerkoEJL+E+4urSsyxiR8W3L3uaR
         Fxfq3MHR9B6IK53ErAiy8ngBbEmt92+SV3VYGoR3pw1DsMrp8z7Fz8nDmUXDZ6ENdh0B
         tvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681290006; x=1683882006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9P9xEM7RdSRxDMBcqewO4fxgr78P61pTnErrKEjm/w=;
        b=AqOPzuhra7mFw669YJLPlr0PZrM/+5MhDynepEdaCzP7//SOnFj2VmJUVuU/8LzFHn
         hMLiSxIJPDUlG3YwENJJok13IKpj1B9aljKB4URkWNdXahu1fdcGg/9KgQNrfsGqI1lC
         +sHBrUTq8s2ZroCnrngJedefOCy4T7GuB9ph12+vUgiBpnOng6tycrGJAk8JZqjhm3va
         FX44Ecbc16VUgoHv0HIs04nVxxNPUkkTy349PWue0Tv6BBLbsy0g/xPv9JPQGAceUv9k
         VQGRmgxBEIwJlguD1z1nWdNcxWKxRlEhgNM9itfXtI1lsig65jP1gsLNdP+ndK4DXCvD
         cNPA==
X-Gm-Message-State: AAQBX9fEES4jTYOa903q1C6kD6vnaIfNp9jnx135biy8xWOnADn/y1vU
        rsPxgUkJZAEN/wJ3ypEohGhuaA==
X-Google-Smtp-Source: AKy350ZvO4vIche02QHwTb2WLYlfvLUVb765c30U3XAh8qmy7ygjeHFQv1rcghvnI3KPQEKFDt3kmw==
X-Received: by 2002:a17:90b:1647:b0:23f:5c60:67b with SMTP id il7-20020a17090b164700b0023f5c60067bmr7575016pjb.5.1681290006342;
        Wed, 12 Apr 2023 02:00:06 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090a6a0400b00233afe09177sm990821pjj.8.2023.04.12.02.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 02:00:06 -0700 (PDT)
Message-ID: <375c6a74-c664-6ecc-cdcd-20cfa4568cd1@9elements.com>
Date:   Wed, 12 Apr 2023 14:30:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/2] leds: max597x: Add support for max597x
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20230328094416.3851801-1-Naresh.Solanki@9elements.com>
 <20230328094416.3851801-2-Naresh.Solanki@9elements.com>
 <20230405150706.GM8371@google.com>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20230405150706.GM8371@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 05-04-2023 08:37 pm, Lee Jones wrote:
> On Tue, 28 Mar 2023, Naresh Solanki wrote:
> 
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> max597x is hot swap controller with indicator LED support.
>> This driver uses DT property to configure led during boot time &
>> also provide the LED control in sysfs.
>>
>> DTS example:
>>      i2c {
>>          #address-cells = <1>;
>>          #size-cells = <0>;
>>          regulator@3a {
>>              compatible = "maxim,max5978";
>>              reg = <0x3a>;
>>              vss1-supply = <&p3v3>;
>>
>>              regulators {
>>                  sw0_ref_0: sw0 {
>>                      shunt-resistor-micro-ohms = <12000>;
>>                  };
>>              };
>>
>>              leds {
>>                  #address-cells = <1>;
>>                  #size-cells = <0>;
>>                  led@0 {
>>                      reg = <0>;
>>                      label = "led0";
>>                      default-state = "on";
>>                  };
>>                  led@1 {
>>                      reg = <1>;
>>                      label = "led1";
>>                      default-state = "on";
>>                  };
>>              };
>>          };
>>      };
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ...
>> Changes in V3:
>> - Remove of_node_put as its handled by for loop
>> - Print error if an LED fails to register.
>> - Update driver name in Kconfig description
>> - Remove unneeded variable assignment
>> - Use devm_led_classdev_register to reget led
>> Changes in V2:
>> - Fix regmap update
>> - Remove devm_kfree
>> - Remove default-state
>> - Add example dts in commit message
>> - Fix whitespace in Kconfig
>> - Fix comment
>> ---
>>   drivers/leds/Kconfig        |  11 ++++
>>   drivers/leds/Makefile       |   1 +
>>   drivers/leds/leds-max597x.c | 112 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 124 insertions(+)
>>   create mode 100644 drivers/leds/leds-max597x.c
>>
>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>> index 9dbce09eabac..60004cb8c257 100644
>> --- a/drivers/leds/Kconfig
>> +++ b/drivers/leds/Kconfig
>> @@ -590,6 +590,17 @@ config LEDS_ADP5520
>>   	  To compile this driver as a module, choose M here: the module will
>>   	  be called leds-adp5520.
>>
>> +config LEDS_MAX597X
>> +	tristate "LED Support for Maxim 597x"
>> +	depends on LEDS_CLASS
>> +	depends on MFD_MAX597X
>> +	help
>> +	  This option enables support for the Maxim MAX5970 & MAX5978 smart
>> +	  switch indication LEDs via the I2C bus.
>> +
>> +	  To compile this driver as a module, choose M here: the module will
>> +	  be called leds-max597x.
>> +
>>   config LEDS_MC13783
>>   	tristate "LED Support for MC13XXX PMIC"
>>   	depends on LEDS_CLASS
>> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
>> index d30395d11fd8..da1192e40268 100644
>> --- a/drivers/leds/Makefile
>> +++ b/drivers/leds/Makefile
>> @@ -53,6 +53,7 @@ obj-$(CONFIG_LEDS_LP8501)		+= leds-lp8501.o
>>   obj-$(CONFIG_LEDS_LP8788)		+= leds-lp8788.o
>>   obj-$(CONFIG_LEDS_LP8860)		+= leds-lp8860.o
>>   obj-$(CONFIG_LEDS_LT3593)		+= leds-lt3593.o
>> +obj-$(CONFIG_LEDS_MAX597X)		+= leds-max597x.o
>>   obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
>>   obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
>>   obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
>> diff --git a/drivers/leds/leds-max597x.c b/drivers/leds/leds-max597x.c
>> new file mode 100644
>> index 000000000000..83e4dfb617fb
>> --- /dev/null
>> +++ b/drivers/leds/leds-max597x.c
>> @@ -0,0 +1,112 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Device driver for leds in MAX5970 and MAX5978 IC
>> + *
>> + * Copyright (c) 2022 9elements GmbH
>> + *
>> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
>> + */
>> +
>> +#include <linux/leds.h>
>> +#include <linux/mfd/max597x.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#define ldev_to_maxled(c)       container_of(c, struct max597x_led, led)
>> +
>> +struct max597x_led {
>> +	struct regmap *regmap;
>> +	struct led_classdev led;
>> +	unsigned int index;
>> +};
>> +
>> +static int max597x_led_set_brightness(struct led_classdev *cdev,
>> +				      enum led_brightness brightness)
>> +{
>> +	struct max597x_led *led = ldev_to_maxled(cdev);
>> +	int ret, val = 0;
> 
> Why preinitialise?
Ack. Not needed so will remove.
> 
>> +	if (!led || !led->regmap)
>> +		return -ENODEV;
> 
> Can !led actually happen?
Ack. Will remove !led .
> 
>> +	val = !brightness ? BIT(led->index) : 0;
> 
> Perhaps a comment?
Sure. Will add "Set/Clear Led index bit"
> 
>> +	ret = regmap_update_bits(led->regmap, MAX5970_REG_LED_FLASH, BIT(led->index), val);
>> +	if (ret < 0)
>> +		dev_err(cdev->dev, "failed to set brightness %d\n", ret);
> 
> '\n'
Ack
> 
>> +	return ret;
>> +}
>> +
>> +static int max597x_setup_led(struct device *dev, struct regmap *regmap, struct device_node *nc,
>> +			     u32 reg)
>> +{
>> +	struct max597x_led *led;
>> +	int ret;
>> +
>> +	led = devm_kzalloc(dev, sizeof(struct max597x_led),
>> +			   GFP_KERNEL);
> 
> Consistently break at 100-chars please.
> 
> You have lines wayyyy longer than this elsewhere.
Ack. Will align with 100-chars. Thanks
> 
>> +	if (!led)
> 
> 'led' is confusing.  Either this or the member 'led' should be changed.
> 
> Perhaps ddata here and cdev for the member?
Sure.
> 
>> +		return -ENOMEM;
>> +
>> +	if (of_property_read_string(nc, "label", &led->led.name))
>> +		led->led.name = nc->name;
>> +
>> +	led->led.max_brightness = 1;
>> +	led->led.brightness_set_blocking = max597x_led_set_brightness;
>> +	led->led.default_trigger = "none";
>> +	led->index = reg;
>> +	led->regmap = regmap;
>> +	ret = devm_led_classdev_register(dev, &led->led);
>> +	if (ret)
>> +		dev_err(dev, "Error in initializing led %s", led->led.name);
> 
> Drop the "in" and s/led/LED/
Ack
> 
>> +
>> +	return ret;
>> +}
>> +
>> +static int max597x_led_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *np = dev_of_node(pdev->dev.parent);
> 
> Why not have your own compatible string?
This is leaf driver & MFD driver does has compatible string.
> 
>> +	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
> 
> These "big" API calls are usually done outside of the allocation block.
> 
> Please move it to just above the check for !regmap.
> 
>> +	struct device_node *led_node;
>> +	struct device_node *child;
>> +	int ret = 0;
> 
> Is it okay for an LED driver to not to register any LEDs?
Yes. Usage of indication LED on the max5970/5978 is optional.
> 
> Perhaps -ENODEV?
This driver is loaded only if MFD driver is included. remap is setup by 
MFD driver & hence defer probe till MFD driver is loaded.
> 
>> +	if (!regmap)
>> +		return -EPROBE_DEFER;
>> +
>> +	led_node = of_get_child_by_name(np, "leds");
>> +	if (!led_node)
>> +		return -ENODEV;
> 
> Ah, that's better.  So set ret to -ENODEV and use it here.
Yes.
> 
>> +	for_each_available_child_of_node(led_node, child) {
>> +		u32 reg;
>> +
>> +		if (of_property_read_u32(child, "reg", &reg))
>> +			continue;
>> +
>> +		if (reg >= MAX597X_NUM_LEDS) {
>> +			dev_err(&pdev->dev, "invalid LED (%u >= %d)\n", reg,
>> +				MAX597X_NUM_LEDS);
>> +			continue;
>> +		}
>> +
>> +		ret = max597x_setup_led(&pdev->dev, regmap, child, reg);
>> +		if (ret < 0)
>> +			dev_err(&pdev->dev, "Failed to initialize LED %u\n", reg);
> 
> I think you (or I) are missing the point of the previous reviews.  It's
> not okay to error out and continue executing.  Either this is okay (you
> can warn and carry on) or it's not (return an error).  Your first
> submission suggested that this was an error.  In which case you do need
> to return.  I think Pavel was suggesting that you should unwind
> (de-register) before retuning, rather than leaving things in an odd
> half-registered state.  Not that you should blindly carry on as if the
> issue never occurred.
I did refer to other such implementations & some have used return on 
error & some just print on error & continue. I felt that continue 
executing with warning(on error) is better approach.

> 
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static struct platform_driver max597x_led_driver = {
>> +	.driver = {
>> +		.name = "max597x-led",
>> +	},
>> +	.probe = max597x_led_probe,
>> +};
>> +
> 
> Remove this line.
>> +module_platform_driver(max597x_led_driver);
>> +
>> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
>> +MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");
> 
> Odd.  I thought this was a LED driver?
This also has LED. will update the strign to:
MAX5970_hot-swap controller LED driver
> 
>> +MODULE_LICENSE("GPL");
>> --
>> 2.39.1
>>
> 
> --
> Lee Jones [李琼斯]
Regards,
Naresh
