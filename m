Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845C167E210
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjA0KoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjA0KoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:44:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215DA3D098;
        Fri, 27 Jan 2023 02:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674816233; x=1706352233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LGTflOF4fWi1HUAGFLkyqA5/1RR+9z9QA+WHOaaYg9Y=;
  b=CTiFY00zx0pbJAPyfMFHY25iF//LcwAr39bzcEWyvgwPACFVtatXVak4
   Tkx8TqhkhKNgr/7plVGQfs/aGWZszF7adC9UzDq/waFbX+YShGE44fXrO
   4eNlNIF+mLjSgrcevAgoD8f9NNbTK6/597bBlpbw7FhVh07d3ncYepbc6
   B+2RjEoAH5LCLowGTwx8Ir44uAa/20u7fmHULVEqXm6ZGkCARndDOQmFU
   B5YWpCLe+a5Z4zm2HZO6Rh5iQ/wQZmcOLrpgsaXICaUmZiU2aerQ6awr4
   I/lJe2iHfQ4pUZH9/JmxPEzF3AkHvS6CK8Sw85y83IISCmYVXEzagHglD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="307407808"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="307407808"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 02:41:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="771531422"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="771531422"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jan 2023 02:41:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLMAw-00Fv44-1G;
        Fri, 27 Jan 2023 12:41:42 +0200
Date:   Fri, 27 Jan 2023 12:41:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] gpiolib: remove asm-generic/gpio.h
Message-ID: <Y9OqZjw8fUb0yAHv@smile.fi.intel.com>
References: <20230127101149.3475929-1-arnd@kernel.org>
 <20230127101149.3475929-4-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127101149.3475929-4-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:11:45AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The asm-generic/gpio.h file is now always included when
> using gpiolib, so just move its contents into linux/gpio.h
> with a few minor simplifications.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  MAINTAINERS                     |   1 -
>  arch/m68k/include/asm/mcfgpio.h |   2 +-
>  drivers/gpio/gpio-davinci.c     |   2 -
>  drivers/pinctrl/core.c          |   1 -
>  include/asm-generic/gpio.h      | 147 --------------------------------
>  include/linux/gpio.h            |  93 ++++++++++++++++++--
>  6 files changed, 85 insertions(+), 161 deletions(-)
>  delete mode 100644 include/asm-generic/gpio.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f64c8f15df4b..25f16f825427 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8731,7 +8731,6 @@ F:	Documentation/admin-guide/gpio/
>  F:	Documentation/devicetree/bindings/gpio/
>  F:	Documentation/driver-api/gpio/
>  F:	drivers/gpio/
> -F:	include/asm-generic/gpio.h
>  F:	include/dt-bindings/gpio/
>  F:	include/linux/gpio.h
>  F:	include/linux/gpio/
> diff --git a/arch/m68k/include/asm/mcfgpio.h b/arch/m68k/include/asm/mcfgpio.h
> index 27f32cc81da6..2cefe8445980 100644
> --- a/arch/m68k/include/asm/mcfgpio.h
> +++ b/arch/m68k/include/asm/mcfgpio.h
> @@ -9,7 +9,7 @@
>  #define mcfgpio_h
>  
>  #ifdef CONFIG_GPIOLIB
> -#include <asm-generic/gpio.h>
> +#include <linux/gpio.h>
>  #else
>  
>  int __mcfgpio_get_value(unsigned gpio);
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index 26b1f7465e09..7fc83057990a 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -24,8 +24,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/pm_runtime.h>
>  
> -#include <asm-generic/gpio.h>
> -
>  #define MAX_REGS_BANKS 5
>  #define MAX_INT_PER_BANK 32
>  
> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
> index d6e6c751255f..401886c81344 100644
> --- a/drivers/pinctrl/core.c
> +++ b/drivers/pinctrl/core.c
> @@ -30,7 +30,6 @@
>  
>  #ifdef CONFIG_GPIOLIB
>  #include "../gpio/gpiolib.h"
> -#include <asm-generic/gpio.h>
>  #endif
>  
>  #include "core.h"
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> deleted file mode 100644
> index 22cb8c9efc1d..000000000000
> --- a/include/asm-generic/gpio.h
> +++ /dev/null
> @@ -1,147 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_GENERIC_GPIO_H
> -#define _ASM_GENERIC_GPIO_H
> -
> -#include <linux/types.h>
> -#include <linux/errno.h>
> -
> -#ifdef CONFIG_GPIOLIB
> -
> -#include <linux/compiler.h>
> -#include <linux/gpio/driver.h>
> -#include <linux/gpio/consumer.h>
> -
> -/*
> - * Platforms may implement their GPIO interface with library code,
> - * at a small performance cost for non-inlined operations and some
> - * extra memory (for code and for per-GPIO table entries).
> - */
> -
> -/*
> - * At the end we want all GPIOs to be dynamically allocated from 0.
> - * However, some legacy drivers still perform fixed allocation.
> - * Until they are all fixed, leave 0-512 space for them.
> - */
> -#define GPIO_DYNAMIC_BASE	512
> -
> -struct device;
> -struct gpio;
> -struct seq_file;
> -struct module;
> -struct device_node;
> -struct gpio_desc;
> -
> -/* Always use the library code for GPIO management calls,
> - * or when sleeping may be involved.
> - */
> -extern int gpio_request(unsigned gpio, const char *label);
> -extern void gpio_free(unsigned gpio);
> -
> -static inline int gpio_direction_input(unsigned gpio)
> -{
> -	return gpiod_direction_input(gpio_to_desc(gpio));
> -}
> -static inline int gpio_direction_output(unsigned gpio, int value)
> -{
> -	return gpiod_direction_output_raw(gpio_to_desc(gpio), value);
> -}
> -
> -static inline int gpio_set_debounce(unsigned gpio, unsigned debounce)
> -{
> -	return gpiod_set_debounce(gpio_to_desc(gpio), debounce);
> -}
> -
> -static inline int gpio_get_value_cansleep(unsigned gpio)
> -{
> -	return gpiod_get_raw_value_cansleep(gpio_to_desc(gpio));
> -}
> -static inline void gpio_set_value_cansleep(unsigned gpio, int value)
> -{
> -	return gpiod_set_raw_value_cansleep(gpio_to_desc(gpio), value);
> -}
> -
> -
> -/* A platform's <asm/gpio.h> code may want to inline the I/O calls when
> - * the GPIO is constant and refers to some always-present controller,
> - * giving direct access to chip registers and tight bitbanging loops.
> - */
> -static inline int __gpio_get_value(unsigned gpio)
> -{
> -	return gpiod_get_raw_value(gpio_to_desc(gpio));
> -}
> -static inline void __gpio_set_value(unsigned gpio, int value)
> -{
> -	return gpiod_set_raw_value(gpio_to_desc(gpio), value);
> -}
> -
> -static inline int __gpio_cansleep(unsigned gpio)
> -{
> -	return gpiod_cansleep(gpio_to_desc(gpio));
> -}
> -
> -static inline int __gpio_to_irq(unsigned gpio)
> -{
> -	return gpiod_to_irq(gpio_to_desc(gpio));
> -}
> -
> -extern int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
> -extern int gpio_request_array(const struct gpio *array, size_t num);
> -extern void gpio_free_array(const struct gpio *array, size_t num);
> -
> -/*
> - * A sysfs interface can be exported by individual drivers if they want,
> - * but more typically is configured entirely from userspace.
> - */
> -static inline int gpio_export(unsigned gpio, bool direction_may_change)
> -{
> -	return gpiod_export(gpio_to_desc(gpio), direction_may_change);
> -}
> -
> -static inline void gpio_unexport(unsigned gpio)
> -{
> -	gpiod_unexport(gpio_to_desc(gpio));
> -}
> -
> -#else	/* !CONFIG_GPIOLIB */
> -
> -#include <linux/kernel.h>
> -
> -/* platforms that don't directly support access to GPIOs through I2C, SPI,
> - * or other blocking infrastructure can use these wrappers.
> - */
> -
> -static inline int gpio_cansleep(unsigned gpio)
> -{
> -	return 0;
> -}
> -
> -static inline int gpio_get_value_cansleep(unsigned gpio)
> -{
> -	might_sleep();
> -	return __gpio_get_value(gpio);
> -}
> -
> -static inline void gpio_set_value_cansleep(unsigned gpio, int value)
> -{
> -	might_sleep();
> -	__gpio_set_value(gpio, value);
> -}
> -
> -#endif /* !CONFIG_GPIOLIB */
> -
> -/*
> - * "valid" GPIO numbers are nonnegative and may be passed to
> - * setup routines like gpio_request().  only some valid numbers
> - * can successfully be requested and used.
> - *
> - * Invalid GPIO numbers are useful for indicating no-such-GPIO in
> - * platform data and other tables.
> - */
> -
> -static inline bool gpio_is_valid(int number)
> -{
> -	/* only non-negative numbers are valid */
> -	return number >= 0;
> -}
> -
> -#endif /* _ASM_GENERIC_GPIO_H */
> diff --git a/include/linux/gpio.h b/include/linux/gpio.h
> index 2b75017b3aad..6719a82eeec5 100644
> --- a/include/linux/gpio.h
> +++ b/include/linux/gpio.h
> @@ -54,26 +54,101 @@ struct gpio {
>  };
>  
>  #ifdef CONFIG_GPIOLIB
> -#include <asm-generic/gpio.h>
> +#include <linux/compiler.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio/driver.h>
>  
> -static inline int gpio_get_value(unsigned int gpio)
> +/*
> + * "valid" GPIO numbers are nonnegative and may be passed to
> + * setup routines like gpio_request().  Only some valid numbers
> + * can successfully be requested and used.
> + *
> + * Invalid GPIO numbers are useful for indicating no-such-GPIO in
> + * platform data and other tables.
> + */
> +static inline bool gpio_is_valid(int number)
> +{
> +	/* only non-negative numbers are valid */
> +	return number >= 0;
> +}
> +
> +/*
> + * Platforms may implement their GPIO interface with library code,
> + * at a small performance cost for non-inlined operations and some
> + * extra memory (for code and for per-GPIO table entries).
> + */
> +
> +/*
> + * At the end we want all GPIOs to be dynamically allocated from 0.
> + * However, some legacy drivers still perform fixed allocation.
> + * Until they are all fixed, leave 0-512 space for them.
> + */
> +#define GPIO_DYNAMIC_BASE	512
> +
> +/* Always use the library code for GPIO management calls,
> + * or when sleeping may be involved.
> + */
> +int gpio_request(unsigned gpio, const char *label);
> +void gpio_free(unsigned gpio);
> +
> +static inline int gpio_direction_input(unsigned gpio)
> +{
> +	return gpiod_direction_input(gpio_to_desc(gpio));
> +}
> +static inline int gpio_direction_output(unsigned gpio, int value)
>  {
> -	return __gpio_get_value(gpio);
> +	return gpiod_direction_output_raw(gpio_to_desc(gpio), value);
>  }
>  
> -static inline void gpio_set_value(unsigned int gpio, int value)
> +static inline int gpio_set_debounce(unsigned gpio, unsigned debounce)
>  {
> -	__gpio_set_value(gpio, value);
> +	return gpiod_set_debounce(gpio_to_desc(gpio), debounce);
>  }
>  
> -static inline int gpio_cansleep(unsigned int gpio)
> +static inline int gpio_get_value_cansleep(unsigned gpio)
> +{
> +	return gpiod_get_raw_value_cansleep(gpio_to_desc(gpio));
> +}
> +static inline void gpio_set_value_cansleep(unsigned gpio, int value)
>  {
> -	return __gpio_cansleep(gpio);
> +	return gpiod_set_raw_value_cansleep(gpio_to_desc(gpio), value);
>  }
>  
> -static inline int gpio_to_irq(unsigned int gpio)
> +static inline int gpio_get_value(unsigned gpio)
> +{
> +	return gpiod_get_raw_value(gpio_to_desc(gpio));
> +}
> +static inline void gpio_set_value(unsigned gpio, int value)
> +{
> +	return gpiod_set_raw_value(gpio_to_desc(gpio), value);
> +}
> +
> +static inline int gpio_cansleep(unsigned gpio)
> +{
> +	return gpiod_cansleep(gpio_to_desc(gpio));
> +}
> +
> +static inline int gpio_to_irq(unsigned gpio)
> +{
> +	return gpiod_to_irq(gpio_to_desc(gpio));
> +}
> +
> +int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
> +int gpio_request_array(const struct gpio *array, size_t num);
> +void gpio_free_array(const struct gpio *array, size_t num);
> +
> +/*
> + * A sysfs interface can be exported by individual drivers if they want,
> + * but more typically is configured entirely from userspace.
> + */
> +static inline int gpio_export(unsigned gpio, bool direction_may_change)
> +{
> +	return gpiod_export(gpio_to_desc(gpio), direction_may_change);
> +}
> +
> +static inline void gpio_unexport(unsigned gpio)
>  {
> -	return __gpio_to_irq(gpio);
> +	gpiod_unexport(gpio_to_desc(gpio));
>  }
>  
>  /* CONFIG_GPIOLIB: bindings for managed devices that want to request gpios */
> -- 
> 2.39.0
> 

-- 
With Best Regards,
Andy Shevchenko


