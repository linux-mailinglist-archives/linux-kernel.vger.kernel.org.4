Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9166A246
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAMSnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjAMSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:43:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7088E209;
        Fri, 13 Jan 2023 10:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673635398; x=1705171398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mEF7gUySF3RDUumsnh379Dwim9+B6ejwxYcXinqqP6w=;
  b=QiLg+ASY/9pmV8nlIQEAmscc4PVfhFK+KZ/2K6n24EDws0zvHoovwugf
   x3LVFhuTdoc4donxWx0DAZkIq5IU0GWayF5O0PTAKIPx4BAbCtYtgrH1E
   /XRpnwELEA+/t+wOLbxv8Jo3R1QSIQkJvU34lAYQRrsCRubjE718twEHx
   mzoZdPWXBkBdEB6Y29Lg6OfdFMMnE06j4+BLhdIc6RDdTyEP67I8J4yr1
   WJi2bGGj2W+RnHQ26wU6VSu1gPg4Wim+oeKCebJI2q8lUB0NWl/tpHSnW
   ++YFUAjhjEQnl7uwtbzScEie/HBaHzNel3Lpb0hg5Px6mHprv/GOISDNA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="324126327"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="324126327"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 10:43:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="903659403"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="903659403"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jan 2023 10:43:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pGP1F-008lKD-22;
        Fri, 13 Jan 2023 20:43:13 +0200
Date:   Fri, 13 Jan 2023 20:43:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gireesh.Hiremath@in.bosch.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, Jonathan.Cameron@huawei.com,
        lis8215@gmail.com, sjoerd.simons@collabora.co.uk,
        VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [PATCH] driver: input: matric-keypad: switch to gpiod API
Message-ID: <Y8GmQVgjmsUwsA/w@smile.fi.intel.com>
References: <20230113062538.1537-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113062538.1537-1-Gireesh.Hiremath@in.bosch.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 06:25:38AM +0000, Gireesh.Hiremath@in.bosch.com wrote:
> From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

Thank you for the patch, my comments below.

> switch to new gpio descriptor based API

Please, respect English grammar and punctuation.

Also, you have a typo in the Subject besides the fact that the template for
Input subsystem is different. So prefix has to be changed as well.

...

>  	bool level_on = !pdata->active_low;
>  
>  	if (on) {
> -		gpio_direction_output(pdata->col_gpios[col], level_on);
> +		gpiod_direction_output(pdata->col_gpios[col], level_on);
>  	} else {
> -		gpio_set_value_cansleep(pdata->col_gpios[col], !level_on);
> +		gpiod_set_value_cansleep(pdata->col_gpios[col], !level_on);
>  	}

I believe it's not so trivial. The GPIO descriptor already has encoded the
level information and above one as below are not clear now.

> -	return gpio_get_value_cansleep(pdata->row_gpios[row]) ?
> +	return gpiod_get_value_cansleep(pdata->row_gpios[row]) ?
>  			!pdata->active_low : pdata->active_low;

...

> -		err = gpio_request(pdata->col_gpios[i], "matrix_kbd_col");
> +		err = gpiod_direction_output(pdata->col_gpios[i], !pdata->active_low);

>  	while (--i >= 0)
> -		gpio_free(pdata->row_gpios[i]);
> +		gpiod_put(pdata->row_gpios[i]);

This looks like an incorrect change.

>  	while (--i >= 0)
> -		gpio_free(pdata->col_gpios[i]);
> +		gpiod_put(pdata->col_gpios[i]);

So does this.

Since you dropped gpio_request() you need to drop gpio_free() as well,
and not replace it.

...

>  	for (i = 0; i < nrow; i++) {
> -		ret = of_get_named_gpio(np, "row-gpios", i);
> -		if (ret < 0)

> -			return ERR_PTR(ret);

(1)

> -		gpios[i] = ret;
> +		desc = gpiod_get_index(dev, "row", i, GPIOD_IN);
> +		if (IS_ERR(desc))

> +			return ERR_PTR(-EINVAL);

Why?! How will it handle deferred probe, for example?

> +		gpios[i] = desc;
>  	}

...

>  	for (i = 0; i < ncol; i++) {
> -		ret = of_get_named_gpio(np, "col-gpios", i);
> -		if (ret < 0)
> -			return ERR_PTR(ret);
> -		gpios[nrow + i] = ret;
> +		desc = gpiod_get_index(dev, "col", i, GPIOD_IN);
> +		if (IS_ERR(desc))
> +			return ERR_PTR(-EINVAL);

Ditto.

> +		gpios[nrow + i] = desc;
>  	}

-- 
With Best Regards,
Andy Shevchenko


