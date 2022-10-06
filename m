Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD585F6650
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJFMpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJFMpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:45:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B96A8052F;
        Thu,  6 Oct 2022 05:45:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 10so2532780lfy.5;
        Thu, 06 Oct 2022 05:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=syFIrhNGevPpXvfxZYLYqs6N+xPUHhSpjZPEZ+aL1yE=;
        b=cYkmR9PyMLbt0fUZ8CVpT1gqVw1vaEgZ4wsD44W4nKx7Xos4hJFwjvvixhe/GGrQA2
         XgEFyVMIR9hLfcf1uOJDD9CIBog1wBPkJc1urISYU4ZYZX5pJIJsI64RMbrn41VCFkFF
         12zGr5XSet13JzfrU8PAhjre465InHcEhIPBbSiRxEo7s6LnK17rkDVa3XJYr/gNXchr
         YxvdS6bpisrHKJVLJa4quUJ3lh2R/i7Y8Q/hn9OHmjnM7b7pXUouwJrW+h++ZD76pXPO
         CgBuzOevgmjhIWuHd55QAEbB32RqX0PC+sYCe7FErBDNgZrm4bLvk5uBLJM9/kIcoPif
         oI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syFIrhNGevPpXvfxZYLYqs6N+xPUHhSpjZPEZ+aL1yE=;
        b=khvQtPqemgALyW8c2G54lJjwd7YPBiCwSP0XYsAJiNeHjZEYwiIncQmkBEF6BQ75DM
         TuifZb4SEjVz7I8HZ0yg638cpjfXuaYNOVeLb5PTlKW2HQQ09aT50seeznJb5tAure32
         uYD7hK7S9x6Pbc89B+qmTRSCPsLYGy3mgOnGJBYZ/P8RZNJ/uIsjYjnA2AqQMsuPa5MJ
         JXPJyyRGKV69hlrEcTuBE9KiSPeTkqj7hHkfKzrGoVt9C0SKXcHSmT4yWMRsv1Ihmoee
         p2MwqBaV5CsB4HIjoC1bfWc/be/Ec6nVRylsTCZfM66Pg+1tUBJ6eJFeqHPRgVIN2OLD
         kyUQ==
X-Gm-Message-State: ACrzQf1qS1xtSKCF4rPmN2ow4T+9nZYagBHesNeYMFbn8RJQIkhH8n/d
        c2Sf17uIa8AxSvVcol0JSCY=
X-Google-Smtp-Source: AMsMyM6DzzlxndZWW7iD5uVWowNfhScTAs2/V4by3aR5YdWdpz1F2LVYpg4Ih62b9daJuK4sjNemig==
X-Received: by 2002:a05:6512:2343:b0:4a2:692a:fcd9 with SMTP id p3-20020a056512234300b004a2692afcd9mr1892861lfu.272.1665060319380;
        Thu, 06 Oct 2022 05:45:19 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id o12-20020a056512230c00b004946748ad4dsm2685630lfu.159.2022.10.06.05.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:45:19 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:45:17 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v4 1/2] gpio: Add gpio latch driver
Message-ID: <20221006124517.pgw7sh7xkczxjzdv@mobilestation>
References: <20221006083031.2259006-1-s.hauer@pengutronix.de>
 <20221006083031.2259006-2-s.hauer@pengutronix.de>
 <20221006091506.bhqe2goh3coxcy2e@mobilestation>
 <20221006122634.GW986@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006122634.GW986@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 02:26:34PM +0200, Sascha Hauer wrote:
> On Thu, Oct 06, 2022 at 12:15:06PM +0300, Serge Semin wrote:
> > On Thu, Oct 06, 2022 at 10:30:30AM +0200, Sascha Hauer wrote:
> > > This driver implements a GPIO multiplexer based on latches connected to
> > > other GPIOs. A set of data GPIOs is connected to the data input of
> > > multiple latches. The clock input of each latch is driven by another
> > > set of GPIOs. With two 8-bit latches 10 GPIOs can be multiplexed into
> > > 16 GPIOs. GPOs might be a better term as in fact the multiplexed pins
> > > are output only.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > > 
> > > Notes:
> > >     Changes since v3:
> > >     - Introduce delays between GPIO toggles as suggested by Serge Semin
> > >     
> > >     Changes since v2:
> > >     - Fix inconsistent licensing
> > >     - document locks
> > >     - use regular bit operations
> > >     - include linux/mod_devicetable.h rather than linux/of_device.h
> > >     - Put spinlock and mutex into a union to make clear that only one of them is used
> > >     - rename __gpio_latch_set to gpio_latch_set_unlocked
> > >     
> > >     Changes since v1:
> > >     - Use gpiod_set_value_cansleep when the underlying GPIOs might sleep
> > >     - Move MODULE_DEVICE_TABLE near to the end
> > > 
> > >  drivers/gpio/Kconfig      |   6 ++
> > >  drivers/gpio/Makefile     |   1 +
> > >  drivers/gpio/gpio-latch.c | 220 ++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 227 insertions(+)
> > >  create mode 100644 drivers/gpio/gpio-latch.c
> > > 
> > > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > > index 0642f579196f2..e4603810ec910 100644
> > > --- a/drivers/gpio/Kconfig
> > > +++ b/drivers/gpio/Kconfig
> > > @@ -1690,6 +1690,12 @@ config GPIO_AGGREGATOR
> > >  	      industrial control context, to be operated from userspace using
> > >  	      the GPIO chardev interface.
> > >  
> > > +config GPIO_LATCH
> > > +	tristate "GPIO latch driver"
> > > +	help
> > > +	  Say yes here to enable a driver for GPIO multiplexers based on latches
> > > +	  connected to other GPIOs.
> > > +
> > >  config GPIO_MOCKUP
> > >  	tristate "GPIO Testing Driver"
> > >  	select IRQ_SIM
> > > diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> > > index a0985d30f51bb..310fa08decc69 100644
> > > --- a/drivers/gpio/Makefile
> > > +++ b/drivers/gpio/Makefile
> > > @@ -75,6 +75,7 @@ obj-$(CONFIG_GPIO_IT87)			+= gpio-it87.o
> > >  obj-$(CONFIG_GPIO_IXP4XX)		+= gpio-ixp4xx.o
> > >  obj-$(CONFIG_GPIO_JANZ_TTL)		+= gpio-janz-ttl.o
> > >  obj-$(CONFIG_GPIO_KEMPLD)		+= gpio-kempld.o
> > > +obj-$(CONFIG_GPIO_LATCH)		+= gpio-latch.o
> > >  obj-$(CONFIG_GPIO_LOGICVC)		+= gpio-logicvc.o
> > >  obj-$(CONFIG_GPIO_LOONGSON1)		+= gpio-loongson1.o
> > >  obj-$(CONFIG_GPIO_LOONGSON)		+= gpio-loongson.o
> > > diff --git a/drivers/gpio/gpio-latch.c b/drivers/gpio/gpio-latch.c
> > > new file mode 100644
> > > index 0000000000000..a4ab8f1240450
> > > --- /dev/null
> > > +++ b/drivers/gpio/gpio-latch.c
> > > @@ -0,0 +1,220 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * GPIO latch driver
> > > + *
> > > + *  Copyright (C) 2022 Sascha Hauer <s.hauer@pengutronix.de>
> > > + *
> > > + * This driver implements a GPIO (or better GPO as there is no input)
> > > + * multiplexer based on latches like this:
> > > + *
> > > + * CLK0 ----------------------.        ,--------.
> > > + * CLK1 -------------------.  `--------|>    #0 |
> > > + *                         |           |        |
> > > + * OUT0 ----------------+--|-----------|D0    Q0|-----|<
> > > + * OUT1 --------------+-|--|-----------|D1    Q1|-----|<
> > > + * OUT2 ------------+-|-|--|-----------|D2    Q2|-----|<
> > > + * OUT3 ----------+-|-|-|--|-----------|D3    Q3|-----|<
> > > + * OUT4 --------+-|-|-|-|--|-----------|D4    Q4|-----|<
> > > + * OUT5 ------+-|-|-|-|-|--|-----------|D5    Q5|-----|<
> > > + * OUT6 ----+-|-|-|-|-|-|--|-----------|D6    Q6|-----|<
> > > + * OUT7 --+-|-|-|-|-|-|-|--|-----------|D7    Q7|-----|<
> > > + *        | | | | | | | |  |           `--------'
> > > + *        | | | | | | | |  |
> > > + *        | | | | | | | |  |           ,--------.
> > > + *        | | | | | | | |  `-----------|>    #1 |
> > > + *        | | | | | | | |              |        |
> > > + *        | | | | | | | `--------------|D0    Q0|-----|<
> > > + *        | | | | | | `----------------|D1    Q1|-----|<
> > > + *        | | | | | `------------------|D2    Q2|-----|<
> > > + *        | | | | `--------------------|D3    Q3|-----|<
> > > + *        | | | `----------------------|D4    Q4|-----|<
> > > + *        | | `------------------------|D5    Q5|-----|<
> > > + *        | `--------------------------|D6    Q6|-----|<
> > > + *        `----------------------------|D7    Q7|-----|<
> > > + *                                     `--------'
> > > + *
> > > + * The above is just an example. The actual number of number of latches and
> > > + * the number of inputs per latch is derived from the number of GPIOs given
> > > + * in the corresponding device tree properties.
> > > + */
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/gpio/driver.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/delay.h>
> > > +
> > > +#include "gpiolib.h"
> > > +
> > > +struct gpio_latch_priv {
> > > +	struct gpio_chip gc;
> > > +	struct gpio_descs *clk_gpios;
> > > +	struct gpio_descs *latched_gpios;
> > > +	int n_latched_gpios;
> > > +	unsigned int setup_duration_ns;
> > > +	unsigned int clock_duration_ns;
> > > +	unsigned long *shadow;
> > > +	/*
> > > +	 * Depending on whether any of the underlying GPIOs may sleep we either
> > > +	 * use a mutex or a spinlock to protect our shadow map.
> > > +	 */
> > > +	union {
> > > +		struct mutex mutex; /* protects @shadow */
> > > +		spinlock_t spinlock; /* protects @shadow */
> > > +	};
> > > +};
> > > +
> > > +static int gpio_latch_get_direction(struct gpio_chip *gc, unsigned int offset)
> > > +{
> > > +	return GPIO_LINE_DIRECTION_OUT;
> > > +}
> > > +
> > > +static void gpio_latch_set_unlocked(struct gpio_latch_priv *priv,
> > > +				    void (*set)(struct gpio_desc *desc, int value),
> > > +				    unsigned int offset, bool val)
> > > +{
> > > +	int latch = offset / priv->n_latched_gpios;
> > > +	int i;
> > > +
> > > +	assign_bit(offset, priv->shadow, val);
> > > +
> > > +	for (i = 0; i < priv->n_latched_gpios; i++)
> > > +		set(priv->latched_gpios->desc[i],
> > > +		    test_bit(latch * priv->n_latched_gpios + i, priv->shadow));
> > > +
> > > +	ndelay(priv->setup_duration_ns);
> > > +	set(priv->clk_gpios->desc[latch], 1);
> > 
> > > +	udelay(priv->clock_duration_ns);
> > 
> > These are supposed to be !n!delay()'s. Aren't they?
> 
> Yes, indeed.
> 
> > 
> > > +	set(priv->clk_gpios->desc[latch], 0);
> > 
> > > +	udelay(priv->clock_duration_ns);
> > 
> > Why do you need the second clock-duration? AFAICS at least from the
> > TI SNx4LV74A specification the outputs get updated on the positive
> > edge of the pulse. So the clock-duration value shall contain both
> > the "CLK pulse duration" and "CLK hold time", which should be enough
> > for the latches states being perceived by the device.
> 
> The rationale was that there should be some delay between two subsequent
> calls to gpio_latch_set_unlocked(). You are right though, on my latch
> the update happens on the positive edge as well, so this shouldn't be
> needed.
> 
> Sascha
> 
> > > +	/*
> > > +	 * Some value which is still acceptable to delay in atomic context.
> > > +	 * If we need to go higher we might have to switch to usleep_range(),
> > > +	 * but that cannot ne used in atomic context and the driver would have
> > > +	 * to be adjusted to support that.
> > > +	 */
> > > +	unsigned int duration_ns_max = 5000;
> > 

> > I don't see you changing this parameter. So it's better to be a macro.
> 
> Why should it?

Well because of its semantics. It's a constant and is definitely a
common parameter for any device. So const-macro-based parametrization
like

/*
...
 */
#define GPIO_LATCH_DURATION_NS_MAX		5000

placed above the struct gpio_latch_priv declaration with the same
comment would be more appropriate than a pre-initialized local
variable. Thus the capitalized name could be right away read that the
parameter is a constant and common for all the devices. In your
implementation it isn't obvious from the variable usage context. I had
to parse the whole gpio_latch_probe() method to understand that.

-Sergey

> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
