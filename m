Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A4A713389
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 10:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjE0IyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 04:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjE0IyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 04:54:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683A8124;
        Sat, 27 May 2023 01:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685177653; x=1716713653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ktI2GnKQXBYUpJgyqu0yKmTKYiR+/wbaze1GTqEtbk8=;
  b=WyidlPJa1SYObJpyTZY10Q4Pe5gORZdzSiXbJzyEbkgxdPu/xPK6V30V
   gxh5lklQbkQROrM0V9MCsuF4E9eO+FVqIgib0E5EfdeYEDSl9jFcgdETJ
   /2mFler00w0FhF7gTQBKt3KwolLP/bxcMcbRrHA8exYGkjZEyQdiBhrKt
   EKhofFmhXLiJJBbuA7AmP/89yy1wZtkFFY68JyhZlTSz+fM5ogG+0qt1J
   uykebhtq9NzIX8wqIxxWkWBZsgJinb7OLO3LePYykg4fCN6doXg0/3RVi
   74yjxtpIF7wdSwJVbOIjaro5AVA7M37YhCZgtp4+z5+x0sAaMBS0pZiK5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="382629538"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="382629538"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 01:54:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="736262786"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="736262786"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2023 01:54:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q2pgf-000Irv-0Y;
        Sat, 27 May 2023 11:54:09 +0300
Date:   Sat, 27 May 2023 11:54:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 1/4] leds: simatic-ipc-leds-gpio: add terminating
 entries to gpio tables
Message-ID: <ZHHFMPEYNz9jBBRd@smile.fi.intel.com>
References: <20230524124628.32295-1-henning.schild@siemens.com>
 <20230524124628.32295-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524124628.32295-2-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 02:46:25PM +0200, Henning Schild wrote:
> The entries do not seem to be stricly needed when the number of entries
> is given via the number of LEDs. But adding them is a safeguard should
> anyone ever iterate over the tables to their end, it also gets us in
> line with other drivers that register "leds-gpio" tables.

Reported-by?
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
> index e8d329b5a68c..1a1cfdad6218 100644
> --- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> +++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
> @@ -28,6 +28,7 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
> +		{} /* Terminating entry */
>  	},
>  };
>  
> @@ -42,6 +43,7 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
>  		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
>  		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
> +		{} /* Terminating entry */
>  	}
>  };
>  
> -- 
> 2.39.3
> 

-- 
With Best Regards,
Andy Shevchenko


