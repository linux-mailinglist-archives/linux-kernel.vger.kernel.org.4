Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3135B89D8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiINOEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiINOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:04:13 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3125776749;
        Wed, 14 Sep 2022 07:03:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id p5so18383861ljc.13;
        Wed, 14 Sep 2022 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=RuOaQhYbr5T6MnVhKoqqAsTO1OPpUIr9a2tO5WPZWDM=;
        b=AGUMhUoe/H7w88i8PFdtQ174vMV296Ir4r9mB1fITufoi78axuTufLaolDs9Ehxl4O
         LLyVBU6EzXaef7L78EOxP6vurGBUt8t6zilrdAch01Fe3uxy/mc4bywRGdiToIC39aaa
         deA3pBlLnz8GPTMpHAD0HYwtw50jRCVmRud0wdKcyb3Gy2gBZkZNe8Pg9eiKwGK6KX2h
         i5wZKuQIz2jwB931JEjoEn90t+sCNN6x/4HgLJHisdcn2T1oy8w55xpZKCnuIdgqxM8J
         PXTxuPcVrjr04OfMUbLRh8WBYuB3WIuyEs3bJ8g3D5q33H42pLv8LxkKMBcY/jxsw52U
         isVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RuOaQhYbr5T6MnVhKoqqAsTO1OPpUIr9a2tO5WPZWDM=;
        b=Xr86ixZXqSrhpilTx5w3a7fD+DzSlxJtbft6IVdbh1jZvBBz5gihcs29sduIwABVlz
         /4rH6yQVWp4n/0FRqQt6OUgM57Am+QPQOdNbBa8IpoJ+zoN05PMdfnqGmce6WzyMBilt
         6v5TNJWnLQvKZlOXS23HqPDha7jE5dd6LqxxcsTXnyHYNFj9eofKsZrqwbFOrUi1WxAJ
         OHRZTMdMSx12nAuwoEdOKg7ly7OvWgMRvrGqVVW4tLwCadViJYCwqxoGBm1cCGjQnXXY
         UbpaVmTmoaIOJ8b9D4B3fqvikk5/SHPa3OYEekcVv/vtHUaP46AIiiTLTf52O9cF+TQw
         cjeQ==
X-Gm-Message-State: ACgBeo26SGFV/ELLE3JPmrh9VyxAVRW/nSteCmJ/6Kmr2iSFiIgHB4ip
        beNRA/Ocz7BFT6V6pZvclGaAfg2Rq00=
X-Google-Smtp-Source: AA6agR4sbK568RX4DmdnSaUdOXVE88bOWn6gQcKR0Saa7DkE22cWHGE/0hnXA6d66FTa2MobS6KotQ==
X-Received: by 2002:a2e:a812:0:b0:261:8f2d:9530 with SMTP id l18-20020a2ea812000000b002618f2d9530mr10270837ljq.251.1663164192725;
        Wed, 14 Sep 2022 07:03:12 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id v21-20020ac258f5000000b00492f6ddba59sm2404038lfo.75.2022.09.14.07.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:03:12 -0700 (PDT)
Date:   Wed, 14 Sep 2022 17:03:10 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v3 1/2] gpio: Add gpio latch driver
Message-ID: <20220914140310.5ffrnsy63piegdyr@mobilestation>
References: <20220914071306.3254881-1-s.hauer@pengutronix.de>
 <20220914071306.3254881-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914071306.3254881-2-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 09:13:05AM +0200, Sascha Hauer wrote:
> This driver implements a GPIO multiplexer based on latches connected to
> other GPIOs. A set of data GPIOs is connected to the data input of
> multiple latches. The clock input of each latch is driven by another
> set of GPIOs. With two 8-bit latches 10 GPIOs can be multiplexed into
> 16 GPIOs. GPOs might be a better term as in fact the multiplexed pins
> are output only.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v2:
>     - Fix inconsistent licensing
>     - document locks
>     - use regular bit operations
>     - include linux/mod_devicetable.h rather than linux/of_device.h
>     - Put spinlock and mutex into a union to make clear that only one of them is used
>     - rename __gpio_latch_set to gpio_latch_set_unlocked
>     
>     Changes since v1:
>     - Use gpiod_set_value_cansleep when the underlying GPIOs might sleep
>     - Move MODULE_DEVICE_TABLE near to the end
> 
>  drivers/gpio/Kconfig      |   6 ++
>  drivers/gpio/Makefile     |   1 +
>  drivers/gpio/gpio-latch.c | 192 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 199 insertions(+)
>  create mode 100644 drivers/gpio/gpio-latch.c
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 0642f579196f2..e4603810ec910 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1690,6 +1690,12 @@ config GPIO_AGGREGATOR
>  	      industrial control context, to be operated from userspace using
>  	      the GPIO chardev interface.
>  
> +config GPIO_LATCH
> +	tristate "GPIO latch driver"
> +	help
> +	  Say yes here to enable a driver for GPIO multiplexers based on latches
> +	  connected to other GPIOs.
> +
>  config GPIO_MOCKUP
>  	tristate "GPIO Testing Driver"
>  	select IRQ_SIM
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index a0985d30f51bb..310fa08decc69 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_GPIO_IT87)			+= gpio-it87.o
>  obj-$(CONFIG_GPIO_IXP4XX)		+= gpio-ixp4xx.o
>  obj-$(CONFIG_GPIO_JANZ_TTL)		+= gpio-janz-ttl.o
>  obj-$(CONFIG_GPIO_KEMPLD)		+= gpio-kempld.o
> +obj-$(CONFIG_GPIO_LATCH)		+= gpio-latch.o
>  obj-$(CONFIG_GPIO_LOGICVC)		+= gpio-logicvc.o
>  obj-$(CONFIG_GPIO_LOONGSON1)		+= gpio-loongson1.o
>  obj-$(CONFIG_GPIO_LOONGSON)		+= gpio-loongson.o
> diff --git a/drivers/gpio/gpio-latch.c b/drivers/gpio/gpio-latch.c
> new file mode 100644
> index 0000000000000..4134cba1c88a8
> --- /dev/null
> +++ b/drivers/gpio/gpio-latch.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * GPIO latch driver
> + *
> + *  Copyright (C) 2022 Sascha Hauer <s.hauer@pengutronix.de>
> + *
> + * This driver implements a GPIO (or better GPO as there is no input)
> + * multiplexer based on latches like this:
> + *
> + * CLK0 ----------------------.        ,--------.
> + * CLK1 -------------------.  `--------|>    #0 |
> + *                         |           |        |
> + * OUT0 ----------------+--|-----------|D0    Q0|-----|<
> + * OUT1 --------------+-|--|-----------|D1    Q1|-----|<
> + * OUT2 ------------+-|-|--|-----------|D2    Q2|-----|<
> + * OUT3 ----------+-|-|-|--|-----------|D3    Q3|-----|<
> + * OUT4 --------+-|-|-|-|--|-----------|D4    Q4|-----|<
> + * OUT5 ------+-|-|-|-|-|--|-----------|D5    Q5|-----|<
> + * OUT6 ----+-|-|-|-|-|-|--|-----------|D6    Q6|-----|<
> + * OUT7 --+-|-|-|-|-|-|-|--|-----------|D7    Q7|-----|<
> + *        | | | | | | | |  |           `--------'
> + *        | | | | | | | |  |
> + *        | | | | | | | |  |           ,--------.
> + *        | | | | | | | |  `-----------|>    #1 |
> + *        | | | | | | | |              |        |
> + *        | | | | | | | `--------------|D0    Q0|-----|<
> + *        | | | | | | `----------------|D1    Q1|-----|<
> + *        | | | | | `------------------|D2    Q2|-----|<
> + *        | | | | `--------------------|D3    Q3|-----|<
> + *        | | | `----------------------|D4    Q4|-----|<
> + *        | | `------------------------|D5    Q5|-----|<
> + *        | `--------------------------|D6    Q6|-----|<
> + *        `----------------------------|D7    Q7|-----|<
> + *                                     `--------'
> + *
> + * The above is just an example. The actual number of number of latches and
> + * the number of inputs per latch is derived from the number of GPIOs given
> + * in the corresponding device tree properties.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +
> +#include "gpiolib.h"
> +
> +struct gpio_latch_priv {
> +	struct gpio_chip gc;
> +	struct gpio_descs *clk_gpios;
> +	struct gpio_descs *latched_gpios;
> +	int n_latched_gpios;
> +	unsigned long *shadow;
> +	/*
> +	 * Depending on whether any of the underlying GPIOs may sleep we either
> +	 * use a mutex or a spinlock to protect our shadow map.
> +	 */
> +	union {
> +		struct mutex mutex; /* protects @shadow */
> +		spinlock_t spinlock; /* protects @shadow */
> +	};
> +};
> +
> +static int gpio_latch_get_direction(struct gpio_chip *gc, unsigned int offset)
> +{
> +	return GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static void gpio_latch_set_unlocked(struct gpio_latch_priv *priv,
> +				    void (*set)(struct gpio_desc *desc, int value),
> +				    unsigned int offset, bool val)
> +{
> +	int latch = offset / priv->n_latched_gpios;
> +	int i;
> +
> +	assign_bit(offset, priv->shadow, val);
> +

> +	for (i = 0; i < priv->n_latched_gpios; i++)
> +		set(priv->latched_gpios->desc[i],
> +		    test_bit(latch * priv->n_latched_gpios + i, priv->shadow));

-> duration?

> +
> +	set(priv->clk_gpios->desc[latch], 1);

-> duration?

> +	set(priv->clk_gpios->desc[latch], 0);

I am pretty much sure there must be some duration between the actions
above *. See for instance the tw and (tsu + th) timing requirements in
the next edge-triggered flip-flops:
https://www.ti.com/lit/ds/symlink/sn74lv74a.pdf?ts=1663163389954&ref_url=https%253A%252F%252Fwww.google.com%252F

The durations are normally small (ns or a bit smaller) but still need
to be added anyway.

Note since the durations are device-specific an additional DT-property array
with durations should be added too.

* already faced weird problems in this regard.

-Sergey

> +}
> +
> +static void gpio_latch_set(struct gpio_chip *gc, unsigned int offset, int val)
> +{
> +	struct gpio_latch_priv *priv = gpiochip_get_data(gc);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->spinlock, flags);
> +
> +	gpio_latch_set_unlocked(priv, gpiod_set_value, offset, val);
> +
> +	spin_unlock_irqrestore(&priv->spinlock, flags);
> +}
> +
> +static void gpio_latch_set_can_sleep(struct gpio_chip *gc, unsigned int offset, int val)
> +{
> +	struct gpio_latch_priv *priv = gpiochip_get_data(gc);
> +
> +	mutex_lock(&priv->mutex);
> +
> +	gpio_latch_set_unlocked(priv, gpiod_set_value_cansleep, offset, val);
> +
> +	mutex_unlock(&priv->mutex);
> +}
> +
> +static bool gpio_latch_can_sleep(struct gpio_latch_priv *priv, unsigned int n_latches)
> +{
> +	int i;
> +
> +	for (i = 0; i < n_latches; i++)
> +		if (gpiod_cansleep(priv->clk_gpios->desc[i]))
> +			return true;
> +
> +	for (i = 0; i < priv->n_latched_gpios; i++)
> +		if (gpiod_cansleep(priv->latched_gpios->desc[i]))
> +			return true;
> +
> +	return false;
> +}
> +
> +static int gpio_latch_probe(struct platform_device *pdev)
> +{
> +	struct gpio_latch_priv *priv;
> +	unsigned int n_latches;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clk_gpios = devm_gpiod_get_array(&pdev->dev, "clk", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->clk_gpios))
> +		return PTR_ERR(priv->clk_gpios);
> +
> +	priv->latched_gpios = devm_gpiod_get_array(&pdev->dev, "latched", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->latched_gpios))
> +		return PTR_ERR(priv->latched_gpios);
> +
> +	n_latches = priv->clk_gpios->ndescs;
> +	priv->n_latched_gpios = priv->latched_gpios->ndescs;
> +
> +	priv->shadow = devm_bitmap_zalloc(&pdev->dev, n_latches * priv->n_latched_gpios,
> +					  GFP_KERNEL);
> +	if (!priv->shadow)
> +		return -ENOMEM;
> +
> +	if (gpio_latch_can_sleep(priv, n_latches)) {
> +		priv->gc.can_sleep = true;
> +		priv->gc.set = gpio_latch_set_can_sleep;
> +		mutex_init(&priv->mutex);
> +	} else {
> +		priv->gc.can_sleep = false;
> +		priv->gc.set = gpio_latch_set;
> +		spin_lock_init(&priv->spinlock);
> +	}
> +
> +	priv->gc.get_direction = gpio_latch_get_direction;
> +	priv->gc.ngpio = n_latches * priv->n_latched_gpios;
> +	priv->gc.owner = THIS_MODULE;
> +	priv->gc.base = -1;
> +	priv->gc.parent = &pdev->dev;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
> +}
> +
> +static const struct of_device_id gpio_latch_ids[] = {
> +	{
> +		.compatible	= "gpio-latch",
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, gpio_latch_ids);
> +
> +static struct platform_driver gpio_latch_driver = {
> +	.driver	= {
> +		.name		= "gpio-latch",
> +		.of_match_table	= gpio_latch_ids,
> +	},
> +	.probe	= gpio_latch_probe,
> +};
> +module_platform_driver(gpio_latch_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
> +MODULE_DESCRIPTION("GPIO latch driver");
> -- 
> 2.30.2
> 
