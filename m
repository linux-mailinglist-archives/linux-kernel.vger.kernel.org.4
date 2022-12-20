Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46596521C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiLTNwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiLTNwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:52:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DED71AA29;
        Tue, 20 Dec 2022 05:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671544349; x=1703080349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VFYbPgahJpfwjZxfp4ytDA+bwT3WYLCNtB8Q3dBTiqk=;
  b=RYrAoGk+S5w6WnEPKTSzUzogNfCPUqfzOFRd92JStMDu/xOaxCuUUXcn
   x1KZ7DyLU1Q2SZBCVTxXCUPEXOBKfg8Vwk+dfiAmiFVVLCediNgFEpMZT
   1IizVVbVhHAXEkbj8C3MYN4grgHLvRKZ9TAi3pQrdZSboz18AwDA4MIXh
   rM/v/oDUQpBcB7rVNRRoHGhKaQzYrp6UVYXlPJOgbC/9xup9dyix41bmN
   6/91pdnslwRsTItSRXkbCZIIIYBobFZgyr/PbVbdjlBG7lGyZzV0PW7FS
   kcv1peDtP2IQ/+MIBvdVeyFLaiyT763dlWRGfAz9WG3CuhECGawio4N31
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="405861830"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="405861830"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 05:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="628743389"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="628743389"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 20 Dec 2022 05:52:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7d2f-00CtLk-0I;
        Tue, 20 Dec 2022 15:52:25 +0200
Date:   Tue, 20 Dec 2022 15:52:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] gpiolib: of: remove obsolete comment for
 of_gpio_get_count()
Message-ID: <Y6G+GMD6ysaEfdXs@smile.fi.intel.com>
References: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
 <20221219192016.1396950-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219192016.1396950-3-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 11:20:14AM -0800, Dmitry Torokhov wrote:
> The function is only being called form the main gpiolib module, so
> remove comment saying that it is also used by external callers.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/gpio/gpiolib-of.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 6724e375678d..6114c5b3d2ce 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -76,12 +76,6 @@ static int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
>  	return of_gpio_named_count(np, "gpios");
>  }
>  
> -/*
> - * This is used by external users of of_gpio_count() from <linux/of_gpio.h>
> - *
> - * FIXME: get rid of those external users by converting them to GPIO
> - * descriptors and let them all use gpiod_count()
> - */
>  int of_gpio_get_count(struct device *dev, const char *con_id)
>  {
>  	int ret;
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 

-- 
With Best Regards,
Andy Shevchenko


