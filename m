Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7596C7CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjCXKyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjCXKyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:54:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59FB24BF0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:54:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so1190332pjt.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1679655260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6vazQhj/k+LZJkE2tleN2fdTOp+KppkGE9uXoqJxxHA=;
        b=T4tkV33tFU2XdvgKtIai6iTiOIsEtBzvz+/RB220QWMZfT6pCNI5faChBGgDO/vejo
         SK5D+UniTTDCNqI+I1fAIXLktMC00hSVqCRyu5/z58dvxpE6emf94Egc/b+VatMUIxSO
         SS64GBECPcCynsRIgMg7tTiYDhb9m+TsE2jPZLtuc7MfQ4XbOfmP2U9jmuxtkAwpsY/8
         OMnCMcyrIb565WRd6s2V5PKRQFvGb5brLlMRJiIRKKE3OAcTVgPJfAqBu4msqdTrMjG7
         g2Rmcg07uaSaxBdj6mLn4qTJc9RLcK9fiHOKNI+60dPqTwCSAUur+3S9yWvy1z1eKLtn
         loWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679655260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vazQhj/k+LZJkE2tleN2fdTOp+KppkGE9uXoqJxxHA=;
        b=8G+3KUnoqrT6Ro9pq3GhD9x1iW5KaF2DRySmpVtiln0VDLvNif0FzaNon0G1kNGYeq
         0sl1/PnXE1DSafWtQTCgQKwfsKsqC5Rec1v2oMmlQnYh897Da6fZgB5V/YfxjHrsaEBl
         qlFDj7j4xBgy3s+JUfn/z58SBYEmTL4/Q0PXPbZ0JTdDJRu2rki5TTAYpE/vxd+OhaDw
         bFV1IHwD2eK8k8Q54MNqXiN2YeulmjUWzjTuQ2EZUkeG/hwDUYFDUYg/I9CiYmq1t3W0
         zOV9P4vTwggMpBwilVdr0K6qYXKxkOkneg3CFv00EV3IABPCUCc4JnlwAlILUhDN2Xw7
         Jnuw==
X-Gm-Message-State: AAQBX9epzHx2Osvj/h2wpmqRBSBsEhtEtFvfwCPRdPrcUZCkCeSnlM3d
        nZcECcmVhWM66ZpyWwTOJbb57g==
X-Google-Smtp-Source: AKy350bzfTmdGyXnehMrctKPXL5AGDqsn6LVyNZzOFTTqwIWqRdpyvI5tg/izvOWmZPI1pn7UPeYPA==
X-Received: by 2002:a17:90b:350f:b0:23d:4a40:e794 with SMTP id ls15-20020a17090b350f00b0023d4a40e794mr2176346pjb.10.1679655260096;
        Fri, 24 Mar 2023 03:54:20 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090ad0c300b00230b572e90csm2726606pjw.35.2023.03.24.03.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 03:54:19 -0700 (PDT)
Message-ID: <688423c6-ba98-002c-efe5-7b0997d6af73@9elements.com>
Date:   Fri, 24 Mar 2023 16:24:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] leds: max597x: Add support for max597x
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20230323194550.1914725-1-Naresh.Solanki@9elements.com>
 <20230323194550.1914725-2-Naresh.Solanki@9elements.com>
 <d6463018-ebdf-30b2-ce0e-f2b5198847f1@wanadoo.fr>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <d6463018-ebdf-30b2-ce0e-f2b5198847f1@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24-03-2023 01:48 am, Christophe JAILLET wrote:
> Le 23/03/2023 à 20:45, Naresh Solanki a écrit :
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> max597x is hot swap controller with indicator LED support.
>> This driver uses DT property to configure led during boot time &
>> also provide the LED control in sysfs.
>>
>> DTS example:
>>      i2c {
>>          #address-cells = <1>;
>>          #size-cells = <0>;
>>          regulator@3a {
>>              compatible = "maxim,max5978";
>>              reg = <0x3a>;
>>              vss1-supply = <&p3v3>;
>>
>>              regulators {
>>                  sw0_ref_0: sw0 {
>>                      shunt-resistor-micro-ohms = <12000>;
>>                  };
>>              };
>>
>>              leds {
>>                  #address-cells = <1>;
>>                  #size-cells = <0>;
>>                  led@0 {
>>                      reg = <0>;
>>                      label = "led0";
>>                      default-state = "on";
>>                  };
>>                  led@1 {
>>                      reg = <1>;
>>                      label = "led1";
>>                      default-state = "on";
>>                  };
>>              };
>>          };
>>      };
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ...
>> Changes in V2:
>> - Fix regmap update
>> - Remove devm_kfree
>> - Remove default-state
>> - Add example dts in commit message
>> - Fix whitespace in Kconfig
>> - Fix comment
>> ---
>>   drivers/leds/Kconfig        |  11 ++++
>>   drivers/leds/Makefile       |   1 +
>>   drivers/leds/leds-max597x.c | 112 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 124 insertions(+)
>>   create mode 100644 drivers/leds/leds-max597x.c
>>
>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>> index 9dbce09eabac..ec2b731ae545 100644
>> --- a/drivers/leds/Kconfig
>> +++ b/drivers/leds/Kconfig
>> @@ -590,6 +590,17 @@ config LEDS_ADP5520
>>         To compile this driver as a module, choose M here: the module 
>> will
>>         be called leds-adp5520.
>> +config LEDS_MAX597X
>> +    tristate "LED Support for Maxim 597x"
>> +    depends on LEDS_CLASS
>> +    depends on MFD_MAX597X
>> +    help
>> +      This option enables support for the Maxim 597x smart switch 
>> indication LEDs
>> +      via the I2C bus.
>> +
>> +      To compile this driver as a module, choose M here: the module will
>> +      be called max597x-led.
> 
> leds-max597x?
As per struct max597x_led_driver, driver name is max597x-led
> 
>> +
>>   config LEDS_MC13783
>>       tristate "LED Support for MC13XXX PMIC"
>>       depends on LEDS_CLASS
>> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
>> index d30395d11fd8..da1192e40268 100644
>> --- a/drivers/leds/Makefile
>> +++ b/drivers/leds/Makefile
>> @@ -53,6 +53,7 @@ obj-$(CONFIG_LEDS_LP8501)        += leds-lp8501.o
>>   obj-$(CONFIG_LEDS_LP8788)        += leds-lp8788.o
>>   obj-$(CONFIG_LEDS_LP8860)        += leds-lp8860.o
>>   obj-$(CONFIG_LEDS_LT3593)        += leds-lt3593.o
>> +obj-$(CONFIG_LEDS_MAX597X)        += leds-max597x.o
>>   obj-$(CONFIG_LEDS_MAX77650)        += leds-max77650.o
>>   obj-$(CONFIG_LEDS_MAX8997)        += leds-max8997.o
>>   obj-$(CONFIG_LEDS_MC13783)        += leds-mc13783.o
>> diff --git a/drivers/leds/leds-max597x.c b/drivers/leds/leds-max597x.c
>> new file mode 100644
>> index 000000000000..3e1747c8693e
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
>> +#define ldev_to_maxled(c)       container_of(c, struct max597x_led, led)
>> +
>> +struct max597x_led {
>> +    struct regmap *regmap;
>> +    struct led_classdev led;
>> +    unsigned int index;
>> +};
>> +
>> +static int max597x_led_set_brightness(struct led_classdev *cdev,
>> +                      enum led_brightness brightness)
>> +{
>> +    struct max597x_led *led = ldev_to_maxled(cdev);
>> +    int ret, val = 0;
>> +
>> +    if (!led || !led->regmap)
>> +        return -ENODEV;
>> +
>> +    val = !brightness ? BIT(led->index) : 0;
>> +    ret = regmap_update_bits(led->regmap, MAX5970_REG_LED_FLASH, 
>> BIT(led->index), val);
>> +    if (ret < 0)
>> +        dev_err(cdev->dev, "failed to set brightness %d\n", ret);
>> +    return ret;
>> +}
>> +
>> +static int max597x_setup_led(struct device *dev, struct regmap 
>> *regmap, struct device_node *nc,
>> +                 u32 reg)
>> +{
>> +    struct max597x_led *led;
>> +    int ret = 0;
> 
> Nit: useless "= 0"
Ack. Will be removing ' = 0' in V3
> 
>> +
>> +    led = devm_kzalloc(dev, sizeof(struct max597x_led),
>> +               GFP_KERNEL);
>> +    if (!led)
>> +        return -ENOMEM;
>> +
>> +    if (of_property_read_string(nc, "label", &led->led.name))
>> +        led->led.name = nc->name;
>> +
>> +    led->led.max_brightness = 1;
>> +    led->led.brightness_set_blocking = max597x_led_set_brightness;
>> +    led->led.default_trigger = "none";
>> +    led->index = reg;
>> +    led->regmap = regmap;
>> +    ret = led_classdev_register(dev, &led->led);
> 
> devm_led_classdev_register?
Ack. Will update in V3
> 
>> +    if (ret)
>> +        dev_err(dev, "Error in initializing led %s", led->led.name);
>> +
>> +    return ret;
>> +}
>> +
>> +static int max597x_led_probe(struct platform_device *pdev)
>> +{
>> +    struct device_node *np = dev_of_node(pdev->dev.parent);
>> +    struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +    struct device_node *led_node;
>> +    struct device_node *child;
>> +    int ret = 0;
>> +
>> +    if (!regmap)
>> +        return -EPROBE_DEFER;
>> +
>> +    led_node = of_get_child_by_name(np, "leds");
>> +    if (!led_node)
>> +        return -ENODEV;
>> +
>> +    for_each_available_child_of_node(led_node, child) {
>> +        u32 reg;
>> +
>> +        if (of_property_read_u32(child, "reg", &reg))
>> +            continue;
>> +
>> +        if (reg >= MAX597X_NUM_LEDS) {
>> +            dev_err(&pdev->dev, "invalid LED (%u >= %d)\n", reg,
>> +                MAX597X_NUM_LEDS);
>> +            continue;
>> +        }
>> +
>> +        ret = max597x_setup_led(&pdev->dev, regmap, child, reg);
>> +        if (ret < 0)
>> +            of_node_put(child);
> 
> This of_node_put() looks odd to me.
Not sure if I get this right but if led setup fails of_node_put should 
be called.
> "return ret;" or "break;" missing ?
> 
Didn't add a break so that it can continue initializing remaining led if 
any.
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static struct platform_driver max597x_led_driver = {
>> +    .driver = {
>> +        .name = "max597x-led",
>> +    },
>> +    .probe = max597x_led_probe,
>> +};
>> +
>> +module_platform_driver(max597x_led_driver);
>> +
>> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
>> +MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");
>> +MODULE_LICENSE("GPL");
> 

Will push V3 based on feedback.

Regards,
Naresh
