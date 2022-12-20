Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D996521C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiLTNwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiLTNvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:51:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67331AF12;
        Tue, 20 Dec 2022 05:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671544308; x=1703080308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FnDumVYNZvNTa9DjVaNtZD4+2+3DL2akGci6xaMTnaQ=;
  b=TUEMq4XiIVC0pNnI8li6B53VIMqGNoqUcj830+Ubf0CAJAXWdke0vVq2
   2ieFtTOcD/FCpF5i0om8KxgymQAtkY7JIJABMXnr3XyAFZ/Zx+YL276oT
   k+BfvMsz7t5oEAWCtMVqM00pC0JLKq2O/8NLoMOVLullk95tVlZPfKEwu
   byZ0/RL4AdWn10awkwFvltnshdsiOY9fZu6PQJfgkGgdW2SIi4vJ5f1nL
   VXqPvE7VTrtKGnrlD9dPRJnSv0MVqGobJQWj/D+OsX1z9vu6b76gABw/x
   iQGN3qhgKvrbyEijfLsKh1dUumVOQvc7VHexYYkuI3+xuxduB2yF1G2Y4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="299289066"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="299289066"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 05:51:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="739763639"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="739763639"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2022 05:51:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7d20-00CtLF-0M;
        Tue, 20 Dec 2022 15:51:44 +0200
Date:   Tue, 20 Dec 2022 15:51:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] gpiolib: of: remove of_gpio_count()
Message-ID: <Y6G97zJwHaW+Kmo0@smile.fi.intel.com>
References: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 11:20:12AM -0800, Dmitry Torokhov wrote:
> There are no more users of of_gpio_count() in the mainline kernel,
> remove it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> After 6.2-rc1 there should be no more users of the APIs mentioned in
> this series.

I believe you probably want to have this patch applied immediately to the GPIO
subsystem after v6.2-rc1 to avoid new users.

>  include/linux/of_gpio.h | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
> index 6db627257a7b..39f16a960565 100644
> --- a/include/linux/of_gpio.h
> +++ b/include/linux/of_gpio.h
> @@ -105,17 +105,6 @@ static inline int of_gpio_named_count(const struct device_node *np,
>  	return of_count_phandle_with_args(np, propname, "#gpio-cells");
>  }
>  
> -/**
> - * of_gpio_count() - Count GPIOs for a device
> - * @np:		device node to count GPIOs for
> - *
> - * Same as of_gpio_named_count, but hard coded to use the 'gpios' property
> - */
> -static inline int of_gpio_count(const struct device_node *np)
> -{
> -	return of_gpio_named_count(np, "gpios");
> -}
> -
>  static inline int of_get_gpio_flags(const struct device_node *np, int index,
>  		      enum of_gpio_flags *flags)
>  {
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 

-- 
With Best Regards,
Andy Shevchenko


