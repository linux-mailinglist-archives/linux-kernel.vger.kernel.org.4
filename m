Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24E85BBE85
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 16:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiIROyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 10:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiIROyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:54:50 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4771DF46;
        Sun, 18 Sep 2022 07:54:47 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y14so624502ljn.7;
        Sun, 18 Sep 2022 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=X2nL2KSAwhN1N7oGYh/hnKQufvm9ZPqZy+bXK3ObVHM=;
        b=ClzgvkyH0BqkP439F5KhDeznP1N4fFbQs5ryZmWESU/E3OEZUGC5of87P1GGKty4Vt
         XhGSBiBt4hG+G3ciuvISp6E7n51cangaWthcbRPQRTrA71GMYCRgP0KFu2BlgOnqNT9m
         9uxqUKuUIR60ED0CArmsHFzFy9/VUYSK2YkYT7ompESn44C0MmZK3sObVy6FT4wQ7Azu
         FEXEdTl9NetWwYSMMVHSb5kk2436U5RIbLUcCWMkZHDMMsaTBeUPr8I3wxmz0fKFeBth
         mtpzmA9pbNfT2Nwyiagv5IEJooVma8vOBJNNptKzvF/OBHFfwNiMjTxtzTEmVorWGiVt
         iqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=X2nL2KSAwhN1N7oGYh/hnKQufvm9ZPqZy+bXK3ObVHM=;
        b=kDFZ3GGlvkKFv14FyEGKLYTPio0xtmxMMVov2Sw7lFZbSrpRPLzDFUDkjKGGEH3Z03
         hg657WqB2xVF2Kq1mZVgINUUW1Nf6xofswIW4MyLS4Nz0NUwh2xqetvhWjY2I8+wOBgZ
         wMjSwW2rm+KeQzIvOF2QZdX7iKzW3YR1O46gPGI9SDJ3hTOvKtK25rEhy9Io4/K3q+A2
         a+2FJsh9CDYBVWxd0ctjYtyYId37b/YORjEppwWUNNzd6DP6ztxi1kP+iGK9qjR/FVOM
         tpoq/gbE4pSsJlKjxD70WZKIZlRNsout3WpUNfNTmEq0sdcgUidTB1b9o96Ah5eHx81E
         PLRg==
X-Gm-Message-State: ACrzQf0lf0IbJoG06Pfi+ZL34VScEYsr8N4f/kOPZ0DS43p3iYz1Iiia
        bz4wIPSyJs3inZXA+QEDQ3I=
X-Google-Smtp-Source: AMsMyM7uA3CWTWmt1O3cdC03BzBUTtWxj0ZcmkjKblWh3hHzDgsxnJmBmL1SwUeqm7S1uABQ7D/Vqw==
X-Received: by 2002:a2e:9c93:0:b0:26c:2fec:2f31 with SMTP id x19-20020a2e9c93000000b0026c2fec2f31mr4164254lji.369.1663512885712;
        Sun, 18 Sep 2022 07:54:45 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id a14-20020a05651c030e00b0026bf0d71b1esm4456077ljp.93.2022.09.18.07.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 07:54:44 -0700 (PDT)
Message-ID: <6f8e986d-6835-ae9a-bba7-074e822c25f5@gmail.com>
Date:   Sun, 18 Sep 2022 16:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND PATCH v3 4/4] leds: Add a multicolor LED driver to group
 monochromatic LEDs
Content-Language: en-US
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>, pavel@ucw.cz,
        robh+dt@kernel.org, sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, marijn.suijten@somainline.org,
        bjorn.andersson@linaro.org, andy.shevchenko@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sha@pengutronix.de
References: <20220917081339.3354075-1-jjhiblot@traphandler.com>
 <20220917081339.3354075-5-jjhiblot@traphandler.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20220917081339.3354075-5-jjhiblot@traphandler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

General question to this driver: since it seems that it is allowed to
have duplicate LEDs of the same color, then it will be impossible to
distinguish which of the two same colors in multi_index file will refer
to which physical LED. Are you aware of this shortcoming?

Besides that I have two remarks below.

On 9/17/22 10:13, Jean-Jacques Hiblot wrote:
> By allowing to group multiple monochrome LED into multicolor LEDs,
> all involved LEDs can be controlled in-sync. This enables using effects
> using triggers, etc.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>   drivers/leds/rgb/Kconfig                 |   6 +
>   drivers/leds/rgb/Makefile                |   1 +
>   drivers/leds/rgb/leds-group-multicolor.c | 153 +++++++++++++++++++++++
>   3 files changed, 160 insertions(+)
>   create mode 100644 drivers/leds/rgb/leds-group-multicolor.c
> 
> diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> index 204cf470beae..c2610c47a82d 100644
> --- a/drivers/leds/rgb/Kconfig
> +++ b/drivers/leds/rgb/Kconfig
> @@ -2,6 +2,12 @@
>   
>   if LEDS_CLASS_MULTICOLOR
>   
> +config LEDS_GRP_MULTICOLOR
> +	tristate "Multi-color LED grouping support"
> +	help
> +	  This option enables support for monochrome LEDs that are
> +	  grouped into multicolor LEDs.
> +
>   config LEDS_PWM_MULTICOLOR
>   	tristate "PWM driven multi-color LED Support"
>   	depends on PWM
> diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
> index 0675bc0f6e18..4de087ad79bc 100644
> --- a/drivers/leds/rgb/Makefile
> +++ b/drivers/leds/rgb/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> +obj-$(CONFIG_LEDS_GRP_MULTICOLOR)	+= leds-group-multicolor.o
>   obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
>   obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
> diff --git a/drivers/leds/rgb/leds-group-multicolor.c b/drivers/leds/rgb/leds-group-multicolor.c
> new file mode 100644
> index 000000000000..61f9e1954fc4
> --- /dev/null
> +++ b/drivers/leds/rgb/leds-group-multicolor.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * multi-color LED built with monochromatic LED devices
> + *
> + * Copyright 2022 Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/leds.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +struct led_mcg_priv {
> +	struct led_classdev_mc mc_cdev;
> +	struct led_classdev **monochromatics;
> +};
> +
> +static int led_mcg_set(struct led_classdev *cdev,
> +			  enum led_brightness brightness)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
> +	struct led_mcg_priv *priv =
> +		container_of(mc_cdev, struct led_mcg_priv, mc_cdev);
> +	int i;
> +
> +	led_mc_calc_color_components(mc_cdev, brightness);
> +
> +	for (i = 0; i < mc_cdev->num_colors; i++) {
> +		struct led_classdev *mono = priv->monochromatics[i];
> +		int actual_led_brightness;
> +
> +		/*
> +		 * Scale the intensity according the max brightness of the
> +		 * monochromatic LED
s/according the/according to the/

> +		 */
> +		actual_led_brightness = DIV_ROUND_CLOSEST(
> +			mono->max_brightness * mc_cdev->subled_info[i].brightness,
> +			mc_cdev->led_cdev.max_brightness);

How about dropping above usage of led_mc_calc_color_components()
helper in favour of doing all required calculations here?
It would be easier for the reader to grasp the idea then.

> +
> +		led_set_brightness(mono, actual_led_brightness);
> +	}
> +
> +	return 0;
> +}
> +
> +static int led_mcg_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct led_init_data init_data = {};
> +	struct led_classdev *cdev;
> +	struct mc_subled *subled;
> +	struct led_mcg_priv *priv;
> +	int i, count, ret;
> +	unsigned int max_brightness;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	count = 0;
> +	max_brightness = 0;
> +	for (;;) {
> +		struct led_classdev *led_cdev;
> +
> +		led_cdev = devm_of_led_get(dev, count);
> +		if (IS_ERR(led_cdev)) {
> +			/* Reached the end of the list ? */
> +			if (PTR_ERR(led_cdev) == -ENOENT)
> +				break;
> +			return dev_err_probe(dev, PTR_ERR(led_cdev),
> +					     "Unable to get led #%d", count);
> +		}
> +		count++;
> +
> +		priv->monochromatics = devm_krealloc(dev, priv->monochromatics,
> +					count * sizeof(*priv->monochromatics),
> +					GFP_KERNEL);
> +		if (!priv->monochromatics)
> +			return -ENOMEM;
> +
> +		priv->monochromatics[count - 1] = led_cdev;
> +
> +		max_brightness = max(max_brightness, led_cdev->max_brightness);
> +	}
> +
> +	subled = devm_kzalloc(dev, count * sizeof(*subled), GFP_KERNEL);
> +	if (!subled)
> +		return -ENOMEM;
> +	priv->mc_cdev.subled_info = subled;
> +
> +	for (i = 0; i < count; i++) {
> +		struct led_classdev *led_cdev = priv->monochromatics[i];
> +
> +		subled[i].color_index = led_cdev->color;
> +		/* configure the LED intensity to its maximum */
> +		subled[i].intensity = max_brightness;
> +	}
> +
> +	/* init the multicolor's LED class device */
> +	cdev = &priv->mc_cdev.led_cdev;
> +	cdev->flags = LED_CORE_SUSPENDRESUME;
> +	cdev->brightness_set_blocking = led_mcg_set;
> +	cdev->max_brightness = max_brightness;
> +	cdev->color = LED_COLOR_ID_MULTI;
> +	priv->mc_cdev.num_colors = count;
> +
> +	init_data.fwnode = dev_fwnode(dev);
> +	ret = devm_led_classdev_multicolor_register_ext(dev, &priv->mc_cdev,
> +							&init_data);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			"failed to register multicolor led for %s.\n",
> +			cdev->name);
> +
> +	ret = led_mcg_set(cdev, cdev->brightness);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to set led value for %s.",
> +				     cdev->name);
> +
> +	for (i = 0; i < count; i++) {
> +		struct led_classdev *led_cdev = priv->monochromatics[i];
> +
> +		/* Make the sysfs of the monochromatic LED read-only */
> +		led_cdev->flags |= LED_SYSFS_DISABLE;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_led_mcg_match[] = {
> +	{ .compatible = "leds-group-multicolor" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_led_mcg_match);
> +
> +static struct platform_driver led_mcg_driver = {
> +	.probe		= led_mcg_probe,
> +	.driver		= {
> +		.name	= "leds_group_multicolor",
> +		.of_match_table = of_led_mcg_match,
> +	}
> +};
> +module_platform_driver(led_mcg_driver);
> +
> +MODULE_AUTHOR("Jean-Jacques Hiblot <jjhiblot@traphandler.com>");
> +MODULE_DESCRIPTION("multi-color LED group driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:leds-group-multicolor");

-- 
Best regards,
Jacek Anaszewski
