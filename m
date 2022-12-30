Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119436597E2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 12:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiL3LxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 06:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiL3LxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 06:53:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F362F9;
        Fri, 30 Dec 2022 03:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672401185; x=1703937185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xFRGjKd+RqAloX3G8veQkP7IPncRlLL6epv3hx3s6KE=;
  b=FspDke4xPMWBJUOsslBF8j7eMyyDg8MMU8dIR09VbvsdD33era63I4PD
   7LhHDufNQUiqcCRBARGHWEUO550q4DAYLLyI6t1u1YXE3Ya8WTLuNwbqS
   jI6SODxti5KH6vfL8UjPj1ZvxrPMT9Z9C9zdDnEM8/yLNdgDl50uuRG89
   oTyy6cYNDX2cx/0Z6Ry2f6BoDCxKEkZ0MjHPrRnu7SgBiQi1DehSN/7Eu
   DS5nYnQKlJqwVjUe7GhfCMmgUMN092wQgOkvLrE58laY4dt52Y2eab7Ui
   6GF8v082ggH7hD5lFuNuFdOXAqIt4fLcLSheV52mRKj7AU0txpKYjQfP0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="319915435"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="319915435"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 03:53:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="742562817"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="742562817"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Dec 2022 03:53:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pBDwc-001e2A-0a;
        Fri, 30 Dec 2022 13:53:02 +0200
Date:   Fri, 30 Dec 2022 13:53:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: pca9570: rename platform_data to chip_data
Message-ID: <Y67RHbdFJBw/9KAU@smile.fi.intel.com>
References: <20221230100044.23000-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230100044.23000-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 11:00:44AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> By convention platform_data refers to structures passed to drivers by
> code that registers devices. When talking about model-specific data
> structures associated with OF compatibles, we usually call them chip_data.
> 
> In order to avoid confusion rename all mentions of platform_data to
> chip_data.

Fine by me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: fbb19fe17eae ("gpio: pca9570: add slg7xl45106 support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-pca9570.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pca9570.c b/drivers/gpio/gpio-pca9570.c
> index 6c07a8811a7a..6a5a8e593ed5 100644
> --- a/drivers/gpio/gpio-pca9570.c
> +++ b/drivers/gpio/gpio-pca9570.c
> @@ -18,11 +18,11 @@
>  #define SLG7XL45106_GPO_REG	0xDB
>  
>  /**
> - * struct pca9570_platform_data - GPIO platformdata
> + * struct pca9570_chip_data - GPIO platformdata
>   * @ngpio: no of gpios
>   * @command: Command to be sent
>   */
> -struct pca9570_platform_data {
> +struct pca9570_chip_data {
>  	u16 ngpio;
>  	u32 command;
>  };
> @@ -36,7 +36,7 @@ struct pca9570_platform_data {
>   */
>  struct pca9570 {
>  	struct gpio_chip chip;
> -	const struct pca9570_platform_data *p_data;
> +	const struct pca9570_chip_data *chip_data;
>  	struct mutex lock;
>  	u8 out;
>  };
> @@ -46,8 +46,8 @@ static int pca9570_read(struct pca9570 *gpio, u8 *value)
>  	struct i2c_client *client = to_i2c_client(gpio->chip.parent);
>  	int ret;
>  
> -	if (gpio->p_data->command != 0)
> -		ret = i2c_smbus_read_byte_data(client, gpio->p_data->command);
> +	if (gpio->chip_data->command != 0)
> +		ret = i2c_smbus_read_byte_data(client, gpio->chip_data->command);
>  	else
>  		ret = i2c_smbus_read_byte(client);
>  
> @@ -62,8 +62,8 @@ static int pca9570_write(struct pca9570 *gpio, u8 value)
>  {
>  	struct i2c_client *client = to_i2c_client(gpio->chip.parent);
>  
> -	if (gpio->p_data->command != 0)
> -		return i2c_smbus_write_byte_data(client, gpio->p_data->command, value);
> +	if (gpio->chip_data->command != 0)
> +		return i2c_smbus_write_byte_data(client, gpio->chip_data->command, value);
>  
>  	return i2c_smbus_write_byte(client, value);
>  }
> @@ -127,8 +127,8 @@ static int pca9570_probe(struct i2c_client *client)
>  	gpio->chip.get = pca9570_get;
>  	gpio->chip.set = pca9570_set;
>  	gpio->chip.base = -1;
> -	gpio->p_data = device_get_match_data(&client->dev);
> -	gpio->chip.ngpio = gpio->p_data->ngpio;
> +	gpio->chip_data = device_get_match_data(&client->dev);
> +	gpio->chip.ngpio = gpio->chip_data->ngpio;
>  	gpio->chip.can_sleep = true;
>  
>  	mutex_init(&gpio->lock);
> @@ -141,15 +141,15 @@ static int pca9570_probe(struct i2c_client *client)
>  	return devm_gpiochip_add_data(&client->dev, &gpio->chip, gpio);
>  }
>  
> -static const struct pca9570_platform_data pca9570_gpio = {
> +static const struct pca9570_chip_data pca9570_gpio = {
>  	.ngpio = 4,
>  };
>  
> -static const struct pca9570_platform_data pca9571_gpio = {
> +static const struct pca9570_chip_data pca9571_gpio = {
>  	.ngpio = 8,
>  };
>  
> -static const struct pca9570_platform_data slg7xl45106_gpio = {
> +static const struct pca9570_chip_data slg7xl45106_gpio = {
>  	.ngpio = 8,
>  	.command = SLG7XL45106_GPO_REG,
>  };
> -- 
> 2.37.2
> 

-- 
With Best Regards,
Andy Shevchenko


