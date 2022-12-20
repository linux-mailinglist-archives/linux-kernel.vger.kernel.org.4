Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFC06521E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiLTOBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLTOBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:01:15 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75A05FA8;
        Tue, 20 Dec 2022 06:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671544872; x=1703080872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AhrCjMsOdyTqB1pTJuzcfG4IOt4EksCe1Hd9MEV/z9s=;
  b=jXYDB4KP4xes0EWWq5RDGPR0CmnwB4BhLv7dcnDQWZdril+vXYzuaMEn
   +i90PmzNm5fL+eDvy3coUJlwRQeO3UUNUSzZOs7I/ZmrA3NBnXfrZxhY8
   CYFgCvm2T2xD3YlCd3aOJOiCWy8PXTIsmFk26j/CUP0oo3rutVmm/DW4k
   bOf+Dlt3joMCYpQ/l6x4LdLpkCou2jNhWguomq+NHx7j+3Drs5F4a5Ua/
   Y8ROHUVOy3mUHQKBqHc+5SRrRdBE5G+ZvyWrPtbDSCJgbLdlDMsn2Br96
   HkJ0yDjZopFwCLumu0N8GIC8OzlL0kfR3yLMjtqTWmvTuqIylHEfzs2tF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="317253744"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="317253744"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 06:01:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="775320450"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="775320450"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 20 Dec 2022 06:01:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7dB6-00CtXG-2r;
        Tue, 20 Dec 2022 16:01:08 +0200
Date:   Tue, 20 Dec 2022 16:01:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] gpiolib: of: remove [devm_]gpiod_get_from_of_node()
 APIs
Message-ID: <Y6HAJCBs3MQxNP29@smile.fi.intel.com>
References: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
 <20221219192016.1396950-5-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219192016.1396950-5-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 11:20:16AM -0800, Dmitry Torokhov wrote:
> Now that everyone is using [devm_]fwnode_gpiod_get[_index]() APIs,
> remove OF-specific [devm_]gpiod_get_from_of_node().

I very much in favour of this change!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

But the same question reminds, how this is possible to exists with the removed
of_get_named_gpiod_flags()?

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/gpio/gpiolib-devres.c | 55 -----------------------------------
>  drivers/gpio/gpiolib-of.c     | 46 -----------------------------
>  include/linux/gpio/consumer.h | 48 ------------------------------
>  3 files changed, 149 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
> index 16a696249229..fe9ce6b19f15 100644
> --- a/drivers/gpio/gpiolib-devres.c
> +++ b/drivers/gpio/gpiolib-devres.c
> @@ -129,61 +129,6 @@ struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_gpiod_get_index);
>  
> -/**
> - * devm_gpiod_get_from_of_node() - obtain a GPIO from an OF node
> - * @dev:	device for lifecycle management
> - * @node:	handle of the OF node
> - * @propname:	name of the DT property representing the GPIO
> - * @index:	index of the GPIO to obtain for the consumer
> - * @dflags:	GPIO initialization flags
> - * @label:	label to attach to the requested GPIO
> - *
> - * Returns:
> - * On successful request the GPIO pin is configured in accordance with
> - * provided @dflags.
> - *
> - * In case of error an ERR_PTR() is returned.
> - */
> -struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
> -					      const struct device_node *node,
> -					      const char *propname, int index,
> -					      enum gpiod_flags dflags,
> -					      const char *label)
> -{
> -	struct gpio_desc **dr;
> -	struct gpio_desc *desc;
> -
> -	desc = gpiod_get_from_of_node(node, propname, index, dflags, label);
> -	if (IS_ERR(desc))
> -		return desc;
> -
> -	/*
> -	 * For non-exclusive GPIO descriptors, check if this descriptor is
> -	 * already under resource management by this device.
> -	 */
> -	if (dflags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
> -		struct devres *dres;
> -
> -		dres = devres_find(dev, devm_gpiod_release,
> -				   devm_gpiod_match, &desc);
> -		if (dres)
> -			return desc;
> -	}
> -
> -	dr = devres_alloc(devm_gpiod_release, sizeof(struct gpio_desc *),
> -			  GFP_KERNEL);
> -	if (!dr) {
> -		gpiod_put(desc);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	*dr = desc;
> -	devres_add(dev, dr);
> -
> -	return desc;
> -}
> -EXPORT_SYMBOL_GPL(devm_gpiod_get_from_of_node);
> -
>  /**
>   * devm_fwnode_gpiod_get_index - get a GPIO descriptor from a given node
>   * @dev:	GPIO consumer
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index fdf443310442..4a47e71782f3 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -418,52 +418,6 @@ static unsigned long of_convert_gpio_flags(enum of_gpio_flags flags)
>  	return lflags;
>  }
>  
> -/**
> - * gpiod_get_from_of_node() - obtain a GPIO from an OF node
> - * @node:	handle of the OF node
> - * @propname:	name of the DT property representing the GPIO
> - * @index:	index of the GPIO to obtain for the consumer
> - * @dflags:	GPIO initialization flags
> - * @label:	label to attach to the requested GPIO
> - *
> - * Returns:
> - * On successful request the GPIO pin is configured in accordance with
> - * provided @dflags.
> - *
> - * In case of error an ERR_PTR() is returned.
> - */
> -struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
> -					 const char *propname, int index,
> -					 enum gpiod_flags dflags,
> -					 const char *label)
> -{
> -	unsigned long lflags;
> -	struct gpio_desc *desc;
> -	enum of_gpio_flags of_flags;
> -	int ret;
> -
> -	desc = of_get_named_gpiod_flags(node, propname, index, &of_flags);
> -	if (!desc || IS_ERR(desc))
> -		return desc;
> -
> -	ret = gpiod_request(desc, label);
> -	if (ret == -EBUSY && (dflags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
> -		return desc;
> -	if (ret)
> -		return ERR_PTR(ret);
> -
> -	lflags = of_convert_gpio_flags(of_flags);
> -
> -	ret = gpiod_configure_flags(desc, propname, lflags, dflags);
> -	if (ret < 0) {
> -		gpiod_put(desc);
> -		return ERR_PTR(ret);
> -	}
> -
> -	return desc;
> -}
> -EXPORT_SYMBOL_GPL(gpiod_get_from_of_node);
> -
>  static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
>  					     const char *con_id,
>  					     unsigned int idx,
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index 45da8f137fe5..59cb20cfac3d 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -581,54 +581,6 @@ struct gpio_desc *devm_fwnode_gpiod_get(struct device *dev,
>  					   flags, label);
>  }
>  
> -#if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_OF_GPIO)
> -struct device_node;
> -
> -struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
> -					 const char *propname, int index,
> -					 enum gpiod_flags dflags,
> -					 const char *label);
> -
> -#else  /* CONFIG_GPIOLIB && CONFIG_OF_GPIO */
> -
> -struct device_node;
> -
> -static inline
> -struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
> -					 const char *propname, int index,
> -					 enum gpiod_flags dflags,
> -					 const char *label)
> -{
> -	return ERR_PTR(-ENOSYS);
> -}
> -
> -#endif /* CONFIG_GPIOLIB && CONFIG_OF_GPIO */
> -
> -#ifdef CONFIG_GPIOLIB
> -struct device_node;
> -
> -struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
> -					      const struct device_node *node,
> -					      const char *propname, int index,
> -					      enum gpiod_flags dflags,
> -					      const char *label);
> -
> -#else  /* CONFIG_GPIOLIB */
> -
> -struct device_node;
> -
> -static inline
> -struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
> -					      const struct device_node *node,
> -					      const char *propname, int index,
> -					      enum gpiod_flags dflags,
> -					      const char *label)
> -{
> -	return ERR_PTR(-ENOSYS);
> -}
> -
> -#endif /* CONFIG_GPIOLIB */
> -
>  struct acpi_gpio_params {
>  	unsigned int crs_entry_index;
>  	unsigned int line_index;
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 

-- 
With Best Regards,
Andy Shevchenko


