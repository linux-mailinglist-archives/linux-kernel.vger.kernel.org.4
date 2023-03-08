Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E95B6B0CFE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjCHPjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjCHPip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:38:45 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F885D266;
        Wed,  8 Mar 2023 07:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678289890; x=1709825890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g8+gub4SaEbhWrdJdK3PPA0svWX5bsVEHIgFdaZxEoY=;
  b=ahaJTF+a2z8kEB2ALoHbU+iN96RXy+qDxl9RMXUed5C0IIEzXMA/+X1v
   xF6OeVYbBv42SHHqyShbBnOG81B8J4qxcW1W+4ufI3hurUXvpejDiSUrM
   1HfTaWkklmdNty+F877VVNkIQsVoaUQw+64MxJnDayVBOKaDAkY1pOKi8
   pLGz2oqM5xRAoD1J3r7aPYR5ueZX1zLWGrm0Ao+y+TxrZEDxdg963elRY
   sSiId0JWbkCkNj62Rm/q3nRc9hfuRrgIbuNuBRo9aMBblCHCMc8XETjR3
   0ZUofWreuFVmxKe1tRrAOriANicLjUhkxjNmYNeBI6PHyFKCTkWlj+GEo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="422456680"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="422456680"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:37:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="626961638"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="626961638"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2023 07:37:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZvrV-00HUVg-2y;
        Wed, 08 Mar 2023 17:37:53 +0200
Date:   Wed, 8 Mar 2023 17:37:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: ar71: include linux/gpio/driver.h
Message-ID: <ZAir0b1aPYQdyNRm@smile.fi.intel.com>
References: <20230308145303.826942-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308145303.826942-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 03:52:53PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The change to remove the implicit gpio/driver.h include was done
> after fixing all the other users, but the ar7 file still needs
> the same change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you!

P.S. Bart, I believe the best strategy here is to you directly apply this to
GPIO tree. If anyone needs this, you can make an immutable tag or branch with
it being included.

Alternatively I can take it and issue a new immutable tag.

Tell me which way suits you better.

> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 21d9526d13b5 ("gpiolib: Make the legacy <linux/gpio.h> consumer-only")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/ar7/gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
> index ae0e01b9438f..4ed833b9cc2f 100644
> --- a/arch/mips/ar7/gpio.c
> +++ b/arch/mips/ar7/gpio.c
> @@ -7,7 +7,7 @@
>  
>  #include <linux/init.h>
>  #include <linux/export.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/driver.h>
>  
>  #include <asm/mach-ar7/ar7.h>
>  
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


