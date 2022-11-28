Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2706563A5D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiK1KOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiK1KOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:14:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693D013E35;
        Mon, 28 Nov 2022 02:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669630471; x=1701166471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x0vkDNxcTGDBQx1tdJF7VOl/Y7E12BTrTMtu7ZOaq8Y=;
  b=FiLEkTPsu5Gt8yKtJGSkVj2+Fb3GuJrmkwSpbyW2V4yr4lsTTrqhI8/f
   +RUfpb6h6m4zM52mRIa1WBduu1XJoQHWzhstFLiAo3M38SYmJE9M6k8kB
   pf+JTo3QgfIOsVKGVHkzGFKZPRLPLCjf2ou3dJb1x5A/rel+Qq8uRD7t0
   N9JESRUyPWF5HKBDIOo8wTRl1DncsrYWeob8TAEgJKx+8TFL/7OOcVQSo
   uBYPBoqnZr6kNSMTZRgatvtlUGRnl40lwuAhsaeoSf8nAhlFBSOm0BLrO
   iPJxui2HZ67Y3n/NO1PkkxUrTDkGTtVPJoK7kiK+5+3Zr25CRvhrLj0Ul
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="341710981"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="341710981"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 02:14:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="637168198"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="637168198"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 28 Nov 2022 02:14:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ozb9d-0014Vw-37;
        Mon, 28 Nov 2022 12:14:25 +0200
Date:   Mon, 28 Nov 2022 12:14:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] gpio: Do not include <linux/kernel.h> when not really
 needed.
Message-ID: <Y4SKAbUM52tanAvc@smile.fi.intel.com>
References: <3f75784c57dc0682b5e1758daddd93fee6bb4b27.1669585920.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f75784c57dc0682b5e1758daddd93fee6bb4b27.1669585920.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 10:52:10PM +0100, Christophe JAILLET wrote:
> <linux/kernel.h> is included only for using container_of().
> Include <linux/container_of.h> instead, it is much lighter.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thanks for doing this! We really don't want to see kernel.h to be included by
other headers in the include/linux, include/asm, etc.

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not sure if the prefix should be gpio or gpiolib.

I'm not sure either because this more for the consumers, I would leave gpio.

> Let see if build-bots spot something which is inherit via kernel.h
> ---
>  include/linux/of_gpio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
> index a5166eb93437..6db627257a7b 100644
> --- a/include/linux/of_gpio.h
> +++ b/include/linux/of_gpio.h
> @@ -34,7 +34,7 @@ enum of_gpio_flags {
>  
>  #ifdef CONFIG_OF_GPIO
>  
> -#include <linux/kernel.h>
> +#include <linux/container_of.h>
>  
>  /*
>   * OF GPIO chip for memory mapped banks
> -- 
> 2.34.1
> 
> 

-- 
With Best Regards,
Andy Shevchenko


