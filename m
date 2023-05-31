Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5AF7187AA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjEaQm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEaQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:42:54 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041FA12C;
        Wed, 31 May 2023 09:42:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d44b198baso926101b3a.0;
        Wed, 31 May 2023 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685551372; x=1688143372;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hp1iyYuSXGdZgXFgvFkqzrcL5409CMPQscypykwCUa0=;
        b=qtpBDa4wfXFgH6cnSME8/dDLkC3F5WPDX7HhJ3E/ShmbLSFQJFmHm1Kak1DX3gwApi
         AwELC0HkXlPQ59iLnDaV/e3JOjSCSdZyHrfAlHIHTdBaXhcgpASivcSzzL6uguzQvxXL
         PSIwy3V7TMIQYlEQuZ9N9Fqrgm0vsX4RgVJ9QVlZ7wcGG9levJ1vJjAKaJbwsGiuFMRF
         f+BoLkd2ng6ihAU+0Ig1w0LSXO2dhsLpoJbmLUuhaFymiReo9EdggLSZX6ECpWfj0GNp
         jDyYklYxuYe6Hj0u+GQqlIhpgqYiFDdPLz1XFeR/LmiH9kfD+VJe7l1n095KNLlrrfUs
         1VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685551372; x=1688143372;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hp1iyYuSXGdZgXFgvFkqzrcL5409CMPQscypykwCUa0=;
        b=JhiL+hSIycd44NxobC2RBgCZH7+G/HrkIfsHUHxanwZSltQwM8Q0CwnGAuuvZr5SeG
         yQsc4w+mQFayy/zZrGkKK0FPpezQtIJK4c7c1k7W5y/XD1e7jcszctGowqF49jKaVGmM
         4+IqTDaapkbIBnkJPgF6425RTn96RhU/9puPo/dX9CL80HjZ1bbXQUNG9teonL7kIMrA
         4PoTfx3/moLnhSGihuPxpVeOpofMBYqgMU2xgyPMITW2m8Wikj82xzCb74fRq5QE8uQF
         kMqgb+ufpM4bpR1V8slU2Dk7yYBG4tvsHS4+4t3CL+locuUdtGxDNfW1lfTv5voEa5ua
         dUcw==
X-Gm-Message-State: AC+VfDy4L7r7BwhcgKEKG5AofxdOjuScX0DgMuVrs3xsEu1BV9KPQLZe
        A3oA1kVE6liHBCNEvGHIzOU=
X-Google-Smtp-Source: ACHHUZ42qUfIN6ffalR9gqA9UAUPucFU/LVgXATHaxj44L16PTCJII+lWPKCm+NCxM1ASwC5MshzTw==
X-Received: by 2002:a05:6a00:1509:b0:5a8:9858:750a with SMTP id q9-20020a056a00150900b005a89858750amr6846557pfu.13.1685551372220;
        Wed, 31 May 2023 09:42:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l6-20020a654486000000b0050927cb606asm1388351pgq.13.2023.05.31.09.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 09:42:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <07b2a2f7-5ddc-0f10-6b1f-184dc21fa580@roeck-us.net>
Date:   Wed, 31 May 2023 09:42:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20230531151918.105223-1-nick.hawkins@hpe.com>
 <20230531151918.105223-5-nick.hawkins@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
In-Reply-To: <20230531151918.105223-5-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 08:19, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The fan driver now receives fan data from GPIO via a shared variable.

No, it is not necessary. The driver can and should get the GPIO data using
the gpio API.

> This is a necessity as the Host and the driver need access to the same
> information. Part of the changes includes removing a system power check
> as the GPIO driver needs it to report power state to host.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> 
> v2:
>   *Removed use of shared functions to GPIO in favor of a shared variable
>   *Added build dependency on GXP GPIO driver.
> ---
>   drivers/hwmon/Kconfig        |  2 +-
>   drivers/hwmon/gxp-fan-ctrl.c | 61 +++++-------------------------------
>   drivers/hwmon/gxp-gpio.h     | 13 ++++++++
>   3 files changed, 21 insertions(+), 55 deletions(-)
>   create mode 100644 drivers/hwmon/gxp-gpio.h
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5b3b76477b0e..5c606bea31f9 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -716,7 +716,7 @@ config SENSORS_GPIO_FAN
>   
>   config SENSORS_GXP_FAN_CTRL
>   	tristate "HPE GXP fan controller"
> -	depends on ARCH_HPE_GXP || COMPILE_TEST
> +	depends on (ARCH_HPE_GXP  && GPIO_GXP_PL) || COMPILE_TEST

Compile test will fail badly unless those external variables
are declared.


>   	help
>   	  If you say yes here you get support for GXP fan control functionality.
>   
> diff --git a/drivers/hwmon/gxp-fan-ctrl.c b/drivers/hwmon/gxp-fan-ctrl.c
> index 0014b8b0fd41..8555231328d7 100644
> --- a/drivers/hwmon/gxp-fan-ctrl.c
> +++ b/drivers/hwmon/gxp-fan-ctrl.c
> @@ -1,5 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
> +/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.P. */
>   
>   #include <linux/bits.h>
>   #include <linux/err.h>
> @@ -8,51 +8,28 @@
>   #include <linux/module.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
> +#include "gxp-gpio.h"
>   
>   #define OFS_FAN_INST	0 /* Is 0 because plreg base will be set at INST */
>   #define OFS_FAN_FAIL	2 /* Is 2 bytes after base */
> -#define OFS_SEVSTAT	0 /* Is 0 because fn2 base will be set at SEVSTAT */
> -#define POWER_BIT	24
>   
>   struct gxp_fan_ctrl_drvdata {
> -	void __iomem	*base;
> -	void __iomem	*plreg;
> -	void __iomem	*fn2;
> +	void __iomem *base;
>   };
>   
>   static bool fan_installed(struct device *dev, int fan)
>   {
> -	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> -	u8 val;
> -
> -	val = readb(drvdata->plreg + OFS_FAN_INST);
> -
> -	return !!(val & BIT(fan));
> +	return !!(fan_presence & BIT(fan));
>   }
>   
>   static long fan_failed(struct device *dev, int fan)
>   {
> -	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> -	u8 val;
> -
> -	val = readb(drvdata->plreg + OFS_FAN_FAIL);
> -
> -	return !!(val & BIT(fan));
> +	return !!(fan_fail & BIT(fan));
>   }
>   
>   static long fan_enabled(struct device *dev, int fan)
>   {
> -	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> -	u32 val;
> -
> -	/*
> -	 * Check the power status as if the platform is off the value
> -	 * reported for the PWM will be incorrect. Report fan as
> -	 * disabled.
> -	 */
> -	val = readl(drvdata->fn2 + OFS_SEVSTAT);
> -
> -	return !!((val & BIT(POWER_BIT)) && fan_installed(dev, fan));
> +	return !!(fan_installed(dev, fan));

Unnecessary () around function call.

>   }
>   
>   static int gxp_pwm_write(struct device *dev, u32 attr, int channel, long val)
> @@ -98,20 +75,8 @@ static int gxp_fan_read(struct device *dev, u32 attr, int channel, long *val)
>   static int gxp_pwm_read(struct device *dev, u32 attr, int channel, long *val)
>   {
>   	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> -	u32 reg;
>   
> -	/*
> -	 * Check the power status of the platform. If the platform is off
> -	 * the value reported for the PWM will be incorrect. In this case
> -	 * report a PWM of zero.
> -	 */
> -
> -	reg = readl(drvdata->fn2 + OFS_SEVSTAT);
> -
> -	if (reg & BIT(POWER_BIT))
> -		*val = fan_installed(dev, channel) ? readb(drvdata->base + channel) : 0;
> -	else
> -		*val = 0;
> +	*val = fan_installed(dev, channel) ? readb(drvdata->base + channel) : 0;
>   
>   	return 0;
>   }
> @@ -212,18 +177,6 @@ static int gxp_fan_ctrl_probe(struct platform_device *pdev)
>   		return dev_err_probe(dev, PTR_ERR(drvdata->base),
>   				     "failed to map base\n");
>   
> -	drvdata->plreg = devm_platform_ioremap_resource_byname(pdev,
> -							       "pl");
> -	if (IS_ERR(drvdata->plreg))
> -		return dev_err_probe(dev, PTR_ERR(drvdata->plreg),
> -				     "failed to map plreg\n");
> -
> -	drvdata->fn2 = devm_platform_ioremap_resource_byname(pdev,
> -							     "fn2");
> -	if (IS_ERR(drvdata->fn2))
> -		return dev_err_probe(dev, PTR_ERR(drvdata->fn2),
> -				     "failed to map fn2\n");
> -
>   	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
>   							 "hpe_gxp_fan_ctrl",
>   							 drvdata,
> diff --git a/drivers/hwmon/gxp-gpio.h b/drivers/hwmon/gxp-gpio.h
> new file mode 100644
> index 000000000000..88abe60bbe83
> --- /dev/null
> +++ b/drivers/hwmon/gxp-gpio.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.P. */
> +
> +#ifndef __GPIO_GXP_H__
> +#define __GPIO_GXP_H__
> +
> +#include <linux/err.h>
> +
> +/* Data provided by GPIO */
> +extern u8 fan_presence;
> +extern u8 fan_fail;
> +

This is not acceptable. It is way too generic for a global variable, and it
does not use the gpio API. Besides, the variables would have to be declared
in an include file associated with the code introducing them.

If you want to use gpio pins in the hwmon driver, use the gpio API
([devm_]gpiod_get() and associated functions). There are lots of examples
in the kernel showing how to do that.

Guenter

> +#endif /* __GPIO_GXP_H__ */

