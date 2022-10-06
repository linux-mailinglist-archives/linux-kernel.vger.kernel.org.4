Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241B35F6363
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiJFJPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiJFJPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:15:16 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AFC2ED4C;
        Thu,  6 Oct 2022 02:15:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y5so1791312lfl.4;
        Thu, 06 Oct 2022 02:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2oZx8oYJ63T+BI1K8lpo7NdYttrBJ2mD1u02Bau0Fo=;
        b=GatUBbi+Qc7PDPbNzMe6+6/hBLR446cMnaOHth1gls7jcR/ZQMFYE/0itzrgAyAXDE
         brltoV/NnbTAZx/0gGgJiMOhS7NFaOCYyeyFoX/QYCTGfsJzugpTr2Nh2fbkuDhItnA6
         ESBClkwiYjQDmRhUgyT3Ahuj77zzD1W0wD2dO2qGwn52iKYifAC9Jw/67GJx4M25DUJx
         QEQChg7cxCYVI+P2LVn1Y1wLcWlmXvlYTi1QiF+ZPMh6Hv8nkuIJ6ACJdHFH/FEGMMcN
         8qI4xQ44LcnoqauyEqebH9dxJUow5p9xIjMuTe0BKrkq2gXOm9f5cU4aLL0YjLoK89Ah
         uMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2oZx8oYJ63T+BI1K8lpo7NdYttrBJ2mD1u02Bau0Fo=;
        b=L4rCl5Lf/pm66tj7Bai5O/TlJ7pK30JlxNJCR7Lbmk8KaSX1fZifMv1rTxOv20Shwu
         Zca4oBofB44TmA8DRbF7mHBvuVWJ+ykWr5dolfG93LMSCOajTEJKQH2073ZDsTVythqf
         r3IMonM/qOll2dvG3rzy/lwUjKC2F212oJE2PvM6jE4yO3eOMZXx89qqnUCQHRuACtFi
         +uPj9JesBkyexSVjYT7kPGsBdVX378dVdWCQTCbyGGNansPP3HER4s1bFkyvJfeF94DY
         VdqLvNmIAtvAXjqe+logJ9p3KNP/B1fh1dxxMS1rsAZwQTD94ExBZnDg+s7D2AT5tpXo
         3Chg==
X-Gm-Message-State: ACrzQf22POQcygywIsIoQqtMJM0O0LoeqsrV7z8+7rvw+19H7uN+R7GK
        z38qX0NGRiv/K/pdEP7uSyeV90cbSOY=
X-Google-Smtp-Source: AMsMyM694QBiwx1YuaoK/XGsgR34fEsTxV3TvcWXuTTGT4aB8joZNN20/QV3AIzFWKNU5uNzk7Qc4A==
X-Received: by 2002:a05:6512:2205:b0:49d:a7e9:455c with SMTP id h5-20020a056512220500b0049da7e9455cmr1575201lfu.296.1665047708857;
        Thu, 06 Oct 2022 02:15:08 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id h19-20020a056512221300b0048a9e18ae67sm2638408lfu.84.2022.10.06.02.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 02:15:08 -0700 (PDT)
Date:   Thu, 6 Oct 2022 12:15:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v4 1/2] gpio: Add gpio latch driver
Message-ID: <20221006091506.bhqe2goh3coxcy2e@mobilestation>
References: <20221006083031.2259006-1-s.hauer@pengutronix.de>
 <20221006083031.2259006-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006083031.2259006-2-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 10:30:30AM +0200, Sascha Hauer wrote:
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
>     Changes since v3:
>     - Introduce delays between GPIO toggles as suggested by Serge Semin
>     
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
>  drivers/gpio/gpio-latch.c | 220 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 227 insertions(+)
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
> index 0000000000000..a4ab8f1240450
> --- /dev/null
> +++ b/drivers/gpio/gpio-latch.c
> @@ -0,0 +1,220 @@
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
> +#include <linux/delay.h>
> +
> +#include "gpiolib.h"
> +
> +struct gpio_latch_priv {
> +	struct gpio_chip gc;
> +	struct gpio_descs *clk_gpios;
> +	struct gpio_descs *latched_gpios;
> +	int n_latched_gpios;
> +	unsigned int setup_duration_ns;
> +	unsigned int clock_duration_ns;
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
> +
> +	ndelay(priv->setup_duration_ns);
> +	set(priv->clk_gpios->desc[latch], 1);

> +	udelay(priv->clock_duration_ns);

These are supposed to be !n!delay()'s. Aren't they?

> +	set(priv->clk_gpios->desc[latch], 0);

> +	udelay(priv->clock_duration_ns);

Why do you need the second clock-duration? AFAICS at least from the
TI SNx4LV74A specification the outputs get updated on the positive
edge of the pulse. So the clock-duration value shall contain both
the "CLK pulse duration" and "CLK hold time", which should be enough
for the latches states being perceived by the device.

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
> +	struct device_node *np = pdev->dev.of_node;

> +	/*
> +	 * Some value which is still acceptable to delay in atomic context.
> +	 * If we need to go higher we might have to switch to usleep_range(),
> +	 * but that cannot ne used in atomic context and the driver would have
> +	 * to be adjusted to support that.
> +	 */
> +	unsigned int duration_ns_max = 5000;

I don't see you changing this parameter. So it's better to be a macro.

-Sergey

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
> +	of_property_read_u32(np, "setup-duration-ns", &priv->setup_duration_ns);
> +	if (priv->setup_duration_ns > duration_ns_max) {
> +		dev_warn(&pdev->dev, "setup-duration-ns too high, limit to %d\n",
> +			 duration_ns_max);
> +		priv->setup_duration_ns = duration_ns_max;
> +	}
> +
> +	of_property_read_u32(np, "clock-duration-ns", &priv->clock_duration_ns);
> +	if (priv->clock_duration_ns > duration_ns_max) {
> +		dev_warn(&pdev->dev, "clock-duration-ns too high, limit to %d\n",
> +			 duration_ns_max);
> +		priv->clock_duration_ns = duration_ns_max;
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
