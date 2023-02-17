Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A7569B2D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBQTGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBQTGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:06:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB02A62429;
        Fri, 17 Feb 2023 11:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676660796; x=1708196796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C1HwhYEGRx0jXmxJic4r57sqdEXLqIHSE0D8nDPPcFQ=;
  b=Wm58IA2EL0nZa5wrM5czXjRKeGxNcXSfcx1hNcJcQFi4SbswyGPVn54O
   AW6JkhWngQVKUETJoiT1OrJCXGJkEoNuOtB9pjCLNf6iHOhMVE0Bf0R5b
   wMX1v5627DHY3crpuqZAtVIPpvosaUOOBnX0NQXbIgJVln/8V2J1pFkLx
   ju3kzmCIkjo5NbH9tPo9ABzJQIX/DOrz/7F91fPxfv8BfVZ1PvZLTmsCF
   Js1Ih4p7tMLy4SIOojQ3L9Y/zohCDNMcrencbA2LNXzBPcdWeVXrM0srb
   cwqnCUmf57gIyBjWLlVvouQ+w3seeIC+ZwUG2KiDdL3yP1s/SUdnrTMBa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="396743750"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="396743750"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 11:06:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="672689362"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="672689362"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 17 Feb 2023 11:06:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pT640-008KZJ-13;
        Fri, 17 Feb 2023 21:06:32 +0200
Date:   Fri, 17 Feb 2023 21:06:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, broonie@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] gpio: idio-16: Remove unused legacy interface
Message-ID: <Y+/QOIHriNYQBOJz@smile.fi.intel.com>
References: <cover.1675876659.git.william.gray@linaro.org>
 <5f2966aaafbba9e6cfcad8544cc72e49a70ceace.1675876659.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f2966aaafbba9e6cfcad8544cc72e49a70ceace.1675876659.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 12:18:21PM -0500, William Breathitt Gray wrote:
> All idio-16 library consumers have migrated to the new interface
> leveraging the gpio-regmap API. Legacy interface functions and code are
> removed as no longer needed.

The best patch in the series!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---
>  drivers/gpio/gpio-idio-16.c | 131 +-----------------------------------
>  drivers/gpio/gpio-idio-16.h |  66 ------------------
>  2 files changed, 1 insertion(+), 196 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
> index 907b0f15fdb3..6882f2f88fe3 100644
> --- a/drivers/gpio/gpio-idio-16.c
> +++ b/drivers/gpio/gpio-idio-16.c
> @@ -3,15 +3,13 @@
>   * GPIO library for the ACCES IDIO-16 family
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
>  #include <linux/types.h>
>  
>  #include "gpio-idio-16.h"
> @@ -172,133 +170,6 @@ int devm_idio_16_regmap_register(struct device *const dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_idio_16_regmap_register);
>  
> -/**
> - * idio_16_get - get signal value at signal offset
> - * @reg:	ACCES IDIO-16 device registers
> - * @state:	ACCES IDIO-16 device state
> - * @offset:	offset of signal to get
> - *
> - * Returns the signal value (0=low, 1=high) for the signal at @offset.
> - */
> -int idio_16_get(struct idio_16 __iomem *const reg,
> -		struct idio_16_state *const state, const unsigned long offset)
> -{
> -	const unsigned long mask = BIT(offset);
> -
> -	if (offset < IDIO_16_NOUT)
> -		return test_bit(offset, state->out_state);
> -
> -	if (offset < 24)
> -		return !!(ioread8(&reg->in0_7) & (mask >> IDIO_16_NOUT));
> -
> -	if (offset < 32)
> -		return !!(ioread8(&reg->in8_15) & (mask >> 24));
> -
> -	return -EINVAL;
> -}
> -EXPORT_SYMBOL_GPL(idio_16_get);
> -
> -/**
> - * idio_16_get_multiple - get multiple signal values at multiple signal offsets
> - * @reg:	ACCES IDIO-16 device registers
> - * @state:	ACCES IDIO-16 device state
> - * @mask:	mask of signals to get
> - * @bits:	bitmap to store signal values
> - *
> - * Stores in @bits the values (0=low, 1=high) for the signals defined by @mask.
> - */
> -void idio_16_get_multiple(struct idio_16 __iomem *const reg,
> -			  struct idio_16_state *const state,
> -			  const unsigned long *const mask,
> -			  unsigned long *const bits)
> -{
> -	unsigned long flags;
> -	const unsigned long out_mask = GENMASK(IDIO_16_NOUT - 1, 0);
> -
> -	spin_lock_irqsave(&state->lock, flags);
> -
> -	bitmap_replace(bits, bits, state->out_state, &out_mask, IDIO_16_NOUT);
> -	if (*mask & GENMASK(23, 16))
> -		bitmap_set_value8(bits, ioread8(&reg->in0_7), 16);
> -	if (*mask & GENMASK(31, 24))
> -		bitmap_set_value8(bits, ioread8(&reg->in8_15), 24);
> -
> -	spin_unlock_irqrestore(&state->lock, flags);
> -}
> -EXPORT_SYMBOL_GPL(idio_16_get_multiple);
> -
> -/**
> - * idio_16_set - set signal value at signal offset
> - * @reg:	ACCES IDIO-16 device registers
> - * @state:	ACCES IDIO-16 device state
> - * @offset:	offset of signal to set
> - * @value:	value of signal to set
> - *
> - * Assigns output @value for the signal at @offset.
> - */
> -void idio_16_set(struct idio_16 __iomem *const reg,
> -		 struct idio_16_state *const state, const unsigned long offset,
> -		 const unsigned long value)
> -{
> -	unsigned long flags;
> -
> -	if (offset >= IDIO_16_NOUT)
> -		return;
> -
> -	spin_lock_irqsave(&state->lock, flags);
> -
> -	__assign_bit(offset, state->out_state, value);
> -	if (offset < 8)
> -		iowrite8(bitmap_get_value8(state->out_state, 0), &reg->out0_7);
> -	else
> -		iowrite8(bitmap_get_value8(state->out_state, 8), &reg->out8_15);
> -
> -	spin_unlock_irqrestore(&state->lock, flags);
> -}
> -EXPORT_SYMBOL_GPL(idio_16_set);
> -
> -/**
> - * idio_16_set_multiple - set signal values at multiple signal offsets
> - * @reg:	ACCES IDIO-16 device registers
> - * @state:	ACCES IDIO-16 device state
> - * @mask:	mask of signals to set
> - * @bits:	bitmap of signal output values
> - *
> - * Assigns output values defined by @bits for the signals defined by @mask.
> - */
> -void idio_16_set_multiple(struct idio_16 __iomem *const reg,
> -			  struct idio_16_state *const state,
> -			  const unsigned long *const mask,
> -			  const unsigned long *const bits)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&state->lock, flags);
> -
> -	bitmap_replace(state->out_state, state->out_state, bits, mask,
> -		       IDIO_16_NOUT);
> -	if (*mask & GENMASK(7, 0))
> -		iowrite8(bitmap_get_value8(state->out_state, 0), &reg->out0_7);
> -	if (*mask & GENMASK(15, 8))
> -		iowrite8(bitmap_get_value8(state->out_state, 8), &reg->out8_15);
> -
> -	spin_unlock_irqrestore(&state->lock, flags);
> -}
> -EXPORT_SYMBOL_GPL(idio_16_set_multiple);
> -
> -/**
> - * idio_16_state_init - initialize idio_16_state structure
> - * @state:	ACCES IDIO-16 device state
> - *
> - * Initializes the ACCES IDIO-16 device @state for use in idio-16 library
> - * functions.
> - */
> -void idio_16_state_init(struct idio_16_state *const state)
> -{
> -	spin_lock_init(&state->lock);
> -}
> -EXPORT_SYMBOL_GPL(idio_16_state_init);
> -
>  MODULE_AUTHOR("William Breathitt Gray");
>  MODULE_DESCRIPTION("ACCES IDIO-16 GPIO Library");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/gpio/gpio-idio-16.h b/drivers/gpio/gpio-idio-16.h
> index 22bb591b4ec0..7a4694dae8f5 100644
> --- a/drivers/gpio/gpio-idio-16.h
> +++ b/drivers/gpio/gpio-idio-16.h
> @@ -3,9 +3,6 @@
>  #ifndef _IDIO_16_H_
>  #define _IDIO_16_H_
>  
> -#include <linux/spinlock.h>
> -#include <linux/types.h>
> -
>  struct device;
>  struct regmap;
>  struct regmap_irq;
> @@ -30,69 +27,6 @@ struct idio_16_regmap_config {
>  	bool filters;
>  };
>  
> -/**
> - * struct idio_16 - IDIO-16 registers structure
> - * @out0_7:	Read: FET Drive Outputs 0-7
> - *		Write: FET Drive Outputs 0-7
> - * @in0_7:	Read: Isolated Inputs 0-7
> - *		Write: Clear Interrupt
> - * @irq_ctl:	Read: Enable IRQ
> - *		Write: Disable IRQ
> - * @filter_ctl:	Read: Activate Input Filters 0-15
> - *		Write: Deactivate Input Filters 0-15
> - * @out8_15:	Read: FET Drive Outputs 8-15
> - *		Write: FET Drive Outputs 8-15
> - * @in8_15:	Read: Isolated Inputs 8-15
> - *		Write: Unused
> - * @irq_status:	Read: Interrupt status
> - *		Write: Unused
> - */
> -struct idio_16 {
> -	u8 out0_7;
> -	u8 in0_7;
> -	u8 irq_ctl;
> -	u8 filter_ctl;
> -	u8 out8_15;
> -	u8 in8_15;
> -	u8 irq_status;
> -};
> -
> -#define IDIO_16_NOUT 16
> -
> -/**
> - * struct idio_16_state - IDIO-16 state structure
> - * @lock:	synchronization lock for accessing device state
> - * @out_state:	output signals state
> - * @irq_mask:	IRQ mask state
> - */
> -struct idio_16_state {
> -	spinlock_t lock;
> -	DECLARE_BITMAP(out_state, IDIO_16_NOUT);
> -};
> -
> -/**
> - * idio_16_get_direction - get the I/O direction for a signal offset
> - * @offset:	offset of signal to get direction
> - *
> - * Returns the signal direction (0=output, 1=input) for the signal at @offset.
> - */
> -static inline int idio_16_get_direction(const unsigned long offset)
> -{
> -	return (offset >= IDIO_16_NOUT) ? 1 : 0;
> -}
> -
> -int idio_16_get(struct idio_16 __iomem *reg, struct idio_16_state *state,
> -		unsigned long offset);
> -void idio_16_get_multiple(struct idio_16 __iomem *reg,
> -			  struct idio_16_state *state,
> -			  const unsigned long *mask, unsigned long *bits);
> -void idio_16_set(struct idio_16 __iomem *reg, struct idio_16_state *state,
> -		 unsigned long offset, unsigned long value);
> -void idio_16_set_multiple(struct idio_16 __iomem *reg,
> -			  struct idio_16_state *state,
> -			  const unsigned long *mask, const unsigned long *bits);
> -void idio_16_state_init(struct idio_16_state *state);
> -
>  int devm_idio_16_regmap_register(struct device *dev,
>  				 const struct idio_16_regmap_config *config);
>  
> -- 
> 2.39.1
> 

-- 
With Best Regards,
Andy Shevchenko


