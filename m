Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E68C6D921F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjDFI5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjDFI5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:57:20 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C49459E0;
        Thu,  6 Apr 2023 01:57:18 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c9so39486468lfb.1;
        Thu, 06 Apr 2023 01:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680771436;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoK3kb7m7fTAFVkR0FS6x9DdwthE8Uj94ral71JPOqI=;
        b=kyW2J61noloIIbRJIusGs+T1IlQHOEcas4vUIJZ4fQVaLm50S5YnqYtU52ZIC9+y+F
         5CKf+u5pAGU2sAQXVHv1Za/V9/p56wVOsv0BxEjKYYrlzACYEiL3YypfA4ZpHQZJPVLX
         NrO9BbdwlCUJunEkxm2NHEqKvQJ3pkP0NJCLGoFGxzRKuX+Ec/K6WU5QySPYDngeEHKX
         grNoSNCJ6QiQhpFEGUP4Q9H6iWkeWvBQ8U93Qk+o7Zq3U637Y8OZDf6laqcoBDIQBgGK
         6Ibs8yenK8nU7e+lsKDwgJwYc0BED7osWFNfxqCwx5neaKkn05oXX8MT0u7fHDU1vZy1
         mycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680771436;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CoK3kb7m7fTAFVkR0FS6x9DdwthE8Uj94ral71JPOqI=;
        b=I4hVljl/K5VSytXasymOGck+FXwtwEil65famWUy3NSm/Bkd189o9K1hM1p81Hjo0M
         ACeB1osc23wGWTqHJ1R+7Gl3byxvvMLLS+z/9bGH2wxNDoqZQ6bRORY5fXs6cPd91d4A
         7KRl8OGyfIg9tUZomlN9ZlaVY/gDrVJLTUWTOIn+5yBAYSTS8F/9yQZXjbw3MLRFynt6
         SxQj4DoAxQjrjT3iyvVgxYaH015RfZD+YugLN57GdTuKiwcUj/TTOWyhVYb4Re0DCqH6
         /A9OQaFVbQ7vW21Adrm+SLT62Y3nqyeNgx5+hZ3rLqBjB/QmbeEbjhA4+SNGAnOqiar2
         7RAg==
X-Gm-Message-State: AAQBX9e/S2qIq6cO68F6MthUh6udywJB28n7/8Gz1qgCABOJURhylVud
        4diKEN8+6ABNmGr3xy7tmCqm1ZloCyw=
X-Google-Smtp-Source: AKy350bv5RELtybtuJlHUXuCedWUnQJpEKIC7x1IzvBn6SgP/EHKJLiWeGCue1yVdcfap4rC9BsXIA==
X-Received: by 2002:ac2:4ac2:0:b0:4eb:13ff:6ca7 with SMTP id m2-20020ac24ac2000000b004eb13ff6ca7mr2428922lfp.16.1680771436114;
        Thu, 06 Apr 2023 01:57:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id l28-20020ac24a9c000000b004e9c983a007sm174661lfp.289.2023.04.06.01.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 01:57:15 -0700 (PDT)
Message-ID: <7d8c558f-0d21-91ed-ecd0-cac079d366ee@gmail.com>
Date:   Thu, 6 Apr 2023 11:57:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     Andreas Kemnade <andreas@kemnade.info>, pavel@ucw.cz,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hns@goldelico.com
References: <20230406060825.103187-1-andreas@kemnade.info>
 <20230406060825.103187-3-andreas@kemnade.info>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel i2c
 LED driver
In-Reply-To: <20230406060825.103187-3-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Overall a nice and clean driver with a good explanation of shared 
brightness. Just some minor things.

On 4/6/23 09:08, Andreas Kemnade wrote:
> The device provides 6 channels which can be individually
> turned off and on but groups of two channels share a common brightness
> register.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/leds/Kconfig          |  11 +++
>   drivers/leds/Makefile         |   1 +
>   drivers/leds/leds-bd2606mvv.c | 145 ++++++++++++++++++++++++++++++++++
>   3 files changed, 157 insertions(+)
>   create mode 100644 drivers/leds/leds-bd2606mvv.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 9dbce09eabacf..cc4eadbb2542e 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -551,6 +551,17 @@ config LEDS_REGULATOR
>   	help
>   	  This option enables support for regulator driven LEDs.
>   
> +config LEDS_BD2606MVV
> +	tristate "LED driver for BD2606MVV"
> +	depends on LEDS_CLASS
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  This option enables support for BD2606MVV LED driver chips
> +	  accessed via the I2C bus. It supports setting brightness, with
> +	  the limitiation that there are groups of two channels sharing
> +	  a brightness setting, but not the on/off setting.
> +
>   config LEDS_BD2802
>   	tristate "LED driver for BD2802 RGB LED"
>   	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index d30395d11fd84..c07d1512c745a 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
>   obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
>   obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
>   obj-$(CONFIG_LEDS_BCM6358)		+= leds-bcm6358.o
> +obj-$(CONFIG_LEDS_BD2606MVV)		+= leds-bd2606mvv.o
>   obj-$(CONFIG_LEDS_BD2802)		+= leds-bd2802.o
>   obj-$(CONFIG_LEDS_BLINKM)		+= leds-blinkm.o
>   obj-$(CONFIG_LEDS_CLEVO_MAIL)		+= leds-clevo-mail.o
> diff --git a/drivers/leds/leds-bd2606mvv.c b/drivers/leds/leds-bd2606mvv.c
> new file mode 100644
> index 0000000000000..47ddd016bae3f
> --- /dev/null
> +++ b/drivers/leds/leds-bd2606mvv.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Andreas Kemnade

Could add a link to data-sheet here.

> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define BD2606_MAX_LEDS 6
> +#define BD2606_MAX_BRIGHTNESS 63
> +#define BD2606_REG_PWRCNT 3
> +#define ldev_to_led(c)	container_of(c, struct bd2606mvv_led, ldev)
> +
> +struct bd2606mvv_led {
> +	bool active;

I didn't spot where this 'active' was used?

> +	unsigned int led_no;
> +	struct led_classdev ldev;
> +	struct bd2606mvv_priv *priv;
> +};
> +
> +struct bd2606mvv_priv {
> +	struct bd2606mvv_led leds[BD2606_MAX_LEDS];
> +	struct regmap *regmap;
> +};
> +
> +static int
> +bd2606mvv_brightness_set(struct led_classdev *led_cdev,
> +		      enum led_brightness brightness)
> +{
> +	struct bd2606mvv_led *led = ldev_to_led(led_cdev);
> +	struct bd2606mvv_priv *priv = led->priv;
> +	int err;
> +
> +	if (brightness == 0) {
> +		return regmap_update_bits(priv->regmap,
> +					  BD2606_REG_PWRCNT,
> +					  1 << led->led_no,
> +					  0);
> +	}

could drop the brackets.

> +
> +	/* shared brightness register */
> +	err = regmap_write(priv->regmap, led->led_no / 2,
> +			   brightness);
> +	if (err)
> +		return err;
> +
> +	return regmap_update_bits(priv->regmap,
> +				  BD2606_REG_PWRCNT,
> +				  1 << led->led_no,
> +				  1 << led->led_no);
> +}
> +
> +static const struct regmap_config bd2606mvv_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x3,
> +};
> +
> +static int bd2606mvv_probe(struct i2c_client *client)
> +{
> +	struct device_node *np, *child;

Is it possible to only use the fwnode? I think the more generic fwnode_* 
is preferred over of_*.

> +	struct device *dev = &client->dev;
> +	struct bd2606mvv_priv *priv;
> +	int err, count, reg;
> +
> +	np = dev_of_node(dev);
> +	if (!np)
> +		return -ENODEV;
> +
> +	count = of_get_available_child_count(np);
> +	if (!count || count > BD2606_MAX_LEDS)
> +		return -EINVAL;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->regmap = devm_regmap_init_i2c(client, &bd2606mvv_regmap);
> +	if (IS_ERR(priv->regmap)) {
> +		err = PTR_ERR(priv->regmap);
> +		dev_err(dev, "Failed to allocate register map: %d\n", err);
> +		return err;
> +	}
> +
> +	i2c_set_clientdata(client, priv);
> +

The IC seems to have an enable pin. I think you might add the 
enable-gpio in dt-bindings and try to (optionally) get and enable it here.

> +	for_each_available_child_of_node(np, child) {
> +		struct bd2606mvv_led *led;
> +		struct led_init_data init_data = {};
> +
> +		init_data.fwnode = of_fwnode_handle(child);
> +
> +		err = of_property_read_u32(child, "reg", &reg);
> +		if (err) {
> +			of_node_put(child);
> +			return err;
> +		}
> +		if (reg < 0 || reg >= BD2606_MAX_LEDS ||
> +		    priv->leds[reg].active) {
> +			of_node_put(child);
> +			return -EINVAL;
> +		}
> +		led = &priv->leds[reg];
> +
> +		led->active = true;
> +		led->priv = priv;
> +		led->led_no = reg;
> +		led->ldev.brightness_set_blocking = bd2606mvv_brightness_set;
> +		led->ldev.max_brightness = BD2606_MAX_BRIGHTNESS;
> +		err = devm_led_classdev_register_ext(dev, &led->ldev,
> +						     &init_data);
> +		if (err < 0) {
> +			of_node_put(child);
> +			return dev_err_probe(dev, err,
> +					     "couldn't register LED %s\n",
> +					     led->ldev.name);
> +		}
> +	}
> +	return 0;
> +}
> +
> +static const struct of_device_id __maybe_unused of_bd2606mvv_leds_match[] = {
> +	{ .compatible = "rohm,bd2606mvv", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_bd2606mvv_leds_match);
> +
> +static struct i2c_driver bd2606mvv_driver = {
> +	.driver   = {
> +		.name    = "leds-bd2606mvv",
> +		.of_match_table = of_match_ptr(of_bd2606mvv_leds_match),
> +	},
> +	.probe_new = bd2606mvv_probe,
> +};
> +
> +module_i2c_driver(bd2606mvv_driver);
> +
> +MODULE_AUTHOR("Andreas Kemnade <andreas@kemnade.info>");
> +MODULE_DESCRIPTION("BD2606 LED driver");
> +MODULE_LICENSE("GPL");

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

