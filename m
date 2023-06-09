Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAEA729D20
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbjFIOlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjFIOlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:41:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80865136;
        Fri,  9 Jun 2023 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686321674; x=1717857674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EoyR4lFdIWQ19KidrDL5ycKJHXLkSv6McCPFpDTTr7c=;
  b=Gt5SSpvApMculddvk5rBX+d/71WAov08ZXQBuYDkCWL+MHPnNUHsKAZK
   Bujn3HdLAEjRmQMrIgkYpwEZ6OYh7kcQnlutrxbq+dRbpSfsi1+bAHJXG
   2EuOVJeoBt6PAqi8c/Fu6f20mfeCDP8UXGWOkY7mPRtF+k6dM0Admig/j
   RfWK08k2lL52EVFEQPNt9vp75dStUssAOZ98Yw/vMnt0h52PqotkxDRrZ
   Itv33isywNz2y3N2cMR23syndFsMnh1tExoEVqkAvxv8/+O2i21eJUqj+
   iFBAz/kHF80mzJsD7SU+onAk7LM1vp4cPvI50F0PYxKbPwMQMJ08V7cJN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="347257423"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="347257423"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 07:41:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="854762977"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="854762977"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2023 07:41:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q7dIb-002QCi-33;
        Fri, 09 Jun 2023 17:41:09 +0300
Date:   Fri, 9 Jun 2023 17:41:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] of: unittest: drop assertions for GPIO hog messages
Message-ID: <ZIM6BQnjxGVenI1S@smile.fi.intel.com>
References: <20230609143609.209373-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609143609.209373-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 04:36:09PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> These have now been demoted to debug and are normally hidden. Drop the
> assertions entirely.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/of/unittest.c | 28 ----------------------------
>  1 file changed, 28 deletions(-)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 0060334a98a7..5386efeaf710 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1844,26 +1844,10 @@ static void __init of_unittest_overlay_gpio(void)
>  	unittest(overlay_data_apply("overlay_gpio_02b", NULL),
>  		 "Adding overlay 'overlay_gpio_02b' failed\n");
>  
> -	/*
> -	 * messages are the result of the probes, after the
> -	 * driver is registered
> -	 */
> -
> -	EXPECT_BEGIN(KERN_DEBUG,
> -		     "gpio-<<int>> (line-B-input): hogged as input\n");
> -
> -	EXPECT_BEGIN(KERN_DEBUG,
> -		     "gpio-<<int>> (line-A-input): hogged as input\n");
> -
>  	ret = platform_driver_register(&unittest_gpio_driver);
>  	if (unittest(ret == 0, "could not register unittest gpio driver\n"))
>  		return;
>  
> -	EXPECT_END(KERN_DEBUG,
> -		   "gpio-<<int>> (line-A-input): hogged as input\n");
> -	EXPECT_END(KERN_DEBUG,
> -		   "gpio-<<int>> (line-B-input): hogged as input\n");
> -
>  	unittest(probe_pass_count + 2 == unittest_gpio_probe_pass_count,
>  		 "unittest_gpio_probe() failed or not called\n");
>  
> @@ -1888,17 +1872,11 @@ static void __init of_unittest_overlay_gpio(void)
>  	probe_pass_count = unittest_gpio_probe_pass_count;
>  	chip_request_count = unittest_gpio_chip_request_count;
>  
> -	EXPECT_BEGIN(KERN_DEBUG,
> -		     "gpio-<<int>> (line-D-input): hogged as input\n");
> -
>  	/* overlay_gpio_03 contains gpio node and child gpio hog node */
>  
>  	unittest(overlay_data_apply("overlay_gpio_03", NULL),
>  		 "Adding overlay 'overlay_gpio_03' failed\n");
>  
> -	EXPECT_END(KERN_DEBUG,
> -		   "gpio-<<int>> (line-D-input): hogged as input\n");
> -
>  	unittest(probe_pass_count + 1 == unittest_gpio_probe_pass_count,
>  		 "unittest_gpio_probe() failed or not called\n");
>  
> @@ -1935,17 +1913,11 @@ static void __init of_unittest_overlay_gpio(void)
>  	 *   - processing gpio for overlay_gpio_04b
>  	 */
>  
> -	EXPECT_BEGIN(KERN_DEBUG,
> -		     "gpio-<<int>> (line-C-input): hogged as input\n");
> -
>  	/* overlay_gpio_04b contains child gpio hog node */
>  
>  	unittest(overlay_data_apply("overlay_gpio_04b", NULL),
>  		 "Adding overlay 'overlay_gpio_04b' failed\n");
>  
> -	EXPECT_END(KERN_DEBUG,
> -		   "gpio-<<int>> (line-C-input): hogged as input\n");
> -
>  	unittest(chip_request_count + 1 == unittest_gpio_chip_request_count,
>  		 "unittest_gpio_chip_request() called %d times (expected 1 time)\n",
>  		 unittest_gpio_chip_request_count - chip_request_count);
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


