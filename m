Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC31563677E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbiKWRoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiKWRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:44:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271998CB8D;
        Wed, 23 Nov 2022 09:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669225444; x=1700761444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sQO+k9nuBFGZkzf+UuTqUqVli514lLoA06x9Xr2TrPk=;
  b=SC/3kcpUITjsa0IlXpVAuFxMfBD1+Y4Mcsmq6qUF7kYmukiBHi5ZA4kl
   8DBM1xRdHjjH/Lw7JEXrk32q+PHa7lrlga93mBE/ARHBy7YN0kTaQTxvb
   GMnKMOw71nK54rAkpXnd2wLY+rXaROwf3x6kEUvbQKbZtU4YDoQoa7mEq
   3IPXi17pQSC1lxxBpzxtsqgjfhs8pw2Fkd9INhJNlAL6uVrk98aSv5nMU
   VpGuuajO243Xs81RuREKQ5Ks1gMKDdiuDIYOzGZI2BdAS8lMSUw7bGyDg
   uQ/1viwYgi5d0Ikw5AI6tMiHfodLLcCZPCDOgxH+7clTYd1Fxsxqcs6MD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="294511949"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="294511949"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 09:44:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="766805287"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="766805287"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2022 09:44:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxtmx-00GOBT-1p;
        Wed, 23 Nov 2022 19:43:59 +0200
Date:   Wed, 23 Nov 2022 19:43:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, broonie@kernel.org
Subject: Re: [PATCH v3 7/9] gpio: 104-dio-48e: Migrate to regmap API
Message-ID: <Y35b38dVXJxI4fk+@smile.fi.intel.com>
References: <cover.1669100542.git.william.gray@linaro.org>
 <79705f8932321afd05df52156ef149dc1c9c632c.1669100542.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79705f8932321afd05df52156ef149dc1c9c632c.1669100542.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:11:04AM -0500, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver. The 104-dio-48e module is migrated to the new
> i8255 library interface leveraging the gpio-regmap API.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(see also below)

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---
>  drivers/gpio/gpio-104-dio-48e.c | 147 ++------------------------------
>  1 file changed, 7 insertions(+), 140 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
> index fcee3dc81902..64f4044150b7 100644
> --- a/drivers/gpio/gpio-104-dio-48e.c
> +++ b/drivers/gpio/gpio-104-dio-48e.c
> @@ -9,7 +9,6 @@
>  #include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> -#include <linux/gpio/driver.h>
>  #include <linux/ioport.h>
>  #include <linux/irq.h>
>  #include <linux/isa.h>
> @@ -42,90 +41,6 @@ MODULE_PARM_DESC(irq, "ACCES 104-DIO-48E interrupt line numbers");
>  
>  #define DIO48E_NUM_PPI 2
>  
> -/**
> - * struct dio48e_reg - device register structure
> - * @ppi:		Programmable Peripheral Interface groups
> - */
> -struct dio48e_reg {
> -	struct i8255 ppi[DIO48E_NUM_PPI];
> -};
> -
> -/**
> - * struct dio48e_gpio - GPIO device private data structure
> - * @chip:		instance of the gpio_chip
> - * @ppi_state:		PPI device states
> - * @reg:		I/O address offset for the device registers
> - */
> -struct dio48e_gpio {
> -	struct gpio_chip chip;
> -	struct i8255_state ppi_state[DIO48E_NUM_PPI];
> -	struct dio48e_reg __iomem *reg;
> -};
> -
> -static int dio48e_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
> -{
> -	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
> -
> -	if (i8255_get_direction(dio48egpio->ppi_state, offset))
> -		return GPIO_LINE_DIRECTION_IN;
> -
> -	return GPIO_LINE_DIRECTION_OUT;
> -}
> -
> -static int dio48e_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
> -{
> -	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
> -
> -	i8255_direction_input(dio48egpio->reg->ppi, dio48egpio->ppi_state,
> -			      offset);
> -
> -	return 0;
> -}
> -
> -static int dio48e_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
> -					int value)
> -{
> -	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
> -
> -	i8255_direction_output(dio48egpio->reg->ppi, dio48egpio->ppi_state,
> -			       offset, value);
> -
> -	return 0;
> -}
> -
> -static int dio48e_gpio_get(struct gpio_chip *chip, unsigned int offset)
> -{
> -	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
> -
> -	return i8255_get(dio48egpio->reg->ppi, offset);
> -}
> -
> -static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
> -	unsigned long *bits)
> -{
> -	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
> -
> -	i8255_get_multiple(dio48egpio->reg->ppi, mask, bits, chip->ngpio);
> -
> -	return 0;
> -}
> -
> -static void dio48e_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> -{
> -	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
> -
> -	i8255_set(dio48egpio->reg->ppi, dio48egpio->ppi_state, offset, value);
> -}
> -
> -static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
> -	unsigned long *mask, unsigned long *bits)
> -{
> -	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
> -
> -	i8255_set_multiple(dio48egpio->reg->ppi, dio48egpio->ppi_state, mask,
> -			   bits, chip->ngpio);
> -}
> -
>  static const struct regmap_range dio48e_wr_ranges[] = {
>  	regmap_reg_range(0x0, 0x9), regmap_reg_range(0xB, 0xB),
>  	regmap_reg_range(0xD, 0xD), regmap_reg_range(0xF, 0xF),
> @@ -237,35 +152,10 @@ static const char *dio48e_names[DIO48E_NGPIO] = {
>  	"PPI Group 1 Port C 5", "PPI Group 1 Port C 6", "PPI Group 1 Port C 7"
>  };
>  
> -static int dio48e_irq_init_hw(struct gpio_chip *gc)
> -{
> -	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(gc);
> -
> -	/* Disable IRQ by default */
> -	ioread8(&dio48egpio->reg->enable_interrupt);
> -
> -	return 0;
> -}
> -
> -static void dio48e_init_ppi(struct i8255 __iomem *const ppi,
> -			    struct i8255_state *const ppi_state)
> -{
> -	const unsigned long ngpio = 24;
> -	const unsigned long mask = GENMASK(ngpio - 1, 0);
> -	const unsigned long bits = 0;
> -	unsigned long i;
> -
> -	/* Initialize all GPIO to output 0 */
> -	for (i = 0; i < DIO48E_NUM_PPI; i++) {
> -		i8255_mode0_output(&ppi[i]);
> -		i8255_set_multiple(&ppi[i], &ppi_state[i], &mask, &bits, ngpio);
> -	}
> -}
> -
>  static int dio48e_probe(struct device *dev, unsigned int id)
>  {
> -	struct dio48e_gpio *dio48egpio;
>  	const char *const name = dev_name(dev);

> +	struct i8255_regmap_config config = {0};

{} will work okay.

>  	void __iomem *regs;
>  	struct regmap *map;
>  	unsigned int val;
> @@ -274,10 +164,6 @@ static int dio48e_probe(struct device *dev, unsigned int id)
>  	unsigned int irq_mask;
>  	struct regmap_irq_chip_data *chip_data;
>  
> -	dio48egpio = devm_kzalloc(dev, sizeof(*dio48egpio), GFP_KERNEL);
> -	if (!dio48egpio)
> -		return -ENOMEM;
> -
>  	if (!devm_request_region(dev, base[id], DIO48E_EXTENT, name)) {
>  		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
>  			base[id], base[id] + DIO48E_EXTENT);
> @@ -287,7 +173,6 @@ static int dio48e_probe(struct device *dev, unsigned int id)
>  	regs = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
>  	if (!regs)
>  		return -ENOMEM;
> -	dio48egpio->reg = regs;
>  
>  	map = devm_regmap_init_mmio(dev, regs, &dio48e_regmap_config);
>  	if (IS_ERR(map))
> @@ -324,31 +209,13 @@ static int dio48e_probe(struct device *dev, unsigned int id)
>  		return err;
>  	}
>  
> -	dio48egpio->chip.label = name;
> -	dio48egpio->chip.parent = dev;
> -	dio48egpio->chip.owner = THIS_MODULE;
> -	dio48egpio->chip.base = -1;
> -	dio48egpio->chip.ngpio = DIO48E_NGPIO;
> -	dio48egpio->chip.names = dio48e_names;
> -	dio48egpio->chip.get_direction = dio48e_gpio_get_direction;
> -	dio48egpio->chip.direction_input = dio48e_gpio_direction_input;
> -	dio48egpio->chip.direction_output = dio48e_gpio_direction_output;
> -	dio48egpio->chip.get = dio48e_gpio_get;
> -	dio48egpio->chip.get_multiple = dio48e_gpio_get_multiple;
> -	dio48egpio->chip.set = dio48e_gpio_set;
> -	dio48egpio->chip.set_multiple = dio48e_gpio_set_multiple;
> -
> -	i8255_state_init(dio48egpio->ppi_state, DIO48E_NUM_PPI);
> -	dio48e_init_ppi(dio48egpio->reg->ppi, dio48egpio->ppi_state);
> -
> -	err = devm_gpiochip_add_data(dev, &dio48egpio->chip, dio48egpio);
> -	if (err) {
> -		dev_err(dev, "GPIO registering failed (%d)\n", err);
> -		return err;
> -	}
> +	config.parent = dev;
> +	config.map = map;
> +	config.num_ppi = DIO48E_NUM_PPI;
> +	config.names = dio48e_names;
> +	config.domain = regmap_irq_get_domain(chip_data);
>  
> -	return gpiochip_irqchip_add_domain(&dio48egpio->chip,
> -					   regmap_irq_get_domain(chip_data));
> +	return devm_i8255_regmap_register(dev, &config);
>  }
>  
>  static struct isa_driver dio48e_driver = {
> -- 
> 2.38.1
> 

-- 
With Best Regards,
Andy Shevchenko


