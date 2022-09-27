Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5295EC948
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiI0QUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiI0QUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:20:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09CB33F;
        Tue, 27 Sep 2022 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664295606; x=1695831606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fPmwcwWibusnzVeAPQ/NG5NTj0eFT7ARGzWz5OODo54=;
  b=d5fcbNWnlWmJIStzE3YNnkILwfnd3uRsNv4bKIoa4EsMM63o+aOm8RuQ
   gtk0Fv3WqMtyrhnVs5vpQ2fNe8Vi+ejDa4rtmnrgjf0d+cu0zU2kR/sHE
   qFBVnL+21IZx6TMjaVORV3Px91D+Z5cUVDB8/tOGCw2FfiD8IvqiDRYe7
   yajRuCMLXi4MSVGqJSm1GnU7q7Un5wkbXCObsZiSjU3LyZ1gZuOJlzYcy
   X7aGJUJJoNGaZPRJXkxNc4vmADujn2C4AkEsIYSujZJQYlQ6Vc+WDF3M3
   AbBY0T8Oo697UFr2KMYywuTWOYw48cr3uVAM575GyXEz0+2+hwrQ8ZR30
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="302270803"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="302270803"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 09:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="616885930"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="616885930"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 27 Sep 2022 09:20:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odDJQ-008WhJ-2p;
        Tue, 27 Sep 2022 19:20:00 +0300
Date:   Tue, 27 Sep 2022 19:20:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: twl4030-madc: add missing of.h include
Message-ID: <YzMisM73yj/APB86@smile.fi.intel.com>
References: <20220927154611.3330871-1-dmitry.torokhov@gmail.com>
 <20220927154611.3330871-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927154611.3330871-3-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 08:46:11AM -0700, Dmitry Torokhov wrote:
> The driver is using of_device_id/of_match_ptr() and therefore needs
> to include of.h header. We used to get this definition indirectly via
> inclusion of matrix_keypad.h from twl.h, but we are cleaning up
> matrix_keypad.h from unnecessary includes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v2: adjusted patch description
> 
>  drivers/iio/adc/twl4030-madc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> index f8f8aea15612..c279c4f2c9b7 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -30,6 +30,7 @@
>  #include <linux/types.h>
>  #include <linux/gfp.h>
>  #include <linux/err.h>
> +#include <linux/of.h>
>  #include <linux/regulator/consumer.h>
>  
>  #include <linux/iio/iio.h>
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 

-- 
With Best Regards,
Andy Shevchenko


