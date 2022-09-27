Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C735EC29A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiI0MZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiI0MY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:24:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA574D4E9;
        Tue, 27 Sep 2022 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664281495; x=1695817495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MLweA3n1o34G/rMU6/yH26LTPtCMNLw86EAP5UfzGq4=;
  b=Tj2lDBCScqcrwIktDhlejDv1fKoGP/o5JXRdBxa6KPf+ibIBQZKHjF9d
   r3xpb4jc3cCfrgH0T3Co3Qu64QIWUYQfDq+N/eg6yf5UAz8EWK0bXyvET
   RaKDSfuKKtZXnOEgsx+3zMiyDIYJKmf4c9SWjrU2J3rVseZTIuPceIMms
   eswR7el+t5LSHUL7LXgy8h8cupuGrlhuO25fVlK9sKc7cL3/shqnulq1u
   GrpmfvLyn4Fa2/EeOt7nYJLQfA1BX952dj4VkgRLrE8kQK3kw3CHNzPnG
   CWx4IiL7GhuPBTQdmuoQ9Is5xuplz//EAY+6IYM344ssJ7SlZfYR2025Y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="387590388"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="387590388"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="725493221"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="725493221"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 27 Sep 2022 05:24:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1od9dp-008RQR-2B;
        Tue, 27 Sep 2022 15:24:49 +0300
Date:   Tue, 27 Sep 2022 15:24:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Input: twl4030-pwrbutton - add missing of.h include
Message-ID: <YzLrkSwngUwlyTGZ@smile.fi.intel.com>
References: <20220927052217.2784593-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927052217.2784593-1-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 10:22:13PM -0700, Dmitry Torokhov wrote:
> The driver is using of_match_ptr() and therefore needs to include
> of.h header.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/twl4030-pwrbutton.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
> index b307cca17022..e3ee0638ffba 100644
> --- a/drivers/input/misc/twl4030-pwrbutton.c
> +++ b/drivers/input/misc/twl4030-pwrbutton.c
> @@ -26,6 +26,7 @@
>  #include <linux/errno.h>
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/mfd/twl.h>
>  
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 

-- 
With Best Regards,
Andy Shevchenko


