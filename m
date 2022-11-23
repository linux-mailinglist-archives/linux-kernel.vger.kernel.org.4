Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1BD636787
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbiKWRqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiKWRqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:46:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63FE8CF24;
        Wed, 23 Nov 2022 09:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669225580; x=1700761580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xDMZM2SvBxkd6xYRbbh63tRtT/aqUSMlkEIryFHvuyU=;
  b=QNxhm/BVZgTbeb4LmZQuLTjckfDKfi8/FLkNMZZIzEMwkx2cES2XxSlB
   aJqHYkZFGKOuo9w7zCg+Er5GoH3tGleNerqRiph1xlrrZss2ceJwF84Ku
   FJJw95na5Rs9+3NIm1s6aVFdeXGbTE9FzY6Z29uRjiHaCKVXXgkZKQ49i
   BVGIUi/Jb28oyWyDHHkaaHG0r3n8RIfbbTJxGoWLhRIjgr6YG3wxtUjV5
   t2/3ioLuA72uEBFloD4LZ85jlbB8aREP4/frJj7XzFjRjfq5JQiSTuijp
   yGZuW/RrCBGrA/wJAAOHbwsh8yoQiZuHLXuGtwWvp4aAz43XRErJRhoMy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="314159362"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="314159362"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 09:46:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="784326294"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="784326294"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 23 Nov 2022 09:46:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxtpA-00GOE4-2d;
        Wed, 23 Nov 2022 19:46:16 +0200
Date:   Wed, 23 Nov 2022 19:46:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, broonie@kernel.org
Subject: Re: [PATCH v3 8/9] gpio: gpio-mm: Migrate to regmap API
Message-ID: <Y35caA6R8XY7LHU5@smile.fi.intel.com>
References: <cover.1669100542.git.william.gray@linaro.org>
 <4c7d582e4078e265d7a8d39d3aa746e573233a4e.1669100542.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c7d582e4078e265d7a8d39d3aa746e573233a4e.1669100542.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:11:05AM -0500, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver. The gpio-mm module is migrated to the new i8255
> library interface leveraging the gpio-regmap API.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(see also below)

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---
>  drivers/gpio/gpio-gpio-mm.c | 153 +++++++-----------------------------
>  1 file changed, 29 insertions(+), 124 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
> index 2689671b6b01..ba8847485660 100644
> --- a/drivers/gpio/gpio-gpio-mm.c
> +++ b/drivers/gpio/gpio-gpio-mm.c
> @@ -8,13 +8,13 @@
>   */
>  #include <linux/device.h>
>  #include <linux/errno.h>
> -#include <linux/gpio/driver.h>
> -#include <linux/io.h>
>  #include <linux/ioport.h>
>  #include <linux/isa.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
>  
>  #include "gpio-i8255.h"
>  
> @@ -30,83 +30,22 @@ MODULE_PARM_DESC(base, "Diamond Systems GPIO-MM base addresses");
>  
>  #define GPIOMM_NUM_PPI 2
>  
> -/**
> - * struct gpiomm_gpio - GPIO device private data structure
> - * @chip:		instance of the gpio_chip
> - * @ppi_state:		Programmable Peripheral Interface group states
> - * @ppi:		Programmable Peripheral Interface groups
> - */
> -struct gpiomm_gpio {
> -	struct gpio_chip chip;
> -	struct i8255_state ppi_state[GPIOMM_NUM_PPI];
> -	struct i8255 __iomem *ppi;
> +static const struct regmap_range gpiomm_volatile_ranges[] = {
> +	i8255_volatile_regmap_range(0x0), i8255_volatile_regmap_range(0x4),
> +};
> +static const struct regmap_access_table gpiomm_volatile_table = {
> +	.yes_ranges = gpiomm_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(gpiomm_volatile_ranges),
> +};
> +static const struct regmap_config gpiomm_regmap_config = {
> +	.reg_bits = 8,
> +	.reg_stride = 1,
> +	.val_bits = 8,
> +	.io_port = true,
> +	.max_register = 0x7,
> +	.volatile_table = &gpiomm_volatile_table,
> +	.cache_type = REGCACHE_FLAT,
>  };
> -
> -static int gpiomm_gpio_get_direction(struct gpio_chip *chip,
> -	unsigned int offset)
> -{
> -	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
> -
> -	if (i8255_get_direction(gpiommgpio->ppi_state, offset))
> -		return GPIO_LINE_DIRECTION_IN;
> -
> -	return GPIO_LINE_DIRECTION_OUT;
> -}
> -
> -static int gpiomm_gpio_direction_input(struct gpio_chip *chip,
> -	unsigned int offset)
> -{
> -	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
> -
> -	i8255_direction_input(gpiommgpio->ppi, gpiommgpio->ppi_state, offset);
> -
> -	return 0;
> -}
> -
> -static int gpiomm_gpio_direction_output(struct gpio_chip *chip,
> -	unsigned int offset, int value)
> -{
> -	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
> -
> -	i8255_direction_output(gpiommgpio->ppi, gpiommgpio->ppi_state, offset,
> -			       value);
> -
> -	return 0;
> -}
> -
> -static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
> -{
> -	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
> -
> -	return i8255_get(gpiommgpio->ppi, offset);
> -}
> -
> -static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
> -	unsigned long *bits)
> -{
> -	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
> -
> -	i8255_get_multiple(gpiommgpio->ppi, mask, bits, chip->ngpio);
> -
> -	return 0;
> -}
> -
> -static void gpiomm_gpio_set(struct gpio_chip *chip, unsigned int offset,
> -	int value)
> -{
> -	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
> -
> -	i8255_set(gpiommgpio->ppi, gpiommgpio->ppi_state, offset, value);
> -}
> -
> -static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
> -	unsigned long *mask, unsigned long *bits)
> -{
> -	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
> -
> -	i8255_set_multiple(gpiommgpio->ppi, gpiommgpio->ppi_state, mask, bits,
> -			   chip->ngpio);
> -}
>  
>  #define GPIOMM_NGPIO 48
>  static const char *gpiomm_names[GPIOMM_NGPIO] = {
> @@ -120,30 +59,11 @@ static const char *gpiomm_names[GPIOMM_NGPIO] = {
>  	"Port 2C2", "Port 2C3", "Port 2C4", "Port 2C5", "Port 2C6", "Port 2C7",
>  };
>  
> -static void gpiomm_init_dio(struct i8255 __iomem *const ppi,
> -			    struct i8255_state *const ppi_state)
> -{
> -	const unsigned long ngpio = 24;
> -	const unsigned long mask = GENMASK(ngpio - 1, 0);
> -	const unsigned long bits = 0;
> -	unsigned long i;
> -
> -	/* Initialize all GPIO to output 0 */
> -	for (i = 0; i < GPIOMM_NUM_PPI; i++) {
> -		i8255_mode0_output(&ppi[i]);
> -		i8255_set_multiple(&ppi[i], &ppi_state[i], &mask, &bits, ngpio);
> -	}
> -}
> -
>  static int gpiomm_probe(struct device *dev, unsigned int id)
>  {
> -	struct gpiomm_gpio *gpiommgpio;
>  	const char *const name = dev_name(dev);
> -	int err;
> -
> -	gpiommgpio = devm_kzalloc(dev, sizeof(*gpiommgpio), GFP_KERNEL);
> -	if (!gpiommgpio)
> -		return -ENOMEM;

> +	struct i8255_regmap_config config = {0};

{} will be okay as well.

> +	void __iomem *regs;
>  
>  	if (!devm_request_region(dev, base[id], GPIOMM_EXTENT, name)) {
>  		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
> @@ -151,34 +71,19 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
>  		return -EBUSY;
>  	}
>  
> -	gpiommgpio->ppi = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
> -	if (!gpiommgpio->ppi)
> +	regs = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
> +	if (!regs)
>  		return -ENOMEM;
>  
> -	gpiommgpio->chip.label = name;
> -	gpiommgpio->chip.parent = dev;
> -	gpiommgpio->chip.owner = THIS_MODULE;
> -	gpiommgpio->chip.base = -1;
> -	gpiommgpio->chip.ngpio = GPIOMM_NGPIO;
> -	gpiommgpio->chip.names = gpiomm_names;
> -	gpiommgpio->chip.get_direction = gpiomm_gpio_get_direction;
> -	gpiommgpio->chip.direction_input = gpiomm_gpio_direction_input;
> -	gpiommgpio->chip.direction_output = gpiomm_gpio_direction_output;
> -	gpiommgpio->chip.get = gpiomm_gpio_get;
> -	gpiommgpio->chip.get_multiple = gpiomm_gpio_get_multiple;
> -	gpiommgpio->chip.set = gpiomm_gpio_set;
> -	gpiommgpio->chip.set_multiple = gpiomm_gpio_set_multiple;
> -
> -	i8255_state_init(gpiommgpio->ppi_state, GPIOMM_NUM_PPI);
> -	gpiomm_init_dio(gpiommgpio->ppi, gpiommgpio->ppi_state);
> -
> -	err = devm_gpiochip_add_data(dev, &gpiommgpio->chip, gpiommgpio);
> -	if (err) {
> -		dev_err(dev, "GPIO registering failed (%d)\n", err);
> -		return err;
> -	}
> +	config.map = devm_regmap_init_mmio(dev, regs, &gpiomm_regmap_config);
> +	if (IS_ERR(config.map))
> +		return PTR_ERR(config.map);
> +
> +	config.parent = dev;
> +	config.num_ppi = GPIOMM_NUM_PPI;
> +	config.names = gpiomm_names;
>  
> -	return 0;
> +	return devm_i8255_regmap_register(dev, &config);
>  }
>  
>  static struct isa_driver gpiomm_driver = {
> -- 
> 2.38.1
> 

-- 
With Best Regards,
Andy Shevchenko


