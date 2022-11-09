Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65F8622F47
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiKIPoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKIPoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:44:12 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DF526B;
        Wed,  9 Nov 2022 07:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668008650; x=1699544650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uf8x9QH/RmFX0sTNIMKa4yl3lKUnVcVn+Gb5ElJY89Q=;
  b=ZvOL4dO1VcI4kCCqOt02/eqfgTENLpG8KN7hYVMV4EeWvhzs87+npCmr
   +1elIzPY84cpXpnjxd1LT2fFWw0xvT+98qqlz7jEKXmtv5uRCQEKqB09T
   CLKZFuG7F5FxUOV6tXi0dC5Nt8qe2d9xxheT4tfQYLDFkK7jbrOKdTAQB
   w4RjTwi2L4BMOvsuWcBZngWe/+6LTizw/5Z/dUD56HFH52RCcVPjZcig2
   AzPjgA8GJrbnsordAsd+WifFHN2pR+aEvrvw0J2ssi5W6fXDjbqOq3BRl
   5n09EOl76TeJ/DPQrcHKfdsJwKAkfMo65TLgZQPJY98ANudYjPl9AI+1y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="375286938"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="375286938"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:40:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="631287359"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="631287359"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 09 Nov 2022 07:40:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1osnBw-009oDq-0f;
        Wed, 09 Nov 2022 17:40:40 +0200
Date:   Wed, 9 Nov 2022 17:40:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
Subject: Re: [PATCH v8 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver
 support
Message-ID: <Y2vJ953qKHQTalru@smile.fi.intel.com>
References: <20221109061122.786-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109061122.786-1-zhuyinbo@loongson.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 02:11:21PM +0800, Yinbo Zhu wrote:
> The Loongson-2 SoC has a few pins that can be used as GPIOs or take
> multiple other functions. Add a driver for the pinmuxing.
> 
> There is currently no support for GPIO pin pull-up and pull-down.

> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

Why two SoBs? Who is(are) the author(s)?

...

> +	help
> +	  This selects pin control driver for the Loongson-2 SoC. It

One space is enough.

> +	  provides pin config functions multiplexing.  GPIO pin pull-up,
> +	  pull-down functions are not supported. Say yes to enable
> +	  pinctrl for Loongson-2 SoC.

Perhaps keep your entry in order?

>  source "drivers/pinctrl/actions/Kconfig"
>  source "drivers/pinctrl/aspeed/Kconfig"
>  source "drivers/pinctrl/bcm/Kconfig"

...

> @@ -29,6 +29,7 @@ obj-$(CONFIG_PINCTRL_KEEMBAY)	+= pinctrl-keembay.o
>  obj-$(CONFIG_PINCTRL_LANTIQ)	+= pinctrl-lantiq.o
>  obj-$(CONFIG_PINCTRL_FALCON)	+= pinctrl-falcon.o
>  obj-$(CONFIG_PINCTRL_XWAY)	+= pinctrl-xway.o
> +obj-$(CONFIG_PINCTRL_LOONGSON2) += pinctrl-loongson2.o

I would expect more order here...

>  obj-$(CONFIG_PINCTRL_LPC18XX)	+= pinctrl-lpc18xx.o
>  obj-$(CONFIG_PINCTRL_MAX77620)	+= pinctrl-max77620.o
>  obj-$(CONFIG_PINCTRL_MCP23S08_I2C)	+= pinctrl-mcp23s08_i2c.o

...

> + * Author: zhanghongchen <zhanghongchen@loongson.cn>
> + *         Yinbo Zhu <zhuyinbo@loongson.cn>

Missed Co-developed-by tag above?

> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

> +#include <linux/of.h>

I found no user of this header.
But you missed mod_devicetable.h.

> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinctrl.h>

Can we keep it as a separate group after generic linux/* ones?

> +#include <linux/seq_file.h>

+ Blank line.

> +#include <asm-generic/io.h>

No, use linux/io.h.

...

> +#define PMX_GROUP(grp, offset, bitv)					\
> +	{								\
> +		.name = #grp,						\
> +		.pins = grp ## _pins,					\
> +		.num_pins = ARRAY_SIZE(grp ## _pins),			\
> +		.reg = offset,						\
> +		.bit = bitv,						\
> +	}

Use PINCTRL_PINGROUP() and associated data structure.

...

> +static const unsigned int lio_pins[]    = {};
> +static const unsigned int uart2_pins[]  = {};
> +static const unsigned int uart1_pins[]  = {};
> +static const unsigned int camera_pins[] = {};
> +static const unsigned int dvo1_pins[]   = {};
> +static const unsigned int dvo0_pins[]   = {};

No sure what this means.

...

> +static struct loongson2_pmx_group loongson2_pmx_groups[] = {
> +	PMX_GROUP(gpio, 0x0, 64),
> +	PMX_GROUP(sdio, 0x0, 20),
> +	PMX_GROUP(can1, 0x0, 17),
> +	PMX_GROUP(can0, 0x0, 16),
> +	PMX_GROUP(pwm3, 0x0, 15),
> +	PMX_GROUP(pwm2, 0x0, 14),
> +	PMX_GROUP(pwm1, 0x0, 13),
> +	PMX_GROUP(pwm0, 0x0, 12),
> +	PMX_GROUP(i2c1, 0x0, 11),
> +	PMX_GROUP(i2c0, 0x0, 10),
> +	PMX_GROUP(nand, 0x0, 9),
> +	PMX_GROUP(sata_led, 0x0, 8),
> +	PMX_GROUP(lio, 0x0, 7),
> +	PMX_GROUP(i2s, 0x0, 6),
> +	PMX_GROUP(hda, 0x0, 4),
> +	PMX_GROUP(uart2, 0x8, 13),
> +	PMX_GROUP(uart1, 0x8, 12),
> +	PMX_GROUP(camera, 0x10, 5),
> +	PMX_GROUP(dvo1, 0x10, 4),
> +	PMX_GROUP(dvo0, 0x10, 1),

> +

Redundant blank line.

> +};

...

> +static const char * const gpio_groups[] = {
> +	"sdio", "can1", "can0", "pwm3", "pwm2", "pwm1", "pwm0", "i2c1",
> +	"i2c0", "nand", "sata_led", "lio", "i2s", "hda", "uart2", "uart1",
> +	"camera", "dvo1", "dvo0"

Leave trailing comma.

Also it would be nice to have that grouped like

	"sdio",
	"can1", "can0",
	"pwm3", "pwm2", "pwm1", "pwm0",
	"i2c1", "i2c0",
	"nand",
	"sata_led",
	"lio",
	"i2s", "hda",
	"uart2", "uart1",
	"camera",
	"dvo1", "dvo0",

> +};


...

> +	unsigned long reg = (unsigned long)pctrl->reg_base +
> +				loongson2_pmx_groups[group_num].reg;

Why casting?!

...

> +	val = readl((void *)reg);

Ouch.

> +	if (func_num == 0)
> +		val &= ~(1<<mux_bit);
> +	else
> +		val |= (1<<mux_bit);

Why not using __assign_bit() or similar? Or at least BIT() ?

...

> +	writel(val, (void *)reg);

Ouch!

...

> +	pctrl->reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pctrl->reg_base))

> +		return dev_err_probe(pctrl->dev, PTR_ERR(pctrl->reg_base),
> +				     "unable to map I/O memory");

Message duplicates what core does.

...

> +	pctrl->desc.confops	= NULL;

Redundant.

...

> +static const struct of_device_id loongson2_pinctrl_dt_match[] = {
> +	{
> +		.compatible = "loongson,ls2k-pinctrl",
> +	},

> +	{ },

No comma for the terminator line.

> +};

-- 
With Best Regards,
Andy Shevchenko


