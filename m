Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4AA636747
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbiKWRcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbiKWRcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:32:02 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D566C8CFDC;
        Wed, 23 Nov 2022 09:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669224714; x=1700760714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cxDtgEHZHpyKDGMJo8zqaKGeHHJYjWhn770PIRuGDRs=;
  b=fH1IDrFwWJ7AR/qvXV/4RHJ6AsFKcUV2OnHGLuenB4oWJeoejcPIUHhM
   gH6U6hB6jvOhtKrDi8ORCUojM4cY051OmzpWtM7WCIb5/wu9BkNODa6G7
   pbGUY//LGBq1KYs2WrUBfpA4dCcPF2L0aFvGz7AAUq7uHAzSeg7PtPduy
   ZLb9ln2DF/+HvvtmS78XYOSljOAQLb+gpAw7OYA0i82zIEr/97ewGqUDt
   coToX8v6w34AYNcALcljkpe76WA/hPwrbR8R6Ac7nzNx59/X7U2zom3/E
   Qk3GOgV/hhHvmEdo026+rlE/yDgefAGQ5WgW35lzVPVNr9fe9KGLPnFdm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="314156156"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="314156156"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 09:31:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="619698160"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="619698160"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 23 Nov 2022 09:31:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxtbC-00GNpi-0F;
        Wed, 23 Nov 2022 19:31:50 +0200
Date:   Wed, 23 Nov 2022 19:31:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, broonie@kernel.org
Subject: Re: [PATCH v3 9/9] gpio: i8255: Remove unused legacy interface
Message-ID: <Y35ZBcrusTog6Juw@smile.fi.intel.com>
References: <cover.1669100542.git.william.gray@linaro.org>
 <79a900a3ae31882f1186aa37ebe895b84916e98e.1669100542.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79a900a3ae31882f1186aa37ebe895b84916e98e.1669100542.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:11:06AM -0500, William Breathitt Gray wrote:
> All i8255 library consumers have migrated to the new interface
> leveraging the gpio-regmap API. Legacy interface functions and code are
> removed as no longer needed.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---
>  drivers/gpio/gpio-i8255.c | 243 +-------------------------------------
>  drivers/gpio/gpio-i8255.h |  39 ------
>  2 files changed, 1 insertion(+), 281 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-i8255.c b/drivers/gpio/gpio-i8255.c
> index 9ecb2e9b97f9..64ab80fc4a1e 100644
> --- a/drivers/gpio/gpio-i8255.c
> +++ b/drivers/gpio/gpio-i8255.c
> @@ -3,16 +3,13 @@
>   * Intel 8255 Programmable Peripheral Interface
>   * Copyright (C) 2022 William Breathitt Gray
>   */
> -#include <linux/bitmap.h>
> +#include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/gpio/regmap.h>
> -#include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> -#include <linux/spinlock.h>
> -#include <linux/types.h>
>  
>  #include "gpio-i8255.h"
>  
> @@ -30,15 +27,6 @@
>  #define I8255_REG_DAT_BASE I8255_PORTA
>  #define I8255_REG_DIR_IN_BASE I8255_CONTROL
>  
> -static int i8255_get_port(struct i8255 __iomem *const ppi,
> -			  const unsigned long io_port, const unsigned long mask)
> -{
> -	const unsigned long bank = io_port / 3;
> -	const unsigned long ppi_port = io_port % 3;
> -
> -	return ioread8(&ppi[bank].port[ppi_port]) & mask;
> -}
> -
>  static int i8255_direction_mask(const unsigned int offset)
>  {
>  	const unsigned int stride = offset / I8255_NGPIO_PER_REG;
> @@ -103,235 +91,6 @@ static int i8255_reg_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
>  	}
>  }
>  
> -static void i8255_set_port(struct i8255 __iomem *const ppi,
> -			   struct i8255_state *const state,
> -			   const unsigned long io_port,
> -			   const unsigned long mask, const unsigned long bits)
> -{
> -	const unsigned long bank = io_port / 3;
> -	const unsigned long ppi_port = io_port % 3;
> -	unsigned long flags;
> -	unsigned long out_state;
> -
> -	spin_lock_irqsave(&state[bank].lock, flags);
> -
> -	out_state = ioread8(&ppi[bank].port[ppi_port]);
> -	out_state = (out_state & ~mask) | (bits & mask);
> -	iowrite8(out_state, &ppi[bank].port[ppi_port]);
> -
> -	spin_unlock_irqrestore(&state[bank].lock, flags);
> -}
> -
> -/**
> - * i8255_direction_input - configure signal offset as input
> - * @ppi:	Intel 8255 Programmable Peripheral Interface banks
> - * @state:	devices states of the respective PPI banks
> - * @offset:	signal offset to configure as input
> - *
> - * Configures a signal @offset as input for the respective Intel 8255
> - * Programmable Peripheral Interface (@ppi) banks. The @state control_state
> - * values are updated to reflect the new configuration.
> - */
> -void i8255_direction_input(struct i8255 __iomem *const ppi,
> -			   struct i8255_state *const state,
> -			   const unsigned long offset)
> -{
> -	const unsigned long io_port = offset / 8;
> -	const unsigned long bank = io_port / 3;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&state[bank].lock, flags);
> -
> -	state[bank].control_state |= I8255_CONTROL_MODE_SET;
> -	state[bank].control_state |= i8255_direction_mask(offset % 24);
> -
> -	iowrite8(state[bank].control_state, &ppi[bank].control);
> -
> -	spin_unlock_irqrestore(&state[bank].lock, flags);
> -}
> -EXPORT_SYMBOL_NS_GPL(i8255_direction_input, I8255);
> -
> -/**
> - * i8255_direction_output - configure signal offset as output
> - * @ppi:	Intel 8255 Programmable Peripheral Interface banks
> - * @state:	devices states of the respective PPI banks
> - * @offset:	signal offset to configure as output
> - * @value:	signal value to output
> - *
> - * Configures a signal @offset as output for the respective Intel 8255
> - * Programmable Peripheral Interface (@ppi) banks and sets the respective signal
> - * output to the desired @value. The @state control_state values are updated to
> - * reflect the new configuration.
> - */
> -void i8255_direction_output(struct i8255 __iomem *const ppi,
> -			    struct i8255_state *const state,
> -			    const unsigned long offset,
> -			    const unsigned long value)
> -{
> -	const unsigned long io_port = offset / 8;
> -	const unsigned long bank = io_port / 3;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&state[bank].lock, flags);
> -
> -	state[bank].control_state |= I8255_CONTROL_MODE_SET;
> -	state[bank].control_state &= ~i8255_direction_mask(offset % 24);
> -
> -	iowrite8(state[bank].control_state, &ppi[bank].control);
> -
> -	spin_unlock_irqrestore(&state[bank].lock, flags);
> -
> -	i8255_set(ppi, state, offset, value);
> -}
> -EXPORT_SYMBOL_NS_GPL(i8255_direction_output, I8255);
> -
> -/**
> - * i8255_get - get signal value at signal offset
> - * @ppi:	Intel 8255 Programmable Peripheral Interface banks
> - * @offset:	offset of signal to get
> - *
> - * Returns the signal value (0=low, 1=high) for the signal at @offset for the
> - * respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
> - */
> -int i8255_get(struct i8255 __iomem *const ppi, const unsigned long offset)
> -{
> -	const unsigned long io_port = offset / 8;
> -	const unsigned long offset_mask = BIT(offset % 8);
> -
> -	return !!i8255_get_port(ppi, io_port, offset_mask);
> -}
> -EXPORT_SYMBOL_NS_GPL(i8255_get, I8255);
> -
> -/**
> - * i8255_get_direction - get the I/O direction for a signal offset
> - * @state:	devices states of the respective PPI banks
> - * @offset:	offset of signal to get direction
> - *
> - * Returns the signal direction (0=output, 1=input) for the signal at @offset.
> - */
> -int i8255_get_direction(const struct i8255_state *const state,
> -			const unsigned long offset)
> -{
> -	const unsigned long io_port = offset / 8;
> -	const unsigned long bank = io_port / 3;
> -
> -	return !!(state[bank].control_state & i8255_direction_mask(offset % 24));
> -}
> -EXPORT_SYMBOL_NS_GPL(i8255_get_direction, I8255);
> -
> -/**
> - * i8255_get_multiple - get multiple signal values at multiple signal offsets
> - * @ppi:	Intel 8255 Programmable Peripheral Interface banks
> - * @mask:	mask of signals to get
> - * @bits:	bitmap to store signal values
> - * @ngpio:	number of GPIO signals of the respective PPI banks
> - *
> - * Stores in @bits the values (0=low, 1=high) for the signals defined by @mask
> - * for the respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
> - */
> -void i8255_get_multiple(struct i8255 __iomem *const ppi,
> -			const unsigned long *const mask,
> -			unsigned long *const bits, const unsigned long ngpio)
> -{
> -	unsigned long offset;
> -	unsigned long port_mask;
> -	unsigned long io_port;
> -	unsigned long port_state;
> -
> -	bitmap_zero(bits, ngpio);
> -
> -	for_each_set_clump8(offset, port_mask, mask, ngpio) {
> -		io_port = offset / 8;
> -		port_state = i8255_get_port(ppi, io_port, port_mask);
> -
> -		bitmap_set_value8(bits, port_state, offset);
> -	}
> -}
> -EXPORT_SYMBOL_NS_GPL(i8255_get_multiple, I8255);
> -
> -/**
> - * i8255_mode0_output - configure all PPI ports to MODE 0 output mode
> - * @ppi:	Intel 8255 Programmable Peripheral Interface bank
> - *
> - * Configures all Intel 8255 Programmable Peripheral Interface (@ppi) ports to
> - * MODE 0 (Basic Input/Output) output mode.
> - */
> -void i8255_mode0_output(struct i8255 __iomem *const ppi)
> -{
> -	iowrite8(I8255_CONTROL_MODE_SET, &ppi->control);
> -}
> -EXPORT_SYMBOL_NS_GPL(i8255_mode0_output, I8255);
> -
> -/**
> - * i8255_set - set signal value at signal offset
> - * @ppi:	Intel 8255 Programmable Peripheral Interface banks
> - * @state:	devices states of the respective PPI banks
> - * @offset:	offset of signal to set
> - * @value:	value of signal to set
> - *
> - * Assigns output @value for the signal at @offset for the respective Intel 8255
> - * Programmable Peripheral Interface (@ppi) banks.
> - */
> -void i8255_set(struct i8255 __iomem *const ppi, struct i8255_state *const state,
> -	       const unsigned long offset, const unsigned long value)
> -{
> -	const unsigned long io_port = offset / 8;
> -	const unsigned long port_offset = offset % 8;
> -	const unsigned long mask = BIT(port_offset);
> -	const unsigned long bits = value << port_offset;
> -
> -	i8255_set_port(ppi, state, io_port, mask, bits);
> -}
> -EXPORT_SYMBOL_NS_GPL(i8255_set, I8255);
> -
> -/**
> - * i8255_set_multiple - set signal values at multiple signal offsets
> - * @ppi:	Intel 8255 Programmable Peripheral Interface banks
> - * @state:	devices states of the respective PPI banks
> - * @mask:	mask of signals to set
> - * @bits:	bitmap of signal output values
> - * @ngpio:	number of GPIO signals of the respective PPI banks
> - *
> - * Assigns output values defined by @bits for the signals defined by @mask for
> - * the respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
> - */
> -void i8255_set_multiple(struct i8255 __iomem *const ppi,
> -			struct i8255_state *const state,
> -			const unsigned long *const mask,
> -			const unsigned long *const bits,
> -			const unsigned long ngpio)
> -{
> -	unsigned long offset;
> -	unsigned long port_mask;
> -	unsigned long io_port;
> -	unsigned long value;
> -
> -	for_each_set_clump8(offset, port_mask, mask, ngpio) {
> -		io_port = offset / 8;
> -		value = bitmap_get_value8(bits, offset);
> -		i8255_set_port(ppi, state, io_port, port_mask, value);
> -	}
> -}
> -EXPORT_SYMBOL_NS_GPL(i8255_set_multiple, I8255);
> -
> -/**
> - * i8255_state_init - initialize i8255_state structure
> - * @state:	devices states of the respective PPI banks
> - * @nbanks:	number of Intel 8255 Programmable Peripheral Interface banks
> - *
> - * Initializes the @state of each Intel 8255 Programmable Peripheral Interface
> - * bank for use in i8255 library functions.
> - */
> -void i8255_state_init(struct i8255_state *const state,
> -		      const unsigned long nbanks)
> -{
> -	unsigned long bank;
> -
> -	for (bank = 0; bank < nbanks; bank++)
> -		spin_lock_init(&state[bank].lock);
> -}
> -EXPORT_SYMBOL_NS_GPL(i8255_state_init, I8255);
> -
>  /**
>   * devm_i8255_regmap_register - Register an i8255 GPIO controller
>   * @dev:	device that is registering this i8255 GPIO device
> diff --git a/drivers/gpio/gpio-i8255.h b/drivers/gpio/gpio-i8255.h
> index 6ec987835c14..bc3023745e7b 100644
> --- a/drivers/gpio/gpio-i8255.h
> +++ b/drivers/gpio/gpio-i8255.h
> @@ -6,28 +6,6 @@
>  #include <linux/device.h>
>  #include <linux/irqdomain.h>
>  #include <linux/regmap.h>
> -#include <linux/spinlock.h>
> -#include <linux/types.h>
> -
> -/**
> - * struct i8255 - Intel 8255 register structure
> - * @port:	Port A, B, and C
> - * @control:	Control register
> - */
> -struct i8255 {
> -	u8 port[3];
> -	u8 control;
> -};
> -
> -/**
> - * struct i8255_state - Intel 8255 state structure
> - * @lock:		synchronization lock for accessing device state
> - * @control_state:	Control register state
> - */
> -struct i8255_state {
> -	spinlock_t lock;
> -	u8 control_state;
> -};
>  
>  #define i8255_volatile_regmap_range(_base) regmap_reg_range(_base, _base + 0x2)
>  
> @@ -53,21 +31,4 @@ struct i8255_regmap_config {
>  int devm_i8255_regmap_register(struct device *dev,
>  			       const struct i8255_regmap_config *config);
>  
> -void i8255_direction_input(struct i8255 __iomem *ppi, struct i8255_state *state,
> -			   unsigned long offset);
> -void i8255_direction_output(struct i8255 __iomem *ppi,
> -			    struct i8255_state *state, unsigned long offset,
> -			    unsigned long value);
> -int i8255_get(struct i8255 __iomem *ppi, unsigned long offset);
> -int i8255_get_direction(const struct i8255_state *state, unsigned long offset);
> -void i8255_get_multiple(struct i8255 __iomem *ppi, const unsigned long *mask,
> -			unsigned long *bits, unsigned long ngpio);
> -void i8255_mode0_output(struct i8255 __iomem *const ppi);
> -void i8255_set(struct i8255 __iomem *ppi, struct i8255_state *state,
> -	       unsigned long offset, unsigned long value);
> -void i8255_set_multiple(struct i8255 __iomem *ppi, struct i8255_state *state,
> -			const unsigned long *mask, const unsigned long *bits,
> -			unsigned long ngpio);
> -void i8255_state_init(struct i8255_state *const state, unsigned long nbanks);
> -
>  #endif /* _I8255_H_ */
> -- 
> 2.38.1
> 

-- 
With Best Regards,
Andy Shevchenko


