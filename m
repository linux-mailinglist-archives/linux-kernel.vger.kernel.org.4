Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994BC724721
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjFFPAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbjFFPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:00:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F397B10D4;
        Tue,  6 Jun 2023 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686063587; x=1717599587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M4igqU7hiOeVhMOHNl6mFZsrtA/dJjpfywViepYmzqc=;
  b=lB8B2hTskR1DnarZx5y1aoGO8vBcdtRHwPKDaFByZ75u+Gk3ULk//UDG
   bKiaBp9aw5XsDyMsze+VU4H5GvcC1rLwi0gos9NAD6ceCHDteYuOVu68z
   v/dgdy3XC13GS873RWeprGzd8JBidrBZiUat6UrfKyHlT5nyBjbzDqWca
   H2jwkUfhcKYvF75+ITD3boutXHbyEW56D1meAdZrkNDi27wEL+Poka9xC
   RnZbwnGaLY4LkXvi6s5MwiaYG9NVtETdK12Uc1RACxqQayk+5pe3CxsqM
   Wf5vljkQHhC0MjR/xPcZ9GKHZA8lvblhMJm3VHfoVVX322vjnrofwsK6g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="336323500"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="336323500"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:57:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="712237651"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="712237651"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jun 2023 07:57:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6Y89-001gOW-1Y;
        Tue, 06 Jun 2023 17:57:53 +0300
Date:   Tue, 6 Jun 2023 17:57:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: demote the hogging log messages to debug
Message-ID: <ZH9JcR2gS6n67eHX@smile.fi.intel.com>
References: <20230605125248.279921-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605125248.279921-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 02:52:48PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Drivers should be silent when they work correctly. There's no reason to
> emit info messages when GPIO lines are hogged. Demote the message to
> debug.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Suggested-by: Kent Gibson <warthog618@gmail.com>
> ---
>  drivers/gpio/gpiolib.c |  2 +-
>  drivers/of/unittest.c  | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index a7220e04a93e..e4515bda8915 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4243,7 +4243,7 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
>  	/* Mark GPIO as hogged so it can be identified and removed later */
>  	set_bit(FLAG_IS_HOGGED, &desc->flags);
>  
> -	gpiod_info(desc, "hogged as %s%s\n",
> +	gpiod_dbg(desc, "hogged as %s%s\n",
>  		(dflags & GPIOD_FLAGS_BIT_DIR_OUT) ? "output" : "input",
>  		(dflags & GPIOD_FLAGS_BIT_DIR_OUT) ?
>  		  (dflags & GPIOD_FLAGS_BIT_DIR_VAL) ? "/high" : "/low" : "");
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 2191c0136531..0060334a98a7 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1849,19 +1849,19 @@ static void __init of_unittest_overlay_gpio(void)
>  	 * driver is registered
>  	 */
>  
> -	EXPECT_BEGIN(KERN_INFO,
> +	EXPECT_BEGIN(KERN_DEBUG,
>  		     "gpio-<<int>> (line-B-input): hogged as input\n");
>  
> -	EXPECT_BEGIN(KERN_INFO,
> +	EXPECT_BEGIN(KERN_DEBUG,
>  		     "gpio-<<int>> (line-A-input): hogged as input\n");
>  
>  	ret = platform_driver_register(&unittest_gpio_driver);
>  	if (unittest(ret == 0, "could not register unittest gpio driver\n"))
>  		return;
>  
> -	EXPECT_END(KERN_INFO,
> +	EXPECT_END(KERN_DEBUG,
>  		   "gpio-<<int>> (line-A-input): hogged as input\n");
> -	EXPECT_END(KERN_INFO,
> +	EXPECT_END(KERN_DEBUG,
>  		   "gpio-<<int>> (line-B-input): hogged as input\n");
>  
>  	unittest(probe_pass_count + 2 == unittest_gpio_probe_pass_count,
> @@ -1888,7 +1888,7 @@ static void __init of_unittest_overlay_gpio(void)
>  	probe_pass_count = unittest_gpio_probe_pass_count;
>  	chip_request_count = unittest_gpio_chip_request_count;
>  
> -	EXPECT_BEGIN(KERN_INFO,
> +	EXPECT_BEGIN(KERN_DEBUG,
>  		     "gpio-<<int>> (line-D-input): hogged as input\n");
>  
>  	/* overlay_gpio_03 contains gpio node and child gpio hog node */
> @@ -1896,7 +1896,7 @@ static void __init of_unittest_overlay_gpio(void)
>  	unittest(overlay_data_apply("overlay_gpio_03", NULL),
>  		 "Adding overlay 'overlay_gpio_03' failed\n");
>  
> -	EXPECT_END(KERN_INFO,
> +	EXPECT_END(KERN_DEBUG,
>  		   "gpio-<<int>> (line-D-input): hogged as input\n");
>  
>  	unittest(probe_pass_count + 1 == unittest_gpio_probe_pass_count,
> @@ -1935,7 +1935,7 @@ static void __init of_unittest_overlay_gpio(void)
>  	 *   - processing gpio for overlay_gpio_04b
>  	 */
>  
> -	EXPECT_BEGIN(KERN_INFO,
> +	EXPECT_BEGIN(KERN_DEBUG,
>  		     "gpio-<<int>> (line-C-input): hogged as input\n");
>  
>  	/* overlay_gpio_04b contains child gpio hog node */
> @@ -1943,7 +1943,7 @@ static void __init of_unittest_overlay_gpio(void)
>  	unittest(overlay_data_apply("overlay_gpio_04b", NULL),
>  		 "Adding overlay 'overlay_gpio_04b' failed\n");
>  
> -	EXPECT_END(KERN_INFO,
> +	EXPECT_END(KERN_DEBUG,
>  		   "gpio-<<int>> (line-C-input): hogged as input\n");
>  
>  	unittest(chip_request_count + 1 == unittest_gpio_chip_request_count,
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


