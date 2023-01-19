Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA4C674B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjATE5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjATE5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:57:00 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB3DBCE03;
        Thu, 19 Jan 2023 20:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674190019; x=1705726019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SyM8caywEFAqKwm6rH70roccYrUPdIquF3xvmc4tvFE=;
  b=TUrPkpXkwJZM3Ga3wC7J1WPjSEdBybqGqLnqMZwT8Kh52tiIHO4+7iS/
   N8bPwqBMQk185UZzMD9h2+C0XrfLH1FjnjlHohPgrIfaKftYujZfL3zaK
   I53TW0UMim0NG0jh8XPJ1KgP6yWQPmhePUalyJaitnBaVnyvL+59PUyiR
   INNRhhYBdAdWbXSKHyjtAIGxnTLtNWA3h/opbz2IY38DaT5Vzz8OjzTkb
   sVxHYbxZn2JZvstNS7+taf6uXUKXHXz4FThiJkWhV3I1JS5jeepYuPySp
   JWngKCFpE4732JOAaQLOR1dnUEqjhymXjIkkoMVPdJAiNnYG7Zfc4Q+TB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="308869078"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="308869078"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 06:19:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="660201404"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="660201404"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2023 06:19:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIVlN-00BhcV-0Q;
        Thu, 19 Jan 2023 16:19:33 +0200
Date:   Thu, 19 Jan 2023 16:19:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gireesh.Hiremath@in.bosch.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, Jonathan.Cameron@huawei.com,
        lis8215@gmail.com, sjoerd.simons@collabora.co.uk,
        VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [PATCH] driver: input: matric-keypad: switch to gpiod API
Message-ID: <Y8lRdC/B2VlDU5zB@smile.fi.intel.com>
References: <20230113062538.1537-1-Gireesh.Hiremath@in.bosch.com>
 <20230119114736.30257-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119114736.30257-1-Gireesh.Hiremath@in.bosch.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:47:36AM +0000, Gireesh.Hiremath@in.bosch.com wrote:

> I will correct it as
> >Thank you for the patch, my comments below.
> >
> >> switch to new gpio descriptor based API
> Switch to GPIO descriptor based API.

...to the GPIO...

> >Please, respect English grammar and punctuation.
> >
> >Also, you have a typo in the Subject besides the fact that the template for
> >Input subsystem is different. So prefix has to be changed as well.
> and template as
> Input: matrix_keypad - switch to gpiod API

OK!

...

> >>  	bool level_on = !pdata->active_low;
> >>  
> >>  	if (on) {
> >> -		gpio_direction_output(pdata->col_gpios[col], level_on);
> >> +		gpiod_direction_output(pdata->col_gpios[col], level_on);
> >>  	} else {
> >> -		gpio_set_value_cansleep(pdata->col_gpios[col], !level_on);
> >> +		gpiod_set_value_cansleep(pdata->col_gpios[col], !level_on);
> >>  	}
> >
> >I believe it's not so trivial. The GPIO descriptor already has encoded the
> >level information and above one as below are not clear now.
> >
> >> -	return gpio_get_value_cansleep(pdata->row_gpios[row]) ?
> >> +	return gpiod_get_value_cansleep(pdata->row_gpios[row]) ?
> >>  			!pdata->active_low : pdata->active_low;
> >
> if GPIO from I2C or SPI IO expander, which may sleep, 
> so it is safer to use the gpiod_set_value_cansleep() and
> gpiod_get_value_cansleep().

No, my point is about active level (LOW or HIGH). It's encoded into
the descriptor in opposite to the plain GPIO number.

This change needs very careful understanding of the active level.

...

> >> -		err = gpio_request(pdata->col_gpios[i], "matrix_kbd_col");
> >> +		err = gpiod_direction_output(pdata->col_gpios[i], !pdata->active_low);
> >
> >>  	while (--i >= 0)
> >> -		gpio_free(pdata->row_gpios[i]);
> >> +		gpiod_put(pdata->row_gpios[i]);
> >
> >This looks like an incorrect change.
> >
> >>  	while (--i >= 0)
> >> -		gpio_free(pdata->col_gpios[i]);
> >> +		gpiod_put(pdata->col_gpios[i]);
> >
> >So does this.
> >
> >Since you dropped gpio_request() you need to drop gpio_free() as well,
> >and not replace it.
> gpio_request() equalent api gpiod_request() is alredy called inside gpiod_get_index(...).
> gpiod_put() is required to free GPIO.

Yes, but you removed request call, so should remove the free.
The gpiod_put() should be at the same function as gpiod_get().

...

> >>  	for (i = 0; i < nrow; i++) {
> >> -		ret = of_get_named_gpio(np, "row-gpios", i);
> >> -		if (ret < 0)
> >
> >> -			return ERR_PTR(ret);
> >
> >(1)
> >
> >> -		gpios[i] = ret;
> >> +		desc = gpiod_get_index(dev, "row", i, GPIOD_IN);
> >> +		if (IS_ERR(desc))
> >
> >> +			return ERR_PTR(-EINVAL);
> >
> >Why?! How will it handle deferred probe, for example?
> shall I update it as 
> 				return ERR_CAST(desc);

For example...

> >> +		gpios[i] = desc;
> >>  	}

...

> >>  	for (i = 0; i < ncol; i++) {
> >> -		ret = of_get_named_gpio(np, "col-gpios", i);
> >> -		if (ret < 0)
> >> -			return ERR_PTR(ret);
> >> -		gpios[nrow + i] = ret;
> >> +		desc = gpiod_get_index(dev, "col", i, GPIOD_IN);
> >> +		if (IS_ERR(desc))
> >> +			return ERR_PTR(-EINVAL);

Ditto.

> >> +		gpios[nrow + i] = desc;
> >>  	}

-- 
With Best Regards,
Andy Shevchenko


